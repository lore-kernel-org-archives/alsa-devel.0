From: Kailang <kailang@realtek.com>
Subject: move alc892 to patch_alc882
Date: Thu, 27 Mar 2014 17:47:11 +0800
Message-ID: <2259125E6B6048C7B3DB0DD2F5BBD60D@realtek.com.tw>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_008A_01CF49E4.950975B0"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id D7B41261717
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 10:47:15 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_NextPart_000_008A_01CF49E4.950975B0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

Hi Takashi,
 
The original was patch to patch_alc662.
Move it into patch_alc882.

Thanks.
 
 BR,
Kailang
------=_NextPart_000_008A_01CF49E4.950975B0
Content-Type: application/octet-stream;
	name="0000-move-alc892-to-patch_alc882.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0000-move-alc892-to-patch_alc882.patch"

>From 4f59a160db58ab7cbc090ba1d6a80cdc8ac18168 Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Thu, 27 Mar 2014 17:40:24 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Move ALC892 to patch_alc882 entry=0A=
=0A=
The old was entry to patch_alc662.=0A=
Move it into patch_alc882.=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index af5f903..b074d75 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -5796,7 +5796,7 @@ static const struct hda_codec_preset =
snd_hda_preset_realtek[] =3D {=0A=
 	  .patch =3D patch_alc882 },=0A=
 	{ .id =3D 0x10ec0888, .name =3D "ALC888", .patch =3D patch_alc882 },=0A=
 	{ .id =3D 0x10ec0889, .name =3D "ALC889", .patch =3D patch_alc882 },=0A=
-	{ .id =3D 0x10ec0892, .name =3D "ALC892", .patch =3D patch_alc662 },=0A=
+	{ .id =3D 0x10ec0892, .name =3D "ALC892", .patch =3D patch_alc882 },=0A=
 	{ .id =3D 0x10ec0899, .name =3D "ALC898", .patch =3D patch_alc882 },=0A=
 	{ .id =3D 0x10ec0900, .name =3D "ALC1150", .patch =3D patch_alc882 },=0A=
 	{} /* terminator */=0A=

------=_NextPart_000_008A_01CF49E4.950975B0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_008A_01CF49E4.950975B0--
