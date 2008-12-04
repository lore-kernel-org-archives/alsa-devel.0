From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: Remove device from platform suspend
	and resume operations
Date: Thu,  4 Dec 2008 11:26:44 +0000
Message-ID: <1228390006-30338-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081204112542.GA30250@rakim.wolfsonmicro.main>
	<1228390006-30338-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AE93324152
	for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2008 12:26:47 +0100 (CET)
In-Reply-To: <1228390006-30338-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

None of the platforms are actually using the SoC device so remove it
(only atmel actually has a suspend method).

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h         |    6 ++----
 sound/soc/atmel/atmel-pcm.c |    6 ++----
 sound/soc/soc-core.c        |    4 ++--
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 3ee608d..8ec63c0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -300,10 +300,8 @@ struct snd_soc_platform {
 
 	int (*probe)(struct platform_device *pdev);
 	int (*remove)(struct platform_device *pdev);
-	int (*suspend)(struct platform_device *pdev,
-		struct snd_soc_dai *dai);
-	int (*resume)(struct platform_device *pdev,
-		struct snd_soc_dai *dai);
+	int (*suspend)(struct snd_soc_dai *dai);
+	int (*resume)(struct snd_soc_dai *dai);
 
 	/* pcm creation and destruction */
 	int (*pcm_new)(struct snd_card *, struct snd_soc_dai *,
diff --git a/sound/soc/atmel/atmel-pcm.c b/sound/soc/atmel/atmel-pcm.c
index 394412f..8507aa1 100644
--- a/sound/soc/atmel/atmel-pcm.c
+++ b/sound/soc/atmel/atmel-pcm.c
@@ -417,8 +417,7 @@ static void atmel_pcm_free_dma_buffers(struct snd_pcm *pcm)
 }
 
 #ifdef CONFIG_PM
-static int atmel_pcm_suspend(struct platform_device *pdev,
-	struct snd_soc_dai *dai)
+static int atmel_pcm_suspend(struct snd_soc_dai *dai)
 {
 	struct snd_pcm_runtime *runtime = dai->runtime;
 	struct atmel_runtime_data *prtd;
@@ -442,8 +441,7 @@ static int atmel_pcm_suspend(struct platform_device *pdev,
 	return 0;
 }
 
-static int atmel_pcm_resume(struct platform_device *pdev,
-	struct snd_soc_dai *dai)
+static int atmel_pcm_resume(struct snd_soc_dai *dai)
 {
 	struct snd_pcm_runtime *runtime = dai->runtime;
 	struct atmel_runtime_data *prtd;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3411439..f83852f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -652,7 +652,7 @@ static int soc_suspend(struct platform_device *pdev, pm_message_t state)
 		if (cpu_dai->suspend && !cpu_dai->ac97_control)
 			cpu_dai->suspend(pdev, cpu_dai);
 		if (platform->suspend)
-			platform->suspend(pdev, cpu_dai);
+			platform->suspend(cpu_dai);
 	}
 
 	/* close any waiting streams and save state */
@@ -741,7 +741,7 @@ static void soc_resume_deferred(struct work_struct *work)
 		if (cpu_dai->resume && !cpu_dai->ac97_control)
 			cpu_dai->resume(pdev, cpu_dai);
 		if (platform->resume)
-			platform->resume(pdev, cpu_dai);
+			platform->resume(cpu_dai);
 	}
 
 	if (card->resume_post)
-- 
1.5.6.5
