From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 08/10] ASoC: dapm: Add snd_soc_dapm_add_path()
	helper function
Date: Mon, 29 Jul 2013 17:14:02 +0200
Message-ID: <1375110845-8069-8-git-send-email-lars@metafoo.de>
References: <1375110845-8069-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-130.synserver.de (smtp-out-134.synserver.de
 [212.40.185.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 03F2126262B
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 17:13:16 +0200 (CEST)
In-Reply-To: <1375110845-8069-1-git-send-email-lars@metafoo.de>
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

snd_soc_dapm_add_path() is similar to snd_soc_dapm_add_route() except that it
expects the pointer to the source and sink widgets instead of their names. This
allows us to simplify the case where we already have a pointer to widgets. (E.g.
as we have in snd_soc_dapm_link_dai_widgets()). snd_soc_dapm_add_route() will be
updated to just look up the widget and then use snd_soc_dapm_add_path() to
handle everything else.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 151 +++++++++++++++++++++++++++------------------------
 1 file changed, 81 insertions(+), 70 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 59bcc66..b811a27 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2263,64 +2263,14 @@ int snd_soc_dapm_sync(struct snd_soc_dapm_context *dapm)
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_sync);
 
-static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
-				  const struct snd_soc_dapm_route *route)
+static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
+	struct snd_soc_dapm_widget *wsource, struct snd_soc_dapm_widget *wsink,
+	const char *control,
+	int (*connected)(struct snd_soc_dapm_widget *source,
+			 struct snd_soc_dapm_widget *sink))
 {
 	struct snd_soc_dapm_path *path;
-	struct snd_soc_dapm_widget *wsource = NULL, *wsink = NULL, *w;
-	struct snd_soc_dapm_widget *wtsource = NULL, *wtsink = NULL;
-	const char *sink;
-	const char *control = route->control;
-	const char *source;
-	char prefixed_sink[80];
-	char prefixed_source[80];
-	int ret = 0;
-
-	if (dapm->codec && dapm->codec->name_prefix) {
-		snprintf(prefixed_sink, sizeof(prefixed_sink), "%s %s",
-			 dapm->codec->name_prefix, route->sink);
-		sink = prefixed_sink;
-		snprintf(prefixed_source, sizeof(prefixed_source), "%s %s",
-			 dapm->codec->name_prefix, route->source);
-		source = prefixed_source;
-	} else {
-		sink = route->sink;
-		source = route->source;
-	}
-
-	/*
-	 * find src and dest widgets over all widgets but favor a widget from
-	 * current DAPM context
-	 */
-	list_for_each_entry(w, &dapm->card->widgets, list) {
-		if (!wsink && !(strcmp(w->name, sink))) {
-			wtsink = w;
-			if (w->dapm == dapm)
-				wsink = w;
-			continue;
-		}
-		if (!wsource && !(strcmp(w->name, source))) {
-			wtsource = w;
-			if (w->dapm == dapm)
-				wsource = w;
-		}
-	}
-	/* use widget from another DAPM context if not found from this */
-	if (!wsink)
-		wsink = wtsink;
-	if (!wsource)
-		wsource = wtsource;
-
-	if (wsource == NULL) {
-		dev_err(dapm->dev, "ASoC: no source widget found for %s\n",
-			route->source);
-		return -ENODEV;
-	}
-	if (wsink == NULL) {
-		dev_err(dapm->dev, "ASoC: no sink widget found for %s\n",
-			route->sink);
-		return -ENODEV;
-	}
+	int ret;
 
 	path = kzalloc(sizeof(struct snd_soc_dapm_path), GFP_KERNEL);
 	if (!path)
@@ -2328,7 +2278,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 
 	path->source = wsource;
 	path->sink = wsink;
-	path->connected = route->connected;
+	path->connected = connected;
 	INIT_LIST_HEAD(&path->list);
 	INIT_LIST_HEAD(&path->list_source);
 	INIT_LIST_HEAD(&path->list_sink);
@@ -2414,11 +2364,77 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	dapm_mark_dirty(wsink, "Route added");
 
 	return 0;
+err:
+	kfree(path);
+	return ret;
+}
 
