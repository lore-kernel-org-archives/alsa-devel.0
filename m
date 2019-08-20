From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH 3/3] ASoC: mchp-i2s-mcc: Fix simultaneous capture and playback in master mode
Date: Tue, 20 Aug 2019 19:24:11 +0300
Message-ID: <20190820162411.24836-4-codrin.ciubotariu@microchip.com>
References: <20190820162411.24836-1-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820162411.24836-1-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
List-Id: alsa-devel@alsa-project.org

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
---
 sound/soc/atmel/mchp-i2s-mcc.c | 70 ++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/sound/soc/atmel/mchp-i2s-mcc.c b/sound/soc/atmel/mchp-i2s-mcc.c
index ab7d5f98e759..befc2a3a05b0 100644
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
 	if (ret < 0) {
 		if (dev->gclk_use) {
-- 
2.20.1
