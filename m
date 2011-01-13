From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH] ASoC: Make register_card API available to
	drivers
Date: Thu, 13 Jan 2011 12:19:18 +0530
Message-ID: <1294901358-14364-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id B3AAA2433F
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 07:47:33 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, Harsha Priya <priya.harsha@intel.com>, broonie@opensource.wolfsonmicro.com, selma.bensaid@intel.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

The register_card is an internal API which soc_probe uses to register the card.
In order to create multiple cards we need to create multiple instances of
soc-audio device. If we exposes the register card API for drivers to use, then
machine driver can register their cards directly

This patch makes register_card and unregister_card API available to machine
drivers. This also maintains compatibility with older method of registration
which can be marked depreciated and removed eventually.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 include/sound/soc.h  |    2 +
 sound/soc/soc-core.c |   90 +++++++++++++++++++++++++++----------------------
 2 files changed, 52 insertions(+), 40 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d609232..b515eb6 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -258,6 +258,8 @@ enum snd_soc_compress_type {
 	SND_SOC_RBTREE_COMPRESSION
 };
 
+int snd_soc_register_card(struct snd_soc_card *card);
+int snd_soc_unregister_card(struct snd_soc_card *card);
 int snd_soc_register_platform(struct device *dev,
 		struct snd_soc_platform_driver *platform_drv);
 void snd_soc_unregister_platform(struct device *dev);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index cbac50b..0bd07f6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -58,8 +58,6 @@ static LIST_HEAD(dai_list);
 static LIST_HEAD(platform_list);
 static LIST_HEAD(codec_list);
 
-static int snd_soc_register_card(struct snd_soc_card *card);
-static int snd_soc_unregister_card(struct snd_soc_card *card);
 static int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num);
 
 /*
@@ -1870,16 +1868,12 @@ static int soc_probe(struct platform_device *pdev)
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	int ret = 0;
 
+	/* no card, so machine driver will register explictly */
+	if (!card)
+		return 0;
+
 	/* Bodge while we unpick instantiation */
 	card->dev = &pdev->dev;
-	INIT_LIST_HEAD(&card->dai_dev_list);
-	INIT_LIST_HEAD(&card->codec_dev_list);
-	INIT_LIST_HEAD(&card->platform_dev_list);
-	INIT_LIST_HEAD(&card->widgets);
-	INIT_LIST_HEAD(&card->paths);
-	INIT_LIST_HEAD(&card->dapm_list);
-
-	soc_init_card_debugfs(card);
 
 	ret = snd_soc_register_card(card);
 	if (ret != 0) {
@@ -1890,37 +1884,46 @@ static int soc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-/* removes a socdev */
-static int soc_remove(struct platform_device *pdev)
+static int soc_cleanup_card_resources(struct snd_soc_card *card)
 {
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
+	struct platform_device *pdev = to_platform_device(card->dev);
 	int i;
 
-	if (card->instantiated) {
+	/* make sure any delayed work runs */
+	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
+		flush_delayed_work_sync(&rtd->delayed_work);
+	}
 
-		/* make sure any delayed work runs */
-		for (i = 0; i < card->num_rtd; i++) {
-			struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
-			flush_delayed_work_sync(&rtd->delayed_work);
-		}
+	/* remove auxiliary devices */
+	for (i = 0; i < card->num_aux_devs; i++)
+		soc_remove_aux_dev(card, i);
 
-		/* remove auxiliary devices */
-		for (i = 0; i < card->num_aux_devs; i++)
-			soc_remove_aux_dev(card, i);
+	/* remove and free each DAI */
+	for (i = 0; i < card->num_rtd; i++)
+		soc_remove_dai_link(card, i);
 
-		/* remove and free each DAI */
-		for (i = 0; i < card->num_rtd; i++)
-			soc_remove_dai_link(card, i);
+	soc_cleanup_card_debugfs(card);
 
-		soc_cleanup_card_debugfs(card);
+	/* remove the card */
+	if (card->remove)
+		card->remove(pdev);
+
+	kfree(card->rtd);
+	snd_card_free(card->snd_card);
+	return 0;
 
-		/* remove the card */
-		if (card->remove)
-			card->remove(pdev);
+}
+
+/* removes a socdev */
+int soc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+
+	if (!card)
+		return 0;
 
-		kfree(card->rtd);
-		snd_card_free(card->snd_card);
-	}
 	snd_soc_unregister_card(card);
 	return 0;
 }
@@ -3107,17 +3110,23 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
  *
  * @card: Card to register
  *
- * Note that currently this is an internal only function: it will be
- * exposed to machine drivers after further backporting of ASoC v2
- * registration APIs.
  */
-static int snd_soc_register_card(struct snd_soc_card *card)
+int snd_soc_register_card(struct snd_soc_card *card)
 {
 	int i;
 
 	if (!card->name || !card->dev)
 		return -EINVAL;
 
+	INIT_LIST_HEAD(&card->dai_dev_list);
+	INIT_LIST_HEAD(&card->codec_dev_list);
+	INIT_LIST_HEAD(&card->platform_dev_list);
+	INIT_LIST_HEAD(&card->widgets);
+	INIT_LIST_HEAD(&card->paths);
+	INIT_LIST_HEAD(&card->dapm_list);
+
+	soc_init_card_debugfs(card);
+
 	card->rtd = kzalloc(sizeof(struct snd_soc_pcm_runtime) *
 			    (card->num_links + card->num_aux_devs),
 			    GFP_KERNEL);
@@ -3141,25 +3150,26 @@ static int snd_soc_register_card(struct snd_soc_card *card)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_soc_register_card);
 
 /**
  * snd_soc_unregister_card - Unregister a card with the ASoC core
  *
  * @card: Card to unregister
  *
- * Note that currently this is an internal only function: it will be
- * exposed to machine drivers after further backporting of ASoC v2
- * registration APIs.
  */
-static int snd_soc_unregister_card(struct snd_soc_card *card)
+int snd_soc_unregister_card(struct snd_soc_card *card)
 {
 	mutex_lock(&client_mutex);
 	list_del(&card->list);
 	mutex_unlock(&client_mutex);
+	if (card->instantiated)
+		soc_cleanup_card_resources(card);
 	dev_dbg(card->dev, "Unregistered card '%s'\n", card->name);
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_soc_unregister_card);
 
 /*
  * Simplify DAI link configuration by removing ".-1" from device names
-- 
1.7.2.3
