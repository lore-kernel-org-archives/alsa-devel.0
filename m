From: srinivas.kandagatla@linaro.org
Subject: [PATCH v1 5/6] ASoC: codecs: msm8916-wcd-analog: add MBHC support
Date: Wed, 26 Jul 2017 02:35:11 +0200
Message-ID: <20170726003512.18965-6-srinivas.kandagatla@linaro.org>
References: <20170726003512.18965-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726003512.18965-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

MBHC (MultiButton Headset Control) support is available in pm8921 in two
blocks, one to detect mechanical headset insertion and removal and other
block to support headset type detection and 5 button detection and othe
features like impedance calculation.

This patch adds support to:
1> Support to NC and NO type of headset Jacks.
2> Mechanical insertion and detection of headset jack.
3> Detect a 3 pole Headphone and a 4 pole Headset.
4> Detect 5 buttons.

Tested it on DB410c with Audio Mezz board with 4 pole and 3 pole
headset/headphones.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/sound/qcom,msm8916-wcd-analog.txt     |   8 +
 sound/soc/codecs/msm8916-wcd-analog.c              | 323 +++++++++++++++++++++
 sound/soc/codecs/msm8916-wcd.h                     |  12 +
 3 files changed, 343 insertions(+)
 create mode 100644 sound/soc/codecs/msm8916-wcd.h

diff --git a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
index 05b67a1..c46401c 100644
--- a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
@@ -34,6 +34,14 @@ Required properties
 
 Optional Properties:
 - qcom,micbias-lvl:  Voltage (mV) for Mic Bias
+- qcom,hphl-jack-type-normally-open: boolean, present if hphl pin on jack is a
+				     NO (Normally Open). If not specified, then
+				     its assumed that hphl pin on jack is NC
+				     (Normally Closed).
+- qcom,gnd-jack-type-normally-open: boolean, present if gnd pin on jack is
+				    NO (Normally Open). If not specified, then
+				    its assumed that gnd pin on jack is NC
+				    (Normally Closed).
 - qcom,micbias1-ext-cap: boolean, present if micbias1 has external capacitor
 			 connected.
 - qcom,micbias2-ext-cap: boolean, present if micbias2 has external capacitor
diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 69df0ee..4db2349 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -12,9 +12,21 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/tlv.h>
+#include <sound/jack.h>
+#include "msm8916-wcd.h"
 
 #define CDC_D_REVISION1			(0xf000)
 #define CDC_D_PERPH_SUBTYPE		(0xf005)
+#define CDC_D_INT_EN_SET		(0x015)
+#define CDC_D_INT_EN_CLR		(0x016)
+#define MBHC_SWITCH_INT			BIT(7)
+#define MBHC_MIC_ELECTRICAL_INS_REM_DET	BIT(6)
+#define MBHC_BUTTON_PRESS_DET		BIT(5)
+#define MBHC_BUTTON_RELEASE_DET		BIT(4)
+#define CDC_DEF_INT_MASK	(MBHC_SWITCH_INT | \
+			MBHC_MIC_ELECTRICAL_INS_REM_DET	| \
+			MBHC_BUTTON_PRESS_DET | \
+			MBHC_BUTTON_RELEASE_DET)
 #define CDC_D_CDC_RST_CTL		(0xf046)
 #define RST_CTL_DIG_SW_RST_N_MASK	BIT(7)
 #define RST_CTL_DIG_SW_RST_N_RESET	0
@@ -37,6 +49,8 @@
 #define DIG_CLK_CTL_RXD1_CLK_EN		BIT(0)
 #define DIG_CLK_CTL_RXD2_CLK_EN		BIT(1)
 #define DIG_CLK_CTL_RXD3_CLK_EN		BIT(2)
+#define DIG_CLK_CTL_D_MBHC_CLK_EN_MASK	BIT(3)
+#define DIG_CLK_CTL_D_MBHC_CLK_EN	BIT(3)
 #define DIG_CLK_CTL_TXD_CLK_EN		BIT(4)
 #define DIG_CLK_CTL_NCP_CLK_EN_MASK	BIT(6)
 #define DIG_CLK_CTL_NCP_CLK_EN		BIT(6)