+static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
+				  const struct snd_soc_dapm_route *route)
+{
+	struct snd_soc_dapm_widget *wsource = NULL, *wsink = NULL, *w;
+	struct snd_soc_dapm_widget *wtsource = NULL, *wtsink = NULL;
+	const char *sink;
+	const char *source;
+	char prefixed_sink[80];
+	char prefixed_source[80];
+	int ret;
+
+	if (dapm->codec && dapm->codec->name_prefix) {
+		snprintf(prefixed_sink, sizeof(prefixed_sink), "%s %s",
+			 dapm->codec->name_prefix, route->sink);
+		sink = prefixed_sink;
+		snprintf(prefixed_source, sizeof(prefixed_source), "%s %s",
+			 dapm->codec->name_prefix, route->source);
+		source = prefixed_source;
+	} else {
+		sink = route->sink;
+		source = route->source;
+	}
+
+	/*
+	 * find src and dest widgets over all widgets but favor a widget from
+	 * current DAPM context
+	 */
+	list_for_each_entry(w, &dapm->card->widgets, list) {
+		if (!wsink && !(strcmp(w->name, sink))) {
+			wtsink = w;
+			if (w->dapm == dapm)
+				wsink = w;
+			continue;
+		}
+		if (!wsource && !(strcmp(w->name, source))) {
+			wtsource = w;
+			if (w->dapm == dapm)
+				wsource = w;
+		}
+	}
+	/* use widget from another DAPM context if not found from this */
+	if (!wsink)
+		wsink = wtsink;
+	if (!wsource)
+		wsource = wtsource;
+
+	if (wsource == NULL) {
+		dev_err(dapm->dev, "ASoC: no source widget found for %s\n",
+			route->source);
+		return -ENODEV;
+	}
+	if (wsink == NULL) {
+		dev_err(dapm->dev, "ASoC: no sink widget found for %s\n",
+			route->sink);
+		return -ENODEV;
+	}
+
+	ret = snd_soc_dapm_add_path(dapm, wsource, wsink, route->control,
+		route->connected);
+	if (ret)
+		goto err;
+
+	return 0;
 err:
 	dev_warn(dapm->dev, "ASoC: no dapm match for %s --> %s --> %s\n",
-		 source, control, sink);
-	kfree(path);
+		 source, route->control, sink);
 	return ret;
 }
 
@@ -3421,9 +3437,6 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 {
 	struct snd_soc_dapm_widget *dai_w, *w;
 	struct snd_soc_dai *dai;
-	struct snd_soc_dapm_route r;
-
-	memset(&r, 0, sizeof(r));
 
 	/* For each DAI widget... */
 	list_for_each_entry(dai_w, &card->widgets, list) {
@@ -3456,23 +3469,21 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 			if (dai->driver->playback.stream_name &&
 			    strstr(w->sname,
 				   dai->driver->playback.stream_name)) {
-				r.source = dai->playback_widget->name;
-				r.sink = w->name;
 				dev_dbg(dai->dev, "%s -> %s\n",
-					 r.source, r.sink);
+					 dai->playback_widget->name, w->name);
 
-				snd_soc_dapm_add_route(w->dapm, &r);
+				snd_soc_dapm_add_path(w->dapm,
+					dai->playback_widget, w, NULL, NULL);
 			}
 
 			if (dai->driver->capture.stream_name &&
 			    strstr(w->sname,
 				   dai->driver->capture.stream_name)) {
-				r.source = w->name;
-				r.sink = dai->capture_widget->name;
 				dev_dbg(dai->dev, "%s -> %s\n",
-					r.source, r.sink);
+					w->name, dai->capture_widget->name);
 
-				snd_soc_dapm_add_route(w->dapm, &r);
+				snd_soc_dapm_add_path(w->dapm, w,
+					dai->capture_widget, NULL, NULL);
 			}
 		}
 	}
-- 
1.8.0
