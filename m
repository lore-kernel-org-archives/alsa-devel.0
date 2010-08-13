From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/7] ASoC: Automatically calculate clock ratio
	for WM8580
Date: Fri, 13 Aug 2010 20:35:04 +0100
Message-ID: <1281728107-25386-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20100813193305.GB3778@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4EB08103904
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 21:35:13 +0200 (CEST)
In-Reply-To: <20100813193305.GB3778@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

Implement set_sysclk() and then rather than assuming 256fs use the
supplied value to calculate and configure the clock ratio for the
currently used sample rate. As a side effect we also end up
implementing clock selection for the ADC path.

In order to avoid confusion remove the existing set_clkdiv() based
configuration of the clock source for the DAC and update the SMDK64xx
driver (which is the only in-tree user of the CODEC).

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8580.c           |  101 +++++++++++++++++++++++++++--------
 sound/soc/codecs/wm8580.h           |   14 +++---
 sound/soc/s3c24xx/smdk64xx_wm8580.c |    9 ++--
 3 files changed, 90 insertions(+), 34 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 9964f02..3d7ff55 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -192,6 +192,7 @@ struct wm8580_priv {
 	u16 reg_cache[WM8580_MAX_REGISTER + 1];
 	struct pll_state a;
 	struct pll_state b;
+	int sysclk[2];
 };
 
 static const DECLARE_TLV_DB_SCALE(dac_tlv, -12750, 50, 1);
@@ -464,6 +465,10 @@ static int wm8580_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	return 0;
 }
 
+static const int wm8580_sysclk_ratios[] = {
+	128, 192, 256, 384, 512, 768, 1152,
+};
+
 /*
  * Set PCM DAI bit size and sample rate.
  */
@@ -473,7 +478,10 @@ static int wm8580_paif_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_codec *codec = rtd->codec;
+	struct wm8580_priv *wm8580 = snd_soc_codec_get_drvdata(codec);
+	u16 paifa = 0;
 	u16 paifb = 0;
