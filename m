From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 13/15] ASoC: multi-component - Marvell Kirkwood
	Platform
Date: Sun, 27 Jun 2010 12:52:12 +0100
Message-ID: <1277639534-5104-14-git-send-email-lrg@slimlogic.co.uk>
References: <1277639534-5104-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 29E051038CB
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 13:52:52 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 23so919297wyf.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Jun 2010 04:52:52 -0700 (PDT)
In-Reply-To: <1277639534-5104-1-git-send-email-lrg@slimlogic.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Update the Marvell Kirkwood platform and machines to new multi-component model.

This patch changes the machine drivers for multi-component as follows :-

 o Removed socdev
 o Each DAI link entry now contains platform and codec fields.
 o DAI link init() now passed snd_soc_pcm_runtime instread of snd_soc_codec.

This patch also changes the DAI and platform DAM drivers as follows :-

 o Each platform DAI and platform DMA driver is a kernel device and can
   have platform data.
 o DAI and Platform DMA drivers have private data accessors.

Other notable changes required for multi-component support:-

 o Add platform devices for PCM.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 arch/arm/mach-kirkwood/common.c      |    6 +++
 sound/soc/kirkwood/kirkwood-dma.c    |   61 +++++++++++++++++++++++----------
 sound/soc/kirkwood/kirkwood-dma.h    |    2 +-
 sound/soc/kirkwood/kirkwood-i2s.c    |   49 ++++++++++++++++-----------
 sound/soc/kirkwood/kirkwood-i2s.h    |    2 +-
 sound/soc/kirkwood/kirkwood-openrd.c |   20 ++++-------
 6 files changed, 87 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index e1f3efe..0769013 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -896,10 +896,16 @@ static struct platform_device kirkwood_i2s_device = {
 	},
 };
 
