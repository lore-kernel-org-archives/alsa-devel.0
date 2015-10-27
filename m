From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v3 2/2] ASoC: wm9713: use snd_soc_*() calls to update ac97 registers
Date: Tue, 27 Oct 2015 22:58:22 +0100
Message-ID: <1445983102-15490-2-git-send-email-robert.jarzmik@free.fr>
References: <1445983102-15490-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445983102-15490-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: alsa-devel@alsa-project.org

Convert wm9713 to use the more modern registers manipulation functions,
such as snd_soc_read(), snd_soc_write() and snd_soc_update_bits().

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 sound/soc/codecs/wm9713.c | 140 +++++++++++++++++-----------------------------
 1 file changed, 52 insertions(+), 88 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 8e2cc1112e40..15c0cbbadec2 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -40,16 +40,6 @@ struct wm9713_priv {
 	struct mutex lock;
 };
 
-static unsigned int ac97_read(struct snd_soc_codec *codec, unsigned int reg)
-{
-	return snd_soc_read(codec, reg);
-}
-static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
-		      unsigned int val)
-{
-	return snd_soc_write(codec, reg, val);
-}
-
 #define HPL_MIXER 0
 #define HPR_MIXER 1
 
@@ -203,18 +193,15 @@ static int wm9713_voice_shutdown(struct snd_soc_dapm_widget *w,
 				 struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	u16 status, rate;
 
 	if (WARN_ON(event != SND_SOC_DAPM_PRE_PMD))
 		return -EINVAL;
 
 	/* Gracefully shut down the voice interface. */
-	status = ac97_read(codec, AC97_EXTENDED_MID) | 0x1000;
-	rate = ac97_read(codec, AC97_HANDSET_RATE) & 0xF0FF;
-	ac97_write(codec, AC97_HANDSET_RATE, rate | 0x0200);
+	snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x0f00, 0x0200);
 	schedule_timeout_interruptible(msecs_to_jiffies(1));
-	ac97_write(codec, AC97_HANDSET_RATE, rate | 0x0F00);
-	ac97_write(codec, AC97_EXTENDED_MID, status);
+	snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x0f00, 0x0f00);
+	snd_soc_update_bits(codec, AC97_EXTENDED_MID, 0x1000, 0x1000);
 
 	return 0;
 }
@@ -834,10 +821,8 @@ static int wm9713_set_pll(struct snd_soc_codec *codec,
 	/* turn PLL off ? */
 	if (freq_in == 0) {
 		/* disable PLL power and select ext source */
-		reg = ac97_read(codec, AC97_HANDSET_RATE);
-		ac97_write(codec, AC97_HANDSET_RATE, reg | 0x0080);
-		reg = ac97_read(codec, AC97_EXTENDED_MID);
-		ac97_write(codec, AC97_EXTENDED_MID, reg | 0x0200);
+		snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x0080, 0x0080);
+		snd_soc_update_bits(codec, AC97_EXTENDED_MID, 0x0200, 0x0200);
 		wm9713->pll_in = 0;
 		return 0;
 	}
