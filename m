From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC v1 7/9] ASoC: msm8x16: Add sound mixer controls.
Date: Tue, 16 Feb 2016 17:33:28 +0000
Message-ID: <1455644008-1917-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1455643880-1611-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455643880-1611-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds basic mixer controls found in the codec.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/msm8x16-wcd.c | 99 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/sound/soc/codecs/msm8x16-wcd.c b/sound/soc/codecs/msm8x16-wcd.c
index 4bc8274..4bf3b81 100644
--- a/sound/soc/codecs/msm8x16-wcd.c
+++ b/sound/soc/codecs/msm8x16-wcd.c
@@ -13,6 +13,7 @@
 #include <sound/soc.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
+#include <sound/tlv.h>
 
 #include "msm8x16-wcd-registers.h"
 #include "msm8x16-wcd.h"
@@ -49,6 +50,29 @@ struct msm8x16_wcd_chip {
 	bool micbias2_cap_mode;
 };
 
+static const char * const msm8x16_wcd_spk_boost_ctrl_text[] = {
+		"DISABLE", "ENABLE"};
+
+/*cut of frequency for high pass filter*/
+static const char * const cf_text[] = {
+	"MIN_3DB_4Hz", "MIN_3DB_75Hz", "MIN_3DB_150Hz"
+};
+
+static const struct soc_enum msm8x16_wcd_spk_boost_ctl_enum[] = {
+		SOC_ENUM_SINGLE_EXT(2, msm8x16_wcd_spk_boost_ctrl_text),
+};
+static const struct soc_enum cf_rxmix1_enum =
+	SOC_ENUM_SINGLE(MSM8X16_WCD_A_CDC_RX1_B4_CTL, 0, 3, cf_text);
+
+static const struct soc_enum cf_rxmix2_enum =
+	SOC_ENUM_SINGLE(MSM8X16_WCD_A_CDC_RX2_B4_CTL, 0, 3, cf_text);
+
+static const struct soc_enum cf_rxmix3_enum =
+	SOC_ENUM_SINGLE(MSM8X16_WCD_A_CDC_RX3_B4_CTL, 0, 3, cf_text);
+
+static const DECLARE_TLV_DB_SCALE(digital_gain, 0, 1, 0);
+static const DECLARE_TLV_DB_SCALE(analog_gain, 0, 25, 1);
+
 static int msm8x16_wcd_volatile(struct snd_soc_codec *codec, unsigned int reg)
 {
 	return msm8x16_wcd_reg_readonly[reg];
@@ -164,6 +188,79 @@ static void msm8x16_wcd_configure_cap(struct snd_soc_codec *codec,
 	}
 }
 
+static int msm8x16_wcd_spk_boost_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct msm8x16_wcd_chip *msm8x16_wcd = dev_get_drvdata(codec->dev);
+
+	if (msm8x16_wcd->spk_boost_set == false) {
+		ucontrol->value.integer.value[0] = 0;
+	} else if (msm8x16_wcd->spk_boost_set == true) {
+		ucontrol->value.integer.value[0] = 1;
+	} else  {
+		dev_err(codec->dev, "%s: ERROR: Unsupported Speaker Boost = %d\n",
+			__func__, msm8x16_wcd->spk_boost_set);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int msm8x16_wcd_spk_boost_set(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
+	struct msm8x16_wcd_chip *msm8x16_wcd = snd_soc_codec_get_drvdata(codec);
+
+	switch (ucontrol->value.integer.value[0]) {
+	case 0:
+		msm8x16_wcd->spk_boost_set = false;
+		break;
+	case 1:
+		msm8x16_wcd->spk_boost_set = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static const struct snd_kcontrol_new msm8x16_wcd_snd_controls[] = {
+
+	SOC_ENUM_EXT("Speaker Boost", msm8x16_wcd_spk_boost_ctl_enum[0],
+		msm8x16_wcd_spk_boost_get, msm8x16_wcd_spk_boost_set),
+
+	SOC_SINGLE_TLV("ADC1 Volume", MSM8X16_WCD_A_ANALOG_TX_1_EN, 3,
+					8, 0, analog_gain),
+	SOC_SINGLE_TLV("ADC2 Volume", MSM8X16_WCD_A_ANALOG_TX_2_EN, 3,
+					8, 0, analog_gain),
+	SOC_SINGLE_TLV("ADC3 Volume", MSM8X16_WCD_A_ANALOG_TX_3_EN, 3,
+					8, 0, analog_gain),
+
+	SOC_SINGLE_SX_TLV("RX1 Digital Volume",
+			  MSM8X16_WCD_A_CDC_RX1_VOL_CTL_B2_CTL,
+			0,  -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX2 Digital Volume",
+			  MSM8X16_WCD_A_CDC_RX2_VOL_CTL_B2_CTL,
+			0,  -84, 40, digital_gain),
+	SOC_SINGLE_SX_TLV("RX3 Digital Volume",
+			  MSM8X16_WCD_A_CDC_RX3_VOL_CTL_B2_CTL,
+			0,  -84, 40, digital_gain),
+
+	SOC_SINGLE("RX1 HPF Switch",
+		MSM8X16_WCD_A_CDC_RX1_B5_CTL, 2, 1, 0),
+	SOC_SINGLE("RX2 HPF Switch",
+		MSM8X16_WCD_A_CDC_RX2_B5_CTL, 2, 1, 0),
+	SOC_SINGLE("RX3 HPF Switch",
+		MSM8X16_WCD_A_CDC_RX3_B5_CTL, 2, 1, 0),
+
+	SOC_ENUM("RX1 HPF cut off", cf_rxmix1_enum),
+	SOC_ENUM("RX2 HPF cut off", cf_rxmix2_enum),
+	SOC_ENUM("RX3 HPF cut off", cf_rxmix3_enum),
+};
+
+
 static int msm8x16_wcd_codec_parse_dt(struct platform_device *pdev,
 				      struct msm8x16_wcd_chip *chip)
 {
@@ -551,6 +648,8 @@ static struct snd_soc_codec_driver msm8x16_wcd_codec = {
 	.reg_cache_size = MSM8X16_WCD_NUM_REGISTERS,
 	.reg_cache_default = msm8x16_wcd_reset_reg_defaults,
 	.reg_word_size = 1,
+	.controls = msm8x16_wcd_snd_controls,
+	.num_controls = ARRAY_SIZE(msm8x16_wcd_snd_controls),
 };
 
 static int msm8x16_wcd_probe(struct platform_device *pdev)
-- 
1.9.1
