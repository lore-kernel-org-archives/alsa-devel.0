From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: msm8916-wcd-analog: replace codec to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:39:10 +0000
Message-ID: <E1elDO2-0004S6-75@debutante>
References: <87inblxpnd.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 86029267628
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:39:12 +0100 (CET)
In-Reply-To: <87inblxpnd.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: msm8916-wcd-analog: replace codec to component

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

>From 732ae454bdebdc2afa133150655277551a77ede4 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 04:21:15 +0000
Subject: [PATCH] ASoC: msm8916-wcd-analog: replace codec to component

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
 sound/soc/codecs/msm8916-wcd-analog.c | 207 +++++++++++++++++-----------------
 1 file changed, 104 insertions(+), 103 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 44062bb7bf2f..12ee83d52405 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -288,7 +288,7 @@ struct pm8916_wcd_analog_priv {
 	int	mbhc_btn0_released;
 	bool	detect_accessory_type;
 	struct clk *mclk;
-	struct snd_soc_codec *codec;
+	struct snd_soc_component *component;
 	struct regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
 	struct snd_soc_jack *jack;
 	bool hphl_jack_type_normally_open;
@@ -338,18 +338,18 @@ static const struct snd_kcontrol_new pm8916_wcd_analog_snd_controls[] = {
 	SOC_SINGLE_TLV("ADC3 Volume", CDC_A_TX_3_EN, 3, 8, 0, analog_gain),
 };
 
-static void pm8916_wcd_analog_micbias_enable(struct snd_soc_codec *codec)
+static void pm8916_wcd_analog_micbias_enable(struct snd_soc_component *component)
 {
-	struct pm8916_wcd_analog_priv *wcd = snd_soc_codec_get_drvdata(codec);
+	struct pm8916_wcd_analog_priv *wcd = snd_soc_component_get_drvdata(component);
 
-	snd_soc_update_bits(codec, CDC_A_MICB_1_CTL,
+	snd_soc_component_update_bits(component, CDC_A_MICB_1_CTL,
 			    MICB_1_CTL_EXT_PRECHARG_EN_MASK |
 			    MICB_1_CTL_INT_PRECHARG_BYP_MASK,
 			    MICB_1_CTL_INT_PRECHARG_BYP_EXT_PRECHRG_SEL
 			    | MICB_1_CTL_EXT_PRECHARG_EN_ENABLE);
 
 	if (wcd->micbias_mv) {
-		snd_soc_update_bits(codec, CDC_A_MICB_1_VAL,
+		snd_soc_component_update_bits(component, CDC_A_MICB_1_VAL,
 				    MICB_1_VAL_MICB_OUT_VAL_MASK,
 				    MICB_VOLTAGE_REGVAL(wcd->micbias_mv));
 		/*
@@ -360,20 +360,20 @@ static void pm8916_wcd_analog_micbias_enable(struct snd_soc_codec *codec)
 			msleep(50);
 	}
 
-	snd_soc_update_bits(codec, CDC_A_MICB_1_CTL,
+	snd_soc_component_update_bits(component, CDC_A_MICB_1_CTL,
 			    MICB_1_CTL_EXT_PRECHARG_EN_MASK |
 			    MICB_1_CTL_INT_PRECHARG_BYP_MASK, 0);
 
 }
 
-static int pm8916_wcd_analog_enable_micbias_ext(struct snd_soc_codec
-						 *codec, int event,
+static int pm8916_wcd_analog_enable_micbias_ext(struct snd_soc_component
+						 *component, int event,
 						 int reg, unsigned int cap_mode)
 {
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		pm8916_wcd_analog_micbias_enable(codec);
-		snd_soc_update_bits(codec, CDC_A_MICB_1_EN,
+		pm8916_wcd_analog_micbias_enable(component);
+		snd_soc_component_update_bits(component, CDC_A_MICB_1_EN,
 				    MICB_1_EN_BYP_CAP_MASK, cap_mode);
 		break;
 	}
@@ -381,25 +381,25 @@ static int pm8916_wcd_analog_enable_micbias_ext(struct snd_soc_codec
 	return 0;
 }
 
-static int pm8916_wcd_analog_enable_micbias_int(struct snd_soc_codec
-						 *codec, int event,
+static int pm8916_wcd_analog_enable_micbias_int(struct snd_soc_component
+						 *component, int event,
 						 int reg, u32 cap_mode)
 {
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		snd_soc_update_bits(codec, CDC_A_MICB_1_INT_RBIAS,
+		snd_soc_component_update_bits(component, CDC_A_MICB_1_INT_RBIAS,
 				    MICB_1_INT_TX2_INT_RBIAS_EN_MASK,
 				    MICB_1_INT_TX2_INT_RBIAS_EN_ENABLE);
-		snd_soc_update_bits(codec, reg, MICB_1_EN_PULL_DOWN_EN_MASK, 0);
-		snd_soc_update_bits(codec, CDC_A_MICB_1_EN,
+		snd_soc_component_update_bits(component, reg, MICB_1_EN_PULL_DOWN_EN_MASK, 0);
+		snd_soc_component_update_bits(component, CDC_A_MICB_1_EN,
 				    MICB_1_EN_OPA_STG2_TAIL_CURR_MASK,
 				    MICB_1_EN_OPA_STG2_TAIL_CURR_1_60UA);
 
 		break;
 	case SND_SOC_DAPM_POST_PMU:
-		pm8916_wcd_analog_micbias_enable(codec);
-		snd_soc_update_bits(codec, CDC_A_MICB_1_EN,
+		pm8916_wcd_analog_micbias_enable(component);
+		snd_soc_component_update_bits(component, CDC_A_MICB_1_EN,
 				    MICB_1_EN_BYP_CAP_MASK, cap_mode);
 		break;
 	}
@@ -412,10 +412,10 @@ static int pm8916_wcd_analog_enable_micbias_ext1(struct
 						  *w, struct snd_kcontrol
 						  *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct pm8916_wcd_analog_priv *wcd = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct pm8916_wcd_analog_priv *wcd = snd_soc_component_get_drvdata(component);
 
-	return pm8916_wcd_analog_enable_micbias_ext(codec, event, w->reg,
+	return pm8916_wcd_analog_enable_micbias_ext(component, event, w->reg,
 						     wcd->micbias1_cap_mode);
 }
 
@@ -424,10 +424,10 @@ static int pm8916_wcd_analog_enable_micbias_ext2(struct
 						  *w, struct snd_kcontrol
 						  *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct pm8916_wcd_analog_priv *wcd = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct pm8916_wcd_analog_priv *wcd = snd_soc_component_get_drvdata(component);
 
-	return pm8916_wcd_analog_enable_micbias_ext(codec, event, w->reg,
+	return pm8916_wcd_analog_enable_micbias_ext(component, event, w->reg,
 						     wcd->micbias2_cap_mode);
 
 }
@@ -437,35 +437,35 @@ static int pm8916_wcd_analog_enable_micbias_int1(struct
 						  *w, struct snd_kcontrol
 						  *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct pm8916_wcd_analog_priv *wcd = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct pm8916_wcd_analog_priv *wcd = snd_soc_component_get_drvdata(component);
 
-	return pm8916_wcd_analog_enable_micbias_int(codec, event, w->reg,
+	return pm8916_wcd_analog_enable_micbias_int(component, event, w->reg,
 						     wcd->micbias1_cap_mode);
 }
 
 static int pm8916_mbhc_configure_bias(struct pm8916_wcd_analog_priv *priv,
 				      bool micbias2_enabled)
 {
-	struct snd_soc_codec *codec = priv->codec;
+	struct snd_soc_component *component = priv->component;
 	u32 coarse, fine, reg_val, reg_addr;
 	int *vrefs, i;
 
 	if (!micbias2_enabled) { /* use internal 100uA Current source */
 		/* Enable internal 2.2k Internal Rbias Resistor */
-		snd_soc_update_bits(codec, CDC_A_MICB_1_INT_RBIAS,
+		snd_soc_component_update_bits(component, CDC_A_MICB_1_INT_RBIAS,
 				    MICB_1_INT_TX2_INT_RBIAS_EN_MASK,
 				    MICB_1_INT_TX2_INT_RBIAS_EN_ENABLE);
 		/* Remove pull down on MIC BIAS2 */
-		snd_soc_update_bits(codec, CDC_A_MICB_2_EN,
+		snd_soc_component_update_bits(component, CDC_A_MICB_2_EN,
 				   CDC_A_MICB_2_PULL_DOWN_EN_MASK,
 				   0);
 		/* enable 100uA internal current source */
-		snd_soc_update_bits(codec, CDC_A_MBHC_FSM_CTL,
+		snd_soc_component_update_bits(component, CDC_A_MBHC_FSM_CTL,
 				    CDC_A_MBHC_FSM_CTL_BTN_ISRC_CTRL_MASK,
 				    CDC_A_MBHC_FSM_CTL_BTN_ISRC_CTRL_I_100UA);
 	}
-	snd_soc_update_bits(codec, CDC_A_MBHC_FSM_CTL,
+	snd_soc_component_update_bits(component, CDC_A_MBHC_FSM_CTL,
 			CDC_A_MBHC_FSM_CTL_MBHC_FSM_EN_MASK,
 			CDC_A_MBHC_FSM_CTL_MBHC_FSM_EN);
 
@@ -482,7 +482,7 @@ static int pm8916_mbhc_configure_bias(struct pm8916_wcd_analog_priv *priv,
 		fine = ((vrefs[i] % 100) / 12);
 		reg_val = (coarse << CDC_A_MBHC_BTN_VREF_COARSE_SHIFT) |
 			 (fine << CDC_A_MBHC_BTN_VREF_FINE_SHIFT);
-		snd_soc_update_bits(codec, reg_addr,
+		snd_soc_component_update_bits(component, reg_addr,
 			       CDC_A_MBHC_BTN_VREF_MASK,
 			       reg_val);
 		reg_addr++;
@@ -493,12 +493,12 @@ static int pm8916_mbhc_configure_bias(struct pm8916_wcd_analog_priv *priv,
 
 static void pm8916_wcd_setup_mbhc(struct pm8916_wcd_analog_priv *wcd)
 {
-	struct snd_soc_codec *codec = wcd->codec;
+	struct snd_soc_component *component = wcd->component;
 	bool micbias_enabled = false;
 	u32 plug_type = 0;
 	u32 int_en_mask;
 
-	snd_soc_write(codec, CDC_A_MBHC_DET_CTL_1,
+	snd_soc_component_write(component, CDC_A_MBHC_DET_CTL_1,
 		      CDC_A_MBHC_DET_CTL_L_DET_EN |
 		      CDC_A_MBHC_DET_CTL_MECH_DET_TYPE_INSERTION |
 		      CDC_A_MBHC_DET_CTL_MIC_CLAMP_CTL_AUTO |
@@ -510,23 +510,23 @@ static void pm8916_wcd_setup_mbhc(struct pm8916_wcd_analog_priv *wcd)
 	if (wcd->gnd_jack_type_normally_open)
 		plug_type |= CDC_A_GND_PLUG_TYPE_NO;
 
-	snd_soc_write(codec, CDC_A_MBHC_DET_CTL_2,
+	snd_soc_component_write(component, CDC_A_MBHC_DET_CTL_2,
 		      CDC_A_MBHC_DET_CTL_HS_L_DET_PULL_UP_CTRL_I_3P0 |
 		      CDC_A_MBHC_DET_CTL_HS_L_DET_COMPA_CTRL_V0P9_VDD |
 		      plug_type |
 		      CDC_A_MBHC_DET_CTL_HPHL_100K_TO_GND_EN);
 
 
-	snd_soc_write(codec, CDC_A_MBHC_DBNC_TIMER,
+	snd_soc_component_write(component, CDC_A_MBHC_DBNC_TIMER,
 		      CDC_A_MBHC_DBNC_TIMER_INSREM_DBNC_T_256_MS |
 		      CDC_A_MBHC_DBNC_TIMER_BTN_DBNC_T_16MS);
 
 	/* enable MBHC clock */
-	snd_soc_update_bits(codec, CDC_D_CDC_DIG_CLK_CTL,
+	snd_soc_component_update_bits(component, CDC_D_CDC_DIG_CLK_CTL,
 			    DIG_CLK_CTL_D_MBHC_CLK_EN_MASK,
 			    DIG_CLK_CTL_D_MBHC_CLK_EN);
 
-	if (snd_soc_read(codec, CDC_A_MICB_2_EN) & CDC_A_MICB_2_EN_ENABLE)
+	if (snd_soc_component_read32(component, CDC_A_MICB_2_EN) & CDC_A_MICB_2_EN_ENABLE)
 		micbias_enabled = true;
 
 	pm8916_mbhc_configure_bias(wcd, micbias_enabled);
@@ -535,8 +535,8 @@ static void pm8916_wcd_setup_mbhc(struct pm8916_wcd_analog_priv *wcd)
 	if (wcd->mbhc_btn_enabled)
 		int_en_mask |= MBHC_BUTTON_PRESS_DET | MBHC_BUTTON_RELEASE_DET;
 
-	snd_soc_update_bits(codec, CDC_D_INT_EN_CLR, int_en_mask, 0);
-	snd_soc_update_bits(codec, CDC_D_INT_EN_SET, int_en_mask, int_en_mask);
+	snd_soc_component_update_bits(component, CDC_D_INT_EN_CLR, int_en_mask, 0);
+	snd_soc_component_update_bits(component, CDC_D_INT_EN_SET, int_en_mask, int_en_mask);
 	wcd->mbhc_btn0_released = false;
 	wcd->detect_accessory_type = true;
 }
@@ -546,8 +546,8 @@ static int pm8916_wcd_analog_enable_micbias_int2(struct
 						  *w, struct snd_kcontrol
 						  *kcontrol, int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
-	struct pm8916_wcd_analog_priv *wcd = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct pm8916_wcd_analog_priv *wcd = snd_soc_component_get_drvdata(component);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
@@ -558,7 +558,7 @@ static int pm8916_wcd_analog_enable_micbias_int2(struct
 		break;
 	}
 
-	return pm8916_wcd_analog_enable_micbias_int(codec, event, w->reg,
+	return pm8916_wcd_analog_enable_micbias_int(component, event, w->reg,
 						     wcd->micbias2_cap_mode);
 }
 
@@ -566,7 +566,7 @@ static int pm8916_wcd_analog_enable_adc(struct snd_soc_dapm_widget *w,
 					 struct snd_kcontrol *kcontrol,
 					 int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	u16 adc_reg = CDC_A_TX_1_2_TEST_CTL_2;
 	u8 init_bit_shift;
 
@@ -578,7 +578,7 @@ static int pm8916_wcd_analog_enable_adc(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		if (w->reg == CDC_A_TX_2_EN)
-			snd_soc_update_bits(codec, CDC_A_MICB_1_CTL,
+			snd_soc_component_update_bits(component, CDC_A_MICB_1_CTL,
 					    MICB_1_CTL_CFILT_REF_SEL_MASK,
 					    MICB_1_CTL_CFILT_REF_SEL_HPF_REF);
 		/*
@@ -587,17 +587,17 @@ static int pm8916_wcd_analog_enable_adc(struct snd_soc_dapm_widget *w,
 		 * happen when the input voltage is changing too much.
 		 */
 		usleep_range(10000, 10010);
-		snd_soc_update_bits(codec, adc_reg, 1 << init_bit_shift,
+		snd_soc_component_update_bits(component, adc_reg, 1 << init_bit_shift,
 				    1 << init_bit_shift);
 		switch (w->reg) {
 		case CDC_A_TX_1_EN:
-			snd_soc_update_bits(codec, CDC_D_CDC_CONN_TX1_CTL,
+			snd_soc_component_update_bits(component, CDC_D_CDC_CONN_TX1_CTL,
 					    CONN_TX1_SERIAL_TX1_MUX,
 					    CONN_TX1_SERIAL_TX1_ADC_1);
 			break;
 		case CDC_A_TX_2_EN:
 		case CDC_A_TX_3_EN:
-			snd_soc_update_bits(codec, CDC_D_CDC_CONN_TX2_CTL,
+			snd_soc_component_update_bits(component, CDC_D_CDC_CONN_TX2_CTL,
 					    CONN_TX2_SERIAL_TX2_MUX,
 					    CONN_TX2_SERIAL_TX2_ADC_2);
 			break;
@@ -609,21 +609,21 @@ static int pm8916_wcd_analog_enable_adc(struct snd_soc_dapm_widget *w,
 		 * to reduce the tx pop
 		 */
 		usleep_range(12000, 12010);
-		snd_soc_update_bits(codec, adc_reg, 1 << init_bit_shift, 0x00);
+		snd_soc_component_update_bits(component, adc_reg, 1 << init_bit_shift, 0x00);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		switch (w->reg) {
 		case CDC_A_TX_1_EN:
-			snd_soc_update_bits(codec, CDC_D_CDC_CONN_TX1_CTL,
+			snd_soc_component_update_bits(component, CDC_D_CDC_CONN_TX1_CTL,
 					    CONN_TX1_SERIAL_TX1_MUX,
 					    CONN_TX1_SERIAL_TX1_ZERO);
 			break;
 		case CDC_A_TX_2_EN:
-			snd_soc_update_bits(codec, CDC_A_MICB_1_CTL,
+			snd_soc_component_update_bits(component, CDC_A_MICB_1_CTL,
 					    MICB_1_CTL_CFILT_REF_SEL_MASK, 0);
 			/* fall through */
 		case CDC_A_TX_3_EN:
-			snd_soc_update_bits(codec, CDC_D_CDC_CONN_TX2_CTL,
+			snd_soc_component_update_bits(component, CDC_D_CDC_CONN_TX2_CTL,
 					    CONN_TX2_SERIAL_TX2_MUX,
 					    CONN_TX2_SERIAL_TX2_ZERO);
 			break;
@@ -639,11 +639,11 @@ static int pm8916_wcd_analog_enable_spk_pa(struct snd_soc_dapm_widget *w,
 					    struct snd_kcontrol *kcontrol,
 					    int event)
 {
-	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		snd_soc_update_bits(codec, CDC_A_SPKR_PWRSTG_CTL,
+		snd_soc_component_update_bits(component, CDC_A_SPKR_PWRSTG_CTL,
 				    SPKR_PWRSTG_CTL_DAC_EN_MASK |
 				    SPKR_PWRSTG_CTL_BBM_MASK |
 				    SPKR_PWRSTG_CTL_HBRDGE_EN_MASK |
@@ -653,29 +653,29 @@ static int pm8916_wcd_analog_enable_spk_pa(struct snd_soc_dapm_widget *w,
 				    SPKR_PWRSTG_CTL_HBRDGE_EN |
 				    SPKR_PWRSTG_CTL_CLAMP_EN);
 
-		snd_soc_update_bits(codec, CDC_A_RX_EAR_CTL,
+		snd_soc_component_update_bits(component, CDC_A_RX_EAR_CTL,
 				    RX_EAR_CTL_SPK_VBAT_LDO_EN_MASK,
 				    RX_EAR_CTL_SPK_VBAT_LDO_EN_ENABLE);
 		break;
 	case SND_SOC_DAPM_POST_PMU:
-		snd_soc_update_bits(codec, CDC_A_SPKR_DRV_CTL,
+		snd_soc_component_update_bits(component, CDC_A_SPKR_DRV_CTL,
 				    SPKR_DRV_CTL_DEF_MASK,
 				    SPKR_DRV_CTL_DEF_VAL);
-		snd_soc_update_bits(codec, w->reg,
+		snd_soc_component_update_bits(component, w->reg,
 				    SPKR_DRV_CLASSD_PA_EN_MASK,
 				    SPKR_DRV_CLASSD_PA_EN_ENABLE);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		snd_soc_update_bits(codec, CDC_A_SPKR_PWRSTG_CTL,
+		snd_soc_component_update_bits(component, CDC_A_SPKR_PWRSTG_CTL,
 				    SPKR_PWRSTG_CTL_DAC_EN_MASK|
 				    SPKR_PWRSTG_CTL_BBM_MASK |
 				    SPKR_PWRSTG_CTL_HBRDGE_EN_MASK |
 				    SPKR_PWRSTG_CTL_CLAMP_EN_MASK, 0);
 
-		snd_soc_update_bits(codec, CDC_A_SPKR_DAC_CTL,
+		snd_soc_component_update_bits(component, CDC_A_SPKR_DAC_CTL,
 				    SPKR_DAC_CTL_DAC_RESET_MASK,
 				    SPKR_DAC_CTL_DAC_RESET_NORMAL);
-		snd_soc_update_bits(codec, CDC_A_RX_EAR_CTL,
+		snd_soc_component_update_bits(component, CDC_A_RX_EAR_CTL,
 				    RX_EAR_CTL_SPK_VBAT_LDO_EN_MASK, 0);
 		break;
 	}
@@ -701,36 +701,36 @@ static const struct reg_default wcd_reg_defaults_2_0[] = {
 	{CDC_A_MASTER_BIAS_CTL, 0x30},
 };
 
-static int pm8916_wcd_analog_probe(struct snd_soc_codec *codec)
+static int pm8916_wcd_analog_probe(struct snd_soc_component *component)
 {
-	struct pm8916_wcd_analog_priv *priv = dev_get_drvdata(codec->dev);
+	struct pm8916_wcd_analog_priv *priv = dev_get_drvdata(component->dev);
 	int err, reg;
 
 	err = regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->supplies);
 	if (err != 0) {
-		dev_err(codec->dev, "failed to enable regulators (%d)\n", err);
+		dev_err(component->dev, "failed to enable regulators (%d)\n", err);
 		return err;
 	}
 
-	snd_soc_codec_init_regmap(codec,
-				  dev_get_regmap(codec->dev->parent, NULL));
-	snd_soc_codec_set_drvdata(codec, priv);
-	priv->pmic_rev = snd_soc_read(codec, CDC_D_REVISION1);
-	priv->codec_version = snd_soc_read(codec, CDC_D_PERPH_SUBTYPE);
+	snd_soc_component_init_regmap(component,
+				  dev_get_regmap(component->dev->parent, NULL));
+	snd_soc_component_set_drvdata(component, priv);
+	priv->pmic_rev = snd_soc_component_read32(component, CDC_D_REVISION1);
+	priv->codec_version = snd_soc_component_read32(component, CDC_D_PERPH_SUBTYPE);
 
-	dev_info(codec->dev, "PMIC REV: %d\t CODEC Version: %d\n",
+	dev_info(component->dev, "PMIC REV: %d\t CODEC Version: %d\n",
 		 priv->pmic_rev, priv->codec_version);
 
-	snd_soc_write(codec, CDC_D_PERPH_RESET_CTL4, 0x01);
-	snd_soc_write(codec, CDC_A_PERPH_RESET_CTL4, 0x01);
+	snd_soc_component_write(component, CDC_D_PERPH_RESET_CTL4, 0x01);
+	snd_soc_component_write(component, CDC_A_PERPH_RESET_CTL4, 0x01);
 
 	for (reg = 0; reg < ARRAY_SIZE(wcd_reg_defaults_2_0); reg++)
-		snd_soc_write(codec, wcd_reg_defaults_2_0[reg].reg,
+		snd_soc_component_write(component, wcd_reg_defaults_2_0[reg].reg,
 			      wcd_reg_defaults_2_0[reg].def);
 
-	priv->codec = codec;
+	priv->component = component;
 
-	snd_soc_update_bits(codec, CDC_D_CDC_RST_CTL,
+	snd_soc_component_update_bits(component, CDC_D_CDC_RST_CTL,
 			    RST_CTL_DIG_SW_RST_N_MASK,
 			    RST_CTL_DIG_SW_RST_N_REMOVE_RESET);
 
@@ -739,14 +739,14 @@ static int pm8916_wcd_analog_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static int pm8916_wcd_analog_remove(struct snd_soc_codec *codec)
+static void pm8916_wcd_analog_remove(struct snd_soc_component *component)
 {
-	struct pm8916_wcd_analog_priv *priv = dev_get_drvdata(codec->dev);
+	struct pm8916_wcd_analog_priv *priv = dev_get_drvdata(component->dev);
 
-	snd_soc_update_bits(codec, CDC_D_CDC_RST_CTL,
+	snd_soc_component_update_bits(component, CDC_D_CDC_RST_CTL,
 			    RST_CTL_DIG_SW_RST_N_MASK, 0);
 
-	return regulator_bulk_disable(ARRAY_SIZE(priv->supplies),
+	regulator_bulk_disable(ARRAY_SIZE(priv->supplies),
 				      priv->supplies);
 }
 
@@ -934,11 +934,11 @@ static const struct snd_soc_dapm_widget pm8916_wcd_analog_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("A_MCLK2", CDC_D_CDC_TOP_CLK_CTL, 3, 0, NULL, 0),
 };
 
-static int pm8916_wcd_analog_set_jack(struct snd_soc_codec *codec,
+static int pm8916_wcd_analog_set_jack(struct snd_soc_component *component,
 				      struct snd_soc_jack *jack,
 				      void *data)
 {
-	struct pm8916_wcd_analog_priv *wcd = snd_soc_codec_get_drvdata(codec);
+	struct pm8916_wcd_analog_priv *wcd = snd_soc_component_get_drvdata(component);
 
 	wcd->jack = jack;
 
@@ -950,8 +950,8 @@ static irqreturn_t mbhc_btn_release_irq_handler(int irq, void *arg)
 	struct pm8916_wcd_analog_priv *priv = arg;
 
 	if (priv->detect_accessory_type) {
-		struct snd_soc_codec *codec = priv->codec;
-		u32 val = snd_soc_read(codec, CDC_A_MBHC_RESULT_1);
+		struct snd_soc_component *component = priv->component;
+		u32 val = snd_soc_component_read32(component, CDC_A_MBHC_RESULT_1);
 
 		/* check if its BTN0 thats released */
 		if ((val != -1) && !(val & CDC_A_MBHC_RESULT_1_BTN_RESULT_MASK))
@@ -967,10 +967,10 @@ static irqreturn_t mbhc_btn_release_irq_handler(int irq, void *arg)
 static irqreturn_t mbhc_btn_press_irq_handler(int irq, void *arg)
 {
 	struct pm8916_wcd_analog_priv *priv = arg;
-	struct snd_soc_codec *codec = priv->codec;
+	struct snd_soc_component *component = priv->component;
 	u32 btn_result;
 
-	btn_result = snd_soc_read(codec, CDC_A_MBHC_RESULT_1) &
+	btn_result = snd_soc_component_read32(component, CDC_A_MBHC_RESULT_1) &
 				  CDC_A_MBHC_RESULT_1_BTN_RESULT_MASK;
 
 	switch (btn_result) {
@@ -993,7 +993,7 @@ static irqreturn_t mbhc_btn_press_irq_handler(int irq, void *arg)
 					    SND_JACK_BTN_0, btn_mask);
 		break;
 	default:
-		dev_err(codec->dev,
+		dev_err(component->dev,
 			"Unexpected button press result (%x)", btn_result);
 		break;
 	}
@@ -1004,15 +1004,15 @@ static irqreturn_t mbhc_btn_press_irq_handler(int irq, void *arg)
 static irqreturn_t pm8916_mbhc_switch_irq_handler(int irq, void *arg)
 {
 	struct pm8916_wcd_analog_priv *priv = arg;
-	struct snd_soc_codec *codec = priv->codec;
+	struct snd_soc_component *component = priv->component;
 	bool ins = false;
 
-	if (snd_soc_read(codec, CDC_A_MBHC_DET_CTL_1) &
+	if (snd_soc_component_read32(component, CDC_A_MBHC_DET_CTL_1) &
 				CDC_A_MBHC_DET_CTL_MECH_DET_TYPE_MASK)
 		ins = true;
 
 	/* Set the detection type appropriately */
-	snd_soc_update_bits(codec, CDC_A_MBHC_DET_CTL_1,
+	snd_soc_component_update_bits(component, CDC_A_MBHC_DET_CTL_1,
 			    CDC_A_MBHC_DET_CTL_MECH_DET_TYPE_MASK,
 			    (!ins << CDC_A_MBHC_DET_CTL_MECH_DET_TYPE_SHIFT));
 
@@ -1020,7 +1020,7 @@ static irqreturn_t pm8916_mbhc_switch_irq_handler(int irq, void *arg)
 	if (ins) { /* hs insertion */
 		bool micbias_enabled = false;
 
-		if (snd_soc_read(codec, CDC_A_MICB_2_EN) &
+		if (snd_soc_component_read32(component, CDC_A_MICB_2_EN) &
 				CDC_A_MICB_2_EN_ENABLE)
 			micbias_enabled = true;
 
@@ -1075,18 +1075,20 @@ static struct snd_soc_dai_driver pm8916_wcd_analog_dai[] = {
 	       },
 };
 
-static const struct snd_soc_codec_driver pm8916_wcd_analog = {
-	.probe = pm8916_wcd_analog_probe,
-	.remove = pm8916_wcd_analog_remove,
-	.set_jack = pm8916_wcd_analog_set_jack,
-	.component_driver = {
-		.controls = pm8916_wcd_analog_snd_controls,
-		.num_controls = ARRAY_SIZE(pm8916_wcd_analog_snd_controls),
-		.dapm_widgets = pm8916_wcd_analog_dapm_widgets,
-		.num_dapm_widgets = ARRAY_SIZE(pm8916_wcd_analog_dapm_widgets),
-		.dapm_routes = pm8916_wcd_analog_audio_map,
-		.num_dapm_routes = ARRAY_SIZE(pm8916_wcd_analog_audio_map),
-	},
+static const struct snd_soc_component_driver pm8916_wcd_analog = {
+	.probe			= pm8916_wcd_analog_probe,
+	.remove			= pm8916_wcd_analog_remove,
+	.set_jack		= pm8916_wcd_analog_set_jack,
+	.controls		= pm8916_wcd_analog_snd_controls,
+	.num_controls		= ARRAY_SIZE(pm8916_wcd_analog_snd_controls),
+	.dapm_widgets		= pm8916_wcd_analog_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(pm8916_wcd_analog_dapm_widgets),
+	.dapm_routes		= pm8916_wcd_analog_audio_map,
+	.num_dapm_routes	= ARRAY_SIZE(pm8916_wcd_analog_audio_map),
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+	.non_legacy_dai_naming	= 1,
 };
 
 static int pm8916_wcd_analog_parse_dt(struct device *dev,
@@ -1223,7 +1225,7 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, priv);
 
-	return snd_soc_register_codec(dev, &pm8916_wcd_analog,
+	return devm_snd_soc_register_component(dev, &pm8916_wcd_analog,
 				      pm8916_wcd_analog_dai,
 				      ARRAY_SIZE(pm8916_wcd_analog_dai));
 }
@@ -1232,7 +1234,6 @@ static int pm8916_wcd_analog_spmi_remove(struct platform_device *pdev)
 {
 	struct pm8916_wcd_analog_priv *priv = dev_get_drvdata(&pdev->dev);
 
-	snd_soc_unregister_codec(&pdev->dev);
 	clk_disable_unprepare(priv->mclk);
 
 	return 0;
-- 
2.16.1