@@ -133,8 +147,51 @@
 #define MICB_1_INT_TX3_INT_PULLUP_EN_TX1N_TO_GND	0
 
 #define CDC_A_MICB_2_EN			(0xf144)
+#define CDC_A_MICB_2_EN_ENABLE		BIT(7)
+#define CDC_A_MICB_2_PULL_DOWN_EN_MASK	BIT(5)
+#define CDC_A_MICB_2_PULL_DOWN_EN	BIT(5)
 #define CDC_A_TX_1_2_ATEST_CTL_2	(0xf145)
 #define CDC_A_MASTER_BIAS_CTL		(0xf146)
+#define CDC_A_MBHC_DET_CTL_1		(0xf147)
+#define CDC_A_MBHC_DET_CTL_L_DET_EN			BIT(7)
+#define CDC_A_MBHC_DET_CTL_GND_DET_EN			BIT(6)
+#define CDC_A_MBHC_DET_CTL_MECH_DET_TYPE_INSERTION	BIT(5)
+#define CDC_A_MBHC_DET_CTL_MECH_DET_TYPE_REMOVAL	(0)
+#define CDC_A_MBHC_DET_CTL_MECH_DET_TYPE_MASK		BIT(5)
+#define CDC_A_MBHC_DET_CTL_MECH_DET_TYPE_SHIFT		(5)
+#define CDC_A_MBHC_DET_CTL_MIC_CLAMP_CTL_AUTO		BIT(4)
+#define CDC_A_MBHC_DET_CTL_MIC_CLAMP_CTL_MANUAL		BIT(3)
+#define CDC_A_MBHC_DET_CTL_MIC_CLAMP_CTL_MASK		GENMASK(4, 3)
+#define CDC_A_MBHC_DET_CTL_MBHC_BIAS_EN			BIT(2)
+#define CDC_A_MBHC_DET_CTL_2		(0xf150)
+#define CDC_A_MBHC_DET_CTL_HS_L_DET_PULL_UP_CTRL_I_3P0	(BIT(7) | BIT(6))
+#define CDC_A_MBHC_DET_CTL_HS_L_DET_COMPA_CTRL_V0P9_VDD	BIT(5)
+#define CDC_A_PLUG_TYPE_MASK				GENMASK(4, 3)
+#define CDC_A_HPHL_PLUG_TYPE_NO				BIT(4)
+#define CDC_A_GND_PLUG_TYPE_NO				BIT(3)
+#define CDC_A_MBHC_DET_CTL_HPHL_100K_TO_GND_EN_MASK	BIT(0)
+#define CDC_A_MBHC_DET_CTL_HPHL_100K_TO_GND_EN		BIT(0)
+#define CDC_A_MBHC_FSM_CTL		(0xf151)
+#define CDC_A_MBHC_FSM_CTL_MBHC_FSM_EN			BIT(7)
+#define CDC_A_MBHC_FSM_CTL_MBHC_FSM_EN_MASK		BIT(7)
+#define CDC_A_MBHC_FSM_CTL_BTN_ISRC_CTRL_I_100UA	(0x3 << 4)
+#define CDC_A_MBHC_FSM_CTL_BTN_ISRC_CTRL_MASK		GENMASK(6, 4)
+#define CDC_A_MBHC_DBNC_TIMER		(0xf152)
+#define CDC_A_MBHC_DBNC_TIMER_BTN_DBNC_T_16MS		BIT(3)
+#define CDC_A_MBHC_DBNC_TIMER_INSREM_DBNC_T_256_MS	(0x9 << 4)
+#define CDC_A_MBHC_BTN0_ZDET_CTL_0	(0xf153)
+#define CDC_A_MBHC_BTN1_ZDET_CTL_1	(0xf154)
+#define CDC_A_MBHC_BTN2_ZDET_CTL_2	(0xf155)
+#define CDC_A_MBHC_BTN3_CTL		(0xf156)
+#define CDC_A_MBHC_BTN4_CTL		(0xf157)
+#define CDC_A_MBHC_BTN_VREF_FINE_SHIFT	(2)
+#define CDC_A_MBHC_BTN_VREF_FINE_MASK	GENMASK(4, 2)
+#define CDC_A_MBHC_BTN_VREF_COARSE_MASK	GENMASK(7, 5)
+#define CDC_A_MBHC_BTN_VREF_COARSE_SHIFT (5)
+#define CDC_A_MBHC_BTN_VREF_MASK	(CDC_A_MBHC_BTN_VREF_COARSE_MASK | \
+					CDC_A_MBHC_BTN_VREF_FINE_MASK)
+#define CDC_A_MBHC_RESULT_1		(0xf158)
+#define CDC_A_MBHC_RESULT_1_BTN_RESULT_MASK	GENMASK(4, 0)
 #define CDC_A_TX_1_EN			(0xf160)
 #define CDC_A_TX_2_EN			(0xf161)
 #define CDC_A_TX_1_2_TEST_CTL_1		(0xf162)
