From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [Patch V5 09/12] ASoC: ipq806x: Add @max98357a machine driver
Date: Wed, 11 Feb 2015 18:10:12 -0800
Message-ID: <1423707015-14527-10-git-send-email-kwestfie@codeaurora.org>
References: <1423707015-14527-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1423707015-14527-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kenneth Westfield <kwestfie@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Add machine driver for the boards with the IPQ806X
SOC connected to the MAX98357A DAC.

Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/qcom/ipq806x-max98357a.c | 171 +++++++++++++++++++++++++++++++++++++
 1 file changed, 171 insertions(+)
 create mode 100644 sound/soc/qcom/ipq806x-max98357a.c

diff --git a/sound/soc/qcom/ipq806x-max98357a.c b/sound/soc/qcom/ipq806x-max98357a.c
new file mode 100644
index 0000000000000000000000000000000000000000..af92e9ffa42104d6e29160b9e0ffedc820388c7c
--- /dev/null
+++ b/sound/soc/qcom/ipq806x-max98357a.c
@@ -0,0 +1,171 @@
+/*
+ * Copyright (c) 2010-2011,2013-2015 The Linux Foundation. All rights reserved.
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
+ * ipq806x-max98357a.c -- ALSA SoC machine driver for QTi ipq806x SOC with
+ *                        MAX98357a DAC
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#define IPQ806X_MAX98357A_SYSCLK_MULT		4
+
+static int ipq806x_max98357a_ops_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct snd_soc_card *card = soc_runtime->card;
+	snd_pcm_format_t format = params_format(params);
+	unsigned int rate = params_rate(params);
+	unsigned int sysclk_freq;
+	int bitwidth, ret;
+
+	bitwidth = snd_pcm_format_width(format);
+	if (bitwidth < 0) {
+		dev_err(card->dev, "%s() invalid bit width given: %d\n",
+				__func__, bitwidth);
+		return bitwidth;
+	}
+
+	/*
+	 * as the CPU DAI is the I2S bus master and no system clock is needed by
+	 * the MAX98357a DAC, simply set the system clock to be a constant
+	 * multiple of the bit clock for the clock divider
+	 */
+	sysclk_freq = rate * bitwidth * 2 * IPQ806X_MAX98357A_SYSCLK_MULT;
+
+	ret = snd_soc_dai_set_sysclk(soc_runtime->cpu_dai, 0, sysclk_freq, 0);
+	if (ret) {
+		dev_err(card->dev, "%s() error setting sysclk to %u: %d\n",
+				__func__, sysclk_freq, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops ipq806x_max98357a_soc_ops = {
+	.hw_params	= ipq806x_max98357a_ops_hw_params,
+};
+
+static struct snd_soc_dai_link ipq806x_max98357a_dai_link = {
+	.name		= "IPQ806x Media1",
+	.stream_name	= "MultiMedia1",
+	.ops		= &ipq806x_max98357a_soc_ops,
+};
+
+static struct snd_soc_card ipq806x_max98357a_soc_card = {
+	.name	= "ipq806x-max98357a",
+	.dev	= NULL,
+};
+
+static int ipq806x_max98357a_parse_of(struct snd_soc_card *card)
+{
+	struct snd_soc_dai_link *dai_link = card->dai_link;
+	struct device_node *np = card->dev->of_node;
+	int ret;
+
+	dai_link->cpu_of_node = of_parse_phandle(np, "cpu", 0);
+	if (!dai_link->cpu_of_node) {
+		dev_err(card->dev, "%s() error getting cpu phandle\n",
+				__func__);
+		return -EINVAL;
+	}
+	dai_link->platform_of_node = dai_link->cpu_of_node;
+
+	dai_link->codec_of_node = of_parse_phandle(np, "codec", 0);
+	if (!dai_link->codec_of_node) {
+		dev_err(card->dev, "%s() error getting codec phandle\n",
+				__func__);
+		return -EINVAL;
+	}
+
+	ret = of_property_read_string(np, "codec-dai",
+			&dai_link->codec_dai_name);
+	if (ret) {
+		dev_err(card->dev, "%s() error getting codec-dai: %d\n",
+				__func__, ret);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ipq806x_max98357a_platform_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &ipq806x_max98357a_soc_card;
+	int ret;
+
+	if (card->dev) {
+		dev_err(&pdev->dev, "%s() error, existing soundcard\n",
+				__func__);
+		return -ENODEV;
+	}
+	card->dev = &pdev->dev;
+	platform_set_drvdata(pdev, card);
+
+	ret = snd_soc_of_parse_card_name(card, "qcom,model");
+	if (ret) {
+		dev_err(&pdev->dev, "%s() error parsing card name: %d\n",
+				__func__, ret);
+		return ret;
+	}
+
+	card->dai_link	= &ipq806x_max98357a_dai_link;
+	card->num_links	= 1;
+
+	ret = ipq806x_max98357a_parse_of(card);
+	if (ret) {
+		dev_err(&pdev->dev, "%s() error resolving dai links: %d\n",
+				__func__, ret);
+		return ret;
+	}
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret == -EPROBE_DEFER) {
+		card->dev = NULL;
+		return ret;
+	} else if (ret) {
+		dev_err(&pdev->dev, "%s() error registering soundcard: %d\n",
+				__func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id ipq806x_max98357a_device_id[]  = {
+	{ .compatible = "qcom,ipq806x-max98357a" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ipq806x_max98357a_device_id);
+#endif
+
+static struct platform_driver ipq806x_max98357a_platform_driver = {
+	.driver = {
+		.name = "ipq806x-max98357a",
+		.of_match_table =
+			of_match_ptr(ipq806x_max98357a_device_id),
+	},
+	.probe = ipq806x_max98357a_platform_probe,
+};
+module_platform_driver(ipq806x_max98357a_platform_driver);
+
+MODULE_DESCRIPTION("QTi ipq806x-max98357a Machine Driver");
+MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
