From: Kailang <kailang@realtek.com>
Subject: Add support of alc288
Date: Mon, 14 Apr 2014 15:21:14 +0800
Message-ID: <956F05DC95C74CA2803F1946D6E4D1C1@realtek.com.tw>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_003B_01CF57F5.2C7C4760"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 513D8260320
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 09:21:24 +0200 (CEST)
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

------=_NextPart_000_003B_01CF57F5.2C7C4760
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hi Takashi,

We have new codec release for ALC288.
Thanks.
 
 BR,
Kailang
------=_NextPart_000_003B_01CF57F5.2C7C4760
Content-Type: application/octet-stream;
	name="0000-add-support-of-alc288.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="0000-add-support-of-alc288.patch"

>From e4cda8487b79172159addefde89700fa0732b9fc Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Mon, 14 Apr 2014 15:09:44 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Add support of ALC288 codec=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index 14ae979..f7766fe 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -4912,6 +4912,7 @@ static int patch_alc269(struct hda_codec *codec)=0A=
 		spec->codec_variant =3D ALC269_TYPE_ALC285;=0A=
 		break;=0A=
 	case 0x10ec0286:=0A=
+	case 0x10ec0288:=0A=
 		spec->codec_variant =3D ALC269_TYPE_ALC286;=0A=
 		break;=0A=
 	case 0x10ec0255:=0A=
@@ -5781,6 +5782,7 @@ static const struct hda_codec_preset =
snd_hda_preset_realtek[] =3D {=0A=
 	{ .id =3D 0x10ec0284, .name =3D "ALC284", .patch =3D patch_alc269 },=0A=
 	{ .id =3D 0x10ec0285, .name =3D "ALC285", .patch =3D patch_alc269 },=0A=
 	{ .id =3D 0x10ec0286, .name =3D "ALC286", .patch =3D patch_alc269 },=0A=
+	{ .id =3D 0x10ec0288, .name =3D "ALC288", .patch =3D patch_alc269 },=0A=
 	{ .id =3D 0x10ec0290, .name =3D "ALC290", .patch =3D patch_alc269 },=0A=
 	{ .id =3D 0x10ec0292, .name =3D "ALC292", .patch =3D patch_alc269 },=0A=
 	{ .id =3D 0x10ec0293, .name =3D "ALC293", .patch =3D patch_alc269 },=0A=

------=_NextPart_000_003B_01CF57F5.2C7C4760
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_003B_01CF57F5.2C7C4760--
