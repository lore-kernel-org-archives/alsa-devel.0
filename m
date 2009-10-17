From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] alsa: echoaudio - pci id cleanup
Date: Sat, 17 Oct 2009 11:48:23 +0200
Message-ID: <4AD992E7.9020203@klingt.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6343713292780086486=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from klingt.org (mail.klingt.org [86.59.21.178])
	by alsa0.perex.cz (Postfix) with ESMTP id EF49B1037E3
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Oct 2009 11:48:34 +0200 (CEST)
Received: from [192.168.178.3] (localhost [127.0.0.1]) (authenticated bits=0)
	by klingt.org (8.14.3/8.14.3/Debian-9) with ESMTP id n9H9mSIx029872
	for <alsa-devel@alsa-project.org>; Sat, 17 Oct 2009 11:48:32 +0200
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============6343713292780086486==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEEFFF7BAC608BA7B06948677"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEEFFF7BAC608BA7B06948677
Content-Type: multipart/mixed;
 boundary="------------030002070806080407060102"

This is a multi-part message in MIME format.
--------------030002070806080407060102
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


using the PCI_VENDOR_ID_MOTOROLA definition instead of the value 0x1057
makes code a bit cleaner.

Signed-off-by: Tim Blechmann <tim@klingt.org>
---
 sound/pci/echoaudio/darla20.c   |    3 ++-
 sound/pci/echoaudio/darla24.c   |    6 ++++--
 sound/pci/echoaudio/echo3g.c    |    3 ++-
 sound/pci/echoaudio/gina20.c    |    3 ++-
 sound/pci/echoaudio/gina24.c    |   12 ++++++++----
 sound/pci/echoaudio/indigo.c    |    3 ++-
 sound/pci/echoaudio/indigodj.c  |    3 ++-
 sound/pci/echoaudio/indigodjx.c |    3 ++-
 sound/pci/echoaudio/indigoio.c  |    3 ++-
 sound/pci/echoaudio/indigoiox.c |    3 ++-
 sound/pci/echoaudio/layla20.c   |    6 ++++--
 sound/pci/echoaudio/layla24.c   |    3 ++-
 sound/pci/echoaudio/mia.c       |    6 ++++--
 sound/pci/echoaudio/mona.c      |   18 ++++++++++++------
 14 files changed, 50 insertions(+), 25 deletions(-)

--------------030002070806080407060102
Content-Type: text/x-patch;
 name="0001-alsa-echoaudio-pci-id-cleanup.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-alsa-echoaudio-pci-id-cleanup.patch"

diff --git a/sound/pci/echoaudio/darla20.c b/sound/pci/echoaudio/darla20.=
c
index 8c6db3a..3f03cf7 100644
--- a/sound/pci/echoaudio/darla20.c
+++ b/sound/pci/echoaudio/darla20.c
@@ -64,7 +64,8 @@ static const struct firmware card_fw[] =3D {
 };
=20
 static struct pci_device_id snd_echo_ids[] =3D {
-	{0x1057, 0x1801, 0xECC0, 0x0010, 0, 0, 0},	/* DSP 56301 Darla20 rev.0 *=
/
+	/* DSP 56301 Darla20 rev.0 */
+	{PCI_VENDOR_ID_MOTOROLA, 0x1801, 0xECC0, 0x0010, 0, 0, 0},
 	{0,}
 };
=20
diff --git a/sound/pci/echoaudio/darla24.c b/sound/pci/echoaudio/darla24.=
c
index 04cbf3e..bd0aa0a 100644
--- a/sound/pci/echoaudio/darla24.c
+++ b/sound/pci/echoaudio/darla24.c
@@ -68,8 +68,10 @@ static const struct firmware card_fw[] =3D {
 };
=20
 static struct pci_device_id snd_echo_ids[] =3D {
-	{0x1057, 0x1801, 0xECC0, 0x0040, 0, 0, 0},	/* DSP 56301 Darla24 rev.0 *=
/
-	{0x1057, 0x1801, 0xECC0, 0x0041, 0, 0, 0},	/* DSP 56301 Darla24 rev.1 *=
/
+	/* DSP 56301 Darla24 rev.0 */
+	{PCI_VENDOR_ID_MOTOROLA, 0x1801, 0xECC0, 0x0040, 0, 0, 0},
+	/* DSP 56301 Darla24 rev.1 */
+	{PCI_VENDOR_ID_MOTOROLA, 0x1801, 0xECC0, 0x0041, 0, 0, 0},
 	{0,}
 };
