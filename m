From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC v1 2/9] ASoC: msm8x16: add driver structure
Date: Tue, 16 Feb 2016 17:32:41 +0000
Message-ID: <1455643961-1700-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1455643880-1611-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455643880-1611-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds device driver structure for msm8x16 codec.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/Kconfig       |   4 ++
 sound/soc/codecs/Makefile      |   3 +-
 sound/soc/codecs/msm8x16-wcd.c | 152 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/codecs/msm8x16-wcd.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 62b62fe..2611d3f 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -528,6 +528,10 @@ config SND_SOC_MAX98925
 config SND_SOC_MAX9850
 	tristate
 
+config SND_SOC_MSM8x16_WCD
+	tristate "Qualcomm MSM8x16 WCD"
+	depends on SPMI && MFD_SYSCON
+
 config SND_SOC_PCM1681
 	tristate "Texas Instruments PCM1681 CODEC"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 5f7b002..40ffae7 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -78,6 +78,7 @@ snd-soc-max98925-objs := max98925.o
 snd-soc-max9850-objs := max9850.o
 snd-soc-mc13783-objs := mc13783.o
 snd-soc-ml26124-objs := ml26124.o
+snd-soc-msm8x16-objs := msm8x16-wcd.o
 snd-soc-nau8825-objs := nau8825.o
 snd-soc-hdmi-codec-objs := hdmi-codec.o
 snd-soc-pcm1681-objs := pcm1681.o
@@ -195,7 +196,6 @@ snd-soc-wm9705-objs := wm9705.o
 snd-soc-wm9712-objs := wm9712.o
 snd-soc-wm9713-objs := wm9713.o
 snd-soc-wm-hubs-objs := wm_hubs.o
-
 # Amp
 snd-soc-max9877-objs := max9877.o
 snd-soc-tpa6130a2-objs := tpa6130a2.o
@@ -283,6 +283,7 @@ obj-$(CONFIG_SND_SOC_MAX98925)	+= snd-soc-max98925.o
 obj-$(CONFIG_SND_SOC_MAX9850)	+= snd-soc-max9850.o
 obj-$(CONFIG_SND_SOC_MC13783)	+= snd-soc-mc13783.o
 obj-$(CONFIG_SND_SOC_ML26124)	+= snd-soc-ml26124.o
+obj-$(CONFIG_SND_SOC_MSM8x16_WCD) +=snd-soc-msm8x16.o
 obj-$(CONFIG_SND_SOC_NAU8825)   += snd-soc-nau8825.o
 obj-$(CONFIG_SND_SOC_HDMI_CODEC)	+= snd-soc-hdmi-codec.o
 obj-$(CONFIG_SND_SOC_PCM1681)	+= snd-soc-pcm1681.o
diff --git a/sound/soc/codecs/msm8x16-wcd.c b/sound/soc/codecs/msm8x16-wcd.c
new file mode 100644
index 0000000..99217ab
--- /dev/null
+++ b/sound/soc/codecs/msm8x16-wcd.c
@@ -0,0 +1,152 @@
+
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <sound/soc.h>
+
+struct msm8x16_wcd_chip {
+	struct regmap	*analog_map;
+	struct regmap	*digital_map;
+	unsigned int	analog_base;
+	u16 pmic_rev;
+	u16 codec_version;
+
+	struct clk *mclk;
+	struct regulator *vddio;
+	struct regulator *vdd_cp;
+	struct regulator *vdd_hph;
+	struct regulator *vdd_tx_rx;
+	struct regulator *vdd_micbias;
+
+	u32 mute_mask;
+	u32 rx_bias_count;
+	bool spk_boost_set;
+	bool ear_pa_boost_set;
+	bool micbias1_cap_mode;
+	bool micbias2_cap_mode;
+};
+
+
+static int msm8x16_wcd_codec_parse_dt(struct platform_device *pdev,
+				      struct msm8x16_wcd_chip *chip)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	int ret;
+	struct regulator_bulk_data regs[5];
+	const char *ext1_cap = "qcom,micbias1-ext-cap";
+	const char *ext2_cap = "qcom,micbias2-ext-cap";
+
+	u32 res[2];
+
+	ret = of_property_read_u32_array(np, "reg", res, 2);
+	if (ret < 0)
+		return ret;
+
+
+	chip->micbias1_cap_mode =
+		(of_property_read_bool(pdev->dev.of_node, ext1_cap) ?
+		MICBIAS_EXT_BYP_CAP : MICBIAS_NO_EXT_BYP_CAP);
+
+	chip->micbias2_cap_mode =
+		(of_property_read_bool(pdev->dev.of_node, ext2_cap) ?
+		MICBIAS_EXT_BYP_CAP : MICBIAS_NO_EXT_BYP_CAP);
+
+	chip->analog_base = res[0];
+
+	chip->digital_map = syscon_regmap_lookup_by_phandle(np,
+						"qcom,lpass-codec-core");
+	if (IS_ERR(chip->digital_map))
+		return PTR_ERR(chip->digital_map);
+
+	chip->mclk = devm_clk_get(dev, "mclk");
+	if (IS_ERR(chip->mclk)) {
+		dev_err(dev, "failed to get mclk\n");
+		return PTR_ERR(chip->mclk);
+	}
+
+	regs[0].supply = "vddio";
+	regs[1].supply = "vdd-cp";
+	regs[2].supply = "vdd-hph";
+	regs[3].supply = "vdd-tx-rx";
+	regs[4].supply = "vdd-micbias";
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(regs), regs);
+	if (ret) {
+		dev_err(dev, "Failed to get regulator supplies %d\n", ret);
+		return ret;
+	}
+	chip->vddio		= regs[0].consumer;
+	chip->vdd_cp		= regs[1].consumer;
+	chip->vdd_hph		= regs[2].consumer;
+	chip->vdd_tx_rx		= regs[3].consumer;
+	chip->vdd_micbias	= regs[4].consumer;
+
+	return 0;
+}
+
+static struct snd_soc_dai_driver msm8x16_wcd_codec_dai[] = {
+};
+
+static struct snd_soc_codec_driver msm8x16_wcd_codec = {
+};
+
+static int msm8x16_wcd_probe(struct platform_device *pdev)
+{
+	struct msm8x16_wcd_chip *chip;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->analog_map = dev_get_regmap(dev->parent, NULL);
+	if (!chip->analog_map)
+		return -ENXIO;
+
+	ret = msm8x16_wcd_codec_parse_dt(pdev, chip);
+	if (IS_ERR_VALUE(ret))
+		return ret;
+
+	clk_prepare_enable(chip->mclk);
+
+	dev_set_drvdata(dev, chip);
+
+	return snd_soc_register_codec(dev, &msm8x16_wcd_codec,
+				      msm8x16_wcd_codec_dai,
+				      ARRAY_SIZE(msm8x16_wcd_codec_dai));
+}
+
+static int msm8x16_wcd_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+static const struct of_device_id msm8x16_wcd_match_table[] = {
+	{ .compatible = "qcom,msm8x16-wcd-codec" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, msm8x16_wcd_match_table);
+
+static struct platform_driver msm8x16_wcd_driver = {
+	.driver = {
+		.name = "msm8x16-wcd-codec",
+		.of_match_table = msm8x16_wcd_match_table,
+	},
+	.probe  = msm8x16_wcd_probe,
+	.remove = msm8x16_wcd_remove,
+};
+module_platform_driver(msm8x16_wcd_driver);
+
+MODULE_ALIAS("platform:spmi-wcd-codec");
+MODULE_DESCRIPTION("SPMI PMIC WCD codec driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
