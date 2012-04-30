From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: wm8350: Replace use of custom I/O
	with snd_soc_read()/write()
Date: Mon, 30 Apr 2012 22:53:14 +0100
Message-ID: <1335822795-4720-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1335822795-4720-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0CAA81041E1
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Apr 2012 23:53:23 +0200 (CEST)
In-Reply-To: <1335822795-4720-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Makes the code more standard and prepares for better framework usage.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8350.c |   74 ++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 840380d..f610518 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -353,8 +353,8 @@ static int wm8350_put_volsw_2r_vu(struct snd_kcontrol *kcontrol,
 		return ret;
 
 	/* now hit the volume update bits (always bit 8) */
-	val = wm8350_codec_read(codec, reg);
-	wm8350_codec_write(codec, reg, val | WM8350_OUT1_VU);
+	val = snd_soc_read(codec, reg);
+	snd_soc_write(codec, reg, val | WM8350_OUT1_VU);
 	return 1;
 }
 
@@ -788,9 +788,9 @@ static int wm8350_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	case WM8350_MCLK_SEL_PLL_32K:
 		wm8350_set_bits(wm8350, WM8350_CLOCK_CONTROL_1,
 				WM8350_MCLK_SEL);
-		fll_4 = wm8350_codec_read(codec, WM8350_FLL_CONTROL_4) &
+		fll_4 = snd_soc_read(codec, WM8350_FLL_CONTROL_4) &
 		    ~WM8350_FLL_CLK_SRC_MASK;
-		wm8350_codec_write(codec, WM8350_FLL_CONTROL_4, fll_4 | clk_id);
+		snd_soc_write(codec, WM8350_FLL_CONTROL_4, fll_4 | clk_id);
 		break;
 	}
 
@@ -812,39 +812,39 @@ static int wm8350_set_clkdiv(struct snd_soc_dai *codec_dai, int div_id, int div)
 
 	switch (div_id) {
 	case WM8350_ADC_CLKDIV:
-		val = wm8350_codec_read(codec, WM8350_ADC_DIVIDER) &
+		val = snd_soc_read(codec, WM8350_ADC_DIVIDER) &
 		    ~WM8350_ADC_CLKDIV_MASK;
-		wm8350_codec_write(codec, WM8350_ADC_DIVIDER, val | div);
+		snd_soc_write(codec, WM8350_ADC_DIVIDER, val | div);
 		break;
 	case WM8350_DAC_CLKDIV:
-		val = wm8350_codec_read(codec, WM8350_DAC_CLOCK_CONTROL) &
+		val = snd_soc_read(codec, WM8350_DAC_CLOCK_CONTROL) &
 		    ~WM8350_DAC_CLKDIV_MASK;
-		wm8350_codec_write(codec, WM8350_DAC_CLOCK_CONTROL, val | div);
+		snd_soc_write(codec, WM8350_DAC_CLOCK_CONTROL, val | div);
 		break;
 	case WM8350_BCLK_CLKDIV:
-		val = wm8350_codec_read(codec, WM8350_CLOCK_CONTROL_1) &
+		val = snd_soc_read(codec, WM8350_CLOCK_CONTROL_1) &
 		    ~WM8350_BCLK_DIV_MASK;
-		wm8350_codec_write(codec, WM8350_CLOCK_CONTROL_1, val | div);
+		snd_soc_write(codec, WM8350_CLOCK_CONTROL_1, val | div);
 		break;
 	case WM8350_OPCLK_CLKDIV:
-		val = wm8350_codec_read(codec, WM8350_CLOCK_CONTROL_1) &
+		val = snd_soc_read(codec, WM8350_CLOCK_CONTROL_1) &
 		    ~WM8350_OPCLK_DIV_MASK;
-		wm8350_codec_write(codec, WM8350_CLOCK_CONTROL_1, val | div);
+		snd_soc_write(codec, WM8350_CLOCK_CONTROL_1, val | div);
 		break;
 	case WM8350_SYS_CLKDIV:
-		val = wm8350_codec_read(codec, WM8350_CLOCK_CONTROL_1) &
+		val = snd_soc_read(codec, WM8350_CLOCK_CONTROL_1) &
 		    ~WM8350_MCLK_DIV_MASK;
-		wm8350_codec_write(codec, WM8350_CLOCK_CONTROL_1, val | div);
+		snd_soc_write(codec, WM8350_CLOCK_CONTROL_1, val | div);
 		break;
 	case WM8350_DACLR_CLKDIV:
-		val = wm8350_codec_read(codec, WM8350_DAC_LR_RATE) &
+		val = snd_soc_read(codec, WM8350_DAC_LR_RATE) &
 		    ~WM8350_DACLRC_RATE_MASK;
-		wm8350_codec_write(codec, WM8350_DAC_LR_RATE, val | div);
+		snd_soc_write(codec, WM8350_DAC_LR_RATE, val | div);
 		break;
 	case WM8350_ADCLR_CLKDIV:
-		val = wm8350_codec_read(codec, WM8350_ADC_LR_RATE) &
+		val = snd_soc_read(codec, WM8350_ADC_LR_RATE) &
 		    ~WM8350_ADCLRC_RATE_MASK;
-		wm8350_codec_write(codec, WM8350_ADC_LR_RATE, val | div);
+		snd_soc_write(codec, WM8350_ADC_LR_RATE, val | div);
 		break;
 	default:
 		return -EINVAL;
@@ -856,13 +856,13 @@ static int wm8350_set_clkdiv(struct snd_soc_dai *codec_dai, int div_id, int div)
 static int wm8350_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 iface = wm8350_codec_read(codec, WM8350_AI_FORMATING) &
+	u16 iface = snd_soc_read(codec, WM8350_AI_FORMATING) &
 	    ~(WM8350_AIF_BCLK_INV | WM8350_AIF_LRCLK_INV | WM8350_AIF_FMT_MASK);
-	u16 master = wm8350_codec_read(codec, WM8350_AI_DAC_CONTROL) &
+	u16 master = snd_soc_read(codec, WM8350_AI_DAC_CONTROL) &
 	    ~WM8350_BCLK_MSTR;
-	u16 dac_lrc = wm8350_codec_read(codec, WM8350_DAC_LR_RATE) &
+	u16 dac_lrc = snd_soc_read(codec, WM8350_DAC_LR_RATE) &
 	    ~WM8350_DACLRC_ENA;
-	u16 adc_lrc = wm8350_codec_read(codec, WM8350_ADC_LR_RATE) &
+	u16 adc_lrc = snd_soc_read(codec, WM8350_ADC_LR_RATE) &
 	    ~WM8350_ADCLRC_ENA;
 
 	/* set master/slave audio interface */
@@ -915,10 +915,10 @@ static int wm8350_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		return -EINVAL;
 	}
 
