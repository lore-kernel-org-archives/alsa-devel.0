From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [RFC 07/16] ASoC: multi-component - cq93vc, cx20442,
	stac9766 and UDA134x CODECs
Date: Fri, 25 Jun 2010 18:52:54 +0100
Message-ID: <1277488383-31287-8-git-send-email-lrg@slimlogic.co.uk>
References: <1277488383-31287-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 86036103840
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 19:53:26 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 23so166806wyf.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2010 10:53:26 -0700 (PDT)
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

Move CODECs to multi-component model.

This patch changes the probe() and remove() of the CODEC drivers as follows:-

 o Make CODEC driver a platform device (non MFD codecs only)
 o Moved all struct snd_soc_codec list, mutex, etc initialiasation to core.
 o Removed all static codec pointers (drivers now support > 1 codec dev)
 o snd_soc_register_pcms() now done by core.
 o snd_soc_register_dai() folded into snd_soc_register_codec().
 o codec cache can now be malloc()ed by core.

Other required changes due to multi-component model :-

 o cx20442: tty hangup now performed in codec remove() rather than machine
  remove() since codec device is not now available at machine remove().

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/cq93vc.c   |  127 +++++++++-----------------------------
 sound/soc/codecs/cq93vc.h   |    4 +-
 sound/soc/codecs/cx20442.c  |  140 ++++++++++-------------------------------
 sound/soc/codecs/cx20442.h  |    4 +-
 sound/soc/codecs/stac9766.c |  113 +++++++++++++++------------------
 sound/soc/codecs/stac9766.h |    4 +-
 sound/soc/codecs/uda134x.c  |  146 +++++++++++++++++--------------------------
 sound/soc/codecs/uda134x.h  |    4 +-
 8 files changed, 178 insertions(+), 364 deletions(-)

diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index a320fb5..656869e 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -130,7 +130,7 @@ static struct snd_soc_dai_ops cq93vc_dai_ops = {
 	.set_sysclk	= cq93vc_set_dai_sysclk,
 };
 
