From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Subject: [PATCH 3/6] sound/pci/hda: fix record volume controls of CX20459
 ("Venice")
Date: Thu, 05 Apr 2012 15:30:16 +0200
Message-ID: <1333632616.4159.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

The "input converter" widget of the CX20459 has only one input amplifier,
expose that one as "Capture Volume/Capture Switch". The actual record
source selection is already exposed through the separately installed
input mux.

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 7d92aac..bd7e7ce 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -798,10 +798,8 @@ static void cxt5045_hp_unsol_event(struct hda_codec *codec,
 }
 
 static const struct snd_kcontrol_new cxt5045_mixers[] = {
-	HDA_CODEC_VOLUME("Internal Mic Capture Volume", 0x1a, 0x01, HDA_INPUT),
-	HDA_CODEC_MUTE("Internal Mic Capture Switch", 0x1a, 0x01, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Capture Volume", 0x1a, 0x02, HDA_INPUT),
-	HDA_CODEC_MUTE("Mic Capture Switch", 0x1a, 0x02, HDA_INPUT),
+	HDA_CODEC_VOLUME("Capture Volume", 0x1a, 0x00, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x1a, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("PCM Playback Volume", 0x17, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("PCM Playback Switch", 0x17, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x17, 0x1, HDA_INPUT),
@@ -822,27 +820,18 @@ static const struct snd_kcontrol_new cxt5045_mixers[] = {
 };
 
 static const struct snd_kcontrol_new cxt5045_benq_mixers[] = {
-	HDA_CODEC_VOLUME("CD Capture Volume", 0x1a, 0x04, HDA_INPUT),
-	HDA_CODEC_MUTE("CD Capture Switch", 0x1a, 0x04, HDA_INPUT),
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x17, 0x4, HDA_INPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x17, 0x4, HDA_INPUT),
 
-	HDA_CODEC_VOLUME("Line In Capture Volume", 0x1a, 0x03, HDA_INPUT),
-	HDA_CODEC_MUTE("Line In Capture Switch", 0x1a, 0x03, HDA_INPUT),
 	HDA_CODEC_VOLUME("Line In Playback Volume", 0x17, 0x3, HDA_INPUT),
 	HDA_CODEC_MUTE("Line In Playback Switch", 0x17, 0x3, HDA_INPUT),
 
-	HDA_CODEC_VOLUME("Mixer Capture Volume", 0x1a, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Mixer Capture Switch", 0x1a, 0x0, HDA_INPUT),
-
 	{}
 };
 
 static const struct snd_kcontrol_new cxt5045_mixers_hp530[] = {
-	HDA_CODEC_VOLUME("Internal Mic Capture Volume", 0x1a, 0x02, HDA_INPUT),
-	HDA_CODEC_MUTE("Internal Mic Capture Switch", 0x1a, 0x02, HDA_INPUT),
-	HDA_CODEC_VOLUME("Mic Capture Volume", 0x1a, 0x01, HDA_INPUT),
-	HDA_CODEC_MUTE("Mic Capture Switch", 0x1a, 0x01, HDA_INPUT),
+	HDA_CODEC_VOLUME("Capture Volume", 0x1a, 0x00, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x1a, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("PCM Playback Volume", 0x17, 0x0, HDA_INPUT),
 	HDA_CODEC_MUTE("PCM Playback Switch", 0x17, 0x0, HDA_INPUT),
 	HDA_CODEC_VOLUME("Internal Mic Playback Volume", 0x17, 0x2, HDA_INPUT),
@@ -978,16 +967,8 @@ static const struct snd_kcontrol_new cxt5045_test_mixer[] = {
 		.put = conexant_mux_enum_put,
 	},
 	/* Audio input controls */
-	HDA_CODEC_VOLUME("Input-1 Volume", 0x1a, 0x0, HDA_INPUT),
-	HDA_CODEC_MUTE("Input-1 Switch", 0x1a, 0x0, HDA_INPUT),
-	HDA_CODEC_VOLUME("Input-2 Volume", 0x1a, 0x1, HDA_INPUT),
-	HDA_CODEC_MUTE("Input-2 Switch", 0x1a, 0x1, HDA_INPUT),
-	HDA_CODEC_VOLUME("Input-3 Volume", 0x1a, 0x2, HDA_INPUT),
-	HDA_CODEC_MUTE("Input-3 Switch", 0x1a, 0x2, HDA_INPUT),
-	HDA_CODEC_VOLUME("Input-4 Volume", 0x1a, 0x3, HDA_INPUT),
-	HDA_CODEC_MUTE("Input-4 Switch", 0x1a, 0x3, HDA_INPUT),
-	HDA_CODEC_VOLUME("Input-5 Volume", 0x1a, 0x4, HDA_INPUT),
-	HDA_CODEC_MUTE("Input-5 Switch", 0x1a, 0x4, HDA_INPUT),
+	HDA_CODEC_VOLUME("Capture Volume", 0x1a, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x1a, 0x0, HDA_INPUT),
 	{ } /* end */
 };
 
-- 
1.7.9.1
