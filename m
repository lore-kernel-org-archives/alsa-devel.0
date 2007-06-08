From: Ritesh Raj Sarraf <rrs@researchut.com>
Subject: snd-usb-audio: Add another QuickCam ID
Date: Fri, 8 Jun 2007 15:38:31 +0530
Message-ID: <200706081538.36615.rrs@researchut.com>
Reply-To: Ritesh Raj Sarraf <rrs@researchut.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9123348146520761948=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 44E74246A7
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2007 12:08:52 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id r21so837426wxc
	for <alsa-devel@alsa-project.org>; Fri, 08 Jun 2007 03:08:50 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============9123348146520761948==
Content-Type: multipart/signed;
  boundary="nextPart2041763.nvPPuJ4xCH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2041763.nvPPuJ4xCH
Content-Type: multipart/mixed;
  boundary="Boundary-01=_fqSaGtIh3PZ1RkT"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_fqSaGtIh3PZ1RkT
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

This patch adds another Logitech QuickCam USB ID for the device which is=20
shipped with Dell's XPS M1210 Notebooks.

Signed-off-by: Ritesh Raj Sarraf <rrs@researchut.com>

diff --git a/sound/usb/usbquirks.h b/sound/usb/usbquirks.h
index 374fbf6..c69a56f 100644
=2D-- a/sound/usb/usbquirks.h
+++ b/sound/usb/usbquirks.h
@@ -70,6 +70,15 @@
        .bInterfaceClass =3D USB_CLASS_AUDIO,
        .bInterfaceSubClass =3D USB_SUBCLASS_AUDIO_CONTROL
 },
+{
+       .match_flags =3D USB_DEVICE_ID_MATCH_DEVICE |
+                      USB_DEVICE_ID_MATCH_INT_CLASS |
+                      USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+       .idVendor =3D 0x046d,
+       .idProduct =3D 0x08c6,
+       .bInterfaceClass =3D USB_CLASS_AUDIO,
+       .bInterfaceSubClass =3D USB_SUBCLASS_AUDIO_CONTROL
+},

PS: Request you to CC me if there are any comments. I'm not subscribed to t=
he=20
list.


Thanks,
Ritesh
=2D-=20
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."

--Boundary-01=_fqSaGtIh3PZ1RkT
Content-Type: text/x-diff;
  charset="us-ascii";
  name="dell_xpsm1210_quickcam.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dell_xpsm1210_quickcam.patch"

diff --git a/sound/usb/usbquirks.h b/sound/usb/usbquirks.h
index 374fbf6..c69a56f 100644
=2D-- a/sound/usb/usbquirks.h
+++ b/sound/usb/usbquirks.h
@@ -70,6 +70,15 @@
 	.bInterfaceClass =3D USB_CLASS_AUDIO,
 	.bInterfaceSubClass =3D USB_SUBCLASS_AUDIO_CONTROL
 },
+{
+	.match_flags =3D USB_DEVICE_ID_MATCH_DEVICE |
+		       USB_DEVICE_ID_MATCH_INT_CLASS |
+		       USB_DEVICE_ID_MATCH_INT_SUBCLASS,
+	.idVendor =3D 0x046d,
+	.idProduct =3D 0x08c6,
+	.bInterfaceClass =3D USB_CLASS_AUDIO,
+	.bInterfaceSubClass =3D USB_SUBCLASS_AUDIO_CONTROL
+},
=20
 /*
  * Yamaha devices

--Boundary-01=_fqSaGtIh3PZ1RkT--

--nextPart2041763.nvPPuJ4xCH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGaSqk4Rhi6gTxMLwRAuRUAKCJ5fL6cdNve953N69rn0xuJxXCUQCfWtBC
SolyvOeHWIiOH8qbtW2oPM8=
=JMWG
-----END PGP SIGNATURE-----

--nextPart2041763.nvPPuJ4xCH--

--===============9123348146520761948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============9123348146520761948==--
