From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 16/16] ASoC: multi-component - Wolfson WM97xx
	AC97 CODECs
Date: Fri, 25 Jun 2010 18:53:03 +0100
Message-ID: <1277488383-31287-17-git-send-email-lrg@slimlogic.co.uk>
References: <1277488383-31287-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 50371103821
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 19:53:41 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 23so166806wyf.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2010 10:53:41 -0700 (PDT)
In-Reply-To: <1277488383-31287-1-git-send-email-lrg@slimlogic.co.uk>
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

 o Make CODEC driver a platform device (non MFD codecs only)
 o Moved all struct snd_soc_codec list, mutex, etc initialiasation to core.
 o Removed all static codec pointers (drivers now support > 1 codec dev)
 o snd_soc_register_pcms() now done by core.
 o snd_soc_register_dai() folded into snd_soc_register_codec().
 o codec cache can now be malloc()ed by core.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/wm9705.c |  114 ++++++++++++++++++-----------------------
 sound/soc/codecs/wm9705.h |    4 +-
 sound/soc/codecs/wm9712.c |  122 +++++++++++++++++++-------------------------
 sound/soc/codecs/wm9712.h |    4 +-
 sound/soc/codecs/wm9713.c |  125 ++++++++++++++++++++-------------------------
 sound/soc/codecs/wm9713.h |    4 +-
 6 files changed, 166 insertions(+), 207 deletions(-)

diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 8793341..17df388 100644
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
 
@@ -273,7 +272,7 @@ static struct snd_soc_dai_ops wm9705_dai_ops = {
 	.prepare	= ac97_prepare,
 };
 
-struct snd_soc_dai wm9705_dai[] = {
+struct snd_soc_dai_driver wm9705_dai[] = {
 	{
 		.name = "AC97 HiFi",
 		.ac97_control = 1,
@@ -318,20 +317,15 @@ static int wm9705_reset(struct snd_soc_codec *codec)
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
 
@@ -352,49 +346,18 @@ static int wm9705_soc_resume(struct platform_device *pdev)
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
@@ -406,41 +369,66 @@ static int wm9705_soc_probe(struct platform_device *pdev)
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
+struct snd_soc_codec_driver soc_codec_dev_wm9705 = {
+	.name = "wm9705",
+	.owner = THIS_MODULE,
 	.probe = 	wm9705_soc_probe,
 	.remove = 	wm9705_soc_remove,
 	.suspend =	wm9705_soc_suspend,
-	.resume =	wm9705_soc_resume,
+	.resume = 	wm9705_soc_resume,
+	.read = ac97_read,
+	.write = ac97_write,
+	.reg_cache_size = sizeof(wm9705_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_step = 2,
+	.reg_cache_default = wm9705_reg,
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm9705);
 
+static __devinit int wm9705_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev, pdev->id,
+			&soc_codec_dev_wm9705, wm9705_dai, ARRAY_SIZE(wm9705_dai));
+}
+
+static int __devexit wm9705_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev, pdev->id);
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
+};
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
+
 MODULE_DESCRIPTION("ASoC WM9705 driver");
 MODULE_AUTHOR("Ian Molton");
 MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/wm9705.h b/sound/soc/codecs/wm9705.h
index d380f11..189249e 100644
--- a/sound/soc/codecs/wm9705.h
+++ b/sound/soc/codecs/wm9705.h
@@ -8,7 +8,7 @@
 #define WM9705_DAI_AC97_HIFI	0
 #define WM9705_DAI_AC97_AUX	1
 
-extern struct snd_soc_dai wm9705_dai[2];
-extern struct snd_soc_codec_device soc_codec_dev_wm9705;
+extern struct snd_soc_dai_driver wm9705_dai[2];
+extern struct snd_soc_codec_driver soc_codec_dev_wm9705;
 
 #endif
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 28790a2..2adb9d8 100644
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
@@ -526,7 +524,7 @@ static struct snd_soc_dai_ops wm9712_dai_ops_aux = {
 	.prepare	= ac97_aux_prepare,
 };
 
