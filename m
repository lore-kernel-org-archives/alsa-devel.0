From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Dynamically allocate the rtd device for
	a non-empty release
Date: Sun,  8 Jan 2012 23:02:30 -0800
Message-ID: <1326092550-22306-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1190B243C2
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 08:02:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Greg KH <greg@kroah.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

Greg, you asked for this to be included in 3.3 but I really don't see
any reason for doing so - this isn't exactly new code and there aren't
any practical issues being reported.  Is there any actual rush?

 include/sound/soc.h  |    6 +++---
 sound/soc/soc-core.c |   34 +++++++++++++++++++++-------------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a7425e9..0a56767 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -862,7 +862,7 @@ struct snd_soc_card {
 
 /* SoC machine DAI configuration, glues a codec and cpu DAI together */
 struct snd_soc_pcm_runtime {
-	struct device dev;
+	struct device *dev;
 	struct snd_soc_card *card;
 	struct snd_soc_dai_link *dai_link;
 	struct mutex pcm_mutex;
@@ -954,12 +954,12 @@ static inline void *snd_soc_platform_get_drvdata(struct snd_soc_platform *platfo
 static inline void snd_soc_pcm_set_drvdata(struct snd_soc_pcm_runtime *rtd,
 		void *data)
 {
-	dev_set_drvdata(&rtd->dev, data);
+	dev_set_drvdata(rtd->dev, data);
 }
 
 static inline void *snd_soc_pcm_get_drvdata(struct snd_soc_pcm_runtime *rtd)
 {
-	return dev_get_drvdata(&rtd->dev);
+	return dev_get_drvdata(rtd->dev);
 }
 
 static inline void snd_soc_initialize_card_lists(struct snd_soc_card *card)
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index dcc4b62..9d8a631 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -884,9 +884,9 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num, int order)
 
 	/* unregister the rtd device */
 	if (rtd->dev_registered) {
-		device_remove_file(&rtd->dev, &dev_attr_pmdown_time);
-		device_remove_file(&rtd->dev, &dev_attr_codec_reg);
-		device_unregister(&rtd->dev);
+		device_remove_file(rtd->dev, &dev_attr_pmdown_time);
+		device_remove_file(rtd->dev, &dev_attr_codec_reg);
+		device_unregister(rtd->dev);
 		rtd->dev_registered = 0;
 	}
 
@@ -1061,7 +1061,10 @@ err_probe:
 	return ret;
 }
 
-static void rtd_release(struct device *dev) {}
+static void rtd_release(struct device *dev)
+{
+	kfree(dev);
+}
 
 static int soc_post_component_init(struct snd_soc_card *card,
 				   struct snd_soc_codec *codec,
@@ -1104,11 +1107,16 @@ static int soc_post_component_init(struct snd_soc_card *card,
 
 	/* register the rtd device */
 	rtd->codec = codec;
-	rtd->dev.parent = card->dev;
-	rtd->dev.release = rtd_release;
-	rtd->dev.init_name = name;
+
+	rtd->dev = kzalloc(sizeof(struct device), GFP_KERNEL);
+	if (!rtd->dev)
+		return -ENOMEM;
+	device_initialize(rtd->dev);
+	rtd->dev->parent = card->dev;
+	rtd->dev->release = rtd_release;
+	rtd->dev->init_name = name;
 	mutex_init(&rtd->pcm_mutex);
-	ret = device_register(&rtd->dev);
+	ret = device_add(rtd->dev);
 	if (ret < 0) {
 		dev_err(card->dev,
 			"asoc: failed to register runtime device: %d\n", ret);
@@ -1117,14 +1125,14 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	rtd->dev_registered = 1;
 
 	/* add DAPM sysfs entries for this codec */
-	ret = snd_soc_dapm_sys_add(&rtd->dev);
+	ret = snd_soc_dapm_sys_add(rtd->dev);
 	if (ret < 0)
 		dev_err(codec->dev,
 			"asoc: failed to add codec dapm sysfs entries: %d\n",
 			ret);
 
 	/* add codec sysfs entries */
-	ret = device_create_file(&rtd->dev, &dev_attr_codec_reg);
+	ret = device_create_file(rtd->dev, &dev_attr_codec_reg);
 	if (ret < 0)
 		dev_err(codec->dev,
 			"asoc: failed to add codec sysfs files: %d\n", ret);
@@ -1213,7 +1221,7 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num, int order)
 	if (ret)
 		return ret;
 
-	ret = device_create_file(&rtd->dev, &dev_attr_pmdown_time);
+	ret = device_create_file(rtd->dev, &dev_attr_pmdown_time);
 	if (ret < 0)
 		printk(KERN_WARNING "asoc: failed to add pmdown_time sysfs\n");
 
@@ -1311,8 +1319,8 @@ static void soc_remove_aux_dev(struct snd_soc_card *card, int num)
 
 	/* unregister the rtd device */
 	if (rtd->dev_registered) {
-		device_remove_file(&rtd->dev, &dev_attr_codec_reg);
-		device_unregister(&rtd->dev);
+		device_remove_file(rtd->dev, &dev_attr_codec_reg);
+		device_del(rtd->dev);
 		rtd->dev_registered = 0;
 	}
 
-- 
1.7.7.3
