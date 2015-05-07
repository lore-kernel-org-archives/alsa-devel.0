From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: dapm: Add cache to speed up adding
	of routes
Date: Thu,  7 May 2015 11:33:59 +0100
Message-ID: <1430994839-32584-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1430994839-32584-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B9A052606A5
 for <alsa-devel@alsa-project.org>; Thu,  7 May 2015 12:42:46 +0200 (CEST)
In-Reply-To: <1430994839-32584-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

This patch adds an optional cache argument to snd_soc_dapm_add_route, if
given, this argument will hold the source and sink widgets from the last
call to snd_soc_dapm_add_route. A small search of the widget list will
be made from those points for both the sink and source. Currently this
search only checks both the last widget and the one adjacent to it.

On wm8280 which has approximately 500 widgets and 30000 routes (one of
the largest CODECs in mainline), the number of paths that hit the cache
is 24000, which significantly improves probe time.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   40 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ea3348e..95d3ea5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2585,8 +2585,26 @@ err:
 	return ret;
 }
 
+static struct snd_soc_dapm_widget *
+dapm_check_path_cache(const char *name, struct snd_soc_dapm_widget *w, int n)
+{
+	int i;
+
+	if (w) {
+		for (i = 0; i < n; i++) {
+			if (!strcmp(name, w->name))
+				return w;
+
+			w = list_next_entry(w, list);
+		}
+	}
+
+	return NULL;
+}
+
 static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
-				  const struct snd_soc_dapm_route *route)
+				  const struct snd_soc_dapm_route *route,
+				  struct snd_soc_dapm_path *cache)
 {
 	struct snd_soc_dapm_widget *wsource = NULL, *wsink = NULL, *w;
 	struct snd_soc_dapm_widget *wtsource = NULL, *wtsink = NULL;
@@ -2610,6 +2628,14 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 		source = route->source;
 	}
 
+	if (cache) {
+		wsink = dapm_check_path_cache(sink, cache->sink, 2);
+		wsource = dapm_check_path_cache(source, cache->source, 2);
+
+		if (wsink && wsource)
+			goto skip_search;
+	}
+
 	/*
 	 * find src and dest widgets over all widgets but favor a widget from
 	 * current DAPM context
@@ -2650,6 +2676,12 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 		return -ENODEV;
 	}
 
+skip_search:
+	if (cache) {
+		cache->sink = wsink;
+		cache->source = wsource;
+	}
+
 	ret = snd_soc_dapm_add_path(dapm, wsource, wsink, route->control,
 		route->connected);
 	if (ret)
@@ -2741,10 +2773,14 @@ int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 			    const struct snd_soc_dapm_route *route, int num)
 {
 	int i, r, ret = 0;
+	struct snd_soc_dapm_path cache = {
+		.source = NULL,
+		.sink = NULL,
+	};
 
 	mutex_lock_nested(&dapm->card->dapm_mutex, SND_SOC_DAPM_CLASS_INIT);
 	for (i = 0; i < num; i++) {
-		r = snd_soc_dapm_add_route(dapm, route);
+		r = snd_soc_dapm_add_route(dapm, route, &cache);
 		if (r < 0) {
 			dev_err(dapm->dev, "ASoC: Failed to add route %s -> %s -> %s\n",
 				route->source,
-- 
1.7.2.5
