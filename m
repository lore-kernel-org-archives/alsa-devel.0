From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: Use card rather than soc-audio
	device to card PM functions
Date: Wed, 26 Jan 2011 17:08:27 +0000
Message-ID: <1296061709-12494-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 08A8924599
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 18:08:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

The platform device for the card is tied closely to the soc-audio
implementation which we're currently trying to remove in favour of
allowing cards to have their own devices. Begin removing it by
replacing it with the card in the suspend and resume callbacks we
give to cards, also taking the opportunity to remove the legacy
suspend types which are currently hard coded anyway.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h      |    8 ++++----
 sound/soc/pxa/raumfeld.c |    4 ++--
 sound/soc/pxa/zylonite.c |    5 ++---
 sound/soc/soc-core.c     |    9 ++++-----
 4 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 00c6fba..d1cc1a2 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -655,10 +655,10 @@ struct snd_soc_card {
 
 	/* the pre and post PM functions are used to do any PM work before and
 	 * after the codec and DAI's do any PM work. */
-	int (*suspend_pre)(struct platform_device *pdev, pm_message_t state);
-	int (*suspend_post)(struct platform_device *pdev, pm_message_t state);
-	int (*resume_pre)(struct platform_device *pdev);
-	int (*resume_post)(struct platform_device *pdev);
+	int (*suspend_pre)(struct snd_soc_card *card);
+	int (*suspend_post)(struct snd_soc_card *card);
+	int (*resume_pre)(struct snd_soc_card *card);
+	int (*resume_post)(struct snd_soc_card *card);
 
 	/* callbacks */
 	int (*set_bias_level)(struct snd_soc_card *,
diff --git a/sound/soc/pxa/raumfeld.c b/sound/soc/pxa/raumfeld.c
index 0fd60f4..db1dd56 100644
--- a/sound/soc/pxa/raumfeld.c
+++ b/sound/soc/pxa/raumfeld.c
@@ -151,13 +151,13 @@ static struct snd_soc_ops raumfeld_cs4270_ops = {
 	.hw_params = raumfeld_cs4270_hw_params,
 };
 
-static int raumfeld_line_suspend(struct platform_device *pdev, pm_message_t state)
+static int raumfeld_line_suspend(struct snd_soc_card *card)
 {
 	raumfeld_enable_audio(false);
 	return 0;
 }
 
-static int raumfeld_line_resume(struct platform_device *pdev)
+static int raumfeld_line_resume(struct snd_soc_card *card)
 {
 	raumfeld_enable_audio(true);
 	return 0;
diff --git a/sound/soc/pxa/zylonite.c b/sound/soc/pxa/zylonite.c
index b222a7d..7b72901 100644
--- a/sound/soc/pxa/zylonite.c
+++ b/sound/soc/pxa/zylonite.c
@@ -226,8 +226,7 @@ static int zylonite_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int zylonite_suspend_post(struct platform_device *pdev,
-				 pm_message_t state)
+static int zylonite_suspend_post(struct snd_soc_card *card)
 {
 	if (clk_pout)
 		clk_disable(pout);
@@ -235,7 +234,7 @@ static int zylonite_suspend_post(struct platform_device *pdev,
 	return 0;
 }
 
-static int zylonite_resume_pre(struct platform_device *pdev)
+static int zylonite_resume_pre(struct snd_soc_card *card)
 {
 	int ret = 0;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 14861f9..446838e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1011,7 +1011,7 @@ static int soc_suspend(struct device *dev)
 	}
 
 	if (card->suspend_pre)
-		card->suspend_pre(pdev, PMSG_SUSPEND);
+		card->suspend_pre(card);
 
 	for (i = 0; i < card->num_rtd; i++) {
 		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
@@ -1078,7 +1078,7 @@ static int soc_suspend(struct device *dev)
 	}
 
 	if (card->suspend_post)
-		card->suspend_post(pdev, PMSG_SUSPEND);
+		card->suspend_post(card);
 
 	return 0;
 }
@@ -1090,7 +1090,6 @@ static void soc_resume_deferred(struct work_struct *work)
 {
 	struct snd_soc_card *card =
 			container_of(work, struct snd_soc_card, deferred_resume_work);
-	struct platform_device *pdev = to_platform_device(card->dev);
 	struct snd_soc_codec *codec;
 	int i;
 
@@ -1104,7 +1103,7 @@ static void soc_resume_deferred(struct work_struct *work)
 	snd_power_change_state(card->snd_card, SNDRV_CTL_POWER_D2);
 
 	if (card->resume_pre)
-		card->resume_pre(pdev);
+		card->resume_pre(card);
 
 	/* resume AC97 DAIs */
 	for (i = 0; i < card->num_rtd; i++) {
@@ -1179,7 +1178,7 @@ static void soc_resume_deferred(struct work_struct *work)
 	}
 
 	if (card->resume_post)
-		card->resume_post(pdev);
+		card->resume_post(card);
 
 	dev_dbg(card->dev, "resume work completed\n");
 
-- 
1.7.2.3