@@ -847,7 +832,7 @@ static int wm9713_set_pll(struct snd_soc_codec *codec,
 	if (pll_div.k == 0) {
 		reg = (pll_div.n << 12) | (pll_div.lf << 11) |
 			(pll_div.divsel << 9) | (pll_div.divctl << 8);
-		ac97_write(codec, AC97_LINE1_LEVEL, reg);
+		snd_soc_write(codec, AC97_LINE1_LEVEL, reg);
 	} else {
 		/* write the fractional k to the reg 0x46 pages */
 		reg2 = (pll_div.n << 12) | (pll_div.lf << 11) | (1 << 10) |
@@ -855,33 +840,31 @@ static int wm9713_set_pll(struct snd_soc_codec *codec,
 
 		/* K [21:20] */
 		reg = reg2 | (0x5 << 4) | (pll_div.k >> 20);
-		ac97_write(codec, AC97_LINE1_LEVEL, reg);
+		snd_soc_write(codec, AC97_LINE1_LEVEL, reg);
 
 		/* K [19:16] */
 		reg = reg2 | (0x4 << 4) | ((pll_div.k >> 16) & 0xf);
-		ac97_write(codec, AC97_LINE1_LEVEL, reg);
+		snd_soc_write(codec, AC97_LINE1_LEVEL, reg);
 
 		/* K [15:12] */
 		reg = reg2 | (0x3 << 4) | ((pll_div.k >> 12) & 0xf);
-		ac97_write(codec, AC97_LINE1_LEVEL, reg);
+		snd_soc_write(codec, AC97_LINE1_LEVEL, reg);
 
 		/* K [11:8] */
 		reg = reg2 | (0x2 << 4) | ((pll_div.k >> 8) & 0xf);
-		ac97_write(codec, AC97_LINE1_LEVEL, reg);
+		snd_soc_write(codec, AC97_LINE1_LEVEL, reg);
 
 		/* K [7:4] */
 		reg = reg2 | (0x1 << 4) | ((pll_div.k >> 4) & 0xf);
-		ac97_write(codec, AC97_LINE1_LEVEL, reg);
+		snd_soc_write(codec, AC97_LINE1_LEVEL, reg);
 
 		reg = reg2 | (0x0 << 4) | (pll_div.k & 0xf); /* K [3:0] */
-		ac97_write(codec, AC97_LINE1_LEVEL, reg);
+		snd_soc_write(codec, AC97_LINE1_LEVEL, reg);
 	}
 
 	/* turn PLL on and select as source */
-	reg = ac97_read(codec, AC97_EXTENDED_MID);
-	ac97_write(codec, AC97_EXTENDED_MID, reg & 0xfdff);
-	reg = ac97_read(codec, AC97_HANDSET_RATE);
-	ac97_write(codec, AC97_HANDSET_RATE, reg & 0xff7f);
+	snd_soc_update_bits(codec, AC97_EXTENDED_MID, 0x0200, 0x0000);
+	snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x0080, 0x0000);
 	wm9713->pll_in = freq_in;
 
 	/* wait 10ms AC97 link frames for the link to stabilise */
@@ -904,10 +887,10 @@ static int wm9713_set_dai_tristate(struct snd_soc_dai *codec_dai,
 	int tristate)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 reg = ac97_read(codec, AC97_CENTER_LFE_MASTER) & 0x9fff;
 
 	if (tristate)
-		ac97_write(codec, AC97_CENTER_LFE_MASTER, reg);
+		snd_soc_update_bits(codec, AC97_CENTER_LFE_MASTER,
+				    0x6000, 0x0000);
 
 	return 0;
 }
@@ -920,36 +903,30 @@ static int wm9713_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		int div_id, int div)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 reg;
 
 	switch (div_id) {
 	case WM9713_PCMCLK_DIV:
-		reg = ac97_read(codec, AC97_HANDSET_RATE) & 0xf0ff;
-		ac97_write(codec, AC97_HANDSET_RATE, reg | div);
+		snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x0f00, div);
 		break;
 	case WM9713_CLKA_MULT:
-		reg = ac97_read(codec, AC97_HANDSET_RATE) & 0xfffd;
-		ac97_write(codec, AC97_HANDSET_RATE, reg | div);
+		snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x0002, div);
 		break;
 	case WM9713_CLKB_MULT:
-		reg = ac97_read(codec, AC97_HANDSET_RATE) & 0xfffb;
-		ac97_write(codec, AC97_HANDSET_RATE, reg | div);
+		snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x0004, div);
 		break;
 	case WM9713_HIFI_DIV:
-		reg = ac97_read(codec, AC97_HANDSET_RATE) & 0x8fff;
-		ac97_write(codec, AC97_HANDSET_RATE, reg | div);
+		snd_soc_update_bits(codec, AC97_HANDSET_RATE, 0x7000, div);
 		break;
 	case WM9713_PCMBCLK_DIV:
-		reg = ac97_read(codec, AC97_CENTER_LFE_MASTER) & 0xf1ff;
-		ac97_write(codec, AC97_CENTER_LFE_MASTER, reg | div);
+		snd_soc_update_bits(codec, AC97_CENTER_LFE_MASTER, 0x0e00, div);
 		break;
 	case WM9713_PCMCLK_PLL_DIV:
