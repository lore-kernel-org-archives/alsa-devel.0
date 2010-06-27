From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 11/15] ASoC: multi-component - Analog Devices
	Blackfin Platform
Date: Sun, 27 Jun 2010 12:52:10 +0100
Message-ID: <1277639534-5104-12-git-send-email-lrg@slimlogic.co.uk>
References: <1277639534-5104-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 198941038B0
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 13:52:48 +0200 (CEST)
Received: by mail-ww0-f51.google.com with SMTP id 13so934011wwb.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Jun 2010 04:52:48 -0700 (PDT)
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

Update the Analog Blackfin platform and machines to new multi-component model.

This patch changes the machine drivers for multi-component as follows :-

 o Removed socdev
 o Each DAI link entry now contains platform and codec fields.
 o DAI link init() now passed snd_soc_pcm_runtime instread of snd_soc_codec.

This patch also changes the DAI and platform DAM drivers as follows :-

 o Each platform DAI and platform DMA driver is a kernel device and can
   have platform data.
 o DAI and Platform DMA drivers have private data accessors.

Other notable changes required for multi-component support:-

 o bf5xx_ssm2602_setup data removed as it should be platform data.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/blackfin/bf5xx-ac97-pcm.c |   41 +++++++++++++++++++++++++--------
 sound/soc/blackfin/bf5xx-ac97-pcm.h |    2 +-
 sound/soc/blackfin/bf5xx-ac97.c     |   42 +++++++++++++++++++++++++----------
 sound/soc/blackfin/bf5xx-ac97.h     |    2 +-
 sound/soc/blackfin/bf5xx-ad1836.c   |   23 +++++++-----------
 sound/soc/blackfin/bf5xx-ad193x.c   |   23 +++++++-----------
 sound/soc/blackfin/bf5xx-ad1980.c   |   19 +++++----------
 sound/soc/blackfin/bf5xx-ad73311.c  |   21 ++++++----------
 sound/soc/blackfin/bf5xx-i2s-pcm.c  |   41 +++++++++++++++++++++++++--------
 sound/soc/blackfin/bf5xx-i2s-pcm.h  |    2 +-
 sound/soc/blackfin/bf5xx-i2s.c      |   42 +++++++++++++++++++++++++---------
 sound/soc/blackfin/bf5xx-i2s.h      |    2 +-
 sound/soc/blackfin/bf5xx-ssm2602.c  |   39 ++++++++------------------------
 sound/soc/blackfin/bf5xx-tdm-pcm.c  |   41 +++++++++++++++++++++++++--------
 sound/soc/blackfin/bf5xx-tdm-pcm.h  |    2 +-
 sound/soc/blackfin/bf5xx-tdm.c      |   14 +++++------
 sound/soc/blackfin/bf5xx-tdm.h      |    2 +-
 17 files changed, 209 insertions(+), 149 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index 5e7aacf..53d6bea 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
