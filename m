From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] ASoC: Use card field to indicate whether a
	component is bound
Date: Wed,  8 Jul 2015 20:47:44 +0200
Message-ID: <1436381264-6924-2-git-send-email-lars@metafoo.de>
References: <1436381264-6924-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-104.synserver.de (smtp-out-104.synserver.de
 [212.40.185.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 25148265A1D
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 20:47:52 +0200 (CEST)
In-Reply-To: <1436381264-6924-1-git-send-email-lars@metafoo.de>
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

Use the card field of a component to indicate whether it is bound or not.
This makes a certain sense given that the field contains the card the
component is bound to and a component can only be bound to one card at a
time. And it also requires to unset the card field when the component is
unbound from the card.

This makes the probded flag redundant and it can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |  1 -
 sound/soc/soc-core.c | 16 ++++++++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 3ccd82a..ab69e26 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -758,7 +758,6 @@ struct snd_soc_component {
 
 	unsigned int ignore_pmdown_time:1; /* pmdown_time is ignored at stop */
 	unsigned int registered_as_component:1;
-	unsigned int probed:1;
 
 	struct list_head list;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index d9ae826..2fc461c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -980,7 +980,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 
 static void soc_remove_component(struct snd_soc_component *component)
 {
-	if (!component->probed)
+	if (!component->card)
 		return;
 
 	/* This is a HACK and will be removed soon */
@@ -993,7 +993,7 @@ static void soc_remove_component(struct snd_soc_component *component)
 	snd_soc_dapm_free(snd_soc_component_get_dapm(component));
 
 	soc_cleanup_component_debugfs(component);
-	component->probed = 0;
+	component->card = NULL;
 	module_put(component->dev->driver->owner);
 }
 
@@ -1107,7 +1107,7 @@ static int soc_probe_component(struct snd_soc_card *card,
 	if (!strcmp(component->name, "snd-soc-dummy"))
 		return 0;
 
-	if (component->probed) {
+	if (component->card) {
 		if (component->card != card) {
 			dev_err(component->dev,
 				"Trying to bind component to card \"%s\" but is already bound to card \"%s\"\n",
@@ -1117,13 +1117,13 @@ static int soc_probe_component(struct snd_soc_card *card,
 		return 0;
 	}
 
+	if (!try_module_get(component->dev->driver->owner))
+		return -ENODEV;
+
 	component->card = card;
 	dapm->card = card;
 	soc_set_name_prefix(card, component);
 
-	if (!try_module_get(component->dev->driver->owner))
-		return -ENODEV;
-
 	soc_init_component_debugfs(component);
 
 	if (component->dapm_widgets) {
@@ -1167,7 +1167,6 @@ static int soc_probe_component(struct snd_soc_card *card,
 		snd_soc_dapm_add_routes(dapm, component->dapm_routes,
 					component->num_dapm_routes);
 
-	component->probed = 1;
 	list_add(&dapm->list, &card->dapm_list);
 
 	/* This is a HACK and will be removed soon */
@@ -1178,6 +1177,7 @@ static int soc_probe_component(struct snd_soc_card *card,
 
 err_probe:
 	soc_cleanup_component_debugfs(component);
+	component->card = NULL;
 	module_put(component->dev->driver->owner);
 
 	return ret;
@@ -1461,7 +1461,7 @@ static void soc_remove_aux_dev(struct snd_soc_card *card, int num)
 		rtd->dev_registered = 0;
 	}
 
-	if (component && component->probed)
+	if (component)
 		soc_remove_component(component);
 }
 
-- 
2.1.4