@@ -226,8 +283,18 @@ static const char * const supply_names[] = {
 struct pm8916_wcd_analog_priv {
 	u16 pmic_rev;
 	u16 codec_version;
+	int	mbhc_sw_irq;
+	int	mbhc_btn_press_irq;
+	int	mbhc_btn_release_irq;
+	/* special event to detect accessory type */
+	bool	mbhc_btn0_pressed;
 	struct clk *mclk;
+	struct snd_soc_codec *codec;
 	struct regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
+	struct snd_soc_jack *jack;
+	bool hphl_jack_type_normally_open;
+	bool gnd_jack_type_normally_open;
+	struct msm8916_wcd_mbhc_data mbhc_data;
 	unsigned int micbias1_cap_mode;
 	unsigned int micbias2_cap_mode;
 	unsigned int micbias_mv;
@@ -365,6 +432,92 @@ static int pm8916_wcd_analog_enable_micbias_int1(struct
 						     wcd->micbias1_cap_mode);
 }
 
+static void pm8916_wcd_setup_mbhc(struct pm8916_wcd_analog_priv *wcd)
+{
+	struct snd_soc_codec *codec = wcd->codec;
+	u32 plug_type = 0;
+
+	snd_soc_write(codec, CDC_A_MBHC_DET_CTL_1,
+		      CDC_A_MBHC_DET_CTL_L_DET_EN |
+		      CDC_A_MBHC_DET_CTL_MECH_DET_TYPE_INSERTION |
+		      CDC_A_MBHC_DET_CTL_MIC_CLAMP_CTL_AUTO |
+		      CDC_A_MBHC_DET_CTL_MBHC_BIAS_EN);
+
+	if (wcd->hphl_jack_type_normally_open)
+		plug_type = CDC_A_HPHL_PLUG_TYPE_NO;
+
+	if (wcd->gnd_jack_type_normally_open)
+		plug_type |= CDC_A_GND_PLUG_TYPE_NO;
+
+	snd_soc_write(codec, CDC_A_MBHC_DET_CTL_2,
+		      CDC_A_MBHC_DET_CTL_HS_L_DET_PULL_UP_CTRL_I_3P0 |
+		      CDC_A_MBHC_DET_CTL_HS_L_DET_COMPA_CTRL_V0P9_VDD |
+		      plug_type |
+		      CDC_A_MBHC_DET_CTL_HPHL_100K_TO_GND_EN);
+
+
+	snd_soc_write(codec, CDC_A_MBHC_DBNC_TIMER,
+		      CDC_A_MBHC_DBNC_TIMER_INSREM_DBNC_T_256_MS |
+		      CDC_A_MBHC_DBNC_TIMER_BTN_DBNC_T_16MS);
+
+	/* enable MBHC clock */
+	snd_soc_update_bits(codec, CDC_D_CDC_DIG_CLK_CTL,
+			    DIG_CLK_CTL_D_MBHC_CLK_EN_MASK,
+			    DIG_CLK_CTL_D_MBHC_CLK_EN);
+
+	snd_soc_update_bits(codec, CDC_D_INT_EN_CLR, CDC_DEF_INT_MASK, 0);
+	snd_soc_update_bits(codec, CDC_D_INT_EN_SET, CDC_DEF_INT_MASK,
+			    CDC_DEF_INT_MASK);
+	wcd->mbhc_btn0_pressed = false;
+}
+
+static int pm8916_mbhc_configure_bias(struct pm8916_wcd_analog_priv *priv,
+				      bool micbias2_enabled)
+{
+	struct snd_soc_codec *codec = priv->codec;
+	u32 coarse, fine, reg_val, reg_addr;
+	int *vrefs, i;
+
+	if (!micbias2_enabled) { /* use internal 100uA Current source */
+		/* Enable internal 2.2k Internal Rbias Resistor */
+		snd_soc_update_bits(codec, CDC_A_MICB_1_INT_RBIAS,
+				    MICB_1_INT_TX2_INT_RBIAS_EN_MASK,
+				    MICB_1_INT_TX2_INT_RBIAS_EN_ENABLE);
+		/* Remove pull down on MIC BIAS2 */
+		snd_soc_update_bits(codec, CDC_A_MICB_2_EN,
+				   CDC_A_MICB_2_PULL_DOWN_EN_MASK,
+				   0);
+		/* enable 100uA internal current source */
+		snd_soc_update_bits(codec, CDC_A_MBHC_FSM_CTL,
+				    CDC_A_MBHC_FSM_CTL_BTN_ISRC_CTRL_MASK,
+				    CDC_A_MBHC_FSM_CTL_BTN_ISRC_CTRL_I_100UA);
+	}
+	snd_soc_update_bits(codec, CDC_A_MBHC_FSM_CTL,
+			CDC_A_MBHC_FSM_CTL_MBHC_FSM_EN_MASK,
+			CDC_A_MBHC_FSM_CTL_MBHC_FSM_EN);
+
+	if (micbias2_enabled)
+		vrefs = &priv->mbhc_data.vref_btn_micb[0];
+	else
+		vrefs = &priv->mbhc_data.vref_btn_cs[0];
+
+	/* program vref ranges for all the buttons */
+	reg_addr = CDC_A_MBHC_BTN0_ZDET_CTL_0;
+	for (i = 0; i <  MBHC_MAX_BUTTONS; i++) {
+		/* split mv in to coarse parts of 100mv & fine parts of 12mv */
+		coarse = (vrefs[i] / 100);
+		fine = ((vrefs[i] % 100) / 12);
+		reg_val = (coarse << CDC_A_MBHC_BTN_VREF_COARSE_SHIFT) |
+			 (fine << CDC_A_MBHC_BTN_VREF_FINE_SHIFT);
+		snd_soc_update_bits(codec, reg_addr,
+			       CDC_A_MBHC_BTN_VREF_MASK,
+			       reg_val);
+		reg_addr++;
+	}
+
+	return 0;
+}
+
 static int pm8916_wcd_analog_enable_micbias_int2(struct
 						  snd_soc_dapm_widget
 						  *w, struct snd_kcontrol
@@ -373,6 +526,15 @@ static int pm8916_wcd_analog_enable_micbias_int2(struct
 	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	struct pm8916_wcd_analog_priv *wcd = snd_soc_codec_get_drvdata(codec);
 
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		pm8916_mbhc_configure_bias(wcd, true);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		pm8916_mbhc_configure_bias(wcd, false);
+		break;
+	}
+
 	return pm8916_wcd_analog_enable_micbias_int(codec, event, w->reg,
 						     wcd->micbias2_cap_mode);
 }
@@ -540,9 +702,14 @@ static int pm8916_wcd_analog_probe(struct snd_soc_codec *codec)
 		snd_soc_write(codec, wcd_reg_defaults_2_0[reg].reg,
 			      wcd_reg_defaults_2_0[reg].def);
 
+	priv->codec = codec;
+
 	snd_soc_update_bits(codec, CDC_D_CDC_RST_CTL,
 			    RST_CTL_DIG_SW_RST_N_MASK,
 			    RST_CTL_DIG_SW_RST_N_REMOVE_RESET);
+
+	pm8916_wcd_setup_mbhc(priv);
+
 	return 0;
 }
 
