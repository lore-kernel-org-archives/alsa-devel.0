From: David Lee Lambert <as4109@wayne.edu>
Subject: ALSA library name / other easy way to capture sound
Date: Tue, 18 Apr 2006 19:56:37 -0400
Message-ID: <200604181956.50676.as4109@wayne.edu>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart25459667.bYgy1Fxlg6";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--nextPart25459667.bYgy1Fxlg6
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I'm trying to write a program that captures a short audio segment (~10 s), =
=20
stores it in a deque<float>, and does some linear-algebra on it.  However, =
=20
I've been having a lot of trouble reading audio input.  At first I tried=20
opening "rec" as a subprocess,  but it seems to only respond to SIGINT when=
=20
standard output is connected to a terminal.

I've also looked into using ALSA.  I found the headers on my system,  and m=
y=20
code seems to compile all right using them (I found the tutorial at=20
http://equalarea.com/paul/alsa-audio.html#basics helpful).  However,  when =
I=20
try to link,  I get errors like the following:

 g++ -O1 -Wall -g -o test3 test3.cpp audioreader.o -shared -lalsa
/usr/bin/ld: cannot find -lalsa
collect2: ld returned 1 exit status
make: *** [test3] Error 1

Are the ALSA functions normally available in some shared library?  What is =
it=20
called?  Is it a good idea to use it in such a simple application,  or woul=
d=20
I get acceptable performance by opening 'arecord' in a subprocess (and can =
I=20
kill it after a specified time)?

=2D-=20
David Lee Lambert ..... Student, Dept. Computer Science,
  Wayne State University (lab: 410 State Hall)
<as4109@wayne.edu> or <lamber45@msu.edu> or +1 586-873-8813
Homepage at http://paris.cs.wayne.edu/~as4109/

--nextPart25459667.bYgy1Fxlg6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBERXzCkeetBuAdnkIRArUEAJ9J8BipSl/kJe7p9sIZwi/NqNvRGgCgiZFc
vYc7uODuWeDIpzOJ5YJhAIo=
=91hl
-----END PGP SIGNATURE-----

--nextPart25459667.bYgy1Fxlg6--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
