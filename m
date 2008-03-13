From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: [PATCH] Fix ALC662 DAC mixer mutes
Date: Thu, 13 Mar 2008 16:19:54 -0300
Message-ID: <200803131619.55113.herton@mandriva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perninha.conectiva.com.br (perninha.conectiva.com.br
	[200.140.247.100])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DD48103874
	for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2008 20:19:58 +0100 (CET)
Content-Disposition: inline
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
Cc: Claudio Matsuoka <cmatsuoka@gmail.com>, Ferry Toth <ftoth@exalondelft.nl>
List-Id: alsa-devel@alsa-project.org

Currently ALC662 doesn't suport amp mute for AmpOut in nids 0x02, 0x03,
0x04 (see block diagram in ALC662 datasheet page 3, does M correspond to
mute?). The result is that currently mute for "Front Playback Switch",
"Surround Playback Switch", "Center Playback Switch" and "LFE Playback
Switch" mixer items doesn't work (tested on Asus P5GC-MX motherboard
with 3stack-6ch model).

The solution I found for this is to mute the proper inputs in 0x0c,
0x0d, 0x0e audio mixers.

Signed-off-by: Herton Ronaldo Krzesinski <herton@mandriva.com>

diff -p -up linux-2.6.24/sound/pci/hda/patch_realtek.c.orig linux-2.6.24/sound/pci/hda/patch_realtek.c
--- linux-2.6.24/sound/pci/hda/patch_realtek.c.orig	2008-03-11 13:45:07.000000000 -0300
+++ linux-2.6.24/sound/pci/hda/patch_realtek.c	2008-03-11 14:01:57.000000000 -0300
@@ -13004,13 +13004,13 @@ static struct hda_channel_mode alc662_5s
 static struct snd_kcontrol_new alc662_base_mixer[] = {
 	/* output mixer control */
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x2, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Front Playback Switch", 0x02, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Front Playback Switch", 0x0c, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Surround Playback Volume", 0x3, 0x0, HDA_OUTPUT),
-	HDA_CODEC_MUTE("Surround Playback Switch", 0x03, 0x0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Surround Playback Switch", 0x0d, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x04, 1, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x04, 2, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x04, 1, 2, HDA_INPUT),
-	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x04, 2, 2, HDA_INPUT),
+	HDA_CODEC_MUTE_MONO("Center Playback Switch", 0x0e, 1, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE_MONO("LFE Playback Switch", 0x0e, 2, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x1b, 0x0, HDA_OUTPUT),
 
 	/*Input mixer control */
@@ -13027,7 +13027,7 @@ static struct snd_kcontrol_new alc662_ba
 
 static struct snd_kcontrol_new alc662_3ST_2ch_mixer[] = {
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x02, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE("Front Playback Switch", 0x02, 2, HDA_INPUT),
+	HDA_CODEC_MUTE("Front Playback Switch", 0x0c, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x1b, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),
@@ -13044,13 +13044,13 @@ static struct snd_kcontrol_new alc662_3S
 
 static struct snd_kcontrol_new alc662_3ST_6ch_mixer[] = {
 	HDA_CODEC_VOLUME("Front Playback Volume", 0x02, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE("Front Playback Switch", 0x02, 2, HDA_INPUT),
+	HDA_CODEC_MUTE("Front Playback Switch", 0x0c, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Surround Playback Volume", 0x03, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE("Surround Playback Switch", 0x03, 2, HDA_INPUT),
+	HDA_CODEC_MUTE("Surround Playback Switch", 0x0d, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME_MONO("Center Playback Volume", 0x04, 1, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME_MONO("LFE Playback Volume", 0x04, 2, 0x0, HDA_OUTPUT),
-	HDA_BIND_MUTE_MONO("Center Playback Switch", 0x04, 1, 2, HDA_INPUT),
-	HDA_BIND_MUTE_MONO("LFE Playback Switch", 0x04, 2, 2, HDA_INPUT),
+	HDA_CODEC_MUTE_MONO("Center Playback Switch", 0x0e, 1, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE_MONO("LFE Playback Switch", 0x0e, 2, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("Headphone Playback Switch", 0x1b, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x0b, 0x04, HDA_INPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x0b, 0x04, HDA_INPUT),


-- 
[]'s
Herton
