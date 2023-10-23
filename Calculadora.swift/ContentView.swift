//
//  ContentView.swift
//  Calculadora.swift
//
//  Created by user on 19/10/23.
//

import SwiftUI

enum BotaoCalcular: String {
    case um = "1"
    case dois = "2"
    case tres = "3"
    case quatro = "4"
    case cinco = "5"
    case seis = "6"
    case sete = "7"
    case oito = "8"
    case nove = "9"
    case zero = "0"
    case adicionar = "+"
    case subtrair = "-"
    case dividir = "÷"
    case multiplicacao = "×"
    case igual = "="
    case limpar = "AC"
    case porcentual = "%"
    case negativo = "-/+"
    case decimal = "."
    
    var corBotao: Color {
        switch self {
        case .adicionar, .subtrair, .multiplicacao, .dividir, .igual:
            return .orange
        case .limpar, .negativo, .porcentual:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operacao {
    case adicionar, subtrair, multiplicacao, dividir,nenhum
}



struct ContentView: View {
    
    @State var valor = "0"
    @State var operacaoAtual: Operacao = .nenhum
    @State var numeroEmExecucao = 0
    
    

    let buttons: [[BotaoCalcular]] = [
        [.limpar, .negativo, .porcentual, .dividir],
        [.sete, .oito, .nove, .multiplicacao],
        [.quatro, .cinco, .seis, .subtrair],
        [.um, .dois, .tres, .adicionar],
        [.zero,.decimal, .igual]
    ]

    
    var body: some View {
        
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer ()
                // Text Tela
                HStack {
                    Spacer()
                    Text(valor)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }
                .padding()
                
                // botoes
                ForEach(buttons,id:\.self) { row in
                    HStack (spacing: 12) {
                        ForEach(row, id:\.self) { item in
                            Button(action:  {
                                self.tocouBotao(botao: item)
                                
                            },label: {
                                Text(item.rawValue)
                                    .font(.system(size:32))
                                
                                    .frame(
                                        width: self.buttonWidth (
                                            item: item),
                                        
                                            
                                        height: self.buttonHeight ()
                                    )
                                    .background(item.corBotao)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item
                                    )/2)

                            })
                            
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
            
            
        }
        
    }
    
   func tocouBotao (botao: BotaoCalcular) {
        switch botao {
        case .adicionar, .subtrair, .multiplicacao, .dividir, .igual:
            
            if botao == .adicionar {
                self.operacaoAtual = .adicionar
                self.numeroEmExecucao = Int(self.valor) ?? 0
            }
            else if botao == .subtrair {
                self.operacaoAtual = .subtrair
                self.numeroEmExecucao = Int(self.valor) ?? 0
            }
            else if botao == .multiplicacao {
                self.operacaoAtual = .multiplicacao
                self.numeroEmExecucao = Int(self.valor) ?? 0
            }
            else if botao == .dividir {
                self.operacaoAtual = .dividir
                self.numeroEmExecucao = Int(self.valor) ?? 0
            }
            
            else if botao == .igual {
                let numeroEmExecucao = self.numeroEmExecucao
                let valorAtual = Int(self.valor) ?? 0
                switch self.operacaoAtual
                {
                case .adicionar:    self.valor = "\(numeroEmExecucao + valorAtual)"
                case .subtrair:     self.valor = "\(numeroEmExecucao - valorAtual)"
                case .multiplicacao:self.valor = "\(numeroEmExecucao * valorAtual)"
                case .dividir:      self.valor = "\(numeroEmExecucao / valorAtual)"
                case .nenhum:
                    break
                }
            }
            
            if botao != .igual {
                self.valor = "0"
            }

            case .limpar:
            self.valor = "0"
        case .decimal, .negativo, .porcentual:
            break
            default:
            let numero = botao.rawValue
            if self.valor == "0" {
                valor = numero
            }
            else {
                self.valor = "\(self.valor)\(numero)"
            }
        }
        
    }
    
    
    func buttonWidth(item:BotaoCalcular) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4 * 2 )
            
        }
        
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
