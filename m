From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v6 4/8] ASoC: wcd9335: add basic controls
Date: Mon, 28 Jan 2019 14:27:49 +0000
Message-ID: <20190128142753.22396-5-srinivas.kandagatla@linaro.org>
References: <20190128142753.22396-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 06E9B267456
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 15:28:36 +0100 (CET)
Received: by mail-wr1-f66.google.com with SMTP id p4so18277882wrt.7
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 06:28:36 -0800 (PST)
In-Reply-To: <20190128142753.22396-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, vkoul@kernel.org, robh+dt@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds basic controls found in wcd9335 codec.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 sound/soc/codecs/wcd9335.c | 325 +++++++++++++++++++++++++++++++++++++
 1 file changed, 325 insertions(+)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 3fdf4d8f310f..66d634764d28 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -105,6 +105,18 @@ enum {
 	NUM_CODEC_DAIS,
 };
 
+enum {
+	COMPANDER_1, /* HPH_L */
+	COMPANDER_2, /* HPH_R */
+	COMPANDER_3, /* LO1_DIFF */
+	COMPANDER_4, /* LO2_DIFF */
+	COMPANDER_5, /* LO3_SE */
+	COMPANDER_6, /* LO4_SE */
+	COMPANDER_7, /* SWR SPK CH1 */
+	COMPANDER_8, /* SWR SPK CH2 */
+	COMPANDER_MAX,
+};
+
 enum {
 	INTn_2_INP_SEL_ZERO = 0,
 	INTn_2_INP_SEL_RX0,
@@ -184,6 +196,8 @@ struct wcd9335_codec {
 
 	struct wcd_clsh_ctrl *clsh_ctrl;
 	u32 hph_mode;
+	int comp_enabled[COMPANDER_MAX];
+
 	int intr1;
 	int reset_gpio;
 	struct regulator_bulk_data supplies[WCD9335_MAX_SUPPLY];
@@ -301,6 +315,111 @@ static const struct wcd9335_reg_mask_val wcd9335_codec_reg_init[] = {
 	{WCD9335_HPH_REFBUFF_LP_CTL, 0x06, 0x02},
 };
 
+/* Cutoff frequency for high pass filter */
+static const char * const cf_text[] = {
+	"CF_NEG_3DB_4HZ", "CF_NEG_3DB_75HZ", "CF_NEG_3DB_150HZ"
+};
+
+static const char * const rx_cf_text[] = {
+	"CF_NEG_3DB_4HZ", "CF_NEG_3DB_75HZ", "CF_NEG_3DB_150HZ",
+	"CF_NEG_3DB_0P48HZ"
+};
+
+static const char * const rx_hph_mode_mux_text[] = {
+	"Class H Invalid", "Class-H Hi-Fi", "Class-H Low Power", "Class-AB",
+	"Class-H Hi-Fi Low Power"
+};
+
+static const DECLARE_TLV_DB_SCALE(digital_gain, 0, 1, 0);
+static const DECLARE_TLV_DB_SCALE(line_gain, 0, 7, 1);
+static const DECLARE_TLV_DB_SCALE(analog_gain, 0, 25, 1);
+static const DECLARE_TLV_DB_SCALE(ear_pa_gain, 0, 150, 0);
+
+static const struct soc_enum cf_dec0_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX0_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX1_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec2_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX2_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec3_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX3_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec4_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX4_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec5_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX5_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec6_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX6_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec7_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX7_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_dec8_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_TX8_TX_PATH_CFG0, 5, 3, cf_text);
+
+static const struct soc_enum cf_int0_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX0_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int0_2_enum, WCD9335_CDC_RX0_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int1_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX1_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int1_2_enum, WCD9335_CDC_RX1_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int2_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX2_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int2_2_enum, WCD9335_CDC_RX2_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int3_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX3_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int3_2_enum, WCD9335_CDC_RX3_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int4_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX4_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int4_2_enum, WCD9335_CDC_RX4_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int5_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX5_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int5_2_enum, WCD9335_CDC_RX5_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int6_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX6_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int6_2_enum, WCD9335_CDC_RX6_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int7_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX7_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int7_2_enum, WCD9335_CDC_RX7_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum cf_int8_1_enum =
+	SOC_ENUM_SINGLE(WCD9335_CDC_RX8_RX_PATH_CFG2, 0, 4, rx_cf_text);
+
+static SOC_ENUM_SINGLE_DECL(cf_int8_2_enum, WCD9335_CDC_RX8_RX_PATH_MIX_CFG, 2,
+		     rx_cf_text);
+
+static const struct soc_enum rx_hph_mode_mux_enum =
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(rx_hph_mode_mux_text),
+			    rx_hph_mode_mux_text);
+
 static int wcd9335_set_mix_interpolator_rate(struct snd_soc_dai *dai,
 					     int rate_val,
 					     u32 rate)
@@ -697,6 +816,210 @@ static struct snd_soc_dai_driver wcd9335_slim_dais[] = {
 	},
 };
 
