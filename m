From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: dapm: Allow routes to be deleted at
	runtime
Date: Thu,  5 Jul 2012 17:27:59 +0100
Message-ID: <1341505680-10802-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1341505680-10802-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 14E5B24456
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2012 18:30:05 +0200 (CEST)
In-Reply-To: <1341505680-10802-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Since we're now relying on DAPM for things like enabling clocks when we
reparent the clocks for widgets we need to either use conditional routes
(which are expensive) or remove routes at runtime. Add a route removal
API to support this use case.

Currently only unconditional routes are supported.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    2 ++
 sound/soc/soc-dapm.c     |   77 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 05559e5..abe373d 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -374,6 +374,8 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm);
 void snd_soc_dapm_free(struct snd_soc_dapm_context *dapm);
 int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 			    const struct snd_soc_dapm_route *route, int num);
+int snd_soc_dapm_del_routes(struct snd_soc_dapm_context *dapm,
+			    const struct snd_soc_dapm_route *route, int num);
 int snd_soc_dapm_weak_routes(struct snd_soc_dapm_context *dapm,
 			     const struct snd_soc_dapm_route *route, int num);
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index beac5e6..5a0fc86 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2263,6 +2263,59 @@ err:
 	return ret;
 }
 
+static int snd_soc_dapm_del_route(struct snd_soc_dapm_context *dapm,
+				  const struct snd_soc_dapm_route *route)
+{
+	struct snd_soc_dapm_path *path, *p;
+	const char *sink;
+	const char *source;
+	char prefixed_sink[80];
+	char prefixed_source[80];
+
+	if (route->control) {
+		dev_err(dapm->dev,
+			"Removal of routes with controls not supported\n");
+		return -EINVAL;
+	}
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
+	path = NULL;
+	list_for_each_entry(p, &dapm->card->paths, list) {
+		if (strcmp(p->source->name, source) != 0)
+			continue;
+		if (strcmp(p->sink->name, sink) != 0)
+			continue;
+		path = p;
+		break;
+	}
+
+	if (path) {
+		dapm_mark_dirty(path->source, "Route removed");
+		dapm_mark_dirty(path->sink, "Route removed");
+
+		list_del(&path->list);
+		list_del(&path->list_sink);
+		list_del(&path->list_source);
+		kfree(path);
+	} else {
+		dev_warn(dapm->dev, "Route %s->%s does not exist\n",
+			 source, sink);
+	}
+
+	return 0;
+}
+
 /**
  * snd_soc_dapm_add_routes - Add routes between DAPM widgets
  * @dapm: DAPM context
@@ -2297,6 +2350,30 @@ int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_add_routes);
 
+/**
+ * snd_soc_dapm_del_routes - Remove routes between DAPM widgets
+ * @dapm: DAPM context
+ * @route: audio routes
+ * @num: number of routes
+ *
+ * Removes routes from the DAPM context.
+ */
+int snd_soc_dapm_del_routes(struct snd_soc_dapm_context *dapm,
+			    const struct snd_soc_dapm_route *route, int num)
+{
+	int i, ret = 0;
+
+	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
+	for (i = 0; i < num; i++) {
+		snd_soc_dapm_del_route(dapm, route);
+		route++;
+	}
+	mutex_unlock(&dapm->card->dapm_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_del_routes);
+
 static int snd_soc_dapm_weak_route(struct snd_soc_dapm_context *dapm,
 				   const struct snd_soc_dapm_route *route)
 {
-- 
1.7.10
