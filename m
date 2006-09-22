From: Mike Frysinger <vapier@gentoo.org>
Subject: [patch] make sure commands in cvs/hg compile scripts
	worked
Date: Fri, 22 Sep 2006 17:00:09 -0400
Message-ID: <200609221700.10112.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_a7EFFNTAlazPE1a"
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

--Boundary-00=_a7EFFNTAlazPE1a
Content-Type: multipart/signed; boundary="nextPart3949983.hKeuCGRG26";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3949983.hKeuCGRG26
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

simple patch ... just add 'set -e' to the top of the files in alsa-lib :)
-mike

--nextPart3949983.hKeuCGRG26
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQIVAwUARRRO2UFjO5/oN/WBAQIPEg//XzPK56Bm0SddeYkUBV1LKA3Vu52qRTuJ
g8i3f20BZ/i+/6FwYsgAjd1pj/igxNCmv3LhgxhNMbiCuxHSu+vLVywYEZ7pbTWT
a6ie7/mfiBCNAxpshRWOg+oE3qNyR0098pakB/j8Y7HVKpa+ri1MiM9wYA3XTNCR
/U7lQVP4PzjEX8OMjqeqisuD+CfS44JFJjRBxZmwWxxm8792BYj4H66RVHEYwmbd
LhcCLMZjqCCSENlL+bXYIvETqwzzlVgu08x4e2bt2/JPijNj4O+8dPhbo4r392ib
y630LVT8eWr9Eo7TKZqhTeSC7NGRXXLG5smGorXsXx/Qvk4XvuE6Mvs2waVr1sHT
1vOO2RbKzVMEIrIYGSZlWgS3ubcka5kOFR6decwTBUmvDGK/5m9faOuU4qz2Z7Tl
CLA64DmOr7j0OhXrKkJXh1vaCigQ0O1H5GgBNoLn+8ir+3SkFIa244gatOkXJTcI
mwCMg55KoWaUUMwYAV6ARrRYrb78/bXiV+JR4s8O8C93mL40zD4Eaa7f03OB4b5l
2+5UtBR2Xb7gkh6MRNXEJZsNZSAKvIHwFBLya+Ify1ZoxgGppruEOcGIaT7UNWuy
2uGQcrEKcB3ZvwH71tx8ty4x1qnH1a091VRRc4hPmmk++cpOZzLanpCPh9GIk8fr
XjOMTRXLaCY=
=WGhK
-----END PGP SIGNATURE-----

--nextPart3949983.hKeuCGRG26--

--Boundary-00=_a7EFFNTAlazPE1a
Content-Type: text/x-diff; charset="us-ascii";
	name="alsa-compile-scripts-set-e.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="alsa-compile-scripts-set-e.patch"

diff -r 8bdd68608788 cvscompile
--- a/cvscompile	Mon Sep 18 17:57:58 2006 +0200
+++ b/cvscompile	Fri Sep 22 16:58:42 2006 -0400
@@ -1,4 +1,6 @@
 #!/bin/bash
+
+set -e
 
 touch ltconfig
 libtoolize --force --copy --automake
diff -r 8bdd68608788 hgcompile
--- a/hgcompile	Mon Sep 18 17:57:58 2006 +0200
+++ b/hgcompile	Fri Sep 22 16:59:13 2006 -0400
@@ -1,4 +1,6 @@
 #!/bin/bash
+
+set -e
 
 touch ltconfig
 libtoolize --force --copy --automake

--Boundary-00=_a7EFFNTAlazPE1a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_a7EFFNTAlazPE1a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_a7EFFNTAlazPE1a--