+static int wcd9335_get_compander(struct snd_kcontrol *kc,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
+	int comp = ((struct soc_mixer_control *)kc->private_value)->shift;
+	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+
+	ucontrol->value.integer.value[0] = wcd->comp_enabled[comp];
+	return 0;
+}
+
+static int wcd9335_set_compander(struct snd_kcontrol *kc,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
+	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+	int comp = ((struct soc_mixer_control *) kc->private_value)->shift;
+	int value = ucontrol->value.integer.value[0];
+	int sel;
+
+	wcd->comp_enabled[comp] = value;
+	sel = value ? WCD9335_HPH_GAIN_SRC_SEL_COMPANDER :
+		WCD9335_HPH_GAIN_SRC_SEL_REGISTER;
+
+	/* Any specific register configuration for compander */
+	switch (comp) {
+	case COMPANDER_1:
+		/* Set Gain Source Select based on compander enable/disable */
+		snd_soc_component_update_bits(component, WCD9335_HPH_L_EN,
+				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
+		break;
+	case COMPANDER_2:
+		snd_soc_component_update_bits(component, WCD9335_HPH_R_EN,
+				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
+		break;
+	case COMPANDER_5:
+		snd_soc_component_update_bits(component, WCD9335_SE_LO_LO3_GAIN,
+				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
+		break;
+	case COMPANDER_6:
+		snd_soc_component_update_bits(component, WCD9335_SE_LO_LO4_GAIN,
+				      WCD9335_HPH_GAIN_SRC_SEL_MASK, sel);
+		break;
+	default:
+		break;
+	};
+
+	return 0;
+}
+
+static int wcd9335_rx_hph_mode_get(struct snd_kcontrol *kc,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
+	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+
+	ucontrol->value.enumerated.item[0] = wcd->hph_mode;
+
+	return 0;
+}
+
+static int wcd9335_rx_hph_mode_put(struct snd_kcontrol *kc,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kc);
+	struct wcd9335_codec *wcd = dev_get_drvdata(component->dev);
+	u32 mode_val;
+
+	mode_val = ucontrol->value.enumerated.item[0];
+
+	if (mode_val == 0) {
+		dev_err(wcd->dev, "Invalid HPH Mode, default to ClSH HiFi\n");
+		mode_val = CLS_H_HIFI;
+	}
+	wcd->hph_mode = mode_val;
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new wcd9335_snd_controls[] = {
+	/* -84dB min - 40dB max */
+	SOC_SINGLE_SX_TLV("RX0 Digital Volume", WCD9335_CDC_RX0_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX1 Digital Volume", WCD9335_CDC_RX1_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX2 Digital Volume", WCD9335_CDC_RX2_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX3 Digital Volume", WCD9335_CDC_RX3_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX4 Digital Volume", WCD9335_CDC_RX4_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX5 Digital Volume", WCD9335_CDC_RX5_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX6 Digital Volume", WCD9335_CDC_RX6_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX7 Digital Volume", WCD9335_CDC_RX7_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX8 Digital Volume", WCD9335_CDC_RX8_RX_VOL_CTL,
+		0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX0 Mix Digital Volume",
+			  WCD9335_CDC_RX0_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX1 Mix Digital Volume",
+			  WCD9335_CDC_RX1_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX2 Mix Digital Volume",
+			  WCD9335_CDC_RX2_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX3 Mix Digital Volume",
+			  WCD9335_CDC_RX3_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX4 Mix Digital Volume",
+			  WCD9335_CDC_RX4_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX5 Mix Digital Volume",
+			  WCD9335_CDC_RX5_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX6 Mix Digital Volume",
+			  WCD9335_CDC_RX6_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX7 Mix Digital Volume",
+			  WCD9335_CDC_RX7_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX8 Mix Digital Volume",
+			  WCD9335_CDC_RX8_RX_VOL_MIX_CTL,
+			  0, -84, 40, digital_gain),
+	SOC_ENUM("RX INT0_1 HPF cut off", cf_int0_1_enum),
+	SOC_ENUM("RX INT0_2 HPF cut off", cf_int0_2_enum),
+	SOC_ENUM("RX INT1_1 HPF cut off", cf_int1_1_enum),
+	SOC_ENUM("RX INT1_2 HPF cut off", cf_int1_2_enum),
+	SOC_ENUM("RX INT2_1 HPF cut off", cf_int2_1_enum),
+	SOC_ENUM("RX INT2_2 HPF cut off", cf_int2_2_enum),
+	SOC_ENUM("RX INT3_1 HPF cut off", cf_int3_1_enum),
+	SOC_ENUM("RX INT3_2 HPF cut off", cf_int3_2_enum),
+	SOC_ENUM("RX INT4_1 HPF cut off", cf_int4_1_enum),
+	SOC_ENUM("RX INT4_2 HPF cut off", cf_int4_2_enum),
+	SOC_ENUM("RX INT5_1 HPF cut off", cf_int5_1_enum),
+	SOC_ENUM("RX INT5_2 HPF cut off", cf_int5_2_enum),
+	SOC_ENUM("RX INT6_1 HPF cut off", cf_int6_1_enum),
+	SOC_ENUM("RX INT6_2 HPF cut off", cf_int6_2_enum),
+	SOC_ENUM("RX INT7_1 HPF cut off", cf_int7_1_enum),
+	SOC_ENUM("RX INT7_2 HPF cut off", cf_int7_2_enum),
+	SOC_ENUM("RX INT8_1 HPF cut off", cf_int8_1_enum),
+	SOC_ENUM("RX INT8_2 HPF cut off", cf_int8_2_enum),
+	SOC_SINGLE_EXT("COMP1 Switch", SND_SOC_NOPM, COMPANDER_1, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_SINGLE_EXT("COMP2 Switch", SND_SOC_NOPM, COMPANDER_2, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_SINGLE_EXT("COMP3 Switch", SND_SOC_NOPM, COMPANDER_3, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_SINGLE_EXT("COMP4 Switch", SND_SOC_NOPM, COMPANDER_4, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_SINGLE_EXT("COMP5 Switch", SND_SOC_NOPM, COMPANDER_5, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_SINGLE_EXT("COMP6 Switch", SND_SOC_NOPM, COMPANDER_6, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_SINGLE_EXT("COMP7 Switch", SND_SOC_NOPM, COMPANDER_7, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_SINGLE_EXT("COMP8 Switch", SND_SOC_NOPM, COMPANDER_8, 1, 0,
+		       wcd9335_get_compander, wcd9335_set_compander),
+	SOC_ENUM_EXT("RX HPH Mode", rx_hph_mode_mux_enum,
+		       wcd9335_rx_hph_mode_get, wcd9335_rx_hph_mode_put),
+
+	/* Gain Controls */
+	SOC_SINGLE_TLV("EAR PA Volume", WCD9335_ANA_EAR, 4, 4, 1,
+		ear_pa_gain),
+	SOC_SINGLE_TLV("HPHL Volume", WCD9335_HPH_L_EN, 0, 20, 1,
+		line_gain),
+	SOC_SINGLE_TLV("HPHR Volume", WCD9335_HPH_R_EN, 0, 20, 1,
+		line_gain),
+	SOC_SINGLE_TLV("LINEOUT1 Volume", WCD9335_DIFF_LO_LO1_COMPANDER,
+			3, 16, 1, line_gain),
+	SOC_SINGLE_TLV("LINEOUT2 Volume", WCD9335_DIFF_LO_LO2_COMPANDER,
+			3, 16, 1, line_gain),
+	SOC_SINGLE_TLV("LINEOUT3 Volume", WCD9335_SE_LO_LO3_GAIN, 0, 20, 1,
+			line_gain),
+	SOC_SINGLE_TLV("LINEOUT4 Volume", WCD9335_SE_LO_LO4_GAIN, 0, 20, 1,
+			line_gain),
+
+	SOC_SINGLE_TLV("ADC1 Volume", WCD9335_ANA_AMIC1, 0, 20, 0,
+			analog_gain),
+	SOC_SINGLE_TLV("ADC2 Volume", WCD9335_ANA_AMIC2, 0, 20, 0,
+			analog_gain),
+	SOC_SINGLE_TLV("ADC3 Volume", WCD9335_ANA_AMIC3, 0, 20, 0,
+			analog_gain),
+	SOC_SINGLE_TLV("ADC4 Volume", WCD9335_ANA_AMIC4, 0, 20, 0,
+			analog_gain),
+	SOC_SINGLE_TLV("ADC5 Volume", WCD9335_ANA_AMIC5, 0, 20, 0,
+			analog_gain),
+	SOC_SINGLE_TLV("ADC6 Volume", WCD9335_ANA_AMIC6, 0, 20, 0,
+			analog_gain),
+
+	SOC_ENUM("TX0 HPF cut off", cf_dec0_enum),
+	SOC_ENUM("TX1 HPF cut off", cf_dec1_enum),
+	SOC_ENUM("TX2 HPF cut off", cf_dec2_enum),
+	SOC_ENUM("TX3 HPF cut off", cf_dec3_enum),
+	SOC_ENUM("TX4 HPF cut off", cf_dec4_enum),
+	SOC_ENUM("TX5 HPF cut off", cf_dec5_enum),
+	SOC_ENUM("TX6 HPF cut off", cf_dec6_enum),
+	SOC_ENUM("TX7 HPF cut off", cf_dec7_enum),
+	SOC_ENUM("TX8 HPF cut off", cf_dec8_enum),
+};
+
 static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
 {
 	struct wcd9335_codec *wcd = data;
@@ -1162,6 +1485,8 @@ static const struct snd_soc_component_driver wcd9335_component_drv = {
 	.probe = wcd9335_codec_probe,
 	.remove = wcd9335_codec_remove,
 	.set_sysclk = wcd9335_codec_set_sysclk,
+	.controls = wcd9335_snd_controls,
+	.num_controls = ARRAY_SIZE(wcd9335_snd_controls),
 };
 
 static int wcd9335_probe(struct wcd9335_codec *wcd)
-- 
2.20.1
