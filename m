From: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH v2 3/4] ASoC: sunxi: Add S/PDIF machine driver.
Date: Wed, 30 Sep 2015 19:50:57 +0200
Message-ID: <1443635458-8873-4-git-send-email-codekipper@gmail.com>
References: <1443635458-8873-1-git-send-email-codekipper@gmail.com>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBC6CWCYAKGQEULJJDLY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1443635458-8873-1-git-send-email-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org, Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 sound/soc/sunxi/sunxi-machine-spdif.c | 108 ++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 sound/soc/sunxi/sunxi-machine-spdif.c

diff --git a/sound/soc/sunxi/sunxi-machine-spdif.c b/sound/soc/sunxi/sunxi-machine-spdif.c
new file mode 100644
index 0000000..2adb727
--- /dev/null
+++ b/sound/soc/sunxi/sunxi-machine-spdif.c
@@ -0,0 +1,108 @@
+/*
+ * Copyright (C) 2015 Andrea Venturi <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>
+ * From code by (C) 2013 Freescale Semiconductor, Inc.
+ * (sound/soc/fsl/imx-spdif.c)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <sound/soc.h>
+
+struct sunxi_machine_spdif_data {
+	struct snd_soc_dai_link dai;
+	struct snd_soc_card card;
+};
+
+static int sunxi_machine_spdif_audio_probe(struct platform_device *pdev)
+{
+	struct device_node *spdif_np, *np = pdev->dev.of_node;
+	struct sunxi_machine_spdif_data *data;
+	int ret = 0;
+
+	dev_dbg(&pdev->dev, "%s: Looking for spdif-controller\n", __func__);
+	spdif_np = of_parse_phandle(np, "spdif-controller", 0);
+	if (!spdif_np) {
+		dev_err(&pdev->dev, "failed to find spdif-controller\n");
+		ret = -EINVAL;
+		goto end;
+	}
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto end;
+	}
+
+	data->dai.name = "S/PDIF PCM";
+	data->dai.stream_name = "S/PDIF PCM";
+	data->dai.codec_dai_name = "snd-soc-dummy-dai";
+	data->dai.codec_name = "snd-soc-dummy";
+	data->dai.cpu_of_node = spdif_np;
+	data->dai.platform_of_node = spdif_np;
+	data->dai.playback_only = true;
+	data->dai.capture_only = true;
+
+	if (of_property_read_bool(np, "spdif-out"))
+		data->dai.capture_only = false;
+
+	if (of_property_read_bool(np, "spdif-in"))
+		data->dai.playback_only = false;
+
+	if (data->dai.playback_only && data->dai.capture_only) {
+		dev_err(&pdev->dev, "no enabled S/PDIF DAI link\n");
+		goto end;
+	}
+
+	data->card.dev = &pdev->dev;
+	data->card.dai_link = &data->dai;
+	data->card.num_links = 1;
+	data->card.owner = THIS_MODULE;
+
+	ret = snd_soc_of_parse_card_name(&data->card, "model");
+	if (ret)
+		goto end;
+
+	ret = devm_snd_soc_register_card(&pdev->dev, &data->card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card failed: %d\n", ret);
+		goto end;
+	}
+
+	platform_set_drvdata(pdev, data);
+
+end:
+	of_node_put(spdif_np);
+
+	return ret;
+}
+
+static const struct of_device_id sunxi_machine_spdif_dt_ids[] = {
+	{ .compatible = "allwinner,sunxi-audio-spdif", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sunxi_machine_spdif_dt_ids);
+
+static struct platform_driver sunxi_machine_spdif_driver = {
+	.driver = {
+		.name = "sunxi-machine-spdif",
+		.of_match_table = sunxi_machine_spdif_dt_ids,
+	},
+	.probe = sunxi_machine_spdif_audio_probe,
+};
+
+module_platform_driver(sunxi_machine_spdif_driver);
+
+MODULE_AUTHOR("Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>");
+MODULE_AUTHOR("Andrea Venturi, <be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org>");
+MODULE_DESCRIPTION("Allwinner sunxi S/PDIF machine driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
