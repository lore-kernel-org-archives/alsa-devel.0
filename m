From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH] ASoC: da7219: Improve pop/click performance for sensitive HPs
Date: Mon, 3 Oct 2016 11:21:01 +0100
Message-ID: <20161003102101.E58CC3FB92@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Xing Zheng <zhengxing@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

Currently on some headsets slight pops can be heard during DAPM
power-up/down. This can also be witnessed during the HP detect
procedure. This patch addresses the issue by adjusting DAPM power
sequencing slightly, the introduction of delays and use of
minimum HP gain to avoid such noise artefacts.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---

Changes are based on top of commit:

ASoC: da7219: Disable AAD if codec is not a wake-up source

 sound/soc/codecs/da7219-aad.c |  18 ++++--
 sound/soc/codecs/da7219.c     | 139 ++++++++++++++++++++++++++++++++++++------
 sound/soc/codecs/da7219.h     |   5 ++
 3 files changed, 140 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 2b8914d..6274d79 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -204,10 +204,19 @@ static void da7219_aad_hptest_work(struct work_struct *work)
 	snd_soc_update_bits(codec, DA7219_MIXOUT_R_CTRL,
 			    DA7219_MIXOUT_R_AMP_EN_MASK,
 			    DA7219_MIXOUT_R_AMP_EN_MASK);
-	snd_soc_write(codec, DA7219_HP_L_CTRL,
-		      DA7219_HP_L_AMP_OE_MASK | DA7219_HP_L_AMP_EN_MASK);
-	snd_soc_write(codec, DA7219_HP_R_CTRL,
-		      DA7219_HP_R_AMP_OE_MASK | DA7219_HP_R_AMP_EN_MASK);
+	snd_soc_update_bits(codec, DA7219_HP_L_CTRL,
+			    DA7219_HP_L_AMP_OE_MASK | DA7219_HP_L_AMP_EN_MASK,
+			    DA7219_HP_L_AMP_OE_MASK | DA7219_HP_L_AMP_EN_MASK);
+	snd_soc_update_bits(codec, DA7219_HP_R_CTRL,
+			    DA7219_HP_R_AMP_OE_MASK | DA7219_HP_R_AMP_EN_MASK,
+			    DA7219_HP_R_AMP_OE_MASK | DA7219_HP_R_AMP_EN_MASK);
+	msleep(DA7219_SETTLING_DELAY);
+	snd_soc_update_bits(codec, DA7219_HP_L_CTRL,
+			    DA7219_HP_L_AMP_MUTE_EN_MASK |
+			    DA7219_HP_L_AMP_MIN_GAIN_EN_MASK, 0);
+	snd_soc_update_bits(codec, DA7219_HP_R_CTRL,
+			    DA7219_HP_R_AMP_MUTE_EN_MASK |
+			    DA7219_HP_R_AMP_MIN_GAIN_EN_MASK, 0);

 	/*
 	 * If we're running from the internal oscillator then give audio paths
@@ -244,6 +253,7 @@ static void da7219_aad_hptest_work(struct work_struct *work)
 	regcache_mark_dirty(da7219->regmap);
 	regcache_sync_region(da7219->regmap, DA7219_HP_L_CTRL,
 			     DA7219_HP_R_CTRL);
+	msleep(DA7219_SETTLING_DELAY);
 	regcache_sync_region(da7219->regmap, DA7219_MIXOUT_L_CTRL,
 			     DA7219_MIXOUT_R_CTRL);
 	regcache_sync_region(da7219->regmap, DA7219_DROUTING_ST_OUTFILT_1L,
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 65f7e98..7c26ee3 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -823,6 +823,85 @@ static int da7219_dai_event(struct snd_soc_dapm_widget *w,
 	}
 }

+static int da7219_settling_event(struct snd_soc_dapm_widget *w,
+				 struct snd_kcontrol *kcontrol, int event)
+{
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+	case SND_SOC_DAPM_POST_PMD:
+		msleep(DA7219_SETTLING_DELAY);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int da7219_mixout_event(struct snd_soc_dapm_widget *w,
+			       struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	u8 hp_ctrl, min_gain_mask;
+
+	switch (w->reg) {
+	case DA7219_MIXOUT_L_CTRL:
+		hp_ctrl = DA7219_HP_L_CTRL;
+		min_gain_mask = DA7219_HP_L_AMP_MIN_GAIN_EN_MASK;
+		break;
+	case DA7219_MIXOUT_R_CTRL:
+		hp_ctrl = DA7219_HP_R_CTRL;
+		min_gain_mask = DA7219_HP_R_AMP_MIN_GAIN_EN_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMD:
+		/* Enable minimum gain on HP to avoid pops */
+		snd_soc_update_bits(codec, hp_ctrl, min_gain_mask,
+				    min_gain_mask);
+
+		msleep(DA7219_MIN_GAIN_DELAY);
+
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		/* Remove minimum gain on HP */
+		snd_soc_update_bits(codec, hp_ctrl, min_gain_mask, 0);
+
+		break;
+	}
+
+	return 0;
+}
+
+static int da7219_gain_ramp_event(struct snd_soc_dapm_widget *w,
+				  struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct da7219_priv *da7219 = snd_soc_codec_get_drvdata(codec);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+	case SND_SOC_DAPM_PRE_PMD:
+		/* Ensure nominal gain ramping for DAPM sequence */
+		da7219->gain_ramp_ctrl =
+			snd_soc_read(codec, DA7219_GAIN_RAMP_CTRL);
+		snd_soc_write(codec, DA7219_GAIN_RAMP_CTRL,
+			      DA7219_GAIN_RAMP_RATE_NOMINAL);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+	case SND_SOC_DAPM_POST_PMD:
+		/* Restore previous gain ramp settings */
+		snd_soc_write(codec, DA7219_GAIN_RAMP_CTRL,
+			      da7219->gain_ramp_ctrl);
+		break;
+	}
+
+	return 0;
+}
+

 /*
  * DAPM Widgets
@@ -906,30 +985,46 @@ static const struct snd_soc_dapm_widget da7219_dapm_widgets[] = {
 			   ARRAY_SIZE(da7219_st_out_filtr_mix_controls)),

 	/* DACs */
