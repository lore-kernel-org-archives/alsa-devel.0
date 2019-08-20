From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mchp-i2s-mcc: Fix simultaneous capture and playback in master mode" to the asoc tree
Date: Tue, 20 Aug 2019 18:41:03 +0100 (BST)
Message-ID: <20190820174103.225022742B4A@ypsilon.sirena.org.uk>
References: <20190820162411.24836-4-codrin.ciubotariu@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820162411.24836-4-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: alexandre.belloni@bootlin.com, alsa-devel@alsa-project.org, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, ludovic.desroches@microchip.comMark Brown <broonie@kernel.org>, nicolas.ferre@microchip.com, perex@perex.cz, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mchp-i2s-mcc: Fix simultaneous capture and playback in master mode

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From c9cff337eab394c4dc8b128dde7308a1dd2e653a Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Tue, 20 Aug 2019 19:24:11 +0300
Subject: [PATCH] ASoC: mchp-i2s-mcc: Fix simultaneous capture and playback in
 master mode

This controller supports capture and playback running at the same time,
with the limitation that both capture and playback must be configured the
same way (sample rate, sample format, number of channels, etc). For this,
we have to assure that the configuration registers look the same when
capture and playback are initiated.
This patch fixes a bug in which the controller is in master mode and the
hw_params() callback fails for the second audio stream. The fail occurs
because the divisors are calculated after comparing the configuration
registers for capture and playback. The fix consists in calculating the
divisors before comparing the configuration registers. BCLK and LRC are
then configured and started only if the controller is not already running.

