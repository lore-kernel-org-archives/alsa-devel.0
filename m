From: Zidan Wang <zidan.wang@freescale.com>
Subject: [alsa-devel][PATCH] ASoC: wm8960: update pll and clock setting function
Date: Fri, 26 Jun 2015 19:09:22 +0800
Message-ID: <5630bd343217e8fa895c5d133497f50739417453.1435316484.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.de, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Zidan Wang <zidan.wang@freescale.com>
List-Id: alsa-devel@alsa-project.org

When using snd_soc_dai_set_pll to set pll in machine driver, we
should set pll in and pll out freq and ensure 5 < PLLN < 13,
otherwise set pll will be failed. In order to support more
formats and sample rates for a certain MCLK, if snd_soc_dai_set_pll
failed, it will calculate a available pll out freq and set the pll
again.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/codecs/wm8960.c | 160 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 126 insertions(+), 34 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 94c5c46..9b17ca7 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -48,6 +48,9 @@
 #define WM8960_DISOP     0x40
 #define WM8960_DRES_MASK 0x30
 
+static bool is_pll_freq_available(unsigned int source, unsigned int target);
+static int wm8960_set_pll(struct snd_soc_dai *codec_dai,
+		unsigned int freq_in, unsigned int freq_out);
 /*
  * wm8960 register cache
  * We can't read the WM8960 register space when we are
@@ -127,8 +130,9 @@ struct wm8960_priv {
 	struct snd_soc_dapm_widget *out3;
 	bool deemph;
 	int playback_fs;
-	int bclk;
+	int freq_in;
 	int sysclk;
+	int clk_id;
 	struct wm8960_data pdata;
 };
 
@@ -565,6 +569,9 @@ static struct {
 	{  8000, 5 },
 };
 
+/* -1 for reserved value */
+static const int sysclk_divs[] = { 1, -1, 2, -1 };
+
 /* Multiply 256 for internal 256 div */
 static const int dac_divs[] = { 256, 384, 512, 768, 1024, 1408, 1536 };
 
@@ -574,61 +581,119 @@ static const int bclk_divs[] = {
 	120, 160, 220, 240, 320, 320, 320
 };
 
