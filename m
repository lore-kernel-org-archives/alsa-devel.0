From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2] ASoC: dapm: Add cache to speed up adding of
	routes
Date: Mon, 11 May 2015 13:50:30 +0100
Message-ID: <1431348630-23462-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 93C8B261AA5
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 14:59:46 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Some CODECs have a significant number of DAPM routes and for each route,
when it is added to the card, the entire card widget list must be
searched. When adding routes it is very likely, however, that adjacent
routes will require adjacent widgets. For example all the routes for a
mux are likely added in a block and the sink widget will be the same
each time and it is also quite likely that the source widgets are
sequential located in the widget list.

This patch adds a cache to the DAPM context, this cache will hold the
source and sink widgets from the last call to snd_soc_dapm_add_route for
that context. A small search of the widget list will be made from those
points for both the sink and source. Currently this search only checks
both the last widget and the one adjacent to it.

On wm8280 which has approximately 500 widgets and 30000 routes (one of
the largest CODECs in mainline), the number of paths that hit the cache
is 24000, which significantly improves probe time.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

Changes since v1:
 - Provide better encapsulation of the cache, to make swapping out the
   implementation simpler
 - Put the cache in the DAPM context instead of passing explicitly to
   snd_soc_dapm_add_route. I went with the context over the card as it
   is likely that requests on the same context will hit the cache in
   the case we have multiple context's interleaving requests.

I hope you don't mind Lars but I didn't pull your reviewed-by forward
as the code has changed quite a bit for what you reviewed.

Thanks,
Charles

 include/sound/soc-dapm.h |    7 +++++++
 sound/soc/soc-dapm.c     |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index bfc415e..2f66e1c 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -593,6 +593,10 @@ struct snd_soc_dapm_update {
 	int val;
 };
 
+struct snd_soc_dapm_wcache {
+	struct snd_soc_dapm_widget *widget;
+};
+
 /* DAPM context */
 struct snd_soc_dapm_context {
 	enum snd_soc_bias_level bias_level;
@@ -614,6 +618,9 @@ struct snd_soc_dapm_context {
 	int (*set_bias_level)(struct snd_soc_dapm_context *dapm,
 			      enum snd_soc_bias_level level);
 
+	struct snd_soc_dapm_wcache path_sink_cache;
+	struct snd_soc_dapm_wcache path_source_cache;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dapm;
 #endif
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7654161..327f9357 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -572,6 +572,35 @@ static void soc_dapm_async_complete(struct snd_soc_dapm_context *dapm)
 		snd_soc_component_async_complete(dapm->component);
 }
 
+static struct snd_soc_dapm_widget *
+dapm_wcache_lookup(struct snd_soc_dapm_wcache *wcache, const char *name)
+{
+	struct snd_soc_dapm_widget *w = wcache->widget;
+	struct list_head *wlist;
+	const int depth = 2;
+	int i = 0;
+
+	if (w) {
+		wlist = &w->dapm->card->widgets;
+
+		list_for_each_entry_from(w, wlist, list) {
+			if (!strcmp(name, w->name))
+				return w;
+
+			if (++i == depth)
+				break;
+		}
+	}
+
+	return NULL;
+}
+
+static inline void dapm_wcache_update(struct snd_soc_dapm_wcache *wcache,
+				      struct snd_soc_dapm_widget *w)
+{
+	wcache->widget = w;
+}
+
 /**
  * snd_soc_dapm_force_bias_level() - Sets the DAPM bias level
  * @dapm: The DAPM context for which to set the level
@@ -2610,6 +2639,12 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 		source = route->source;
 	}
 
+	wsource = dapm_wcache_lookup(&dapm->path_source_cache, source);
+	wsink = dapm_wcache_lookup(&dapm->path_sink_cache, sink);
+
+	if (wsink && wsource)
+		goto skip_search;
+
 	/*
 	 * find src and dest widgets over all widgets but favor a widget from
 	 * current DAPM context
@@ -2644,6 +2679,10 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 		return -ENODEV;
 	}
 
+skip_search:
+	dapm_wcache_update(&dapm->path_sink_cache, wsink);
+	dapm_wcache_update(&dapm->path_source_cache, wsource);
+
 	ret = snd_soc_dapm_add_path(dapm, wsource, wsink, route->control,
 		route->connected);
 	if (ret)
-- 
1.7.2.5
