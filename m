From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da732x: replace codec to component" to
	the asoc tree
Date: Mon, 12 Feb 2018 12:42:52 +0000
Message-ID: <E1elDRc-0004yY-PP@debutante>
References: <871si91fjc.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A96C267CAE
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:42:55 +0100 (CET)
In-Reply-To: <871si91fjc.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da732x: replace codec to component

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 192ce2fb1a4052b4a2ee01f1cad2f39c0eebeb48 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:00:47 +0000
Subject: [PATCH] ASoC: da732x: replace codec to component

Now we can replace Codec to Component. Let's do it.

Note:
	xxx_codec_xxx()		->	xxx_component_xxx()
	.idle_bias_off = 0	->	.idle_bias_on = 1
	.ignore_pmdown_time = 0	->	.use_pmdown_time = 1
	-			->	.endianness = 1
	-			->	.non_legacy_dai_naming = 1

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da732x.c | 241 +++++++++++++++++++++++-----------------------
 1 file changed, 121 insertions(+), 120 deletions(-)

diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index 83db4d23c90b..de275df8f4ee 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -168,7 +168,7 @@ static const struct reg_default da732x_reg_cache[] = {
 	{ DA732X_REG_UNLOCK		, 0x00 },
 };
 
-static inline int da732x_get_input_div(struct snd_soc_codec *codec, int sysclk)
+static inline int da732x_get_input_div(struct snd_soc_component *component, int sysclk)
 {
 	int val;
 	int ret;
@@ -192,28 +192,28 @@ static inline int da732x_get_input_div(struct snd_soc_codec *codec, int sysclk)
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, DA732X_REG_PLL_CTRL, val);
+	snd_soc_component_write(component, DA732X_REG_PLL_CTRL, val);
 
 	return ret;
 }
 
