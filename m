From: srinivas.kandagatla@linaro.org
Subject: [PATCH v4 2/3] ASoC: codecs: msm8916-wcd-analog: add MBHC support
Date: Thu, 17 Aug 2017 10:02:10 +0200
Message-ID: <20170817080211.11453-3-srinivas.kandagatla@linaro.org>
References: <20170817080211.11453-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170817080211.11453-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: damien.riegel@savoirfairelinux.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
Tested-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 .../bindings/sound/qcom,msm8916-wcd-analog.txt     |  17 +-
 sound/soc/codecs/msm8916-wcd-analog.c              | 373 ++++++++++++++++++++-
 2 files changed, 388 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
index 05b67a1d4851..551ecab67efe 100644
--- a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
@@ -31,9 +31,22 @@ Required properties
  - vdd-cdc-io-supply: phandle to VDD_CDC_IO regulator DT node.
  - vdd-cdc-tx-rx-cx-supply: phandle to VDD_CDC_TX/RX/CX regulator DT node.
  - vdd-micbias-supply: phandle of VDD_MICBIAS supply's regulator DT node.
-
 Optional Properties:
+ - qcom,mbhc-vthreshold-low: Array of 5 threshold voltages in mV for 5 buttons
+			     detection on headset when the mbhc is powered up
+			     by internal current source, this is a low power.
+ - qcom,mbhc-vthreshold-high: Array of 5 thresold voltages in mV for 5 buttons
+			      detection on headset when mbhc is powered up
+			       from micbias.
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
@@ -49,6 +62,8 @@ spmi_bus {
 		reg-names = "pmic-codec-core";
 		clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
 		clock-names = "mclk";
+		qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
+		qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
 		interrupt-parent = <&spmi_bus>;
 		interrupts = <0x1 0xf0 0x0 IRQ_TYPE_NONE>,
 			     <0x1 0xf0 0x1 IRQ_TYPE_NONE>,
diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 8633524b1961..f834a639b350 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -12,9 +12,16 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/tlv.h>
+#include <sound/jack.h>
 
 #define CDC_D_REVISION1			(0xf000)
 #define CDC_D_PERPH_SUBTYPE		(0xf005)
+#define CDC_D_INT_EN_SET		(0x015)
+#define CDC_D_INT_EN_CLR		(0x016)
+#define MBHC_SWITCH_INT			BIT(7)
+#define MBHC_MIC_ELECTRICAL_INS_REM_DET	BIT(6)
+#define MBHC_BUTTON_PRESS_DET		BIT(5)
+#define MBHC_BUTTON_RELEASE_DET		BIT(4)
 #define CDC_D_CDC_RST_CTL		(0xf046)
 #define RST_CTL_DIG_SW_RST_N_MASK	BIT(7)
 #define RST_CTL_DIG_SW_RST_N_RESET	0
@@ -37,6 +44,8 @@
 #define DIG_CLK_CTL_RXD1_CLK_EN		BIT(0)
 #define DIG_CLK_CTL_RXD2_CLK_EN		BIT(1)
 #define DIG_CLK_CTL_RXD3_CLK_EN		BIT(2)
+#define DIG_CLK_CTL_D_MBHC_CLK_EN_MASK	BIT(3)
+#define DIG_CLK_CTL_D_MBHC_CLK_EN	BIT(3)
 #define DIG_CLK_CTL_TXD_CLK_EN		BIT(4)
 #define DIG_CLK_CTL_NCP_CLK_EN_MASK	BIT(6)
 #define DIG_CLK_CTL_NCP_CLK_EN		BIT(6)
@@ -132,8 +141,51 @@
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
@@ -217,16 +269,34 @@
 #define MSM8916_WCD_ANALOG_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
 				    SNDRV_PCM_FMTBIT_S24_LE)
 
+static int btn_mask = SND_JACK_BTN_0 | SND_JACK_BTN_1 |
+	       SND_JACK_BTN_2 | SND_JACK_BTN_3 | SND_JACK_BTN_4;
+static int hs_jack_mask = SND_JACK_HEADPHONE | SND_JACK_HEADSET;
+
 static const char * const supply_names[] = {
 	"vdd-cdc-io",
 	"vdd-cdc-tx-rx-cx",
 };
 
+#define MBHC_MAX_BUTTONS	(5)
+
 struct pm8916_wcd_analog_priv {
 	u16 pmic_rev;
 	u16 codec_version;
+	bool	mbhc_btn_enabled;
+	/* special event to detect accessory type */
+	bool	mbhc_btn0_pressed;
+	bool	detect_accessory_type;
 	struct clk *mclk;
+	struct snd_soc_codec *codec;
 	struct regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
+	struct snd_soc_jack *jack;
+	bool hphl_jack_type_normally_open;
+	bool gnd_jack_type_normally_open;
+	/* Voltage threshold when internal current source of 100uA is used */
+	u32 vref_btn_cs[MBHC_MAX_BUTTONS];
+	/* Voltage threshold when microphone bias is ON */
+	u32 vref_btn_micb[MBHC_MAX_BUTTONS];
 	unsigned int micbias1_cap_mode;
 	unsigned int micbias2_cap_mode;
 	unsigned int micbias_mv;
@@ -373,6 +443,97 @@ static int pm8916_wcd_analog_enable_micbias_int1(struct
 						     wcd->micbias1_cap_mode);
 }
 
