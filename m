From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 01/11] ASoC: Move name_prefix from CODEC to
	component
Date: Mon, 16 Jun 2014 18:13:01 +0200
Message-ID: <1402935191-18398-2-git-send-email-lars@metafoo.de>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-035.synserver.de (smtp-out-035.synserver.de
 [212.40.185.35])
 by alsa0.perex.cz (Postfix) with ESMTP id 194D1265466
 for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2014 18:13:22 +0200 (CEST)
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

Move the name_prefix from the CODEC struct to the component struct. This will
eventually allow to specify prefixes for all types of components. It is also
necessary to make the DAPM code component type independent (i.e. a DAPM context
does not need to know whether it belongs to a CODEC or a platform or something
else).

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |  2 +-
 sound/soc/soc-core.c | 12 ++++++------
 sound/soc/soc-dapm.c | 36 ++++++++++++++++++++++--------------
 3 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index ed9e2d7..e1cce00 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -682,6 +682,7 @@ struct snd_soc_component_driver {
 struct snd_soc_component {
 	const char *name;
 	int id;
+	const char *name_prefix;
 	struct device *dev;
 
 	unsigned int active;
@@ -710,7 +711,6 @@ struct snd_soc_component {
 /* SoC Audio Codec device */
 struct snd_soc_codec {
 	const char *name;
-	const char *name_prefix;
 	int id;
 	struct device *dev;
 	const struct snd_soc_codec_driver *driver;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b87d7d8..ba822e9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1108,7 +1108,7 @@ static void soc_remove_dai_links(struct snd_soc_card *card)
 }
 
 static void soc_set_name_prefix(struct snd_soc_card *card,
-				struct snd_soc_codec *codec)
+				struct snd_soc_component *component)
 {
 	int i;
 
@@ -1117,11 +1117,11 @@ static void soc_set_name_prefix(struct snd_soc_card *card,
 
 	for (i = 0; i < card->num_configs; i++) {
 		struct snd_soc_codec_conf *map = &card->codec_conf[i];
-		if (map->of_node && codec->dev->of_node != map->of_node)
+		if (map->of_node && component->dev->of_node != map->of_node)
 			continue;
-		if (map->dev_name && strcmp(codec->name, map->dev_name))
+		if (map->dev_name && strcmp(component->name, map->dev_name))
 			continue;
-		codec->name_prefix = map->name_prefix;
+		component->name_prefix = map->name_prefix;
 		break;
 	}
 }
@@ -1135,7 +1135,7 @@ static int soc_probe_codec(struct snd_soc_card *card,
 
 	codec->card = card;
 	codec->dapm.card = card;
-	soc_set_name_prefix(card, codec);
+	soc_set_name_prefix(card, &codec->component);
 
 	if (!try_module_get(codec->dev->driver->owner))
 		return -ENODEV;
@@ -2403,7 +2403,7 @@ int snd_soc_add_codec_controls(struct snd_soc_codec *codec,
 	struct snd_card *card = codec->card->snd_card;
 
 	return snd_soc_add_controls(card, codec->dev, controls, num_controls,
-			codec->name_prefix, &codec->component);
+			codec->component.name_prefix, &codec->component);
 }
 EXPORT_SYMBOL_GPL(snd_soc_add_codec_controls);
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index cdc837e..8e08ace 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -375,6 +375,13 @@ static void dapm_reset(struct snd_soc_card *card)
 	}
 }
 
+static const char *soc_dapm_prefix(struct snd_soc_dapm_context *dapm)
+{
+	if (!dapm->component)
+		return NULL;
+	return dapm->component->name_prefix;
+}
+
 static int soc_widget_read(struct snd_soc_dapm_widget *w, int reg,
 	unsigned int *value)
 {
@@ -570,11 +577,7 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 	const char *name;
 	int ret;
 
-	if (dapm->codec)
-		prefix = dapm->codec->name_prefix;
-	else
-		prefix = NULL;
-
+	prefix = soc_dapm_prefix(dapm);
 	if (prefix)
 		prefix_len = strlen(prefix) + 1;
 	else
@@ -2371,14 +2374,16 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	const char *source;
 	char prefixed_sink[80];
 	char prefixed_source[80];
+	const char *prefix;
 	int ret;
 
-	if (dapm->codec && dapm->codec->name_prefix) {
+	prefix = soc_dapm_prefix(dapm);
+	if (prefix) {
 		snprintf(prefixed_sink, sizeof(prefixed_sink), "%s %s",
-			 dapm->codec->name_prefix, route->sink);
+			 prefix, route->sink);
 		sink = prefixed_sink;
 		snprintf(prefixed_source, sizeof(prefixed_source), "%s %s",
-			 dapm->codec->name_prefix, route->source);
+			 prefix, route->source);
 		source = prefixed_source;
 	} else {
 		sink = route->sink;
@@ -2439,6 +2444,7 @@ static int snd_soc_dapm_del_route(struct snd_soc_dapm_context *dapm,
 	const char *source;
 	char prefixed_sink[80];
 	char prefixed_source[80];
+	const char *prefix;
 
 	if (route->control) {
 		dev_err(dapm->dev,
@@ -2446,12 +2452,13 @@ static int snd_soc_dapm_del_route(struct snd_soc_dapm_context *dapm,
 		return -EINVAL;
 	}
 
-	if (dapm->codec && dapm->codec->name_prefix) {
+	prefix = soc_dapm_prefix(dapm);
+	if (prefix) {
 		snprintf(prefixed_sink, sizeof(prefixed_sink), "%s %s",
-			 dapm->codec->name_prefix, route->sink);
+			 prefix, route->sink);
 		sink = prefixed_sink;
 		snprintf(prefixed_source, sizeof(prefixed_source), "%s %s",
-			 dapm->codec->name_prefix, route->source);
+			 prefix, route->source);
 		source = prefixed_source;
 	} else {
 		sink = route->sink;
@@ -2971,6 +2978,7 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 			 const struct snd_soc_dapm_widget *widget)
 {
 	struct snd_soc_dapm_widget *w;
+	const char *prefix;
 	int ret;
 
 	if ((w = dapm_cnew_widget(widget)) == NULL)
@@ -3011,9 +3019,9 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 		break;
 	}
 
-	if (dapm->codec && dapm->codec->name_prefix)
-		w->name = kasprintf(GFP_KERNEL, "%s %s",
-			dapm->codec->name_prefix, widget->name);
+	prefix = soc_dapm_prefix(dapm);
+	if (prefix)
+		w->name = kasprintf(GFP_KERNEL, "%s %s", prefix, widget->name);
 	else
 		w->name = kasprintf(GFP_KERNEL, "%s", widget->name);
 
-- 
1.8.0
