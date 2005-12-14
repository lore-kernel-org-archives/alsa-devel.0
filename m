From: =?utf-8?q?Ren=C3=A9_Rebe?= <rene@exactcode.de>
Subject: [PATCH] cs5536 ID for cs5535audio
Date: Wed, 14 Dec 2005 14:31:29 +0100
Message-ID: <200512141431.32685.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1395271.pGEIAZl7uB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932468AbVLNNck@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
List-Id: alsa-devel@alsa-project.org

--nextPart1395271.pGEIAZl7uB
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

relative to 2.6.15-rc5-mm2 / alsa-cvs, works for me:

Added AMD CS5536 to the cs5535audio driver.

Signed-off-by: Ren=C3=A9 Rebe <rene@exactcode.de>

=2D-- sound/pci/cs5535audio/cs5535audio.c.orig	2005-12-14 14:39:11.00000000=
0 +0100
+++ sound/pci/cs5535audio/cs5535audio.c	2005-12-14 14:29:23.000000000 +0100
@@ -46,8 +46,10 @@
 static int enable[SNDRV_CARDS] =3D SNDRV_DEFAULT_ENABLE_PNP;
=20
 static struct pci_device_id snd_cs5535audio_ids[] =3D {
=2D	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO, PCI_ANY_ID,
=2D		PCI_ANY_ID, 0, 0, 0, },
+	{ PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_AUDIO,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
+	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_AUDIO,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },
 	{}
 };
=20


=2D-=20
Ren=C3=A9 Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45

--nextPart1395271.pGEIAZl7uB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDoB60QuICExGFvYIRAnKqAJ44SL+prO5sQprQlQGo3U5dPvo5pACfYKoN
kbzHw3hcCRjARy840e/qYp4=
=EPOe
-----END PGP SIGNATURE-----

--nextPart1395271.pGEIAZl7uB--
