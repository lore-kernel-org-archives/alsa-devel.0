From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Allow WM8915 BCLK calculation outside
	hw_params()
Date: Mon,  6 Jun 2011 19:21:04 +0100
Message-ID: <1307384464-24522-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0348424435
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jun 2011 20:21:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Allow more dynamic management of the device clocking by allowing BCLK to
be calculated when we set SYSCLK. This means that if the system is idle
when hw_params() runs then we don't try to use the SYSCLK used in that case
to set up the BCLK dividers, we can instead wait until a later point such
as bias level configuration. This makes it easier to manage low power modes.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8915.c |   82 +++++++++++++++++++++++++++++----------------
 1 files changed, 53 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/wm8915.c b/sound/soc/codecs/wm8915.c
index a1d8618..423baa9 100644
--- a/sound/soc/codecs/wm8915.c
+++ b/sound/soc/codecs/wm8915.c
@@ -75,6 +75,7 @@ struct wm8915_priv {
 	struct wm8915_pdata pdata;
 
 	int rx_rate[WM8915_AIFS];
+	int bclk_rate[WM8915_AIFS];
 
 	/* Platform dependant ReTune mobile configuration */
 	int num_retune_mobile_texts;
@@ -1562,6 +1563,50 @@ static int wm8915_reset(struct snd_soc_codec *codec)
 	return snd_soc_write(codec, WM8915_SOFTWARE_RESET, 0x8915);
 }
 
+static const int bclk_divs[] = {
+	1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48, 64, 96
+};
+
+static void wm8915_update_bclk(struct snd_soc_codec *codec)
+{
+	struct wm8915_priv *wm8915 = snd_soc_codec_get_drvdata(codec);
+	int aif, best, cur_val, bclk_rate, bclk_reg, i;
+
+	/* Don't bother if we're in a low frequency idle mode that
+	 * can't support audio.
+	 */
+	if (wm8915->sysclk < 64000)
+		return;
+
+	for (aif = 0; aif < WM8915_AIFS; aif++) {
+		switch (aif) {
+		case 0:
+			bclk_reg = WM8915_AIF1_BCLK;
+			break;
+		case 1:
+			bclk_reg = WM8915_AIF2_BCLK;
+			break;
+		}
+
+		bclk_rate = wm8915->bclk_rate[aif];
+
+		/* Pick a divisor for BCLK as close as we can get to ideal */
+		best = 0;
+		for (i = 0; i < ARRAY_SIZE(bclk_divs); i++) {
+			cur_val = (wm8915->sysclk / bclk_divs[i]) - bclk_rate;
+			if (cur_val < 0) /* BCLK table is sorted */
+				break;
+			best = i;
+		}
+		bclk_rate = wm8915->sysclk / bclk_divs[best];
+		dev_dbg(codec->dev, "Using BCLK_DIV %d for actual BCLK %dHz\n",
+			bclk_divs[best], bclk_rate);
+
+		snd_soc_update_bits(codec, bclk_reg,
+				    WM8915_AIF1_BCLK_DIV_MASK, best);
+	}
+}
+
 static int wm8915_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
@@ -1714,10 +1759,6 @@ static int wm8915_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
-static const int bclk_divs[] = {
-	1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48, 64, 96
-};
-
 static const int dsp_divs[] = {
 	48000, 32000, 16000, 8000
 };
@@ -1728,17 +1769,11 @@ static int wm8915_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct wm8915_priv *wm8915 = snd_soc_codec_get_drvdata(codec);
-	int bits, i, bclk_rate, best, cur_val;
+	int bits, i, bclk_rate;
 	int aifdata = 0;
-	int bclk = 0;
 	int lrclk = 0;
 	int dsp = 0;
-	int aifdata_reg, bclk_reg, lrclk_reg, dsp_shift;
-
-	if (!wm8915->sysclk) {
-		dev_err(codec->dev, "SYSCLK not configured\n");
-		return -EINVAL;
-	}
+	int aifdata_reg, lrclk_reg, dsp_shift;
 
 	switch (dai->id) {
 	case 0:
@@ -1750,7 +1785,6 @@ static int wm8915_hw_params(struct snd_pcm_substream *substream,
 			aifdata_reg = WM8915_AIF1TX_DATA_CONFIGURATION_1;
 			lrclk_reg = WM8915_AIF1_TX_LRCLK_1;
 		}
-		bclk_reg = WM8915_AIF1_BCLK;
 		dsp_shift = 0;
 		break;
 	case 1:
@@ -1762,7 +1796,6 @@ static int wm8915_hw_params(struct snd_pcm_substream *substream,
 			aifdata_reg = WM8915_AIF2TX_DATA_CONFIGURATION_1;
 			lrclk_reg = WM8915_AIF2_TX_LRCLK_1;
 		}
-		bclk_reg = WM8915_AIF2_BCLK;
 		dsp_shift = WM8915_DSP2_DIV_SHIFT;
 		break;
 	default:
@@ -1776,6 +1809,9 @@ static int wm8915_hw_params(struct snd_pcm_substream *substream,
 		return bclk_rate;
 	}
 
+	wm8915->bclk_rate[dai->id] = bclk_rate;
+	wm8915->rx_rate[dai->id] = params_rate(params);
+
 	/* Needs looking at for TDM */
 	bits = snd_pcm_format_width(params_format(params));
 	if (bits < 0)
@@ -1793,18 +1829,7 @@ static int wm8915_hw_params(struct snd_pcm_substream *substream,
 	}
 	dsp |= i << dsp_shift;
 
-	/* Pick a divisor for BCLK as close as we can get to ideal */
-	best = 0;
-	for (i = 0; i < ARRAY_SIZE(bclk_divs); i++) {
-		cur_val = (wm8915->sysclk / bclk_divs[i]) - bclk_rate;
-		if (cur_val < 0) /* BCLK table is sorted */
-			break;
-		best = i;
-	}
-	bclk_rate = wm8915->sysclk / bclk_divs[best];
-	dev_dbg(dai->dev, "Using BCLK_DIV %d for actual BCLK %dHz\n",
-		bclk_divs[best], bclk_rate);
-	bclk |= best;
+	wm8915_update_bclk(codec);
 
 	lrclk = bclk_rate / params_rate(params);
 	dev_dbg(dai->dev, "Using LRCLK rate %d for actual LRCLK %dHz\n",
@@ -1814,14 +1839,11 @@ static int wm8915_hw_params(struct snd_pcm_substream *substream,
 			    WM8915_AIF1TX_WL_MASK |
 			    WM8915_AIF1TX_SLOT_LEN_MASK,
 			    aifdata);
-	snd_soc_update_bits(codec, bclk_reg, WM8915_AIF1_BCLK_DIV_MASK, bclk);
 	snd_soc_update_bits(codec, lrclk_reg, WM8915_AIF1RX_RATE_MASK,
 			    lrclk);
 	snd_soc_update_bits(codec, WM8915_AIF_CLOCKING_2,
 			    WM8915_DSP1_DIV_SHIFT << dsp_shift, dsp);
 
-	wm8915->rx_rate[dai->id] = params_rate(params);
-
 	return 0;
 }
 
@@ -1882,6 +1904,8 @@ static int wm8915_set_sysclk(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
+	wm8915_update_bclk(codec);
+
 	snd_soc_update_bits(codec, WM8915_AIF_CLOCKING_1,
 			    WM8915_SYSCLK_SRC_MASK | WM8915_SYSCLK_DIV_MASK,
 			    src << WM8915_SYSCLK_SRC_SHIFT | ratediv);
-- 
1.7.5.3
