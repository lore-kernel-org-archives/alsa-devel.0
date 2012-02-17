From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: soc-core: Show the returned values on
	error messages
Date: Fri, 17 Feb 2012 19:40:38 -0200
Message-ID: <1329514838-30933-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id E8276103FFC
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 22:40:50 +0100 (CET)
Received: by ggnq4 with SMTP id q4so2099709ggn.38
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 13:40:49 -0800 (PST)
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
Cc: tiwai@suse.de, Fabio Estevam <fabio.estevam@freescale.com>, broonie@opensource.wolfsonmicro.com, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Showing the returned values on error messages is useful information.

While at it, use pr_err/pr_warn whenever possible.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/soc-core.c |   39 ++++++++++++++++++++++-----------------
 1 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6bad7cd..7001fb3 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -931,7 +931,8 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num, int order)
 		if (codec_dai->driver->remove) {
 			err = codec_dai->driver->remove(codec_dai);
 			if (err < 0)
-				printk(KERN_ERR "asoc: failed to remove %s\n", codec_dai->name);
+				pr_err("asoc: failed to remove %s: %d\n",
+							codec_dai->name, err);
 		}
 		codec_dai->probed = 0;
 		list_del(&codec_dai->card_list);
@@ -943,7 +944,8 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num, int order)
 		if (platform->driver->remove) {
 			err = platform->driver->remove(platform);
 			if (err < 0)
-				printk(KERN_ERR "asoc: failed to remove %s\n", platform->name);
+				pr_err("asoc: failed to remove %s: %d\n",
+							platform->name, err);
 		}
 
 		/* Make sure all DAPM widgets are freed */
@@ -966,7 +968,8 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num, int order)
 		if (cpu_dai->driver->remove) {
 			err = cpu_dai->driver->remove(cpu_dai);
 			if (err < 0)
-				printk(KERN_ERR "asoc: failed to remove %s\n", cpu_dai->name);
+				pr_err("asoc: failed to remove %s: %d\n",
+							cpu_dai->name, err);
 		}
 		cpu_dai->probed = 0;
 		list_del(&cpu_dai->card_list);
@@ -1213,8 +1216,8 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num, int order)
 		if (cpu_dai->driver->probe) {
 			ret = cpu_dai->driver->probe(cpu_dai);
 			if (ret < 0) {
-				printk(KERN_ERR "asoc: failed to probe CPU DAI %s\n",
-						cpu_dai->name);
+				pr_err("asoc: failed to probe CPU DAI %s: %d\n",
+							cpu_dai->name, ret);
 				module_put(cpu_dai->dev->driver->owner);
 				return ret;
 			}
@@ -1245,8 +1248,8 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num, int order)
 		if (codec_dai->driver->probe) {
 			ret = codec_dai->driver->probe(codec_dai);
 			if (ret < 0) {
-				printk(KERN_ERR "asoc: failed to probe CODEC DAI %s\n",
-						codec_dai->name);
+				pr_err("asoc: failed to probe CODEC DAI %s: %d\n",
+							codec_dai->name, ret);
 				return ret;
 			}
 		}
@@ -1266,12 +1269,13 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num, int order)
 
 	ret = device_create_file(rtd->dev, &dev_attr_pmdown_time);
 	if (ret < 0)
-		printk(KERN_WARNING "asoc: failed to add pmdown_time sysfs\n");
+		pr_warn("asoc: failed to add pmdown_time sysfs:%d\n", ret);
 
 	/* create the pcm */
 	ret = soc_new_pcm(rtd, num);
 	if (ret < 0) {
-		printk(KERN_ERR "asoc: can't create pcm %s\n", dai_link->stream_name);
+		pr_err("asoc: can't create pcm %s :%d\n",
+				dai_link->stream_name, ret);
 		return ret;
 	}
 
@@ -1304,7 +1308,7 @@ static int soc_register_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
 
 		ret = soc_ac97_dev_register(rtd->codec);
 		if (ret < 0) {
-			printk(KERN_ERR "asoc: AC97 device register failed\n");
+			pr_err("asoc: AC97 device register failed:%d\n", ret);
 			return ret;
 		}
 
@@ -1444,8 +1448,8 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	ret = snd_card_create(SNDRV_DEFAULT_IDX1, SNDRV_DEFAULT_STR1,
 			card->owner, 0, &card->snd_card);
 	if (ret < 0) {
-		printk(KERN_ERR "asoc: can't create sound card for card %s\n",
-			card->name);
+		pr_err("asoc: can't create sound card for card %s: %d\n",
+			card->name, ret);
 		mutex_unlock(&card->mutex);
 		return;
 	}
@@ -1563,7 +1567,8 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 
 	ret = snd_card_register(card->snd_card);
 	if (ret < 0) {
-		printk(KERN_ERR "asoc: failed to register soundcard for %s\n", card->name);
+		pr_err("asoc: failed to register soundcard for %s: %d\n",
+							card->name, ret);
 		goto probe_aux_dev_err;
 	}
 
@@ -1572,7 +1577,8 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 	for (i = 0; i < card->num_rtd; i++) {
 		ret = soc_register_ac97_dai_link(&card->rtd[i]);
 		if (ret < 0) {
-			printk(KERN_ERR "asoc: failed to register AC97 %s\n", card->name);
+			pr_err("asoc: failed to register AC97 %s: %d\n",
+							card->name, ret);
 			while (--i >= 0)
 				soc_unregister_ac97_dai_link(card->rtd[i].codec);
 			goto probe_aux_dev_err;
@@ -3070,7 +3076,7 @@ static inline char *fmt_multiple_name(struct device *dev,
 		struct snd_soc_dai_driver *dai_drv)
 {
 	if (dai_drv->name == NULL) {
-		printk(KERN_ERR "asoc: error - multiple DAI %s registered with no name\n",
+		pr_err("asoc: error - multiple DAI %s registered with no name\n",
 				dev_name(dev));
 		return NULL;
 	}
@@ -3542,8 +3548,7 @@ static int __init snd_soc_init(void)
 #ifdef CONFIG_DEBUG_FS
 	snd_soc_debugfs_root = debugfs_create_dir("asoc", NULL);
 	if (IS_ERR(snd_soc_debugfs_root) || !snd_soc_debugfs_root) {
-		printk(KERN_WARNING
-		       "ASoC: Failed to create debugfs directory\n");
+		pr_warn("ASoC: Failed to create debugfs directory\n");
 		snd_soc_debugfs_root = NULL;
 	}
 
-- 
1.7.1
