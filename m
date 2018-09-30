From: Connor McAdams <conmanx360@gmail.com>
Subject: [PATCH 02/11] ALSA: hda/ca0132 - Fix surround sound with output effects
Date: Sat, 29 Sep 2018 23:03:17 -0400
Message-ID: <1538276607-30234-3-git-send-email-conmanx360@gmail.com>
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Alastair Bridgewater <alastair.bridgewater@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch fixes an issue where if surround sound was the selected
output and output effects were enabled, the sound wasn't sent to all
channels correctly.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index aebc592..5a3fb56 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4125,6 +4125,7 @@ static int ca0132_select_out(struct hda_codec *codec)
 }
 
 static int ae5_headphone_gain_set(struct hda_codec *codec, long val);
+static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val);
 
 static void ae5_mmio_select_out(struct hda_codec *codec)
 {
@@ -4365,12 +4366,19 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 		snd_hda_set_pin_ctl(codec, spec->out_pins[3],
 				    pin_ctl | PIN_OUT);
 
-		if (spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID])
-			dspio_set_uint_param(codec, 0x80, 0x04, FLOAT_ONE);
-		else
-			dspio_set_uint_param(codec, 0x80, 0x04, FLOAT_EIGHT);
+		dspio_set_uint_param(codec, 0x80, 0x04, FLOAT_EIGHT);
 		break;
 	}
+	/*
+	 * Surround always sets it's scp command to req 0x04 to FLOAT_EIGHT.
+	 * With this set though, X_BASS cannot be enabled. So, if we have OutFX
+	 * enabled, we need to make sure X_BASS is off, otherwise everything
+	 * sounds all muffled. Running ca0132_effects_set with X_BASS as the
+	 * effect should sort this out.
+	 */
+	if (spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID])
+		ca0132_effects_set(codec, X_BASS,
+			spec->effects_switch[X_BASS - EFFECT_START_NID]);
 
 	/* run through the output dsp commands for the selected output. */
 	for (i = 0; i < alt_out_presets[spec->cur_out_type].commands; i++) {
@@ -4409,7 +4417,6 @@ static void ca0132_unsol_hp_delayed(struct work_struct *work)
 
 static void ca0132_set_dmic(struct hda_codec *codec, int enable);
 static int ca0132_mic_boost_set(struct hda_codec *codec, long val);
-static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val);
 static void resume_mic1(struct hda_codec *codec, unsigned int oldval);
 static int stop_mic1(struct hda_codec *codec);
 static int ca0132_cvoice_switch_set(struct hda_codec *codec);
@@ -4787,6 +4794,8 @@ static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val)
 		/* if PE if off, turn off out effects. */
 		if (!spec->effects_switch[PLAY_ENHANCEMENT - EFFECT_START_NID])
 			val = 0;
+		if (spec->cur_out_type == SURROUND_OUT && nid == X_BASS)
+			val = 0;
 	}
 
 	/* for in effect, qualify with CrystalVoice */
-- 
2.7.4
