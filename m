From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH] ASoC: da7219: Make more efficient use of MCLK within driver
Date: Fri, 29 Jul 2016 14:46:54 +0100
Message-ID: <20160729134654.BC1F73FB13@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Currently, if the driver has control of MCLK then it remains
enabled as long as the codec is in STANDBY or above. The MCLK is
only really required in STANDBY when a 3-pole jack is inserted
and the HP detect procedure is required to run.

This patch updates the code to enable/disable the MCLK when moving
between the STANDBY and PREPARE bias level, and when a 3-pole jack
is inserted and HP detection is required, thus saving power at all
other times.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/codecs/da7219-aad.c | 18 +++++++++++++++++-
 sound/soc/codecs/da7219.c     | 18 +++++++++++-------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index f0057cd..4e369a1 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -13,6 +13,7 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
 #include <linux/i2c.h>
 #include <linux/property.h>
 #include <linux/pm_wakeirq.h>
@@ -115,12 +116,23 @@ static void da7219_aad_hptest_work(struct work_struct *work)
 
 	u16 tonegen_freq_hptest;
 	u8 accdet_cfg8;
-	int report = 0;
+	int report = 0, ret = 0;
 
 	/* Lock DAPM and any Kcontrols that are affected by this test */
 	snd_soc_dapm_mutex_lock(dapm);
 	mutex_lock(&da7219->lock);
 
+	/* Ensure MCLK is available for HP test procedure */
+	if (da7219->mclk) {
+		ret = clk_prepare_enable(da7219->mclk);
+		if (ret) {
+			dev_err(codec->dev, "Failed to enable mclk - %d\n", ret);
+			mutex_unlock(&da7219->lock);
+			snd_soc_dapm_mutex_unlock(dapm);
+			return;
+		}
+	}
+
 	/* Bypass cache so it saves current settings */
 	regcache_cache_bypass(da7219->regmap, true);
 
@@ -250,6 +262,10 @@ static void da7219_aad_hptest_work(struct work_struct *work)
 	snd_soc_update_bits(codec, DA7219_HP_R_CTRL, DA7219_HP_R_AMP_OE_MASK,
 			    DA7219_HP_R_AMP_OE_MASK);
 
+	/* Remove MCLK, if previously enabled */
+	if (da7219->mclk)
+		clk_disable_unprepare(da7219->mclk);
+
 	mutex_unlock(&da7219->lock);
 	snd_soc_dapm_mutex_unlock(dapm);
 
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 50ea943..737e914 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1508,11 +1508,10 @@ static int da7219_set_bias_level(struct snd_soc_codec *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-	case SND_SOC_BIAS_PREPARE:
 		break;
-	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
-			/* MCLK */
+	case SND_SOC_BIAS_PREPARE:
+		/* Enable MCLK for transition to ON state */
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_STANDBY) {
 			if (da7219->mclk) {
 				ret = clk_prepare_enable(da7219->mclk);
 				if (ret) {
@@ -1521,11 +1520,19 @@ static int da7219_set_bias_level(struct snd_soc_codec *codec,
 					return ret;
 				}
 			}
+		}
 
+		break;
+	case SND_SOC_BIAS_STANDBY:
+		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
 			/* Master bias */
 			snd_soc_update_bits(codec, DA7219_REFERENCES,
 					    DA7219_BIAS_EN_MASK,
 					    DA7219_BIAS_EN_MASK);
+		} else {
+			/* Remove MCLK */
+			if (da7219->mclk)
+				clk_disable_unprepare(da7219->mclk);
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
@@ -1534,9 +1541,6 @@ static int da7219_set_bias_level(struct snd_soc_codec *codec,
 			snd_soc_update_bits(codec, DA7219_REFERENCES,
 					    DA7219_BIAS_EN_MASK, 0);
 
-		/* MCLK */
-		if (da7219->mclk)
-			clk_disable_unprepare(da7219->mclk);
 		break;
 	}
 
-- 
1.9.3
