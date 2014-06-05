From: Kailang <kailang@realtek.com>
Subject: New codec support for ALC891
Date: Thu, 5 Jun 2014 14:46:54 +0800
Message-ID: <DC6D34B8EAA84097AD36C9CEABEA5BC0@realtek.com.tw>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_001F_01CF80CC.FE73A830"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 661102652AA
 for <alsa-devel@alsa-project.org>; Thu,  5 Jun 2014 08:47:10 +0200 (CEST)
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

------=_NextPart_000_001F_01CF80CC.FE73A830
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit

 Hi Takashi,

We have a new codec ALC891.
The support  patch  as attach.
 
 Many Thanks.
 
 BR,
Kailang
------=_NextPart_000_001F_01CF80CC.FE73A830
Content-Type: application/octet-stream;
	name="0000-add-support-of-alc891.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="0000-add-support-of-alc891.patch"

>From e882787c358cea3a4e53649f408da45392fc4b0a Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Thu, 5 Jun 2014 11:13:44 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Add support of ALC891 codec=0A=
=0A=
New codec support for ALC891.=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index 12fb411..246826f 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -6227,6 +6227,7 @@ static const struct hda_codec_preset =
snd_hda_preset_realtek[] =3D {=0A=
 	{ .id =3D 0x10ec0670, .name =3D "ALC670", .patch =3D patch_alc662 },=0A=
 	{ .id =3D 0x10ec0671, .name =3D "ALC671", .patch =3D patch_alc662 },=0A=
 	{ .id =3D 0x10ec0680, .name =3D "ALC680", .patch =3D patch_alc680 },=0A=
+	{ .id =3D 0x10ec0867, .name =3D "ALC891", .patch =3D patch_alc882 },=0A=
 	{ .id =3D 0x10ec0880, .name =3D "ALC880", .patch =3D patch_alc880 },=0A=
 	{ .id =3D 0x10ec0882, .name =3D "ALC882", .patch =3D patch_alc882 },=0A=
 	{ .id =3D 0x10ec0883, .name =3D "ALC883", .patch =3D patch_alc882 },=0A=

------=_NextPart_000_001F_01CF80CC.FE73A830
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_001F_01CF80CC.FE73A830--