=20
diff --git a/sound/pci/echoaudio/echo3g.c b/sound/pci/echoaudio/echo3g.c
index 4022e43..f8b2c47 100644
--- a/sound/pci/echoaudio/echo3g.c
+++ b/sound/pci/echoaudio/echo3g.c
@@ -82,7 +82,8 @@ static const struct firmware card_fw[] =3D {
 };
=20
 static struct pci_device_id snd_echo_ids[] =3D {
-	{0x1057, 0x3410, 0xECC0, 0x0100, 0, 0, 0},	/* Echo 3G */
+	/* Echo 3G */
+	{PCI_VENDOR_ID_MOTOROLA, 0x3410, 0xECC0, 0x0100, 0, 0, 0},
 	{0,}
 };
=20
diff --git a/sound/pci/echoaudio/gina20.c b/sound/pci/echoaudio/gina20.c
index c0e64b8..d00e92e 100644
--- a/sound/pci/echoaudio/gina20.c
+++ b/sound/pci/echoaudio/gina20.c
@@ -68,7 +68,8 @@ static const struct firmware card_fw[] =3D {
 };
=20
 static struct pci_device_id snd_echo_ids[] =3D {
-	{0x1057, 0x1801, 0xECC0, 0x0020, 0, 0, 0},	/* DSP 56301 Gina20 rev.0 */=

+	/* DSP 56301 Gina20 rev.0 */
+	{PCI_VENDOR_ID_MOTOROLA, 0x1801, 0xECC0, 0x0020, 0, 0, 0},
 	{0,}
 };
=20
diff --git a/sound/pci/echoaudio/gina24.c b/sound/pci/echoaudio/gina24.c
index c36a78d..1f403c4 100644
--- a/sound/pci/echoaudio/gina24.c
+++ b/sound/pci/echoaudio/gina24.c
@@ -86,10 +86,14 @@ static const struct firmware card_fw[] =3D {
 };
=20
 static struct pci_device_id snd_echo_ids[] =3D {
-	{0x1057, 0x1801, 0xECC0, 0x0050, 0, 0, 0},	/* DSP 56301 Gina24 rev.0 */=

-	{0x1057, 0x1801, 0xECC0, 0x0051, 0, 0, 0},	/* DSP 56301 Gina24 rev.1 */=

-	{0x1057, 0x3410, 0xECC0, 0x0050, 0, 0, 0},	/* DSP 56361 Gina24 rev.0 */=

-	{0x1057, 0x3410, 0xECC0, 0x0051, 0, 0, 0},	/* DSP 56361 Gina24 rev.1 */=

+	/* DSP 56301 Gina24 rev.0 */
+	{PCI_VENDOR_ID_MOTOROLA, 0x1801, 0xECC0, 0x0050, 0, 0, 0},
+	/* DSP 56301 Gina24 rev.1 */
+	{PCI_VENDOR_ID_MOTOROLA, 0x1801, 0xECC0, 0x0051, 0, 0, 0},
+	/* DSP 56361 Gina24 rev.0 */
+	{PCI_VENDOR_ID_MOTOROLA, 0x3410, 0xECC0, 0x0050, 0, 0, 0},
+	/* DSP 56361 Gina24 rev.1 */
+	{PCI_VENDOR_ID_MOTOROLA, 0x3410, 0xECC0, 0x0051, 0, 0, 0},
 	{0,}
 };
=20
diff --git a/sound/pci/echoaudio/indigo.c b/sound/pci/echoaudio/indigo.c
index 0a58a7c..fa3e2c0 100644
--- a/sound/pci/echoaudio/indigo.c
+++ b/sound/pci/echoaudio/indigo.c
@@ -69,7 +69,8 @@ static const struct firmware card_fw[] =3D {
 };
=20
 static struct pci_device_id snd_echo_ids[] =3D {
-	{0x1057, 0x3410, 0xECC0, 0x0090, 0, 0, 0},	/* Indigo */
+	/* Indigo */
+	{PCI_VENDOR_ID_MOTOROLA, 0x3410, 0xECC0, 0x0090, 0, 0, 0},
 	{0,}
 };
=20
diff --git a/sound/pci/echoaudio/indigodj.c b/sound/pci/echoaudio/indigod=
j.c
index 2db24d2..3a68b11 100644
--- a/sound/pci/echoaudio/indigodj.c
+++ b/sound/pci/echoaudio/indigodj.c
@@ -69,7 +69,8 @@ static const struct firmware card_fw[] =3D {
 };
