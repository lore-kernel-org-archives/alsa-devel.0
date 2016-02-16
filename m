From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC v1 5/9] ASoC: msm8x16: add codec intialization setup
Date: Tue, 16 Feb 2016 17:33:03 +0000
Message-ID: <1455643983-1827-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1455643880-1611-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455643880-1611-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds codec hardware intialization code.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/msm8x16-wcd.c | 180 +++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/msm8x16-wcd.h |  11 +++
 2 files changed, 191 insertions(+)

diff --git a/sound/soc/codecs/msm8x16-wcd.c b/sound/soc/codecs/msm8x16-wcd.c
index 3598e48..bc8b38a 100644
--- a/sound/soc/codecs/msm8x16-wcd.c
+++ b/sound/soc/codecs/msm8x16-wcd.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
+#include <linux/delay.h>
 #include <linux/regulator/consumer.h>
 #include <linux/types.h>
 #include <linux/clk.h>
@@ -14,6 +15,10 @@
 #include "msm8x16-wcd-registers.h"
 #include "msm8x16-wcd.h"
 
+/* Cap mode for micbias */
+#define MICBIAS_EXT_BYP_CAP 0x00
+#define MICBIAS_NO_EXT_BYP_CAP 0x01
+
 struct msm8x16_wcd_chip {
 	struct regmap	*analog_map;
 	struct regmap	*digital_map;
@@ -124,6 +129,33 @@ static unsigned int msm8x16_wcd_read(struct snd_soc_codec *codec,
 	return val;
 }
 
+static void msm8x16_wcd_configure_cap(struct snd_soc_codec *codec,
+		bool micbias1, bool micbias2)
+{
+	struct msm8x16_wcd_chip *wcd = snd_soc_codec_get_drvdata(codec);
+
+	if (micbias1 && micbias2) {
+		if ((wcd->micbias1_cap_mode == MICBIAS_EXT_BYP_CAP) ||
+		    (wcd->micbias2_cap_mode == MICBIAS_EXT_BYP_CAP))
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_ANALOG_MICB_1_EN,
+				0x40, (MICBIAS_EXT_BYP_CAP << 6));
+		else
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_ANALOG_MICB_1_EN,
+				0x40, (MICBIAS_NO_EXT_BYP_CAP << 6));
+	} else if (micbias2) {
+		snd_soc_update_bits(codec, MSM8X16_WCD_A_ANALOG_MICB_1_EN,
+				0x40, (wcd->micbias2_cap_mode << 6));
+	} else if (micbias1) {
+		snd_soc_update_bits(codec, MSM8X16_WCD_A_ANALOG_MICB_1_EN,
+				0x40, (wcd->micbias1_cap_mode << 6));
+	} else {
+		snd_soc_update_bits(codec, MSM8X16_WCD_A_ANALOG_MICB_1_EN,
+				0x40, 0x00);
+	}
+}
+
 static int msm8x16_wcd_codec_parse_dt(struct platform_device *pdev,
 				      struct msm8x16_wcd_chip *chip)
 {
@@ -181,11 +213,159 @@ static int msm8x16_wcd_codec_parse_dt(struct platform_device *pdev,
 
 	return 0;
 }
+#define VDDIO_VOL_MIN	1800000 /* uV */
+#define VDDIO_VOL_MAX	1800000 /* uV */
+
+static int msm8x16_wcd_codec_enable_clock_block(struct snd_soc_codec *codec,
+						int enable)
+{
+	struct msm8x16_wcd_chip *msm8x16_wcd = snd_soc_codec_get_drvdata(codec);
+	unsigned long mclk_rate;
+
+	if (enable) {
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_CDC_CLK_MCLK_CTL, 0x01, 0x01);
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_CDC_CLK_PDM_CTL, 0x03, 0x03);
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_ANALOG_MASTER_BIAS_CTL, 0x30, 0x30);
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_DIGITAL_CDC_RST_CTL, 0x80, 0x80);
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_DIGITAL_CDC_TOP_CLK_CTL, 0x0C, 0x0C);
+
+		mclk_rate = clk_get_rate(msm8x16_wcd->mclk);
+
+		if (mclk_rate == 12288000)
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_CDC_TOP_CTL, 0x01, 0x00);
+		else if (mclk_rate == 9600000)
+			snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_CDC_TOP_CTL, 0x01, 0x01);
+	} else {
+		snd_soc_update_bits(codec,
+			MSM8X16_WCD_A_DIGITAL_CDC_TOP_CLK_CTL, 0x0C, 0x00);
+		snd_soc_update_bits(codec,
+				MSM8X16_WCD_A_CDC_CLK_PDM_CTL, 0x03, 0x00);
+
+	}
+	return 0;
+}
+
+static const struct msm8x16_wcd_reg_mask_val wcd_reg_defaults[] = {
+	MSM8X16_WCD_REG_VAL(MSM8X16_WCD_A_ANALOG_SPKR_DAC_CTL, 0x03),
+	MSM8X16_WCD_REG_VAL(MSM8X16_WCD_A_ANALOG_CURRENT_LIMIT, 0x82),
+	MSM8X16_WCD_REG_VAL(MSM8X16_WCD_A_ANALOG_SPKR_OCP_CTL, 0xE1),
+};
+
+static const struct msm8x16_wcd_reg_mask_val wcd_reg_defaults_2_0[] = {
+	MSM8X16_WCD_REG_VAL(MSM8X16_WCD_A_DIGITAL_PERPH_RESET_CTL3, 0x0F),
+	MSM8X16_WCD_REG_VAL(MSM8X16_WCD_A_ANALOG_TX_1_2_OPAMP_BIAS, 0x4B),
+	MSM8X16_WCD_REG_VAL(MSM8X16_WCD_A_ANALOG_NCP_FBCTRL, 0x28),
+	MSM8X16_WCD_REG_VAL(MSM8X16_WCD_A_ANALOG_SPKR_DRV_CTL, 0x69),
+	MSM8X16_WCD_REG_VAL(MSM8X16_WCD_A_ANALOG_SPKR_DRV_DBG, 0x01),
+	MSM8X16_WCD_REG_VAL(MSM8X16_WCD_A_ANALOG_BOOST_EN_CTL, 0x5F),
+	MSM8X16_WCD_REG_VAL(MSM8X16_WCD_A_ANALOG_SLOPE_COMP_IP_ZERO, 0x88),
+	MSM8X16_WCD_REG_VAL(MSM8X16_WCD_A_ANALOG_PERPH_RESET_CTL3, 0x0F),
+	MSM8X16_WCD_REG_VAL(MSM8X16_WCD_A_ANALOG_CURRENT_LIMIT, 0x82),
+	MSM8X16_WCD_REG_VAL(MSM8X16_WCD_A_ANALOG_SPKR_DAC_CTL, 0x03),
+	MSM8X16_WCD_REG_VAL(MSM8X16_WCD_A_ANALOG_SPKR_OCP_CTL, 0xE1),
+};
+
+static const struct msm8x16_wcd_reg_mask_val
+	msm8x16_wcd_codec_reg_init_val[] = {
+
+	/* Initialize current threshold to 350MA
+	 * number of wait and run cycles to 4096
+	 */
+	{MSM8X16_WCD_A_ANALOG_RX_COM_OCP_CTL, 0xFF, 0xD1},
+	{MSM8X16_WCD_A_ANALOG_RX_COM_OCP_COUNT, 0xFF, 0xFF},
+};
+
+static int msm8x16_wcd_device_up(struct snd_soc_codec *codec)
+{
+	struct msm8x16_wcd_chip *msm8x16_wcd = snd_soc_codec_get_drvdata(codec);
+	u32 reg;
+
+	snd_soc_write(codec, MSM8X16_WCD_A_DIGITAL_PERPH_RESET_CTL4, 0x01);
+	snd_soc_write(codec, MSM8X16_WCD_A_ANALOG_PERPH_RESET_CTL4, 0x01);
+
+	for (reg = 0; reg < ARRAY_SIZE(msm8x16_wcd_reset_reg_defaults); reg++)
+		if (msm8x16_wcd_reg_readable[reg])
+			msm8x16_wcd_write(codec,
+				reg, msm8x16_wcd_reset_reg_defaults[reg]);
+
+	/* delay is required to make sure sound card state updated */
+	usleep_range(5000, 5100);
+
+	for (reg = 0; reg < ARRAY_SIZE(msm8x16_wcd_codec_reg_init_val); reg++)
+		snd_soc_update_bits(codec,
+				    msm8x16_wcd_codec_reg_init_val[reg].reg,
+				    msm8x16_wcd_codec_reg_init_val[reg].mask,
+				    msm8x16_wcd_codec_reg_init_val[reg].val);
+
+	if (TOMBAK_IS_1_0(msm8x16_wcd->pmic_rev)) {
+		for (reg = 0; reg < ARRAY_SIZE(wcd_reg_defaults); reg++)
+			snd_soc_write(codec, wcd_reg_defaults[reg].reg,
+					wcd_reg_defaults[reg].val);
+	} else {
+		for (reg = 0; reg < ARRAY_SIZE(wcd_reg_defaults_2_0); reg++)
+			snd_soc_write(codec, wcd_reg_defaults_2_0[reg].reg,
+				wcd_reg_defaults_2_0[reg].val);
+	}
+
+	msm8x16_wcd_codec_enable_clock_block(codec, 1);
+
+	return 0;
+}
+
+static int msm8x16_wcd_codec_probe(struct snd_soc_codec *codec)
+{
+	struct msm8x16_wcd_chip *chip = dev_get_drvdata(codec->dev);
+	int err;
+
+	regulator_set_voltage(chip->vddio, VDDIO_VOL_MIN, VDDIO_VOL_MAX);
+	err = regulator_enable(chip->vddio);
+	if (err < 0) {
+		dev_err(codec->dev, "failed to enable VDDIO regulator\n");
+		return err;
+	}
+
+	err = regulator_enable(chip->vdd_tx_rx);
+	if (err < 0) {
+		dev_err(codec->dev, "failed to enable VDD_TX_RX regulator\n");
+		return err;
+	}
+
+	snd_soc_codec_set_drvdata(codec, chip);
+
+	chip->pmic_rev = snd_soc_read(codec, MSM8X16_WCD_A_DIGITAL_REVISION1);
+	dev_info(codec->dev, "%s :PMIC REV: %d", __func__, chip->pmic_rev);
+
+	chip->codec_version = snd_soc_read(codec,
+				MSM8X16_WCD_A_DIGITAL_PERPH_SUBTYPE);
+	dev_info(codec->dev, "%s :CODEC Version: %d", __func__,
+				chip->codec_version);
+
+	msm8x16_wcd_device_up(codec);
+
+	/* Set initial cap mode */
+	msm8x16_wcd_configure_cap(codec, false, false);
+
+	return 0;
+}
+
+static int msm8x16_wcd_codec_remove(struct snd_soc_codec *codec)
+{
+	return 0;
+};
 
 static struct snd_soc_dai_driver msm8x16_wcd_codec_dai[] = {
 };
 
 static struct snd_soc_codec_driver msm8x16_wcd_codec = {
+	.probe	= msm8x16_wcd_codec_probe,
+	.remove	= msm8x16_wcd_codec_remove,
 	.read = msm8x16_wcd_read,
 	.write = msm8x16_wcd_write,
 	.reg_cache_size = MSM8X16_WCD_NUM_REGISTERS,
diff --git a/sound/soc/codecs/msm8x16-wcd.h b/sound/soc/codecs/msm8x16-wcd.h
index db82f58..bfb6c88 100644
--- a/sound/soc/codecs/msm8x16-wcd.h
+++ b/sound/soc/codecs/msm8x16-wcd.h
@@ -16,12 +16,23 @@
 
 #define MSM8X16_WCD_NUM_REGISTERS	0x6FF
 #define MSM8X16_WCD_MAX_REGISTER	(MSM8X16_WCD_NUM_REGISTERS-1)
+#define MSM8X16_WCD_REG_VAL(reg, val)		{reg, 0, val}
 
 #define MSM8X16_WCD_IS_DIGITAL_REG(reg) \
 	(((reg >= 0x200) && (reg <= 0x4FF)) ? 1 : 0)
 #define MSM8X16_WCD_IS_TOMBAK_REG(reg) \
 	(((reg >= 0x000) && (reg <= 0x1FF)) ? 1 : 0)
 
+#define TOMBAK_VERSION_1_0	0
+#define TOMBAK_IS_1_0(ver) \
+	((ver == TOMBAK_VERSION_1_0) ? 1 : 0)
+
+struct msm8x16_wcd_reg_mask_val {
+	u16	reg;
+	u8	mask;
+	u8	val;
+};
+
 const u8 msm8x16_wcd_reg_readable[MSM8X16_WCD_NUM_REGISTERS] = {
 		[MSM8X16_WCD_A_DIGITAL_REVISION1] = 1,
 		[MSM8X16_WCD_A_DIGITAL_REVISION2] = 1,
-- 
1.9.1