+	int i, ratio;
 
 	/* bit size */
 	switch (params_format(params)) {
@@ -492,6 +500,22 @@ static int wm8580_paif_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	/* Look up the SYSCLK ratio; accept only exact matches */
+	ratio = wm8580->sysclk[dai->id] / params_rate(params);
+	for (i = 0; i < ARRAY_SIZE(wm8580_sysclk_ratios); i++)
+		if (ratio == wm8580_sysclk_ratios[i])
+			break;
+	if (i == ARRAY_SIZE(wm8580_sysclk_ratios)) {
+		dev_err(codec->dev, "Invalid clock ratio %d/%d\n",
+			wm8580->sysclk[dai->id], params_rate(params));
+		return -EINVAL;
+	}
+	paifa |= i;
+	dev_dbg(codec->dev, "Running at %dfs with %dHz clock\n",
+		wm8580_sysclk_ratios[i], wm8580->sysclk[dai->driver->id]);
+
+	snd_soc_update_bits(codec, WM8580_PAIF1 + dai->driver->id,
+			    WM8580_AIF_RATE_MASK, paifa);
 	snd_soc_update_bits(codec, WM8580_PAIF3 + dai->driver->id,
 			    WM8580_AIF_LENGTH_MASK, paifb);
 	return 0;
@@ -501,9 +525,11 @@ static int wm8580_set_paif_dai_fmt(struct snd_soc_dai *codec_dai,
 				      unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
+	struct wm8580_priv *wm8580 = snd_soc_codec_get_drvdata(codec);
 	unsigned int aifa;
 	unsigned int aifb;
 	int can_invert_lrclk;
+	int sysclk;
 
 	aifa = snd_soc_read(codec, WM8580_PAIF1 + codec_dai->driver->id);
 	aifb = snd_soc_read(codec, WM8580_PAIF3 + codec_dai->driver->id);
@@ -572,6 +598,8 @@ static int wm8580_set_paif_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
+	sysclk = wm8580->sysclk[codec_dai->driver->id];
+
 	snd_soc_write(codec, WM8580_PAIF1 + codec_dai->driver->id, aifa);
 	snd_soc_write(codec, WM8580_PAIF3 + codec_dai->driver->id, aifb);
 
@@ -611,28 +639,6 @@ static int wm8580_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		snd_soc_write(codec, WM8580_PLLB4, reg);
 		break;
 
-	case WM8580_DAC_CLKSEL:
-		reg = snd_soc_read(codec, WM8580_CLKSEL);
-		reg &= ~WM8580_CLKSEL_DAC_CLKSEL_MASK;
-
-		switch (div) {
-		case WM8580_CLKSRC_MCLK:
-			break;
-
-		case WM8580_CLKSRC_PLLA:
-			reg |= WM8580_CLKSEL_DAC_CLKSEL_PLLA;
-			break;
-
-		case WM8580_CLKSRC_PLLB:
-			reg |= WM8580_CLKSEL_DAC_CLKSEL_PLLB;
-			break;
-
-		default:
-			return -EINVAL;
-		}
-		snd_soc_write(codec, WM8580_CLKSEL, reg);
-		break;
-
 	case WM8580_CLKOUTSRC:
 		reg = snd_soc_read(codec, WM8580_PLLB4);
 		reg &= ~WM8580_PLLB4_CLKOUTSRC_MASK;
@@ -666,6 +672,55 @@ static int wm8580_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
+static int wm8580_set_sysclk(struct snd_soc_dai *dai, int clk_id,
+			     unsigned int freq, int dir)
+{
+	struct snd_soc_codec *codec = dai->codec;
+	struct wm8580_priv *wm8580 = snd_soc_codec_get_drvdata(codec);
+	int sel, sel_mask, sel_shift;
+
+	switch (dai->driver->id) {
+	case WM8580_DAI_PAIFTX:
+		sel_mask = 0x3;
+		sel_shift = 0;
+		break;
+
+	case WM8580_DAI_PAIFRX:
+		sel_mask = 0xc;
+		sel_shift = 3;
+		break;
+
+	default:
+		BUG_ON("Unknown DAI driver ID\n");
+		return -EINVAL;
+	}
+
+	switch (clk_id) {
+	case WM8580_CLKSRC_ADCMCLK:
+		if (dai->id != WM8580_DAI_PAIFTX)
+			return -EINVAL;
+		sel = 0 << sel_shift;
+		break;
+	case WM8580_CLKSRC_PLLA:
+		sel = 1 << sel_shift;
+		break;
+	case WM8580_CLKSRC_PLLB:
+		sel = 2 << sel_shift;
+		break;
+	case WM8580_CLKSRC_MCLK:
+		sel = 3 << sel_shift;
+		break;
+	default:
+		dev_err(codec->dev, "Unknown clock %d\n", clk_id);
+		return -EINVAL;
+	}
+
+	/* We really should validate PLL settings but not yet */
+	wm8580->sysclk[dai->id] = freq;
+
+	return snd_soc_update_bits(codec, WM8580_CLKSEL, sel, sel_mask);
+}
+
 static int wm8580_digital_mute(struct snd_soc_dai *codec_dai, int mute)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
@@ -719,6 +774,7 @@ static int wm8580_set_bias_level(struct snd_soc_codec *codec,
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
 static struct snd_soc_dai_ops wm8580_dai_ops_playback = {
+	.set_sysclk	= wm8580_set_sysclk,
 	.hw_params	= wm8580_paif_hw_params,
 	.set_fmt	= wm8580_set_paif_dai_fmt,
 	.set_clkdiv	= wm8580_set_dai_clkdiv,
@@ -727,6 +783,7 @@ static struct snd_soc_dai_ops wm8580_dai_ops_playback = {
 };
 
 static struct snd_soc_dai_ops wm8580_dai_ops_capture = {
+	.set_sysclk	= wm8580_set_sysclk,
 	.hw_params	= wm8580_paif_hw_params,
 	.set_fmt	= wm8580_set_paif_dai_fmt,
 	.set_clkdiv	= wm8580_set_dai_clkdiv,
diff --git a/sound/soc/codecs/wm8580.h b/sound/soc/codecs/wm8580.h
index 8328ef6..1d34656 100644
--- a/sound/soc/codecs/wm8580.h
+++ b/sound/soc/codecs/wm8580.h
@@ -19,14 +19,14 @@
 #define WM8580_PLLB  2
 
 #define WM8580_MCLK       1
-#define WM8580_DAC_CLKSEL 2
-#define WM8580_CLKOUTSRC  3
+#define WM8580_CLKOUTSRC  2
 
-#define WM8580_CLKSRC_MCLK 1
-#define WM8580_CLKSRC_PLLA 2
-#define WM8580_CLKSRC_PLLB 3
-#define WM8580_CLKSRC_OSC  4
-#define WM8580_CLKSRC_NONE 5
+#define WM8580_CLKSRC_MCLK    1
+#define WM8580_CLKSRC_PLLA    2
+#define WM8580_CLKSRC_PLLB    3
+#define WM8580_CLKSRC_OSC     4
+#define WM8580_CLKSRC_NONE    5
+#define WM8580_CLKSRC_ADCMCLK 6
 
 #define WM8580_DAI_PAIFRX 0
 #define WM8580_DAI_PAIFTX 1
diff --git a/sound/soc/s3c24xx/smdk64xx_wm8580.c b/sound/soc/s3c24xx/smdk64xx_wm8580.c
index 5c21e26..91367f7 100644
--- a/sound/soc/s3c24xx/smdk64xx_wm8580.c
+++ b/sound/soc/s3c24xx/smdk64xx_wm8580.c
@@ -113,14 +113,13 @@ static int smdk64xx_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	/* Explicitly set WM8580-DAC to source from MCLK */
-	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8580_DAC_CLKSEL,
-					WM8580_CLKSRC_MCLK);
+	ret = snd_soc_dai_set_pll(codec_dai, WM8580_PLLA, 0,
+					SMDK64XX_WM8580_FREQ, pll_out);
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_pll(codec_dai, WM8580_PLLA, 0,
-					SMDK64XX_WM8580_FREQ, pll_out);
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8580_CLKSRC_PLLA,
+				     pll_out, SND_SOC_CLOCK_IN);
 	if (ret < 0)
 		return ret;
 
-- 
1.7.1
