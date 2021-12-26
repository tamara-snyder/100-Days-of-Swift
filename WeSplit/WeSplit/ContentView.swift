//
//  ContentView.swift
//  WeSplit
//
//  Created by Tamara Snyder on 12/24/21.
//

import SwiftUI

struct ContentView: View {
	@State private var checkAmount = 0.0
	@State private var numberOfPeople = 0
	@State private var tipPercentage = 20
	@FocusState private var amountIsFocused: Bool
	
	let tipPercentages = [15, 18, 20, 25, 0]
	
	var billTotal: Double {
		let tip = checkAmount / 100 * Double(tipPercentage)
		return checkAmount + tip
	}
	
	var totalPerPerson: Double {
		let peopleCount = Double(numberOfPeople + 2)
		return billTotal / peopleCount
	}
	
	func defaultCurrency() -> FloatingPointFormatStyle<Double>.Currency {
		return .currency(code: Locale.current.currencyCode ?? "USD")
	}
	
    var body: some View {
		NavigationView {
			Form {
				Section {
					TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
						.keyboardType(.decimalPad)
						.focused($amountIsFocused)
					
					Picker("Number of people", selection: $numberOfPeople) {
						ForEach(2..<100) {
							Text("\($0) people")
						}
					}
				}
				
				Section {
					Picker("Tip percentage", selection: $tipPercentage) {
						ForEach(tipPercentages, id: \.self) {
							Text($0, format: .percent)
						}
					}
				} header: {
					Text("How much tip do you want to leave?")
				}
				.pickerStyle(.segmented)
				
				Section {
					Text(billTotal, format: defaultCurrency())
				} header: {
					Text("Bill total including tip")
				}

				Section {
					Text(totalPerPerson, format: defaultCurrency())
				} header: {
					Text("Amount per person")
				}
				
			}
			.navigationTitle("WeSplit")
			.toolbar {
				ToolbarItemGroup(placement: .keyboard) {
					Spacer()
					
					Button("Done") {
						// closure to run when button is pressed:
						amountIsFocused = false
					}
				}
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
