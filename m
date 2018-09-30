From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 09/11] ALSA: hda/ca0132 - Remove input select enum for ZxR
Date: Sat, 29 Sep 2018 23:03:24 -0400
Message-ID: <1538276607-30234-10-git-send-email-conmanx360@gmail.com>
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch removes the input select control for the ZxR, as it only has
one input option, rear microphone.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index bc8745f..f0781e4 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -6402,8 +6402,13 @@ static int ca0132_build_controls(struct hda_codec *codec)
 	 */
 	if (spec->use_alt_functions) {
 		ca0132_alt_add_output_enum(codec);
-		ca0132_alt_add_input_enum(codec);
 		ca0132_alt_add_mic_boost_enum(codec);
+		/*
+		 * ZxR only has microphone input, there is no front panel
+		 * header on the card, and aux-in is handled by the DBPro board.
+		 */
+		if (spec->quirk != QUIRK_ZXR)
+			ca0132_alt_add_input_enum(codec);
 	}
 
 	if (spec->quirk == QUIRK_AE5) {
@@ -7665,6 +7670,14 @@ static void ca0132_init_chip(struct hda_codec *codec)
 	spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID] = 1;
 	spec->effects_switch[CRYSTAL_VOICE - EFFECT_START_NID] = 0;
 
+	/*
+	 * The ZxR doesn't have a front panel header, and it's line-in is on
+	 * the daughter board. So, there is no input enum control, and we need
+	 * to make sure that spec->in_enum_val is set properly.
+	 */
+	if (spec->quirk == QUIRK_ZXR)
+		spec->in_enum_val = REAR_MIC;
+
 #ifdef ENABLE_TUNING_CONTROLS
 	ca0132_init_tuning_defaults(codec);
 #endif
-- 
2.7.4