+static void pm8916_wcd_setup_mbhc(struct pm8916_wcd_analog_priv *wcd)
+{
+	struct snd_soc_codec *codec = wcd->codec;
+	u32 plug_type = 0;
+	u32 int_en_mask;
+
+	snd_soc_write(codec, CDC_A_MBHC_DET_CTL_1,
+		      CDC_A_MBHC_DET_CTL_L_DET_EN |
+		      CDC_A_MBHC_DET_CTL_MECH_DET_TYPE_INSERTION |
+		      CDC_A_MBHC_DET_CTL_MIC_CLAMP_CTL_AUTO |
+		      CDC_A_MBHC_DET_CTL_MBHC_BIAS_EN);
+
+	if (wcd->hphl_jack_type_normally_open)
+		plug_type |= CDC_A_HPHL_PLUG_TYPE_NO;
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
+	int_en_mask = MBHC_SWITCH_INT;
+	if (wcd->mbhc_btn_enabled)
+		int_en_mask |= MBHC_BUTTON_PRESS_DET | MBHC_BUTTON_RELEASE_DET;
+
+	snd_soc_update_bits(codec, CDC_D_INT_EN_CLR, int_en_mask, 0);
+	snd_soc_update_bits(codec, CDC_D_INT_EN_SET, int_en_mask, int_en_mask);
+	wcd->mbhc_btn0_pressed = false;
+	wcd->detect_accessory_type = true;
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
+		vrefs = &priv->vref_btn_micb[0];
+	else
+		vrefs = &priv->vref_btn_cs[0];
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
@@ -381,6 +542,15 @@ static int pm8916_wcd_analog_enable_micbias_int2(struct
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
@@ -548,9 +718,14 @@ static int pm8916_wcd_analog_probe(struct snd_soc_codec *codec)
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
 
@@ -749,11 +924,130 @@ static const struct snd_soc_dapm_widget pm8916_wcd_analog_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("A_MCLK2", CDC_D_CDC_TOP_CLK_CTL, 3, 0, NULL, 0),
 };
 
+static int pm8916_wcd_analog_set_jack(struct snd_soc_codec *codec,
+				      struct snd_soc_jack *jack,
+				      void *data)
+{
+	struct pm8916_wcd_analog_priv *wcd = snd_soc_codec_get_drvdata(codec);
+
+	wcd->jack = jack;
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
+
+	if (priv->detect_accessory_type) {
+		struct snd_soc_codec *codec = priv->codec;
+		u32 val = snd_soc_read(codec, CDC_A_MBHC_RESULT_1);
+
+		/* check if its BTN0 thats released */
+		if ((val >= 0) && !(val & CDC_A_MBHC_RESULT_1_BTN_RESULT_MASK))
+			priv->mbhc_btn0_pressed = false;
+
+	} else {
+		snd_soc_jack_report(priv->jack, 0, btn_mask);
+	}
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
+		snd_soc_jack_report(priv->jack, SND_JACK_BTN_4, btn_mask);
+		break;
+	case 0x7:
+		snd_soc_jack_report(priv->jack, SND_JACK_BTN_3, btn_mask);
+		break;
+	case 0x3:
+		snd_soc_jack_report(priv->jack, SND_JACK_BTN_2, btn_mask);
+		break;
+	case 0x1:
+		snd_soc_jack_report(priv->jack, SND_JACK_BTN_1, btn_mask);
+		break;
+	case 0x0:
+		/* handle BTN_0 specially for type detection */
+		if (priv->detect_accessory_type)
+			priv->mbhc_btn0_pressed = true;
+		else
+			snd_soc_jack_report(priv->jack,
+					    SND_JACK_BTN_0, btn_mask);
+		break;
+	default:
+		dev_err(codec->dev,
+			"Unexpected button press result (%x)", btn_result);
+		break;
+	}
+
+	return IRQ_HANDLED;
+}
+
+
+static irqreturn_t pm8916_mbhc_switch_irq_handler(int irq, void *arg)
+{
+	struct pm8916_wcd_analog_priv *priv = arg;
+	struct snd_soc_codec *codec = priv->codec;
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
+
+
+	if (ins) { /* hs insertion */
+		bool micbias_enabled = false;
+
+		if (snd_soc_read(codec, CDC_A_MICB_2_EN) &
+				CDC_A_MICB_2_EN_ENABLE)
+			micbias_enabled = true;
+
+		pm8916_mbhc_configure_bias(priv, micbias_enabled);
+
+		/*
+		 * if only a btn0 press event is receive just before
+		 * insert event then its a 3 pole headphone else if
+		 * both press and release event received then its
+		 * a headset.
+		 */
+		if (priv->mbhc_btn0_pressed)
+			snd_soc_jack_report(priv->jack,
+					    SND_JACK_HEADPHONE, hs_jack_mask);
+		else
+			snd_soc_jack_report(priv->jack,
+					    SND_JACK_HEADSET, hs_jack_mask);
+
+		priv->detect_accessory_type = false;
+
+	} else { /* removal */
+		snd_soc_jack_report(priv->jack, 0, hs_jack_mask);
+		priv->detect_accessory_type = true;
+		priv->mbhc_btn0_pressed = false;
+	}
+
+	return IRQ_HANDLED;
+}
+
 static struct snd_soc_dai_driver pm8916_wcd_analog_dai[] = {
 	[0] = {
 	       .name = "pm8916_wcd_analog_pdm_rx",
@@ -782,6 +1076,7 @@ static struct snd_soc_dai_driver pm8916_wcd_analog_dai[] = {
 static const struct snd_soc_codec_driver pm8916_wcd_analog = {
 	.probe = pm8916_wcd_analog_probe,
 	.remove = pm8916_wcd_analog_remove,
+	.set_jack = pm8916_wcd_analog_set_jack,
 	.get_regmap = pm8916_get_regmap,
 	.component_driver = {
 		.controls = pm8916_wcd_analog_snd_controls,
@@ -796,6 +1091,7 @@ static const struct snd_soc_codec_driver pm8916_wcd_analog = {
 static int pm8916_wcd_analog_parse_dt(struct device *dev,
 				       struct pm8916_wcd_analog_priv *priv)
 {
+	int rval;
 
 	if (of_property_read_bool(dev->of_node, "qcom,micbias1-ext-cap"))
 		priv->micbias1_cap_mode = MICB_1_EN_EXT_BYP_CAP;
@@ -810,6 +1106,39 @@ static int pm8916_wcd_analog_parse_dt(struct device *dev,
 	of_property_read_u32(dev->of_node, "qcom,micbias-lvl",
 			     &priv->micbias_mv);
 
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
+	priv->mbhc_btn_enabled = true;
+	rval = of_property_read_u32_array(dev->of_node,
+					  "qcom,mbhc-vthreshold-low",
+					  &priv->vref_btn_cs[0],
+					  MBHC_MAX_BUTTONS);
+	if (rval < 0) {
+		priv->mbhc_btn_enabled = false;
+	} else {
+		rval = of_property_read_u32_array(dev->of_node,
+						  "qcom,mbhc-vthreshold-high",
+						  &priv->vref_btn_micb[0],
+						  MBHC_MAX_BUTTONS);
+		if (rval < 0)
+			priv->mbhc_btn_enabled = false;
+	}
+
+	if (!priv->mbhc_btn_enabled)
+		dev_err(dev,
+			"DT property missing, MBHC btn detection disabled\n");
+
+
 	return 0;
 }
 
@@ -817,7 +1146,7 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 {
 	struct pm8916_wcd_analog_priv *priv;
 	struct device *dev = &pdev->dev;
-	int ret, i;
+	int ret, i, irq;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -849,6 +1178,48 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	irq = platform_get_irq_byname(pdev, "mbhc_switch_int");
+	if (irq < 0) {
+		dev_err(dev, "failed to get mbhc switch irq\n");
+		return irq;
+	}
+
+	ret = devm_request_irq(dev, irq, pm8916_mbhc_switch_irq_handler,
+			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
+			       IRQF_ONESHOT,
+			       "mbhc switch irq", priv);
+	if (ret)
+		dev_err(dev, "cannot request mbhc switch irq\n");
+
+	if (priv->mbhc_btn_enabled) {
+		irq = platform_get_irq_byname(pdev, "mbhc_but_press_det");
+		if (irq < 0) {
+			dev_err(dev, "failed to get button press irq\n");
+			return irq;
+		}
+
+		ret = devm_request_irq(dev, irq, mbhc_btn_press_irq_handler,
+				       IRQF_TRIGGER_RISING |
+				       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				       "mbhc btn press irq", priv);
+		if (ret)
+			dev_err(dev, "cannot request mbhc button press irq\n");
+
+		irq = platform_get_irq_byname(pdev, "mbhc_but_rel_det");
+		if (irq < 0) {
+			dev_err(dev, "failed to get button release irq\n");
+			return irq;
+		}
+
+		ret = devm_request_irq(dev, irq, mbhc_btn_release_irq_handler,
+				       IRQF_TRIGGER_RISING |
+				       IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				       "mbhc btn release irq", priv);
+		if (ret)
+			dev_err(dev, "cannot request mbhc button release irq\n");
+
+	}
+
 	dev_set_drvdata(dev, priv);
 
 	return snd_soc_register_codec(dev, &pm8916_wcd_analog,
-- 
2.11.0
