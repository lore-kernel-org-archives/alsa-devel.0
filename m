From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 3/4] ALSA: hda/ca0132 - Add error checking in ca0132_build_controls()
Date: Mon,  8 Oct 2018 15:39:59 -0400
Message-ID: <1539027601-20910-4-git-send-email-conmanx360@gmail.com>
References: <1539027601-20910-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539027601-20910-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds error checking to functions creating controls inside of
ca0132_build_controls().

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 47 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 07d50d6..693b063 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -6365,7 +6365,8 @@ static int ca0132_build_controls(struct hda_codec *codec)
 					    NULL, ca0132_alt_slave_pfxs,
 					    "Playback Switch",
 					    true, &spec->vmaster_mute.sw_kctl);
-
+		if (err < 0)
+			return err;
 	}
 
 	/* Add in and out effects controls.
@@ -6392,8 +6393,14 @@ static int ca0132_build_controls(struct hda_codec *codec)
 	 * prefix, and change PlayEnhancement and CrystalVoice to match.
 	 */
 	if (spec->use_alt_controls) {
-		ca0132_alt_add_svm_enum(codec);
-		add_ca0132_alt_eq_presets(codec);
+		err = ca0132_alt_add_svm_enum(codec);
+		if (err < 0)
+			return err;
+
+		err = add_ca0132_alt_eq_presets(codec);
+		if (err < 0)
+			return err;
+
 		err = add_fx_switch(codec, PLAY_ENHANCEMENT,
 					"Enable OutFX", 0);
 		if (err < 0)
@@ -6430,7 +6437,9 @@ static int ca0132_build_controls(struct hda_codec *codec)
 		if (err < 0)
 			return err;
 	}
-	add_voicefx(codec);
+	err = add_voicefx(codec);
+	if (err < 0)
+		return err;
 
 	/*
 	 * If the codec uses alt_functions, you need the enumerated controls
@@ -6438,23 +6447,37 @@ static int ca0132_build_controls(struct hda_codec *codec)
 	 * setting control.
 	 */
 	if (spec->use_alt_functions) {
-		ca0132_alt_add_output_enum(codec);
-		ca0132_alt_add_mic_boost_enum(codec);
+		err = ca0132_alt_add_output_enum(codec);
+		if (err < 0)
+			return err;
+		err = ca0132_alt_add_mic_boost_enum(codec);
+		if (err < 0)
+			return err;
 		/*
 		 * ZxR only has microphone input, there is no front panel
 		 * header on the card, and aux-in is handled by the DBPro board.
 		 */
-		if (spec->quirk != QUIRK_ZXR)
-			ca0132_alt_add_input_enum(codec);
+		if (spec->quirk != QUIRK_ZXR) {
+			err = ca0132_alt_add_input_enum(codec);
+			if (err < 0)
+				return err;
+		}
 	}
 
 	if (spec->quirk == QUIRK_AE5) {
-		ae5_add_headphone_gain_enum(codec);
-		ae5_add_sound_filter_enum(codec);
+		err = ae5_add_headphone_gain_enum(codec);
+		if (err < 0)
+			return err;
+		err = ae5_add_sound_filter_enum(codec);
+		if (err < 0)
+			return err;
 	}
 
-	if (spec->quirk == QUIRK_ZXR)
-		zxr_add_headphone_gain_switch(codec);
+	if (spec->quirk == QUIRK_ZXR) {
+		err = zxr_add_headphone_gain_switch(codec);
+		if (err < 0)
+			return err;
+	}
 #ifdef ENABLE_TUNING_CONTROLS
 	add_tuning_ctls(codec);
 #endif
-- 
2.7.4
