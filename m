From: Kailang <kailang@realtek.com>
Subject: Add support of alc667 and more codec rename
Date: Fri, 6 Jun 2014 17:15:42 +0800
Message-ID: <16A8E24BB57F47858B07548277F039D6@realtek.com.tw>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_00B7_01CF81AA.F2728A90"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C419265206
 for <alsa-devel@alsa-project.org>; Fri,  6 Jun 2014 11:15:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kailang <kailang@realtek.com>, Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

------=_NextPart_000_00B7_01CF81AA.F2728A90
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hi Takashi,

Attach has 3 patches. 
Many Thanks.
 
BR,
Kailang
------=_NextPart_000_00B7_01CF81AA.F2728A90
Content-Type: application/octet-stream;
	name="0000-new-vendor-id-for-alc233.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0000-new-vendor-id-for-alc233.patch"

>From a5de17ee450e1df6e5c67051dde712b685d487c0 Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Fri, 6 Jun 2014 17:05:33 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - New vendor ID for ALC233=0A=
=0A=
This is compatible with ALC255.=0A=
It is use for Lenovo.=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index 2d698c0..e097e80 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -6225,6 +6225,7 @@ static const struct hda_codec_preset =
snd_hda_preset_realtek[] =3D {=0A=
 	{ .id =3D 0x10ec0221, .name =3D "ALC221", .patch =3D patch_alc269 },=0A=
 	{ .id =3D 0x10ec0231, .name =3D "ALC231", .patch =3D patch_alc269 },=0A=
 	{ .id =3D 0x10ec0233, .name =3D "ALC233", .patch =3D patch_alc269 },=0A=
+	{ .id =3D 0x10ec0235, .name =3D "ALC233", .patch =3D patch_alc269 },=0A=
 	{ .id =3D 0x10ec0255, .name =3D "ALC255", .patch =3D patch_alc269 },=0A=
 	{ .id =3D 0x10ec0260, .name =3D "ALC260", .patch =3D patch_alc260 },=0A=
 	{ .id =3D 0x10ec0262, .name =3D "ALC262", .patch =3D patch_alc262 },=0A=

------=_NextPart_000_00B7_01CF81AA.F2728A90
Content-Type: application/octet-stream;
	name="0000-add-more-codec-rename.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="0000-add-more-codec-rename.patch"

>From 3372fe0d56b2ee4841f7a113b11f2d3dedda1e75 Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Fri, 6 Jun 2014 16:46:43 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Add more codec rename=0A=
=0A=
Some vendor has special bonding options.=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index 2d698c0..8a00bc4 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -929,6 +929,7 @@ struct alc_codec_rename_pci_table {=0A=
 };=0A=
 =0A=
 static struct alc_codec_rename_table rename_tbl[] =3D {=0A=
+	{ 0x10ec0221, 0xf00f, 0x1003, "ALC231" },=0A=
 	{ 0x10ec0269, 0xfff0, 0x3010, "ALC277" },=0A=
 	{ 0x10ec0269, 0xf0f0, 0x2010, "ALC259" },=0A=
 	{ 0x10ec0269, 0xf0f0, 0x3010, "ALC258" },=0A=
@@ -937,6 +938,7 @@ static struct alc_codec_rename_table rename_tbl[] =
=3D {=0A=
 	{ 0x10ec0269, 0xffff, 0x6023, "ALC281X" },=0A=
 	{ 0x10ec0269, 0x00f0, 0x0020, "ALC269VC" },=0A=
 	{ 0x10ec0269, 0x00f0, 0x0030, "ALC269VD" },=0A=
+	{ 0x10ec0662, 0xffff, 0x4020, "ALC656" },=0A=
 	{ 0x10ec0887, 0x00f0, 0x0030, "ALC887-VD" },=0A=
 	{ 0x10ec0888, 0x00f0, 0x0030, "ALC888-VD" },=0A=
 	{ 0x10ec0888, 0xf0f0, 0x3020, "ALC886" },=0A=
@@ -956,6 +958,19 @@ static struct alc_codec_rename_pci_table =
rename_pci_tbl[] =3D {=0A=
 	{ 0x10ec0293, 0x1028, 0, "ALC3235" },=0A=
 	{ 0x10ec0255, 0x1028, 0, "ALC3234" },=0A=
 	{ 0x10ec0668, 0x1028, 0, "ALC3661" },=0A=
+	{ 0x10ec0275, 0x1028, 0, "ALC3260" },=0A=
+	{ 0x10ec0899, 0x1028, 0, "ALC3861" },=0A=
+	{ 0x10ec0670, 0x1025, 0, "ALC669X" },=0A=
+	{ 0x10ec0676, 0x1025, 0, "ALC679X" },=0A=
+	{ 0x10ec0282, 0x1043, 0, "ALC3229" },=0A=
+	{ 0x10ec0233, 0x1043, 0, "ALC3236" },=0A=
+	{ 0x10ec0280, 0x103c, 0, "ALC3228" },=0A=
+	{ 0x10ec0282, 0x103c, 0, "ALC3227" },=0A=
+	{ 0x10ec0286, 0x103c, 0, "ALC3242" },=0A=
+	{ 0x10ec0290, 0x103c, 0, "ALC3241" },=0A=
+	{ 0x10ec0668, 0x103c, 0, "ALC3662" },=0A=
+	{ 0x10ec0283, 0x17aa, 0, "ALC3239" },=0A=
+	{ 0x10ec0292, 0x17aa, 0, "ALC3232" },=0A=
 	{ } /* terminator */=0A=
 };=0A=
 =0A=

------=_NextPart_000_00B7_01CF81AA.F2728A90
Content-Type: application/octet-stream;
	name="0000-add-support-of-alc667.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="0000-add-support-of-alc667.patch"

>From eab0c002e92cf3d6999c1bcb4f49013a32bee615 Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Fri, 6 Jun 2014 16:51:18 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Add support of ALC667 codec=0A=
=0A=
New codec suooprt of ALC667.=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index 2d698c0..c3f10c5 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -6258,6 +6258,7 @@ static const struct hda_codec_preset =
snd_hda_preset_realtek[] =3D {=0A=
 	  .patch =3D patch_alc662 },=0A=
 	{ .id =3D 0x10ec0663, .name =3D "ALC663", .patch =3D patch_alc662 },=0A=
 	{ .id =3D 0x10ec0665, .name =3D "ALC665", .patch =3D patch_alc662 },=0A=
+	{ .id =3D 0x10ec0667, .name =3D "ALC667", .patch =3D patch_alc662 },=0A=
 	{ .id =3D 0x10ec0668, .name =3D "ALC668", .patch =3D patch_alc662 },=0A=
 	{ .id =3D 0x10ec0670, .name =3D "ALC670", .patch =3D patch_alc662 },=0A=
 	{ .id =3D 0x10ec0671, .name =3D "ALC671", .patch =3D patch_alc662 },=0A=

------=_NextPart_000_00B7_01CF81AA.F2728A90
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_00B7_01CF81AA.F2728A90--
