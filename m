From: RongJun Ying <rjying@gmail.com>
Subject: [PATCH 1/2] ASoC: sirf: Add sirf audio hub driver for
	sharing same register address space
Date: Thu, 13 Mar 2014 18:38:30 +0800
Message-ID: <1394707111-9539-2-git-send-email-rongjun.ying@csr.com>
References: <1394707111-9539-1-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f180.google.com (mail-pd0-f180.google.com
 [209.85.192.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F9C726517A
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 11:39:40 +0100 (CET)
Received: by mail-pd0-f180.google.com with SMTP id v10so895600pde.25
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 03:39:40 -0700 (PDT)
In-Reply-To: <1394707111-9539-1-git-send-email-rongjun.ying@csr.com>
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

The SiRF audio modules such as I2S, internal audio codec and audio port are sharing
same register address space. This driver create regmap and register all child audio device.
The child audio drivers can get regmap form its' parent driver data.

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
---
 sound/soc/codecs/sirf-audio-codec.c |   32 +++--------------
 sound/soc/sirf/Kconfig              |    5 +++
 sound/soc/sirf/Makefile             |    2 +
 sound/soc/sirf/sirf-audio-hub.c     |   66 +++++++++++++++++++++++++++++++++++
 sound/soc/sirf/sirf-audio-port.c    |   26 +-------------
 5 files changed, 79 insertions(+), 52 deletions(-)
 create mode 100644 sound/soc/sirf/sirf-audio-hub.c

diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
index 90e3a22..d04e202 100644
--- a/sound/soc/codecs/sirf-audio-codec.c
+++ b/sound/soc/codecs/sirf-audio-codec.c
@@ -283,9 +283,10 @@ static int sirf_audio_codec_trigger(struct snd_pcm_substream *substream,
 		int cmd,
 		struct snd_soc_dai *dai)
 {
-	int playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	struct snd_soc_codec *codec = dai->codec;
 	u32 val = 0;
+	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
+		return 0;
 
 	/*
 	 * This is a workaround, When stop playback,
@@ -299,15 +300,13 @@ static int sirf_audio_codec_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (playback)
-			val = IC_HSLEN | IC_HSREN;
+		val = IC_HSLEN | IC_HSREN;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	if (playback)
-		snd_soc_update_bits(codec, AUDIO_IC_CODEC_CTRL0,
+	snd_soc_update_bits(codec, AUDIO_IC_CODEC_CTRL0,
 			IC_HSLEN | IC_HSREN, val);
 	return 0;
 }
@@ -397,23 +396,10 @@ static const struct of_device_id sirf_audio_codec_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sirf_audio_codec_of_match);
 
-static const struct regmap_config sirf_audio_codec_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = AUDIO_IC_CODEC_CTRL3,
-	.cache_type = REGCACHE_NONE,
-};
-
 static int sirf_audio_codec_driver_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct sirf_audio_codec *sirf_audio_codec;
-	void __iomem *base;
-	struct resource *mem_res;
-	const struct of_device_id *match;
-
-	match = of_match_node(sirf_audio_codec_of_match, pdev->dev.of_node);
 
 	sirf_audio_codec = devm_kzalloc(&pdev->dev,
 		sizeof(struct sirf_audio_codec), GFP_KERNEL);
@@ -422,15 +408,7 @@ static int sirf_audio_codec_driver_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sirf_audio_codec);
 
-	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, mem_res);
-	if (base == NULL)
-		return -ENOMEM;
-
-	sirf_audio_codec->regmap = devm_regmap_init_mmio(&pdev->dev, base,
-					    &sirf_audio_codec_regmap_config);
-	if (IS_ERR(sirf_audio_codec->regmap))
-		return PTR_ERR(sirf_audio_codec->regmap);
+	sirf_audio_codec->regmap = dev_get_drvdata(pdev->dev.parent);
 
 	sirf_audio_codec->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(sirf_audio_codec->clk)) {
diff --git a/sound/soc/sirf/Kconfig b/sound/soc/sirf/Kconfig
index 89e8942..723641c 100644
--- a/sound/soc/sirf/Kconfig
+++ b/sound/soc/sirf/Kconfig
@@ -8,6 +8,11 @@ config SND_SOC_SIRF_AUDIO
 	depends on SND_SOC_SIRF
 	select SND_SOC_SIRF_AUDIO_CODEC
 	select SND_SOC_SIRF_AUDIO_PORT
+	select SND_SOC_SIRF_AUDIO_HUB
+
+config SND_SOC_SIRF_AUDIO_HUB
+	depends on SND_SOC_SIRF
+	tristate
 
 config SND_SOC_SIRF_AUDIO_PORT
 	select REGMAP_MMIO
diff --git a/sound/soc/sirf/Makefile b/sound/soc/sirf/Makefile
index 913b932..74927e8 100644
--- a/sound/soc/sirf/Makefile
+++ b/sound/soc/sirf/Makefile
@@ -1,5 +1,7 @@
 snd-soc-sirf-audio-objs := sirf-audio.o
+snd-soc-sirf-audio-hub-objs := sirf-audio-hub.o
 snd-soc-sirf-audio-port-objs := sirf-audio-port.o
 
 obj-$(CONFIG_SND_SOC_SIRF_AUDIO) += snd-soc-sirf-audio.o
+obj-$(CONFIG_SND_SOC_SIRF_AUDIO_HUB) += snd-soc-sirf-audio-hub.o
 obj-$(CONFIG_SND_SOC_SIRF_AUDIO_PORT) += snd-soc-sirf-audio-port.o
diff --git a/sound/soc/sirf/sirf-audio-hub.c b/sound/soc/sirf/sirf-audio-hub.c
new file mode 100644
index 0000000..d30ef78
--- /dev/null
+++ b/sound/soc/sirf/sirf-audio-hub.c
@@ -0,0 +1,66 @@
+/*
+ * sirf-audio-hub.c - SiRF Audio hub driver purpose is sharing regmap.
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+/* This regmap is shared all child audio drivers */
+struct regmap *regmap;
+
+static const struct regmap_config sirf_audio_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.cache_type = REGCACHE_NONE,
+};
+
+static int sirf_audio_probe(struct platform_device *pdev)
+{
+	struct resource *mem_res;
+	void __iomem *base;
+
+	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, mem_res);
+	if (base == NULL)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_mmio(&pdev->dev, base,
+			&sirf_audio_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	platform_set_drvdata(pdev, regmap);
+
+	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
+}
+
+static const struct of_device_id sirf_audio_of_match[] = {
+	{ .compatible = "sirf,audio-hub", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sirf_audio_of_match);
+
+static struct platform_driver sirf_audio_driver = {
+	.driver = {
+		.name = "sirf-audio-hub",
+		.owner = THIS_MODULE,
+		.of_match_table = sirf_audio_of_match,
+	},
+	.probe = sirf_audio_probe,
+};
+
+module_platform_driver(sirf_audio_driver);
+
+MODULE_DESCRIPTION("SiRF Audio hub driver");
+MODULE_AUTHOR("RongJun Ying <Rongjun.Ying@csr.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/sirf/sirf-audio-port.c b/sound/soc/sirf/sirf-audio-port.c
index b04a53f..cda4cb4 100644
--- a/sound/soc/sirf/sirf-audio-port.c
+++ b/sound/soc/sirf/sirf-audio-port.c
@@ -127,41 +127,17 @@ static const struct snd_soc_component_driver sirf_audio_port_component = {
 	.name       = "sirf-audio-port",
 };
 
-static const struct regmap_config sirf_audio_port_regmap_config = {
-	.reg_bits = 32,
-	.reg_stride = 4,
-	.val_bits = 32,
-	.max_register = AUDIO_PORT_IC_RXFIFO_INT_MSK,
-	.cache_type = REGCACHE_NONE,
-};
-
 static int sirf_audio_port_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct sirf_audio_port *port;
-	void __iomem *base;
-	struct resource *mem_res;
 
 	port = devm_kzalloc(&pdev->dev,
 			sizeof(struct sirf_audio_port), GFP_KERNEL);
 	if (!port)
 		return -ENOMEM;
 
-	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem_res) {
-		dev_err(&pdev->dev, "no mem resource?\n");
-		return -ENODEV;
-	}
-
-	base = devm_ioremap(&pdev->dev, mem_res->start,
-			resource_size(mem_res));
-	if (base == NULL)
-		return -ENOMEM;
-
-	port->regmap = devm_regmap_init_mmio(&pdev->dev, base,
-					    &sirf_audio_port_regmap_config);
-	if (IS_ERR(port->regmap))
-		return PTR_ERR(port->regmap);
+	port->regmap = dev_get_drvdata(pdev->dev.parent);
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
 			&sirf_audio_port_component, &sirf_audio_port_dai, 1);
-- 
1.7.5.4
