From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 2/2] ASoC: qcom: add apq8016 sound card support
Date: Tue,  9 Jun 2015 13:59:36 +0100
Message-ID: <1433854776-23852-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1433854702-23654-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1433854702-23654-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Rob Herring <robh+dt@kernel.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds apq8016 machine driver support. This patch is tested on
DB410c and msm8916-mtp board for both hdmi and analog audio
features.

Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig       |   9 ++
 sound/soc/qcom/Makefile      |   2 +
 sound/soc/qcom/apq8016_sbc.c | 208 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+)
 create mode 100644 sound/soc/qcom/apq8016_sbc.c

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 938144c..807fedf 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -32,3 +32,12 @@ config SND_SOC_STORM
 	help
           Say Y or M if you want add support for SoC audio on the
           Qualcomm Technologies IPQ806X-based Storm board.
+
+config SND_SOC_APQ8016_SBC
+	tristate "SoC Audio support for APQ8016 SBC platforms"
+	depends on SND_SOC_QCOM && (ARCH_QCOM || COMPILE_TEST)
+	select SND_SOC_LPASS_APQ8016
+	help
+          Support for Qualcomm Technologies LPASS audio block in
+          APQ8016 SOC-based systems.
+          Say Y if you want to use audio devices on MI2S.
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
index ac76308..79e5c50 100644
--- a/sound/soc/qcom/Makefile
+++ b/sound/soc/qcom/Makefile
@@ -11,5 +11,7 @@ obj-$(CONFIG_SND_SOC_LPASS_APQ8016) += snd-soc-lpass-apq8016.o
 
 # Machine
 snd-soc-storm-objs := storm.o
+snd-soc-apq8016-sbc-objs := apq8016_sbc.o
 
 obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
+obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
new file mode 100644
index 0000000..f7a5e76
--- /dev/null
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -0,0 +1,208 @@
+/*
+ * Copyright (c) 2015 The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <dt-bindings/sound/apq8016-lpass.h>
+
+struct apq8016_sbc_data {
+	void __iomem *mic_iomux;
+	void __iomem *spkr_iomux;
+	struct snd_soc_dai_link dai_link[];	/* dynamically allocated */
+};
+
+#define MIC_CTRL_QUA_WS_SLAVE_SEL_10	BIT(17)
+#define MIC_CTRL_TLMM_SCLK_EN		BIT(1)
+#define	SPKR_CTL_PRI_WS_SLAVE_SEL_11	(BIT(17) | BIT(16))
+
+static int apq8016_sbc_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_card *card = rtd->card;
+	struct apq8016_sbc_data *pdata = snd_soc_card_get_drvdata(card);
+
+	if (cpu_dai->id == MI2S_QUATERNARY) {
+		/* Configure the Quat MI2S to TLMM */
+		writel(readl(pdata->mic_iomux) |
+			MIC_CTRL_QUA_WS_SLAVE_SEL_10 |
+			MIC_CTRL_TLMM_SCLK_EN,
+			pdata->mic_iomux);
+
+		return 0;
+	} else if (cpu_dai->id == MI2S_PRIMARY) {
+		writel(readl(pdata->spkr_iomux) |
+			SPKR_CTL_PRI_WS_SLAVE_SEL_11,
+			pdata->spkr_iomux);
+
+		return 0;
+	}
+
+	dev_err(card->dev, "unsupported cpu dai configuration\n");
+
+	return -EINVAL;
+}
+
+static struct snd_soc_ops apq8016_sbc_soc_ops = {
+	.startup	= apq8016_sbc_startup,
+};
+
+static struct apq8016_sbc_data *apq8016_sbc_parse_of(struct snd_soc_card *card)
+{
+	int num_links;
+	struct device *dev = card->dev;
+	struct snd_soc_dai_link *dai_link;
+	struct device_node *np, *codec, *cpu, *node  = dev->of_node;
+	struct apq8016_sbc_data *data;
+	char *name;
+	int ret;
+
+	ret = snd_soc_of_parse_card_name(card, "qcom,model");
+	if (ret) {
+		dev_err(dev, "Error parsing card name: %d\n", ret);
+		return ERR_PTR(ret);
+	}
+
+	/* Populate links */
+	num_links = of_get_child_count(node);
+
+	/* Allocate the private data and the DAI link array */
+	data = devm_kzalloc(dev, sizeof(*data) + sizeof(*dai_link) * num_links,
+			    GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	card->dai_link	= &data->dai_link[0];
+	card->num_links	= num_links;
+
+	dai_link = data->dai_link;
+
+	for_each_child_of_node(node, np) {
+		cpu = of_get_child_by_name(np, "cpu");
+		codec = of_get_child_by_name(np, "codec");
+
+		if (!cpu || !codec) {
+			dev_err(dev, "Can't find cpu/codec DT node\n");
+			return ERR_PTR(-EINVAL);
+		}
+
+		dai_link->cpu_of_node = of_parse_phandle(cpu, "sound-dai", 0);
+		if (!dai_link->cpu_of_node) {
+			dev_err(card->dev, "error getting cpu phandle\n");
+			return ERR_PTR(-EINVAL);
+		}
+
+		dai_link->codec_of_node = of_parse_phandle(codec,
+							   "sound-dai",
+							   0);
+		if (!dai_link->codec_of_node) {
+			dev_err(card->dev, "error getting codec phandle\n");
+			return ERR_PTR(-EINVAL);
+		}
+
+		ret = snd_soc_of_get_dai_name(cpu, &dai_link->cpu_dai_name);
+		if (ret) {
+			dev_err(card->dev, "error getting cpu dai name\n");
+			return ERR_PTR(ret);
+		}
+
+		ret = snd_soc_of_get_dai_name(codec, &dai_link->codec_dai_name);
+		if (ret) {
+			dev_err(card->dev, "error getting codec dai name\n");
+			return ERR_PTR(ret);
+		}
+
+		dai_link->platform_of_node = dai_link->cpu_of_node;
+		/* For now we only support playback */
+		dai_link->playback_only = true;
+
+		/**
+		 * External codec is ADV7533
+		 * and internal codec digital part is inside apq8016
+		 * and analog part is in PMIC PM8916
+		 **/
+		if (of_property_read_bool(np, "external"))
+			name = "ADV7533";
+		else
+			name = "WCD";
+
+		dai_link->name = dai_link->stream_name = name;
+		dai_link->ops = &apq8016_sbc_soc_ops;
+		dai_link++;
+	}
+
+	return data;
+}
+
+static int apq8016_sbc_platform_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct snd_soc_card *card;
+	struct apq8016_sbc_data *data;
+	struct resource *res;
+
+	card = devm_kzalloc(dev, sizeof(*card), GFP_KERNEL);
+	if (!card)
+		return -ENOMEM;
+
+	card->dev = dev;
+	data = apq8016_sbc_parse_of(card);
+	if (IS_ERR(data)) {
+		dev_err(&pdev->dev, "Error resolving dai links: %ld\n",
+			PTR_ERR(data));
+		return PTR_ERR(data);
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mic-iomux");
+	data->mic_iomux = devm_ioremap_resource(dev, res);
+	if (IS_ERR(data->mic_iomux))
+		return PTR_ERR(data->mic_iomux);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "spkr-iomux");
+	data->spkr_iomux = devm_ioremap_resource(dev, res);
+	if (IS_ERR(data->spkr_iomux))
+		return PTR_ERR(data->spkr_iomux);
+
+	platform_set_drvdata(pdev, data);
+	snd_soc_card_set_drvdata(card, data);
+
+	return devm_snd_soc_register_card(&pdev->dev, card);
+}
+
+static const struct of_device_id apq8016_sbc_device_id[]  = {
+	{ .compatible = "qcom,apq8016-sbc-sndcard" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, apq8016_sbc_device_id);
+
+static struct platform_driver apq8016_sbc_platform_driver = {
+	.driver = {
+		.name = "qcom-apq8016-sbc",
+		.of_match_table = of_match_ptr(apq8016_sbc_device_id),
+	},
+	.probe = apq8016_sbc_platform_probe,
+};
+module_platform_driver(apq8016_sbc_platform_driver);
+
+MODULE_AUTHOR("Srinivas Kandagatla <srinivas.kandagatla@linaro.org");
+MODULE_DESCRIPTION("APQ8016 ASoC Machine Driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
