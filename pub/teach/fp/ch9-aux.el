$B!($3$N%W%m%0%i%`$OM}3XIt>pJs2J3X2J$NGkC+>;8J@h@8$N$b$N$r(B
$B!(;29M$7$F:n$C$?$b$N$G$9!%(B

$B#1(B $BHWLL$NI=8=(B

(defun at (b i j)
   (elt (elt b i) j))

(defun elt (x i)
  (cond ((= i 0) (car x))
        ((= i 1) (car (cdr x)))
        ((= i 2) (car (cdr (cdr x))))))


$B#2(B $B<g4X?t(B

(defun max-move (p b i j)
  (if (= i 3) 
      '(-999 . (0 . 0))    ; $B8E$$HG$G$O!$(B) $B$,0l8DM>$C$F$$$?!%(B
      (if (eq (at b i j) 'b) 
	(if (= j 2)        ; $B8E$$HG$G$O!$(B(= j 3)$B$G$7$?!%(B
	    (max-move-2 (cons (eval-board p (move p b i j)) (cons i j))
			(max-move p b (+ i 1) 0))
	    (max-move-2 (cons (eval-board p (move p b i j)) (cons i j))
		      (max-move p b i (+ j 1))))
        (if (= j 2)        ; $B8E$$HG$G$O!$(B(= j 3)$B$G$7$?!%(B
	    (max-move p b (+ i 1) 0)
	    (max-move p b i (+ j 1))))))

(defun eval-board (p b)
   (cond ((winp p b) 1)
         ((winp (opp p) b) -1)
         ((drawp b) 0)
         (t (- (car (max-move (opp p) b 0 0))))))

$B#3(B $BJd=u4X?t(B

(defun winp (p b)
  (or (win-line p b 0 0 0 1)
      (win-line p b 1 0 0 1)
      (win-line p b 2 0 0 1)
      (win-line p b 0 0 1 0)
      (win-line p b 0 1 1 0)
      (win-line p b 0 2 1 0)
      (win-line p b 0 0 1 1)
      (win-line p b 2 0 -1 1)))

(defun win-line (p b i j di dj)
  (and (eq (at b i j) p)
       (eq (at b (+ i di) (+ j dj)) p)
       (eq (at b (+ i di di) (+ j dj dj)) p)))

(defun drawp (b)
 (and (draw-line b 0 0 0 1)
      (draw-line b 1 0 0 1)
      (draw-line b 2 0 0 1)
      (draw-line b 0 0 1 0)
      (draw-line b 0 1 1 0)
      (draw-line b 0 2 1 0)
      (draw-line b 0 0 1 1)
      (draw-line b 2 0 -1 1)))

(defun draw-line (b i j di dj)
  (and (or (eq (at b i j) 'o)
           (eq (at b (+ i di) (+ j dj)) 'o)
           (eq (at b (+ i di di) (+ j dj dj)) 'o))
       (or (eq (at b i j) 'x)
           (eq (at b (+ i di) (+ j dj)) 'x)
           (eq (at b (+ i di di) (+ j dj dj)) 'x))))

(defun opp (p)
  (if (eq p 'o) 'x 'o))

(defun max-move-2 (m1 m2)
   (if (< (car m1) (car m2)) m2 m1))

(defun move (p b i j)
  (rep-elt b i (rep-elt (elt b i) j p)))

(defun rep-elt (x i e)
   (cond ((= i 0) (cons e (cdr x)))
         ((= i 1) (cons (car x) (cons e (cdr (cdr x)))))
         ((= i 2) (cons (car x) (cons (car (cdr x)) (cons e ()))))))

$B#4(B $B%F%9%H(B

(at '((x b o) (o o x) (b b x)) 2 1)
b

(at '((x b o) (o o x) (b b x)) 1 2)
x

(move 'x  '((x b o) (o o x) (b b x)) 2 1)
((x b o) (o o x) (b x x))

(drawp '((o x x) (b o b) (b b o)))
nil

(drawp '((o x o) (o x x) (x o b)))
t

(eval-board 'o '((x b b) (b o x) (o b o)))
1

(eval-board 'x '((o x o) (o x x) (x o b)))
0

(max-move 'o '((b x x) (b o b) (b b o)) 0 0)
(1 0 . 0)

(max-move 'o '((x b b) (b o x) (b b o)) 0 0)
(1 2 . 0)

(max-move 'x '((o x o) (o x b) (x o b)) 0 0)
(0 1 . 2)

(max-move 'o '((b b b) (b b b) (b b b)) 0 0)
(0 0 . 0)     ; $B$3$N7W;;$O(B20$BJ,$0$i$$$+$+$j$^$7$?!%(B



