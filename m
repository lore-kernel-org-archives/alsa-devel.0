From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: Make more efficient use of MCLK within driver" to the asoc tree
Date: Mon, 01 Aug 2016 18:07:33 +0100
Message-ID: <E1bUGgf-0006TS-Sm@debutante>
References: <20160729134654.BC1F73FB13@swsrvapps-01.diasemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160729134654.BC1F73FB13@swsrvapps-01.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7219: Make more efficient use of MCLK within driver

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3278bfca82e9d8ec0eefe7ecf932acd7efdad944 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Fri, 29 Jul 2016 14:46:54 +0100
Subject: [PATCH] ASoC: da7219: Make more efficient use of MCLK within driver

Currently, if the driver has control of MCLK then it remains
enabled as long as the codec is in STANDBY or above. The MCLK is
only really required in STANDBY when a 3-pole jack is inserted
and the HP detect procedure is required to run.

This patch updates the code to enable/disable the MCLK when moving
between the STANDBY and PREPARE bias level, and when a 3-pole jack
is inserted and HP detection is required, thus saving power at all
other times.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219-aad.c | 18 +++++++++++++++++-
 sound/soc/codecs/da7219.c     | 18 +++++++++++-------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index f0057cd223a4..4e369a1c5d88 100644
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
index 50ea94317cb3..737e91422a5e 100644
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
2.8.1
