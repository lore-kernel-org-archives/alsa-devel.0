From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ASoC: Merge common code in DAI link and
	auxiliary codec probing/removal
Date: Mon,  6 Dec 2010 16:27:07 +0200
Message-ID: <1291645627-4311-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1930E1038A2
	for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2010 15:27:21 +0100 (CET)
Received: by eyg24 with SMTP id 24so6173683eyg.38
	for <alsa-devel@alsa-project.org>; Mon, 06 Dec 2010 06:27:20 -0800 (PST)
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

Commit 2eea392 "ASoC: Add support for optional auxiliary dailess codecs"
added much of code that can be shared with DAI link codec probing/removal.
Merge now this common code into new soc_probe_codec, soc_remove_codec and
soc_post_component_init functions.

Error prints in these functions are converted to use dev_err and to print
the error code.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/soc-core.c |  284 +++++++++++++++++++++++---------------------------
 1 files changed, 132 insertions(+), 152 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fd284a7..c0cd9b8 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1327,6 +1327,27 @@ out:
 	return 1;
 }
 
+static void soc_remove_codec(struct snd_soc_codec *codec)
+{
+	int err;
+
+	if (codec->driver->remove) {
+		err = codec->driver->remove(codec);
+		if (err < 0)
+			dev_err(codec->dev,
+				"asoc: failed to remove %s: %d\n",
+				codec->name, err);
+	}
+
+	/* Make sure all DAPM widgets are freed */
+	snd_soc_dapm_free(&codec->dapm);
+
+	soc_cleanup_codec_debugfs(codec);
+	codec->probed = 0;
+	list_del(&codec->card_list);
+	module_put(codec->dev->driver->owner);
+}
+
 static void soc_remove_dai_link(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
@@ -1338,6 +1359,7 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num)
 	/* unregister the rtd device */
 	if (rtd->dev_registered) {
 		device_remove_file(&rtd->dev, &dev_attr_pmdown_time);
+		device_remove_file(&rtd->dev, &dev_attr_codec_reg);
 		device_unregister(&rtd->dev);
 		rtd->dev_registered = 0;
 	}
@@ -1366,22 +1388,8 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num)
 	}
 
 	/* remove the CODEC */
-	if (codec && codec->probed) {
-		if (codec->driver->remove) {
-			err = codec->driver->remove(codec);
-			if (err < 0)
-				printk(KERN_ERR "asoc: failed to remove %s\n", codec->name);
-		}
-
-		/* Make sure all DAPM widgets are freed */
-		snd_soc_dapm_free(&codec->dapm);
-
-		soc_cleanup_codec_debugfs(codec);
-		device_remove_file(&rtd->dev, &dev_attr_codec_reg);
-		codec->probed = 0;
-		list_del(&codec->card_list);
-		module_put(codec->dev->driver->owner);
-	}
+	if (codec && codec->probed)
+		soc_remove_codec(codec);
 
 	/* remove the cpu_dai */
 	if (cpu_dai && cpu_dai->probed) {
@@ -1413,8 +1421,105 @@ static void soc_set_name_prefix(struct snd_soc_card *card,
 	}
 }
 
+static int soc_probe_codec(struct snd_soc_card *card,
+			   struct snd_soc_codec *codec)
+{
+	int ret = 0;
+
+	codec->card = card;
+	codec->dapm.card = card;
+	soc_set_name_prefix(card, codec);
+
+	if (codec->driver->probe) {
+		ret = codec->driver->probe(codec);
+		if (ret < 0) {
+			dev_err(codec->dev,
+				"asoc: failed to probe CODEC %s: %d\n",
+				codec->name, ret);
+			return ret;
+		}
+	}
+
+	soc_init_codec_debugfs(codec);
+
+	/* mark codec as probed and add to card codec list */
+	codec->probed = 1;
+	list_add(&codec->card_list, &card->codec_dev_list);
+
+	return ret;
+}
+
 static void rtd_release(struct device *dev) {}
 
