From: Ritesh Raj Sarraf <rrs@researchut.com>
Subject: [PATCH] snd-usb-audio: Add another QuickCam ID
Date: Tue, 10 Jul 2007 16:21:11 +0530
Message-ID: <200707101621.17001.rrs@researchut.com>
Reply-To: Ritesh Raj Sarraf <rrs@researchut.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4870504671032661230=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by alsa0.perex.cz (Postfix) with ESMTP id C03991038DB
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2007 12:51:34 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id d32so2274591pye
	for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2007 03:51:33 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============4870504671032661230==
Content-Type: multipart/signed;
  boundary="nextPart1249083.Xg40qfBdQu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1249083.Xg40qfBdQu
Content-Type: multipart/mixed;
  boundary="Boundary-01=_fS2kGTL9TStIOqI"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_fS2kGTL9TStIOqI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Clemens,

Can you push this for 2.6.23 ?

Or is there anything else missing in the patch ?


Thanks,
Ritesh


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

On Friday 08 June 2007, Clemens Ladisch wrote:
> Ritesh Raj Sarraf wrote:
> > dell_xpsm1210_quickcam.patch
>
> Please provide a Signed-off-by line.
>
> I guess this patch is for the integrated webcam of the Dell XPS M1210?
>
>

Hi Clemens,

I've regenerate the patch properly this time.

And yes, this patch is for the integrated webcam shipped with M1210.


PS: Request you to CC me if there are any comments. I'm not subscribed to t=
he=20
list.

Thanks,
Ritesh
=2D-=20
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."

=2D-=20
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."

--Boundary-01=_fS2kGTL9TStIOqI
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="0003-USB-ID-for-intergrated-quickcam-on-dell-xps-m1210.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0003-USB-ID-for-intergrated-quickcam-on-dell-xps-m1210.patch"

=46rom 27e2ff25469fb4fae564ef074a65c83fffd9c665 Mon Sep 17 00:00:00 2001
=46rom: Ritesh Raj Sarraf <rrs@researchut.com>
Date: Fri, 8 Jun 2007 20:53:07 +0530
Subject: [PATCH] USB ID for intergrated quickcam on dell xps m1210

This patch adds Logitech QuickCam USB ID for Dell's
XPS M1210 notebooks.

Signed-off-by: Ritesh Raj Sarraf <rrs@researchut.com>
=2D--
 sound/usb/usbquirks.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

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
=2D-=20
1.5.2.1


--Boundary-01=_fS2kGTL9TStIOqI--

--nextPart1249083.Xg40qfBdQu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGk2Sk4Rhi6gTxMLwRApIuAJwM1hUz7IyGakLaEPDpWG7RR94KnwCgtCCG
kQvtFagxQdi0b4RV7jb+XtE=
=+2cs
-----END PGP SIGNATURE-----

--nextPart1249083.Xg40qfBdQu--

--===============4870504671032661230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4870504671032661230==--