-struct snd_soc_dai wm9712_dai[] = {
+struct snd_soc_dai_driver wm9712_dai[] = {
 {
 	.name = "AC97 HiFi",
 	.ac97_control = 1,
@@ -597,20 +595,15 @@ err:
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
 
@@ -635,51 +628,18 @@ static int wm9712_soc_resume(struct platform_device *pdev)
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
@@ -697,43 +657,67 @@ static int wm9712_soc_probe(struct platform_device *pdev)
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
+struct snd_soc_codec_driver soc_codec_dev_wm9712 = {
+	.name = "wm9712",
+	.owner = THIS_MODULE,
 	.probe = 	wm9712_soc_probe,
 	.remove = 	wm9712_soc_remove,
 	.suspend =	wm9712_soc_suspend,
-	.resume =	wm9712_soc_resume,
+	.resume = 	wm9712_soc_resume,
+	.read = ac97_read,
+	.write = ac97_write,
+	.set_bias_level = wm9712_set_bias_level,
+	.reg_cache_size = sizeof(wm9712_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_step = 2,
+	.reg_cache_default = wm9712_reg,
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm9712);
 
+static __devinit int wm9712_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev, pdev->id,
+			&soc_codec_dev_wm9712, wm9712_dai, ARRAY_SIZE(wm9712_dai));
+}
+
+static int __devexit wm9712_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev, pdev->id);
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
+
 MODULE_DESCRIPTION("ASoC WM9711/WM9712 driver");
 MODULE_AUTHOR("Liam Girdwood");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm9712.h b/sound/soc/codecs/wm9712.h
index d29e8a1..a275bf7 100644
--- a/sound/soc/codecs/wm9712.h
+++ b/sound/soc/codecs/wm9712.h
@@ -8,7 +8,7 @@
 #define WM9712_DAI_AC97_HIFI	0
 #define WM9712_DAI_AC97_AUX		1
 
-extern struct snd_soc_dai wm9712_dai[2];
-extern struct snd_soc_codec_device soc_codec_dev_wm9712;
+extern struct snd_soc_dai_driver wm9712_dai[2];
+extern struct snd_soc_codec_driver soc_codec_dev_wm9712;
 
 #endif
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 34e0c91..44c6a9a 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1057,7 +1057,7 @@ static struct snd_soc_dai_ops wm9713_dai_ops_voice = {
 	.set_tristate	= wm9713_set_dai_tristate,
 };
 
-struct snd_soc_dai wm9713_dai[] = {
+struct snd_soc_dai_driver wm9713_dai[] = {
 {
 	.name = "AC97 HiFi",
 	.ac97_control = 1,
@@ -1152,11 +1152,9 @@ static int wm9713_set_bias_level(struct snd_soc_codec *codec,
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
@@ -1171,10 +1169,8 @@ static int wm9713_soc_suspend(struct platform_device *pdev,
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
@@ -1204,53 +1200,20 @@ static int wm9713_soc_resume(struct platform_device *pdev)
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
@@ -1273,47 +1236,71 @@ static int wm9713_soc_probe(struct platform_device *pdev)
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
+struct snd_soc_codec_driver soc_codec_dev_wm9713 = {
+	.name = "WM9713",
+	.owner = THIS_MODULE,
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
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm9713);
 
+static __devinit int wm9713_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev, pdev->id,
+			&soc_codec_dev_wm9713, wm9713_dai, ARRAY_SIZE(wm9713_dai));
+}
+
+static int __devexit wm9713_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev, pdev->id);
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
+};
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
+
 MODULE_DESCRIPTION("ASoC WM9713/WM9714 driver");
 MODULE_AUTHOR("Liam Girdwood");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/wm9713.h b/sound/soc/codecs/wm9713.h
index 63b8d81..0a38180 100644
--- a/sound/soc/codecs/wm9713.h
+++ b/sound/soc/codecs/wm9713.h
@@ -45,8 +45,8 @@
 #define WM9713_DAI_AC97_AUX		1
 #define WM9713_DAI_PCM_VOICE	2
 
-extern struct snd_soc_codec_device soc_codec_dev_wm9713;
-extern struct snd_soc_dai wm9713_dai[3];
+extern struct snd_soc_codec_driver soc_codec_dev_wm9713;
+extern struct snd_soc_dai_driver wm9713_dai[3];
 
 int wm9713_reset(struct snd_soc_codec *codec,  int try_warm);
 
-- 
1.7.0.4
