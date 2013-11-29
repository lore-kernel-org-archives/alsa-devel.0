From: Kailang <kailang@realtek.com>
Subject: Remove depop delay for suspend and resume
Date: Fri, 29 Nov 2013 10:48:20 +0800
Message-ID: <F59E396CBAC34485AD04AEDF69643CB9@realtek.com.tw>
Reply-To: Kailang <kailang@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_NextPart_000_0040_01CEECF0.851057B0"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C6172654AA
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 03:48:22 +0100 (CET)
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

------=_NextPart_000_0040_01CEECF0.851057B0
Content-Type: text/plain; format=flowed; charset="big5"; reply-type=original
Content-Transfer-Encoding: 7bit

Hi Takashi,

Intel test alc262.
They find the suspend and resume time were > 50ms.
So, I delete the delay for alc_eapd_shutup and alc_resume.
If we want to have depop functions, we will follow like alc283.

Thanks.
Kailang
------=_NextPart_000_0040_01CEECF0.851057B0
Content-Type: application/octet-stream; name="0000-remove-depop-delay.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="0000-remove-depop-delay.patch"

>From 11a85d67e65326065bc0648f0750fe14925b2a03 Mon Sep 17 00:00:00 2001=0A=
From: Kailang Yang <kailang@realtek.com>=0A=
Date: Thu, 28 Nov 2013 13:55:26 +0800=0A=
Subject: [PATCH] ALSA: hda/realtek - Remove depop delay for suspend and =
resume=0A=
=0A=
Remove common alc_suspend for alc_eapd_shutup and alc_resume delay.=0A=
We could add the depop functions like ALC283.=0A=
=0A=
Signed-off-by: Kailang Yang <kailang@realtek.com>=0A=
=0A=
diff --git a/sound/pci/hda/patch_realtek.c =
b/sound/pci/hda/patch_realtek.c=0A=
index c4ad9d1..fbb32d1 100644=0A=
--- a/sound/pci/hda/patch_realtek.c=0A=
+++ b/sound/pci/hda/patch_realtek.c=0A=
@@ -281,7 +281,6 @@ static void alc_auto_setup_eapd(struct hda_codec =
*codec, bool on)=0A=
 static void alc_eapd_shutup(struct hda_codec *codec)=0A=
 {=0A=
 	alc_auto_setup_eapd(codec, false);=0A=
-	msleep(200);=0A=
 	snd_hda_shutup_pins(codec);=0A=
 }=0A=
 =0A=
@@ -863,7 +862,6 @@ static int alc_suspend(struct hda_codec *codec)=0A=
 #ifdef CONFIG_PM=0A=
 static int alc_resume(struct hda_codec *codec)=0A=
 {=0A=
-	msleep(150); /* to avoid pop noise */=0A=
 	codec->patch_ops.init(codec);=0A=
 	snd_hda_codec_resume_amp(codec);=0A=
 	snd_hda_codec_resume_cache(codec);=0A=

------=_NextPart_000_0040_01CEECF0.851057B0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_0040_01CEECF0.851057B0--
