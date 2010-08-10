From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [PATCH 06/17] ASoC: multi-component - Generic AC97 and
	SPDIF CODECs
Date: Wed, 11 Aug 2010 00:02:57 +0100
Message-ID: <1281481388-3000-7-git-send-email-lrg@slimlogic.co.uk>
References: <1281481388-3000-1-git-send-email-lrg@slimlogic.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3792B103858
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 01:03:37 +0200 (CEST)
Received: by mail-ww0-f51.google.com with SMTP id 36so2366031wwa.20
	for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2010 16:03:37 -0700 (PDT)
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

Moved generic codecs to multi-component model.

This patch changes the probe() and remove() of the CODEC drivers as follows:-

 o Make CODEC driver a platform driver
 o Moved all struct snd_soc_codec list, mutex, etc initialiasation to core.
 o Removed all static codec pointers (drivers now support > 1 codec dev)
 o snd_soc_register_pcms() now done by core.
 o snd_soc_register_dai() folded into snd_soc_register_codec().
 o codec cache can now be malloc()ed by core.

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/ac97.c              |  124 +++++++++++++++-------------------
 sound/soc/codecs/ac97.h              |    4 +-
 sound/soc/codecs/spdif_transciever.c |  102 ++--------------------------
 sound/soc/codecs/spdif_transciever.h |    4 +-
 4 files changed, 65 insertions(+), 169 deletions(-)

diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index 1f5e57a..cc0b697 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -21,7 +21,6 @@
 #include <sound/ac97_codec.h>
 #include <sound/initval.h>
 #include <sound/soc.h>
-#include "ac97.h"
 
 #define AC97_VERSION "0.6"
 
@@ -30,8 +29,7 @@ static int ac97_prepare(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_device *socdev = rtd->socdev;
-	struct snd_soc_codec *codec = socdev->card->codec;
+	struct snd_soc_codec *codec = rtd->codec;
 
 	int reg = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
 		  AC97_PCM_FRONT_DAC_RATE : AC97_PCM_LR_ADC_RATE;
@@ -46,8 +44,8 @@ static struct snd_soc_dai_ops ac97_dai_ops = {
 	.prepare	= ac97_prepare,
 };
 
-struct snd_soc_dai ac97_dai = {
-	.name = "AC97 HiFi",
+static struct snd_soc_dai_driver ac97_dai = {
+	.name = "ac97-hifi",
 	.ac97_control = 1,
 	.playback = {
 		.stream_name = "AC97 Playback",
@@ -63,7 +61,6 @@ struct snd_soc_dai ac97_dai = {
 		.formats = SND_SOC_STD_AC97_FMTS,},
 	.ops = &ac97_dai_ops,
 };
-EXPORT_SYMBOL_GPL(ac97_dai);
 
 static unsigned int ac97_read(struct snd_soc_codec *codec,
 	unsigned int reg)
@@ -78,95 +75,49 @@ static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
 	return 0;
 }
 
-static int ac97_soc_probe(struct platform_device *pdev)
+static int ac97_soc_probe(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_card *card = socdev->card;
-	struct snd_soc_codec *codec;
 	struct snd_ac97_bus *ac97_bus;
 	struct snd_ac97_template ac97_template;
-	int i;
-	int ret = 0;
+	int ret;
 
 	printk(KERN_INFO "AC97 SoC Audio Codec %s\n", AC97_VERSION);
 
-	socdev->card->codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (!socdev->card->codec)
-		return -ENOMEM;
-	codec = socdev->card->codec;
-	mutex_init(&codec->mutex);
-
-	codec->name = "AC97";
-	codec->owner = THIS_MODULE;
-	codec->dai = &ac97_dai;
-	codec->num_dai = 1;
-	codec->write = ac97_write;
-	codec->read = ac97_read;
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	/* register pcms */
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0)
-		goto err;
+	ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);
+	if (ret < 0) {
+		printk(KERN_ERR "ASoC: failed to init gen ac97 glue\n");
+		return ret;
+	}
 
 	/* add codec as bus device for standard ac97 */
-	ret = snd_ac97_bus(codec->card, 0, &soc_ac97_ops, NULL, &ac97_bus);
+	ret = snd_ac97_bus(codec->snd_card, 0, &soc_ac97_ops, NULL, &ac97_bus);
 	if (ret < 0)
-		goto bus_err;
+		return ret;
 
 	memset(&ac97_template, 0, sizeof(struct snd_ac97_template));
 	ret = snd_ac97_mixer(ac97_bus, &ac97_template, &codec->ac97);
 	if (ret < 0)
-		goto bus_err;
-
-	for (i = 0; i < card->num_links; i++) {
-		if (card->dai_link[i].codec_dai->ac97_control) {
-			snd_ac97_dev_add_pdata(codec->ac97,
-				card->dai_link[i].cpu_dai->ac97_pdata);
-		}
-	}
+		return ret;
 
 	return 0;
-
-bus_err:
-	snd_soc_free_pcms(socdev);
-
-err:
-	kfree(socdev->card->codec);
-	socdev->card->codec = NULL;
-	return ret;
 }
 
