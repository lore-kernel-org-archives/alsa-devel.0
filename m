From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 10/14] ASoC: multi-component - Analog Devices
	Blackfin Platform
Date: Wed, 11 Aug 2010 09:46:29 +0100
Message-ID: <1281516393-6060-11-git-send-email-lrg@slimlogic.co.uk>
References: <1281516393-6060-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 93847103886
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 10:47:11 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 42so11847202wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2010 01:47:11 -0700 (PDT)
In-Reply-To: <1281516393-6060-1-git-send-email-lrg@slimlogic.co.uk>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Mike Frysinger <vapier.adi@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
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

CC: Mike Frysinger <vapier.adi@gmail.com>
Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/blackfin/bf5xx-ac97-pcm.c |   43 ++++++++++++++++++++++++---------
 sound/soc/blackfin/bf5xx-ac97-pcm.h |    3 --
 sound/soc/blackfin/bf5xx-ac97.c     |   41 +++++++++++++++++++++++--------
 sound/soc/blackfin/bf5xx-ac97.h     |    2 -
 sound/soc/blackfin/bf5xx-ad1836.c   |   23 +++++++-----------
 sound/soc/blackfin/bf5xx-ad193x.c   |   23 +++++++-----------
 sound/soc/blackfin/bf5xx-ad1980.c   |   19 +++++---------
 sound/soc/blackfin/bf5xx-ad73311.c  |   22 ++++++-----------
 sound/soc/blackfin/bf5xx-i2s-pcm.c  |   44 ++++++++++++++++++++++++----------
 sound/soc/blackfin/bf5xx-i2s-pcm.h  |    3 --
 sound/soc/blackfin/bf5xx-i2s.c      |   45 ++++++++++++++++++++++++-----------
 sound/soc/blackfin/bf5xx-i2s.h      |   14 -----------
 sound/soc/blackfin/bf5xx-ssm2602.c  |   38 +++++++----------------------
 sound/soc/blackfin/bf5xx-tdm-pcm.c  |   43 ++++++++++++++++++++++++---------
 sound/soc/blackfin/bf5xx-tdm-pcm.h  |    3 --
 sound/soc/blackfin/bf5xx-tdm.c      |   17 +++++-------
 sound/soc/blackfin/bf5xx-tdm.h      |    2 -
 17 files changed, 203 insertions(+), 182 deletions(-)
 delete mode 100644 sound/soc/blackfin/bf5xx-i2s.h

diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index 5e7aacf..5a2fd8a 100644
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
@@ -439,25 +439,44 @@ int bf5xx_pcm_ac97_new(struct snd_card *card, struct snd_soc_dai *dai,
 	return ret;
 }
 
-struct snd_soc_platform bf5xx_ac97_soc_platform = {
-	.name		= "bf5xx-audio",
-	.pcm_ops 	= &bf5xx_pcm_ac97_ops,
+static struct snd_soc_platform_driver bf5xx_ac97_soc_platform = {
+	.ops			= &bf5xx_pcm_ac97_ops,
 	.pcm_new	= bf5xx_pcm_ac97_new,
 	.pcm_free	= bf5xx_pcm_free_dma_buffers,
 };
-EXPORT_SYMBOL_GPL(bf5xx_ac97_soc_platform);
 
-static int __init bfin_ac97_init(void)
+static int __devinit bf5xx_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&bf5xx_ac97_soc_platform);
+	return snd_soc_register_platform(&pdev->dev, &bf5xx_ac97_soc_platform);
 }
-module_init(bfin_ac97_init);
 
-static void __exit bfin_ac97_exit(void)
+static int __devexit bf5xx_soc_platform_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&bf5xx_ac97_soc_platform);
+	snd_soc_unregister_platform(&pdev->dev);
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
index 350125a..d324d58 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.h
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.h
@@ -23,7 +23,4 @@ struct bf5xx_gpio {
 	u32 frm;
 };
 