=20
 static struct pci_device_id snd_echo_ids[] =3D {
-	{0x1057, 0x3410, 0xECC0, 0x00B0, 0, 0, 0},	/* Indigo DJ*/
+	/* Indigo DJ*/
+	{PCI_VENDOR_ID_MOTOROLA, 0x3410, 0xECC0, 0x00B0, 0, 0, 0},
 	{0,}
 };
=20
diff --git a/sound/pci/echoaudio/indigodjx.c b/sound/pci/echoaudio/indigo=
djx.c
index 2e44316..270cc6b 100644
--- a/sound/pci/echoaudio/indigodjx.c
+++ b/sound/pci/echoaudio/indigodjx.c
@@ -69,7 +69,8 @@ static const struct firmware card_fw[] =3D {
 };
=20
 static struct pci_device_id snd_echo_ids[] =3D {
-	{0x1057, 0x3410, 0xECC0, 0x00E0, 0, 0, 0},	/* Indigo DJx*/
+	/* Indigo DJx*/
+	{PCI_VENDOR_ID_MOTOROLA, 0x3410, 0xECC0, 0x00E0, 0, 0, 0},
 	{0,}
 };
=20
diff --git a/sound/pci/echoaudio/indigoio.c b/sound/pci/echoaudio/indigoi=
o.c
index a60c0a0..548862d 100644
--- a/sound/pci/echoaudio/indigoio.c
+++ b/sound/pci/echoaudio/indigoio.c
@@ -70,7 +70,8 @@ static const struct firmware card_fw[] =3D {
 };
=20
 static struct pci_device_id snd_echo_ids[] =3D {
-	{0x1057, 0x3410, 0xECC0, 0x00A0, 0, 0, 0},	/* Indigo IO*/
+	/* Indigo IO*/
+	{PCI_VENDOR_ID_MOTOROLA, 0x3410, 0xECC0, 0x00A0, 0, 0, 0},
 	{0,}
 };
=20
diff --git a/sound/pci/echoaudio/indigoiox.c b/sound/pci/echoaudio/indigo=
iox.c
index eb3819f..722417b 100644
--- a/sound/pci/echoaudio/indigoiox.c
+++ b/sound/pci/echoaudio/indigoiox.c
@@ -70,7 +70,8 @@ static const struct firmware card_fw[] =3D {
 };
=20
 static struct pci_device_id snd_echo_ids[] =3D {
-	{0x1057, 0x3410, 0xECC0, 0x00D0, 0, 0, 0},	/* Indigo IOx */
+	/* Indigo IOx */
+	{PCI_VENDOR_ID_MOTOROLA, 0x3410, 0xECC0, 0x00D0, 0, 0, 0},
 	{0,}
 };
=20
diff --git a/sound/pci/echoaudio/layla20.c b/sound/pci/echoaudio/layla20.=
c
index 5061946..7d4a4e0 100644
--- a/sound/pci/echoaudio/layla20.c
+++ b/sound/pci/echoaudio/layla20.c
@@ -77,8 +77,10 @@ static const struct firmware card_fw[] =3D {
 };
=20
 static struct pci_device_id snd_echo_ids[] =3D {
-	{0x1057, 0x1801, 0xECC0, 0x0030, 0, 0, 0},	/* DSP 56301 Layla20 rev.0 *=
/
-	{0x1057, 0x1801, 0xECC0, 0x0031, 0, 0, 0},	/* DSP 56301 Layla20 rev.1 *=
/
+	/* DSP 56301 Layla20 rev.0 */
+	{PCI_VENDOR_ID_MOTOROLA, 0x1801, 0xECC0, 0x0030, 0, 0, 0},
+	/* DSP 56301 Layla20 rev.1 */
+	{PCI_VENDOR_ID_MOTOROLA, 0x1801, 0xECC0, 0x0031, 0, 0, 0},
 	{0,}
 };
=20
diff --git a/sound/pci/echoaudio/layla24.c b/sound/pci/echoaudio/layla24.=
c
index e09e3ea..48246f8 100644
--- a/sound/pci/echoaudio/layla24.c
+++ b/sound/pci/echoaudio/layla24.c
@@ -88,7 +88,8 @@ static const struct firmware card_fw[] =3D {
 };