-static int ac97_soc_remove(struct platform_device *pdev)
+static int ac97_soc_remove(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec = socdev->card->codec;
-
-	if (!codec)
-		return 0;
-
-	snd_soc_free_pcms(socdev);
-	kfree(socdev->card->codec);
-
 	return 0;
 }
 
 #ifdef CONFIG_PM
-static int ac97_soc_suspend(struct platform_device *pdev, pm_message_t msg)
+static int ac97_soc_suspend(struct snd_soc_codec *codec, pm_message_t msg)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_ac97_suspend(socdev->card->codec->ac97);
+	snd_ac97_suspend(codec->ac97);
 
 	return 0;
 }
 
-static int ac97_soc_resume(struct platform_device *pdev)
+static int ac97_soc_resume(struct snd_soc_codec *codec)
 {
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_ac97_resume(socdev->card->codec->ac97);
+	snd_ac97_resume(codec->ac97);
 
 	return 0;
 }
@@ -175,13 +126,48 @@ static int ac97_soc_resume(struct platform_device *pdev)
 #define ac97_soc_resume NULL
 #endif
 
-struct snd_soc_codec_device soc_codec_dev_ac97 = {
+static struct snd_soc_codec_driver soc_codec_dev_ac97 = {
+	.write = ac97_write,
+	.read = ac97_read,
 	.probe = 	ac97_soc_probe,
 	.remove = 	ac97_soc_remove,
 	.suspend =	ac97_soc_suspend,
 	.resume =	ac97_soc_resume,
 };
-EXPORT_SYMBOL_GPL(soc_codec_dev_ac97);
+
+static __devinit int ac97_probe(struct platform_device *pdev)
+{
+	return snd_soc_register_codec(&pdev->dev,
+			&soc_codec_dev_ac97, &ac97_dai, 1);
+}
+
+static int __devexit ac97_remove(struct platform_device *pdev)
+{
+	snd_soc_unregister_codec(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver ac97_codec_driver = {
+	.driver = {
+			.name = "ac97-codec",
+			.owner = THIS_MODULE,
+	},
+
+	.probe = ac97_probe,
+	.remove = __devexit_p(ac97_remove),
+};
+
+static int __init ac97_init(void)
+{
+	return platform_driver_register(&ac97_codec_driver);
+}
+module_init(ac97_init);
+
+static void __exit ac97_exit(void)
+{
+	platform_driver_unregister(&ac97_codec_driver);
+}
+module_exit(ac97_exit);
 
 MODULE_DESCRIPTION("Soc Generic AC97 driver");
 MODULE_AUTHOR("Liam Girdwood");
diff --git a/sound/soc/codecs/ac97.h b/sound/soc/codecs/ac97.h
index 281aa42..a924659 100644
--- a/sound/soc/codecs/ac97.h
+++ b/sound/soc/codecs/ac97.h
@@ -13,7 +13,7 @@
 #ifndef __LINUX_SND_SOC_AC97_H
 #define __LINUX_SND_SOC_AC97_H
 
-extern struct snd_soc_codec_device soc_codec_dev_ac97;
-extern struct snd_soc_dai ac97_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_ac97;
+extern struct snd_soc_dai_driver ac97_dai;
 
 #endif
diff --git a/sound/soc/codecs/spdif_transciever.c b/sound/soc/codecs/spdif_transciever.c
index 9119836..4c32b54 100644
--- a/sound/soc/codecs/spdif_transciever.c
+++ b/sound/soc/codecs/spdif_transciever.c
@@ -21,57 +21,16 @@
 #include <sound/pcm.h>
 #include <sound/initval.h>
 
-#include "spdif_transciever.h"
-
 MODULE_LICENSE("GPL");
 
 #define STUB_RATES	SNDRV_PCM_RATE_8000_96000
 #define STUB_FORMATS	SNDRV_PCM_FMTBIT_S16_LE
 
-static struct snd_soc_codec *spdif_dit_codec;
-
-static int spdif_dit_codec_probe(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-	struct snd_soc_codec *codec;
-	int ret;
-
-	if (spdif_dit_codec == NULL) {
-		dev_err(&pdev->dev, "Codec device not registered\n");
-		return -ENODEV;
-	}
-
-	socdev->card->codec = spdif_dit_codec;
-	codec = spdif_dit_codec;
-
-	ret = snd_soc_new_pcms(socdev, SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1);
-	if (ret < 0) {
-		dev_err(codec->dev, "failed to create pcms: %d\n", ret);
-		goto err_create_pcms;
-	}
-
-	return 0;
-
-err_create_pcms:
-	return ret;
-}
-
-static int spdif_dit_codec_remove(struct platform_device *pdev)
-{
-	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
-
-	snd_soc_free_pcms(socdev);
-
-	return 0;
-}
 
-struct snd_soc_codec_device soc_codec_dev_spdif_dit = {
-	.probe		= spdif_dit_codec_probe,
-	.remove		= spdif_dit_codec_remove,
-}; EXPORT_SYMBOL_GPL(soc_codec_dev_spdif_dit);
+static struct snd_soc_codec_driver soc_codec_spdif_dit;
 
-struct snd_soc_dai dit_stub_dai = {
-	.name		= "DIT",
+static struct snd_soc_dai_driver dit_stub_dai = {
+	.name		= "dit-hifi",
 	.playback 	= {
 		.stream_name	= "Playback",
 		.channels_min	= 1,
@@ -80,65 +39,16 @@ struct snd_soc_dai dit_stub_dai = {
 		.formats	= STUB_FORMATS,
 	},
 };
-EXPORT_SYMBOL_GPL(dit_stub_dai);
 
 static int spdif_dit_probe(struct platform_device *pdev)
 {
-	struct snd_soc_codec *codec;
-	int ret;
-
-	if (spdif_dit_codec) {
-		dev_err(&pdev->dev, "Another Codec is registered\n");
-		ret = -EINVAL;
-		goto err_reg_codec;
-	}
-
-	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
-	if (codec == NULL)
-		return -ENOMEM;
-
-	codec->dev = &pdev->dev;
-
-	mutex_init(&codec->mutex);
-
-	INIT_LIST_HEAD(&codec->dapm_widgets);
-	INIT_LIST_HEAD(&codec->dapm_paths);
-
-	codec->name = "spdif-dit";
-	codec->owner = THIS_MODULE;
-	codec->dai = &dit_stub_dai;
-	codec->num_dai = 1;
-
-	spdif_dit_codec = codec;
-
-	ret = snd_soc_register_codec(codec);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to register codec: %d\n", ret);
-		goto err_reg_codec;
-	}
-
-	dit_stub_dai.dev = &pdev->dev;
-	ret = snd_soc_register_dai(&dit_stub_dai);
-	if (ret < 0) {
-		dev_err(codec->dev, "Failed to register dai: %d\n", ret);
-		goto err_reg_dai;
-	}
-
-	return 0;
-
-err_reg_dai:
-	snd_soc_unregister_codec(codec);
-err_reg_codec:
-	kfree(spdif_dit_codec);
-	return ret;
+	return snd_soc_register_codec(&pdev->dev, &soc_codec_spdif_dit,
+			&dit_stub_dai, 1);
 }
 
 static int spdif_dit_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_dai(&dit_stub_dai);
-	snd_soc_unregister_codec(spdif_dit_codec);
-	kfree(spdif_dit_codec);
-	spdif_dit_codec = NULL;
+	snd_soc_unregister_codec(&pdev->dev);
 	return 0;
 }
 
diff --git a/sound/soc/codecs/spdif_transciever.h b/sound/soc/codecs/spdif_transciever.h
index 1e10212..d686191 100644
--- a/sound/soc/codecs/spdif_transciever.h
+++ b/sound/soc/codecs/spdif_transciever.h
@@ -12,7 +12,7 @@
 #ifndef CODEC_STUBS_H
 #define CODEC_STUBS_H
 
-extern struct snd_soc_codec_device soc_codec_dev_spdif_dit;
-extern struct snd_soc_dai dit_stub_dai;
+extern struct snd_soc_codec_driver soc_codec_spdif_dit;
+extern struct snd_soc_dai_driver dit_stub_dai;
 
 #endif /* CODEC_STUBS_H */
-- 
1.7.0.4