-	SND_SOC_DAPM_DAC("DACL", NULL, DA7219_DAC_L_CTRL, DA7219_DAC_L_EN_SHIFT,
-			 DA7219_NO_INVERT),
-	SND_SOC_DAPM_DAC("DACR", NULL, DA7219_DAC_R_CTRL, DA7219_DAC_R_EN_SHIFT,
-			 DA7219_NO_INVERT),
+	SND_SOC_DAPM_DAC_E("DACL", NULL, DA7219_DAC_L_CTRL,
+			   DA7219_DAC_L_EN_SHIFT, DA7219_NO_INVERT,
+			   da7219_settling_event,
+			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_DAC_E("DACR", NULL, DA7219_DAC_R_CTRL,
+			   DA7219_DAC_R_EN_SHIFT, DA7219_NO_INVERT,
+			   da7219_settling_event,
+			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),

 	/* Output PGAs */
-	SND_SOC_DAPM_PGA("Mixout Left PGA", DA7219_MIXOUT_L_CTRL,
-			 DA7219_MIXOUT_L_AMP_EN_SHIFT, DA7219_NO_INVERT,
-			 NULL, 0),
-	SND_SOC_DAPM_PGA("Mixout Right PGA", DA7219_MIXOUT_R_CTRL,
-			 DA7219_MIXOUT_R_AMP_EN_SHIFT, DA7219_NO_INVERT,
-			 NULL, 0),
-	SND_SOC_DAPM_PGA("Headphone Left PGA", DA7219_HP_L_CTRL,
-			 DA7219_HP_L_AMP_EN_SHIFT, DA7219_NO_INVERT, NULL, 0),
-	SND_SOC_DAPM_PGA("Headphone Right PGA", DA7219_HP_R_CTRL,
-			 DA7219_HP_R_AMP_EN_SHIFT, DA7219_NO_INVERT, NULL, 0),
+	SND_SOC_DAPM_PGA_E("Mixout Left PGA", DA7219_MIXOUT_L_CTRL,
+			   DA7219_MIXOUT_L_AMP_EN_SHIFT, DA7219_NO_INVERT,
+			   NULL, 0, da7219_mixout_event,
+			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_PGA_E("Mixout Right PGA", DA7219_MIXOUT_R_CTRL,
+			   DA7219_MIXOUT_R_AMP_EN_SHIFT, DA7219_NO_INVERT,
+			   NULL, 0, da7219_mixout_event,
+			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+	SND_SOC_DAPM_SUPPLY_S("Headphone Left PGA", 1, DA7219_HP_L_CTRL,
+			      DA7219_HP_L_AMP_EN_SHIFT, DA7219_NO_INVERT,
+			      da7219_settling_event,
+			      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SUPPLY_S("Headphone Right PGA", 1, DA7219_HP_R_CTRL,
+			      DA7219_HP_R_AMP_EN_SHIFT, DA7219_NO_INVERT,
+			      da7219_settling_event,
+			      SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),

 	/* Output Supplies */
-	SND_SOC_DAPM_SUPPLY("Charge Pump", DA7219_CP_CTRL, DA7219_CP_EN_SHIFT,
-			    DA7219_NO_INVERT, NULL, 0),
+	SND_SOC_DAPM_SUPPLY_S("Charge Pump", 0, DA7219_CP_CTRL,
+			      DA7219_CP_EN_SHIFT, DA7219_NO_INVERT,
+			      da7219_settling_event,
+			      SND_SOC_DAPM_POST_PMU),

 	/* Outputs */
 	SND_SOC_DAPM_OUTPUT("HPL"),
 	SND_SOC_DAPM_OUTPUT("HPR"),
+
+	/* Pre/Post Power */
+	SND_SOC_DAPM_PRE("Pre Power Gain Ramp", da7219_gain_ramp_event),
+	SND_SOC_DAPM_POST("Post Power Gain Ramp", da7219_gain_ramp_event),
 };


@@ -1002,8 +1097,8 @@ static const struct snd_soc_dapm_route da7219_audio_map[] = {
 	{"Mixout Left PGA", NULL, "DACL"},
 	{"Mixout Right PGA", NULL, "DACR"},

-	{"Headphone Left PGA", NULL, "Mixout Left PGA"},
-	{"Headphone Right PGA", NULL, "Mixout Right PGA"},
+	{"HPL", NULL, "Mixout Left PGA"},
+	{"HPR", NULL, "Mixout Right PGA"},

 	{"HPL", NULL, "Headphone Left PGA"},
 	{"HPR", NULL, "Headphone Right PGA"},
@@ -1711,6 +1806,14 @@ static int da7219_probe(struct snd_soc_codec *codec)
 			    DA7219_HP_R_AMP_RAMP_EN_MASK,
 			    DA7219_HP_R_AMP_RAMP_EN_MASK);

+	/* Default minimum gain on HP to avoid pops during DAPM sequencing */
+	snd_soc_update_bits(codec, DA7219_HP_L_CTRL,
+			    DA7219_HP_L_AMP_MIN_GAIN_EN_MASK,
+			    DA7219_HP_L_AMP_MIN_GAIN_EN_MASK);
+	snd_soc_update_bits(codec, DA7219_HP_R_CTRL,
+			    DA7219_HP_R_AMP_MIN_GAIN_EN_MASK,
+			    DA7219_HP_R_AMP_MIN_GAIN_EN_MASK);
+
 	/* Default infinite tone gen, start/stop by Kcontrol */
 	snd_soc_write(codec, DA7219_TONE_GEN_CYCLES, DA7219_BEEP_CYCLES_MASK);

diff --git a/sound/soc/codecs/da7219.h b/sound/soc/codecs/da7219.h
index 66d3bad..6baba74 100644
--- a/sound/soc/codecs/da7219.h
+++ b/sound/soc/codecs/da7219.h
@@ -777,6 +777,10 @@
 #define DA7219_SYS_STAT_CHECK_RETRIES	6
 #define DA7219_SYS_STAT_CHECK_DELAY	50

+/* Power up/down Delays */
+#define DA7219_SETTLING_DELAY	40
+#define DA7219_MIN_GAIN_DELAY	30
+
 enum da7219_clk_src {
 	DA7219_CLKSRC_MCLK = 0,
 	DA7219_CLKSRC_MCLK_SQR,
@@ -814,6 +818,7 @@ struct da7219_priv {

 	bool master;
 	bool alc_en;
+	u8 gain_ramp_ctrl;
 };

 #endif /* __DA7219_H */
--
1.9.3