=20
 static struct pci_device_id snd_echo_ids[] =3D {
-	{0x1057, 0x3410, 0xECC0, 0x0060, 0, 0, 0},	/* DSP 56361 Layla24 rev.0 *=
/
+	/* DSP 56361 Layla24 rev.0 */
+	{PCI_VENDOR_ID_MOTOROLA, 0x3410, 0xECC0, 0x0060, 0, 0, 0},
 	{0,}
 };
=20
diff --git a/sound/pci/echoaudio/mia.c b/sound/pci/echoaudio/mia.c
index f3b9b45..bbed105 100644
--- a/sound/pci/echoaudio/mia.c
+++ b/sound/pci/echoaudio/mia.c
@@ -77,8 +77,10 @@ static const struct firmware card_fw[] =3D {
 };
=20
 static struct pci_device_id snd_echo_ids[] =3D {
-	{0x1057, 0x3410, 0xECC0, 0x0080, 0, 0, 0},	/* DSP 56361 Mia rev.0 */
-	{0x1057, 0x3410, 0xECC0, 0x0081, 0, 0, 0},	/* DSP 56361 Mia rev.1 */
+	/* DSP 56361 Mia rev.0 */
+	{PCI_VENDOR_ID_MOTOROLA, 0x3410, 0xECC0, 0x0080, 0, 0, 0},
+	/* DSP 56361 Mia rev.1 */
+	{PCI_VENDOR_ID_MOTOROLA, 0x3410, 0xECC0, 0x0081, 0, 0, 0},
 	{0,}
 };
=20
diff --git a/sound/pci/echoaudio/mona.c b/sound/pci/echoaudio/mona.c
index b05bad9..917c9b2 100644
--- a/sound/pci/echoaudio/mona.c
+++ b/sound/pci/echoaudio/mona.c
@@ -93,12 +93,18 @@ static const struct firmware card_fw[] =3D {
 };
=20
 static struct pci_device_id snd_echo_ids[] =3D {
-	{0x1057, 0x1801, 0xECC0, 0x0070, 0, 0, 0},	/* DSP 56301 Mona rev.0 */
-	{0x1057, 0x1801, 0xECC0, 0x0071, 0, 0, 0},	/* DSP 56301 Mona rev.1 */
-	{0x1057, 0x1801, 0xECC0, 0x0072, 0, 0, 0},	/* DSP 56301 Mona rev.2 */
-	{0x1057, 0x3410, 0xECC0, 0x0070, 0, 0, 0},	/* DSP 56361 Mona rev.0 */
-	{0x1057, 0x3410, 0xECC0, 0x0071, 0, 0, 0},	/* DSP 56361 Mona rev.1 */
-	{0x1057, 0x3410, 0xECC0, 0x0072, 0, 0, 0},	/* DSP 56361 Mona rev.2 */
+	/* DSP 56301 Mona rev.0 */
+	{PCI_VENDOR_ID_MOTOROLA, 0x1801, 0xECC0, 0x0070, 0, 0, 0},
+	/* DSP 56301 Mona rev.1 */
+	{PCI_VENDOR_ID_MOTOROLA, 0x1801, 0xECC0, 0x0071, 0, 0, 0},
+	/* DSP 56301 Mona rev.2 */
+	{PCI_VENDOR_ID_MOTOROLA, 0x1801, 0xECC0, 0x0072, 0, 0, 0},
+	/* DSP 56361 Mona rev.0 */
+	{PCI_VENDOR_ID_MOTOROLA, 0x3410, 0xECC0, 0x0070, 0, 0, 0},
+	/* DSP 56361 Mona rev.1 */
+	{PCI_VENDOR_ID_MOTOROLA, 0x3410, 0xECC0, 0x0071, 0, 0, 0},
+	/* DSP 56361 Mona rev.2 */
+	{PCI_VENDOR_ID_MOTOROLA, 0x3410, 0xECC0, 0x0072, 0, 0, 0},
 	{0,}
 };
=20


--------------030002070806080407060102--

--------------enigEEFFF7BAC608BA7B06948677
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrZkucACgkQdL+4qsZfVstmxACeNr1qES6lDnAQdhmEXBRhVyqw
zuQAn1UnomRAHCnOWhEoo+TOJpx49h4k
=Hug7
-----END PGP SIGNATURE-----

--------------enigEEFFF7BAC608BA7B06948677--

--===============6343713292780086486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6343713292780086486==--
