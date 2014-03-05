From: RongJun Ying <rjying@gmail.com>
Subject: [PATCH v5 5/7] ASoC: sirf: Add hdmi card
Date: Wed,  5 Mar 2014 10:36:25 +0800
Message-ID: <1393986987-20505-6-git-send-email-rongjun.ying@csr.com>
References: <1393986987-20505-1-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f53.google.com (mail-pb0-f53.google.com
 [209.85.160.53])
 by alsa0.perex.cz (Postfix) with ESMTP id B3C1A265874
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 03:37:41 +0100 (CET)
Received: by mail-pb0-f53.google.com with SMTP id rp16so412136pbb.40
 for <alsa-devel@alsa-project.org>; Tue, 04 Mar 2014 18:37:40 -0800 (PST)
In-Reply-To: <1393986987-20505-1-git-send-email-rongjun.ying@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, rjying@gmail.com
Cc: Takashi Iwai <tiwai@suse.de>, Rongjun Ying <rongjun.ying@csr.com>, alsa-devel@alsa-project.org, workgroup.linux@csr.com
List-Id: alsa-devel@alsa-project.org

From: Rongjun Ying <rongjun.ying@csr.com>

This connects platform DAI, hdmi audio  codec DAI  and
SiRF I2S DAI together and works as a mach driver.

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
---
 .../devicetree/bindings/sound/sirf-hdmi.txt        |   15 +++
 sound/soc/sirf/Kconfig                             |    6 +
 sound/soc/sirf/Makefile                            |    2 +
 sound/soc/sirf/sirf-hdmi.c                         |   98 ++++++++++++++++++++
 4 files changed, 121 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-hdmi.txt
 create mode 100644 sound/soc/sirf/sirf-hdmi.c

diff --git a/Documentation/devicetree/bindings/sound/sirf-hdmi.txt b/Documentation/devicetree/bindings/sound/sirf-hdmi.txt
new file mode 100644
index 0000000..3b6eb2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sirf-hdmi.txt
@@ -0,0 +1,15 @@
+* SiRF atlas6/prima2 hdmi audio codec based audio setups
+
+Required properties:
+- compatible: "sirf,sirf-hdmi"
+- sirf,i2s-controller: The phandle of the SiRF I2S controller.
+- sirf,hdmi-audio-codec: The phandle of the hdmi audio codec.
+
+Example:
+
+sirf-hdmi {
+	compatible = "sirf,hdmi-card";
+	sirf,i2s-controller = <&i2s>;
+	sirf,hdmi-audio-codec = <&hdmi_audio>;
+};
+
diff --git a/sound/soc/sirf/Kconfig b/sound/soc/sirf/Kconfig
index e0b7157..66ed994 100644
--- a/sound/soc/sirf/Kconfig
+++ b/sound/soc/sirf/Kconfig
@@ -13,6 +13,12 @@ config SND_SOC_SIRF_AUDIO_PORT
 	select REGMAP_MMIO
 	tristate
 
+config SND_SOC_SIRF_HDMI
+	tristate "SoC Audio support for SiRF HDMI"
+	depends on SND_SOC_SIRF
+	select SND_SOC_SIRF_I2S
+	select SND_SOC_HDMI_CODEC
+
 config SND_SOC_SIRF_I2S
 	select REGMAP_MMIO
 	tristate
diff --git a/sound/soc/sirf/Makefile b/sound/soc/sirf/Makefile
index d06a39e..c961307 100644
--- a/sound/soc/sirf/Makefile
+++ b/sound/soc/sirf/Makefile
@@ -1,7 +1,9 @@
 snd-soc-sirf-audio-objs := sirf-audio.o
 snd-soc-sirf-audio-port-objs := sirf-audio-port.o
+snd-soc-sirf-hdmi-objs := sirf-hdmi.o
 snd-soc-sirf-i2s-objs := sirf-i2s.o
 
 obj-$(CONFIG_SND_SOC_SIRF_AUDIO) += snd-soc-sirf-audio.o
 obj-$(CONFIG_SND_SOC_SIRF_AUDIO_PORT) += snd-soc-sirf-audio-port.o
+obj-$(CONFIG_SND_SOC_SIRF_HDMI) += snd-soc-sirf-hdmi.o
 obj-$(CONFIG_SND_SOC_SIRF_I2S) += snd-soc-sirf-i2s.o
diff --git a/sound/soc/sirf/sirf-hdmi.c b/sound/soc/sirf/sirf-hdmi.c
new file mode 100644
index 0000000..a581ec4
--- /dev/null
+++ b/sound/soc/sirf/sirf-hdmi.c
@@ -0,0 +1,98 @@
+/*
+ * SIRF HDMI ALSA SoC Audio board driver
+ *
+ * Copyright (c) 2013 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include <sound/soc.h>
+
+static int sirf_hdmi_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_card *card = codec->card;
+	unsigned int fmt;
+	int ret;
+
+	fmt = card->dai_link[0].dai_fmt;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+	if (ret < 0) {
+		dev_err(card->dev, "can't set cpu DAI configuration\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops sirf_hdmi_ops = {
+	.hw_params = sirf_hdmi_hw_params,
+};
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link sirf_hdmi_dai_links[] = {
+	{
+		.name = "SiRF HDMI",
+		.stream_name = "SiRF HDMI",
+		.codec_dai_name = "hdmi-hifi",
+		.ops = &sirf_hdmi_ops,
+	},
+};
+
+static struct snd_soc_card snd_soc_sirf_hdmi_card = {
+	.name = "SiRF HDMI",
+	.owner = THIS_MODULE,
+	.dai_link = sirf_hdmi_dai_links,
+	.num_links = ARRAY_SIZE(sirf_hdmi_dai_links),
+};
+
+static int sirf_hdmi_card_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &snd_soc_sirf_hdmi_card;
+	int ret;
+	sirf_hdmi_dai_links[0].cpu_of_node =
+		of_parse_phandle(pdev->dev.of_node, "sirf,i2s-controller", 0);
+	sirf_hdmi_dai_links[0].platform_of_node =
+		of_parse_phandle(pdev->dev.of_node, "sirf,i2s-controller", 0);
+	sirf_hdmi_dai_links[0].codec_of_node =
+		of_parse_phandle(pdev->dev.of_node, "sirf,hdmi-audio-codec", 0);
+
+	sirf_hdmi_dai_links[0].dai_fmt = SND_SOC_DAIFMT_CBM_CFM |
+		SND_SOC_DAIFMT_I2S;
+
+	card->dev = &pdev->dev;
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret)
+		dev_err(&pdev->dev, "snd_soc_register_card() failed:%d\n", ret);
+
+	return ret;
+}
+
+static const struct of_device_id sirf_hdmi_card_of_match[] = {
+	{ .compatible = "sirf,hdmi-card", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sirf_hdmi_card_of_match);
+
+static struct platform_driver sirf_hdmi_card_driver = {
+	.driver = {
+		.name = "sirf-hdmi-card",
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+		.of_match_table = sirf_hdmi_card_of_match,
+	},
+	.probe = sirf_hdmi_card_probe,
+};
+
+module_platform_driver(sirf_hdmi_card_driver);
+
+MODULE_DESCRIPTION("SIRF HDMI ALSA SoC Audio board driver");
+MODULE_AUTHOR("RongJun Ying <Rongjun.Ying@csr.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.7.5.4
