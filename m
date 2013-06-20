From: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: [PATCH] ASoC: SPEAr: Add device tree support + SPEAr
	machine driver
Date: Thu, 20 Jun 2013 17:05:52 +0530
Message-ID: <1371728152-14641-1-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog121.obsmtp.com (eu1sys200aog121.obsmtp.com
 [207.126.144.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 39BBE2650F0
 for <alsa-devel@alsa-project.org>; Thu, 20 Jun 2013 13:35:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, rajeev-dlh.kumar@st.com
List-Id: alsa-devel@alsa-project.org

The patch adds device tree support + SPEAr machine driver

Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
---
 .../devicetree/bindings/sound/spear-evb.txt        |   20 +++
 sound/soc/spear/spear_evb.c                        |  135 ++++++++++++++++++++
 2 files changed, 155 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/spear-evb.txt
 create mode 100644 sound/soc/spear/spear_evb.c

diff --git a/Documentation/devicetree/bindings/sound/spear-evb.txt b/Documentation/devicetree/bindings/sound/spear-evb.txt
new file mode 100644
index 0000000..cb011b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/spear-evb.txt
@@ -0,0 +1,20 @@
+* SPEAr audio sta529 codec
+
+Required properties:
+- compatible: "spear,spear-evb"
+- audio-controllers: The phandle list of synopsys audio i2s controller
+- audio-codec: The phandle of the sta529 audio codec
+- codec_dai_name: DAI name for codec.
+- stream_name: stream name.
+
+Example:
+
+sound {
+        compatible = "spear,spear-evb";
+        audio-controllers = <&i2s0 &i2s1>;
+        audio-codecs = <&sta529 &sta529>;
+        codec_dai_name = "sta529-audio", "sta529-audio";
+        stream_name = "i2s-play", "i2s-cap";
+        dai_name = "i2s0-pcm", "i2s1-pcm";
+};
+
diff --git a/sound/soc/spear/spear_evb.c b/sound/soc/spear/spear_evb.c
new file mode 100644
index 0000000..6da1732
--- /dev/null
+++ b/sound/soc/spear/spear_evb.c
@@ -0,0 +1,135 @@
+/*
+ * ASoC machine driver for SPEAr evaluation boards
+ *
+ * sound/soc/spear/spear_evb.c
+ *
+ * Copyright (C) 2010 ST Microelectronics
+ * Rajeev Kumar<rajeev-dlh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/spear_dma.h>
+
+struct snd_soc_card spear_soc_card;
+
+static int spear_evb_probe(struct platform_device *pdev)
+{
+	struct snd_soc_dai_link *evb_dai;
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *spear_audio_np, *codec_np;
+	int i, nr_controllers, ret = 0;
+
+	if (!np)
+		return -EINVAL; /* no device tree */
+
+	of_property_read_u32(np, "nr_controllers", &nr_controllers);
+
+	evb_dai = devm_kzalloc(&pdev->dev,
+			(nr_controllers * sizeof(*evb_dai)), GFP_KERNEL);
+	if (!evb_dai) {
+		dev_warn(&pdev->dev, "kzalloc fail for evb_dai\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < nr_controllers ; i++) {
+		spear_audio_np = of_parse_phandle(np, "audio-controllers", i);
+		codec_np = of_parse_phandle(np, "audio-codecs", i);
+		if (!spear_audio_np || !codec_np) {
+			dev_err(&pdev->dev, "phandle missing or invalid\n");
+			return -EINVAL;
+		}
+
+		ret = of_property_read_string_index(np, "dai_names", i,
+				&evb_dai[i].name);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Cannot parse names: %d\n", ret);
+			goto err;
+		}
+
+		ret = of_property_read_string_index(np, "codec_dai_names", i,
+				&evb_dai[i].codec_dai_name);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Can't parse codec-dai-names: %d\n",
+					ret);
+			goto err;
+		}
+		ret = of_property_read_string_index(np, "stream_names", i,
+				&evb_dai[i].stream_name);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Cannot parse stream names: %d\n",
+					ret);
+			goto err;
+		}
+
+		evb_dai[i].cpu_dai_name = NULL;
+		evb_dai[i].cpu_of_node = spear_audio_np;
+		evb_dai[i].platform_of_node = np;
+		evb_dai[i].codec_name = NULL;
+		evb_dai[i].codec_of_node = codec_np;
+		if (!(strcmp(evb_dai[i].codec_dai_name, "sta529-audio")))
+			evb_dai[i].dai_fmt = SND_SOC_DAIFMT_I2S |
+				SND_SOC_DAIFMT_CBS_CFM;
+		of_node_put(spear_audio_np);
+		of_node_put(codec_np);
+	}
+
+	spear_soc_card.name = "spear-evb";
+	spear_soc_card.dai_link = evb_dai;
+	spear_soc_card.num_links = nr_controllers;
+
+	spear_soc_card.dev = &pdev->dev;
+	platform_set_drvdata(pdev, &spear_soc_card);
+
+	ret = snd_soc_register_card(&spear_soc_card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card failed: %d\n", ret);
+		goto err;
+	}
+
+	return 0;
+err:
+	return ret;
+}
+
+static int spear_evb_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *spear_soc_card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(spear_soc_card);
+
+	return 0;
+}
+
+static const struct of_device_id spear_evb_dt_ids[] = {
+	{ .compatible = "spear,spear-evb", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, spear_evb_dt_ids);
+
+static struct platform_driver spear_evb_driver = {
+	.driver = {
+		.name = "spear-evb",
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+		.of_match_table = spear_evb_dt_ids,
+	},
+	.probe = spear_evb_probe,
+	.remove = spear_evb_remove,
+};
+
+module_platform_driver(spear_evb_driver);
+
+MODULE_AUTHOR("Rajeev Kumar <rajeev-dlh.kumar@st.com>");
+MODULE_DESCRIPTION("ST SPEAr EVB ASoC driver");
+MODULE_LICENSE("GPL");
-- 
1.6.0.2
