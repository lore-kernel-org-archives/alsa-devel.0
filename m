From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 3/3] ALSA: HDA: Rename "e-Mic" and "i-Mic" to
 "Mic" and "Internal Mic"
Date: Mon, 20 Dec 2010 14:57:14 +0100
Message-ID: <4D0F60BA.9040803@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010506000707060102030300"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 54E6A10389D
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 14:57:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010506000707060102030300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------010506000707060102030300
Content-Type: text/x-patch;
 name="0003-ALSA-HDA-Rename-e-Mic-and-i-Mic-to-Mic-and-Internal-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0003-ALSA-HDA-Rename-e-Mic-and-i-Mic-to-Mic-and-Internal-.pa";
 filename*1="tch"

>From cb93b812dd22afd6c23a094200730e7cefc6acdc Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Mon, 20 Dec 2010 14:50:59 +0100
Subject: [PATCH 3/3] ALSA: HDA: Rename "e-Mic" and "i-Mic" to "Mic" and "Internal Mic"

Change non-standard mic control names to standard control names
to clean up the namespace.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 08c3d95..91fc2a4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -17533,13 +17533,13 @@ static struct snd_kcontrol_new alc662_eeepc_p701_mixer[] = {
 	HDA_CODEC_VOLUME("Master Playback Volume", 0x02, 0x0, HDA_OUTPUT),
 	ALC262_HIPPO_MASTER_SWITCH,
 
-	HDA_CODEC_VOLUME("e-Mic Boost", 0x18, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("e-Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("e-Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
 
-	HDA_CODEC_VOLUME("i-Mic Boost", 0x19, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("i-Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_MUTE("i-Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -17683,8 +17683,8 @@ static struct snd_kcontrol_new alc663_g71v_mixer[] = {
 
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("i-Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_MUTE("i-Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
 
@@ -17695,8 +17695,8 @@ static struct snd_kcontrol_new alc663_g50v_mixer[] = {
 
 	HDA_CODEC_VOLUME("Mic Playback Volume", 0x0b, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Mic Playback Switch", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("i-Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_MUTE("i-Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	HDA_CODEC_VOLUME("Line Playback Volume", 0x0b, 0x02, HDA_INPUT),
 	HDA_CODEC_MUTE("Line Playback Switch", 0x0b, 0x02, HDA_INPUT),
 	{ } /* end */
@@ -18529,13 +18529,13 @@ static struct snd_kcontrol_new alc662_ecs_mixer[] = {
 	HDA_CODEC_VOLUME("Master Playback Volume", 0x02, 0x0, HDA_OUTPUT),
 	ALC262_HIPPO_MASTER_SWITCH,
 
-	HDA_CODEC_VOLUME("e-Mic/LineIn Boost", 0x18, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("e-Mic/LineIn Playback Volume", 0x0b, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("e-Mic/LineIn Playback Switch", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic/LineIn Boost", 0x18, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Mic/LineIn Playback Volume", 0x0b, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic/LineIn Playback Switch", 0x0b, 0x0, HDA_INPUT),
 
-	HDA_CODEC_VOLUME("i-Mic Boost", 0x19, 0, HDA_INPUT),
-	HDA_CODEC_VOLUME("i-Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
-	HDA_CODEC_MUTE("i-Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Boost", 0x19, 0, HDA_INPUT),
+	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x0b, 0x1, HDA_INPUT),
+	HDA_CODEC_MUTE("Internal Mic Playback Switch", 0x0b, 0x1, HDA_INPUT),
 	{ } /* end */
 };
 
-- 
1.7.1


--------------010506000707060102030300
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010506000707060102030300--