-	wm8350_codec_write(codec, WM8350_AI_FORMATING, iface);
-	wm8350_codec_write(codec, WM8350_AI_DAC_CONTROL, master);
-	wm8350_codec_write(codec, WM8350_DAC_LR_RATE, dac_lrc);
-	wm8350_codec_write(codec, WM8350_ADC_LR_RATE, adc_lrc);
+	snd_soc_write(codec, WM8350_AI_FORMATING, iface);
+	snd_soc_write(codec, WM8350_AI_DAC_CONTROL, master);
+	snd_soc_write(codec, WM8350_DAC_LR_RATE, dac_lrc);
+	snd_soc_write(codec, WM8350_ADC_LR_RATE, adc_lrc);
 	return 0;
 }
 
@@ -928,7 +928,7 @@ static int wm8350_pcm_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct wm8350 *wm8350 = codec->control_data;
-	u16 iface = wm8350_codec_read(codec, WM8350_AI_FORMATING) &
+	u16 iface = snd_soc_read(codec, WM8350_AI_FORMATING) &
 	    ~WM8350_AIF_WL_MASK;
 
 	/* bit size */
@@ -946,7 +946,7 @@ static int wm8350_pcm_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	wm8350_codec_write(codec, WM8350_AI_FORMATING, iface);
+	snd_soc_write(codec, WM8350_AI_FORMATING, iface);
 
 	/* The sloping stopband filter is recommended for use with
 	 * lower sample rates to improve performance.
@@ -1065,17 +1065,17 @@ static int wm8350_set_fll(struct snd_soc_dai *codec_dai,
 		fll_div.ratio);
 
 	/* set up N.K & dividers */
-	fll_1 = wm8350_codec_read(codec, WM8350_FLL_CONTROL_1) &
+	fll_1 = snd_soc_read(codec, WM8350_FLL_CONTROL_1) &
 	    ~(WM8350_FLL_OUTDIV_MASK | WM8350_FLL_RSP_RATE_MASK | 0xc000);
-	wm8350_codec_write(codec, WM8350_FLL_CONTROL_1,
+	snd_soc_write(codec, WM8350_FLL_CONTROL_1,
 			   fll_1 | (fll_div.div << 8) | 0x50);
-	wm8350_codec_write(codec, WM8350_FLL_CONTROL_2,
+	snd_soc_write(codec, WM8350_FLL_CONTROL_2,
 			   (fll_div.ratio << 11) | (fll_div.
 						    n & WM8350_FLL_N_MASK));
-	wm8350_codec_write(codec, WM8350_FLL_CONTROL_3, fll_div.k);
-	fll_4 = wm8350_codec_read(codec, WM8350_FLL_CONTROL_4) &
+	snd_soc_write(codec, WM8350_FLL_CONTROL_3, fll_div.k);
+	fll_4 = snd_soc_read(codec, WM8350_FLL_CONTROL_4) &
 	    ~(WM8350_FLL_FRAC | WM8350_FLL_SLOW_LOCK_REF);
-	wm8350_codec_write(codec, WM8350_FLL_CONTROL_4,
+	snd_soc_write(codec, WM8350_FLL_CONTROL_4,
 			   fll_4 | (fll_div.k ? WM8350_FLL_FRAC : 0) |
 			   (fll_div.ratio == 8 ? WM8350_FLL_SLOW_LOCK_REF : 0));
 
@@ -1519,9 +1519,9 @@ static  int wm8350_codec_probe(struct snd_soc_codec *codec)
 	wm8350_set_bits(wm8350, WM8350_POWER_MGMT_5, WM8350_CODEC_ENA);
 
 	/* Enable robust clocking mode in ADC */
-	wm8350_codec_write(codec, WM8350_SECURITY, 0xa7);
-	wm8350_codec_write(codec, 0xde, 0x13);
-	wm8350_codec_write(codec, WM8350_SECURITY, 0);
+	snd_soc_write(codec, WM8350_SECURITY, 0xa7);
+	snd_soc_write(codec, 0xde, 0x13);
+	snd_soc_write(codec, WM8350_SECURITY, 0);
 
 	/* read OUT1 & OUT2 volumes */
 	out1 = &priv->out1;
-- 
1.7.10
