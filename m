From: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [Patch v2 07/11] ASoC: ipq806x: Add machine driver for IPQ806X SOC
Date: Mon,  8 Dec 2014 14:01:09 -0800
Message-ID: <1418076073-12623-8-git-send-email-kwestfie@codeaurora.org>
References: <1418076073-12623-1-git-send-email-kwestfie@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1418076073-12623-1-git-send-email-kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Patrick Lai <plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: ALSA Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Device Tree Mailing List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, MSM Mailing List <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

Add machine driver for the IPQ806X LPASS SOC.

Signed-off-by: Kenneth Westfield <kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Acked-by: Banajit Goswami <bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 sound/soc/qcom/ipq806x.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 sound/soc/qcom/ipq806x.c

diff --git a/sound/soc/qcom/ipq806x.c b/sound/soc/qcom/ipq806x.c
new file mode 100644
index 0000000000000000000000000000000000000000..58bc64105ce6176cbe9408e5a75e4a7d7be437a1
--- /dev/null
+++ b/sound/soc/qcom/ipq806x.c
@@ -0,0 +1,127 @@
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
+#include <linux/module.h>
+#include <sound/soc.h>
+
+#define DRV_NAME	"ipq806x-machine"
+
+static struct snd_soc_dai_link ipq806x_machine_dai_link = {
+	.name		= "IPQ806x Media1",
+	.stream_name	= "MultiMedia1",
+};
+
+static int ipq806x_populate_dai_link_of_nodes(struct snd_soc_card *card)
+{
+	int ret;
+	struct device *cdev = card->dev;
+	struct snd_soc_dai_link *dai_link = card->dai_link;
+	struct device_node *np;
+
+	np = of_parse_phandle(cdev->of_node, "platform", 0);
+	if (!np) {
+		dev_err(cdev, "%s: no phandle for platform driver\n",
+				__func__);
+		return -ENODEV;
+	}
+	dai_link->platform_of_node = np;
+
+	np = of_parse_phandle(cdev->of_node, "cpu", 0);
+	if (!np) {
+		dev_err(cdev, "%s: no phandle for cpu-dai driver\n", __func__);
+		return -ENODEV;
+	}
+	dai_link->cpu_of_node = np;
+
+	np = of_parse_phandle(cdev->of_node, "codec", 0);
+	if (!np) {
+		dev_err(cdev, "%s: no phandle for codec driver\n", __func__);
+		return -ENODEV;
+	}
+	dai_link->codec_of_node = np;
+
+	ret = of_property_read_string(cdev->of_node, "codec-dai",
+			&dai_link->codec_dai_name);
+	if (ret) {
+		dev_err(cdev, "%s: no name for codec dai\n", __func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_card ipq806x_machine_soc_card = {
+	.name	= DRV_NAME,
+	.dev	= NULL,
+};
+
+static int ipq806x_machine_platform_probe(struct platform_device *pdev)
+{
+	int ret;
+	struct snd_soc_card *card = &ipq806x_machine_soc_card;
+
+	if (card->dev) {
+		dev_err(&pdev->dev, "soundcard instance already created\n");
+		return -ENODEV;
+	}
+
+	card->dev = &pdev->dev;
+	platform_set_drvdata(pdev, card);
+
+	ret = snd_soc_of_parse_card_name(card, "qcom,model");
+	if (ret) {
+		dev_err(&pdev->dev, "parse card name failed, err:%d\n", ret);
+		return ret;
+	}
+
+	card->dai_link	= &ipq806x_machine_dai_link;
+	card->num_links	= 1;
+
+	ret = ipq806x_populate_dai_link_of_nodes(card);
+	if (ret) {
+		dev_err(&pdev->dev, "could not resolve dai links, err:%d\n",
+				ret);
+		return ret;
+	}
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret == -EPROBE_DEFER) {
+		card->dev = NULL;
+		return ret;
+	} else if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id ipq806x_machine_dt_match[]  = {
+	{ .compatible = "qcom,ipq806x-snd-card", },
+	{},
+};
+
+static struct platform_driver ipq806x_machine_platform_driver = {
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = ipq806x_machine_dt_match,
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = ipq806x_machine_platform_probe,
+};
+module_platform_driver(ipq806x_machine_platform_driver);
+
+MODULE_DESCRIPTION("QCOM IPQ806X MACHINE DRIVER");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_DEVICE_TABLE(of, ipq806x_asoc_machine_of_match);
-- 
1.8.2.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
