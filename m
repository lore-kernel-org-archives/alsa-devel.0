From: Mike Frysinger <vapier@gentoo.org>
Subject: [patch] remove unneeded headers from
	alsa-lib/src/alisp/alisp.c
Date: Fri, 22 Sep 2006 17:16:17 -0400
Message-ID: <200609221716.17673.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hKFFFYYGlwZGbqw"
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

--Boundary-00=_hKFFFYYGlwZGbqw
Content-Type: multipart/signed; boundary="nextPart1273186.1TH3sbIqkD";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1273186.1TH3sbIqkD
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

the alisp.c file includes wordexp.h even though it doesnt actually use any=
=20
wordexp functions ... causes trouble when target doesnt have wordexp=20
support :)

patch attached to scrub said headers
=2Dmike

--nextPart1273186.1TH3sbIqkD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIUAwUARRRSoUFjO5/oN/WBAQKsAg/4zuIK8vqWoCv9XyVwwnEqP4gR/vc68gAq
0HL48NTJF3traFy+xseeOOg8IC+4ftAvW+Aao7XFC9NbtVH/HtSM6gsSSA/yNJEc
9vfkDA2nB6Bjd0UYXnkQMLFIAVJ7M8MWsBAx8CSHHMOyOdXh/xw0ppFZHi9Jn/52
TsazMrgdAgb5Ne/7YDi3R2g/dQE3jv/bZDJZqhlOxUbsikgWDXc9BJOhLhbkyRZe
tRfFd3J8R6rzw9fIw+kgKtbSaDQFOS/Nqfo0pkr1dHxymf8pnLhH1UeTwCd5m919
YxHq2HyMDEQKgNtQ1uB0San4wuUN8koPGjRC/BANfitpqnPf3pDXtt3kdoWe/v6w
1vrJNJTw/7MqzxsDLjX0VAIAzteuUuSmGHO8juAcnzHg2FWsRjHAQt5OaxX0YeXu
DXMKQLf9RBfn2/A2fYOiEETxW+takXkwUroNQpdN5zeTUg5JMXPj1c3ur6bE52Mx
oUET4Td2xN2GwbMmeFtDkk5F8pJO550N4nxJ+ZIC+/8QfzpGqdRP4Yz4ayUftHJQ
ENLtLPAcs+2zdZq/PTlk/D9R6q8FVWxMix/ttH7OD5fUI7eUV2wbQ+zhWvI001Bc
+rQ0MiTxvh3e2q3/zt2bPOq/DA7fSAgwHOVIA6iNQVkB7W3mJO/c1golNNtTmuc2
QYnm/cIZBQ==
=apUS
-----END PGP SIGNATURE-----

--nextPart1273186.1TH3sbIqkD--

--Boundary-00=_hKFFFYYGlwZGbqw
Content-Type: text/x-diff; charset="us-ascii";
	name="alsa-lib-alisp-include-less.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="alsa-lib-alisp-include-less.patch"

Signed-off-by: Mike Frysinger <vapier@gentoo.org>

 alisp.c |    1 -
 1 file changed, 1 deletion(-)

diff -r 46221e609f45 src/alisp/alisp.c
--- a/src/alisp/alisp.c	Wed Sep 06 14:39:01 2006 +0200
+++ b/src/alisp/alisp.c	Thu Sep 07 14:42:21 2006 -0400
@@ -30,7 +30,6 @@
 #include <ctype.h>
 #include <math.h>
 #include <err.h>
-#include <wordexp.h>
 
 #define alisp_seq_iterator alisp_object
 

--Boundary-00=_hKFFFYYGlwZGbqw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_hKFFFYYGlwZGbqw
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_hKFFFYYGlwZGbqw--
