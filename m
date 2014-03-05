From: RongJun Ying <rjying@gmail.com>
Subject: [PATCH v5 7/7] ASoC: sirf: Add bt-sco card
Date: Wed,  5 Mar 2014 10:36:27 +0800
Message-ID: <1393986987-20505-8-git-send-email-rongjun.ying@csr.com>
References: <1393986987-20505-1-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CBA8265897
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 03:38:00 +0100 (CET)
Received: by mail-pa0-f53.google.com with SMTP id ld10so429810pab.12
 for <alsa-devel@alsa-project.org>; Tue, 04 Mar 2014 18:37:59 -0800 (PST)
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

This connects platform DAI, USP(DSP mode) CPU DAI and
bt-sco Codec DAI together and works as a mach driver.

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
---
 .../devicetree/bindings/sound/sirf-bt-sco.txt      |   18 ++++
 sound/soc/sirf/Kconfig                             |   10 +-
 sound/soc/sirf/Makefile                            |    2 +
 sound/soc/sirf/sirf-bt-sco.c                       |   99 ++++++++++++++++++++
 4 files changed, 125 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/sirf-bt-sco.txt
 create mode 100644 sound/soc/sirf/sirf-bt-sco.c

diff --git a/Documentation/devicetree/bindings/sound/sirf-bt-sco.txt b/Documentation/devicetree/bindings/sound/sirf-bt-sco.txt
new file mode 100644
index 0000000..e51de20
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sirf-bt-sco.txt
@@ -0,0 +1,18 @@
+* SiRF atlas6/prima2 and bt-sco based audio setups
+
+Required properties:
+- compatible: "sirf,sirf-bt-sco"
+- sirf,usp-controller: The phandle of the SiRF usp controller.
+
+Optional properties:
+- bt-sco-master: The phandle of who is master, if set,
+  the codec is master, Otherwiss, the soc is master.
+
+Example:
+
+sirf-bt-sco {
+	compatible = "sirf,sirf-bt-sco";
+	sirf,usp-controller = <&usp0>;
+	bt-sco-master;
+};
+
diff --git a/sound/soc/sirf/Kconfig b/sound/soc/sirf/Kconfig
index f54029c..fd55572 100644
--- a/sound/soc/sirf/Kconfig
+++ b/sound/soc/sirf/Kconfig
@@ -13,6 +13,12 @@ config SND_SOC_SIRF_AUDIO_PORT
 	select REGMAP_MMIO
 	tristate
 
+config SND_SOC_SIRF_BT_SCO
+	tristate "SoC Audio support for BT SCO"
+	depends on SND_SOC_SIRF
+	select SND_SOC_BT_SCO
+	select SND_SOC_SIRF_USP
+
 config SND_SOC_SIRF_I2S
 	select REGMAP_MMIO
 	tristate
@@ -23,10 +29,6 @@ config SND_SOC_SIRF_HDMI
 	select SND_SOC_SIRF_I2S
 	select SND_SOC_HDMI_CODEC
 
-config SND_SOC_SIRF_I2S
-	select REGMAP_MMIO
-	tristate
-
 config SND_SOC_SIRF_USP
 	select REGMAP_MMIO
 	tristate
diff --git a/sound/soc/sirf/Makefile b/sound/soc/sirf/Makefile
index 2b68632..7b5a9f5 100644
--- a/sound/soc/sirf/Makefile
+++ b/sound/soc/sirf/Makefile
@@ -1,11 +1,13 @@
 snd-soc-sirf-audio-objs := sirf-audio.o
 snd-soc-sirf-audio-port-objs := sirf-audio-port.o
+snd-soc-sirf-bt-sco-objs := sirf-bt-sco.o
 snd-soc-sirf-hdmi-objs := sirf-hdmi.o
 snd-soc-sirf-i2s-objs := sirf-i2s.o
 snd-soc-sirf-usp-objs := sirf-usp.o
 
 obj-$(CONFIG_SND_SOC_SIRF_AUDIO) += snd-soc-sirf-audio.o
 obj-$(CONFIG_SND_SOC_SIRF_AUDIO_PORT) += snd-soc-sirf-audio-port.o