-/* platform data */
-extern struct snd_soc_platform bf5xx_ac97_soc_platform;
-
 #endif
diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
index c0eba51..067f38b 100644
--- a/sound/soc/blackfin/bf5xx-ac97.c
+++ b/sound/soc/blackfin/bf5xx-ac97.c
@@ -255,7 +255,7 @@ EXPORT_SYMBOL_GPL(soc_ac97_ops);
 #ifdef CONFIG_PM
 static int bf5xx_ac97_suspend(struct snd_soc_dai *dai)
 {
-	struct sport_device *sport = dai->private_data;
+	struct sport_device *sport = snd_soc_dai_get_drvdata(dai);
 
 	pr_debug("%s : sport %d\n", __func__, dai->id);
 	if (!dai->active)
@@ -270,7 +270,7 @@ static int bf5xx_ac97_suspend(struct snd_soc_dai *dai)
 static int bf5xx_ac97_resume(struct snd_soc_dai *dai)
 {
 	int ret;
-	struct sport_device *sport = dai->private_data;
+	struct sport_device *sport = snd_soc_dai_get_drvdata(dai);
 
 	pr_debug("%s : sport %d\n", __func__, dai->id);
 	if (!dai->active)
@@ -306,8 +306,7 @@ static int bf5xx_ac97_resume(struct snd_soc_dai *dai)
 #define bf5xx_ac97_resume	NULL
 #endif
 
-static int bf5xx_ac97_probe(struct platform_device *pdev,
-			    struct snd_soc_dai *dai)
+static int bf5xx_ac97_probe(struct snd_soc_dai *dai)
 {
 	int ret = 0;
 	cmd_count = (int *)get_zeroed_page(GFP_KERNEL);
@@ -379,8 +378,7 @@ peripheral_err:
 	return ret;
 }
 
-static void bf5xx_ac97_remove(struct platform_device *pdev,
-			      struct snd_soc_dai *dai)
+static int bf5xx_ac97_remove(struct snd_soc_dai *dai)
 {
 	free_page((unsigned long)cmd_count);
 	cmd_count = NULL;
@@ -388,11 +386,10 @@ static void bf5xx_ac97_remove(struct platform_device *pdev,
 #ifdef CONFIG_SND_BF5XX_HAVE_COLD_RESET
 	gpio_free(CONFIG_SND_BF5XX_RESET_GPIO_NUM);
 #endif
+	return 0;
 }
 
-struct snd_soc_dai bfin_ac97_dai = {
-	.name = "bf5xx-ac97",
-	.id = 0,
+struct snd_soc_dai_driver bfin_ac97_dai = {
 	.ac97_control = 1,
 	.probe = bf5xx_ac97_probe,
 	.remove = bf5xx_ac97_remove,
@@ -417,18 +414,40 @@ struct snd_soc_dai bfin_ac97_dai = {
 };
 EXPORT_SYMBOL_GPL(bfin_ac97_dai);
 
+static __devinit int asoc_bfin_ac97_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_dai(&pdev->dev, &bfin_ac97_dai);
+}
+
+static int __devexit asoc_bfin_ac97_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_dai(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver asoc_bfin_ac97_driver = {
+	.driver = {
+			.name = "bfin-ac97-dai",
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
index a1f97dd..15c635e 100644
--- a/sound/soc/blackfin/bf5xx-ac97.h
+++ b/sound/soc/blackfin/bf5xx-ac97.h
@@ -50,8 +50,6 @@ struct ac97_frame {
 #define TAG_PCM_SR		0x0080
 #define TAG_PCM_LFE		0x0040
 
-extern struct snd_soc_dai bfin_ac97_dai;
-
 void bf5xx_pcm_to_ac97(struct ac97_frame *dst, const __u16 *src, \
 		size_t count, unsigned int chan_mask);
 
diff --git a/sound/soc/blackfin/bf5xx-ad1836.c b/sound/soc/blackfin/bf5xx-ad1836.c
index 0f45a3f..64d2ddb 100644
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
+	.cpu_dai_name = "bf5xx-tdm-dai",
+	.codec_dai_name = "ad1836-hifi",
+	.platform_name = "bf5xx-tdm-pcm-audio",
+	.codec_name = "ad1836-codec.0",
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
index b8c9060..e36028b 100644
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
+	.cpu_dai_name = "bf5xx-tdm-dai",
+	.codec_dai_name ="ad193x-hifi",
+	.platform_name = "bf5xx-tdm-pcm-audio",
+	.codec_name = "ad193x-codec.5",
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
index d8f5912..a23f512 100644
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
+	.cpu_dai_name = "bfin-ac97-dai",
+	.codec_dai_name = "ad1980-hifi",
+	.platform_name = "bfin-pcm-audio",
+	.codec_name = "ad1980-codec",
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
index 9825b71..901eb30 100644
--- a/sound/soc/blackfin/bf5xx-ad73311.c
+++ b/sound/soc/blackfin/bf5xx-ad73311.c
@@ -47,7 +47,6 @@
 #include "../codecs/ad73311.h"
 #include "bf5xx-sport.h"
 #include "bf5xx-i2s-pcm.h"
-#include "bf5xx-i2s.h"
 
 #if CONFIG_SND_BF5XX_SPORT_NUM == 0
 #define bfin_write_SPORT_TCR1	bfin_write_SPORT0_TCR1
@@ -150,10 +149,10 @@ static int bf5xx_probe(struct platform_device *pdev)
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
 
@@ -161,7 +160,7 @@ static int bf5xx_ad73311_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret = 0;
 
 	pr_debug("%s rate %d format %x\n", __func__, params_rate(params),
@@ -185,24 +184,20 @@ static struct snd_soc_ops bf5xx_ad73311_ops = {
 static struct snd_soc_dai_link bf5xx_ad73311_dai = {
 	.name = "ad73311",
 	.stream_name = "AD73311",
-	.cpu_dai = &bf5xx_i2s_dai,
-	.codec_dai = &ad73311_dai,
+	.cpu_dai_name = "bf5xx-i2s-dai",
+	.codec_dai_name = "ad73311-hifi",
+	.platform_name = "bfin-pcm-audio",
+	.codec_name = "ad73311-codec",
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
@@ -214,8 +209,7 @@ static int __init bf5xx_ad73311_init(void)
 	if (!bf5xx_ad73311_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(bf5xx_ad73311_snd_device, &bf5xx_ad73311_snd_devdata);
-	bf5xx_ad73311_snd_devdata.dev = &bf5xx_ad73311_snd_device->dev;
+	platform_set_drvdata(bf5xx_ad73311_snd_device, &bf5xx_ad73311);
 	ret = platform_device_add(bf5xx_ad73311_snd_device);
 
 	if (ret)
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index 1d2a1ad..890a0dc 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -40,7 +40,6 @@
 #include <asm/dma.h>
 
 #include "bf5xx-i2s-pcm.h"
-#include "bf5xx-i2s.h"
 #include "bf5xx-sport.h"
 
 static void bf5xx_dma_irq(void *data)
@@ -257,14 +256,14 @@ int bf5xx_pcm_i2s_new(struct snd_card *card, struct snd_soc_dai *dai,
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
@@ -274,25 +273,44 @@ int bf5xx_pcm_i2s_new(struct snd_card *card, struct snd_soc_dai *dai,
 	return ret;
 }
 
-struct snd_soc_platform bf5xx_i2s_soc_platform = {
-	.name		= "bf5xx-audio",
-	.pcm_ops 	= &bf5xx_pcm_i2s_ops,
+static struct snd_soc_platform_driver bf5xx_i2s_soc_platform = {
+	.ops		= &bf5xx_pcm_i2s_ops,
 	.pcm_new	= bf5xx_pcm_i2s_new,
 	.pcm_free	= bf5xx_pcm_free_dma_buffers,
 };
-EXPORT_SYMBOL_GPL(bf5xx_i2s_soc_platform);
 
-static int __init bfin_i2s_init(void)
+static int __devinit bfin_i2s_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&bf5xx_i2s_soc_platform);
+	return snd_soc_register_platform(&pdev->dev, &bf5xx_i2s_soc_platform);
 }
-module_init(bfin_i2s_init);
 
-static void __exit bfin_i2s_exit(void)
+static int __devexit bfin_i2s_soc_platform_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&bf5xx_i2s_soc_platform);
+	snd_soc_unregister_platform(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver bfin_i2s_pcm_driver = {
+	.driver = {
+			.name = "bfin-pcm-audio",
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
index 4d4609a..0c2c5a6 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.h
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.h
@@ -23,7 +23,4 @@ struct bf5xx_gpio {
 	u32 frm;
 };
 
-/* platform data */
-extern struct snd_soc_platform bf5xx_i2s_soc_platform;
-
 #endif
diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index 3e6ada0..e45ea4a 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -42,7 +42,6 @@
 #include <linux/gpio.h>
 
 #include "bf5xx-sport.h"
-#include "bf5xx-i2s.h"
 
 struct bf5xx_i2s_port {
 	u16 tcr1;
@@ -195,8 +194,7 @@ static void bf5xx_i2s_shutdown(struct snd_pcm_substream *substream,
 		bf5xx_i2s.configured = 0;
 }
 
-static int bf5xx_i2s_probe(struct platform_device *pdev,
-			   struct snd_soc_dai *dai)
+static int bf5xx_i2s_probe(struct snd_soc_dai *dai)
 {
 	pr_debug("%s enter\n", __func__);
 	if (peripheral_request_list(&sport_req[sport_num][0], "soc-audio")) {
@@ -215,11 +213,11 @@ static int bf5xx_i2s_probe(struct platform_device *pdev,
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
@@ -228,9 +226,9 @@ static int bf5xx_i2s_suspend(struct snd_soc_dai *dai)
 
 	pr_debug("%s : sport %d\n", __func__, dai->id);
 
-	if (dai->capture.active)
+	if (dai->capture_active)
 		sport_rx_stop(sport_handle);
-	if (dai->playback.active)
+	if (dai->playback_active)
 		sport_tx_stop(sport_handle);
 	return 0;
 }
@@ -277,9 +275,7 @@ static struct snd_soc_dai_ops bf5xx_i2s_dai_ops = {
 	.set_fmt	= bf5xx_i2s_set_dai_fmt,
 };
 
-struct snd_soc_dai bf5xx_i2s_dai = {
-	.name = "bf5xx-i2s",
-	.id = 0,
+static struct snd_soc_dai_driver bf5xx_i2s_dai = {
 	.probe = bf5xx_i2s_probe,
 	.remove = bf5xx_i2s_remove,
 	.suspend = bf5xx_i2s_suspend,
@@ -296,18 +292,39 @@ struct snd_soc_dai bf5xx_i2s_dai = {
 		.formats = BF5XX_I2S_FORMATS,},
 	.ops = &bf5xx_i2s_dai_ops,
 };
-EXPORT_SYMBOL_GPL(bf5xx_i2s_dai);
+
+static int bfin_i2s_drv_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_dai(&pdev->dev, &bf5xx_i2s_dai);
+}
+
+static int __devexit bfin_i2s_drv_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_dai(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver bfin_i2s_driver = {
+	.probe = bfin_i2s_drv_probe,
+	.remove = __devexit_p(bfin_i2s_drv_remove),
+
+	.driver = {
+		.name = "bf5xx-i2s-dai",
+		.owner = THIS_MODULE,
+	},
+};
 
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
deleted file mode 100644
index 264ecdc..0000000
--- a/sound/soc/blackfin/bf5xx-i2s.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * sound/soc/blackfin/bf5xx-i2s.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _BF5XX_I2S_H
-#define _BF5XX_I2S_H
-
-extern struct snd_soc_dai bf5xx_i2s_dai;
-
-#endif
diff --git a/sound/soc/blackfin/bf5xx-ssm2602.c b/sound/soc/blackfin/bf5xx-ssm2602.c
index 3a00fa4..951c40e 100644
--- a/sound/soc/blackfin/bf5xx-ssm2602.c
+++ b/sound/soc/blackfin/bf5xx-ssm2602.c
@@ -42,17 +42,16 @@
 #include "../codecs/ssm2602.h"
 #include "bf5xx-sport.h"
 #include "bf5xx-i2s-pcm.h"
-#include "bf5xx-i2s.h"
 
 static struct snd_soc_card bf5xx_ssm2602;
 
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
 
@@ -60,8 +59,8 @@ static int bf5xx_ssm2602_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	unsigned int clk = 0;
 	int ret = 0;
 
@@ -118,36 +117,19 @@ static struct snd_soc_ops bf5xx_ssm2602_ops = {
 static struct snd_soc_dai_link bf5xx_ssm2602_dai = {
 	.name = "ssm2602",
 	.stream_name = "SSM2602",
-	.cpu_dai = &bf5xx_i2s_dai,
-	.codec_dai = &ssm2602_dai,
+	.cpu_dai_name = "bf5xx-i2s-dai",
+	.codec_dai_name = "ssm2602-hifi",
+	.platform_name = "bf5xx-pcm-audio",
+	.codec_name = "ssm2602-codec.0-0x1b",
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
 };
 
-static struct snd_soc_device bf5xx_ssm2602_snd_devdata = {
-	.card = &bf5xx_ssm2602,
-	.codec_dev = &soc_codec_dev_ssm2602,
-	.codec_data = &bf5xx_ssm2602_setup,
-};
-
 static struct platform_device *bf5xx_ssm2602_snd_device;
 
 static int __init bf5xx_ssm2602_init(void)
@@ -159,9 +141,7 @@ static int __init bf5xx_ssm2602_init(void)
 	if (!bf5xx_ssm2602_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(bf5xx_ssm2602_snd_device,
-				&bf5xx_ssm2602_snd_devdata);
-	bf5xx_ssm2602_snd_devdata.dev = &bf5xx_ssm2602_snd_device->dev;
+	platform_set_drvdata(bf5xx_ssm2602_snd_device, &bf5xx_ssm2602);
 	ret = platform_device_add(bf5xx_ssm2602_snd_device);
 
 	if (ret)
diff --git a/sound/soc/blackfin/bf5xx-tdm-pcm.c b/sound/soc/blackfin/bf5xx-tdm-pcm.c
index 6bac1ac..74cf759 100644
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
@@ -307,25 +307,44 @@ out:
 	return ret;
 }
 
-struct snd_soc_platform bf5xx_tdm_soc_platform = {
-	.name           = "bf5xx-audio",
-	.pcm_ops        = &bf5xx_pcm_tdm_ops,
+static struct snd_soc_platform_driver bf5xx_tdm_soc_platform = {
+	.ops        = &bf5xx_pcm_tdm_ops,
 	.pcm_new        = bf5xx_pcm_tdm_new,
 	.pcm_free       = bf5xx_pcm_free_dma_buffers,
 };
-EXPORT_SYMBOL_GPL(bf5xx_tdm_soc_platform);
 
-static int __init bfin_pcm_tdm_init(void)
+static int __devinit bf5xx_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&bf5xx_tdm_soc_platform);
+	return snd_soc_register_platform(&pdev->dev, &bf5xx_tdm_soc_platform);
 }
-module_init(bfin_pcm_tdm_init);
 
-static void __exit bfin_pcm_tdm_exit(void)
+static int __devexit bf5xx_soc_platform_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&bf5xx_tdm_soc_platform);
+	snd_soc_unregister_platform(&pdev->dev);
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
index ddc5047..7f8cc01 100644
--- a/sound/soc/blackfin/bf5xx-tdm-pcm.h
+++ b/sound/soc/blackfin/bf5xx-tdm-pcm.h
@@ -15,7 +15,4 @@ struct bf5xx_pcm_dma_params {
 	char *name;                     /* stream identifier */
 };
 
-/* platform data */
-extern struct snd_soc_platform bf5xx_tdm_soc_platform;
-
 #endif
diff --git a/sound/soc/blackfin/bf5xx-tdm.c b/sound/soc/blackfin/bf5xx-tdm.c
index 24c1426..8baffe0 100644
--- a/sound/soc/blackfin/bf5xx-tdm.c
+++ b/sound/soc/blackfin/bf5xx-tdm.c
@@ -214,9 +214,9 @@ static int bf5xx_tdm_suspend(struct snd_soc_dai *dai)
 
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
@@ -224,7 +224,7 @@ static int bf5xx_tdm_suspend(struct snd_soc_dai *dai)
 static int bf5xx_tdm_resume(struct snd_soc_dai *dai)
 {
 	int ret;
-	struct sport_device *sport = dai->private_data;
+	struct sport_device *sport = snd_soc_dai_get_drvdata(dai);
 
 	if (!dai->active)
 		return 0;
@@ -262,9 +262,7 @@ static struct snd_soc_dai_ops bf5xx_tdm_dai_ops = {
 	.set_channel_map   = bf5xx_tdm_set_channel_map,
 };
 
-struct snd_soc_dai bf5xx_tdm_dai = {
-	.name = "bf5xx-tdm",
-	.id = 0,
+static struct snd_soc_dai_driver bf5xx_tdm_dai = {
 	.suspend = bf5xx_tdm_suspend,
 	.resume = bf5xx_tdm_resume,
 	.playback = {
@@ -279,7 +277,6 @@ struct snd_soc_dai bf5xx_tdm_dai = {
 		.formats = SNDRV_PCM_FMTBIT_S32_LE,},
 	.ops = &bf5xx_tdm_dai_ops,
 };
-EXPORT_SYMBOL_GPL(bf5xx_tdm_dai);
 
 static int __devinit bfin_tdm_probe(struct platform_device *pdev)
 {
@@ -320,7 +317,7 @@ static int __devinit bfin_tdm_probe(struct platform_device *pdev)
 		goto sport_config_err;
 	}
 
-	ret = snd_soc_register_dai(&bf5xx_tdm_dai);
+	ret = snd_soc_register_dai(&pdev->dev, &bf5xx_tdm_dai);
 	if (ret) {
 		pr_err("Failed to register DAI: %d\n", ret);
 		goto sport_config_err;
@@ -337,7 +334,7 @@ sport_config_err:
 static int __devexit bfin_tdm_remove(struct platform_device *pdev)
 {
 	peripheral_free_list(&sport_req[sport_num][0]);
-	snd_soc_unregister_dai(&bf5xx_tdm_dai);
+	snd_soc_unregister_dai(&pdev->dev);
 
 	return 0;
 }
@@ -346,7 +343,7 @@ static struct platform_driver bfin_tdm_driver = {
 	.probe  = bfin_tdm_probe,
 	.remove = __devexit_p(bfin_tdm_remove),
 	.driver = {
-		.name   = "bfin-tdm",
+		.name   = "bfin-tdm-dai",
 		.owner  = THIS_MODULE,
 	},
 };
diff --git a/sound/soc/blackfin/bf5xx-tdm.h b/sound/soc/blackfin/bf5xx-tdm.h
index 04189a1..e986a3e 100644
--- a/sound/soc/blackfin/bf5xx-tdm.h
+++ b/sound/soc/blackfin/bf5xx-tdm.h
@@ -20,6 +20,4 @@ struct bf5xx_tdm_port {
 	int configured;
 };
 
-extern struct snd_soc_dai bf5xx_tdm_dai;
-
 #endif
-- 
1.7.0.4
