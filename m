From: "Hesse, Christian" <mail@earthworm.de>
Subject: Device ID Intel HDA
Date: Sun, 16 Jul 2006 02:30:39 +0200
Message-ID: <200607160230.43928.mail@earthworm.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0071172492=="
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

--===============0071172492==
Content-Type: multipart/signed; boundary="nextPart1576118.7E5h4cjUKg";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1576118.7E5h4cjUKg
Content-Type: multipart/mixed;
  boundary="Boundary-01=_viYuEv4KoBJj679"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_viYuEv4KoBJj679
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody!

I need the attached patch to get a working sound setup with my Samsung X11=
=20
T2300 Culesa. If you have any comments please cc me as I'm not subscribed t=
o=20
the list.

The only thing that does not work is the S/P-DIF output. Comments on that a=
re=20
welcome as well. ;)
=2D-=20
Regards,
Christian

--Boundary-01=_viYuEv4KoBJj679
Content-Type: text/x-diff; charset="us-ascii";
	name="alsa_hda_samsung-x11.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="alsa_hda_samsung-x11.patch"

=2D-- vanilla-2.6.17/sound/pci/hda/patch_analog.c	2006-06-18 03:49:35.00000=
0000 +0200
+++ linux/sound/pci/hda/patch_analog.c	2006-07-15 21:20:44.220434504 +0200
@@ -809,6 +809,8 @@
 	  .config =3D AD1986A_LAPTOP_EAPD }, /* ASUS Z62F */
 	{ .pci_subvendor =3D 0x103c, .pci_subdevice =3D 0x30af,
 	  .config =3D AD1986A_LAPTOP_EAPD }, /* HP Compaq Presario B2800 */
+	{ .pci_subvendor =3D 0x144d, .pci_subdevice =3D 0xc026,
+	  .config =3D AD1986A_LAPTOP_EAPD }, /* Samsung X10 T2300 Culesa */
 	{}
 };
=20

--Boundary-01=_viYuEv4KoBJj679
Content-Type: text/plain;
  charset="us-ascii";
  name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci"

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 02)
	Subsystem: Samsung Electronics Co Ltd Unknown device c026
	Flags: bus master, fast devsel, latency 0, IRQ 22
	Memory at d0240000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [70] Express Unknown type IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Unknown (5)


--Boundary-01=_viYuEv4KoBJj679--

--nextPart1576118.7E5h4cjUKg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQBEuYizlZfG2c8gdSURAqDKAKD3RNQQhlUVi8uL4n4u/FhZ4CC5qwCg8keJ
f41vyO2W8VMz5tnV5dUswO8=
=xF9R
-----END PGP SIGNATURE-----

--nextPart1576118.7E5h4cjUKg--


--===============0071172492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============0071172492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0071172492==--
