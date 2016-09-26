From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 2/2] ASoC: da7219: Disable AAD if codec is not a wake-up
 source
Date: Mon, 26 Sep 2016 14:29:21 +0100
Message-ID: <3e8afb3b15da512bc7adff946ffdb1320c246498.1474896038.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1474896038.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1474896038.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Xing Zheng <zhengxing@rock-chips.com>, Hsin-Yu Chao <hychao@chromium.org>
List-Id: alsa-devel@alsa-project.org

Currently if AAD is enabled in the device, during system suspend
the feature remains, regardless of whether the codec is a wake-up
source or not. This means some additional power is being used
which is unnecessary, and can causes issues with some platforms'
IRQ handlers where state changes during system suspend aren't
captured.

This patch updates the driver to disable AAD during suspend, if
we're not a wake-up source, and then re-enables this on resume.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 include/sound/da7219.h        |  2 ++
 sound/soc/codecs/da7219-aad.c | 56 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/da7219-aad.h |  5 ++++
 sound/soc/codecs/da7219.c     | 30 +++++++++++++----------
 sound/soc/codecs/da7219.h     |  1 +
 5 files changed, 81 insertions(+), 13 deletions(-)

diff --git a/include/sound/da7219.h b/include/sound/da7219.h
index 02876ac..409ef139 100644
--- a/include/sound/da7219.h
+++ b/include/sound/da7219.h
@@ -34,6 +34,8 @@ enum da7219_mic_amp_in_sel {
 struct da7219_aad_pdata;
 
 struct da7219_pdata {
+	bool wakeup_source;
+
 	/* Mic */
 	enum da7219_micbias_voltage micbias_lvl;
 	enum da7219_mic_amp_in_sel mic_amp_in_sel;
diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index fc27dab..2b8914d 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -797,6 +797,62 @@ static void da7219_aad_handle_pdata(struct snd_soc_codec *codec)
 
 
 /*
+ * Suspend/Resume
+ */
+
+void da7219_aad_suspend(struct snd_soc_codec *codec)
+{
+	struct da7219_priv *da7219 = snd_soc_codec_get_drvdata(codec);
+	struct da7219_aad_priv *da7219_aad = da7219->aad;
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+	u8 micbias_ctrl;
+
+	if (da7219_aad->jack) {
+		/* Disable jack detection during suspend */
+		snd_soc_update_bits(codec, DA7219_ACCDET_CONFIG_1,
+				    DA7219_ACCDET_EN_MASK, 0);
+
+		/*
+		 * If we have a 4-pole jack inserted, then micbias will be
+		 * enabled. We can disable micbias here, and keep a note to
+		 * re-enable it on resume. If jack removal occurred during
+		 * suspend then this will be dealt with through the IRQ handler.
+		 */
+		if (da7219_aad->jack_inserted) {
+			micbias_ctrl = snd_soc_read(codec, DA7219_MICBIAS_CTRL);
+			if (micbias_ctrl & DA7219_MICBIAS1_EN_MASK) {
+				snd_soc_dapm_disable_pin(dapm, "Mic Bias");
+				snd_soc_dapm_sync(dapm);
+				da7219_aad->micbias_resume_enable = true;
+			}
+		}
+	}
+}
+
+void da7219_aad_resume(struct snd_soc_codec *codec)
+{
+	struct da7219_priv *da7219 = snd_soc_codec_get_drvdata(codec);
+	struct da7219_aad_priv *da7219_aad = da7219->aad;
+	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
+
+	if (da7219_aad->jack) {
+		/* Re-enable micbias if previously enabled for 4-pole jack */
+		if (da7219_aad->jack_inserted &&
+		    da7219_aad->micbias_resume_enable) {
+			snd_soc_dapm_force_enable_pin(dapm, "Mic Bias");
+			snd_soc_dapm_sync(dapm);
+			da7219_aad->micbias_resume_enable = false;
+		}
+
+		/* Re-enable jack detection */
+		snd_soc_update_bits(codec, DA7219_ACCDET_CONFIG_1,
+				    DA7219_ACCDET_EN_MASK,
+				    DA7219_ACCDET_EN_MASK);
+	}
+}
+
+
+/*
  * Init/Exit
  */
 
diff --git a/sound/soc/codecs/da7219-aad.h b/sound/soc/codecs/da7219-aad.h
index a34be48..117a3d7 100644
--- a/sound/soc/codecs/da7219-aad.h
+++ b/sound/soc/codecs/da7219-aad.h
@@ -201,12 +201,17 @@ struct da7219_aad_priv {
 	struct work_struct hptest_work;
 
 	struct snd_soc_jack *jack;
+	bool micbias_resume_enable;
 	bool jack_inserted;
 };
 
 /* AAD control */
 void da7219_aad_jack_det(struct snd_soc_codec *codec, struct snd_soc_jack *jack);
 
+/* Suspend/Resume */
+void da7219_aad_suspend(struct snd_soc_codec *codec);
+void da7219_aad_resume(struct snd_soc_codec *codec);
+
 /* Init/Exit */
 int da7219_aad_init(struct snd_soc_codec *codec);
 void da7219_aad_exit(struct snd_soc_codec *codec);
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index eecb6d6..65f7e98 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1482,6 +1482,8 @@ static struct da7219_pdata *da7219_fw_to_pdata(struct snd_soc_codec *codec)
 	if (!pdata)
 		return NULL;
 
+	pdata->wakeup_source = device_property_read_bool(dev, "wakeup-source");
+
 	if (device_property_read_u32(dev, "dlg,micbias-lvl", &of_val32) >= 0)
 		pdata->micbias_lvl = da7219_fw_micbias_lvl(dev, of_val32);
 	else
@@ -1524,20 +1526,21 @@ static int da7219_set_bias_level(struct snd_soc_codec *codec,
 
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF)
 			/* Master bias */
 			snd_soc_update_bits(codec, DA7219_REFERENCES,
 					    DA7219_BIAS_EN_MASK,
 					    DA7219_BIAS_EN_MASK);
-		} else {
+
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_PREPARE) {
 			/* Remove MCLK */
 			if (da7219->mclk)
 				clk_disable_unprepare(da7219->mclk);
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
-		/* Only disable master bias if jack detection not active */
-		if (!da7219->aad->jack)
+		/* Only disable master bias if we're not a wake-up source */
+		if (!da7219->wakeup_source)
 			snd_soc_update_bits(codec, DA7219_REFERENCES,
 					    DA7219_BIAS_EN_MASK, 0);
 
@@ -1603,6 +1606,8 @@ static void da7219_handle_pdata(struct snd_soc_codec *codec)
 	if (pdata) {
 		u8 micbias_lvl = 0;
 
+		da7219->wakeup_source = pdata->wakeup_source;
+
 		/* Mic Bias voltages */
 		switch (pdata->micbias_lvl) {
 		case DA7219_MICBIAS_1_6V:
@@ -1737,11 +1742,11 @@ static int da7219_suspend(struct snd_soc_codec *codec)
 {
 	struct da7219_priv *da7219 = snd_soc_codec_get_drvdata(codec);
 
-	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
+	/* Suspend AAD if we're not a wake-up source */
+	if (!da7219->wakeup_source)
+		da7219_aad_suspend(codec);
 
-	/* Put device into standby mode if jack detection disabled */
-	if (!da7219->aad->jack)
-		snd_soc_write(codec, DA7219_SYSTEM_ACTIVE, 0);
+	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
@@ -1750,13 +1755,12 @@ static int da7219_resume(struct snd_soc_codec *codec)
 {
 	struct da7219_priv *da7219 = snd_soc_codec_get_drvdata(codec);
 
-	/* Put device into active mode if previously pushed to standby */
-	if (!da7219->aad->jack)
-		snd_soc_write(codec, DA7219_SYSTEM_ACTIVE,
-			      DA7219_SYSTEM_ACTIVE_MASK);
-
 	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
+	/* Resume AAD if previously suspended */
+	if (!da7219->wakeup_source)
+		da7219_aad_resume(codec);
+
 	return 0;
 }
 #else
diff --git a/sound/soc/codecs/da7219.h b/sound/soc/codecs/da7219.h
index f1b3ad8..66d3bad 100644
--- a/sound/soc/codecs/da7219.h
+++ b/sound/soc/codecs/da7219.h
@@ -803,6 +803,7 @@ struct da7219_priv {
 	struct da7219_aad_priv *aad;
 	struct da7219_pdata *pdata;
 
+	bool wakeup_source;
 	struct regulator_bulk_data supplies[DA7219_NUM_SUPPLIES];
 	struct regmap *regmap;
 	struct mutex lock;
-- 
1.9.3