-struct snd_soc_dai cq93vc_dai = {
+struct snd_soc_dai_driver cq93vc_dai = {
 	.name = "CQ93VC",
 	.playback = {
 		.stream_name = "Playback",
@@ -148,34 +148,19 @@ struct snd_soc_dai cq93vc_dai = {
 };
 EXPORT_SYMBOL_GPL(cq93vc_dai);
 
-static int cq93vc_resume(struct platform_device *pdev)
+static int cq93vc_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	cq93vc_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
 	return 0;
 }
 
-static struct snd_soc_codec *cq93vc_codec;
-
-static int cq93vc_probe(struct platform_device *pdev)
+static int cq93vc_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct device *dev = &pdev->dev;
-	struct snd_soc_codec *codec;
-	int ret;
-
-	socdev->card->codec = cq93vc_codec;
-	codec = socdev->card->codec;
-
-	/* Register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(dev, "%s: failed to create pcms\n", pdev->name);
-		return ret;
-	}
+	struct davinci_vc *davinci_vc = codec->dev->platform_data;
+
+	davinci_vc->cq93vc.codec = codec;
+	codec->control_data = davinci_vc;
 
 	/* Set controls */
 	snd_soc_add_controls(codec, cq93vc_snd_controls,
@@ -187,108 +172,54 @@ static int cq93vc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int cq93vc_remove(struct platform_device *pdev)
+static int cq93vc_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
+	cq93vc_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
 	return 0;
 }
 
-struct snd_soc_codec_device soc_codec_dev_cq93vc = {
+struct snd_soc_codec_driver soc_codec_dev_cq93vc = {
+	.name = "CQ93VC",
+	.owner = THIS_MODULE,
+	.read = cq93vc_read,
+	.write = cq93vc_write,
+	.set_bias_level = cq93vc_set_bias_level,
 	.probe = cq93vc_probe,
 	.remove = cq93vc_remove,
 	.resume = cq93vc_resume,
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_cq93vc);
 
-static __init int cq93vc_codec_probe(struct platform_device *pdev)
+static int cq93vc_platform_probe(struct platform_device *pdev)
 {
-	struct davinci_vc *davinci_vc = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret;
-
-	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (codec == NULL) {
-		dev_dbg(davinci_vc->dev,
-			"could not allocate memory for codec data\n");
-		return -ENOMEM;
-	}
-
-	davinci_vc->cq93vc.codec = codec;
-
-	cq93vc_dai.dev = &pdev->dev;
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-	codec->dev = &pdev->dev;
-	codec->name = "CQ93VC";
-	codec->owner = THIS_MODULE;
-	codec->read = cq93vc_read;
-	codec->write = cq93vc_write;
-	codec->set_bias_level = cq93vc_set_bias_level;
-	codec->dai = &cq93vc_dai;
-	codec->num_dai = 1;
-	codec->control_data = davinci_vc;
-
-	cq93vc_codec = codec;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret) {
-		dev_err(davinci_vc->dev, "failed to register codec\n");
-		goto fail1;
-	}
-
-	ret = snd_soc_register_dai(&cq93vc_dai);
-	if (ret) {
-		dev_err(davinci_vc->dev, "could register dai\n");
-		goto fail2;
-	}
-	return 0;
-
-fail2:
-	snd_soc_unregister_codec(codec);
-
-fail1:
-	kfree(codec);
-	cq93vc_codec = NULL;
-
-	return ret;
+	return snd_soc_register_codec(&pdev->dev, pdev->id,
+			&soc_codec_dev_cq93vc, &cq93vc_dai, 1);
 }
 
-static int __devexit cq93vc_codec_remove(struct platform_device *pdev)
+static int cq93vc_platform_remove(struct platform_device *pdev)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	snd_soc_unregister_dai(&cq93vc_dai);
-	snd_soc_unregister_codec(&codec);
-
-	kfree(codec);
-	cq93vc_codec = NULL;
-
+	snd_soc_unregister_codec(&pdev->dev, pdev->id);
 	return 0;
 }
 
 static struct platform_driver cq93vc_codec_driver = {
 	.driver = {
-		   .name = "cq93vc",
-		   .owner = THIS_MODULE,
-		   },
-	.probe = cq93vc_codec_probe,
-	.remove = __devexit_p(cq93vc_codec_remove),
+			.name = "cq93vc",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = cq93vc_platform_probe,
+	.remove = __devexit_p(cq93vc_platform_remove),
 };
 
-static __init int cq93vc_init(void)
+static int __init cq93vc_init(void)
 {
-	return platform_driver_probe(&cq93vc_codec_driver, cq93vc_codec_probe);
+	return platform_driver_register(&cq93vc_codec_driver);
 }
 module_init(cq93vc_init);
 
-static __exit void cq93vc_exit(void)
+static void __exit cq93vc_exit(void)
 {
 	platform_driver_unregister(&cq93vc_codec_driver);
 }
diff --git a/sound/soc/codecs/cq93vc.h b/sound/soc/codecs/cq93vc.h
index 845b196..77f9d3d 100644
--- a/sound/soc/codecs/cq93vc.h
+++ b/sound/soc/codecs/cq93vc.h
@@ -23,7 +23,7 @@
 #ifndef _CQ93VC_H
 #define _CQ93VC_H
 
-extern struct snd_soc_dai cq93vc_dai;
-extern struct snd_soc_codec_device soc_codec_dev_cq93vc;
+extern struct snd_soc_dai_driver cq93vc_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_cq93vc;
 
 #endif
diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index f07a415..5285452 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -24,7 +24,8 @@
 
 
 struct cx20442_priv {
-	struct snd_soc_codec codec;
+	enum snd_soc_control_type control_type;
+	void *control_data;
 	u8 reg_cache[1];
 };
 
@@ -102,7 +103,7 @@ static unsigned int cx20442_read_reg_cache(struct snd_soc_codec *codec,
 {
 	u8 *reg_cache = codec->reg_cache;
 
-	if (reg >= codec->reg_cache_size)
+	if (reg >= codec->driver->reg_cache_size)
 		return -EINVAL;
 
 	return reg_cache[reg];
@@ -168,7 +169,7 @@ static int cx20442_write(struct snd_soc_codec *codec, unsigned int reg,
 	int vls, vsp, old, len;
 	char buf[18];
 
-	if (reg >= codec->reg_cache_size)
+	if (reg >= codec->driver->reg_cache_size)
 		return -EINVAL;
 
 	/* hw_write and control_data pointers required for talking to the modem
@@ -313,7 +314,7 @@ EXPORT_SYMBOL_GPL(v253_ops);
  * Codec DAI
  */
 
-struct snd_soc_dai cx20442_dai = {
+struct snd_soc_dai_driver cx20442_dai = {
 	.name = "CX20442",
 	.playback = {
 		.stream_name = "Playback",
@@ -332,134 +333,59 @@ struct snd_soc_dai cx20442_dai = {
 };
 EXPORT_SYMBOL_GPL(cx20442_dai);
 
-static int cx20442_codec_probe(struct platform_device *pdev)
+static int cx20442_codec_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret;
-
-	if (!cx20442_codec) {
-		dev_err(&pdev->dev, "cx20442 not yet discovered\n");
-		return -ENODEV;
-	}
-	codec = cx20442_codec;
-
-	socdev->card->codec = codec;
+	struct cx20442_priv *cx20442;
 
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to create pcms\n");
-		goto pcm_err;
-	}
+	cx20442 = kzalloc(sizeof(struct cx20442_priv), GFP_KERNEL);
+	if (cx20442 == NULL)
+		return -ENOMEM;
+	snd_soc_codec_set_drvdata(codec, cx20442);
 
 	cx20442_add_widgets(codec);
 
-pcm_err:
-	return ret;
+	codec->control_data = NULL;
+	codec->hw_write = NULL;
+	codec->pop_time = 0;
+
+	return 0;
 }
 
 /* power down chip */
-static int cx20442_codec_remove(struct platform_device *pdev)
+static int cx20442_codec_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct cx20442_priv *cx20442 = snd_soc_codec_get_drvdata(codec);
 
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
+	if (codec->control_data) {
+			struct tty_struct *tty = codec->control_data;
+			tty_hangup(tty);
+	}
 
+	kfree(cx20442);
 	return 0;
 }
 
-struct snd_soc_codec_device cx20442_codec_dev = {
+struct snd_soc_codec_driver cx20442_codec_dev = {
+	.name = "CX20442",
+	.owner = THIS_MODULE,
 	.probe = 	cx20442_codec_probe,
 	.remove = 	cx20442_codec_remove,
+	.reg_cache_size = 1,
+	.reg_word_size = sizeof(u8),
+	.read = cx20442_read_reg_cache,
+	.write = cx20442_write,
 };
 EXPORT_SYMBOL_GPL(cx20442_codec_dev);
 
-static int cx20442_register(struct cx20442_priv *cx20442)
-{
-	struct snd_soc_codec *codec = &cx20442->codec;
-	int ret;
-
-	mutex_init(&codec->mutex);
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	codec->name = "CX20442";
-	codec->owner = THIS_MODULE;
-	snd_soc_codec_set_drvdata(codec, cx20442);
-
-	codec->dai = &cx20442_dai;
-	codec->num_dai = 1;
-
-	codec->reg_cache = &cx20442->reg_cache;
-	codec->reg_cache_size = ARRAY_SIZE(cx20442->reg_cache);
-	codec->read = cx20442_read_reg_cache;
-	codec->write = cx20442_write;
-
-	codec->bias_level = SND_SOC_BIAS_OFF;
-
-	cx20442_dai.dev = codec->dev;
-
-	cx20442_codec = codec;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto err;
-	}
-
-	ret = snd_soc_register_dai(&cx20442_dai);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to register DAI: %d\n", ret);
-		goto err_codec;
-	}
-
-	return 0;
-
-err_codec:
-	snd_soc_unregister_codec(codec);
-err:
-	cx20442_codec = NULL;
-	kfree(cx20442);
-	return ret;
-}
-
-static void cx20442_unregister(struct cx20442_priv *cx20442)
-{
-	snd_soc_unregister_dai(&cx20442_dai);
-	snd_soc_unregister_codec(&cx20442->codec);
-
-	cx20442_codec = NULL;
-	kfree(cx20442);
-}
-
 static int cx20442_platform_probe(struct platform_device *pdev)
 {
-	struct cx20442_priv *cx20442;
-	struct snd_soc_codec *codec;
-
-	cx20442 = kzalloc(sizeof(struct cx20442_priv), GFP_KERNEL);
-	if (cx20442 == NULL)
-		return -ENOMEM;
-
-	codec = &cx20442->codec;
-
-	codec->control_data = NULL;
-	codec->hw_write = NULL;
-	codec->pop_time = 0;
-
-	codec->dev = &pdev->dev;
-	platform_set_drvdata(pdev, cx20442);
-
-	return cx20442_register(cx20442);
+	return snd_soc_register_codec(&pdev->dev, pdev->id,
+			&cx20442_codec_dev, &cx20442_dai, 1);
 }
 
 static int __exit cx20442_platform_remove(struct platform_device *pdev)
 {
-	struct cx20442_priv *cx20442 = platform_get_drvdata(pdev);
-
-	cx20442_unregister(cx20442);
+	snd_soc_unregister_codec(&pdev->dev, pdev->id);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/cx20442.h b/sound/soc/codecs/cx20442.h
index 688a5eb..e37e1c7 100644
--- a/sound/soc/codecs/cx20442.h
+++ b/sound/soc/codecs/cx20442.h
@@ -13,8 +13,8 @@
 #ifndef _CX20442_CODEC_H
 #define _CX20442_CODEC_H
 
-extern struct snd_soc_dai cx20442_dai;
-extern struct snd_soc_codec_device cx20442_codec_dev;
+extern struct snd_soc_dai_driver cx20442_dai;
+extern struct snd_soc_codec_driver cx20442_codec_dev;
 extern struct tty_ldisc_ops v253_ops;
 
 #endif
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index ee86568..82b10fb 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -257,20 +257,15 @@ static int stac9766_reset(struct snd_soc_codec *codec, int try_warm)
 	return 0;
 }
 
-static int stac9766_codec_suspend(struct platform_device *pdev,
+static int stac9766_codec_suspend(struct snd_soc_codec *codec,
 				  pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	stac9766_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-static int stac9766_codec_resume(struct platform_device *pdev)
+static int stac9766_codec_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
 	u16 id, reset;
 
 	reset = 0;
@@ -300,10 +295,9 @@ static struct snd_soc_dai_ops stac9766_dai_ops_digital = {
 	.prepare = ac97_digital_prepare,
 };
 
-struct snd_soc_dai stac9766_dai[] = {
+struct snd_soc_dai_driver stac9766_dai[] = {
 {
 	.name = "stac9766 analog",
-	.id = 0,
 	.ac97_control = 1,
 
 	/* stream cababilities */
@@ -326,7 +320,6 @@ struct snd_soc_dai stac9766_dai[] = {
 },
 {
 	.name = "stac9766 IEC958",
-	.id = 1,
 	.ac97_control = 1,
 
 	/* stream cababilities */
@@ -344,55 +337,23 @@ struct snd_soc_dai stac9766_dai[] = {
 };
 EXPORT_SYMBOL_GPL(stac9766_dai);
 
-static int stac9766_codec_probe(struct platform_device *pdev)
+static int stac9766_codec_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
 	int ret = 0;
 
 	printk(KERN_INFO "STAC9766 SoC Audio Codec %s\n", STAC9766_VERSION);
 
-	socdev->card->codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (socdev->card->codec == NULL)
-		return -ENOMEM;
-	codec = socdev->card->codec;
-	mutex_init(&codec->mutex);
-
-	codec->reg_cache = kmemdup(stac9766_reg, sizeof(stac9766_reg),
-				   GFP_KERNEL);
-	if (codec->reg_cache == NULL) {
-		ret = -ENOMEM;
-		goto cache_err;
-	}
-	codec->reg_cache_size = sizeof(stac9766_reg);
-	codec->reg_cache_step = 2;
-
-	codec->name = "STAC9766";
-	codec->owner = THIS_MODULE;
-	codec->dai = stac9766_dai;
-	codec->num_dai = ARRAY_SIZE(stac9766_dai);
-	codec->write = stac9766_ac97_write;
-	codec->read = stac9766_ac97_read;
-	codec->set_bias_level = stac9766_set_bias_level;
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
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
 	stac9766_reset(codec, 0);
 	ret = stac9766_reset(codec, 1);
 	if (ret < 0) {
 		printk(KERN_ERR "Failed to reset STAC9766: AC97 link error\n");
-		goto reset_err;
+		goto codec_err;
 	}
 
 	stac9766_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
@@ -402,41 +363,67 @@ static int stac9766_codec_probe(struct platform_device *pdev)
 
 	return 0;
 
-reset_err:
-	snd_soc_free_pcms(socdev);
-pcm_err:
-	snd_soc_free_ac97_codec(codec);
 codec_err:
-	kfree(snd_soc_codec_get_drvdata(codec));
-cache_err:
-	kfree(socdev->card->codec);
-	socdev->card->codec = NULL;
+	snd_soc_free_ac97_codec(codec);
 	return ret;
 }
 
-static int stac9766_codec_remove(struct platform_device *pdev)
+static int stac9766_codec_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	if (codec == NULL)
-		return 0;
-
-	snd_soc_free_pcms(socdev);
 	snd_soc_free_ac97_codec(codec);
-	kfree(codec->reg_cache);
-	kfree(codec);
 	return 0;
 }
 
-struct snd_soc_codec_device soc_codec_dev_stac9766 = {
+struct snd_soc_codec_driver soc_codec_dev_stac9766 = {
+	.name = "STAC9766",
+	.owner = THIS_MODULE,
+	.write = stac9766_ac97_write,
+	.read = stac9766_ac97_read,
+	.set_bias_level = stac9766_set_bias_level,
 	.probe = stac9766_codec_probe,
 	.remove = stac9766_codec_remove,
 	.suspend = stac9766_codec_suspend,
 	.resume = stac9766_codec_resume,
+	.reg_cache_size = sizeof(stac9766_reg),
+	.reg_word_size = sizeof(u16),
+	.reg_cache_step = 2,
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_stac9766);
 
+static __devinit int stac9766_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev, pdev->id,
+			&soc_codec_dev_stac9766, stac9766_dai, ARRAY_SIZE(stac9766_dai));
+}
+
+static int __devexit stac9766_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev, pdev->id);
+	return 0;
+}
+
+static struct platform_driver stac9766_codec_driver = {
+	.driver = {
+			.name = "stac9766-audio",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = stac9766_probe,
+	.remove = __devexit_p(stac9766_remove),
+};
+
+static int __init stac9766_init(void)
+{
+	return platform_driver_register(&stac9766_codec_driver);
+}
+module_init(stac9766_init);
+
+static void __exit stac9766_exit(void)
+{
+	platform_driver_unregister(&stac9766_codec_driver);
+}
+module_exit(stac9766_exit);
+
 MODULE_DESCRIPTION("ASoC stac9766 driver");
 MODULE_AUTHOR("Jon Smirl <jonsmirl@gmail.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/stac9766.h b/sound/soc/codecs/stac9766.h
index 65642eb..c387124 100644
--- a/sound/soc/codecs/stac9766.h
+++ b/sound/soc/codecs/stac9766.h
@@ -14,8 +14,8 @@
 #define STAC9766_DAI_AC97_ANALOG		0
 #define STAC9766_DAI_AC97_DIGITAL		1
 
-extern struct snd_soc_dai stac9766_dai[];
-extern struct snd_soc_codec_device soc_codec_dev_stac9766;
+extern struct snd_soc_dai_driver stac9766_dai[];
+extern struct snd_soc_codec_driver soc_codec_dev_stac9766;
 
 
 #endif
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index 28aac53..b6a64b5 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -173,8 +173,7 @@ static int uda134x_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec =rtd->codec;
 	struct uda134x_priv *uda134x = snd_soc_codec_get_drvdata(codec);
 	struct snd_pcm_runtime *master_runtime;
 
@@ -206,8 +205,7 @@ static void uda134x_shutdown(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct uda134x_priv *uda134x = snd_soc_codec_get_drvdata(codec);
 
 	if (uda134x->master_substream == substream)
@@ -221,8 +219,7 @@ static int uda134x_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *dai)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 	struct uda134x_priv *uda134x = snd_soc_codec_get_drvdata(codec);
 	u8 hw_params;
 
@@ -362,7 +359,7 @@ static int uda134x_set_bias_level(struct snd_soc_codec *codec,
 			pd->power(1);
 			/* Sync reg_cache with the hardware */
 			for (i = 0; i < ARRAY_SIZE(uda134x_reg); i++)
-				codec->write(codec, i, *cache++);
+				codec->driver->write(codec, i, *cache++);
 		}
 		break;
 	case SND_SOC_BIAS_STANDBY:
@@ -449,7 +446,7 @@ static struct snd_soc_dai_ops uda134x_dai_ops = {
 	.set_fmt	= uda134x_set_dai_fmt,
 };
 
-struct snd_soc_dai uda134x_dai = {
+struct snd_soc_dai_driver uda134x_dai = {
 	.name = "UDA134X",
 	/* playback capabilities */
 	.playback = {
@@ -473,24 +470,20 @@ struct snd_soc_dai uda134x_dai = {
 EXPORT_SYMBOL(uda134x_dai);
 
 
-static int uda134x_soc_probe(struct platform_device *pdev)
+static int uda134x_soc_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
 	struct uda134x_priv *uda134x;
-	void *codec_setup_data = socdev->codec_data;
-	int ret = -ENOMEM;
-	struct uda134x_platform_data *pd;
+	struct uda134x_platform_data *pd = dev_get_drvdata(codec->card->dev);
+	int ret;
 
 	printk(KERN_INFO "UDA134X SoC Audio Codec\n");
 
-	if (!codec_setup_data) {
+	if (!pd) {
 		printk(KERN_ERR "UDA134X SoC codec: "
 		       "missing L3 bitbang function\n");
 		return -ENODEV;
 	}
 
-	pd = codec_setup_data;
 	switch (pd->model) {
 	case UDA134X_UDA1340:
 	case UDA134X_UDA1341:
@@ -504,53 +497,18 @@ static int uda134x_soc_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	socdev->card->codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (socdev->card->codec == NULL)
-		return ret;
-
-	codec = socdev->card->codec;
-
 	uda134x = kzalloc(sizeof(struct uda134x_priv), GFP_KERNEL);
 	if (uda134x == NULL)
-		goto priv_err;
+		return -ENOMEM;
 	snd_soc_codec_set_drvdata(codec, uda134x);
 
-	codec->reg_cache = kmemdup(uda134x_reg, sizeof(uda134x_reg),
-				   GFP_KERNEL);
-	if (codec->reg_cache == NULL)
-		goto reg_err;
-
-	mutex_init(&codec->mutex);
-
-	codec->reg_cache_size = sizeof(uda134x_reg);
-	codec->reg_cache_step = 1;
-
-	codec->name = "UDA134X";
-	codec->owner = THIS_MODULE;
-	codec->dai = &uda134x_dai;
-	codec->num_dai = 1;
-	codec->read = uda134x_read_reg_cache;
-	codec->write = uda134x_write;
-#ifdef POWER_OFF_ON_STANDBY
-	codec->set_bias_level = uda134x_set_bias_level;
-#endif
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	codec->control_data = codec_setup_data;
+	codec->control_data = pd;
 
 	if (pd->power)
 		pd->power(1);
 
 	uda134x_reset(codec);
 
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		printk(KERN_ERR "UDA134X: failed to register pcms\n");
-		goto pcm_err;
-	}
-
 	switch (pd->model) {
 	case UDA134X_UDA1340:
 	case UDA134X_UDA1344:
@@ -568,61 +526,42 @@ static int uda134x_soc_probe(struct platform_device *pdev)
 	default:
 		printk(KERN_ERR "%s unknown codec type: %d",
 			__func__, pd->model);
-	return -EINVAL;
+		kfree(uda134x);
+		return -EINVAL;
 	}
 
 	if (ret < 0) {
 		printk(KERN_ERR "UDA134X: failed to register controls\n");
-		goto pcm_err;
+		kfree(uda134x);
+		return ret;
 	}
 
 	return 0;
-
-pcm_err:
-	kfree(codec->reg_cache);
-reg_err:
-	kfree(snd_soc_codec_get_drvdata(codec));
-priv_err:
-	kfree(codec);
-	return ret;
 }
 
 /* power down chip */
-static int uda134x_soc_remove(struct platform_device *pdev)
+static int uda134x_soc_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct uda134x_priv *uda134x = snd_soc_codec_get_drvdata(codec);
 
 	uda134x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	uda134x_set_bias_level(codec, SND_SOC_BIAS_OFF);
 
-	snd_soc_free_pcms(socdev);
-	snd_soc_dapm_free(socdev);
-
-	kfree(snd_soc_codec_get_drvdata(codec));
-	kfree(codec->reg_cache);
-	kfree(codec);
-
+	kfree(uda134x);
 	return 0;
 }
 
 #if defined(CONFIG_PM)
-static int uda134x_soc_suspend(struct platform_device *pdev,
+static int uda134x_soc_suspend(struct snd_soc_codec *codec,
 						pm_message_t state)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	uda134x_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	uda134x_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	return 0;
 }
 
-static int uda134x_soc_resume(struct platform_device *pdev)
+static int uda134x_soc_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
 	uda134x_set_bias_level(codec, SND_SOC_BIAS_PREPARE);
 	uda134x_set_bias_level(codec, SND_SOC_BIAS_ON);
 	return 0;
@@ -632,25 +571,56 @@ static int uda134x_soc_resume(struct platform_device *pdev)
 #define uda134x_soc_resume NULL
 #endif /* CONFIG_PM */
 
-struct snd_soc_codec_device soc_codec_dev_uda134x = {
+struct snd_soc_codec_driver soc_codec_dev_uda134x = {
+	.name = "UDA134X",
+	.owner = THIS_MODULE,
 	.probe =        uda134x_soc_probe,
 	.remove =       uda134x_soc_remove,
 	.suspend =      uda134x_soc_suspend,
 	.resume =       uda134x_soc_resume,
+	.reg_cache_size = sizeof(uda134x_reg),
+	.reg_word_size = sizeof(u8),
+	.reg_cache_step = 1,
+	.read = uda134x_read_reg_cache,
+	.write = uda134x_write,
+#ifdef POWER_OFF_ON_STANDBY
+	.set_bias_level = uda134x_set_bias_level,
+#endif
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_uda134x);
 
-static int __init uda134x_init(void)
+static int __devinit uda134x_codec_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev, pdev->id,
+			&soc_codec_dev_uda134x, &uda134x_dai, 1);
+}
+
+static int __devexit uda134x_codec_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev, pdev->id);
+	return 0;
+}
+
+static struct platform_driver uda134x_codec_driver = {
+	.driver = {
+		.name = "uda134x_codec",
+		.owner = THIS_MODULE,
+	},
+	.probe = uda134x_codec_probe,
+	.remove = __devexit_p(uda134x_codec_remove),
+};
+
+static int __init uda134x_codec_init(void)
 {
-	return snd_soc_register_dai(&uda134x_dai);
+	return platform_driver_register(&uda134x_codec_driver);
 }
-module_init(uda134x_init);
+module_init(uda134x_codec_init);
 
-static void __exit uda134x_exit(void)
+static void __exit uda134x_codec_exit(void)
 {
-	snd_soc_unregister_dai(&uda134x_dai);
+	platform_driver_unregister(&uda134x_codec_driver);
 }
-module_exit(uda134x_exit);
+module_exit(uda134x_codec_exit);
 
 MODULE_DESCRIPTION("UDA134X ALSA soc codec driver");
 MODULE_AUTHOR("Zoltan Devai, Christian Pellegrin <chripell@evolware.org>");
diff --git a/sound/soc/codecs/uda134x.h b/sound/soc/codecs/uda134x.h
index 94f4404..0585cde 100644
--- a/sound/soc/codecs/uda134x.h
+++ b/sound/soc/codecs/uda134x.h
@@ -30,7 +30,7 @@
 #define STATUS0_DAIFMT_MASK (~(7<<1))
 #define STATUS0_SYSCLK_MASK (~(3<<4))
 
-extern struct snd_soc_dai uda134x_dai;
-extern struct snd_soc_codec_device soc_codec_dev_uda134x;
+extern struct snd_soc_dai_driver uda134x_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_uda134x;
 
 #endif
-- 
1.7.0.4
