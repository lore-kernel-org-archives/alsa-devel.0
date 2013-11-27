From: Kailang <kailang@realtek.com>
Subject: Update patch for codecs alias name for Dell
Date: Wed, 27 Nov 2013 18:01:03 +0800
Message-ID: <8837DB3485424EB4ADE016301C6D7DF6@realtek.com.tw>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_09F0_01CEEB9A.A366FE50"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id EC4EF2625D3
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 11:01:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_NextPart_000_09F0_01CEEB9A.A366FE50
Content-Type: text/plain; format=flowed; charset="big5"; reply-type=original
Content-Transfer-Encoding: 7bit

Hi Takashi,

Dell assigned more codecs for alias name.
I update in attach patch.

Thanks.
Kailang
------=_NextPart_000_09F0_01CEEB9A.A366FE50
Content-Type: application/octet-stream;
	name="0000-add-codecs-alias-name-for-Dell.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0000-add-codecs-alias-name-for-Dell.patch"

>From 520b8cebfd20cda4976ed24fe18bb8bb6bed1809 Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Wed, 27 Nov 2013 17:41:32 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Add codecs alias name for Dell=0A=
=0A=
Dell assigned alias name for more codecs.=0A=
ALC3220 ALC3221 ALC3223 ALC3226 ALC3234 ALC3661.=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index c4ad9d1..3f4a6e6 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -4393,20 +4393,36 @@ static int patch_alc269(struct hda_codec *codec)=0A=
 =0A=
 	case 0x10ec0280:=0A=
 	case 0x10ec0290:=0A=
+		if (codec->bus->pci->subsystem_vendor =3D=3D 0x1028)=0A=
+			err =3D alc_codec_rename(codec, "ALC3220");=0A=
 		spec->codec_variant =3D ALC269_TYPE_ALC280;=0A=
+		if (err < 0)=0A=
+			goto error;=0A=
 		break;=0A=
 	case 0x10ec0282:=0A=
+		if (codec->bus->pci->subsystem_vendor =3D=3D 0x1028)=0A=
+			err =3D alc_codec_rename(codec, "ALC3221");=0A=
 		spec->codec_variant =3D ALC269_TYPE_ALC282;=0A=
+		if (err < 0)=0A=
+			goto error;=0A=
 		break;=0A=
 	case 0x10ec0233:=0A=
 	case 0x10ec0283:=0A=
+		if (codec->bus->pci->subsystem_vendor =3D=3D 0x1028)=0A=
+			err =3D alc_codec_rename(codec, "ALC3223");=0A=
 		spec->codec_variant =3D ALC269_TYPE_ALC283;=0A=
 		spec->shutup =3D alc283_shutup;=0A=
 		spec->init_hook =3D alc283_init;=0A=
+		if (err < 0)=0A=
+			goto error;=0A=
 		break;=0A=
 	case 0x10ec0284:=0A=
 	case 0x10ec0292:=0A=
+		if (codec->bus->pci->subsystem_vendor =3D=3D 0x1028)=0A=
+			err =3D alc_codec_rename(codec, "ALC3226");=0A=
 		spec->codec_variant =3D ALC269_TYPE_ALC284;=0A=
+		if (err < 0)=0A=
+			goto error;=0A=
 		break;=0A=
 	case 0x10ec0285:=0A=
 	case 0x10ec0293:=0A=
@@ -4416,7 +4432,11 @@ static int patch_alc269(struct hda_codec *codec)=0A=
 		spec->codec_variant =3D ALC269_TYPE_ALC286;=0A=
 		break;=0A=
 	case 0x10ec0255:=0A=
+		if (codec->bus->pci->subsystem_vendor =3D=3D 0x1028)=0A=
+			err =3D alc_codec_rename(codec, "ALC3234");=0A=
 		spec->codec_variant =3D ALC269_TYPE_ALC255;=0A=
+		if (err < 0)=0A=
+			goto error;=0A=
 		break;=0A=
 	}=0A=
 =0A=
@@ -5105,6 +5125,13 @@ static int patch_alc662(struct hda_codec *codec)=0A=
 			goto error;=0A=
 	}=0A=
 =0A=
+	if (codec->bus->pci->subsystem_vendor =3D=3D 0x1028 &&=0A=
+			codec->vendor_id =3D=3D 0x10ec0668) {=0A=
+		err =3D alc_codec_rename(codec, "ALC3661");=0A=
+		if (err < 0)=0A=
+			goto error;=0A=
+	}=0A=
+=0A=
 	/* automatic parse from the BIOS config */=0A=
 	err =3D alc662_parse_auto_config(codec);=0A=
 	if (err < 0)=0A=

------=_NextPart_000_09F0_01CEEB9A.A366FE50
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_09F0_01CEEB9A.A366FE50--
