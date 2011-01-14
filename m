From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH 4/4] ASoC: soc core allow machine driver to
	register the card
Date: Fri, 14 Jan 2011 19:22:48 +0530
Message-ID: <1295013168-29748-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 423D010384B
	for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2011 14:51:19 +0100 (CET)
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

The machine driver can't register the card directly and need to do this thru
soc-audio device creation

This patch allows the register and unregister card to be directly called by
machine drivers

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 include/sound/soc.h  |    2 ++
 sound/soc/soc-core.c |   21 +++++++++++----------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 541ddfa..9952254 100644
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
index 8305712..69117b6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -58,8 +58,6 @@ static LIST_HEAD(dai_list);
 static LIST_HEAD(platform_list);
 static LIST_HEAD(codec_list);
 
-static int snd_soc_register_card(struct snd_soc_card *card);
-static int snd_soc_unregister_card(struct snd_soc_card *card);
 static int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num);
 
 /*
@@ -1870,6 +1868,13 @@ static int soc_probe(struct platform_device *pdev)
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 	int ret = 0;
 
+	/*
+	 * no card, so machine driver should be registering card
+	 * we should not be here in that case so ret error
+	 */
+	if (!card)
+		return -EINVAL;
+
 	/* Bodge while we unpick instantiation */
 	card->dev = &pdev->dev;
 	snd_soc_initialize_card_lists(card);
@@ -3105,11 +3110,8 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
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
 
@@ -3141,17 +3143,15 @@ static int snd_soc_register_card(struct snd_soc_card *card)
 
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
 	if (card->instantiated)
 		soc_cleanup_card_resources(card);
@@ -3162,6 +3162,7 @@ static int snd_soc_unregister_card(struct snd_soc_card *card)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_soc_unregister_card);
 
 /*
  * Simplify DAI link configuration by removing ".-1" from device names
-- 
1.7.2.3