Fixes: 7e0cdf545a55 ("ASoC: mchp-i2s-mcc: add driver for I2SC Multi-Channel Controller")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Link: https://lore.kernel.org/r/20190820162411.24836-4-codrin.ciubotariu@microchip.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/mchp-i2s-mcc.c | 70 ++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/sound/soc/atmel/mchp-i2s-mcc.c b/sound/soc/atmel/mchp-i2s-mcc.c
index 86495883ca3f..9a406144b18f 100644
--- a/sound/soc/atmel/mchp-i2s-mcc.c
+++ b/sound/soc/atmel/mchp-i2s-mcc.c
@@ -392,11 +392,11 @@ static int mchp_i2s_mcc_clk_get_rate_diff(struct clk *clk,
 }
 
 static int mchp_i2s_mcc_config_divs(struct mchp_i2s_mcc_dev *dev,
-				    unsigned int bclk, unsigned int *mra)
+				    unsigned int bclk, unsigned int *mra,
+				    unsigned long *best_rate)
 {
 	unsigned long clk_rate;
 	unsigned long lcm_rate;
-	unsigned long best_rate = 0;
 	unsigned long best_diff_rate = ~0;
 	unsigned int sysclk;
 	struct clk *best_clk = NULL;
@@ -423,7 +423,7 @@ static int mchp_i2s_mcc_config_divs(struct mchp_i2s_mcc_dev *dev,
 	     (clk_rate == bclk || clk_rate / (bclk * 2) <= GENMASK(5, 0));
 	     clk_rate += lcm_rate) {
 		ret = mchp_i2s_mcc_clk_get_rate_diff(dev->gclk, clk_rate,
-						     &best_clk, &best_rate,
+						     &best_clk, best_rate,
 						     &best_diff_rate);
 		if (ret) {
 			dev_err(dev->dev, "gclk error for rate %lu: %d",
@@ -437,7 +437,7 @@ static int mchp_i2s_mcc_config_divs(struct mchp_i2s_mcc_dev *dev,
 		}
 
 		ret = mchp_i2s_mcc_clk_get_rate_diff(dev->pclk, clk_rate,
-						     &best_clk, &best_rate,
+						     &best_clk, best_rate,
 						     &best_diff_rate);
 		if (ret) {
 			dev_err(dev->dev, "pclk error for rate %lu: %d",
@@ -459,33 +459,17 @@ static int mchp_i2s_mcc_config_divs(struct mchp_i2s_mcc_dev *dev,
 
 	dev_dbg(dev->dev, "source CLK is %s with rate %lu, diff %lu\n",
 		best_clk == dev->pclk ? "pclk" : "gclk",
-		best_rate, best_diff_rate);
-
-	/* set the rate */
-	ret = clk_set_rate(best_clk, best_rate);
-	if (ret) {
-		dev_err(dev->dev, "unable to set rate %lu to %s: %d\n",
-			best_rate, best_clk == dev->pclk ? "PCLK" : "GCLK",
-			ret);
-		return ret;
-	}
+		*best_rate, best_diff_rate);
 
 	/* Configure divisors */
 	if (dev->sysclk)
-		*mra |= MCHP_I2SMCC_MRA_IMCKDIV(best_rate / (2 * sysclk));
-	*mra |= MCHP_I2SMCC_MRA_ISCKDIV(best_rate / (2 * bclk));
+		*mra |= MCHP_I2SMCC_MRA_IMCKDIV(*best_rate / (2 * sysclk));
+	*mra |= MCHP_I2SMCC_MRA_ISCKDIV(*best_rate / (2 * bclk));
 
-	if (best_clk == dev->gclk) {
+	if (best_clk == dev->gclk)
 		*mra |= MCHP_I2SMCC_MRA_SRCCLK_GCLK;
-		ret = clk_prepare(dev->gclk);
-		if (ret < 0)
-			dev_err(dev->dev, "unable to prepare GCLK: %d\n", ret);
-		else
-			dev->gclk_use = 1;
-	} else {
+	else
 		*mra |= MCHP_I2SMCC_MRA_SRCCLK_PCLK;
-		dev->gclk_use = 0;
-	}
 
 	return 0;
 }
@@ -502,6 +486,7 @@ static int mchp_i2s_mcc_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *params,
 				  struct snd_soc_dai *dai)
 {
+	unsigned long rate = 0;
 	struct mchp_i2s_mcc_dev *dev = snd_soc_dai_get_drvdata(dai);
 	u32 mra = 0;
 	u32 mrb = 0;
@@ -640,6 +625,17 @@ static int mchp_i2s_mcc_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	if (set_divs) {
+		bclk_rate = frame_length * params_rate(params);
+		ret = mchp_i2s_mcc_config_divs(dev, bclk_rate, &mra,
+					       &rate);
+		if (ret) {
+			dev_err(dev->dev,
+				"unable to configure the divisors: %d\n", ret);
+			return ret;
+		}
+	}
+
 	/*
 	 * If we are already running, the wanted setup must be
 	 * the same with the one that's currently ongoing
@@ -656,19 +652,27 @@ static int mchp_i2s_mcc_hw_params(struct snd_pcm_substream *substream,
 		return 0;
 	}
 
-	/* Save the number of channels to know what interrupts to enable */
-	dev->channels = channels;
-
-	if (set_divs) {
-		bclk_rate = frame_length * params_rate(params);
-		ret = mchp_i2s_mcc_config_divs(dev, bclk_rate, &mra);
+	if (mra & MCHP_I2SMCC_MRA_SRCCLK_GCLK && !dev->gclk_use) {
+		/* set the rate */
+		ret = clk_set_rate(dev->gclk, rate);
 		if (ret) {
-			dev_err(dev->dev, "unable to configure the divisors: %d\n",
-				ret);
+			dev_err(dev->dev,
+				"unable to set rate %lu to GCLK: %d\n",
+				rate, ret);
+			return ret;
+		}
+
+		ret = clk_prepare(dev->gclk);
+		if (ret < 0) {
+			dev_err(dev->dev, "unable to prepare GCLK: %d\n", ret);
 			return ret;
 		}
+		dev->gclk_use = 1;
 	}
 
+	/* Save the number of channels to know what interrupts to enable */
+	dev->channels = channels;
+
 	ret = regmap_write(dev->regmap, MCHP_I2SMCC_MRA, mra);
 	if (ret < 0)
 		return ret;
-- 
2.20.1