+static int soc_post_component_init(struct snd_soc_card *card,
+				   struct snd_soc_codec *codec,
+				   int num, int dailess)
+{
+	struct snd_soc_dai_link *dai_link = NULL;
+	struct snd_soc_aux_dev *aux_dev = NULL;
+	struct snd_soc_pcm_runtime *rtd;
+	const char *temp, *name;
+	int ret = 0;
+
+	if (!dailess) {
+		dai_link = &card->dai_link[num];
+		rtd = &card->rtd[num];
+		name = dai_link->name;
+	} else {
+		aux_dev = &card->aux_dev[num];
+		rtd = &card->rtd_aux[num];
+		name = aux_dev->name;
+	}
+
+	/* machine controls, routes and widgets are not prefixed */
+	temp = codec->name_prefix;
+	codec->name_prefix = NULL;
+
+	/* do machine specific initialization */
+	if (!dailess && dai_link->init)
+		ret = dai_link->init(rtd);
+	else if (dailess && aux_dev->init)
+		ret = aux_dev->init(&codec->dapm);
+	if (ret < 0) {
+		dev_err(card->dev, "asoc: failed to init %s: %d\n", name, ret);
+		return ret;
+	}
+	codec->name_prefix = temp;
+
+	/* Make sure all DAPM widgets are instantiated */
+	snd_soc_dapm_new_widgets(&codec->dapm);
+	snd_soc_dapm_sync(&codec->dapm);
+
+	/* register the rtd device */
+	rtd->codec = codec;
+	rtd->card = card;
+	rtd->dev.parent = card->dev;
+	rtd->dev.release = rtd_release;
+	rtd->dev.init_name = name;
+	ret = device_register(&rtd->dev);
+	if (ret < 0) {
+		dev_err(card->dev,
+			"asoc: failed to register runtime device: %d\n", ret);
+		return ret;
+	}
+	rtd->dev_registered = 1;
+
+	/* add DAPM sysfs entries for this codec */
+	ret = snd_soc_dapm_sys_add(&rtd->dev);
+	if (ret < 0)
+		dev_err(codec->dev,
+			"asoc: failed to add codec dapm sysfs entries: %d\n",
+			ret);
+
+	/* add codec sysfs entries */
+	ret = device_create_file(&rtd->dev, &dev_attr_codec_reg);
+	if (ret < 0)
+		dev_err(codec->dev,
+			"asoc: failed to add codec sysfs files: %d\n", ret);
+
+	return 0;
+}
+
 static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
@@ -1422,17 +1527,13 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai, *cpu_dai = rtd->cpu_dai;
-	const char *temp;
 	int ret;
 
 	dev_dbg(card->dev, "probe %s dai link %d\n", card->name, num);
 
 	/* config components */
 	codec_dai->codec = codec;
-	codec->card = card;
 	cpu_dai->platform = platform;
-	rtd->card = card;
-	rtd->dev.parent = card->dev;
 	codec_dai->card = card;
 	cpu_dai->card = card;
 
@@ -1456,22 +1557,9 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 
 	/* probe the CODEC */
 	if (!codec->probed) {
-		codec->dapm.card = card;
-		soc_set_name_prefix(card, codec);
-		if (codec->driver->probe) {
-			ret = codec->driver->probe(codec);
-			if (ret < 0) {
-				printk(KERN_ERR "asoc: failed to probe CODEC %s\n",
-						codec->name);
-				return ret;
-			}
-		}
-
-		soc_init_codec_debugfs(codec);
-
-		/* mark codec as probed and add to card codec list */
-		codec->probed = 1;
-		list_add(&codec->card_list, &card->codec_dev_list);
+		ret = soc_probe_codec(card, codec);
+		if (ret < 0)
+			return ret;
 	}
 
 	/* probe the platform */
@@ -1508,47 +1596,14 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
 	/* DAPM dai link stream work */
 	INIT_DELAYED_WORK(&rtd->delayed_work, close_delayed_work);
 
-	/* now that all clients have probed, initialise the DAI link */
-	if (dai_link->init) {
-		/* machine controls, routes and widgets are not prefixed */
-		temp = rtd->codec->name_prefix;
-		rtd->codec->name_prefix = NULL;
-		ret = dai_link->init(rtd);
-		if (ret < 0) {
-			printk(KERN_ERR "asoc: failed to init %s\n", dai_link->stream_name);
-			return ret;
-		}
-		rtd->codec->name_prefix = temp;
-	}
-
-	/* Make sure all DAPM widgets are instantiated */
-	snd_soc_dapm_new_widgets(&codec->dapm);
-	snd_soc_dapm_sync(&codec->dapm);
-
-	/* register the rtd device */
-	rtd->dev.release = rtd_release;
-	rtd->dev.init_name = dai_link->name;
-	ret = device_register(&rtd->dev);
-	if (ret < 0) {
-		printk(KERN_ERR "asoc: failed to register DAI runtime device %d\n", ret);
+	ret = soc_post_component_init(card, codec, num, 0);
+	if (ret)
 		return ret;
-	}
 
-	rtd->dev_registered = 1;
 	ret = device_create_file(&rtd->dev, &dev_attr_pmdown_time);
 	if (ret < 0)
 		printk(KERN_WARNING "asoc: failed to add pmdown_time sysfs\n");
 