@@ -741,11 +908,110 @@ static const struct snd_soc_dapm_widget pm8916_wcd_analog_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("A_MCLK2", CDC_D_CDC_TOP_CLK_CTL, 3, 0, NULL, 0),
 };
 
+static int pm8916_wcd_analog_set_jack(struct snd_soc_codec *codec,
+				      struct snd_soc_jack *jack,
+				      void *data)
+{
+	struct msm8916_wcd_mbhc_data *d = data;
+	struct pm8916_wcd_analog_priv *wcd = snd_soc_codec_get_drvdata(codec);
+
+	wcd->jack = jack;
+	wcd->mbhc_data = *d;
+
+	return 0;
+}
+
 static struct regmap *pm8916_get_regmap(struct device *dev)
 {
 	return dev_get_regmap(dev->parent, NULL);
 }
 
+static irqreturn_t mbhc_btn_release_irq_handler(int irq, void *arg)
+{
+	struct pm8916_wcd_analog_priv *priv = arg;
+	struct snd_soc_codec *codec = priv->codec;
+	u32 btn_result;
+
+	btn_result = snd_soc_read(codec, CDC_A_MBHC_RESULT_1) &
+				  CDC_A_MBHC_RESULT_1_BTN_RESULT_MASK;
+
+	if (!btn_result)
+		priv->mbhc_btn0_pressed = false;
+
+	snd_jack_report(priv->jack->jack, 0);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mbhc_btn_press_irq_handler(int irq, void *arg)
+{
+	struct pm8916_wcd_analog_priv *priv = arg;
+	struct snd_soc_codec *codec = priv->codec;
+	u32 btn_result;
+
+	btn_result = snd_soc_read(codec, CDC_A_MBHC_RESULT_1) &
+				  CDC_A_MBHC_RESULT_1_BTN_RESULT_MASK;
+
+	switch (btn_result) {
+	case 0xf:
+		snd_jack_report(priv->jack->jack, SND_JACK_BTN_4);
+		break;
+	case 0x7:
+		snd_jack_report(priv->jack->jack, SND_JACK_BTN_3);
+		break;
+	case 0x3:
+		snd_jack_report(priv->jack->jack, SND_JACK_BTN_2);
+		break;
+	case 0x1:
+		snd_jack_report(priv->jack->jack, SND_JACK_BTN_1);
+		break;
+	case 0:
+		priv->mbhc_btn0_pressed = true;
+		snd_jack_report(priv->jack->jack, SND_JACK_BTN_0);
+		break;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t pm8916_mbhc_switch_irq_handler(int irq, void *arg)
+{
+	struct pm8916_wcd_analog_priv *priv = arg;
+	struct snd_soc_codec *codec = priv->codec;
+	bool micbias_enabled = false;
+	bool ins = false;
+
+	if (snd_soc_read(codec, CDC_A_MBHC_DET_CTL_1) &
+				CDC_A_MBHC_DET_CTL_MECH_DET_TYPE_MASK)
+		ins = true;
+
+	/* Set the detection type appropriately */
+	snd_soc_update_bits(codec, CDC_A_MBHC_DET_CTL_1,
+			    CDC_A_MBHC_DET_CTL_MECH_DET_TYPE_MASK,
+			    (!ins << CDC_A_MBHC_DET_CTL_MECH_DET_TYPE_SHIFT));
+	if (ins) { /* hs insertion */
+		if (snd_soc_read(codec, CDC_A_MICB_2_EN) &
+				CDC_A_MICB_2_EN_ENABLE)
+			micbias_enabled = true;
+
+		pm8916_mbhc_configure_bias(priv, micbias_enabled);
+
+		/*
+		 * if only a btn press event is receive just before
+		 * insert event then its a 3 pole headphone
+		 */
+		if (priv->mbhc_btn0_pressed)
+			snd_jack_report(priv->jack->jack, SND_JACK_HEADPHONE);
+		else
+			snd_jack_report(priv->jack->jack, SND_JACK_HEADSET);
+
+	} else { /* removal */
+		snd_jack_report(priv->jack->jack, 0);
+	}
+
+	return IRQ_HANDLED;
+}
+
 static struct snd_soc_dai_driver pm8916_wcd_analog_dai[] = {
 	[0] = {
 	       .name = "pm8916_wcd_analog_pdm_rx",
@@ -774,6 +1040,7 @@ static struct snd_soc_dai_driver pm8916_wcd_analog_dai[] = {
 static struct snd_soc_codec_driver pm8916_wcd_analog = {
 	.probe = pm8916_wcd_analog_probe,
 	.remove = pm8916_wcd_analog_remove,
+	.set_jack = pm8916_wcd_analog_set_jack,
 	.get_regmap = pm8916_get_regmap,
 	.component_driver = {
 		.controls = pm8916_wcd_analog_snd_controls,
@@ -803,6 +1070,18 @@ static int pm8916_wcd_analog_parse_dt(struct device *dev,
 				 &priv->micbias_mv))
 		priv->micbias_mv = MICB_DEFAULT_VAL;
 
+	if (of_property_read_bool(dev->of_node,
+				  "qcom,hphl-jack-type-normally-open"))
+		priv->hphl_jack_type_normally_open = true;
+	else
+		priv->hphl_jack_type_normally_open = false;
+
+	if (of_property_read_bool(dev->of_node,
+				  "qcom,gnd-jack-type-normally-open"))
+		priv->gnd_jack_type_normally_open = true;
+	else
+		priv->gnd_jack_type_normally_open = false;
+
 	return 0;
 }
 
@@ -842,6 +1121,50 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	priv->mbhc_sw_irq = platform_get_irq_byname(pdev, "mbhc_switch_int");
+	if (priv->mbhc_sw_irq < 0) {
+		dev_err(dev, "failed to get mbhc switch irq\n");
+		return priv->mbhc_sw_irq;
+	}
+
+	priv->mbhc_btn_press_irq = platform_get_irq_byname(pdev,
+							"mbhc_but_press_det");
+	if (priv->mbhc_btn_press_irq < 0) {
+		dev_err(dev, "failed to get button press irq\n");
+		return priv->mbhc_btn_press_irq;
+	}
+
+	priv->mbhc_btn_release_irq = platform_get_irq_byname(pdev,
+							"mbhc_but_rel_det");
+	if (priv->mbhc_btn_release_irq < 0) {
+		dev_err(dev, "failed to get button release irq\n");
+		return priv->mbhc_btn_release_irq;
+	}
+
+	ret = devm_request_irq(dev, priv->mbhc_btn_release_irq,
+			       mbhc_btn_release_irq_handler,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
+				IRQF_ONESHOT,
+				       "mbhc btn release irq", priv);
+	if (ret)
+		dev_err(dev, "cannot request mbhc button release irq\n");
+
+	ret = devm_request_irq(dev, priv->mbhc_btn_press_irq,
+			       mbhc_btn_press_irq_handler,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
+				IRQF_ONESHOT,
+				       "mbhc btn press irq", priv);
+	if (ret)
+		dev_err(dev, "cannot request mbhc button press irq\n");
+
+	ret = devm_request_irq(dev, priv->mbhc_sw_irq,
+			       pm8916_mbhc_switch_irq_handler,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
+				IRQF_ONESHOT,
+				       "mbhc switch irq", priv);
+	if (ret)
+		dev_err(dev, "cannot request mbhc switch irq\n");
+
 	dev_set_drvdata(dev, priv);
 
 	return snd_soc_register_codec(dev, &pm8916_wcd_analog,
diff --git a/sound/soc/codecs/msm8916-wcd.h b/sound/soc/codecs/msm8916-wcd.h
new file mode 100644
index 0000000..23f1d7a
--- /dev/null
+++ b/sound/soc/codecs/msm8916-wcd.h
@@ -0,0 +1,12 @@
+#ifndef _MSM8916_WCD_H_
+#define _MSM8916_WCD_H_
+
+#define MBHC_MAX_BUTTONS	(5)
+struct msm8916_wcd_mbhc_data {
+	/* Voltage threshold when internal current source of 100uA is used */
+	int vref_btn_cs[MBHC_MAX_BUTTONS];
+	/* Voltage threshold when microphone bias is ON */
+	int vref_btn_micb[MBHC_MAX_BUTTONS];
+};
+
+#endif /* _MSM8916_WCD_H_ */
-- 
2.9.3