-		reg = ac97_read(codec, AC97_LINE1_LEVEL) & 0xff80;
-		ac97_write(codec, AC97_LINE1_LEVEL, reg | 0x60 | div);
+		snd_soc_update_bits(codec, AC97_LINE1_LEVEL,
+				    0x007f, div | 0x60);
 		break;
 	case WM9713_HIFI_PLL_DIV:
-		reg = ac97_read(codec, AC97_LINE1_LEVEL) & 0xff80;
-		ac97_write(codec, AC97_LINE1_LEVEL, reg | 0x70 | div);
+		snd_soc_update_bits(codec, AC97_LINE1_LEVEL,
+				    0x007f, div | 0x70);
 		break;
 	default:
 		return -EINVAL;
@@ -962,7 +939,7 @@ static int wm9713_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 gpio = ac97_read(codec, AC97_GPIO_CFG) & 0xffc5;
+	u16 gpio = snd_soc_read(codec, AC97_GPIO_CFG) & 0xffc5;
 	u16 reg = 0x8000;
 
 	/* clock masters */
@@ -1015,8 +992,8 @@ static int wm9713_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		break;
 	}
 
-	ac97_write(codec, AC97_GPIO_CFG, gpio);
-	ac97_write(codec, AC97_CENTER_LFE_MASTER, reg);
+	snd_soc_write(codec, AC97_GPIO_CFG, gpio);
+	snd_soc_write(codec, AC97_CENTER_LFE_MASTER, reg);
 	return 0;
 }
 
@@ -1025,24 +1002,24 @@ static int wm9713_pcm_hw_params(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	u16 reg = ac97_read(codec, AC97_CENTER_LFE_MASTER) & 0xfff3;
 
+	/* enable PCM interface in master mode */
 	switch (params_width(params)) {
 	case 16:
 		break;
 	case 20:
-		reg |= 0x0004;
+		snd_soc_update_bits(codec, AC97_CENTER_LFE_MASTER,
+				    0x000c, 0x0004);
 		break;
 	case 24:
-		reg |= 0x0008;
+		snd_soc_update_bits(codec, AC97_CENTER_LFE_MASTER,
+				    0x000c, 0x0008);
 		break;
 	case 32:
-		reg |= 0x000c;
+		snd_soc_update_bits(codec, AC97_CENTER_LFE_MASTER,
+				    0x000c, 0x000c);
 		break;
 	}
-
-	/* enable PCM interface in master mode */
-	ac97_write(codec, AC97_CENTER_LFE_MASTER, reg);
 	return 0;
 }
 
