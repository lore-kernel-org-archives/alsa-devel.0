From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/8] ASoC: Factor out WM8580 register cache code
Date: Mon,  3 Aug 2009 17:09:46 +0100
Message-ID: <1249315790-22814-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1249315790-22814-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249315790-22814-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1249315790-22814-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 795B924791
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Aug 2009 18:09:54 +0200 (CEST)
In-Reply-To: <1249315790-22814-3-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Note the slightly tricky cache usage in the volume update function due
to the requirement for a separate write for the VU bit.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8580.c |  148 ++++++++++++--------------------------------
 1 files changed, 41 insertions(+), 107 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 97b9ed9..2250ade 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -205,73 +205,6 @@ struct wm8580_priv {
 	struct pll_state b;
 };
 
-/*
- * read wm8580 register cache
- */
-static inline unsigned int wm8580_read_reg_cache(struct snd_soc_codec *codec,
-	unsigned int reg)
-{
-	u16 *cache = codec->reg_cache;
-	BUG_ON(reg >= ARRAY_SIZE(wm8580_reg));
-	return cache[reg];
-}
-
-/*
- * write wm8580 register cache
- */
-static inline void wm8580_write_reg_cache(struct snd_soc_codec *codec,
-	unsigned int reg, unsigned int value)
-{
-	u16 *cache = codec->reg_cache;
-
-	cache[reg] = value;
-}
-
-/*
- * write to the WM8580 register space
- */
-static int wm8580_write(struct snd_soc_codec *codec, unsigned int reg,
-	unsigned int value)
-{
-	u8 data[2];
-
-	BUG_ON(reg >= ARRAY_SIZE(wm8580_reg));
-
-	/* Registers are 9 bits wide */
-	value &= 0x1ff;
-
-	switch (reg) {
-	case WM8580_RESET:
-		/* Uncached */
-		break;
-	default:
-		if (value == wm8580_read_reg_cache(codec, reg))
-			return 0;
-	}
-
-	/* data is
-	 *   D15..D9 WM8580 register offset
-	 *   D8...D0 register data
-	 */
-	data[0] = (reg << 1) | ((value >> 8) & 0x0001);
-	data[1] = value & 0x00ff;
-
-	wm8580_write_reg_cache(codec, reg, value);
-	if (codec->hw_write(codec->control_data, data, 2) == 2)
-		return 0;
-	else
-		return -EIO;
-}
-
-static inline unsigned int wm8580_read(struct snd_soc_codec *codec,
-				       unsigned int reg)
-{
-	switch (reg) {
-	default:
-		return wm8580_read_reg_cache(codec, reg);
-	}
-}
-
 static const DECLARE_TLV_DB_SCALE(dac_tlv, -12750, 50, 1);
 
 static int wm8580_out_vu(struct snd_kcontrol *kcontrol,
@@ -280,25 +213,22 @@ static int wm8580_out_vu(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	u16 *reg_cache = codec->reg_cache;
 	unsigned int reg = mc->reg;
 	unsigned int reg2 = mc->rreg;
 	int ret;
-	u16 val;
 
 	/* Clear the register cache so we write without VU set */
-	wm8580_write_reg_cache(codec, reg, 0);
-	wm8580_write_reg_cache(codec, reg2, 0);
+	reg_cache[reg] = 0;
+	reg_cache[reg2] = 0;
 
 	ret = snd_soc_put_volsw_2r(kcontrol, ucontrol);
 	if (ret < 0)
 		return ret;
 
 	/* Now write again with the volume update bit set */
-	val = wm8580_read_reg_cache(codec, reg);
-	wm8580_write(codec, reg, val | 0x0100);
-
-	val = wm8580_read_reg_cache(codec, reg2);
-	wm8580_write(codec, reg2, val | 0x0100);
+	snd_soc_update_bits(codec, reg, 0x100, 0x100);
+	snd_soc_update_bits(codec, reg2, 0x100, 0x100);
 
 	return 0;
 }
@@ -521,27 +451,27 @@ static int wm8580_set_dai_pll(struct snd_soc_dai *codec_dai,
 	/* Always disable the PLL - it is not safe to leave it running
 	 * while reprogramming it.
 	 */
-	reg = wm8580_read(codec, WM8580_PWRDN2);
-	wm8580_write(codec, WM8580_PWRDN2, reg | pwr_mask);
+	reg = snd_soc_read(codec, WM8580_PWRDN2);
+	snd_soc_write(codec, WM8580_PWRDN2, reg | pwr_mask);
 
 	if (!freq_in || !freq_out)
 		return 0;
 
-	wm8580_write(codec, WM8580_PLLA1 + offset, pll_div.k & 0x1ff);
-	wm8580_write(codec, WM8580_PLLA2 + offset, (pll_div.k >> 9) & 0xff);
-	wm8580_write(codec, WM8580_PLLA3 + offset,
+	snd_soc_write(codec, WM8580_PLLA1 + offset, pll_div.k & 0x1ff);
+	snd_soc_write(codec, WM8580_PLLA2 + offset, (pll_div.k >> 9) & 0xff);
+	snd_soc_write(codec, WM8580_PLLA3 + offset,
 		     (pll_div.k >> 18 & 0xf) | (pll_div.n << 4));
 
-	reg = wm8580_read(codec, WM8580_PLLA4 + offset);
+	reg = snd_soc_read(codec, WM8580_PLLA4 + offset);
 	reg &= ~0x3f;
 	reg |= pll_div.prescale | pll_div.postscale << 1 |
 		pll_div.freqmode << 3;
 
-	wm8580_write(codec, WM8580_PLLA4 + offset, reg);
+	snd_soc_write(codec, WM8580_PLLA4 + offset, reg);
 
 	/* All done, turn it on */
-	reg = wm8580_read(codec, WM8580_PWRDN2);
-	wm8580_write(codec, WM8580_PWRDN2, reg & ~pwr_mask);
+	reg = snd_soc_read(codec, WM8580_PWRDN2);
+	snd_soc_write(codec, WM8580_PWRDN2, reg & ~pwr_mask);
 
 	return 0;
 }
@@ -556,7 +486,7 @@ static int wm8580_paif_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->card->codec;
-	u16 paifb = wm8580_read(codec, WM8580_PAIF3 + dai->id);
+	u16 paifb = snd_soc_read(codec, WM8580_PAIF3 + dai->id);
 
 	paifb &= ~WM8580_AIF_LENGTH_MASK;
 	/* bit size */
@@ -576,7 +506,7 @@ static int wm8580_paif_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	wm8580_write(codec, WM8580_PAIF3 + dai->id, paifb);
+	snd_soc_write(codec, WM8580_PAIF3 + dai->id, paifb);
 	return 0;
 }
 
@@ -588,8 +518,8 @@ static int wm8580_set_paif_dai_fmt(struct snd_soc_dai *codec_dai,
 	unsigned int aifb;
 	int can_invert_lrclk;
 
-	aifa = wm8580_read(codec, WM8580_PAIF1 + codec_dai->id);
-	aifb = wm8580_read(codec, WM8580_PAIF3 + codec_dai->id);
+	aifa = snd_soc_read(codec, WM8580_PAIF1 + codec_dai->id);
+	aifb = snd_soc_read(codec, WM8580_PAIF3 + codec_dai->id);
 
 	aifb &= ~(WM8580_AIF_FMT_MASK | WM8580_AIF_LRP | WM8580_AIF_BCP);
 
@@ -655,8 +585,8 @@ static int wm8580_set_paif_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	wm8580_write(codec, WM8580_PAIF1 + codec_dai->id, aifa);
-	wm8580_write(codec, WM8580_PAIF3 + codec_dai->id, aifb);
+	snd_soc_write(codec, WM8580_PAIF1 + codec_dai->id, aifa);
+	snd_soc_write(codec, WM8580_PAIF3 + codec_dai->id, aifb);
 
 	return 0;
 }
@@ -669,7 +599,7 @@ static int wm8580_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 
 	switch (div_id) {
 	case WM8580_MCLK:
-		reg = wm8580_read(codec, WM8580_PLLB4);
+		reg = snd_soc_read(codec, WM8580_PLLB4);
 		reg &= ~WM8580_PLLB4_MCLKOUTSRC_MASK;
 
 		switch (div) {
@@ -691,11 +621,11 @@ static int wm8580_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		default:
 			return -EINVAL;
 		}
-		wm8580_write(codec, WM8580_PLLB4, reg);
+		snd_soc_write(codec, WM8580_PLLB4, reg);
 		break;
 
 	case WM8580_DAC_CLKSEL:
-		reg = wm8580_read(codec, WM8580_CLKSEL);
+		reg = snd_soc_read(codec, WM8580_CLKSEL);
 		reg &= ~WM8580_CLKSEL_DAC_CLKSEL_MASK;
 
 		switch (div) {
@@ -713,11 +643,11 @@ static int wm8580_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		default:
 			return -EINVAL;
 		}
-		wm8580_write(codec, WM8580_CLKSEL, reg);
+		snd_soc_write(codec, WM8580_CLKSEL, reg);
 		break;
 
 	case WM8580_CLKOUTSRC:
-		reg = wm8580_read(codec, WM8580_PLLB4);
+		reg = snd_soc_read(codec, WM8580_PLLB4);
 		reg &= ~WM8580_PLLB4_CLKOUTSRC_MASK;
 
 		switch (div) {
@@ -739,7 +669,7 @@ static int wm8580_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 		default:
 			return -EINVAL;
 		}
-		wm8580_write(codec, WM8580_PLLB4, reg);
+		snd_soc_write(codec, WM8580_PLLB4, reg);
 		break;
 
 	default:
@@ -754,14 +684,14 @@ static int wm8580_digital_mute(struct snd_soc_dai *codec_dai, int mute)
 	struct snd_soc_codec *codec = codec_dai->codec;
 	unsigned int reg;
 
-	reg = wm8580_read(codec, WM8580_DAC_CONTROL5);
+	reg = snd_soc_read(codec, WM8580_DAC_CONTROL5);
 
 	if (mute)
 		reg |= WM8580_DAC_CONTROL5_MUTEALL;
 	else
 		reg &= ~WM8580_DAC_CONTROL5_MUTEALL;
 
-	wm8580_write(codec, WM8580_DAC_CONTROL5, reg);
+	snd_soc_write(codec, WM8580_DAC_CONTROL5, reg);
 
 	return 0;
 }
@@ -778,20 +708,20 @@ static int wm8580_set_bias_level(struct snd_soc_codec *codec,
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->bias_level == SND_SOC_BIAS_OFF) {
 			/* Power up and get individual control of the DACs */
-			reg = wm8580_read(codec, WM8580_PWRDN1);
+			reg = snd_soc_read(codec, WM8580_PWRDN1);
 			reg &= ~(WM8580_PWRDN1_PWDN | WM8580_PWRDN1_ALLDACPD);
-			wm8580_write(codec, WM8580_PWRDN1, reg);
+			snd_soc_write(codec, WM8580_PWRDN1, reg);
 
 			/* Make VMID high impedence */
-			reg = wm8580_read(codec,  WM8580_ADC_CONTROL1);
+			reg = snd_soc_read(codec,  WM8580_ADC_CONTROL1);
 			reg &= ~0x100;
-			wm8580_write(codec, WM8580_ADC_CONTROL1, reg);
+			snd_soc_write(codec, WM8580_ADC_CONTROL1, reg);
 		}
 		break;
 
 	case SND_SOC_BIAS_OFF:
-		reg = wm8580_read(codec, WM8580_PWRDN1);
-		wm8580_write(codec, WM8580_PWRDN1, reg | WM8580_PWRDN1_PWDN);
+		reg = snd_soc_read(codec, WM8580_PWRDN1);
+		snd_soc_write(codec, WM8580_PWRDN1, reg | WM8580_PWRDN1_PWDN);
 		break;
 	}
 	codec->bias_level = level;
