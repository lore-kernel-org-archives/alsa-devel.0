From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 03/17] ASoC: multi-component - pcm3008, ssm2602,
	jz4740 and uda1380
Date: Wed, 11 Aug 2010 00:02:54 +0100
Message-ID: <1281481388-3000-4-git-send-email-lrg@slimlogic.co.uk>
References: <1281481388-3000-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id BCE282444D
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 01:03:30 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 42so11453003wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2010 16:03:30 -0700 (PDT)
In-Reply-To: <1281481388-3000-1-git-send-email-lrg@slimlogic.co.uk>
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

Move CODECs to multi-component model.

This patch changes the probe() and remove() of the CODEC drivers as follows:-

 o Make CODEC driver a platform driver
 o Moved all struct snd_soc_codec list, mutex, etc initialiasation to core.
 o Removed all static codec pointers (drivers now support > 1 codec dev)
 o snd_soc_register_pcms() now done by core.
 o snd_soc_register_dai() folded into snd_soc_register_codec().
 o codec cache can now be malloc()ed by core.

Other required changes due to multi-component model :-

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/jz4740.c  |  116 +++++------------------
 sound/soc/codecs/jz4740.h  |    4 +-
 sound/soc/codecs/pcm3008.c |   92 ++++++++-----------
 sound/soc/codecs/pcm3008.h |    3 -
 sound/soc/codecs/ssm2602.c |  219 ++++++++++++--------------------------------
 sound/soc/codecs/ssm2602.h |    3 -
 sound/soc/codecs/uda1380.c |  211 ++++++++++++-------------------------------
 sound/soc/codecs/uda1380.h |    3 -
 8 files changed, 182 insertions(+), 469 deletions(-)

diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 66557de..16253ec 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -74,29 +74,22 @@ static const uint32_t jz4740_codec_regs[] = {
 struct jz4740_codec {
 	void __iomem *base;
 	struct resource *mem;
-
-	uint32_t reg_cache[2];
-	struct snd_soc_codec codec;
 };
 
-static inline struct jz4740_codec *codec_to_jz4740(struct snd_soc_codec *codec)
-{
-	return container_of(codec, struct jz4740_codec, codec);
-}
-
 static unsigned int jz4740_codec_read(struct snd_soc_codec *codec,
 	unsigned int reg)
 {
-	struct jz4740_codec *jz4740_codec = codec_to_jz4740(codec);
+	struct jz4740_codec *jz4740_codec = snd_soc_codec_get_drvdata(codec);
 	return readl(jz4740_codec->base + (reg << 2));
 }
 
 static int jz4740_codec_write(struct snd_soc_codec *codec, unsigned int reg,
 	unsigned int val)
 {
-	struct jz4740_codec *jz4740_codec = codec_to_jz4740(codec);
+	struct jz4740_codec *jz4740_codec = snd_soc_codec_get_drvdata(codec);
+	u32 *cache = codec->reg_cache;
 
-	jz4740_codec->reg_cache[reg] = val;
+	cache[reg] = val;
 	writel(val, jz4740_codec->base + (reg << 2));
 
 	return 0;
@@ -172,8 +165,7 @@ static int jz4740_codec_hw_params(struct snd_pcm_substream *substream,
 {
 	uint32_t val;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec =rtd->codec;
 
 	switch (params_rate(params)) {
 	case 8000:
@@ -219,8 +211,8 @@ static struct snd_soc_dai_ops jz4740_codec_dai_ops = {
 	.hw_params = jz4740_codec_hw_params,
 };
 
-struct snd_soc_dai jz4740_codec_dai = {
-	.name = "jz4740",
+static struct snd_soc_dai_driver jz4740_codec_dai = {
+	.name = "jz4740-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
@@ -238,7 +230,6 @@ struct snd_soc_dai jz4740_codec_dai = {
 	.ops = &jz4740_codec_dai_ops,
 	.symmetric_rates = 1,
 };
-EXPORT_SYMBOL_GPL(jz4740_codec_dai);
 
 static void jz4740_codec_wakeup(struct snd_soc_codec *codec)
 {
@@ -302,23 +293,10 @@ static int jz4740_codec_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static struct snd_soc_codec *jz4740_codec_codec;
-
-static int jz4740_codec_dev_probe(struct platform_device *pdev)
+static int jz4740_codec_dev_probe(struct snd_soc_codec *codec)
 {
-	int ret;
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = jz4740_codec_codec;
-
-	BUG_ON(!codec);
-
-	socdev->card->codec = codec;
-
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to create pcms: %d\n", ret);
-		return ret;
-	}
+	snd_soc_update_bits(codec, JZ4740_REG_CODEC_1,
+			JZ4740_CODEC_1_SW2_ENABLE, JZ4740_CODEC_1_SW2_ENABLE);
 
 	snd_soc_add_controls(codec, jz4740_codec_controls,
 		ARRAY_SIZE(jz4740_codec_controls));
@@ -331,34 +309,27 @@ static int jz4740_codec_dev_probe(struct platform_device *pdev)
 
 	snd_soc_dapm_new_widgets(codec);
 
+	jz4740_codec_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+
 	return 0;
 }
 
-static int jz4740_codec_dev_remove(struct platform_device *pdev)
+static int jz4740_codec_dev_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
+	jz4740_codec_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
 
-static int jz4740_codec_suspend(struct platform_device *pdev, pm_message_t state)
+static int jz4740_codec_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	return jz4740_codec_set_bias_level(codec, SND_SOC_BIAS_OFF);
 }
 
-static int jz4740_codec_resume(struct platform_device *pdev)
+static int jz4740_codec_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	return jz4740_codec_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 }
 
@@ -367,19 +338,23 @@ static int jz4740_codec_resume(struct platform_device *pdev)
 #define jz4740_codec_resume NULL
 #endif
 
-struct snd_soc_codec_device soc_codec_dev_jz4740_codec = {
+static struct snd_soc_codec_driver soc_codec_dev_jz4740_codec = {
 	.probe = jz4740_codec_dev_probe,
 	.remove = jz4740_codec_dev_remove,
 	.suspend = jz4740_codec_suspend,
 	.resume = jz4740_codec_resume,
+	.read = jz4740_codec_read,
+	.write = jz4740_codec_write,
+	.set_bias_level = jz4740_codec_set_bias_level,
+	.reg_cache_default	= jz4740_codec_regs,
+	.reg_word_size = sizeof(u32),
+	.reg_cache_size	= 2,
 };
-EXPORT_SYMBOL_GPL(soc_codec_dev_jz4740_codec);
 
 static int __devinit jz4740_codec_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct jz4740_codec *jz4740_codec;
-	struct snd_soc_codec *codec;
 	struct resource *mem;
 
 	jz4740_codec = kzalloc(sizeof(*jz4740_codec), GFP_KERNEL);
@@ -408,55 +383,17 @@ static int __devinit jz4740_codec_probe(struct platform_device *pdev)
 	}
 	jz4740_codec->mem = mem;
 
-	jz4740_codec_dai.dev = &pdev->dev;
-
-	codec = &jz4740_codec->codec;
-
-	codec->dev		= &pdev->dev;
-	codec->name		= "jz4740";
-	codec->owner		= THIS_MODULE;
-
-	codec->read		= jz4740_codec_read;
-	codec->write		= jz4740_codec_write;
-	codec->set_bias_level	= jz4740_codec_set_bias_level;
-	codec->bias_level	= SND_SOC_BIAS_OFF;
-
-	codec->dai		= &jz4740_codec_dai;
-	codec->num_dai		= 1;
-
-	codec->reg_cache	= jz4740_codec->reg_cache;
-	codec->reg_cache_size	= 2;
-	memcpy(codec->reg_cache, jz4740_codec_regs, sizeof(jz4740_codec_regs));
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	jz4740_codec_codec = codec;
-
-	snd_soc_update_bits(codec, JZ4740_REG_CODEC_1,
-			JZ4740_CODEC_1_SW2_ENABLE, JZ4740_CODEC_1_SW2_ENABLE);
-
 	platform_set_drvdata(pdev, jz4740_codec);
 
-	ret = snd_soc_register_codec(codec);
+	ret = snd_soc_register_codec(&pdev->dev,
+			&soc_codec_dev_jz4740_codec, &jz4740_codec_dai, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register codec\n");
 		goto err_iounmap;
 	}
 
-	ret = snd_soc_register_dai(&jz4740_codec_dai);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to register codec dai\n");
-		goto err_unregister_codec;
-	}
-
-	jz4740_codec_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-
 	return 0;
 
-err_unregister_codec:
-	snd_soc_unregister_codec(codec);
 err_iounmap:
 	iounmap(jz4740_codec->base);
 err_release_mem_region:
@@ -472,8 +409,7 @@ static int __devexit jz4740_codec_remove(struct platform_device *pdev)
 	struct jz4740_codec *jz4740_codec = platform_get_drvdata(pdev);
 	struct resource *mem = jz4740_codec->mem;
 
-	snd_soc_unregister_dai(&jz4740_codec_dai);
-	snd_soc_unregister_codec(&jz4740_codec->codec);
+	snd_soc_unregister_codec(&pdev->dev);
 
 	iounmap(jz4740_codec->base);
 	release_mem_region(mem->start, resource_size(mem));
diff --git a/sound/soc/codecs/jz4740.h b/sound/soc/codecs/jz4740.h
index b5a0691..d4b5d73 100644
--- a/sound/soc/codecs/jz4740.h
+++ b/sound/soc/codecs/jz4740.h
@@ -14,7 +14,7 @@
 #ifndef __SND_SOC_CODECS_JZ4740_CODEC_H__
 #define __SND_SOC_CODECS_JZ4740_CODEC_H__
 
-extern struct snd_soc_dai jz4740_codec_dai;
-extern struct snd_soc_codec_device soc_codec_dev_jz4740_codec;
+extern struct snd_soc_dai_driver jz4740_codec_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_jz4740_codec;
 
 #endif
diff --git a/sound/soc/codecs/pcm3008.c b/sound/soc/codecs/pcm3008.c
index 5a5f187..bd8f26e 100644
--- a/sound/soc/codecs/pcm3008.c
+++ b/sound/soc/codecs/pcm3008.c
@@ -32,8 +32,8 @@
 #define PCM3008_RATES (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |	\
 		       SNDRV_PCM_RATE_48000)
 
-struct snd_soc_dai pcm3008_dai = {
-	.name = "PCM3008 HiFi",
+static struct snd_soc_dai_driver pcm3008_dai = {
+	.name = "pcm3008-hifi",
 	.playback = {
 		.stream_name = "PCM3008 Playback",
 		.channels_min = 1,
@@ -49,7 +49,6 @@ struct snd_soc_dai pcm3008_dai = {
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 };
-EXPORT_SYMBOL_GPL(pcm3008_dai);
 
 static void pcm3008_gpio_free(struct pcm3008_setup_data *setup)
 {
@@ -59,38 +58,13 @@ static void pcm3008_gpio_free(struct pcm3008_setup_data *setup)
 	gpio_free(setup->pdda_pin);
 }
 
-static int pcm3008_soc_probe(struct platform_device *pdev)
+static int pcm3008_soc_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	struct pcm3008_setup_data *setup = socdev->codec_data;
+	struct pcm3008_setup_data *setup = codec->dev->platform_data;
 	int ret = 0;
 
 	printk(KERN_INFO "PCM3008 SoC Audio Codec %s\n", PCM3008_VERSION);
 
-	socdev->card->codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (!socdev->card->codec)
-		return -ENOMEM;
-
-	codec = socdev->card->codec;
-	mutex_init(&codec->mutex);
-
-	codec->name = "PCM3008";
-	codec->owner = THIS_MODULE;
-	codec->dai = &pcm3008_dai;
-	codec->num_dai = 1;
-	codec->write = NULL;
-	codec->read = NULL;
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	/* Register PCMs. */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		printk(KERN_ERR "pcm3008: failed to create pcms\n");
-		goto pcm_err;
-	}
-
 	/* DEM1  DEM0  DE-EMPHASIS_MODE
 	 * Low   Low   De-emphasis 44.1 kHz ON
 	 * Low   High  De-emphasis OFF
@@ -130,33 +104,22 @@ static int pcm3008_soc_probe(struct platform_device *pdev)
 
 gpio_err:
 	pcm3008_gpio_free(setup);
-pcm_err:
-	kfree(socdev->card->codec);
 
 	return ret;
 }
 
-static int pcm3008_soc_remove(struct platform_device *pdev)
+static int pcm3008_soc_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-	struct pcm3008_setup_data *setup = socdev->codec_data;
-
-	if (!codec)
-		return 0;
+	struct pcm3008_setup_data *setup = codec->dev->platform_data;
 
 	pcm3008_gpio_free(setup);
-	snd_soc_free_pcms(socdev);
-	kfree(socdev->card->codec);
-
 	return 0;
 }
 
 #ifdef CONFIG_PM
-static int pcm3008_soc_suspend(struct platform_device *pdev, pm_message_t msg)
+static int pcm3008_soc_suspend(struct snd_soc_codec *codec, pm_message_t msg)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct pcm3008_setup_data *setup = socdev->codec_data;
+	struct pcm3008_setup_data *setup = codec->dev->platform_data;
 
 	gpio_set_value(setup->pdad_pin, 0);
 	gpio_set_value(setup->pdda_pin, 0);
@@ -164,10 +127,9 @@ static int pcm3008_soc_suspend(struct platform_device *pdev, pm_message_t msg)
 	return 0;
 }
 
-static int pcm3008_soc_resume(struct platform_device *pdev)
+static int pcm3008_soc_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct pcm3008_setup_data *setup = socdev->codec_data;
+	struct pcm3008_setup_data *setup = codec->dev->platform_data;
 
 	gpio_set_value(setup->pdad_pin, 1);
 	gpio_set_value(setup->pdda_pin, 1);
@@ -179,23 +141,45 @@ static int pcm3008_soc_resume(struct platform_device *pdev)
 #define pcm3008_soc_resume NULL
 #endif
 
-struct snd_soc_codec_device soc_codec_dev_pcm3008 = {
+static struct snd_soc_codec_driver soc_codec_dev_pcm3008 = {
 	.probe = 	pcm3008_soc_probe,
 	.remove = 	pcm3008_soc_remove,
 	.suspend =	pcm3008_soc_suspend,
 	.resume =	pcm3008_soc_resume,
 };
-EXPORT_SYMBOL_GPL(soc_codec_dev_pcm3008);
 
-static int __init pcm3008_init(void)
+static int __devinit pcm3008_codec_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev,
+			&soc_codec_dev_pcm3008, &pcm3008_dai, 1);
+}
+
+static int __devexit pcm3008_codec_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+MODULE_ALIAS("platform:pcm3008-codec");
+
+static struct platform_driver pcm3008_codec_driver = {
+	.probe		= pcm3008_codec_probe,
+	.remove		= __devexit_p(pcm3008_codec_remove),
+	.driver		= {
+		.name	= "pcm3008-codec",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init pcm3008_modinit(void)
 {
-	return snd_soc_register_dai(&pcm3008_dai);
+	return platform_driver_register(&pcm3008_codec_driver);
 }
-module_init(pcm3008_init);
+module_init(pcm3008_modinit);
 
 static void __exit pcm3008_exit(void)
 {
-	snd_soc_unregister_dai(&pcm3008_dai);
+	platform_driver_unregister(&pcm3008_codec_driver);
 }
 module_exit(pcm3008_exit);
 
diff --git a/sound/soc/codecs/pcm3008.h b/sound/soc/codecs/pcm3008.h
index d04e87d..7e5489a 100644
--- a/sound/soc/codecs/pcm3008.h
+++ b/sound/soc/codecs/pcm3008.h
@@ -19,7 +19,4 @@ struct pcm3008_setup_data {
 	unsigned pdda_pin;
 };
 
-extern struct snd_soc_codec_device soc_codec_dev_pcm3008;
-extern struct snd_soc_dai pcm3008_dai;
-
 #endif
diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index b47ed4f..67d8c04 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -45,11 +45,11 @@
 
 #define SSM2602_VERSION "0.1"
 
-struct snd_soc_codec_device soc_codec_dev_ssm2602;
-
 /* codec private data */
 struct ssm2602_priv {
 	unsigned int sysclk;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	struct snd_pcm_substream *master_substream;
 	struct snd_pcm_substream *slave_substream;
 };
@@ -276,8 +276,7 @@ static int ssm2602_hw_params(struct snd_pcm_substream *substream,
 {
 	u16 srate;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
 	struct i2c_client *i2c = codec->control_data;
 	u16 iface = ssm2602_read_reg_cache(codec, SSM2602_IFACE) & 0xfff3;
@@ -321,8 +320,7 @@ static int ssm2602_startup(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
 	struct i2c_client *i2c = codec->control_data;
 	struct snd_pcm_runtime *master_runtime;
@@ -360,8 +358,7 @@ static int ssm2602_pcm_prepare(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	/* set active */
 	ssm2602_write(codec, SSM2602_ACTIVE, ACTIVE_ACTIVATE_CODEC);
 
@@ -372,8 +369,7 @@ static void ssm2602_shutdown(struct snd_pcm_substream *substream,
 			     struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
 
 	/* deactivate */
@@ -518,8 +514,8 @@ static struct snd_soc_dai_ops ssm2602_dai_ops = {
 	.set_fmt	= ssm2602_set_dai_fmt,
 };
 
-struct snd_soc_dai ssm2602_dai = {
-	.name = "SSM2602",
+static struct snd_soc_dai_driver ssm2602_dai = {
+	.name = "ssm2602-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
@@ -534,21 +530,15 @@ struct snd_soc_dai ssm2602_dai = {
 		.formats = SSM2602_FORMATS,},
 	.ops = &ssm2602_dai_ops,
 };
-EXPORT_SYMBOL_GPL(ssm2602_dai);
 
-static int ssm2602_suspend(struct platform_device *pdev, pm_message_t state)
+static int ssm2602_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	ssm2602_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-static int ssm2602_resume(struct platform_device *pdev)
+static int ssm2602_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	int i;
 	u8 data[2];
 	u16 *cache = codec->reg_cache;
@@ -563,36 +553,18 @@ static int ssm2602_resume(struct platform_device *pdev)
 	return 0;
 }
 
-/*
- * initialise the ssm2602 driver
- * register the mixer and dsp interfaces with the kernel
- */
-static int ssm2602_init(struct snd_soc_device *socdev)
+static int ssm2602_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_codec *codec = socdev->card->codec;
-	int reg, ret = 0;
-
-	codec->name = "SSM2602";
-	codec->owner = THIS_MODULE;
-	codec->read = ssm2602_read_reg_cache;
-	codec->write = ssm2602_write;
-	codec->set_bias_level = ssm2602_set_bias_level;
-	codec->dai = &ssm2602_dai;
-	codec->num_dai = 1;
-	codec->reg_cache_size = sizeof(ssm2602_reg);
-	codec->reg_cache = kmemdup(ssm2602_reg, sizeof(ssm2602_reg),
-					GFP_KERNEL);
-	if (codec->reg_cache == NULL)
-		return -ENOMEM;
+	struct ssm2602_priv *ssm2602 = snd_soc_codec_get_drvdata(codec);
+	int ret = 0, reg;
+
+	pr_info("ssm2602 Audio Codec %s", SSM2602_VERSION);
+
+	codec->bias_level = SND_SOC_BIAS_OFF,
+	codec->control_data = ssm2602->control_data;
 
 	ssm2602_reset(codec);
 
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		pr_err("ssm2602: failed to create pcms\n");
-		goto pcm_err;
-	}
 	/*power on device*/
 	ssm2602_write(codec, SSM2602_ACTIVE, 0);
 	/* set the update bits */
@@ -614,13 +586,27 @@ static int ssm2602_init(struct snd_soc_device *socdev)
 	ssm2602_add_widgets(codec);
 
 	return ret;
+}
 
-pcm_err:
-	kfree(codec->reg_cache);
-	return ret;
+/* remove everything here */
+static int ssm2602_remove(struct snd_soc_codec *codec)
+{
+	ssm2602_set_bias_level(codec, SND_SOC_BIAS_OFF);
+	return 0;
 }
 
-static struct snd_soc_device *ssm2602_socdev;
+static struct snd_soc_codec_driver soc_codec_dev_ssm2602 = {
+	.probe =	ssm2602_probe,
+	.remove =	ssm2602_remove,
+	.suspend =	ssm2602_suspend,
+	.resume =	ssm2602_resume,
+	.read = ssm2602_read_reg_cache,
+	.write = ssm2602_write,
+	.set_bias_level = ssm2602_set_bias_level,
+	.reg_cache_size = sizeof(ssm2602_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = ssm2602_reg,
+};
 
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 /*
@@ -632,24 +618,28 @@ static struct snd_soc_device *ssm2602_socdev;
 static int ssm2602_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
-	struct snd_soc_device *socdev = ssm2602_socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct ssm2602_priv *ssm2602;
 	int ret;
 
-	i2c_set_clientdata(i2c, codec);
-	codec->control_data = i2c;
+	ssm2602 = kzalloc(sizeof(struct ssm2602_priv), GFP_KERNEL);
+	if (ssm2602 == NULL)
+		return -ENOMEM;
 
-	ret = ssm2602_init(socdev);
-	if (ret < 0)
-		pr_err("failed to initialise SSM2602\n");
+	i2c_set_clientdata(i2c, ssm2602);
+	ssm2602->control_data = i2c;
+	ssm2602->control_type = SND_SOC_I2C;
 
+	ret = snd_soc_register_codec(&i2c->dev,
+			&soc_codec_dev_ssm2602, &ssm2602_dai, 1);
+	if (ret < 0)
+		kfree(ssm2602);
 	return ret;
 }
 
 static int ssm2602_i2c_remove(struct i2c_client *client)
 {
-	struct snd_soc_codec *codec = i2c_get_clientdata(client);
-	kfree(codec->reg_cache);
+	snd_soc_unregister_codec(&client->dev);
+	kfree(i2c_get_clientdata(client));
 	return 0;
 }
 
@@ -658,130 +648,39 @@ static const struct i2c_device_id ssm2602_i2c_id[] = {
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ssm2602_i2c_id);
+
 /* corgi i2c codec control layer */
 static struct i2c_driver ssm2602_i2c_driver = {
 	.driver = {
-		.name = "SSM2602 I2C Codec",
+		.name = "ssm2602-codec",
 		.owner = THIS_MODULE,
 	},
 	.probe = ssm2602_i2c_probe,
 	.remove = ssm2602_i2c_remove,
 	.id_table = ssm2602_i2c_id,
 };
-
-static int ssm2602_add_i2c_device(struct platform_device *pdev,
-				  const struct ssm2602_setup_data *setup)
-{
-	struct i2c_board_info info;
-	struct i2c_adapter *adapter;
-	struct i2c_client *client;
-	int ret;
-
-	ret = i2c_add_driver(&ssm2602_i2c_driver);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "can't add i2c driver\n");
-		return ret;
-	}
-	memset(&info, 0, sizeof(struct i2c_board_info));
-	info.addr = setup->i2c_address;
-	strlcpy(info.type, "ssm2602", I2C_NAME_SIZE);
-	adapter = i2c_get_adapter(setup->i2c_bus);
-	if (!adapter) {
-		dev_err(&pdev->dev, "can't get i2c adapter %d\n",
-		setup->i2c_bus);
-		goto err_driver;
-	}
-	client = i2c_new_device(adapter, &info);
-	i2c_put_adapter(adapter);
-	if (!client) {
-		dev_err(&pdev->dev, "can't add i2c device at 0x%x\n",
-		(unsigned int)info.addr);
-		goto err_driver;
-	}
-	return 0;
-err_driver:
-	i2c_del_driver(&ssm2602_i2c_driver);
-	return -ENODEV;
-}
 #endif
 
-static int ssm2602_probe(struct platform_device *pdev)
+
+static int __init ssm2602_modinit(void)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct ssm2602_setup_data *setup;
-	struct snd_soc_codec *codec;
-	struct ssm2602_priv *ssm2602;
 	int ret = 0;
-
-	pr_info("ssm2602 Audio Codec %s", SSM2602_VERSION);
-
-	setup = socdev->codec_data;
-	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (codec == NULL)
-		return -ENOMEM;
-
-	ssm2602 = kzalloc(sizeof(struct ssm2602_priv), GFP_KERNEL);
-	if (ssm2602 == NULL) {
-		kfree(codec);
-		return -ENOMEM;
-	}
-
-	snd_soc_codec_set_drvdata(codec, ssm2602);
-	socdev->card->codec = codec;
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	ssm2602_socdev = socdev;
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	if (setup->i2c_address) {
-		codec->hw_write = (hw_write_t)i2c_master_send;
-		ret = ssm2602_add_i2c_device(pdev, setup);
+	ret = i2c_add_driver(&ssm2602_i2c_driver);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register SSM2602 I2C driver: %d\n",
+		       ret);
 	}
-#else
-	/* other interfaces */
 #endif
 	return ret;
 }
+module_init(ssm2602_modinit);
 
-/* remove everything here */
-static int ssm2602_remove(struct platform_device *pdev)
+static void __exit ssm2602_exit(void)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	if (codec->control_data)
-		ssm2602_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
-	i2c_unregister_device(codec->control_data);
 	i2c_del_driver(&ssm2602_i2c_driver);
 #endif
-	kfree(snd_soc_codec_get_drvdata(codec));
-	kfree(codec);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_ssm2602 = {
-	.probe = 	ssm2602_probe,
-	.remove = 	ssm2602_remove,
-	.suspend = 	ssm2602_suspend,
-	.resume =	ssm2602_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_ssm2602);
-
-static int __init ssm2602_modinit(void)
-{
-	return snd_soc_register_dai(&ssm2602_dai);
-}
-module_init(ssm2602_modinit);
-
-static void __exit ssm2602_exit(void)
-{
-	snd_soc_unregister_dai(&ssm2602_dai);
 }
 module_exit(ssm2602_exit);
 
diff --git a/sound/soc/codecs/ssm2602.h b/sound/soc/codecs/ssm2602.h
index f344e6d..42a47d0 100644
--- a/sound/soc/codecs/ssm2602.h
+++ b/sound/soc/codecs/ssm2602.h
@@ -124,7 +124,4 @@ struct ssm2602_setup_data {
 	unsigned short i2c_address;
 };
 
-extern struct snd_soc_dai ssm2602_dai;
-extern struct snd_soc_codec_device soc_codec_dev_ssm2602;
-
 #endif
diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index 2f925a2..1a51c81 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -33,11 +33,9 @@
 
 #include "uda1380.h"
 
-static struct snd_soc_codec *uda1380_codec;
-
 /* codec private data */
 struct uda1380_priv {
-	struct snd_soc_codec codec;
+	struct snd_soc_codec *codec;
 	u16 reg_cache[UDA1380_CACHEREGNUM];
 	unsigned int dac_clk;
 	struct work_struct work;
@@ -135,6 +133,8 @@ static int uda1380_write(struct snd_soc_codec *codec, unsigned int reg,
 
 static void uda1380_flush_work(struct work_struct *work)
 {
+	struct uda1380_priv *uda1380 = container_of(work, struct uda1380_priv, work);
+	struct snd_soc_codec *uda1380_codec = uda1380->codec;
 	int bit, reg;
 
 	for_each_set_bit(bit, &uda1380_cache_dirty, UDA1380_CACHEREGNUM - 0x10) {
@@ -145,6 +145,7 @@ static void uda1380_flush_work(struct work_struct *work)
 				uda1380_read_reg_cache(uda1380_codec, reg));
 		clear_bit(bit, &uda1380_cache_dirty);
 	}
+
 }
 
 /* declarations of ALSA reg_elem_REAL controls */
@@ -474,8 +475,7 @@ static int uda1380_trigger(struct snd_pcm_substream *substream, int cmd,
 		struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct uda1380_priv *uda1380 = snd_soc_codec_get_drvdata(codec);
 	int mixer = uda1380_read_reg_cache(codec, UDA1380_MIXER);
 
@@ -501,8 +501,7 @@ static int uda1380_pcm_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	u16 clk = uda1380_read_reg_cache(codec, UDA1380_CLK);
 
 	/* set WSPLL power and divider if running from this clock */
@@ -540,8 +539,7 @@ static void uda1380_pcm_shutdown(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	u16 clk = uda1380_read_reg_cache(codec, UDA1380_CLK);
 
 	/* shut down WSPLL power if running from this clock */
@@ -604,9 +602,9 @@ static struct snd_soc_dai_ops uda1380_dai_ops_capture = {
 	.set_fmt	= uda1380_set_dai_fmt_capture,
 };
 
-struct snd_soc_dai uda1380_dai[] = {
+static struct snd_soc_dai_driver uda1380_dai[] = {
 {
-	.name = "UDA1380",
+	.name = "uda1380-hifi",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
@@ -622,7 +620,7 @@ struct snd_soc_dai uda1380_dai[] = {
 	.ops = &uda1380_dai_ops,
 },
 { /* playback only - dual interface */
-	.name = "UDA1380",
+	.name = "uda1380-hifi-playback",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
@@ -633,7 +631,7 @@ struct snd_soc_dai uda1380_dai[] = {
 	.ops = &uda1380_dai_ops_playback,
 },
 { /* capture only - dual interface*/
-	.name = "UDA1380",
+	.name = "uda1380-hifi-capture",
 	.capture = {
 		.stream_name = "Capture",
 		.channels_min = 1,
@@ -644,21 +642,15 @@ struct snd_soc_dai uda1380_dai[] = {
 	.ops = &uda1380_dai_ops_capture,
 },
 };
-EXPORT_SYMBOL_GPL(uda1380_dai);
 
-static int uda1380_suspend(struct platform_device *pdev, pm_message_t state)
+static int uda1380_suspend(struct snd_soc_codec *codec, pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	uda1380_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-static int uda1380_resume(struct platform_device *pdev)
+static int uda1380_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	int i;
 	u8 data[2];
 	u16 *cache = codec->reg_cache;
@@ -673,91 +665,20 @@ static int uda1380_resume(struct platform_device *pdev)
 	return 0;
 }
 
-static int uda1380_probe(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	struct uda1380_platform_data *pdata;
-	int ret = 0;
-
-	if (uda1380_codec == NULL) {
-		dev_err(&pdev->dev, "Codec device not registered\n");
-		return -ENODEV;
-	}
-
-	socdev->card->codec = uda1380_codec;
-	codec = uda1380_codec;
-	pdata = codec->dev->platform_data;
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
-		goto pcm_err;
-	}
-
-	/* power on device */
-	uda1380_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	/* set clock input */
-	switch (pdata->dac_clk) {
-	case UDA1380_DAC_CLK_SYSCLK:
-		uda1380_write(codec, UDA1380_CLK, 0);
-		break;
-	case UDA1380_DAC_CLK_WSPLL:
-		uda1380_write(codec, UDA1380_CLK, R00_DAC_CLK);
-		break;
-	}
-
-	snd_soc_add_controls(codec, uda1380_snd_controls,
-				ARRAY_SIZE(uda1380_snd_controls));
-	uda1380_add_widgets(codec);
-
-	return ret;
-
-pcm_err:
-	return ret;
-}
-
-/* power down chip */
-static int uda1380_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	if (codec->control_data)
-		uda1380_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
-	return 0;
-}
-
-struct snd_soc_codec_device soc_codec_dev_uda1380 = {
-	.probe = 	uda1380_probe,
-	.remove = 	uda1380_remove,
-	.suspend = 	uda1380_suspend,
-	.resume =	uda1380_resume,
-};
-EXPORT_SYMBOL_GPL(soc_codec_dev_uda1380);
-
-static int uda1380_register(struct uda1380_priv *uda1380)
+static int uda1380_probe(struct snd_soc_codec *codec)
 {
-	int ret, i;
-	struct snd_soc_codec *codec = &uda1380->codec;
-	struct uda1380_platform_data *pdata = codec->dev->platform_data;
+	struct uda1380_platform_data *pdata =codec->dev->platform_data;
+	struct uda1380_priv *uda1380 = snd_soc_codec_get_drvdata(codec);
+	int ret;
 
-	if (uda1380_codec) {
-		dev_err(codec->dev, "Another UDA1380 is registered\n");
-		return -EINVAL;
-	}
+	codec->hw_write = (hw_write_t)i2c_master_send;
 
 	if (!pdata || !pdata->gpio_power || !pdata->gpio_reset)
 		return -EINVAL;
 
 	ret = gpio_request(pdata->gpio_power, "uda1380 power");
 	if (ret)
-		goto err_out;
+		return ret;
 	ret = gpio_request(pdata->gpio_reset, "uda1380 reset");
 	if (ret)
 		goto err_gpio;
@@ -769,25 +690,6 @@ static int uda1380_register(struct uda1380_priv *uda1380)
 	udelay(5);
 	gpio_set_value(pdata->gpio_reset, 0);
 
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	snd_soc_codec_set_drvdata(codec, uda1380);
-	codec->name = "UDA1380";
-	codec->owner = THIS_MODULE;
-	codec->read = uda1380_read_reg_cache;
-	codec->write = uda1380_write;
-	codec->bias_level = SND_SOC_BIAS_OFF;
-	codec->set_bias_level = uda1380_set_bias_level;
-	codec->dai = uda1380_dai;
-	codec->num_dai = ARRAY_SIZE(uda1380_dai);
-	codec->reg_cache_size = ARRAY_SIZE(uda1380_reg);
-	codec->reg_cache = &uda1380->reg_cache;
-	codec->reg_cache_step = 1;
-
-	memcpy(codec->reg_cache, uda1380_reg, sizeof(uda1380_reg));
-
 	ret = uda1380_reset(codec);
 	if (ret < 0) {
 		dev_err(codec->dev, "Failed to issue reset\n");
@@ -796,83 +698,84 @@ static int uda1380_register(struct uda1380_priv *uda1380)
 
 	INIT_WORK(&uda1380->work, uda1380_flush_work);
 
-	for (i = 0; i < ARRAY_SIZE(uda1380_dai); i++)
-		uda1380_dai[i].dev = codec->dev;
-
-	uda1380_codec = codec;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto err_reset;
+	/* power on device */
+	uda1380_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
+	/* set clock input */
+	switch (pdata->dac_clk) {
+	case UDA1380_DAC_CLK_SYSCLK:
+		uda1380_write(codec, UDA1380_CLK, 0);
+		break;
+	case UDA1380_DAC_CLK_WSPLL:
+		uda1380_write(codec, UDA1380_CLK, R00_DAC_CLK);
+		break;
 	}
 
-	ret = snd_soc_register_dais(uda1380_dai, ARRAY_SIZE(uda1380_dai));
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register DAIs: %d\n", ret);
-		goto err_dai;
-	}
+	snd_soc_add_controls(codec, uda1380_snd_controls,
+				ARRAY_SIZE(uda1380_snd_controls));
+	uda1380_add_widgets(codec);
 
 	return 0;
 
-err_dai:
-	snd_soc_unregister_codec(codec);
 err_reset:
 	gpio_set_value(pdata->gpio_power, 0);
 	gpio_free(pdata->gpio_reset);
 err_gpio:
 	gpio_free(pdata->gpio_power);
-err_out:
 	return ret;
 }
 
-static void uda1380_unregister(struct uda1380_priv *uda1380)
+/* power down chip */
+static int uda1380_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_codec *codec = &uda1380->codec;
-	struct uda1380_platform_data *pdata = codec->dev->platform_data;
+	struct uda1380_platform_data *pdata =codec->dev->platform_data;
 
-	snd_soc_unregister_dais(uda1380_dai, ARRAY_SIZE(uda1380_dai));
-	snd_soc_unregister_codec(&uda1380->codec);
+	uda1380_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	gpio_set_value(pdata->gpio_power, 0);
 	gpio_free(pdata->gpio_reset);
 	gpio_free(pdata->gpio_power);
 
-	kfree(uda1380);
-	uda1380_codec = NULL;
+	return 0;
 }
 
+static struct snd_soc_codec_driver soc_codec_dev_uda1380 = {
+	.probe =	uda1380_probe,
+	.remove =	uda1380_remove,
+	.suspend =	uda1380_suspend,
+	.resume =	uda1380_resume,
+	.read = uda1380_read_reg_cache,
+	.write = uda1380_write,
+	.set_bias_level = uda1380_set_bias_level,
+	.reg_cache_size = ARRAY_SIZE(uda1380_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_default = uda1380_reg,
+	.reg_cache_step = 1,
+};
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static __devinit int uda1380_i2c_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *id)
 {
 	struct uda1380_priv *uda1380;
-	struct snd_soc_codec *codec;
 	int ret;
 
 	uda1380 = kzalloc(sizeof(struct uda1380_priv), GFP_KERNEL);
 	if (uda1380 == NULL)
 		return -ENOMEM;
 
-	codec = &uda1380->codec;
-	codec->hw_write = (hw_write_t)i2c_master_send;
-
 	i2c_set_clientdata(i2c, uda1380);
-	codec->control_data = i2c;
-
-	codec->dev = &i2c->dev;
 
-	ret = uda1380_register(uda1380);
-	if (ret != 0)
+	ret =  snd_soc_register_codec(&i2c->dev,
+			&soc_codec_dev_uda1380, uda1380_dai, ARRAY_SIZE(uda1380_dai));
+	if (ret < 0)
 		kfree(uda1380);
-
 	return ret;
 }
 
 static int __devexit uda1380_i2c_remove(struct i2c_client *i2c)
 {
-	struct uda1380_priv *uda1380 = i2c_get_clientdata(i2c);
-	uda1380_unregister(uda1380);
+	snd_soc_unregister_codec(&i2c->dev);
+	kfree(i2c_get_clientdata(i2c));
 	return 0;
 }
 
@@ -884,7 +787,7 @@ MODULE_DEVICE_TABLE(i2c, uda1380_i2c_id);
 
 static struct i2c_driver uda1380_i2c_driver = {
 	.driver = {
-		.name =  "UDA1380 I2C Codec",
+		.name =  "uda1380-codec",
 		.owner = THIS_MODULE,
 	},
 	.probe =    uda1380_i2c_probe,
diff --git a/sound/soc/codecs/uda1380.h b/sound/soc/codecs/uda1380.h
index 9cefa8a..942e392 100644
--- a/sound/soc/codecs/uda1380.h
+++ b/sound/soc/codecs/uda1380.h
@@ -76,7 +76,4 @@
 #define UDA1380_DAI_PLAYBACK	1 /* playback DAI */
 #define UDA1380_DAI_CAPTURE	2 /* capture DAI */
 
-extern struct snd_soc_dai uda1380_dai[3];
-extern struct snd_soc_codec_device soc_codec_dev_uda1380;
-
 #endif /* _UDA1380_H */
-- 
1.7.0.4