@@ -422,14 +422,14 @@ int bf5xx_pcm_ac97_new(struct snd_card *card, struct snd_soc_dai *dai,
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
 
-	if (dai->playback.channels_min) {
+	if (dai->driver->playback.channels_min) {
 		ret = bf5xx_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_PLAYBACK);
 		if (ret)
 			goto out;
 	}
 
-	if (dai->capture.channels_min) {
+	if (dai->driver->capture.channels_min) {
 		ret = bf5xx_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_CAPTURE);
 		if (ret)
@@ -439,25 +439,46 @@ int bf5xx_pcm_ac97_new(struct snd_card *card, struct snd_soc_dai *dai,
 	return ret;
 }
 
-struct snd_soc_platform bf5xx_ac97_soc_platform = {
+struct snd_soc_platform_driver bf5xx_ac97_soc_platform = {
 	.name		= "bf5xx-audio",
-	.pcm_ops 	= &bf5xx_pcm_ac97_ops,
+	.ops			= &bf5xx_pcm_ac97_ops,
 	.pcm_new	= bf5xx_pcm_ac97_new,
 	.pcm_free	= bf5xx_pcm_free_dma_buffers,
 };
 EXPORT_SYMBOL_GPL(bf5xx_ac97_soc_platform);
 
-static int __init bfin_ac97_init(void)
+static int __devinit bf5xx_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&bf5xx_ac97_soc_platform);
+	return snd_soc_register_platform(&pdev->dev, -1, &bf5xx_ac97_soc_platform);
 }
-module_init(bfin_ac97_init);
 
-static void __exit bfin_ac97_exit(void)
+static int __devexit bf5xx_soc_platform_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&bf5xx_ac97_soc_platform);
+	snd_soc_unregister_platform(&pdev->dev, -1);
+	return 0;
+}
+
+static struct platform_driver bf5xx_pcm_driver = {
+	.driver = {
+			.name = "bf5xx-pcm-audio",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = bf5xx_soc_platform_probe,
+	.remove = __devexit_p(bf5xx_soc_platform_remove),
+};
+
+static int __init snd_bf5xx_pcm_init(void)
+{
+	return platform_driver_register(&bf5xx_pcm_driver);
+}
+module_init(snd_bf5xx_pcm_init);
+
+static void __exit snd_bf5xx_pcm_exit(void)
+{
+	platform_driver_unregister(&bf5xx_pcm_driver);
 }
-module_exit(bfin_ac97_exit);
+module_exit(snd_bf5xx_pcm_exit);
 
 MODULE_AUTHOR("Cliff Cai");
 MODULE_DESCRIPTION("ADI Blackfin AC97 PCM DMA module");
diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.h b/sound/soc/blackfin/bf5xx-ac97-pcm.h
index 350125a..258ab44 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.h
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.h
@@ -24,6 +24,6 @@ struct bf5xx_gpio {
 };
 
 /* platform data */
-extern struct snd_soc_platform bf5xx_ac97_soc_platform;
+extern struct snd_soc_platform_driver bf5xx_ac97_soc_platform;
 
 #endif
diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
index 523b7fc..c699c6b 100644
--- a/sound/soc/blackfin/bf5xx-ac97.c
+++ b/sound/soc/blackfin/bf5xx-ac97.c
@@ -255,8 +255,7 @@ EXPORT_SYMBOL_GPL(soc_ac97_ops);
 #ifdef CONFIG_PM
 static int bf5xx_ac97_suspend(struct snd_soc_dai *dai)
 {
-	struct sport_device *sport =
-		(struct sport_device *)dai->private_data;
+	struct sport_device *sport = snd_soc_dai_get_drvdata(dai);
 
 	pr_debug("%s : sport %d\n", __func__, dai->id);
 	if (!dai->active)
@@ -271,8 +270,7 @@ static int bf5xx_ac97_suspend(struct snd_soc_dai *dai)
 static int bf5xx_ac97_resume(struct snd_soc_dai *dai)
 {
 	int ret;
-	struct sport_device *sport =
-		(struct sport_device *)dai->private_data;
+	struct sport_device *sport = snd_soc_dai_get_drvdata(dai);
 
 	pr_debug("%s : sport %d\n", __func__, dai->id);
 	if (!dai->active)
@@ -308,8 +306,7 @@ static int bf5xx_ac97_resume(struct snd_soc_dai *dai)
 #define bf5xx_ac97_resume	NULL
 #endif
 
-static int bf5xx_ac97_probe(struct platform_device *pdev,
-			    struct snd_soc_dai *dai)
+static int bf5xx_ac97_probe(struct snd_soc_dai *dai)
 {
 	int ret = 0;
 	cmd_count = (int *)get_zeroed_page(GFP_KERNEL);
@@ -381,8 +378,7 @@ peripheral_err:
 	return ret;
 }
 
-static void bf5xx_ac97_remove(struct platform_device *pdev,
-			      struct snd_soc_dai *dai)
+static int bf5xx_ac97_remove(struct snd_soc_dai *dai)
 {
 	free_page((unsigned long)cmd_count);
 	cmd_count = NULL;
@@ -390,11 +386,11 @@ static void bf5xx_ac97_remove(struct platform_device *pdev,
 #ifdef CONFIG_SND_BF5XX_HAVE_COLD_RESET
 	gpio_free(CONFIG_SND_BF5XX_RESET_GPIO_NUM);
 #endif
+	return 0;
 }
 
-struct snd_soc_dai bfin_ac97_dai = {
+struct snd_soc_dai_driver bfin_ac97_dai = {
 	.name = "bf5xx-ac97",
-	.id = 0,
 	.ac97_control = 1,
 	.probe = bf5xx_ac97_probe,
 	.remove = bf5xx_ac97_remove,
@@ -419,18 +415,40 @@ struct snd_soc_dai bfin_ac97_dai = {
 };
 EXPORT_SYMBOL_GPL(bfin_ac97_dai);
 
+static __devinit int asoc_bfin_ac97_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_dai(&pdev->dev, pdev->id, &bfin_ac97_dai);
+}
+
+static int __devexit asoc_bfin_ac97_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_dai(&pdev->dev, pdev->id);
+	return 0;
+}
+
+static struct platform_driver asoc_bfin_ac97_driver = {
+	.driver = {
+			.name = "bfin-ac97-audio",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = asoc_bfin_ac97_probe,
+	.remove = __devexit_p(asoc_bfin_ac97_remove),
+};
+
 static int __init bfin_ac97_init(void)
 {
-	return snd_soc_register_dai(&bfin_ac97_dai);
+	return platform_driver_register(&asoc_bfin_ac97_driver);
 }
 module_init(bfin_ac97_init);
 
 static void __exit bfin_ac97_exit(void)
 {
-	snd_soc_unregister_dai(&bfin_ac97_dai);
+	platform_driver_unregister(&asoc_bfin_ac97_driver);
 }
 module_exit(bfin_ac97_exit);
 
+
 MODULE_AUTHOR("Roy Huang");
 MODULE_DESCRIPTION("AC97 driver for ADI Blackfin");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/blackfin/bf5xx-ac97.h b/sound/soc/blackfin/bf5xx-ac97.h
index a1f97dd..8aa685b 100644
--- a/sound/soc/blackfin/bf5xx-ac97.h
+++ b/sound/soc/blackfin/bf5xx-ac97.h
@@ -50,7 +50,7 @@ struct ac97_frame {
 #define TAG_PCM_SR		0x0080
 #define TAG_PCM_LFE		0x0040
 
-extern struct snd_soc_dai bfin_ac97_dai;
+extern struct snd_soc_dai_driver bfin_ac97_dai;
 
 void bf5xx_pcm_to_ac97(struct ac97_frame *dst, const __u16 *src, \
 		size_t count, unsigned int chan_mask);
diff --git a/sound/soc/blackfin/bf5xx-ad1836.c b/sound/soc/blackfin/bf5xx-ad1836.c
index 0f45a3f..4a7984d 100644
--- a/sound/soc/blackfin/bf5xx-ad1836.c
+++ b/sound/soc/blackfin/bf5xx-ad1836.c
@@ -40,9 +40,9 @@ static struct snd_soc_card bf5xx_ad1836;
 static int bf5xx_ad1836_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
-	cpu_dai->private_data = sport_handle;
+	snd_soc_dai_set_drvdata(cpu_dai, sport_handle);
 	return 0;
 }
 
@@ -50,8 +50,8 @@ static int bf5xx_ad1836_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	unsigned int channel_map[] = {0, 4, 1, 5, 2, 6, 3, 7};
 	int ret = 0;
 	/* set cpu DAI configuration */
@@ -83,23 +83,19 @@ static struct snd_soc_ops bf5xx_ad1836_ops = {
 static struct snd_soc_dai_link bf5xx_ad1836_dai = {
 	.name = "ad1836",
 	.stream_name = "AD1836",
-	.cpu_dai = &bf5xx_tdm_dai,
-	.codec_dai = &ad1836_dai,
+	.cpu_dai_drv = &bf5xx_tdm_dai,
+	.codec_dai_drv = &ad1836_dai,
+	.platform_drv = &bf5xx_tdm_soc_platform,
+	.codec_drv = &soc_codec_dev_ad1836,
 	.ops = &bf5xx_ad1836_ops,
 };
 
 static struct snd_soc_card bf5xx_ad1836 = {
 	.name = "bf5xx_ad1836",
-	.platform = &bf5xx_tdm_soc_platform,
 	.dai_link = &bf5xx_ad1836_dai,
 	.num_links = 1,
 };
 
-static struct snd_soc_device bf5xx_ad1836_snd_devdata = {
-	.card = &bf5xx_ad1836,
-	.codec_dev = &soc_codec_dev_ad1836,
-};
-
 static struct platform_device *bfxx_ad1836_snd_device;
 
 static int __init bf5xx_ad1836_init(void)
@@ -110,8 +106,7 @@ static int __init bf5xx_ad1836_init(void)
 	if (!bfxx_ad1836_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(bfxx_ad1836_snd_device, &bf5xx_ad1836_snd_devdata);
-	bf5xx_ad1836_snd_devdata.dev = &bfxx_ad1836_snd_device->dev;
+	platform_set_drvdata(bfxx_ad1836_snd_device, &bf5xx_ad1836);
 	ret = platform_device_add(bfxx_ad1836_snd_device);
 
 	if (ret)
diff --git a/sound/soc/blackfin/bf5xx-ad193x.c b/sound/soc/blackfin/bf5xx-ad193x.c
index b8c9060..e49a9ec 100644
--- a/sound/soc/blackfin/bf5xx-ad193x.c
+++ b/sound/soc/blackfin/bf5xx-ad193x.c
@@ -49,9 +49,9 @@ static struct snd_soc_card bf5xx_ad193x;
 static int bf5xx_ad193x_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
-	cpu_dai->private_data = sport_handle;
+	snd_soc_dai_set_drvdata(cpu_dai, sport_handle);
 	return 0;
 }
 
@@ -59,8 +59,8 @@ static int bf5xx_ad193x_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	unsigned int channel_map[] = {0, 1, 2, 3, 4, 5, 6, 7};
 	int ret = 0;
 	/* set cpu DAI configuration */
@@ -97,23 +97,19 @@ static struct snd_soc_ops bf5xx_ad193x_ops = {
 static struct snd_soc_dai_link bf5xx_ad193x_dai = {
 	.name = "ad193x",
 	.stream_name = "AD193X",
-	.cpu_dai = &bf5xx_tdm_dai,
-	.codec_dai = &ad193x_dai,
+	.cpu_dai_drv = &bf5xx_tdm_dai,
+	.codec_dai_drv = &ad193x_dai,
+	.platform_drv = &bf5xx_tdm_soc_platform,
+	.codec_drv = &soc_codec_dev_ad193x,
 	.ops = &bf5xx_ad193x_ops,
 };
 
 static struct snd_soc_card bf5xx_ad193x = {
 	.name = "bf5xx_ad193x",
-	.platform = &bf5xx_tdm_soc_platform,
 	.dai_link = &bf5xx_ad193x_dai,
 	.num_links = 1,
 };
 
-static struct snd_soc_device bf5xx_ad193x_snd_devdata = {
-	.card = &bf5xx_ad193x,
-	.codec_dev = &soc_codec_dev_ad193x,
-};
-
 static struct platform_device *bfxx_ad193x_snd_device;
 
 static int __init bf5xx_ad193x_init(void)
@@ -124,8 +120,7 @@ static int __init bf5xx_ad193x_init(void)
 	if (!bfxx_ad193x_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(bfxx_ad193x_snd_device, &bf5xx_ad193x_snd_devdata);
-	bf5xx_ad193x_snd_devdata.dev = &bfxx_ad193x_snd_device->dev;
+	platform_set_drvdata(bfxx_ad193x_snd_device, &bf5xx_ad193x);
 	ret = platform_device_add(bfxx_ad193x_snd_device);
 
 	if (ret)
diff --git a/sound/soc/blackfin/bf5xx-ad1980.c b/sound/soc/blackfin/bf5xx-ad1980.c
index d8f5912..aeef91d 100644
--- a/sound/soc/blackfin/bf5xx-ad1980.c
+++ b/sound/soc/blackfin/bf5xx-ad1980.c
@@ -48,10 +48,10 @@ static struct snd_soc_card bf5xx_board;
 static int bf5xx_board_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
 	pr_debug("%s enter\n", __func__);
-	cpu_dai->private_data = sport_handle;
+	snd_soc_dai_set_drvdata(cpu_dai, sport_handle);
 	return 0;
 }
 
@@ -62,23 +62,19 @@ static struct snd_soc_ops bf5xx_board_ops = {
 static struct snd_soc_dai_link bf5xx_board_dai = {
 	.name = "AC97",
 	.stream_name = "AC97 HiFi",
-	.cpu_dai = &bfin_ac97_dai,
-	.codec_dai = &ad1980_dai,
+	.cpu_dai_drv = &bfin_ac97_dai,
+	.codec_dai_drv = &ad1980_dai,
+	.platform_drv = &bf5xx_ac97_soc_platform,
+	.codec_drv = &soc_codec_dev_ad1980,
 	.ops = &bf5xx_board_ops,
 };
 
 static struct snd_soc_card bf5xx_board = {
 	.name = "bf5xx-board",
-	.platform = &bf5xx_ac97_soc_platform,
 	.dai_link = &bf5xx_board_dai,
 	.num_links = 1,
 };
 
-static struct snd_soc_device bf5xx_board_snd_devdata = {
-	.card = &bf5xx_board,
-	.codec_dev = &soc_codec_dev_ad1980,
-};
-
 static struct platform_device *bf5xx_board_snd_device;
 
 static int __init bf5xx_board_init(void)
@@ -89,8 +85,7 @@ static int __init bf5xx_board_init(void)
 	if (!bf5xx_board_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(bf5xx_board_snd_device, &bf5xx_board_snd_devdata);
-	bf5xx_board_snd_devdata.dev = &bf5xx_board_snd_device->dev;
+	platform_set_drvdata(bf5xx_board_snd_device, &bf5xx_board);
 	ret = platform_device_add(bf5xx_board_snd_device);
 
 	if (ret)
diff --git a/sound/soc/blackfin/bf5xx-ad73311.c b/sound/soc/blackfin/bf5xx-ad73311.c
index 9825b71..961c641 100644
--- a/sound/soc/blackfin/bf5xx-ad73311.c
+++ b/sound/soc/blackfin/bf5xx-ad73311.c
@@ -150,10 +150,10 @@ static int bf5xx_probe(struct platform_device *pdev)
 static int bf5xx_ad73311_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
 	pr_debug("%s enter\n", __func__);
-	cpu_dai->private_data = sport_handle;
+	snd_soc_dai_set_drvdata(cpu_dai, sport_handle);
 	return 0;
 }
 
@@ -161,7 +161,7 @@ static int bf5xx_ad73311_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret = 0;
 
 	pr_debug("%s rate %d format %x\n", __func__, params_rate(params),
@@ -185,24 +185,20 @@ static struct snd_soc_ops bf5xx_ad73311_ops = {
 static struct snd_soc_dai_link bf5xx_ad73311_dai = {
 	.name = "ad73311",
 	.stream_name = "AD73311",
-	.cpu_dai = &bf5xx_i2s_dai,
-	.codec_dai = &ad73311_dai,
+	.cpu_dai_drv = &bf5xx_i2s_dai,
+	.codec_dai_drv = &ad73311_dai,
+	.platform_drv = &bf5xx_i2s_soc_platform,
+	.codec_drv = &soc_codec_dev_ad73311,
 	.ops = &bf5xx_ad73311_ops,
 };
 
 static struct snd_soc_card bf5xx_ad73311 = {
 	.name = "bf5xx_ad73311",
-	.platform = &bf5xx_i2s_soc_platform,
 	.probe = bf5xx_probe,
 	.dai_link = &bf5xx_ad73311_dai,
 	.num_links = 1,
 };
 
-static struct snd_soc_device bf5xx_ad73311_snd_devdata = {
-	.card = &bf5xx_ad73311,
-	.codec_dev = &soc_codec_dev_ad73311,
-};
-
 static struct platform_device *bf5xx_ad73311_snd_device;
 
 static int __init bf5xx_ad73311_init(void)
@@ -214,8 +210,7 @@ static int __init bf5xx_ad73311_init(void)
 	if (!bf5xx_ad73311_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(bf5xx_ad73311_snd_device, &bf5xx_ad73311_snd_devdata);
-	bf5xx_ad73311_snd_devdata.dev = &bf5xx_ad73311_snd_device->dev;
+	platform_set_drvdata(bf5xx_ad73311_snd_device, &bf5xx_ad73311);
 	ret = platform_device_add(bf5xx_ad73311_snd_device);
 
 	if (ret)
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index 1d2a1ad..2eab41f 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -257,14 +257,14 @@ int bf5xx_pcm_i2s_new(struct snd_card *card, struct snd_soc_dai *dai,
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
 
-	if (dai->playback.channels_min) {
+	if (dai->driver->playback.channels_min) {
 		ret = bf5xx_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_PLAYBACK);
 		if (ret)
 			goto out;
 	}
 
-	if (dai->capture.channels_min) {
+	if (dai->driver->capture.channels_min) {
 		ret = bf5xx_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_CAPTURE);
 		if (ret)
@@ -274,25 +274,46 @@ int bf5xx_pcm_i2s_new(struct snd_card *card, struct snd_soc_dai *dai,
 	return ret;
 }
 
-struct snd_soc_platform bf5xx_i2s_soc_platform = {
+struct snd_soc_platform_driver bf5xx_i2s_soc_platform = {
 	.name		= "bf5xx-audio",
-	.pcm_ops 	= &bf5xx_pcm_i2s_ops,
+	.ops		= &bf5xx_pcm_i2s_ops,
 	.pcm_new	= bf5xx_pcm_i2s_new,
 	.pcm_free	= bf5xx_pcm_free_dma_buffers,
 };
 EXPORT_SYMBOL_GPL(bf5xx_i2s_soc_platform);
 
-static int __init bfin_i2s_init(void)
+static int __devinit bfin_i2s_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&bf5xx_i2s_soc_platform);
+	return snd_soc_register_platform(&pdev->dev, -1, &bf5xx_i2s_soc_platform);
 }
-module_init(bfin_i2s_init);
 
-static void __exit bfin_i2s_exit(void)
+static int __devexit bfin_i2s_soc_platform_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&bf5xx_i2s_soc_platform);
+	snd_soc_unregister_platform(&pdev->dev, -1);
+	return 0;
+}
+
+static struct platform_driver bfin_i2s_pcm_driver = {
+	.driver = {
+			.name = "bfin-i2s-pcm-audio",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = bfin_i2s_soc_platform_probe,
+	.remove = __devexit_p(bfin_i2s_soc_platform_remove),
+};
+
+static int __init snd_bfin_i2s_pcm_init(void)
+{
+	return platform_driver_register(&bfin_i2s_pcm_driver);
+}
+module_init(snd_bfin_i2s_pcm_init);
+
+static void __exit snd_bfin_i2s_pcm_exit(void)
+{
+	platform_driver_unregister(&bfin_i2s_pcm_driver);
 }
-module_exit(bfin_i2s_exit);
+module_exit(snd_bfin_i2s_pcm_exit);
 
 MODULE_AUTHOR("Cliff Cai");
 MODULE_DESCRIPTION("ADI Blackfin I2S PCM DMA module");
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.h b/sound/soc/blackfin/bf5xx-i2s-pcm.h
index 4d4609a..63fed4b 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.h
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.h
@@ -24,6 +24,6 @@ struct bf5xx_gpio {
 };
 
 /* platform data */
-extern struct snd_soc_platform bf5xx_i2s_soc_platform;
+extern struct snd_soc_platform_driver bf5xx_i2s_soc_platform;
 
 #endif
diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index 3e6ada0..c311b5f 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -195,8 +195,7 @@ static void bf5xx_i2s_shutdown(struct snd_pcm_substream *substream,
 		bf5xx_i2s.configured = 0;
 }
 
-static int bf5xx_i2s_probe(struct platform_device *pdev,
-			   struct snd_soc_dai *dai)
+static int bf5xx_i2s_probe(struct snd_soc_dai *dai)
 {
 	pr_debug("%s enter\n", __func__);
 	if (peripheral_request_list(&sport_req[sport_num][0], "soc-audio")) {
@@ -215,11 +214,11 @@ static int bf5xx_i2s_probe(struct platform_device *pdev,
 	return 0;
 }
 
-static void bf5xx_i2s_remove(struct platform_device *pdev,
-			struct snd_soc_dai *dai)
+static int bf5xx_i2s_remove(struct snd_soc_dai *dai)
 {
 	pr_debug("%s enter\n", __func__);
 	peripheral_free_list(&sport_req[sport_num][0]);
+	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -228,9 +227,9 @@ static int bf5xx_i2s_suspend(struct snd_soc_dai *dai)
 
 	pr_debug("%s : sport %d\n", __func__, dai->id);
 
-	if (dai->capture.active)
+	if (dai->capture_active)
 		sport_rx_stop(sport_handle);
-	if (dai->playback.active)
+	if (dai->playback_active)
 		sport_tx_stop(sport_handle);
 	return 0;
 }
@@ -277,9 +276,8 @@ static struct snd_soc_dai_ops bf5xx_i2s_dai_ops = {
 	.set_fmt	= bf5xx_i2s_set_dai_fmt,
 };
 
-struct snd_soc_dai bf5xx_i2s_dai = {
+struct snd_soc_dai_driver bf5xx_i2s_dai = {
 	.name = "bf5xx-i2s",
-	.id = 0,
 	.probe = bf5xx_i2s_probe,
 	.remove = bf5xx_i2s_remove,
 	.suspend = bf5xx_i2s_suspend,
@@ -298,16 +296,38 @@ struct snd_soc_dai bf5xx_i2s_dai = {
 };
 EXPORT_SYMBOL_GPL(bf5xx_i2s_dai);
 
+static int bfin_i2s_drv_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_dai(&pdev->dev, -1, &bf5xx_i2s_dai);
+}
+
+static int __devexit bfin_i2s_drv_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_dai(&pdev->dev, -1);
+	return 0;
+}
+
+static struct platform_driver bfin_i2s_driver = {
+	.probe = bfin_i2s_drv_probe,
+	.remove = __devexit_p(bfin_i2s_drv_remove),
+
+	.driver = {
+		.name = "bf5xx-i2s",
+		.owner = THIS_MODULE,
+	},
+};
+
 static int __init bfin_i2s_init(void)
 {
-	return snd_soc_register_dai(&bf5xx_i2s_dai);
+	return platform_driver_register(&bfin_i2s_driver);
 }
-module_init(bfin_i2s_init);
 
 static void __exit bfin_i2s_exit(void)
 {
-	snd_soc_unregister_dai(&bf5xx_i2s_dai);
+	platform_driver_unregister(&bfin_i2s_driver);
 }
+
+module_init(bfin_i2s_init);
 module_exit(bfin_i2s_exit);
 
 /* Module information */
diff --git a/sound/soc/blackfin/bf5xx-i2s.h b/sound/soc/blackfin/bf5xx-i2s.h
index 264ecdc..794e604 100644
--- a/sound/soc/blackfin/bf5xx-i2s.h
+++ b/sound/soc/blackfin/bf5xx-i2s.h
@@ -9,6 +9,6 @@
 #ifndef _BF5XX_I2S_H
 #define _BF5XX_I2S_H
 
-extern struct snd_soc_dai bf5xx_i2s_dai;
+extern struct snd_soc_dai_driver bf5xx_i2s_dai;
 
 #endif
diff --git a/sound/soc/blackfin/bf5xx-ssm2602.c b/sound/soc/blackfin/bf5xx-ssm2602.c
index 3a00fa4..fa3a22c 100644
--- a/sound/soc/blackfin/bf5xx-ssm2602.c
+++ b/sound/soc/blackfin/bf5xx-ssm2602.c
@@ -49,10 +49,10 @@ static struct snd_soc_card bf5xx_ssm2602;
 static int bf5xx_ssm2602_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 
 	pr_debug("%s enter\n", __func__);
-	cpu_dai->private_data = sport_handle;
+	snd_soc_dai_set_drvdata(cpu_dai, sport_handle);
 	return 0;
 }
 
@@ -60,8 +60,8 @@ static int bf5xx_ssm2602_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	unsigned int clk = 0;
 	int ret = 0;
 
@@ -118,35 +118,18 @@ static struct snd_soc_ops bf5xx_ssm2602_ops = {
 static struct snd_soc_dai_link bf5xx_ssm2602_dai = {
 	.name = "ssm2602",
 	.stream_name = "SSM2602",
-	.cpu_dai = &bf5xx_i2s_dai,
-	.codec_dai = &ssm2602_dai,
+	.cpu_dai_drv = &bf5xx_i2s_dai,
+	.codec_dai_drv = &ssm2602_dai,
+	.platform_drv = &bf5xx_i2s_soc_platform,
+	.codec_drv = &soc_codec_dev_ssm2602,
 	.ops = &bf5xx_ssm2602_ops,
 };
 
-/*
- * SSM2602 2 wire address is determined by CSB
- * state during powerup.
- *    low  = 0x1a
- *    high = 0x1b
- */
-
-static struct ssm2602_setup_data bf5xx_ssm2602_setup = {
-	.i2c_bus = 0,
-	.i2c_address = 0x1b,
-};
-
 static struct snd_soc_card bf5xx_ssm2602 = {
 	.name = "bf5xx_ssm2602",
-	.platform = &bf5xx_i2s_soc_platform,
 	.dai_link = &bf5xx_ssm2602_dai,
 	.num_links = 1,
-};
-
-static struct snd_soc_device bf5xx_ssm2602_snd_devdata = {
-	.card = &bf5xx_ssm2602,
-	.codec_dev = &soc_codec_dev_ssm2602,
-	.codec_data = &bf5xx_ssm2602_setup,
-};
+};;
 
 static struct platform_device *bf5xx_ssm2602_snd_device;
 
@@ -159,9 +142,7 @@ static int __init bf5xx_ssm2602_init(void)
 	if (!bf5xx_ssm2602_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(bf5xx_ssm2602_snd_device,
-				&bf5xx_ssm2602_snd_devdata);
-	bf5xx_ssm2602_snd_devdata.dev = &bf5xx_ssm2602_snd_device->dev;
+	platform_set_drvdata(bf5xx_ssm2602_snd_device, &bf5xx_ssm2602);
 	ret = platform_device_add(bf5xx_ssm2602_snd_device);
 
 	if (ret)
diff --git a/sound/soc/blackfin/bf5xx-tdm-pcm.c b/sound/soc/blackfin/bf5xx-tdm-pcm.c
index 6bac1ac..487d9dd 100644
--- a/sound/soc/blackfin/bf5xx-tdm-pcm.c
+++ b/sound/soc/blackfin/bf5xx-tdm-pcm.c
@@ -290,14 +290,14 @@ static int bf5xx_pcm_tdm_new(struct snd_card *card, struct snd_soc_dai *dai,
 	if (!card->dev->coherent_dma_mask)
 		card->dev->coherent_dma_mask = DMA_BIT_MASK(32);
 
-	if (dai->playback.channels_min) {
+	if (dai->driver->playback.channels_min) {
 		ret = bf5xx_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_PLAYBACK);
 		if (ret)
 			goto out;
 	}
 
-	if (dai->capture.channels_min) {
+	if (dai->driver->capture.channels_min) {
 		ret = bf5xx_pcm_preallocate_dma_buffer(pcm,
 			SNDRV_PCM_STREAM_CAPTURE);
 		if (ret)
@@ -307,25 +307,46 @@ out:
 	return ret;
 }
 
-struct snd_soc_platform bf5xx_tdm_soc_platform = {
+struct snd_soc_platform_driver bf5xx_tdm_soc_platform = {
 	.name           = "bf5xx-audio",
-	.pcm_ops        = &bf5xx_pcm_tdm_ops,
+	.ops        = &bf5xx_pcm_tdm_ops,
 	.pcm_new        = bf5xx_pcm_tdm_new,
 	.pcm_free       = bf5xx_pcm_free_dma_buffers,
 };
 EXPORT_SYMBOL_GPL(bf5xx_tdm_soc_platform);
 
-static int __init bfin_pcm_tdm_init(void)
+static int __devinit bf5xx_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&bf5xx_tdm_soc_platform);
+	return snd_soc_register_platform(&pdev->dev, -1, &bf5xx_tdm_soc_platform);
 }
-module_init(bfin_pcm_tdm_init);
 
-static void __exit bfin_pcm_tdm_exit(void)
+static int __devexit bf5xx_soc_platform_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&bf5xx_tdm_soc_platform);
+	snd_soc_unregister_platform(&pdev->dev, -1);
+	return 0;
+}
+
+static struct platform_driver bfin_tdm_driver = {
+	.driver = {
+			.name = "bf5xx-tdm-pcm-audio",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = bf5xx_soc_platform_probe,
+	.remove = __devexit_p(bf5xx_soc_platform_remove),
+};
+
+static int __init snd_bfin_tdm_init(void)
+{
+	return platform_driver_register(&bfin_tdm_driver);
+}
+module_init(snd_bfin_tdm_init);
+
+static void __exit snd_bfin_tdm_exit(void)
+{
+	platform_driver_unregister(&bfin_tdm_driver);
 }
-module_exit(bfin_pcm_tdm_exit);
+module_exit(snd_bfin_tdm_exit);
 
 MODULE_AUTHOR("Barry Song");
 MODULE_DESCRIPTION("ADI Blackfin TDM PCM DMA module");
diff --git a/sound/soc/blackfin/bf5xx-tdm-pcm.h b/sound/soc/blackfin/bf5xx-tdm-pcm.h
index ddc5047..ef0213f 100644
--- a/sound/soc/blackfin/bf5xx-tdm-pcm.h
+++ b/sound/soc/blackfin/bf5xx-tdm-pcm.h
@@ -16,6 +16,6 @@ struct bf5xx_pcm_dma_params {
 };
 
 /* platform data */
-extern struct snd_soc_platform bf5xx_tdm_soc_platform;
+extern struct snd_soc_platform_driver bf5xx_tdm_soc_platform;
 
 #endif
diff --git a/sound/soc/blackfin/bf5xx-tdm.c b/sound/soc/blackfin/bf5xx-tdm.c
index 4b36012..74c8de3 100644
--- a/sound/soc/blackfin/bf5xx-tdm.c
+++ b/sound/soc/blackfin/bf5xx-tdm.c
@@ -215,9 +215,9 @@ static int bf5xx_tdm_suspend(struct snd_soc_dai *dai)
 
 	if (!dai->active)
 		return 0;
-	if (dai->capture.active)
+	if (dai->capture_active)
 		sport_rx_stop(sport);
-	if (dai->playback.active)
+	if (dai->playback_active)
 		sport_tx_stop(sport);
 	return 0;
 }
@@ -225,8 +225,7 @@ static int bf5xx_tdm_suspend(struct snd_soc_dai *dai)
 static int bf5xx_tdm_resume(struct snd_soc_dai *dai)
 {
 	int ret;
-	struct sport_device *sport =
-		(struct sport_device *)dai->private_data;
+	struct sport_device *sport = snd_soc_dai_get_drvdata(dai);
 
 	if (!dai->active)
 		return 0;
@@ -264,9 +263,8 @@ static struct snd_soc_dai_ops bf5xx_tdm_dai_ops = {
 	.set_channel_map   = bf5xx_tdm_set_channel_map,
 };
 
-struct snd_soc_dai bf5xx_tdm_dai = {
+struct snd_soc_dai_driver bf5xx_tdm_dai = {
 	.name = "bf5xx-tdm",
-	.id = 0,
 	.suspend = bf5xx_tdm_suspend,
 	.resume = bf5xx_tdm_resume,
 	.playback = {
@@ -322,7 +320,7 @@ static int __devinit bfin_tdm_probe(struct platform_device *pdev)
 		goto sport_config_err;
 	}
 
-	ret = snd_soc_register_dai(&bf5xx_tdm_dai);
+	ret = snd_soc_register_dai(&pdev->dev, -1, &bf5xx_tdm_dai);
 	if (ret) {
 		pr_err("Failed to register DAI: %d\n", ret);
 		goto sport_config_err;
@@ -339,7 +337,7 @@ sport_config_err:
 static int __devexit bfin_tdm_remove(struct platform_device *pdev)
 {
 	peripheral_free_list(&sport_req[sport_num][0]);
-	snd_soc_unregister_dai(&bf5xx_tdm_dai);
+	snd_soc_unregister_dai(&pdev->dev, -1);
 
 	return 0;
 }
diff --git a/sound/soc/blackfin/bf5xx-tdm.h b/sound/soc/blackfin/bf5xx-tdm.h
index 04189a1..8a2c642 100644
--- a/sound/soc/blackfin/bf5xx-tdm.h
+++ b/sound/soc/blackfin/bf5xx-tdm.h
@@ -20,6 +20,6 @@ struct bf5xx_tdm_port {
 	int configured;
 };
 
-extern struct snd_soc_dai bf5xx_tdm_dai;
+extern struct snd_soc_dai_driver bf5xx_tdm_dai;
 
 #endif
-- 
1.7.0.4