+obj-$(CONFIG_SND_SOC_SIRF_BT_SCO) += snd-soc-sirf-bt-sco.o
 obj-$(CONFIG_SND_SOC_SIRF_HDMI) += snd-soc-sirf-hdmi.o
 obj-$(CONFIG_SND_SOC_SIRF_I2S) += snd-soc-sirf-i2s.o
 obj-$(CONFIG_SND_SOC_SIRF_USP) += snd-soc-sirf-usp.o
diff --git a/sound/soc/sirf/sirf-bt-sco.c b/sound/soc/sirf/sirf-bt-sco.c
new file mode 100644
index 0000000..e01b280
--- /dev/null
+++ b/sound/soc/sirf/sirf-bt-sco.c
@@ -0,0 +1,99 @@
+/*
+ * SiRF bt sco ALSA SoC Audio board driver
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include <sound/soc.h>
+
+static int sirf_bt_sco_hw_params(struct snd_pcm_substream *substream,
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
+	/* Set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, fmt);
+	if (ret < 0) {
+		dev_err(card->dev, "can't set cpu DAI configuration\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops sirf_bt_sco_ops = {
+	.hw_params = sirf_bt_sco_hw_params,
+};
+
+/* Digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link sirf_bt_sco_dai_links[] = {
+	{
+		.name = "SiRF BT SCO",
+		.stream_name = "SiRF BT_SCO",
+		.codec_dai_name = "bt-sco-pcm",
+		.codec_name = "bt-sco",
+		.ops = &sirf_bt_sco_ops,
+	},
+};
+
+static struct snd_soc_card snd_soc_sirf_bt_sco_card = {
+	.name = "SiRF BT SCO",
+	.owner = THIS_MODULE,
+	.dai_link = sirf_bt_sco_dai_links,
+	.num_links = ARRAY_SIZE(sirf_bt_sco_dai_links),
+};
+
+static int sirf_bt_sco_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &snd_soc_sirf_bt_sco_card;
+	int ret;
+
+	sirf_bt_sco_dai_links[0].cpu_of_node =
+		of_parse_phandle(pdev->dev.of_node, "sirf,usp-controller", 0);
+	sirf_bt_sco_dai_links[0].platform_of_node =
+		of_parse_phandle(pdev->dev.of_node, "sirf,usp-controller", 0);
+	if (of_property_read_bool(pdev->dev.of_node, "bt-sco-master"))
+		sirf_bt_sco_dai_links[0].dai_fmt = SND_SOC_DAIFMT_CBM_CFM;
+	else
+		sirf_bt_sco_dai_links[0].dai_fmt = SND_SOC_DAIFMT_CBS_CFS;
+	card->dev = &pdev->dev;
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret)
+		dev_err(&pdev->dev, "snd_soc_register_card() failed:%d\n", ret);
+
+	return ret;
+}
+
+static const struct of_device_id sirf_bt_sco_of_match[] = {
+	{ .compatible = "sirf,sirf-bt-sco", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sirf_bt_sco_of_match);
+
+static struct platform_driver sirf_bt_sco_driver = {
+	.driver = {
+		.name = "sirf-bt-sco",
+		.owner = THIS_MODULE,
+		.pm = &snd_soc_pm_ops,
+		.of_match_table = sirf_bt_sco_of_match,
+	},
+	.probe = sirf_bt_sco_probe,
+};
+
+module_platform_driver(sirf_bt_sco_driver);
+
+MODULE_DESCRIPTION("SIRF BT SCO ALSA SoC Audio board driver");
+MODULE_AUTHOR("RongJun Ying <Rongjun.Ying@csr.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.7.5.4