@@ -920,8 +850,6 @@ static int wm8580_register(struct wm8580_priv *wm8580)
 	codec->private_data = wm8580;
 	codec->name = "WM8580";
 	codec->owner = THIS_MODULE;
-	codec->read = wm8580_read_reg_cache;
-	codec->write = wm8580_write;
 	codec->bias_level = SND_SOC_BIAS_OFF;
 	codec->set_bias_level = wm8580_set_bias_level;
 	codec->dai = wm8580_dai;
@@ -931,6 +859,12 @@ static int wm8580_register(struct wm8580_priv *wm8580)
 
 	memcpy(codec->reg_cache, wm8580_reg, sizeof(wm8580_reg));
 
+	ret = snd_soc_codec_set_cache_io(codec, 7, 9);
+	if (ret < 0) {
+		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		goto err;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(wm8580->supplies); i++)
 		wm8580->supplies[i].supply = wm8580_supply_names[i];
 
@@ -949,7 +883,7 @@ static int wm8580_register(struct wm8580_priv *wm8580)
 	}
 
 	/* Get the codec into a known state */
-	ret = wm8580_write(codec, WM8580_RESET, 0);
+	ret = snd_soc_write(codec, WM8580_RESET, 0);
 	if (ret != 0) {
 		dev_err(codec->dev, "Failed to reset codec: %d\n", ret);
 		goto err_regulator_enable;
-- 
1.6.3.3
