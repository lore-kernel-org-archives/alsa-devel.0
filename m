From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] ASoC: Remove per card platform list
Date: Thu, 17 Jul 2014 22:01:05 +0200
Message-ID: <1405627268-23939-2-git-send-email-lars@metafoo.de>
References: <1405627268-23939-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-180.synserver.de (smtp-out-180.synserver.de
 [212.40.185.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 85B0F26535D
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 22:01:07 +0200 (CEST)
In-Reply-To: <1405627268-23939-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

The platform_dev_list was added in commit f0fba2ad1b ("ASoC: multi-component -
ASoC Multi-Component Support") and while platforms are added and remove from
that list it is otherwise unused. This patch removes it again.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  | 3 ---
 sound/soc/soc-core.c | 2 --
 2 files changed, 5 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 96a5ff2..6a8d577 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -876,7 +876,6 @@ struct snd_soc_platform {
 
 	struct snd_soc_card *card;
 	struct list_head list;
-	struct list_head card_list;
 
 	struct snd_soc_component component;
 
@@ -1067,7 +1066,6 @@ struct snd_soc_card {
 
 	/* lists of probed devices belonging to this card */
 	struct list_head codec_dev_list;
-	struct list_head platform_dev_list;
 
 	struct list_head widgets;
 	struct list_head paths;
@@ -1313,7 +1311,6 @@ static inline void *snd_soc_pcm_get_drvdata(struct snd_soc_pcm_runtime *rtd)
 static inline void snd_soc_initialize_card_lists(struct snd_soc_card *card)
 {
 	INIT_LIST_HEAD(&card->codec_dev_list);
-	INIT_LIST_HEAD(&card->platform_dev_list);
 	INIT_LIST_HEAD(&card->widgets);
 	INIT_LIST_HEAD(&card->paths);
 	INIT_LIST_HEAD(&card->dapm_list);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9e4a23e..2cb2edd 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1027,7 +1027,6 @@ static int soc_remove_platform(struct snd_soc_platform *platform)
 
 	soc_cleanup_platform_debugfs(platform);
 	platform->probed = 0;
-	list_del(&platform->card_list);
 	module_put(platform->dev->driver->owner);
 
 	return 0;
@@ -1297,7 +1296,6 @@ static int soc_probe_platform(struct snd_soc_card *card,
 
 	/* mark platform as probed and add to card platform list */
 	platform->probed = 1;
-	list_add(&platform->card_list, &card->platform_dev_list);
 	list_add(&platform->component.dapm.list, &card->dapm_list);
 
 	return 0;
-- 
1.8.0
