From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH] ASoC: wm9713: convert to regmap
Date: Sat, 24 Oct 2015 22:12:19 +0200
Message-ID: <1445717539-409-1-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr
 [80.12.242.124])
 by alsa0.perex.cz (Postfix) with ESMTP id 69A7426580E
 for <alsa-devel@alsa-project.org>; Sat, 24 Oct 2015 22:18:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Robert Jarzmik <robert.jarzmik@free.fr>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Convert the Wolfson WM9713 to regmap API. This will leverage all the
regmap functions (debug, registers update, etc ...).

As a bonus, this will pave the path to gpio chip introduction, and
devicetree support.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 sound/soc/codecs/Kconfig  |   1 +
 sound/soc/codecs/wm9713.c | 284 ++++++++++++++++++++++++----------------------
 2 files changed, 147 insertions(+), 138 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 0c9733ecd17f..ba306f8f3717 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -879,6 +879,7 @@ config SND_SOC_WM9712
 
 config SND_SOC_WM9713
 	tristate
+	select REGMAP_AC97
 
 # Amp
 config SND_SOC_LM4857
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 4083a5130cbd..18f371b2add5 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/regmap.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
@@ -39,34 +40,6 @@ struct wm9713_priv {
 	struct mutex lock;
 };
 
-static unsigned int ac97_read(struct snd_soc_codec *codec,
-	unsigned int reg);
-static int ac97_write(struct snd_soc_codec *codec,
-	unsigned int reg, unsigned int val);
-
-/*
- * WM9713 register cache
- * Reg 0x3c bit 15 is used by touch driver.
- */
-static const u16 wm9713_reg[] = {
-	0x6174, 0x8080, 0x8080, 0x8080,
-	0xc880, 0xe808, 0xe808, 0x0808,
-	0x00da, 0x8000, 0xd600, 0xaaa0,
-	0xaaa0, 0xaaa0, 0x0000, 0x0000,
-	0x0f0f, 0x0040, 0x0000, 0x7f00,
-	0x0405, 0x0410, 0xbb80, 0xbb80,
-	0x0000, 0xbb80, 0x0000, 0x4523,
-	0x0000, 0x2000, 0x7eff, 0xffff,
-	0x0000, 0x0000, 0x0080, 0x0000,
-	0x0000, 0x0000, 0xfffe, 0xffff,
-	0x0000, 0x0000, 0x0000, 0xfffe,
-	0x4000, 0x0000, 0x0000, 0x0000,
-	0xb032, 0x3e00, 0x0000, 0x0000,
-	0x0000, 0x0000, 0x0000, 0x0000,
-	0x0000, 0x0000, 0x0000, 0x0006,
-	0x0001, 0x0000, 0x574d, 0x4c13,
-};
-
 #define HPL_MIXER 0
 #define HPR_MIXER 1
 
