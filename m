From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH 1/4] ASoC: soc core move card cleanup from
	soc_remove()
Date: Thu, 13 Jan 2011 22:48:02 +0530
Message-ID: <1294939082-26350-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id EDF52103B1B
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 18:16:10 +0100 (CET)
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

In soc_remove() the card resources are cleaned up.
This can also be done in card_unregister()

This patch move this cleanup into a new function and calls it from
card_unregister. This paves way for further work to allow card registartion
from machine.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/soc-core.c |   51 ++++++++++++++++++++++++++++---------------------
 1 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 30d76e8..318c3a7 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1890,37 +1890,42 @@ static int soc_probe(struct platform_device *pdev)
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
 
-		/* remove the card */
-		if (card->remove)
-			card->remove(pdev);
+	kfree(card->rtd);
+	snd_card_free(card->snd_card);
+	return 0;
+
+}
+
+/* removes a socdev */
+static int soc_remove(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
-		kfree(card->rtd);
-		snd_card_free(card->snd_card);
-	}
 	snd_soc_unregister_card(card);
 	return 0;
 }
@@ -3153,6 +3158,8 @@ static int snd_soc_register_card(struct snd_soc_card *card)
  */
 static int snd_soc_unregister_card(struct snd_soc_card *card)
 {
+	if (card->instantiated)
+		soc_cleanup_card_resources(card);
 	mutex_lock(&client_mutex);
 	list_del(&card->list);
 	mutex_unlock(&client_mutex);
-- 
1.7.2.3
