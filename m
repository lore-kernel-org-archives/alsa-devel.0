From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] ASoC: Move non-shared code paths out of
	snd_soc_post_component_init()
Date: Tue,  1 Jul 2014 22:13:48 +0200
Message-ID: <1404245628-30877-5-git-send-email-lars@metafoo.de>
References: <1404245628-30877-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-155.synserver.de (smtp-out-155.synserver.de
 [212.40.185.155])
 by alsa0.perex.cz (Postfix) with ESMTP id 633912650E1
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 22:14:01 +0200 (CEST)
In-Reply-To: <1404245628-30877-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Sebastian Reichel <sre@kernel.org>, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

There are two call sites for snd_soc_post_component_init(), one passes 0 and the
other 1 for the 'dailess' parameter of snd_soc_post_component_init(). Depending
on whether 'dailess' is 0 or 1 snd_soc_post_component_init() runs different code
at the beginning and the end of the function. The patch moves this conditional
code out of snd_soc_post_component_init() and into the call sites. This removes
the need for snd_soc_post_component_init() to know whether it is called for a
DAI link or a aux dev.

Also do the initialization of rtd->card when the rtd struct is allocated.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 121 ++++++++++++++++++++-------------------------------
 1 file changed, 46 insertions(+), 75 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0b870bb..6712e2f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1286,74 +1286,17 @@ static void rtd_release(struct device *dev)
 	kfree(dev);
 }
 
-static int soc_aux_dev_init(struct snd_soc_card *card, int num)
+static int soc_post_component_init(struct snd_soc_pcm_runtime *rtd,
+	const char *name)
 {
-	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
-	struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
-	int ret;
-
-	rtd->card = card;
-
-	/* do machine specific initialization */
-	if (aux_dev->init) {
-		ret = aux_dev->init(&rtd->codec->dapm);
-		if (ret < 0)
-			return ret;
-	}
-
-	return 0;
-}
-
-static int soc_dai_link_init(struct snd_soc_card *card, int num)
-{
-	struct snd_soc_dai_link *dai_link =  &card->dai_link[num];
-	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
-	int ret;
-
-	rtd->card = card;
-
-	/* do machine specific initialization */
-	if (dai_link->init) {
-		ret = dai_link->init(rtd);
-		if (ret < 0)
-			return ret;
-	}
-
-	return 0;
-}
-
-static int soc_post_component_init(struct snd_soc_card *card,
-				   int num, int dailess)
-{
-	struct snd_soc_dai_link *dai_link = NULL;
-	struct snd_soc_aux_dev *aux_dev = NULL;
-	struct snd_soc_pcm_runtime *rtd;
-	const char *name;
 	int ret = 0;
 
-	if (!dailess) {
-		dai_link = &card->dai_link[num];
-		rtd = &card->rtd[num];
-		name = dai_link->name;
-		ret = soc_dai_link_init(card, num);
-	} else {
-		aux_dev = &card->aux_dev[num];
-		rtd = &card->rtd_aux[num];
-		name = aux_dev->name;
-		ret = soc_aux_dev_init(card, num);
-	}
-
-	if (ret < 0) {
-		dev_err(card->dev, "ASoC: failed to init %s: %d\n", name, ret);
-		return ret;
-	}
-
 	/* register the rtd device */
 	rtd->dev = kzalloc(sizeof(struct device), GFP_KERNEL);
 	if (!rtd->dev)
 		return -ENOMEM;
 	device_initialize(rtd->dev);
-	rtd->dev->parent = card->dev;
+	rtd->dev->parent = rtd->card->dev;
 	rtd->dev->release = rtd_release;
 	rtd->dev->init_name = name;
 	dev_set_drvdata(rtd->dev, rtd);
@@ -1366,7 +1309,7 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	if (ret < 0) {
 		/* calling put_device() here to free the rtd->dev */
 		put_device(rtd->dev);
-		dev_err(card->dev,
+		dev_err(rtd->card->dev,
 			"ASoC: failed to register runtime device: %d\n", ret);
 		return ret;
 	}
@@ -1384,17 +1327,6 @@ static int soc_post_component_init(struct snd_soc_card *card,
 		dev_err(rtd->dev,
 			"ASoC: failed to add codec sysfs files: %d\n", ret);
 
-#ifdef CONFIG_DEBUG_FS
-	/* add DPCM sysfs entries */
-	if (!dailess && !dai_link->dynamic)
-		goto out;
-
-	ret = soc_dpcm_debugfs_add(rtd);
-	if (ret < 0)
-		dev_err(rtd->dev, "ASoC: failed to add dpcm sysfs entries: %d\n", ret);
-
-out:
-#endif
 	return 0;
 }
 
@@ -1546,10 +1478,33 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 	if (order != SND_SOC_COMP_ORDER_LAST)
 		return 0;
 
-	ret = soc_post_component_init(card, num, 0);
+	/* do machine specific initialization */
+	if (dai_link->init) {
+		ret = dai_link->init(rtd);
+		if (ret < 0) {
+			dev_err(card->dev, "ASoC: failed to init %s: %d\n",
+				dai_link->name, ret);
+			return ret;
+		}
+	}
+
+	ret = soc_post_component_init(rtd, dai_link->name);
 	if (ret)
 		return ret;
 
+#ifdef CONFIG_DEBUG_FS
+	/* add DPCM sysfs entries */
+	if (dai_link->dynamic) {
+		ret = soc_dpcm_debugfs_add(rtd);
+		if (ret < 0) {
+			dev_err(rtd->dev,
+				"ASoC: failed to add dpcm sysfs entries: %d\n",
+				ret);
+			return ret;
+		}
+	}
+#endif
+
 	ret = device_create_file(rtd->dev, &dev_attr_pmdown_time);
 	if (ret < 0)
 		dev_warn(rtd->dev, "ASoC: failed to add pmdown_time sysfs: %d\n",
@@ -1665,6 +1620,7 @@ static int soc_bind_aux_dev(struct snd_soc_card *card, int num)
 static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
+	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
 	int ret;
 
 	if (rtd->codec->probed) {
@@ -1676,7 +1632,17 @@ static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
 	if (ret < 0)
 		return ret;
 
-	return soc_post_component_init(card, num, 1);
+	/* do machine specific initialization */
+	if (aux_dev->init) {
+		ret = aux_dev->init(&rtd->codec->dapm);
+		if (ret < 0) {
+			dev_err(card->dev, "ASoC: failed to init %s: %d\n",
+				aux_dev->name, ret);
+			return ret;
+		}
+	}
+
+	return soc_post_component_init(rtd, aux_dev->name);
 }
 
 static void soc_remove_aux_dev(struct snd_soc_card *card, int num)
@@ -3775,8 +3741,13 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	card->num_rtd = 0;
 	card->rtd_aux = &card->rtd[card->num_links];
 
-	for (i = 0; i < card->num_links; i++)
+	for (i = 0; i < card->num_links; i++) {
+		card->rtd[i].card = card;
 		card->rtd[i].dai_link = &card->dai_link[i];
+	}
+
+	for (i = 0; i < card->num_aux_devs; i++)
+		card->rtd_aux[i].card = card;
 
 	INIT_LIST_HEAD(&card->dapm_dirty);
 	card->instantiated = 0;
-- 
1.8.0