@@ -220,18 +193,15 @@ static int wm9713_voice_shutdown(struct snd_soc_dapm_widget *w,
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
@@ -674,39 +644,97 @@ static const struct snd_soc_dapm_route wm9713_audio_map[] = {
 	{"Capture Mono Mux", "Right", "Right Capture Source"},
 };
 
-static unsigned int ac97_read(struct snd_soc_codec *codec,
-	unsigned int reg)
+static bool wm9713_readable_reg(struct device *dev, unsigned int reg)
 {
-	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
-	u16 *cache = codec->reg_cache;
-
-	if (reg == AC97_RESET || reg == AC97_GPIO_STATUS ||
-		reg == AC97_VENDOR_ID1 || reg == AC97_VENDOR_ID2 ||
-		reg == AC97_CD)
-		return soc_ac97_ops->read(wm9713->ac97, reg);
-	else {
-		reg = reg >> 1;
-
-		if (reg >= (ARRAY_SIZE(wm9713_reg)))
-			return -EIO;
-
-		return cache[reg];
+	switch (reg) {
+	case AC97_RESET ... AC97_PCM_SURR_DAC_RATE:
+	case AC97_PCM_LR_ADC_RATE:
+	case AC97_CENTER_LFE_MASTER:
+	case AC97_SPDIF ... AC97_LINE1_LEVEL:
+	case AC97_GPIO_CFG ... 0x5c:
+	case AC97_CODEC_CLASS_REV ... AC97_PCI_SID:
+	case 0x74 ... AC97_VENDOR_ID2:
+		return true;
+	default:
+		return false;
 	}
 }
 
-static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
-	unsigned int val)
+static bool wm9713_writeable_reg(struct device *dev, unsigned int reg)
 {
-	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
+	switch (reg) {
+	case AC97_VENDOR_ID1:
+	case AC97_VENDOR_ID2:
+		return false;
+	default:
+		return wm9713_readable_reg(dev, reg);
+	}
+}
 
-	u16 *cache = codec->reg_cache;
-	soc_ac97_ops->write(wm9713->ac97, reg, val);
-	reg = reg >> 1;
-	if (reg < (ARRAY_SIZE(wm9713_reg)))
-		cache[reg] = val;
+static const struct reg_default wm9713_reg_defaults[] = {
+	{ 0x02, 0x8080 },	/* Speaker Output Volume */
+	{ 0x04, 0x8080 },	/* Headphone Output Volume */
+	{ 0x06, 0x8080 },	/* Out3/OUT4 Volume */
+	{ 0x08, 0xc880 },	/* Mono Volume */
+	{ 0x0a, 0xe808 },	/* LINEIN Volume */
+	{ 0x0c, 0xe808 },	/* DAC PGA Volume */
+	{ 0x0e, 0x0808 },	/* MIC PGA Volume */
+	{ 0x10, 0x00da },	/* MIC Routing Control */
+	{ 0x12, 0x8000 },	/* Record PGA Volume */
+	{ 0x14, 0xd600 },	/* Record Routing */
+	{ 0x16, 0xaaa0 },	/* PCBEEP Volume */
+	{ 0x18, 0xaaa0 },	/* VxDAC Volume */
+	{ 0x1a, 0xaaa0 },	/* AUXDAC Volume */
+	{ 0x1c, 0x0000 },	/* Output PGA Mux */
+	{ 0x1e, 0x0000 },	/* DAC 3D control */
+	{ 0x20, 0x0f0f },	/* DAC Tone Control*/
+	{ 0x22, 0x0040 },	/* MIC Input Select & Bias */
+	{ 0x24, 0x0000 },	/* Output Volume Mapping & Jack */
+	{ 0x26, 0x7f00 },	/* Powerdown Ctrl/Stat*/
+	{ 0x28, 0x0405 },	/* Extended Audio ID */
+	{ 0x2a, 0x0410 },	/* Extended Audio Start/Ctrl */
+	{ 0x2c, 0xbb80 },	/* Audio DACs Sample Rate */
+	{ 0x2e, 0xbb80 },	/* AUXDAC Sample Rate */
+	{ 0x32, 0xbb80 },	/* Audio ADCs Sample Rate */
+	{ 0x36, 0x4523 },	/* PCM codec control */
+	{ 0x3a, 0x2000 },	/* SPDIF control */
+	{ 0x3c, 0xfdff },	/* Powerdown 1 */
+	{ 0x3e, 0xffff },	/* Powerdown 2 */
+	{ 0x40, 0x0000 },	/* General Purpose */
+	{ 0x42, 0x0000 },	/* Fast Power-Up Control */
+	{ 0x44, 0x0080 },	/* MCLK/PLL Control */
+	{ 0x46, 0x0000 },	/* MCLK/PLL Control */
+	{ 0x4c, 0xfffe },	/* GPIO Pin Configuration */
+	{ 0x4e, 0xffff },	/* GPIO Pin Polarity / Type */
+	{ 0x50, 0x0000 },	/* GPIO Pin Sticky */
+	{ 0x52, 0x0000 },	/* GPIO Pin Wake-Up */
+				/* GPIO Pin Status */
+	{ 0x56, 0xfffe },	/* GPIO Pin Sharing */
+	{ 0x58, 0x4000 },	/* GPIO PullUp/PullDown */
+	{ 0x5a, 0x0000 },	/* Additional Functions 1 */
+	{ 0x5c, 0x0000 },	/* Additional Functions 2 */
+	{ 0x60, 0xb032 },	/* ALC Control */
+	{ 0x62, 0x3e00 },	/* ALC / Noise Gate Control */
+	{ 0x64, 0x0000 },	/* AUXDAC input control */
+	{ 0x74, 0x0000 },	/* Digitiser Reg 1 */
+	{ 0x76, 0x0006 },	/* Digitiser Reg 2 */
+	{ 0x78, 0x0001 },	/* Digitiser Reg 3 */
+	{ 0x7a, 0x0000 },	/* Digitiser Read Back */
+};
 
-	return 0;
-}
+static const struct regmap_config wm9713_regmap_config = {
+	.reg_bits = 16,
+	.reg_stride = 2,
+	.val_bits = 16,
+	.max_register = 0x7e,
+	.cache_type = REGCACHE_RBTREE,
+
+	.reg_defaults = wm9713_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(wm9713_reg_defaults),
+	.volatile_reg = regmap_ac97_default_volatile,
+	.readable_reg = wm9713_readable_reg,
+	.writeable_reg = wm9713_writeable_reg,
+};
 
 /* PLL divisors */
 struct _pll_div {
@@ -793,10 +821,8 @@ static int wm9713_set_pll(struct snd_soc_codec *codec,
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
@@ -806,7 +832,7 @@ static int wm9713_set_pll(struct snd_soc_codec *codec,
 	if (pll_div.k == 0) {
 		reg = (pll_div.n << 12) | (pll_div.lf << 11) |
 			(pll_div.divsel << 9) | (pll_div.divctl << 8);
-		ac97_write(codec, AC97_LINE1_LEVEL, reg);
+		snd_soc_write(codec, AC97_LINE1_LEVEL, reg);
 	} else {
 		/* write the fractional k to the reg 0x46 pages */
 		reg2 = (pll_div.n << 12) | (pll_div.lf << 11) | (1 << 10) |
@@ -814,33 +840,31 @@ static int wm9713_set_pll(struct snd_soc_codec *codec,
 
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
@@ -863,10 +887,10 @@ static int wm9713_set_dai_tristate(struct snd_soc_dai *codec_dai,
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
@@ -879,36 +903,30 @@ static int wm9713_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
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
@@ -921,7 +939,7 @@ static int wm9713_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		unsigned int fmt)
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
-	u16 gpio = ac97_read(codec, AC97_GPIO_CFG) & 0xffc5;
+	u16 gpio = snd_soc_read(codec, AC97_GPIO_CFG) & 0xffc5;
 	u16 reg = 0x8000;
 
 	/* clock masters */
@@ -974,8 +992,8 @@ static int wm9713_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		break;
 	}
 
-	ac97_write(codec, AC97_GPIO_CFG, gpio);
-	ac97_write(codec, AC97_CENTER_LFE_MASTER, reg);
+	snd_soc_write(codec, AC97_GPIO_CFG, gpio);
+	snd_soc_write(codec, AC97_CENTER_LFE_MASTER, reg);
 	return 0;
 }
 
@@ -984,24 +1002,24 @@ static int wm9713_pcm_hw_params(struct snd_pcm_substream *substream,
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
 
@@ -1011,17 +1029,15 @@ static int ac97_hifi_prepare(struct snd_pcm_substream *substream,
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
@@ -1029,17 +1045,14 @@ static int ac97_aux_prepare(struct snd_pcm_substream *substream,
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
@@ -1128,27 +1141,23 @@ static struct snd_soc_dai_driver wm9713_dai[] = {
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
@@ -1156,16 +1165,14 @@ static int wm9713_set_bias_level(struct snd_soc_codec *codec,
 
 static int wm9713_soc_suspend(struct snd_soc_codec *codec)
 {
-	u16 reg;
-
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
@@ -1203,16 +1210,23 @@ static int wm9713_soc_resume(struct snd_soc_codec *codec)
 static int wm9713_soc_probe(struct snd_soc_codec *codec)
 {
 	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
-	int reg;
+	struct regmap *regmap;
 
 	wm9713->ac97 = snd_soc_new_ac97_codec(codec, WM9713_VENDOR_ID,
 		WM9713_VENDOR_ID_MASK);
 	if (IS_ERR(wm9713->ac97))
 		return PTR_ERR(wm9713->ac97);
 
+	regmap = devm_regmap_init_ac97(wm9713->ac97, &wm9713_regmap_config);
+	if (IS_ERR(regmap)) {
+		snd_soc_free_ac97_codec(wm9713->ac97);
+		return PTR_ERR(regmap);
+	}
+
+	snd_soc_codec_init_regmap(codec, regmap);
+
 	/* unmute the adc - move to kcontrol */
-	reg = ac97_read(codec, AC97_CD) & 0x7fff;
-	ac97_write(codec, AC97_CD, reg);
+	snd_soc_update_bits(codec, AC97_CD, 0x7fff, 0x0000);
 
 	return 0;
 }
@@ -1230,13 +1244,7 @@ static struct snd_soc_codec_driver soc_codec_dev_wm9713 = {
 	.remove = 	wm9713_soc_remove,
 	.suspend =	wm9713_soc_suspend,
 	.resume = 	wm9713_soc_resume,
-	.read = ac97_read,
-	.write = ac97_write,
 	.set_bias_level = wm9713_set_bias_level,
-	.reg_cache_size = ARRAY_SIZE(wm9713_reg),
-	.reg_word_size = sizeof(u16),
-	.reg_cache_step = 2,
-	.reg_cache_default = wm9713_reg,
 
 	.controls = wm9713_snd_ac97_controls,
 	.num_controls = ARRAY_SIZE(wm9713_snd_ac97_controls),
-- 
2.1.4