@@ -1052,17 +1029,15 @@ static int ac97_hifi_prepare(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = dai->codec;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int reg;
-	u16 vra;
 
-	vra = ac97_read(codec, AC97_EXTENDED_STATUS);
-	ac97_write(codec, AC97_EXTENDED_STATUS, vra | 0x1);
+	snd_soc_update_bits(codec, AC97_EXTENDED_STATUS, 0x0001, 0x0001);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		reg = AC97_PCM_FRONT_DAC_RATE;
 	else
 		reg = AC97_PCM_LR_ADC_RATE;
 
-	return ac97_write(codec, reg, runtime->rate);
+	return snd_soc_write(codec, reg, runtime->rate);
 }
 
 static int ac97_aux_prepare(struct snd_pcm_substream *substream,
@@ -1070,17 +1045,14 @@ static int ac97_aux_prepare(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	u16 vra, xsle;
 
-	vra = ac97_read(codec, AC97_EXTENDED_STATUS);
-	ac97_write(codec, AC97_EXTENDED_STATUS, vra | 0x1);
-	xsle = ac97_read(codec, AC97_PCI_SID);
-	ac97_write(codec, AC97_PCI_SID, xsle | 0x8000);
+	snd_soc_update_bits(codec, AC97_EXTENDED_STATUS, 0x0001, 0x0001);
+	snd_soc_update_bits(codec, AC97_PCI_SID, 0x8000, 0x8000);
 
 	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
 		return -ENODEV;
 
-	return ac97_write(codec, AC97_PCM_SURR_DAC_RATE, runtime->rate);
+	return snd_soc_write(codec, AC97_PCM_SURR_DAC_RATE, runtime->rate);
 }
 
 #define WM9713_RATES (SNDRV_PCM_RATE_8000  |	\
@@ -1169,27 +1141,23 @@ static struct snd_soc_dai_driver wm9713_dai[] = {
 static int wm9713_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
 {
-	u16 reg;
-
 	switch (level) {
 	case SND_SOC_BIAS_ON:
 		/* enable thermal shutdown */
-		reg = ac97_read(codec, AC97_EXTENDED_MID) & 0x1bff;
-		ac97_write(codec, AC97_EXTENDED_MID, reg);
+		snd_soc_update_bits(codec, AC97_EXTENDED_MID, 0xe400, 0x0000);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		/* enable master bias and vmid */
-		reg = ac97_read(codec, AC97_EXTENDED_MID) & 0x3bff;
-		ac97_write(codec, AC97_EXTENDED_MID, reg);
-		ac97_write(codec, AC97_POWERDOWN, 0x0000);
+		snd_soc_update_bits(codec, AC97_EXTENDED_MID, 0xc400, 0x0000);
+		snd_soc_write(codec, AC97_POWERDOWN, 0x0000);
 		break;
 	case SND_SOC_BIAS_OFF:
 		/* disable everything including AC link */
-		ac97_write(codec, AC97_EXTENDED_MID, 0xffff);
-		ac97_write(codec, AC97_EXTENDED_MSTATUS, 0xffff);
-		ac97_write(codec, AC97_POWERDOWN, 0xffff);
+		snd_soc_write(codec, AC97_EXTENDED_MID, 0xffff);
+		snd_soc_write(codec, AC97_EXTENDED_MSTATUS, 0xffff);
+		snd_soc_write(codec, AC97_POWERDOWN, 0xffff);
 		break;
 	}
 	return 0;
@@ -1197,19 +1165,17 @@ static int wm9713_set_bias_level(struct snd_soc_codec *codec,
 
 static int wm9713_soc_suspend(struct snd_soc_codec *codec)
 {
-	u16 reg;
-
 	snd_soc_cache_sync(codec);
 	regcache_cache_bypass(codec->component.regmap, true);
 
 	/* Disable everything except touchpanel - that will be handled
 	 * by the touch driver and left disabled if touch is not in
 	 * use. */
-	reg = ac97_read(codec, AC97_EXTENDED_MID);
-	ac97_write(codec, AC97_EXTENDED_MID, reg | 0x7fff);
-	ac97_write(codec, AC97_EXTENDED_MSTATUS, 0xffff);
-	ac97_write(codec, AC97_POWERDOWN, 0x6f00);
-	ac97_write(codec, AC97_POWERDOWN, 0xffff);
+	snd_soc_update_bits(codec, AC97_EXTENDED_MID, 0x7fff,
+				 0x7fff);
+	snd_soc_write(codec, AC97_EXTENDED_MSTATUS, 0xffff);
+	snd_soc_write(codec, AC97_POWERDOWN, 0x6f00);
+	snd_soc_write(codec, AC97_POWERDOWN, 0xffff);
 
 	return 0;
 }
@@ -1244,7 +1210,6 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 {
 	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
 	struct regmap *regmap;
-	int reg;
 
 	wm9713->ac97 = snd_soc_new_ac97_codec(codec, WM9713_VENDOR_ID,
 		WM9713_VENDOR_ID_MASK);
@@ -1260,8 +1225,7 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 	snd_soc_codec_init_regmap(codec, regmap);
 
 	/* unmute the adc - move to kcontrol */
-	reg = ac97_read(codec, AC97_CD) & 0x7fff;
-	ac97_write(codec, AC97_CD, reg);
+	snd_soc_update_bits(codec, AC97_CD, 0x7fff, 0x0000);
 
 	return 0;
 }
-- 
2.1.4
