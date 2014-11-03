From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: Remove snd_soc_platform_driver
	suspend/resume callbacks
Date: Mon,  3 Nov 2014 10:31:47 +0100
Message-ID: <1415007108-18895-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-246.synserver.de (smtp-out-246.synserver.de
 [212.40.185.246])
 by alsa0.perex.cz (Postfix) with ESMTP id 580DF26047B
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 10:31:49 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Those are unused and new drivers should use device driver suspend/resume.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |  4 ----
 sound/soc/soc-core.c | 10 ----------
 2 files changed, 14 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index ad47e96..edbb07b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -857,8 +857,6 @@ struct snd_soc_platform_driver {
 
 	int (*probe)(struct snd_soc_platform *);
 	int (*remove)(struct snd_soc_platform *);
-	int (*suspend)(struct snd_soc_dai *dai);
-	int (*resume)(struct snd_soc_dai *dai);
 	struct snd_soc_component_driver component_driver;
 
 	/* pcm creation and destruction */
@@ -891,8 +889,6 @@ struct snd_soc_platform {
 	struct device *dev;
 	const struct snd_soc_platform_driver *driver;
 
-	unsigned int suspended:1; /* platform is suspended */
-
 	struct list_head list;
 
 	struct snd_soc_component component;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index dd8234d..00e944e 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -592,17 +592,12 @@ int snd_soc_suspend(struct device *dev)
 
 	for (i = 0; i < card->num_rtd; i++) {
 		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
-		struct snd_soc_platform *platform = card->rtd[i].platform;
 
 		if (card->rtd[i].dai_link->ignore_suspend)
 			continue;
 
 		if (cpu_dai->driver->suspend && !cpu_dai->driver->ac97_control)
 			cpu_dai->driver->suspend(cpu_dai);
-		if (platform->driver->suspend && !platform->suspended) {
-			platform->driver->suspend(cpu_dai);
-			platform->suspended = 1;
-		}
 	}
 
 	/* close any waiting streams and save state */
@@ -775,17 +770,12 @@ static void soc_resume_deferred(struct work_struct *work)
 
 	for (i = 0; i < card->num_rtd; i++) {
 		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
-		struct snd_soc_platform *platform = card->rtd[i].platform;
 
 		if (card->rtd[i].dai_link->ignore_suspend)
 			continue;
 
 		if (cpu_dai->driver->resume && !cpu_dai->driver->ac97_control)
 			cpu_dai->driver->resume(cpu_dai);
-		if (platform->driver->resume && platform->suspended) {
-			platform->driver->resume(cpu_dai);
-			platform->suspended = 0;
-		}
 	}
 
 	if (card->resume_post)
-- 
1.8.0