-static void da732x_set_charge_pump(struct snd_soc_codec *codec, int state)
+static void da732x_set_charge_pump(struct snd_soc_component *component, int state)
 {
 	switch (state) {
 	case DA732X_ENABLE_CP:
-		snd_soc_write(codec, DA732X_REG_CLK_EN2, DA732X_CP_CLK_EN);
-		snd_soc_write(codec, DA732X_REG_CP_HP2, DA732X_HP_CP_EN |
+		snd_soc_component_write(component, DA732X_REG_CLK_EN2, DA732X_CP_CLK_EN);
+		snd_soc_component_write(component, DA732X_REG_CP_HP2, DA732X_HP_CP_EN |
 			      DA732X_HP_CP_REG | DA732X_HP_CP_PULSESKIP);
-		snd_soc_write(codec, DA732X_REG_CP_CTRL1, DA732X_CP_EN |
+		snd_soc_component_write(component, DA732X_REG_CP_CTRL1, DA732X_CP_EN |
 			      DA732X_CP_CTRL_CPVDD1);
-		snd_soc_write(codec, DA732X_REG_CP_CTRL2,
+		snd_soc_component_write(component, DA732X_REG_CP_CTRL2,
 			      DA732X_CP_MANAGE_MAGNITUDE | DA732X_CP_BOOST);
-		snd_soc_write(codec, DA732X_REG_CP_CTRL3, DA732X_CP_1MHZ);
+		snd_soc_component_write(component, DA732X_REG_CP_CTRL3, DA732X_CP_1MHZ);
 		break;
 	case DA732X_DISABLE_CP:
-		snd_soc_write(codec, DA732X_REG_CLK_EN2, DA732X_CP_CLK_DIS);
-		snd_soc_write(codec, DA732X_REG_CP_HP2, DA732X_HP_CP_DIS);
-		snd_soc_write(codec, DA732X_REG_CP_CTRL1, DA723X_CP_DIS);
+		snd_soc_component_write(component, DA732X_REG_CLK_EN2, DA732X_CP_CLK_DIS);
+		snd_soc_component_write(component, DA732X_REG_CP_HP2, DA732X_HP_CP_DIS);
+		snd_soc_component_write(component, DA732X_REG_CP_CTRL1, DA723X_CP_DIS);
 		break;
 	default:
 		pr_err("Wrong charge pump state\n");
@@ -331,7 +331,7 @@ static SOC_ENUM_SINGLE_DECL(da732x_adc2_voice_filter_enum,
 static int da732x_hpf_set(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct soc_enum *enum_ctrl = (struct soc_enum *)kcontrol->private_value;
 	unsigned int reg = enum_ctrl->reg;
 	unsigned int sel = ucontrol->value.enumerated.item[0];
@@ -351,7 +351,7 @@ static int da732x_hpf_set(struct snd_kcontrol *kcontrol,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, reg, DA732X_HPF_MASK, bits);
+	snd_soc_component_update_bits(component, reg, DA732X_HPF_MASK, bits);
 
 	return 0;
 }
@@ -359,12 +359,12 @@ static int da732x_hpf_set(struct snd_kcontrol *kcontrol,
 static int da732x_hpf_get(struct snd_kcontrol *kcontrol,
 			  struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct soc_enum *enum_ctrl = (struct soc_enum *)kcontrol->private_value;
 	unsigned int reg = enum_ctrl->reg;
 	int val;
 
-	val = snd_soc_read(codec, reg) & DA732X_HPF_MASK;
+	val = snd_soc_component_read32(component, reg) & DA732X_HPF_MASK;
 
 	switch (val) {
 	case DA732X_HPF_VOICE_EN:
@@ -609,18 +609,18 @@ static const struct snd_kcontrol_new da732x_snd_controls[] = {
 static int da732x_adc_event(struct snd_soc_dapm_widget *w,
 			    struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		switch (w->reg) {
 		case DA732X_REG_ADC1_PD:
-			snd_soc_update_bits(codec, DA732X_REG_CLK_EN3,
+			snd_soc_component_update_bits(component, DA732X_REG_CLK_EN3,
 					    DA732X_ADCA_BB_CLK_EN,
 					    DA732X_ADCA_BB_CLK_EN);
 			break;
 		case DA732X_REG_ADC2_PD:
-			snd_soc_update_bits(codec, DA732X_REG_CLK_EN3,
+			snd_soc_component_update_bits(component, DA732X_REG_CLK_EN3,
 					    DA732X_ADCC_BB_CLK_EN,
 					    DA732X_ADCC_BB_CLK_EN);
 			break;
@@ -628,24 +628,24 @@ static int da732x_adc_event(struct snd_soc_dapm_widget *w,
 			return -EINVAL;
 		}
 
-		snd_soc_update_bits(codec, w->reg, DA732X_ADC_RST_MASK,
+		snd_soc_component_update_bits(component, w->reg, DA732X_ADC_RST_MASK,
 				    DA732X_ADC_SET_ACT);
-		snd_soc_update_bits(codec, w->reg, DA732X_ADC_PD_MASK,
+		snd_soc_component_update_bits(component, w->reg, DA732X_ADC_PD_MASK,
 				    DA732X_ADC_ON);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		snd_soc_update_bits(codec, w->reg, DA732X_ADC_PD_MASK,
+		snd_soc_component_update_bits(component, w->reg, DA732X_ADC_PD_MASK,
 				    DA732X_ADC_OFF);
-		snd_soc_update_bits(codec, w->reg, DA732X_ADC_RST_MASK,
+		snd_soc_component_update_bits(component, w->reg, DA732X_ADC_RST_MASK,
 				    DA732X_ADC_SET_RST);
 
 		switch (w->reg) {
 		case DA732X_REG_ADC1_PD:
-			snd_soc_update_bits(codec, DA732X_REG_CLK_EN3,
+			snd_soc_component_update_bits(component, DA732X_REG_CLK_EN3,
 					    DA732X_ADCA_BB_CLK_EN, 0);
 			break;
 		case DA732X_REG_ADC2_PD:
-			snd_soc_update_bits(codec, DA732X_REG_CLK_EN3,
+			snd_soc_component_update_bits(component, DA732X_REG_CLK_EN3,
 					    DA732X_ADCC_BB_CLK_EN, 0);
 			break;
 		default:
@@ -663,16 +663,16 @@ static int da732x_adc_event(struct snd_soc_dapm_widget *w,
 static int da732x_out_pga_event(struct snd_soc_dapm_widget *w,
 				struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		snd_soc_update_bits(codec, w->reg,
+		snd_soc_component_update_bits(component, w->reg,
 				    (1 << w->shift) | DA732X_OUT_HIZ_EN,
 				    (1 << w->shift) | DA732X_OUT_HIZ_EN);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		snd_soc_update_bits(codec, w->reg,
+		snd_soc_component_update_bits(component, w->reg,
 				    (1 << w->shift) | DA732X_OUT_HIZ_EN,
 				    (1 << w->shift) | DA732X_OUT_HIZ_DIS);
 		break;
@@ -949,7 +949,7 @@ static int da732x_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	u32 aif = 0;
 	u32 reg_aif;
 	u32 fs;
@@ -1011,15 +1011,15 @@ static int da732x_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	snd_soc_update_bits(codec, reg_aif, DA732X_AIF_WORD_MASK, aif);
-	snd_soc_update_bits(codec, DA732X_REG_CLK_CTRL, DA732X_SR1_MASK, fs);
+	snd_soc_component_update_bits(component, reg_aif, DA732X_AIF_WORD_MASK, aif);
+	snd_soc_component_update_bits(component, DA732X_REG_CLK_CTRL, DA732X_SR1_MASK, fs);
 
 	return 0;
 }
 
 static int da732x_set_dai_fmt(struct snd_soc_dai *dai, u32 fmt)
 {
-	struct snd_soc_codec *codec = dai->codec;
+	struct snd_soc_component *component = dai->component;
 	u32 aif_mclk, pc_count;
 	u32 reg_aif1, aif1;
 	u32 reg_aif3, aif3;
@@ -1107,29 +1107,29 @@ static int da732x_set_dai_fmt(struct snd_soc_dai *dai, u32 fmt)
 		return -EINVAL;
 	}
 
-	snd_soc_write(codec, DA732X_REG_AIF_MCLK, aif_mclk);
-	snd_soc_update_bits(codec, reg_aif1, DA732X_AIF1_CLK_MASK, aif1);
-	snd_soc_update_bits(codec, reg_aif3, DA732X_AIF_BCLK_INV |
+	snd_soc_component_write(component, DA732X_REG_AIF_MCLK, aif_mclk);
+	snd_soc_component_update_bits(component, reg_aif1, DA732X_AIF1_CLK_MASK, aif1);
+	snd_soc_component_update_bits(component, reg_aif3, DA732X_AIF_BCLK_INV |
 			    DA732X_AIF_WCLK_INV | DA732X_AIF_MODE_MASK, aif3);
-	snd_soc_write(codec, DA732X_REG_PC_CTRL, pc_count);
+	snd_soc_component_write(component, DA732X_REG_PC_CTRL, pc_count);
 
 	return 0;
 }
 
 
 
-static int da732x_set_dai_pll(struct snd_soc_codec *codec, int pll_id,
+static int da732x_set_dai_pll(struct snd_soc_component *component, int pll_id,
 			      int source, unsigned int freq_in,
 			      unsigned int freq_out)
 {
-	struct da732x_priv *da732x = snd_soc_codec_get_drvdata(codec);
+	struct da732x_priv *da732x = snd_soc_component_get_drvdata(component);
 	int fref, indiv;
 	u8 div_lo, div_mid, div_hi;
 	u64 frac_div;
 
 	/* Disable PLL */
 	if (freq_out == 0) {
-		snd_soc_update_bits(codec, DA732X_REG_PLL_CTRL,
+		snd_soc_component_update_bits(component, DA732X_REG_PLL_CTRL,
 				    DA732X_PLL_EN, 0);
 		da732x->pll_en = false;
 		return 0;
@@ -1147,17 +1147,17 @@ static int da732x_set_dai_pll(struct snd_soc_codec *codec, int pll_id,
 		case 24576000:
 		case 45160000:
 		case 49152000:
-			snd_soc_write(codec, DA732X_REG_PLL_CTRL,
+			snd_soc_component_write(component, DA732X_REG_PLL_CTRL,
 				      DA732X_PLL_BYPASS);
 			return 0;
 		default:
-			dev_err(codec->dev,
+			dev_err(component->dev,
 				"Cannot use PLL Bypass, invalid SYSCLK rate\n");
 			return -EINVAL;
 		}
 	}
 
-	indiv = da732x_get_input_div(codec, da732x->sysclk);
+	indiv = da732x_get_input_div(component, da732x->sysclk);
 	if (indiv < 0)
 		return indiv;
 
@@ -1168,11 +1168,11 @@ static int da732x_set_dai_pll(struct snd_soc_codec *codec, int pll_id,
 	div_mid = (frac_div >> DA732X_1BYTE_SHIFT) & DA732X_U8_MASK;
 	div_lo = (frac_div) & DA732X_U8_MASK;
 
-	snd_soc_write(codec, DA732X_REG_PLL_DIV_LO, div_lo);
-	snd_soc_write(codec, DA732X_REG_PLL_DIV_MID, div_mid);
-	snd_soc_write(codec, DA732X_REG_PLL_DIV_HI, div_hi);
+	snd_soc_component_write(component, DA732X_REG_PLL_DIV_LO, div_lo);
+	snd_soc_component_write(component, DA732X_REG_PLL_DIV_MID, div_mid);
+	snd_soc_component_write(component, DA732X_REG_PLL_DIV_HI, div_hi);
 
-	snd_soc_update_bits(codec, DA732X_REG_PLL_CTRL, DA732X_PLL_EN,
+	snd_soc_component_update_bits(component, DA732X_REG_PLL_CTRL, DA732X_PLL_EN,
 			    DA732X_PLL_EN);
 
 	da732x->pll_en = true;
@@ -1183,8 +1183,8 @@ static int da732x_set_dai_pll(struct snd_soc_codec *codec, int pll_id,
 static int da732x_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 				 unsigned int freq, int dir)
 {
-	struct snd_soc_codec *codec = dai->codec;
-	struct da732x_priv *da732x = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = dai->component;
+	struct da732x_priv *da732x = snd_soc_component_get_drvdata(component);
 
 	da732x->sysclk = freq;
 
@@ -1268,21 +1268,21 @@ static const struct regmap_config da732x_regmap = {
 };
 
 
-static void da732x_dac_offset_adjust(struct snd_soc_codec *codec)
+static void da732x_dac_offset_adjust(struct snd_soc_component *component)
 {
 	u8 offset[DA732X_HP_DACS];
 	u8 sign[DA732X_HP_DACS];
 	u8 step = DA732X_DAC_OFFSET_STEP;
 
 	/* Initialize DAC offset calibration circuits and registers */
-	snd_soc_write(codec, DA732X_REG_HPL_DAC_OFFSET,
+	snd_soc_component_write(component, DA732X_REG_HPL_DAC_OFFSET,
 		      DA732X_HP_DAC_OFFSET_TRIM_VAL);
-	snd_soc_write(codec, DA732X_REG_HPR_DAC_OFFSET,
+	snd_soc_component_write(component, DA732X_REG_HPR_DAC_OFFSET,
 		      DA732X_HP_DAC_OFFSET_TRIM_VAL);
-	snd_soc_write(codec, DA732X_REG_HPL_DAC_OFF_CNTL,
+	snd_soc_component_write(component, DA732X_REG_HPL_DAC_OFF_CNTL,
 		      DA732X_HP_DAC_OFF_CALIBRATION |
 		      DA732X_HP_DAC_OFF_SCALE_STEPS);
-	snd_soc_write(codec, DA732X_REG_HPR_DAC_OFF_CNTL,
+	snd_soc_component_write(component, DA732X_REG_HPR_DAC_OFF_CNTL,
 		      DA732X_HP_DAC_OFF_CALIBRATION |
 		      DA732X_HP_DAC_OFF_SCALE_STEPS);
 
@@ -1290,9 +1290,9 @@ static void da732x_dac_offset_adjust(struct snd_soc_codec *codec)
 	msleep(DA732X_WAIT_FOR_STABILIZATION);
 
 	/* Check DAC offset sign */
-	sign[DA732X_HPL_DAC] = (snd_soc_read(codec, DA732X_REG_HPL_DAC_OFF_CNTL) &
+	sign[DA732X_HPL_DAC] = (snd_soc_component_read32(component, DA732X_REG_HPL_DAC_OFF_CNTL) &
 				DA732X_HP_DAC_OFF_CNTL_COMPO);
-	sign[DA732X_HPR_DAC] = (snd_soc_read(codec, DA732X_REG_HPR_DAC_OFF_CNTL) &
+	sign[DA732X_HPR_DAC] = (snd_soc_component_read32(component, DA732X_REG_HPR_DAC_OFF_CNTL) &
 				DA732X_HP_DAC_OFF_CNTL_COMPO);
 
 	/* Binary search DAC offset values (both channels at once) */
@@ -1302,17 +1302,17 @@ static void da732x_dac_offset_adjust(struct snd_soc_codec *codec)
 	do {
 		offset[DA732X_HPL_DAC] |= step;
 		offset[DA732X_HPR_DAC] |= step;
-		snd_soc_write(codec, DA732X_REG_HPL_DAC_OFFSET,
+		snd_soc_component_write(component, DA732X_REG_HPL_DAC_OFFSET,
 			      ~offset[DA732X_HPL_DAC] & DA732X_HP_DAC_OFF_MASK);
-		snd_soc_write(codec, DA732X_REG_HPR_DAC_OFFSET,
+		snd_soc_component_write(component, DA732X_REG_HPR_DAC_OFFSET,
 			      ~offset[DA732X_HPR_DAC] & DA732X_HP_DAC_OFF_MASK);
 
 		msleep(DA732X_WAIT_FOR_STABILIZATION);
 
-		if ((snd_soc_read(codec, DA732X_REG_HPL_DAC_OFF_CNTL) &
+		if ((snd_soc_component_read32(component, DA732X_REG_HPL_DAC_OFF_CNTL) &
 		     DA732X_HP_DAC_OFF_CNTL_COMPO) ^ sign[DA732X_HPL_DAC])
 			offset[DA732X_HPL_DAC] &= ~step;
-		if ((snd_soc_read(codec, DA732X_REG_HPR_DAC_OFF_CNTL) &
+		if ((snd_soc_component_read32(component, DA732X_REG_HPR_DAC_OFF_CNTL) &
 		     DA732X_HP_DAC_OFF_CNTL_COMPO) ^ sign[DA732X_HPR_DAC])
 			offset[DA732X_HPR_DAC] &= ~step;
 
@@ -1320,19 +1320,19 @@ static void da732x_dac_offset_adjust(struct snd_soc_codec *codec)
 	} while (step);
 
 	/* Write final DAC offsets to registers */
-	snd_soc_write(codec, DA732X_REG_HPL_DAC_OFFSET,
+	snd_soc_component_write(component, DA732X_REG_HPL_DAC_OFFSET,
 		      ~offset[DA732X_HPL_DAC] &	DA732X_HP_DAC_OFF_MASK);
-	snd_soc_write(codec, DA732X_REG_HPR_DAC_OFFSET,
+	snd_soc_component_write(component, DA732X_REG_HPR_DAC_OFFSET,
 		      ~offset[DA732X_HPR_DAC] &	DA732X_HP_DAC_OFF_MASK);
 
 	/* End DAC calibration mode */
-	snd_soc_write(codec, DA732X_REG_HPL_DAC_OFF_CNTL,
+	snd_soc_component_write(component, DA732X_REG_HPL_DAC_OFF_CNTL,
 		DA732X_HP_DAC_OFF_SCALE_STEPS);
-	snd_soc_write(codec, DA732X_REG_HPR_DAC_OFF_CNTL,
+	snd_soc_component_write(component, DA732X_REG_HPR_DAC_OFF_CNTL,
 		DA732X_HP_DAC_OFF_SCALE_STEPS);
 }
 
-static void da732x_output_offset_adjust(struct snd_soc_codec *codec)
+static void da732x_output_offset_adjust(struct snd_soc_component *component)
 {
 	u8 offset[DA732X_HP_AMPS];
 	u8 sign[DA732X_HP_AMPS];
@@ -1342,26 +1342,26 @@ static void da732x_output_offset_adjust(struct snd_soc_codec *codec)
 	offset[DA732X_HPR_AMP] = DA732X_HP_OUT_TRIM_VAL;
 
 	/* Initialize output offset calibration circuits and registers  */
-	snd_soc_write(codec, DA732X_REG_HPL_OUT_OFFSET, DA732X_HP_OUT_TRIM_VAL);
-	snd_soc_write(codec, DA732X_REG_HPR_OUT_OFFSET, DA732X_HP_OUT_TRIM_VAL);
-	snd_soc_write(codec, DA732X_REG_HPL,
+	snd_soc_component_write(component, DA732X_REG_HPL_OUT_OFFSET, DA732X_HP_OUT_TRIM_VAL);
+	snd_soc_component_write(component, DA732X_REG_HPR_OUT_OFFSET, DA732X_HP_OUT_TRIM_VAL);
+	snd_soc_component_write(component, DA732X_REG_HPL,
 		      DA732X_HP_OUT_COMP | DA732X_HP_OUT_EN);
-	snd_soc_write(codec, DA732X_REG_HPR,
+	snd_soc_component_write(component, DA732X_REG_HPR,
 		      DA732X_HP_OUT_COMP | DA732X_HP_OUT_EN);
 
 	/* Wait for voltage stabilization */
 	msleep(DA732X_WAIT_FOR_STABILIZATION);
 
 	/* Check output offset sign */
-	sign[DA732X_HPL_AMP] = snd_soc_read(codec, DA732X_REG_HPL) &
+	sign[DA732X_HPL_AMP] = snd_soc_component_read32(component, DA732X_REG_HPL) &
 			       DA732X_HP_OUT_COMPO;
-	sign[DA732X_HPR_AMP] = snd_soc_read(codec, DA732X_REG_HPR) &
+	sign[DA732X_HPR_AMP] = snd_soc_component_read32(component, DA732X_REG_HPR) &
 			       DA732X_HP_OUT_COMPO;
 
-	snd_soc_write(codec, DA732X_REG_HPL, DA732X_HP_OUT_COMP |
+	snd_soc_component_write(component, DA732X_REG_HPL, DA732X_HP_OUT_COMP |
 		      (sign[DA732X_HPL_AMP] >> DA732X_HP_OUT_COMPO_SHIFT) |
 		      DA732X_HP_OUT_EN);
-	snd_soc_write(codec, DA732X_REG_HPR, DA732X_HP_OUT_COMP |
+	snd_soc_component_write(component, DA732X_REG_HPR, DA732X_HP_OUT_COMP |
 		      (sign[DA732X_HPR_AMP] >> DA732X_HP_OUT_COMPO_SHIFT) |
 		      DA732X_HP_OUT_EN);
 
@@ -1369,17 +1369,17 @@ static void da732x_output_offset_adjust(struct snd_soc_codec *codec)
 	do {
 		offset[DA732X_HPL_AMP] |= step;
 		offset[DA732X_HPR_AMP] |= step;
-		snd_soc_write(codec, DA732X_REG_HPL_OUT_OFFSET,
+		snd_soc_component_write(component, DA732X_REG_HPL_OUT_OFFSET,
 			      offset[DA732X_HPL_AMP]);
-		snd_soc_write(codec, DA732X_REG_HPR_OUT_OFFSET,
+		snd_soc_component_write(component, DA732X_REG_HPR_OUT_OFFSET,
 			      offset[DA732X_HPR_AMP]);
 
 		msleep(DA732X_WAIT_FOR_STABILIZATION);
 
-		if ((snd_soc_read(codec, DA732X_REG_HPL) &
+		if ((snd_soc_component_read32(component, DA732X_REG_HPL) &
 		     DA732X_HP_OUT_COMPO) ^ sign[DA732X_HPL_AMP])
 			offset[DA732X_HPL_AMP] &= ~step;
-		if ((snd_soc_read(codec, DA732X_REG_HPR) &
+		if ((snd_soc_component_read32(component, DA732X_REG_HPR) &
 		     DA732X_HP_OUT_COMPO) ^ sign[DA732X_HPR_AMP])
 			offset[DA732X_HPR_AMP] &= ~step;
 
@@ -1387,80 +1387,80 @@ static void da732x_output_offset_adjust(struct snd_soc_codec *codec)
 	} while (step);
 
 	/* Write final DAC offsets to registers */
-	snd_soc_write(codec, DA732X_REG_HPL_OUT_OFFSET, offset[DA732X_HPL_AMP]);
-	snd_soc_write(codec, DA732X_REG_HPR_OUT_OFFSET, offset[DA732X_HPR_AMP]);
+	snd_soc_component_write(component, DA732X_REG_HPL_OUT_OFFSET, offset[DA732X_HPL_AMP]);
+	snd_soc_component_write(component, DA732X_REG_HPR_OUT_OFFSET, offset[DA732X_HPR_AMP]);
 }
 
-static void da732x_hp_dc_offset_cancellation(struct snd_soc_codec *codec)
+static void da732x_hp_dc_offset_cancellation(struct snd_soc_component *component)
 {
 	/* Make sure that we have Soft Mute enabled */
-	snd_soc_write(codec, DA732X_REG_DAC1_SOFTMUTE, DA732X_SOFTMUTE_EN |
+	snd_soc_component_write(component, DA732X_REG_DAC1_SOFTMUTE, DA732X_SOFTMUTE_EN |
 		      DA732X_GAIN_RAMPED | DA732X_16_SAMPLES);
-	snd_soc_write(codec, DA732X_REG_DAC1_SEL, DA732X_DACL_EN |
+	snd_soc_component_write(component, DA732X_REG_DAC1_SEL, DA732X_DACL_EN |
 		      DA732X_DACR_EN | DA732X_DACL_SDM | DA732X_DACR_SDM |
 		      DA732X_DACL_MUTE | DA732X_DACR_MUTE);
-	snd_soc_write(codec, DA732X_REG_HPL, DA732X_HP_OUT_DAC_EN |
+	snd_soc_component_write(component, DA732X_REG_HPL, DA732X_HP_OUT_DAC_EN |
 		      DA732X_HP_OUT_MUTE | DA732X_HP_OUT_EN);
-	snd_soc_write(codec, DA732X_REG_HPR, DA732X_HP_OUT_EN |
+	snd_soc_component_write(component, DA732X_REG_HPR, DA732X_HP_OUT_EN |
 		      DA732X_HP_OUT_MUTE | DA732X_HP_OUT_DAC_EN);
 
-	da732x_dac_offset_adjust(codec);
-	da732x_output_offset_adjust(codec);
+	da732x_dac_offset_adjust(component);
+	da732x_output_offset_adjust(component);
 
-	snd_soc_write(codec, DA732X_REG_DAC1_SEL, DA732X_DACS_DIS);
-	snd_soc_write(codec, DA732X_REG_HPL, DA732X_HP_DIS);
-	snd_soc_write(codec, DA732X_REG_HPR, DA732X_HP_DIS);
+	snd_soc_component_write(component, DA732X_REG_DAC1_SEL, DA732X_DACS_DIS);
+	snd_soc_component_write(component, DA732X_REG_HPL, DA732X_HP_DIS);
+	snd_soc_component_write(component, DA732X_REG_HPR, DA732X_HP_DIS);
 }
 
-static int da732x_set_bias_level(struct snd_soc_codec *codec,
+static int da732x_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
-	struct da732x_priv *da732x = snd_soc_codec_get_drvdata(codec);
+	struct da732x_priv *da732x = snd_soc_component_get_drvdata(component);
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		snd_soc_update_bits(codec, DA732X_REG_BIAS_EN,
+		snd_soc_component_update_bits(component, DA732X_REG_BIAS_EN,
 				    DA732X_BIAS_BOOST_MASK,
 				    DA732X_BIAS_BOOST_100PC);
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		if (snd_soc_codec_get_bias_level(codec) == SND_SOC_BIAS_OFF) {
+		if (snd_soc_component_get_bias_level(component) == SND_SOC_BIAS_OFF) {
 			/* Init Codec */
-			snd_soc_write(codec, DA732X_REG_REF1,
+			snd_soc_component_write(component, DA732X_REG_REF1,
 				      DA732X_VMID_FASTCHG);
-			snd_soc_write(codec, DA732X_REG_BIAS_EN,
+			snd_soc_component_write(component, DA732X_REG_BIAS_EN,
 				      DA732X_BIAS_EN);
 
 			mdelay(DA732X_STARTUP_DELAY);
 
 			/* Disable Fast Charge and enable DAC ref voltage */
-			snd_soc_write(codec, DA732X_REG_REF1,
+			snd_soc_component_write(component, DA732X_REG_REF1,
 				      DA732X_REFBUFX2_EN);
 
 			/* Enable bypass DSP routing */
-			snd_soc_write(codec, DA732X_REG_DATA_ROUTE,
+			snd_soc_component_write(component, DA732X_REG_DATA_ROUTE,
 				      DA732X_BYPASS_DSP);
 
 			/* Enable Digital subsystem */
-			snd_soc_write(codec, DA732X_REG_DSP_CTRL,
+			snd_soc_component_write(component, DA732X_REG_DSP_CTRL,
 				      DA732X_DIGITAL_EN);
 
-			snd_soc_write(codec, DA732X_REG_SPARE1_OUT,
+			snd_soc_component_write(component, DA732X_REG_SPARE1_OUT,
 				      DA732X_HP_DRIVER_EN |
 				      DA732X_HP_GATE_LOW |
 				      DA732X_HP_LOOP_GAIN_CTRL);
-			snd_soc_write(codec, DA732X_REG_HP_LIN1_GNDSEL,
+			snd_soc_component_write(component, DA732X_REG_HP_LIN1_GNDSEL,
 				      DA732X_HP_OUT_GNDSEL);
 
-			da732x_set_charge_pump(codec, DA732X_ENABLE_CP);
+			da732x_set_charge_pump(component, DA732X_ENABLE_CP);
 
-			snd_soc_write(codec, DA732X_REG_CLK_EN1,
+			snd_soc_component_write(component, DA732X_REG_CLK_EN1,
 			      DA732X_SYS3_CLK_EN | DA732X_PC_CLK_EN);
 
 			/* Enable Zero Crossing */
-			snd_soc_write(codec, DA732X_REG_INP_ZC_EN,
+			snd_soc_component_write(component, DA732X_REG_INP_ZC_EN,
 				      DA732X_MIC1_PRE_ZC_EN |
 				      DA732X_MIC1_ZC_EN |
 				      DA732X_MIC2_PRE_ZC_EN |
@@ -1469,28 +1469,28 @@ static int da732x_set_bias_level(struct snd_soc_codec *codec,
 				      DA732X_AUXR_ZC_EN |
 				      DA732X_MIC3_PRE_ZC_EN |
 				      DA732X_MIC3_ZC_EN);
-			snd_soc_write(codec, DA732X_REG_OUT_ZC_EN,
+			snd_soc_component_write(component, DA732X_REG_OUT_ZC_EN,
 				      DA732X_HPL_ZC_EN | DA732X_HPR_ZC_EN |
 				      DA732X_LIN2_ZC_EN | DA732X_LIN3_ZC_EN |
 				      DA732X_LIN4_ZC_EN);
 
-			da732x_hp_dc_offset_cancellation(codec);
+			da732x_hp_dc_offset_cancellation(component);
 
 			regcache_cache_only(da732x->regmap, false);
 			regcache_sync(da732x->regmap);
 		} else {
-			snd_soc_update_bits(codec, DA732X_REG_BIAS_EN,
+			snd_soc_component_update_bits(component, DA732X_REG_BIAS_EN,
 					    DA732X_BIAS_BOOST_MASK,
 					    DA732X_BIAS_BOOST_50PC);
-			snd_soc_update_bits(codec, DA732X_REG_PLL_CTRL,
+			snd_soc_component_update_bits(component, DA732X_REG_PLL_CTRL,
 					    DA732X_PLL_EN, 0);
 			da732x->pll_en = false;
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
 		regcache_cache_only(da732x->regmap, true);
-		da732x_set_charge_pump(codec, DA732X_DISABLE_CP);
-		snd_soc_update_bits(codec, DA732X_REG_BIAS_EN, DA732X_BIAS_EN,
+		da732x_set_charge_pump(component, DA732X_DISABLE_CP);
+		snd_soc_component_update_bits(component, DA732X_REG_BIAS_EN, DA732X_BIAS_EN,
 				    DA732X_BIAS_DIS);
 		da732x->pll_en = false;
 		break;
@@ -1499,17 +1499,19 @@ static int da732x_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static const struct snd_soc_codec_driver soc_codec_dev_da732x = {
+static const struct snd_soc_component_driver soc_component_dev_da732x = {
 	.set_bias_level		= da732x_set_bias_level,
-	.component_driver = {
-		.controls		= da732x_snd_controls,
-		.num_controls		= ARRAY_SIZE(da732x_snd_controls),
-		.dapm_widgets		= da732x_dapm_widgets,
-		.num_dapm_widgets	= ARRAY_SIZE(da732x_dapm_widgets),
-		.dapm_routes		= da732x_dapm_routes,
-		.num_dapm_routes	= ARRAY_SIZE(da732x_dapm_routes),
-	},
+	.controls		= da732x_snd_controls,
+	.num_controls		= ARRAY_SIZE(da732x_snd_controls),
+	.dapm_widgets		= da732x_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(da732x_dapm_widgets),
+	.dapm_routes		= da732x_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(da732x_dapm_routes),
 	.set_pll		= da732x_set_dai_pll,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int da732x_i2c_probe(struct i2c_client *i2c,
@@ -1543,10 +1545,11 @@ static int da732x_i2c_probe(struct i2c_client *i2c,
 		 (reg & DA732X_ID_MAJOR_MASK) >> 4,
 		 (reg & DA732X_ID_MINOR_MASK));
 
-	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_da732x,
+	ret = devm_snd_soc_register_component(&i2c->dev,
+				     &soc_component_dev_da732x,
 				     da732x_dai, ARRAY_SIZE(da732x_dai));
 	if (ret != 0)
-		dev_err(&i2c->dev, "Failed to register codec.\n");
+		dev_err(&i2c->dev, "Failed to register component.\n");
 
 err:
 	return ret;
@@ -1554,8 +1557,6 @@ static int da732x_i2c_probe(struct i2c_client *i2c,
 
 static int da732x_i2c_remove(struct i2c_client *client)
 {
-	snd_soc_unregister_codec(&client->dev);
-
 	return 0;
 }
 
-- 
2.16.1