+static struct platform_device kirkwood_pcm_device = {
+	.name		= "kirkwood-pcm",
+	.id		= -1,
+};
+
 void __init kirkwood_audio_init(void)
 {
 	kirkwood_clk_ctrl |= CGC_AUDIO;
 	platform_device_register(&kirkwood_i2s_device);
+	platform_device_register(&kirkwood_pcm_device);
 }
 
 /*****************************************************************************
diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index a30205b..f902716 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -123,9 +123,10 @@ static int kirkwood_dma_open(struct snd_pcm_substream *substream)
 	int err;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct snd_soc_dai *cpu_dai = soc_runtime->dai->cpu_dai;
+	struct snd_soc_platform *platform = soc_runtime->platform;
+	struct snd_soc_dai *cpu_dai = soc_runtime->cpu_dai;
 	struct kirkwood_dma_data *priv;
-	struct kirkwood_dma_priv *prdata = cpu_dai->private_data;
+	struct kirkwood_dma_priv *prdata = snd_soc_platform_get_drvdata(platform);
 	unsigned long addr;
 
 	priv = snd_soc_dai_get_dma_data(cpu_dai, substream);
@@ -151,7 +152,7 @@ static int kirkwood_dma_open(struct snd_pcm_substream *substream)
 	if (err < 0)
 		return err;
 
-	if (soc_runtime->dai->cpu_dai->private_data == NULL) {
+	if (prdata == NULL) {
 		prdata = kzalloc(sizeof(struct kirkwood_dma_priv), GFP_KERNEL);
 		if (prdata == NULL)
 			return -ENOMEM;
@@ -165,7 +166,7 @@ static int kirkwood_dma_open(struct snd_pcm_substream *substream)
 			return -EBUSY;
 		}
 
-		soc_runtime->dai->cpu_dai->private_data = prdata;
+		snd_soc_platform_set_drvdata(platform, prdata);
 
 		/*
 		 * Enable Error interrupts. We're only ack'ing them but
@@ -191,8 +192,9 @@ static int kirkwood_dma_open(struct snd_pcm_substream *substream)
 static int kirkwood_dma_close(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct snd_soc_dai *cpu_dai = soc_runtime->dai->cpu_dai;
-	struct kirkwood_dma_priv *prdata = cpu_dai->private_data;
+	struct snd_soc_dai *cpu_dai = soc_runtime->cpu_dai;
+	struct snd_soc_platform *platform = soc_runtime->platform;
+	struct kirkwood_dma_priv *prdata = snd_soc_platform_get_drvdata(platform);
 	struct kirkwood_dma_data *priv;
 
 	priv = snd_soc_dai_get_dma_data(cpu_dai, substream);
@@ -209,7 +211,7 @@ static int kirkwood_dma_close(struct snd_pcm_substream *substream)
 		writel(0, priv->io + KIRKWOOD_ERR_MASK);
 		free_irq(priv->irq, prdata);
 		kfree(prdata);
-		soc_runtime->dai->cpu_dai->private_data = NULL;
+		snd_soc_platform_set_drvdata(platform, NULL);
 	}
 
 	return 0;
@@ -236,7 +238,7 @@ static int kirkwood_dma_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct snd_soc_dai *cpu_dai = soc_runtime->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = soc_runtime->cpu_dai;
 	struct kirkwood_dma_data *priv;
 	unsigned long size, count;
 
@@ -265,7 +267,7 @@ static snd_pcm_uframes_t kirkwood_dma_pointer(struct snd_pcm_substream
 						*substream)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct snd_soc_dai *cpu_dai = soc_runtime->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = soc_runtime->cpu_dai;
 	struct kirkwood_dma_data *priv;
 	snd_pcm_uframes_t count;
 
@@ -320,14 +322,14 @@ static int kirkwood_dma_new(struct snd_card *card,
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = 0xffffffff;
 
-	if (dai->playback.channels_min) {
+	if (dai->driver->playback.channels_min) {
 		ret = kirkwood_dma_preallocate_dma_buffer(pcm,
 				SNDRV_PCM_STREAM_PLAYBACK);
 		if (ret)
 			return ret;
 	}
 
-	if (dai->capture.channels_min) {
+	if (dai->driver->capture.channels_min) {
 		ret = kirkwood_dma_preallocate_dma_buffer(pcm,
 				SNDRV_PCM_STREAM_CAPTURE);
 		if (ret)
@@ -357,25 +359,46 @@ static void kirkwood_dma_free_dma_buffers(struct snd_pcm *pcm)
 	}
 }
 
-struct snd_soc_platform kirkwood_soc_platform = {
+struct snd_soc_platform_driver kirkwood_soc_platform = {
 	.name		= "kirkwood-dma",
-	.pcm_ops	= &kirkwood_dma_ops,
+	.ops		= &kirkwood_dma_ops,
 	.pcm_new	= kirkwood_dma_new,
 	.pcm_free	= kirkwood_dma_free_dma_buffers,
 };
 EXPORT_SYMBOL_GPL(kirkwood_soc_platform);
 
-static int __init kirkwood_soc_platform_init(void)
+static int __devinit kirkwood_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&kirkwood_soc_platform);
+	return snd_soc_register_platform(&pdev->dev, -1, &kirkwood_soc_platform);
 }
-module_init(kirkwood_soc_platform_init);
 
-static void __exit kirkwood_soc_platform_exit(void)
+static int __devexit kirkwood_soc_platform_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&kirkwood_soc_platform);
+	snd_soc_unregister_platform(&pdev->dev, -1);
+	return 0;
+}
+
+static struct platform_driver kirkwood_pcm_driver = {
+	.driver = {
+			.name = "kirkwood-pcm",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = kirkwood_soc_platform_probe,
+	.remove = __devexit_p(kirkwood_soc_platform_remove),
+};
+
+static int __init kirkwood_pcm_init(void)
+{
+	return platform_driver_register(&kirkwood_pcm_driver);
+}
+module_init(kirkwood_pcm_init);
+
+static void __exit kirkwood_pcm_exit(void)
+{
+	platform_driver_unregister(&kirkwood_pcm_driver);
 }
-module_exit(kirkwood_soc_platform_exit);
+module_exit(kirkwood_pcm_exit);
 
 MODULE_AUTHOR("Arnaud Patard <apatard@mandriva.com>");
 MODULE_DESCRIPTION("Marvell Kirkwood Audio DMA module");
diff --git a/sound/soc/kirkwood/kirkwood-dma.h b/sound/soc/kirkwood/kirkwood-dma.h
index ba4454c..eedcd4e 100644
--- a/sound/soc/kirkwood/kirkwood-dma.h
+++ b/sound/soc/kirkwood/kirkwood-dma.h
@@ -12,6 +12,6 @@
 #ifndef _KIRKWOOD_DMA_H
 #define _KIRKWOOD_DMA_H
 
-extern struct snd_soc_platform kirkwood_soc_platform;
+extern struct snd_soc_platform_driver kirkwood_soc_platform;
 
 #endif
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 0fdc7db..8d0b750 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -33,13 +33,10 @@
 	 SNDRV_PCM_FMTBIT_S24_LE | \
 	 SNDRV_PCM_FMTBIT_S32_LE)
 
-
-struct snd_soc_dai kirkwood_i2s_dai;
-static struct kirkwood_dma_data *priv;
-
 static int kirkwood_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 		unsigned int fmt)
 {
+	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(cpu_dai);
 	unsigned long mask;
 	unsigned long value;
 
@@ -101,10 +98,20 @@ static inline void kirkwood_set_dco(void __iomem *io, unsigned long rate)
 	} while (value == 0);
 }
 
+static int kirkwood_i2s_startup(struct snd_pcm_substream *substream,
+		struct snd_soc_dai *dai)
+{
+	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
+
+	snd_soc_dai_set_dma_data(dai, substream, priv);
+	return 0;
+}
+
 static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
+	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
 	unsigned int i2s_reg, reg;
 	unsigned long i2s_value, value;
 
@@ -162,6 +169,7 @@ static int kirkwood_i2s_hw_params(struct snd_pcm_substream *substream,
 static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 				int cmd, struct snd_soc_dai *dai)
 {
+	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
 	unsigned long value;
 
 	/*
@@ -234,6 +242,7 @@ static int kirkwood_i2s_play_trigger(struct snd_pcm_substream *substream,
 static int kirkwood_i2s_rec_trigger(struct snd_pcm_substream *substream,
 				int cmd, struct snd_soc_dai *dai)
 {
+	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
 	unsigned long value;
 
 	value = readl(priv->io + KIRKWOOD_RECCTL);
@@ -312,9 +321,9 @@ static int kirkwood_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	return 0;
 }
 
-static int kirkwood_i2s_probe(struct platform_device *pdev,
-			     struct snd_soc_dai *dai)
+static int kirkwood_i2s_probe(struct snd_soc_dai *dai)
 {
+	struct kirkwood_dma_data *priv = snd_soc_dai_get_drvdata(dai);
 	unsigned long value;
 	unsigned int reg_data;
 
@@ -348,21 +357,21 @@ static int kirkwood_i2s_probe(struct platform_device *pdev,
 
 }
 
-static void kirkwood_i2s_remove(struct platform_device *pdev,
-				struct snd_soc_dai *dai)
+static int kirkwood_i2s_remove(struct snd_soc_dai *dai)
 {
+	return 0;
 }
 
 static struct snd_soc_dai_ops kirkwood_i2s_dai_ops = {
+	.startup	= kirkwood_i2s_startup,
 	.trigger	= kirkwood_i2s_trigger,
 	.hw_params      = kirkwood_i2s_hw_params,
 	.set_fmt        = kirkwood_i2s_set_fmt,
 };
 
 
-struct snd_soc_dai kirkwood_i2s_dai = {
+struct snd_soc_dai_driver kirkwood_i2s_dai = {
 	.name = DRV_NAME,
-	.id = 0,
 	.probe = kirkwood_i2s_probe,
 	.remove = kirkwood_i2s_remove,
 	.playback = {
@@ -384,6 +393,7 @@ static __devinit int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 	struct resource *mem;
 	struct kirkwood_asoc_platform_data *data =
 		pdev->dev.platform_data;
+	struct kirkwood_dma_data *priv;
 	int err;
 
 	priv = kzalloc(sizeof(struct kirkwood_dma_data), GFP_KERNEL);
@@ -392,6 +402,7 @@ static __devinit int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		err = -ENOMEM;
 		goto error;
 	}
+	dev_set_drvdata(&pdev->dev, priv);
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
@@ -430,10 +441,7 @@ static __devinit int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 	priv->dram = data->dram;
 	priv->burst = data->burst;
 
-	kirkwood_i2s_dai.capture.dma_data = priv;
-	kirkwood_i2s_dai.playback.dma_data = priv;
-
-	return snd_soc_register_dai(&kirkwood_i2s_dai);
+	return snd_soc_register_dai(&pdev->dev, pdev->id, &kirkwood_i2s_dai);
 
 err_ioremap:
 	iounmap(priv->io);
@@ -447,12 +455,13 @@ error:
 
 static __devexit int kirkwood_i2s_dev_remove(struct platform_device *pdev)
 {
-	if (priv) {
-		iounmap(priv->io);
-		release_mem_region(priv->mem->start, SZ_16K);
-		kfree(priv);
-	}
-	snd_soc_unregister_dai(&kirkwood_i2s_dai);
+	struct kirkwood_dma_data *priv = dev_get_drvdata(&pdev->dev);
+
+	snd_soc_unregister_dai(&pdev->dev, pdev->id);
+	iounmap(priv->io);
+	release_mem_region(priv->mem->start, SZ_16K);
+	kfree(priv);
+
 	return 0;
 }
 
diff --git a/sound/soc/kirkwood/kirkwood-i2s.h b/sound/soc/kirkwood/kirkwood-i2s.h
index c5595c6..1be706f 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.h
+++ b/sound/soc/kirkwood/kirkwood-i2s.h
@@ -12,6 +12,6 @@
 #ifndef _KIRKWOOD_I2S_H
 #define _KIRKWOOD_I2S_H
 
-extern struct snd_soc_dai kirkwood_i2s_dai;
+extern struct snd_soc_dai_driver kirkwood_i2s_dai;
 
 #endif
diff --git a/sound/soc/kirkwood/kirkwood-openrd.c b/sound/soc/kirkwood/kirkwood-openrd.c
index 0353d06..e7a6cd1 100644
--- a/sound/soc/kirkwood/kirkwood-openrd.c
+++ b/sound/soc/kirkwood/kirkwood-openrd.c
@@ -26,8 +26,8 @@ static int openrd_client_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret;
 	unsigned int freq, fmt;
 
@@ -66,8 +66,11 @@ static struct snd_soc_dai_link openrd_client_dai[] = {
 {
 	.name = "CS42L51",
 	.stream_name = "CS42L51 HiFi",
-	.cpu_dai = &kirkwood_i2s_dai,
-	.codec_dai = &cs42l51_dai,
+	.cpu_dai_drv = &kirkwood_i2s_dai,
+	.platform_drv = &kirkwood_soc_platform,
+	.codec_dai_drv = &cs42l51_dai,
+	.codec_drv = &soc_codec_device_cs42l51,
+	.codec_id = 0x4a,
 	.ops = &openrd_client_ops,
 },
 };
@@ -75,16 +78,10 @@ static struct snd_soc_dai_link openrd_client_dai[] = {
 
 static struct snd_soc_card openrd_client = {
 	.name = "OpenRD Client",
-	.platform = &kirkwood_soc_platform,
 	.dai_link = openrd_client_dai,
 	.num_links = ARRAY_SIZE(openrd_client_dai),
 };
 
-static struct snd_soc_device openrd_client_snd_devdata = {
-	.card = &openrd_client,
-	.codec_dev = &soc_codec_device_cs42l51,
-};
-
 static struct platform_device *openrd_client_snd_device;
 
 static int __init openrd_client_init(void)
@@ -99,8 +96,7 @@ static int __init openrd_client_init(void)
 		return -ENOMEM;
 
 	platform_set_drvdata(openrd_client_snd_device,
-			&openrd_client_snd_devdata);
-	openrd_client_snd_devdata.dev = &openrd_client_snd_device->dev;
+			&openrd_client);
 
 	ret = platform_device_add(openrd_client_snd_device);
 	if (ret) {
-- 
1.7.0.4
