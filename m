From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 07/11] ASoC: Use component DAPM context for
	platforms
Date: Mon, 16 Jun 2014 18:13:07 +0200
Message-ID: <1402935191-18398-8-git-send-email-lars@metafoo.de>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-035.synserver.de (smtp-out-035.synserver.de
 [212.40.185.35])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AA1626549A
 for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2014 18:13:27 +0200 (CEST)
In-Reply-To: <1402935191-18398-1-git-send-email-lars@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The snd_soc_platform dapm field is not accessed outside of the ASoC core. Switch
it over to using the snd_soc_component DAPM context.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |  4 +---
 sound/soc/soc-core.c | 25 ++++++++++++-------------
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a21dfec..84ebc07 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -862,8 +862,6 @@ struct snd_soc_platform {
 
 	struct snd_soc_component component;
 
-	struct snd_soc_dapm_context dapm;
-
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_platform_root;
 #endif
@@ -1203,7 +1201,7 @@ static inline struct snd_soc_codec *snd_soc_dapm_to_codec(
 static inline struct snd_soc_platform *snd_soc_dapm_to_platform(
 	struct snd_soc_dapm_context *dapm)
 {
-	return container_of(dapm, struct snd_soc_platform, dapm);
+	return snd_soc_component_to_platform(snd_soc_dapm_to_component(dapm));
 }
 
 /**
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f519a9f..711e99c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -314,7 +314,7 @@ static void soc_init_platform_debugfs(struct snd_soc_platform *platform)
 		return;
 	}
 
-	snd_soc_dapm_debugfs_init(&platform->dapm,
+	snd_soc_dapm_debugfs_init(&platform->component.dapm,
 		platform->debugfs_platform_root);
 }
 
@@ -974,7 +974,7 @@ static int soc_remove_platform(struct snd_soc_platform *platform)
 	}
 
 	/* Make sure all DAPM widgets are freed */
-	snd_soc_dapm_free(&platform->dapm);
+	snd_soc_dapm_free(&platform->component.dapm);
 
 	soc_cleanup_platform_debugfs(platform);
 	platform->probed = 0;
@@ -1210,7 +1210,7 @@ static int soc_probe_platform(struct snd_soc_card *card,
 	struct snd_soc_dai *dai;
 
 	platform->card = card;
-	platform->dapm.card = card;
+	platform->component.dapm.card = card;
 
 	if (!try_module_get(platform->dev->driver->owner))
 		return -ENODEV;
@@ -1218,7 +1218,7 @@ static int soc_probe_platform(struct snd_soc_card *card,
 	soc_init_platform_debugfs(platform);
 
 	if (driver->dapm_widgets)
-		snd_soc_dapm_new_controls(&platform->dapm,
+		snd_soc_dapm_new_controls(&platform->component.dapm,
 			driver->dapm_widgets, driver->num_dapm_widgets);
 
 	/* Create DAPM widgets for each DAI stream */
@@ -1226,10 +1226,11 @@ static int soc_probe_platform(struct snd_soc_card *card,
 		if (component->dev != platform->dev)
 			continue;
 		list_for_each_entry(dai, &component->dai_list, list)
-			snd_soc_dapm_new_dai_widgets(&platform->dapm, dai);
+			snd_soc_dapm_new_dai_widgets(&platform->component.dapm,
+				dai);
 	}
 
-	platform->dapm.idle_bias_off = 1;
+	platform->component.dapm.idle_bias_off = 1;
 
 	if (driver->probe) {
 		ret = driver->probe(platform);
@@ -1244,13 +1245,13 @@ static int soc_probe_platform(struct snd_soc_card *card,
 		snd_soc_add_platform_controls(platform, driver->controls,
 				     driver->num_controls);
 	if (driver->dapm_routes)
-		snd_soc_dapm_add_routes(&platform->dapm, driver->dapm_routes,
-					driver->num_dapm_routes);
+		snd_soc_dapm_add_routes(&platform->component.dapm,
+			driver->dapm_routes, driver->num_dapm_routes);
 
 	/* mark platform as probed and add to card platform list */
 	platform->probed = 1;
 	list_add(&platform->card_list, &card->platform_dev_list);
-	list_add(&platform->dapm.list, &card->dapm_list);
+	list_add(&platform->component.dapm.list, &card->dapm_list);
 
 	return 0;
 
@@ -4141,8 +4142,6 @@ int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 {
 	int ret;
 
-	platform->component.dapm_ptr = &platform->dapm;
-
 	ret = snd_soc_component_initialize(&platform->component,
 			&platform_drv->component_driver, dev);
 	if (ret)
@@ -4150,8 +4149,8 @@ int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 
 	platform->dev = dev;
 	platform->driver = platform_drv;
-	platform->dapm.platform = platform;
-	platform->dapm.stream_event = platform_drv->stream_event;
+	platform->component.dapm.platform = platform;
+	platform->component.dapm.stream_event = platform_drv->stream_event;
 	if (platform_drv->write)
 		platform->component.write = snd_soc_platform_drv_write;
 	if (platform_drv->read)
-- 
1.8.0
