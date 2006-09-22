From: Mike Frysinger <vapier@gentoo.org>
Subject: [patch] remove unneeded headers from src/names.c
Date: Fri, 22 Sep 2006 17:14:50 -0400
Message-ID: <200609221714.51381.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LJFFFkjCIVVkUYB"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_LJFFFkjCIVVkUYB
Content-Type: multipart/signed; boundary="nextPart1203983.61iWjfyao8";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1203983.61iWjfyao8
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

the src/names.c file includes many more headers than it actually needs ...=
=20
this causes troubles when porting to a target that lacks those headers :)

patch attached to scrub said headers
=2Dmike

--nextPart1203983.61iWjfyao8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARRRSS0FjO5/oN/WBAQJgYBAA0ufB6IFPL9BGr1hvWiDhkJnIRmKc69to
vaZVwj6/4PTaOdtLGZtO4MnD1QdyLOHHCRlmf+1o/uuZbdnl6z82snpcrAZe/nC7
duRzY+L/3ZfrbRxhE7cNqSOatQyvNV3yIpenZYnMAqVK2bQr7wmwIpevRoZoTpXn
yHBsFNEjyIwayvOT5pQMw05tWqXJir36pNKwXpA6jySBz1cR0DSPgytrwhnpVQjD
SPAwgwUlfbtupFlF0zNIv6Y5I+tYMWpxC24UslWevPym+J0M5L6RnlmJ6LMgEQiP
zKpZjELxvd0d6aD2AKrfcShZ00mDPoTash+NCc5fO4My4ZYM49uR3YAt4GQ2Xaz1
Fwo8lfkVbYrPeLlcHP+o9CX5Ou03ezWV5i3l4EHCkBzFbtXAyk1eb+bz0s/IshVw
gEe1GJ4w1R5hyKYEDQGUJbfn10QyxJJRA6gvGl7I4Pd7xTC5GIsAJRkTFNM5s3ZR
T9WY4W5BGjxDp6vtYLRYP6vX5JWXPh/0UzEMjya8J1VerVplznSXH9t/tinuZ0se
neQLX2WOrc2PigyJa7demh5GcrjyKbNAm3r8sz2gczHL6umAuNec7L9KOWJ74wqc
wp0V4vAzHiavKjkuKd+lMnQ/op14AI2k66BdLUdrC+aJ8EnuoRWYPJk8PT91gUu6
JtOF80a9e2I=
=YRzc
-----END PGP SIGNATURE-----

--nextPart1203983.61iWjfyao8--

--Boundary-00=_LJFFFkjCIVVkUYB
Content-Type: text/x-diff; charset="us-ascii";
	name="alsa-lib-names-include-less.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="alsa-lib-names-include-less.patch"

Signed-off-by: Mike Frysinger <vapier@gentoo.org>

 names.c |    4 ----
 1 file changed, 4 deletions(-)

diff -r 46221e609f45 src/names.c
--- a/src/names.c	Wed Sep 06 14:39:01 2006 +0200
+++ b/src/names.c	Thu Sep 07 14:39:43 2006 -0400
@@ -31,12 +31,8 @@
  */
 
 #include <stdarg.h>
-#include <wordexp.h>
-#include <dlfcn.h>
 #include <limits.h>
 #include <sys/stat.h>
-#include <pthread.h>
-#include <locale.h>
 #include "local.h"
 
 #ifndef DOC_HIDDEN

--Boundary-00=_LJFFFkjCIVVkUYB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_LJFFFkjCIVVkUYB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_LJFFFkjCIVVkUYB--
