From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 16/17] ASoC: multi-component - Wolfson WM97xx
	AC97 CODECs
Date: Wed, 11 Aug 2010 00:03:07 +0100
Message-ID: <1281481388-3000-17-git-send-email-lrg@slimlogic.co.uk>
References: <1281481388-3000-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BDF53103849
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 01:04:00 +0200 (CEST)
Received: by mail-ww0-f51.google.com with SMTP id 36so2366031wwa.20
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2010 16:04:00 -0700 (PDT)
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

Move Wolfson WM97xx AC97 CODECs to multi-component model.

This patch changes the probe() and remove() of the CODEC drivers as follows:-

 o Make CODEC driver a platform driver
 o Moved all struct snd_soc_codec list, mutex, etc initialiasation to core.
 o Removed all static codec pointers (drivers now support > 1 codec dev)
 o snd_soc_register_pcms() now done by core.
 o snd_soc_register_dai() folded into snd_soc_register_codec().
 o codec cache can now be malloc()ed by core.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/wm9705.c |  116 +++++++++++++++++-----------------------
 sound/soc/codecs/wm9705.h |    3 -
 sound/soc/codecs/wm9712.c |  124 ++++++++++++++++++-------------------------
 sound/soc/codecs/wm9712.h |    3 -
 sound/soc/codecs/wm9713.c |  131 +++++++++++++++++++-------------------------
 sound/soc/codecs/wm9713.h |    3 -
 6 files changed, 159 insertions(+), 221 deletions(-)

diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 8793341..e4d8f53 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -248,8 +248,7 @@ static int ac97_prepare(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	int reg;
 	u16 vra;
 
@@ -273,9 +272,9 @@ static struct snd_soc_dai_ops wm9705_dai_ops = {
 	.prepare	= ac97_prepare,
 };
 
-struct snd_soc_dai wm9705_dai[] = {
+static struct snd_soc_dai_driver wm9705_dai[] = {
 	{
-		.name = "AC97 HiFi",
+		.name = "wm9705-hifi",
 		.ac97_control = 1,
 		.playback = {
 			.stream_name = "HiFi Playback",
@@ -294,7 +293,7 @@ struct snd_soc_dai wm9705_dai[] = {
 		.ops = &wm9705_dai_ops,
 	},
 	{
-		.name = "AC97 Aux",
+		.name = "wm9705-aux",
 		.playback = {
 			.stream_name = "Aux Playback",
 			.channels_min = 1,
@@ -304,7 +303,6 @@ struct snd_soc_dai wm9705_dai[] = {
 		},
 	}
 };
-EXPORT_SYMBOL_GPL(wm9705_dai);
 
 static int wm9705_reset(struct snd_soc_codec *codec)
 {
@@ -318,20 +316,15 @@ static int wm9705_reset(struct snd_soc_codec *codec)
 }
 
 #ifdef CONFIG_PM
-static int wm9705_soc_suspend(struct platform_device *pdev, pm_message_t msg)
+static int wm9705_soc_suspend(struct snd_soc_codec *codec, pm_message_t msg)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	soc_ac97_ops.write(codec->ac97, AC97_POWERDOWN, 0xffff);
 
 	return 0;
 }
 
-static int wm9705_soc_resume(struct platform_device *pdev)
+static int wm9705_soc_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	int i, ret;
 	u16 *cache = codec->reg_cache;
 
@@ -352,49 +345,18 @@ static int wm9705_soc_resume(struct platform_device *pdev)
 #define wm9705_soc_resume NULL
 #endif
 
-static int wm9705_soc_probe(struct platform_device *pdev)
+static int wm9705_soc_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
 	int ret = 0;
 
 	printk(KERN_INFO "WM9705 SoC Audio Codec\n");
 
-	socdev->card->codec = kzalloc(sizeof(struct snd_soc_codec),
-				      GFP_KERNEL);
-	if (socdev->card->codec == NULL)
-		return -ENOMEM;
-	codec = socdev->card->codec;
-	mutex_init(&codec->mutex);
-
-	codec->reg_cache = kmemdup(wm9705_reg, sizeof(wm9705_reg), GFP_KERNEL);
-	if (codec->reg_cache == NULL) {
-		ret = -ENOMEM;
-		goto cache_err;
-	}
-	codec->reg_cache_size = sizeof(wm9705_reg);
-	codec->reg_cache_step = 2;
-
-	codec->name = "WM9705";
-	codec->owner = THIS_MODULE;
-	codec->dai = wm9705_dai;
-	codec->num_dai = ARRAY_SIZE(wm9705_dai);
-	codec->write = ac97_write;
-	codec->read = ac97_read;
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
 	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
 	if (ret < 0) {
 		printk(KERN_ERR "wm9705: failed to register AC97 codec\n");
-		goto codec_err;
+		return ret;
 	}
 
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0)
-		goto pcm_err;
-
 	ret = wm9705_reset(codec);
 	if (ret)
 		goto reset_err;
@@ -406,40 +368,62 @@ static int wm9705_soc_probe(struct platform_device *pdev)
 	return 0;
 
 reset_err:
-	snd_soc_free_pcms(socdev);
-pcm_err:
 	snd_soc_free_ac97_codec(codec);
-codec_err:
-	kfree(codec->reg_cache);
-cache_err:
-	kfree(socdev->card->codec);
-	socdev->card->codec = NULL;
 	return ret;
 }
 
-static int wm9705_soc_remove(struct platform_device *pdev)
+static int wm9705_soc_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	if (codec == NULL)
-		return 0;
-
-	snd_soc_dapm_free(socdev);
-	snd_soc_free_pcms(socdev);
 	snd_soc_free_ac97_codec(codec);
-	kfree(codec->reg_cache);
-	kfree(codec);
 	return 0;
 }
 
-struct snd_soc_codec_device soc_codec_dev_wm9705 = {
+static struct snd_soc_codec_driver soc_codec_dev_wm9705 = {
 	.probe = 	wm9705_soc_probe,
 	.remove = 	wm9705_soc_remove,
 	.suspend =	wm9705_soc_suspend,
 	.resume =	wm9705_soc_resume,
+	.read = ac97_read,
+	.write = ac97_write,
+	.reg_cache_size = sizeof(wm9705_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_step = 2,
+	.reg_cache_default = wm9705_reg,
+};
+
+static __devinit int wm9705_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev,
+			&soc_codec_dev_wm9705, wm9705_dai, ARRAY_SIZE(wm9705_dai));
+}
+
+static int __devexit wm9705_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver wm9705_codec_driver = {
+	.driver = {
+			.name = "wm9705-codec",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = wm9705_probe,
+	.remove = __devexit_p(wm9705_remove),
 };
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm9705);
+
+static int __init wm9705_init(void)
+{
+	return platform_driver_register(&wm9705_codec_driver);
+}
+module_init(wm9705_init);
+
+static void __exit wm9705_exit(void)
+{
+	platform_driver_unregister(&wm9705_codec_driver);
+}
+module_exit(wm9705_exit);
 
 MODULE_DESCRIPTION("ASoC WM9705 driver");
 MODULE_AUTHOR("Ian Molton");
diff --git a/sound/soc/codecs/wm9705.h b/sound/soc/codecs/wm9705.h
index d380f11..23ea9ce 100644
--- a/sound/soc/codecs/wm9705.h
+++ b/sound/soc/codecs/wm9705.h
@@ -8,7 +8,4 @@
 #define WM9705_DAI_AC97_HIFI	0
 #define WM9705_DAI_AC97_AUX	1
 
-extern struct snd_soc_dai wm9705_dai[2];
-extern struct snd_soc_codec_device soc_codec_dev_wm9705;
-
 #endif
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 28790a2..f8f37ae 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -478,8 +478,7 @@ static int ac97_prepare(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec =rtd->codec;
 	int reg;
 	u16 vra;
 
@@ -499,8 +498,7 @@ static int ac97_aux_prepare(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	u16 vra, xsle;
 
 	vra = ac97_read(codec, AC97_EXTENDED_STATUS);
@@ -526,9 +524,9 @@ static struct snd_soc_dai_ops wm9712_dai_ops_aux = {
 	.prepare	= ac97_aux_prepare,
 };
 
-struct snd_soc_dai wm9712_dai[] = {
+struct snd_soc_dai_driver wm9712_dai[] = {
 {
-	.name = "AC97 HiFi",
+	.name = "wm9712-hifi",
 	.ac97_control = 1,
 	.playback = {
 		.stream_name = "HiFi Playback",
@@ -545,7 +543,7 @@ struct snd_soc_dai wm9712_dai[] = {
 	.ops = &wm9712_dai_ops_hifi,
 },
 {
-	.name = "AC97 Aux",
+	.name = "wm9712-aux",
 	.playback = {
 		.stream_name = "Aux Playback",
 		.channels_min = 1,
@@ -555,7 +553,6 @@ struct snd_soc_dai wm9712_dai[] = {
 	.ops = &wm9712_dai_ops_aux,
 }
 };
-EXPORT_SYMBOL_GPL(wm9712_dai);
 
 static int wm9712_set_bias_level(struct snd_soc_codec *codec,
 				 enum snd_soc_bias_level level)
@@ -597,20 +594,15 @@ err:
 	return -EIO;
 }
 
-static int wm9712_soc_suspend(struct platform_device *pdev,
+static int wm9712_soc_suspend(struct snd_soc_codec *codec,
 	pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	wm9712_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-static int wm9712_soc_resume(struct platform_device *pdev)
+static int wm9712_soc_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	int i, ret;
 	u16 *cache = codec->reg_cache;
 
@@ -635,51 +627,18 @@ static int wm9712_soc_resume(struct platform_device *pdev)
 	return ret;
 }
 
-static int wm9712_soc_probe(struct platform_device *pdev)
+static int wm9712_soc_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
 	int ret = 0;
 
 	printk(KERN_INFO "WM9711/WM9712 SoC Audio Codec %s\n", WM9712_VERSION);
 
-	socdev->card->codec = kzalloc(sizeof(struct snd_soc_codec),
-				      GFP_KERNEL);
-	if (socdev->card->codec == NULL)
-		return -ENOMEM;
-	codec = socdev->card->codec;
-	mutex_init(&codec->mutex);
-
-	codec->reg_cache = kmemdup(wm9712_reg, sizeof(wm9712_reg), GFP_KERNEL);
-
-	if (codec->reg_cache == NULL) {
-		ret = -ENOMEM;
-		goto cache_err;
-	}
-	codec->reg_cache_size = sizeof(wm9712_reg);
-	codec->reg_cache_step = 2;
-
-	codec->name = "WM9712";
-	codec->owner = THIS_MODULE;
-	codec->dai = wm9712_dai;
-	codec->num_dai = ARRAY_SIZE(wm9712_dai);
-	codec->write = ac97_write;
-	codec->read = ac97_read;
-	codec->set_bias_level = wm9712_set_bias_level;
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
 	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
 	if (ret < 0) {
 		printk(KERN_ERR "wm9712: failed to register AC97 codec\n");
-		goto codec_err;
+		return ret;
 	}
 
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0)
-		goto pcm_err;
-
 	ret = wm9712_reset(codec, 0);
 	if (ret < 0) {
 		printk(KERN_ERR "Failed to reset WM9712: AC97 link error\n");
@@ -697,42 +656,63 @@ static int wm9712_soc_probe(struct platform_device *pdev)
 	return 0;
 
 reset_err:
-	snd_soc_free_pcms(socdev);
-pcm_err:
 	snd_soc_free_ac97_codec(codec);
-
-codec_err:
-	kfree(codec->reg_cache);
-
-cache_err:
-	kfree(socdev->card->codec);
-	socdev->card->codec = NULL;
 	return ret;
 }
 
-static int wm9712_soc_remove(struct platform_device *pdev)
+static int wm9712_soc_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	if (codec == NULL)
-		return 0;
-
-	snd_soc_dapm_free(socdev);
-	snd_soc_free_pcms(socdev);
 	snd_soc_free_ac97_codec(codec);
-	kfree(codec->reg_cache);
-	kfree(codec);
 	return 0;
 }
 
-struct snd_soc_codec_device soc_codec_dev_wm9712 = {
+static struct snd_soc_codec_driver soc_codec_dev_wm9712 = {
 	.probe = 	wm9712_soc_probe,
 	.remove = 	wm9712_soc_remove,
 	.suspend =	wm9712_soc_suspend,
 	.resume =	wm9712_soc_resume,
+	.read = ac97_read,
+	.write = ac97_write,
+	.set_bias_level = wm9712_set_bias_level,
+	.reg_cache_size = sizeof(wm9712_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_step = 2,
+	.reg_cache_default = wm9712_reg,
 };
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm9712);
+
+static __devinit int wm9712_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev,
+			&soc_codec_dev_wm9712, wm9712_dai, ARRAY_SIZE(wm9712_dai));
+}
+
+static int __devexit wm9712_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver wm9712_codec_driver = {
+	.driver = {
+			.name = "wm9712-codec",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = wm9712_probe,
+	.remove = __devexit_p(wm9712_remove),
+};
+
+static int __init wm9712_init(void)
+{
+	return platform_driver_register(&wm9712_codec_driver);
+}
+module_init(wm9712_init);
+
+static void __exit wm9712_exit(void)
+{
+	platform_driver_unregister(&wm9712_codec_driver);
+}
+module_exit(wm9712_exit);
 
 MODULE_DESCRIPTION("ASoC WM9711/WM9712 driver");
 MODULE_AUTHOR("Liam Girdwood");
diff --git a/sound/soc/codecs/wm9712.h b/sound/soc/codecs/wm9712.h
index d29e8a1..fb69c3a 100644
--- a/sound/soc/codecs/wm9712.h
+++ b/sound/soc/codecs/wm9712.h
@@ -8,7 +8,4 @@
 #define WM9712_DAI_AC97_HIFI	0
 #define WM9712_DAI_AC97_AUX		1
 
-extern struct snd_soc_dai wm9712_dai[2];
-extern struct snd_soc_codec_device soc_codec_dev_wm9712;
-
 #endif
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 34e0c91..463917e 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1057,9 +1057,9 @@ static struct snd_soc_dai_ops wm9713_dai_ops_voice = {
 	.set_tristate	= wm9713_set_dai_tristate,
 };
 
-struct snd_soc_dai wm9713_dai[] = {
+static struct snd_soc_dai_driver wm9713_dai[] = {
 {
-	.name = "AC97 HiFi",
+	.name = "wm9713-hifi",
 	.ac97_control = 1,
 	.playback = {
 		.stream_name = "HiFi Playback",
@@ -1076,7 +1076,7 @@ struct snd_soc_dai wm9713_dai[] = {
 	.ops = &wm9713_dai_ops_hifi,
 	},
 	{
-	.name = "AC97 Aux",
+	.name = "wm9713-aux",
 	.playback = {
 		.stream_name = "Aux Playback",
 		.channels_min = 1,
@@ -1086,7 +1086,7 @@ struct snd_soc_dai wm9713_dai[] = {
 	.ops = &wm9713_dai_ops_aux,
 	},
 	{
-	.name = "WM9713 Voice",
+	.name = "wm9713-voice",
 	.playback = {
 		.stream_name = "Voice Playback",
 		.channels_min = 1,
@@ -1103,7 +1103,6 @@ struct snd_soc_dai wm9713_dai[] = {
 	.symmetric_rates = 1,
 	},
 };
-EXPORT_SYMBOL_GPL(wm9713_dai);
 
 int wm9713_reset(struct snd_soc_codec *codec, int try_warm)
 {
@@ -1152,11 +1151,9 @@ static int wm9713_set_bias_level(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int wm9713_soc_suspend(struct platform_device *pdev,
+static int wm9713_soc_suspend(struct snd_soc_codec *codec,
 	pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	u16 reg;
 
 	/* Disable everything except touchpanel - that will be handled
@@ -1171,10 +1168,8 @@ static int wm9713_soc_suspend(struct platform_device *pdev,
 	return 0;
 }
 
-static int wm9713_soc_resume(struct platform_device *pdev)
+static int wm9713_soc_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
 	int i, ret;
 	u16 *cache = codec->reg_cache;
@@ -1204,53 +1199,20 @@ static int wm9713_soc_resume(struct platform_device *pdev)
 	return ret;
 }
 
-static int wm9713_soc_probe(struct platform_device *pdev)
+static int wm9713_soc_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
+	struct wm9713_priv *wm9713;
 	int ret = 0, reg;
 
-	socdev->card->codec = kzalloc(sizeof(struct snd_soc_codec),
-				      GFP_KERNEL);
-	if (socdev->card->codec == NULL)
+	wm9713 = kzalloc(sizeof(struct wm9713_priv), GFP_KERNEL);
+	if (wm9713 == NULL)
 		return -ENOMEM;
-	codec = socdev->card->codec;
-	mutex_init(&codec->mutex);
-
-	codec->reg_cache = kmemdup(wm9713_reg, sizeof(wm9713_reg), GFP_KERNEL);
-	if (codec->reg_cache == NULL) {
-		ret = -ENOMEM;
-		goto cache_err;
-	}
-	codec->reg_cache_size = sizeof(wm9713_reg);
-	codec->reg_cache_step = 2;
-
-	snd_soc_codec_set_drvdata(codec, kzalloc(sizeof(struct wm9713_priv),
-						 GFP_KERNEL));
-	if (snd_soc_codec_get_drvdata(codec) == NULL) {
-		ret = -ENOMEM;
-		goto priv_err;
-	}
-
-	codec->name = "WM9713";
-	codec->owner = THIS_MODULE;
-	codec->dai = wm9713_dai;
-	codec->num_dai = ARRAY_SIZE(wm9713_dai);
-	codec->write = ac97_write;
-	codec->read = ac97_read;
-	codec->set_bias_level = wm9713_set_bias_level;
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
+	snd_soc_codec_set_drvdata(codec, wm9713);
 
 	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
 	if (ret < 0)
 		goto codec_err;
 
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0)
-		goto pcm_err;
-
 	/* do a cold reset for the controller and then try
 	 * a warm reset followed by an optional cold reset for codec */
 	wm9713_reset(codec, 0);
@@ -1273,46 +1235,67 @@ static int wm9713_soc_probe(struct platform_device *pdev)
 	return 0;
 
 reset_err:
-	snd_soc_free_pcms(socdev);
-pcm_err:
 	snd_soc_free_ac97_codec(codec);
-
 codec_err:
-	kfree(snd_soc_codec_get_drvdata(codec));
-
-priv_err:
-	kfree(codec->reg_cache);
-
-cache_err:
-	kfree(socdev->card->codec);
-	socdev->card->codec = NULL;
+	kfree(wm9713);
 	return ret;
 }
 
-static int wm9713_soc_remove(struct platform_device *pdev)
+static int wm9713_soc_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	if (codec == NULL)
-		return 0;
-
-	snd_soc_dapm_free(socdev);
-	snd_soc_free_pcms(socdev);
+	struct wm9713_priv *wm9713 = snd_soc_codec_get_drvdata(codec);
 	snd_soc_free_ac97_codec(codec);
-	kfree(snd_soc_codec_get_drvdata(codec));
-	kfree(codec->reg_cache);
-	kfree(codec);
+	kfree(wm9713);
 	return 0;
 }
 
-struct snd_soc_codec_device soc_codec_dev_wm9713 = {
+static struct snd_soc_codec_driver soc_codec_dev_wm9713 = {
 	.probe = 	wm9713_soc_probe,
 	.remove = 	wm9713_soc_remove,
 	.suspend =	wm9713_soc_suspend,
 	.resume = 	wm9713_soc_resume,
+	.read = ac97_read,
+	.write = ac97_write,
+	.set_bias_level = wm9713_set_bias_level,
+	.reg_cache_size = sizeof(wm9713_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_step = 2,
+	.reg_cache_default = wm9713_reg,
+};
+
+static __devinit int wm9713_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev,
+			&soc_codec_dev_wm9713, wm9713_dai, ARRAY_SIZE(wm9713_dai));
+}
+
+static int __devexit wm9713_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver wm9713_codec_driver = {
+	.driver = {
+			.name = "wm9713-codec",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = wm9713_probe,
+	.remove = __devexit_p(wm9713_remove),
 };
-EXPORT_SYMBOL_GPL(soc_codec_dev_wm9713);
+
+static int __init wm9713_init(void)
+{
+	return platform_driver_register(&wm9713_codec_driver);
+}
+module_init(wm9713_init);
+
+static void __exit wm9713_exit(void)
+{
+	platform_driver_unregister(&wm9713_codec_driver);
+}
+module_exit(wm9713_exit);
 
 MODULE_DESCRIPTION("ASoC WM9713/WM9714 driver");
 MODULE_AUTHOR("Liam Girdwood");
diff --git a/sound/soc/codecs/wm9713.h b/sound/soc/codecs/wm9713.h
index 63b8d81..793da86 100644
--- a/sound/soc/codecs/wm9713.h
+++ b/sound/soc/codecs/wm9713.h
@@ -45,9 +45,6 @@
 #define WM9713_DAI_AC97_AUX		1
 #define WM9713_DAI_PCM_VOICE	2
 
-extern struct snd_soc_codec_device soc_codec_dev_wm9713;
-extern struct snd_soc_dai wm9713_dai[3];
-
 int wm9713_reset(struct snd_soc_codec *codec,  int try_warm);
 
 #endif
-- 
1.7.0.4