-	/* add DAPM sysfs entries for this codec */
-	ret = snd_soc_dapm_sys_add(&rtd->dev);
-	if (ret < 0)
-		printk(KERN_WARNING "asoc: failed to add codec dapm sysfs entries\n");
-
-	/* add codec sysfs entries */
-	ret = device_create_file(&rtd->dev, &dev_attr_codec_reg);
-	if (ret < 0)
-		printk(KERN_WARNING "asoc: failed to add codec sysfs files\n");
-
 	/* create the pcm */
 	ret = soc_new_pcm(rtd, num);
 	if (ret < 0) {
@@ -1606,9 +1661,7 @@ static void soc_unregister_ac97_dai_link(struct snd_soc_codec *codec)
 static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
-	struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
 	struct snd_soc_codec *codec;
-	const char *temp;
 	int ret = -ENODEV;
 
 	/* find CODEC from registered CODECs*/
@@ -1631,67 +1684,11 @@ found:
 	if (!try_module_get(codec->dev->driver->owner))
 		return -ENODEV;
 
-	codec->card = card;
-	codec->dapm.card = card;
-
-	soc_set_name_prefix(card, codec);
-	if (codec->driver->probe) {
-		ret = codec->driver->probe(codec);
-		if (ret < 0) {
-			dev_err(codec->dev, "asoc: failed to probe CODEC");
-			return ret;
-		}
-	}
-
-	soc_init_codec_debugfs(codec);
-
-	/* mark codec as probed and add to card codec list */
-	codec->probed = 1;
-	list_add(&codec->card_list, &card->codec_dev_list);
-
-	/* now that all clients have probed, initialise the DAI link */
-	if (aux_dev->init) {
-		/* machine controls, routes and widgets are not prefixed */
-		temp = codec->name_prefix;
-		codec->name_prefix = NULL;
-		ret = aux_dev->init(&codec->dapm);
-		if (ret < 0) {
-			dev_err(codec->dev,
-				"asoc: failed to init %s\n", aux_dev->name);
-			return ret;
-		}
-		codec->name_prefix = temp;
-	}
-
-	/* Make sure all DAPM widgets are instantiated */
-	snd_soc_dapm_new_widgets(&codec->dapm);
-	snd_soc_dapm_sync(&codec->dapm);
-
-	/* register the rtd device */
-	rtd->codec = codec;
-	rtd->card = card;
-	rtd->dev.parent = card->dev;
-	rtd->dev.release = rtd_release;
-	rtd->dev.init_name = aux_dev->name;
-	ret = device_register(&rtd->dev);
-	if (ret < 0) {
-		dev_err(codec->dev,
-			"asoc: failed to register aux runtime device %d\n",
-			ret);
-		return ret;
-	}
-	rtd->dev_registered = 1;
-
-	/* add DAPM sysfs entries for this codec */
-	ret = snd_soc_dapm_sys_add(&rtd->dev);
+	ret = soc_probe_codec(card, codec);
 	if (ret < 0)
-		dev_err(codec->dev,
-			"asoc: failed to add codec dapm sysfs entries\n");
+		return ret;
 
-	/* add codec sysfs entries */
-	ret = device_create_file(&rtd->dev, &dev_attr_codec_reg);
-	if (ret < 0)
-		dev_err(codec->dev, "asoc: failed to add codec sysfs files\n");
+	ret = soc_post_component_init(card, codec, num, 1);
 
 out:
 	return ret;
@@ -1701,33 +1698,16 @@ static void soc_remove_aux_dev(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
 	struct snd_soc_codec *codec = rtd->codec;
-	int err;
 
 	/* unregister the rtd device */
 	if (rtd->dev_registered) {
+		device_remove_file(&rtd->dev, &dev_attr_codec_reg);
 		device_unregister(&rtd->dev);
 		rtd->dev_registered = 0;
 	}
 
-	/* remove the CODEC */
-	if (codec && codec->probed) {
-		if (codec->driver->remove) {
-			err = codec->driver->remove(codec);
-			if (err < 0)
-				dev_err(codec->dev,
-					"asoc: failed to remove %s\n",
-					codec->name);
-		}
-
-		/* Make sure all DAPM widgets are freed */
-		snd_soc_dapm_free(&codec->dapm);
-
-		soc_cleanup_codec_debugfs(codec);
-		device_remove_file(&rtd->dev, &dev_attr_codec_reg);
-		codec->probed = 0;
-		list_del(&codec->card_list);
-		module_put(codec->dev->driver->owner);
-	}
+	if (codec && codec->probed)
+		soc_remove_codec(codec);
 }
 
 static int snd_soc_init_codec_cache(struct snd_soc_codec *codec,
-- 
1.7.0.4