-static void wm8960_configure_clocking(struct snd_soc_codec *codec,
-		bool tx, int lrclk)
+static int wm8960_configure_clocking(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params,
+		struct snd_soc_dai *dai)
 {
+	struct snd_soc_codec *codec = dai->codec;
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
+	unsigned int sample_rate = params_rate(params);
+	unsigned int channels = params_channels(params);
+	unsigned int sysclk, bclk, pll_out, freq_in;
+	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	u16 iface1 = snd_soc_read(codec, WM8960_IFACE1);
 	u16 iface2 = snd_soc_read(codec, WM8960_IFACE2);
-	u32 sysclk;
-	int i, j;
+	int i, j, k;
 
 	if (!(iface1 & (1<<6))) {
 		dev_dbg(codec->dev,
 			"Codec is slave mode, no need to configure clock\n");
-		return;
+		return 0;
 	}
 
 	if (!wm8960->sysclk) {
 		dev_dbg(codec->dev, "No SYSCLK configured\n");
-		return;
+		return -EINVAL;
 	}
 
-	if (!wm8960->bclk || !lrclk) {
-		dev_dbg(codec->dev, "No audio clocks configured\n");
-		return;
+	bclk = snd_soc_params_to_bclk(params);
+	if (channels == 1)
+		bclk *= 2;
+
+	sysclk = wm8960->sysclk;
+
+	if (wm8960->clk_id == WM8960_SYSCLK_PLL) {
+		if (!wm8960->freq_in) {
+			dev_dbg(codec->dev, "No PLL input clock configured\n");
+			return -EINVAL;
+		}
+
+		pll_out = sysclk;
+		/*
+		 * If the PLL input and output frequency are not available for
+		 * wm8960 PLL, try to calculte a available pll out frequency and
+		 * set pll again.
+		 */
+		if (!is_pll_freq_available(wm8960->freq_in, pll_out))
+			goto get_pll_freq;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(dac_divs); ++i) {
-		if (wm8960->sysclk == lrclk * dac_divs[i]) {
-			for (j = 0; j < ARRAY_SIZE(bclk_divs); ++j) {
-				sysclk = wm8960->bclk * bclk_divs[j] / 10;
-				if (wm8960->sysclk == sysclk)
+	/* check if the sysclk frequency is available. */
+	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
+		if (sysclk_divs[i] == -1)
+			continue;
+		sysclk /= sysclk_divs[i];
+		for (j = 0; j < ARRAY_SIZE(dac_divs); ++j)
+			if (sysclk == dac_divs[j] * sample_rate)
+				break;
+		for (k = 0; k < ARRAY_SIZE(bclk_divs); ++k)
+			if (sysclk == bclk * bclk_divs[k] / 10)
+				break;
+		if (j != ARRAY_SIZE(dac_divs) && k != ARRAY_SIZE(bclk_divs))
+			break;
+	}
+	if (i != ARRAY_SIZE(sysclk_divs))
+		goto configure_clock;
+
+get_pll_freq:
+	freq_in = wm8960->freq_in;
+	/*
+	 * If the pll out frequcncy set from machine driver is not available,
+	 * try to find a pll out frequcncy and set pll.
+	 */
+	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
+		if (sysclk_divs[i] == -1)
+			continue;
+		for (j = 0; j < ARRAY_SIZE(dac_divs); ++j) {
+			sysclk = sample_rate * dac_divs[j];
+			pll_out = sysclk * sysclk_divs[i];
+
+			for (k = 0; k < ARRAY_SIZE(bclk_divs); ++k) {
+				if (sysclk == bclk * bclk_divs[k] / 10 &&
+				    is_pll_freq_available(freq_in, pll_out)) {
+					wm8960_set_pll(dai, freq_in, pll_out);
 					break;
+				} else
+					continue;
 			}
-			if(j != ARRAY_SIZE(bclk_divs))
+			if (k != ARRAY_SIZE(bclk_divs))
 				break;
 		}
+		if (j != ARRAY_SIZE(dac_divs))
+			break;
 	}
 
-	if (i == ARRAY_SIZE(dac_divs)) {
-		dev_err(codec->dev, "Unsupported sysclk %d\n", wm8960->sysclk);
-		return;
+	if (i == ARRAY_SIZE(sysclk_divs)) {
+		dev_err(codec->dev, "failed to configure clock\n");
+		return -EINVAL;
 	}
 
+configure_clock:
+	snd_soc_update_bits(codec, WM8960_CLOCK1, 3 << 1, i << 1);
 	/*
 	 * configure frame clock. If ADCLRC configure as GPIO pin, DACLRC
 	 * pin is used as a frame clock for ADCs and DACs.
 	 */
 	if (iface2 & (1<<6))
-		snd_soc_update_bits(codec, WM8960_CLOCK1, 0x7 << 3, i << 3);
+		snd_soc_update_bits(codec, WM8960_CLOCK1, 0x7 << 3, j << 3);
 	else if (tx)
-		snd_soc_update_bits(codec, WM8960_CLOCK1, 0x7 << 3, i << 3);
+		snd_soc_update_bits(codec, WM8960_CLOCK1, 0x7 << 3, j << 3);
 	else if (!tx)
-		snd_soc_update_bits(codec, WM8960_CLOCK1, 0x7 << 6, i << 6);
+		snd_soc_update_bits(codec, WM8960_CLOCK1, 0x7 << 6, j << 6);
 
 	/* configure bit clock */
-	snd_soc_update_bits(codec, WM8960_CLOCK2, 0xf, j);
+	snd_soc_update_bits(codec, WM8960_CLOCK2, 0xf, k);
+	return 0;
 }
 
 static int wm8960_hw_params(struct snd_pcm_substream *substream,
@@ -638,13 +703,8 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = dai->codec;
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 	u16 iface = snd_soc_read(codec, WM8960_IFACE1) & 0xfff3;
-	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	int i;
 
-	wm8960->bclk = snd_soc_params_to_bclk(params);
-	if (params_channels(params) == 1)
-		wm8960->bclk *= 2;
-
 	/* bit size */
 	switch (params_width(params)) {
 	case 16:
@@ -682,9 +742,7 @@ static int wm8960_hw_params(struct snd_pcm_substream *substream,
 	/* set iface */
 	snd_soc_write(codec, WM8960_IFACE1, iface);
 
-	wm8960_configure_clocking(codec, tx, params_rate(params));
-
-	return 0;
+	return wm8960_configure_clocking(substream, params, dai);
 }
 
 static int wm8960_mute(struct snd_soc_dai *dai, int mute)
@@ -892,6 +950,28 @@ struct _pll_div {
 	u32 k:24;
 };
 
+static bool is_pll_freq_available(unsigned int source, unsigned int target)
+{
+	unsigned int Ndiv;
+
+	if (source == 0 || target == 0)
+		return false;
+
+	/* Scale up target to PLL operating frequency */
+	target *= 4;
+	Ndiv = target / source;
+
+	if (Ndiv < 6) {
+		source >>= 1;
+		Ndiv = target / source;
+	}
+
+	if ((Ndiv < 6) || (Ndiv > 12))
+		return false;
+
+	return true;
+}
+
 /* The size in bits of the pll divide multiplied by 10
  * to allow rounding later */
 #define FIXED_PLL_SIZE ((1 << 24) * 10)
@@ -916,7 +996,7 @@ static int pll_factors(unsigned int source, unsigned int target,
 		pll_div->pre_div = 0;
 
 	if ((Ndiv < 6) || (Ndiv > 12)) {
-		pr_err("WM8960 PLL: Unsupported N=%d\n", Ndiv);
+		pr_debug("WM8960 PLL: Unsupported N=%d\n", Ndiv);
 		return -EINVAL;
 	}
 
@@ -943,8 +1023,8 @@ static int pll_factors(unsigned int source, unsigned int target,
 	return 0;
 }
 
-static int wm8960_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
-		int source, unsigned int freq_in, unsigned int freq_out)
+static int wm8960_set_pll(struct snd_soc_dai *codec_dai,
+		unsigned int freq_in, unsigned int freq_out)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	u16 reg;
@@ -986,6 +1066,17 @@ static int wm8960_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
 	return 0;
 }
 
+static int wm8960_set_dai_pll(struct snd_soc_dai *codec_dai, int pll_id,
+		int source, unsigned int freq_in, unsigned int freq_out)
+{
+	struct snd_soc_codec *codec = codec_dai->codec;
+	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
+
+	wm8960->freq_in = freq_in;
+
+	return wm8960_set_pll(codec_dai, freq_in, freq_out);
+}
+
 static int wm8960_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		int div_id, int div)
 {
@@ -1048,6 +1139,7 @@ static int wm8960_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 	}
 
 	wm8960->sysclk = freq;
+	wm8960->clk_id = clk_id;
 
 	return 0;
 }
-- 
1.9.1
