From: "Hesse, Christian" <mail@earthworm.de>
Subject: fix typo in PCI IDs
Date: Wed, 8 Nov 2006 09:19:44 +0100
Message-ID: <200611080919.45112.mail@earthworm.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1618860129=="
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

--===============1618860129==
Content-Type: multipart/signed; boundary="nextPart1972230.jUP9XMoNbB";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1972230.jUP9XMoNbB
Content-Type: multipart/mixed;
  boundary="Boundary-01=_hMZUFeWd0cBbc3A"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_hMZUFeWd0cBbc3A
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everybody,

my notebook is a Samsung X11 of course... The attached patch fixes the typo.

Signed-off-by: Christian Hesse <mail@earthworm.de>

--Boundary-01=_hMZUFeWd0cBbc3A
Content-Type: text/x-diff;
  charset="us-ascii";
  name="alsa-x11.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="alsa-x11.patch"

--- a/sound/pci/hda/patch_analog.c	2006-11-08 09:12:56.221261238 +0100
+++ b/sound/pci/hda/patch_analog.c	2006-11-08 09:13:13.337659150 +0100
@@ -804,7 +804,7 @@
 	{ .pci_subvendor = 0x144d, .pci_subdevice = 0xc024,
 	  .config = AD1986A_LAPTOP_EAPD }, /* Samsung R65-T2300 Charis */
 	{ .pci_subvendor = 0x144d, .pci_subdevice = 0xc026,
-	  .config = AD1986A_LAPTOP_EAPD }, /* Samsung X10-T2300 Culesa */
+	  .config = AD1986A_LAPTOP_EAPD }, /* Samsung X11-T2300 Culesa */
 	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x1153,
 	  .config = AD1986A_LAPTOP_EAPD }, /* ASUS M9 */
 	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x1213,

--Boundary-01=_hMZUFeWd0cBbc3A--

--nextPart1972230.jUP9XMoNbB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFUZMhlZfG2c8gdSURAgMPAKDg94J1OeaG2Xlw9Il/46rZWdJAjgCfQgSs
S2MXiNdtCHGgd3iH4oY+oZE=
=pHKB
-----END PGP SIGNATURE-----

--nextPart1972230.jUP9XMoNbB--


--===============1618860129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1618860129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1618860129==--
