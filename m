From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Subject: [PATCH 4/6] sound/pci/hda: Remove CD control from model=benq for
 CX20549
Date: Thu, 05 Apr 2012 15:30:25 +0200
Message-ID: <1333632625.4159.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

The ID used for detection of the BenQ R55E actually identifies the
Quana TW3 ODM design, which is also used for the Gigabyte W551 laptop
series. Schematics on the internet clearly indicate that the "Port C"
(analog input connected to record source #4 and mixer input #4) is
unconnected.

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index bd7e7ce..8d7a977 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -695,7 +695,6 @@ static const struct hda_input_mux cxt5045_capture_source = {
 static const struct hda_input_mux cxt5045_capture_source_benq = {
 	.num_items = 5,
 	.items = {
-		{ "CD",     0x4 },
 		{ "Internal Mic", 0x1 },
 		{ "Mic", 0x2 },
 		{ "Line In", 0x3 },
@@ -820,9 +819,6 @@ static const struct snd_kcontrol_new cxt5045_mixers[] = {
 };
 
 static const struct snd_kcontrol_new cxt5045_benq_mixers[] = {
-	HDA_CODEC_VOLUME("CD Playback Volume", 0x17, 0x4, HDA_INPUT),
-	HDA_CODEC_MUTE("CD Playback Switch", 0x17, 0x4, HDA_INPUT),
-
 	HDA_CODEC_VOLUME("Line In Playback Volume", 0x17, 0x3, HDA_INPUT),
 	HDA_CODEC_MUTE("Line In Playback Switch", 0x17, 0x3, HDA_INPUT),
 
-- 
1.7.9.1
