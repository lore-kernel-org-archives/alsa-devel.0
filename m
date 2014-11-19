From: Kenneth Westfield <kwestfie@codeaurora.org>
Subject: [PATCH 6/9] ASoC: ipq806x: Add machine driver for IPQ806X SOC
Date: Wed, 19 Nov 2014 10:52:46 -0800
Message-ID: <1416423169-21865-7-git-send-email-kwestfie@codeaurora.org>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie@codeaurora.org>

Add machine driver for the IPQ806X LPASS SOC.

Change-Id: Ica26398fafd3098cdd12dcf45ebccec2ad820002
Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
---
 sound/soc/qcom/ipq806x.c | 221 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 221 insertions(+)
 create mode 100644 sound/soc/qcom/ipq806x.c

diff --git a/sound/soc/qcom/ipq806x.c b/sound/soc/qcom/ipq806x.c
new file mode 100644
index 0000000000000000000000000000000000000000..e973bd71fa7fe117e73b1b562ec2758b3379e98f
--- /dev/null
+++ b/sound/soc/qcom/ipq806x.c
@@ -0,0 +1,221 @@
+/*
+ * Copyright (c) 2010-2011,2013-2014 The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <sound/soc.h>
+
+#define DRV_NAME	"ipq806x-asoc-snd"
+#define DRV_VERSION	"1.0"
+
+struct ipq806x_asoc_mach_data {
+	struct clk *ahbix_clk;
+	struct gpio_desc *dac_desc;
+};
+
+static struct snd_soc_dai_link ipq_snd_dai[] = {
+	/* Front end DAI Links */
+	{
+		.name		= "IPQ806x Media1",
+		.stream_name	= "MultiMedia1",
+		.cpu_dai_name	= "lpass-cpu-dai",
+		.platform_name	= "lpass-pcm-mi2s",
+		.codec_dai_name	= "snd-soc-dummy-dai",
+		.codec_name	= "snd-soc-dummy",
+	},
+};
+
+
+static int ipq806x_populate_dai_link_component_of_node(
+		struct snd_soc_card *card)
+{
+	int i, index;
+	int ret = 0;
+	struct device *cdev = card->dev;
+	struct snd_soc_dai_link *dai_link = card->dai_link;
+	struct device_node *np;
+
+	if (!cdev) {
+		pr_err("%s: Sound card device memory NULL\n", __func__);
+		return -ENODEV;
+	}
+
+	for (i = 0; i < card->num_links; i++) {
+		if (dai_link[i].platform_of_node && dai_link[i].cpu_of_node)
+			continue;
+
+		/* populate platform_of_node for snd card dai links */
+		if (dai_link[i].platform_name &&
+				!dai_link[i].platform_of_node) {
+			index = of_property_match_string(cdev->of_node,
+					"asoc-platform-names",
+					dai_link[i].platform_name);
+			if (index < 0) {
+				pr_err("%s: No match found for platform name: %s\n",
+						__func__,
+						dai_link[i].platform_name);
+				ret = index;
+				goto err;
+			}
+			np = of_parse_phandle(cdev->of_node, "asoc-platform",
+					index);
+			if (!np) {
+				pr_err("%s: retrieving phandle for platform %s, index %d failed\n",
+						__func__,
+						dai_link[i].platform_name,
+						index);
+				ret = -ENODEV;
+				goto err;
+			}
+			dai_link[i].platform_of_node = np;
+			dai_link[i].platform_name = NULL;
+		}
+
+		/* populate cpu_of_node for snd card dai links */
+		if (dai_link[i].cpu_dai_name && !dai_link[i].cpu_of_node) {
+			index = of_property_match_string(cdev->of_node,
+					"asoc-cpu-names",
+					dai_link[i].cpu_dai_name);
+			if (index >= 0) {
+				np = of_parse_phandle(cdev->of_node,
+						"asoc-cpu", index);
+				if (!np) {
+					pr_err("%s: retrieving phandle for cpu dai %s failed\n",
+						__func__,
+						dai_link[i].cpu_dai_name);
+					ret = -ENODEV;
+					goto err;
+				}
+				dai_link[i].cpu_of_node = np;
+				dai_link[i].cpu_dai_name = NULL;
+			}
+		}
+	}
+
+err:
+	return ret;
+}
+
+static struct snd_soc_card snd_soc_card_ipq = {
+	.name = DRV_NAME,
+};
+
+static int ipq806x_asoc_machine_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &snd_soc_card_ipq;
+	struct ipq806x_asoc_mach_data *pdata;
+	int ret;
+
+	pdata = devm_kzalloc(&pdev->dev,
+			sizeof(struct ipq806x_asoc_mach_data), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	card->dev = &pdev->dev;
+	platform_set_drvdata(pdev, card);
+	snd_soc_card_set_drvdata(card, pdata);
+
+	ret = snd_soc_of_parse_card_name(card, "qcom,model");
+	if (ret) {
+		dev_err(&pdev->dev, "parse card name failed, err:%d\n",
+				ret);
+		goto err;
+	}
+	card->dai_link	= ipq_snd_dai;
+	card->num_links	= ARRAY_SIZE(ipq_snd_dai);
+
+	ret = ipq806x_populate_dai_link_component_of_node(card);
+	if (ret) {
+		ret = -EPROBE_DEFER;
+		goto err;
+	}
+
+	pdata->dac_desc = devm_gpiod_get(&pdev->dev, "dac");
+	if (IS_ERR(pdata->dac_desc)) {
+		pr_err("unable to get dac-gpio\n");
+		ret = PTR_ERR(pdata->dac_desc);
+		goto err;
+	}
+	gpiod_direction_output(pdata->dac_desc, 0);
+	gpiod_set_value(pdata->dac_desc, 1);
+
+	pdata->ahbix_clk = devm_clk_get(&pdev->dev, "ahbix_clk");
+	if (IS_ERR(pdata->ahbix_clk)) {
+		dev_err(&pdev->dev, "%s: Error in getting ahbix_clk\n",
+				__func__);
+		ret = PTR_ERR(pdata->ahbix_clk);
+		goto err;
+	}
+
+	clk_set_rate(pdata->ahbix_clk, 131072);
+	ret = clk_prepare_enable(pdata->ahbix_clk);
+	if (IS_ERR_VALUE(ret)) {
+		dev_err(&pdev->dev, "%s: Error in enabling ahbix_clk\n",
+				__func__);
+		goto err;
+	}
+
+	ret = snd_soc_register_card(card);
+	if (ret == -EPROBE_DEFER) {
+		goto err_clock;
+	} else if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
+				ret);
+		goto err_clock;
+	}
+
+	return 0;
+
+err_clock:
+	clk_disable_unprepare(pdata->ahbix_clk);
+
+err:
+	return ret;
+}
+
+static int ipq806x_asoc_machine_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct ipq806x_asoc_mach_data *pdata = snd_soc_card_get_drvdata(card);
+
+	clk_disable_unprepare(pdata->ahbix_clk);
+
+	snd_soc_unregister_card(card);
+
+	return 0;
+}
+
+static const struct of_device_id ipq806x_asoc_machine_of_match[]  = {
+	{ .compatible = "qcom,ipq806x-snd-card", },
+	{},
+};
+
+static struct platform_driver ipq806x_asoc_machine_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+		.of_match_table = ipq806x_asoc_machine_of_match,
+	},
+	.probe = ipq806x_asoc_machine_probe,
+	.remove = ipq806x_asoc_machine_remove,
+};
+module_platform_driver(ipq806x_asoc_machine_driver);
+
+MODULE_DESCRIPTION("ALSA SoC IPQ806x Machine Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_DEVICE_TABLE(of, ipq806x_asoc_machine_of_match);
+MODULE_VERSION(DRV_VERSION);
-- 
1.8.2.1
