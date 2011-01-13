From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH 3/4] ASoC: soc core add inline to handle card
	list initialzation
Date: Thu, 13 Jan 2011 22:48:52 +0530
Message-ID: <1294939132-26412-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 1863A103B20
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 18:16:49 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, Harsha Priya <harsha.priya@intel.com>, broonie@opensource.wolfsonmicro.com, selma.bensaid@intel.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

Currently the soc_probe initializes the card hence it does the card list
initialzation. But if machines directly register the card they would need to
do these steps, so putting them as inline would save lot of code

This patch adds an inline to do list initialzation

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <harsha.priya@intel.com>
---
 include/sound/soc.h  |   10 ++++++++++
 sound/soc/soc-core.c |    7 +------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index accb8a1..541ddfa 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -779,6 +779,16 @@ static inline void *snd_soc_pcm_get_drvdata(struct snd_soc_pcm_runtime *rtd)
 	return dev_get_drvdata(&rtd->dev);
 }
 
+static inline void snd_soc_initialize_card_lists(struct snd_soc_card *card)
+{
+	INIT_LIST_HEAD(&card->dai_dev_list);
+	INIT_LIST_HEAD(&card->codec_dev_list);
+	INIT_LIST_HEAD(&card->platform_dev_list);
+	INIT_LIST_HEAD(&card->widgets);
+	INIT_LIST_HEAD(&card->paths);
+	INIT_LIST_HEAD(&card->dapm_list);
+}
+
 #include <sound/soc-dai.h>
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9c5e7cf..8305712 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1872,12 +1872,7 @@ static int soc_probe(struct platform_device *pdev)
 
 	/* Bodge while we unpick instantiation */
 	card->dev = &pdev->dev;
-	INIT_LIST_HEAD(&card->dai_dev_list);
-	INIT_LIST_HEAD(&card->codec_dev_list);
-	INIT_LIST_HEAD(&card->platform_dev_list);
-	INIT_LIST_HEAD(&card->widgets);
-	INIT_LIST_HEAD(&card->paths);
-	INIT_LIST_HEAD(&card->dapm_list);
+	snd_soc_initialize_card_lists(card);
 
 	ret = snd_soc_register_card(card);
 	if (ret != 0) {
-- 
1.7.2.3
