From: crimsun@fungus.sh.nu
Subject: [PATCH] Include quirks from Ubuntu Dapper/Edgy/Feisty
Date: Tue, 15 May 2007 02:03:37 -0700
Message-ID: <20070515090337.GA834@fungus.sh.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7052746320054730317=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ns1.mcdownloads.com (ns1.mcdownloads.com [216.239.132.98])
	by alsa0.perex.cz (Postfix) with ESMTP id D819024801
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2007 11:03:38 +0200 (CEST)
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


--===============7052746320054730317==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

# HG changeset patch
# User crimsun@Box.ncat.edu
# Date 1179219408 14400
# Node ID f38d824e5df6fb7d9677cce13f91ad868e617fe4
# Parent  38fe50050f000c3a9660134a86f713dc23f7ec79
[PATCH] Include quirks from Ubuntu Dapper/Edgy/Feisty

Included is a patch against current alsa-kernel hg tip adding
quirks that Ubuntu Dapper/Edgy/Feisty contains.

Signed-off-by: Daniel T Chen <crimsun@ubuntu.com>


diff -r 38fe50050f00 -r f38d824e5df6 pci/ac97/ac97_patch.c
--- a/pci/ac97/ac97_patch.c	Mon May 14 18:40:07 2007 +0200
+++ b/pci/ac97/ac97_patch.c	Tue May 15 04:56:48 2007 -0400
@@ -1782,6 +1782,11 @@ static unsigned int ad1981_jacks_blackli
 	0x10140534, /* Thinkpad X31 */
 	0x10140537, /* Thinkpad T41p */
 	0x10140554, /* Thinkpad T42p/R50p */
+	0x10140567, /* Thinkpad T43p 2668-G7U */
+	0x10140581, /* Thinkpad X41-2527 */
+	0x104380b0, /* Asus A7V8X-MX */
+	0x11790241, /* Toshiba Satellite A-15 S127 */
+	0x144dc01a, /* Samsung NP-X20C004/SEG */
 	0 /* end */
 };
=20
diff -r 38fe50050f00 -r f38d824e5df6 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Mon May 14 18:40:07 2007 +0200
+++ b/pci/hda/patch_sigmatel.c	Tue May 15 04:56:48 2007 -0400
@@ -467,6 +467,8 @@ static struct snd_pci_quirk stac9200_cfg
 		      "Dell XPS M1710", STAC_REF),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01cf,
 		      "Dell Precision M90", STAC_REF),
+	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01d6,
+		      "unknown Dell", STAC_REF),
 	{} /* terminator */
 };
=20
diff -r 38fe50050f00 -r f38d824e5df6 pci/intel8x0.c
--- a/pci/intel8x0.c	Mon May 14 18:40:07 2007 +0200
+++ b/pci/intel8x0.c	Tue May 15 04:56:48 2007 -0400
@@ -1799,6 +1799,18 @@ static struct ac97_quirk ac97_quirks[] _
 	},
 	{
 		.subvendor =3D 0x1028,
+		.subdevice =3D 0x0186,
+		.name =3D "Dell Latitude D810", /* cf. Malone #41015 */
+		.type =3D AC97_TUNE_HP_MUTE_LED
+	},
+	{
+		.subvendor =3D 0x1028,
+		.subdevice =3D 0x0188,
+		.name =3D "Dell Inspiron 6000",
+		.type =3D AC97_TUNE_HP_MUTE_LED /* cf. Malone #41015 */
+	},
+	{
+		.subvendor =3D 0x1028,
 		.subdevice =3D 0x0191,
 		.name =3D "Dell Inspiron 8600",
 		.type =3D AC97_TUNE_HP_ONLY
@@ -1819,7 +1831,7 @@ static struct ac97_quirk ac97_quirks[] _
 		.subvendor =3D 0x103c,
 		.subdevice =3D 0x088c,
 		.name =3D "HP nc8000",
-		.type =3D AC97_TUNE_MUTE_LED
+		.type =3D AC97_TUNE_HP_MUTE_LED
 	},
 	{
 		.subvendor =3D 0x103c,
@@ -1909,6 +1921,12 @@ static struct ac97_quirk ac97_quirks[] _
 		.subvendor =3D 0x10cf,
 		.subdevice =3D 0x1253,
 		.name =3D "Fujitsu S6210",	/* STAC9750/51 */
+		.type =3D AC97_TUNE_HP_ONLY
+	},
+	{
+		.subvendor =3D 0x10cf,
+		.subdevice =3D 0x127e,
+		.name =3D "Fujitsu Lifebook C1211D",
 		.type =3D AC97_TUNE_HP_ONLY
 	},
 	{

--=20
Daniel T. Chen            crimsun@ubuntu.com
GPG key:  0xC88ABDA3

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGSXdoe9GwFciKvaMRAoOLAJwNsAraX0H5ORHhEzFIQlFT6jrQDQCfY6Ar
Zj/jzIzXw0/afOSkSJ8Eyes=
=EDOK
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

--===============7052746320054730317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7052746320054730317==--
