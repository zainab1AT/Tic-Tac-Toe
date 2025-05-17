import 'dart:io';

class TicTacToe {
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ' '));
  String currentPlayer = 'X';

  void startGame() {
    bool gameOver = false;

    while (!gameOver) {
      printBoard();
      int move = getPlayerMove();
      if (makeMove(move)) {
        if (checkWin()) {
          printBoard();
          print('Player $currentPlayer wins!');
          gameOver = true;
        } else if (isDraw()) {
          printBoard();
          print('Game ended in a draw.');
          gameOver = true;
        } else {
          switchPlayer();
        }
      }
    }

    stdout.write('Do you want to play again? (y/n): ');
    String? again = stdin.readLineSync();
    if (again?.toLowerCase() == 'y') {
      resetGame();
      startGame();
    } else {
      print('Thanks for playing!');
    }
  }

  void printBoard() {
    print('');
    for (int i = 0; i < 3; i++) {
      print(' ${board[i][0]} | ${board[i][1]} | ${board[i][2]} ');
      if (i < 2) print('---+---+---');
    }
    print('');
  }

  int getPlayerMove() {
    while (true) {
      stdout.write('Player $currentPlayer, enter your move (1-9): ');
      String? input = stdin.readLineSync();
      if (input == null || int.tryParse(input) == null) {
        print('Invalid input. Please enter a number between 1 and 9.');
        continue;
      }

      int move = int.parse(input);
      if (move < 1 || move > 9) {
        print('Move must be between 1 and 9.');
        continue;
      }

      int row = (move - 1) ~/ 3;
      int col = (move - 1) % 3;

      if (board[row][col] != ' ') {
        print('Cell already taken. Choose another.');
        continue;
      }

      return move;
    }
  }

  bool makeMove(int move) {
    int row = (move - 1) ~/ 3;
    int col = (move - 1) % 3;
    if (board[row][col] == ' ') {
      board[row][col] = currentPlayer;
      return true;
    }
    return false;
  }

  bool checkWin() {
    // Rows and Columns
    for (int i = 0; i < 3; i++) {
      if ((board[i][0] == currentPlayer &&
           board[i][1] == currentPlayer &&
           board[i][2] == currentPlayer) ||
          (board[0][i] == currentPlayer &&
           board[1][i] == currentPlayer &&
           board[2][i] == currentPlayer)) {
        return true;
      }
    }

    // Diagonals
    if ((board[0][0] == currentPlayer &&
         board[1][1] == currentPlayer &&
         board[2][2] == currentPlayer) ||
        (board[0][2] == currentPlayer &&
         board[1][1] == currentPlayer &&
         board[2][0] == currentPlayer)) {
      return true;
    }

    return false;
  }

  bool isDraw() {
    for (var row in board) {
      if (row.contains(' ')) return false;
    }
    return true;
  }

  void switchPlayer() {
    currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
  }

  void resetGame() {
    board = List.generate(3, (_) => List.filled(3, ' '));
    currentPlayer = 'X';
  }
}

void main() {
  TicTacToe game = TicTacToe();
  game.startGame();
}
