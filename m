From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Add weak routes for sidetone style paths
Date: Mon, 13 Jun 2011 16:53:17 +0100
Message-ID: <1307980397-4035-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C253C24508
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Jun 2011 17:53:20 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Normally DAPM will power up any connected audio path. This is not ideal
for sidetone paths as with sidetone paths the audio path is not wanted in
itself, it is only desired if the two paths it provides a sidetone between
are both active. If the sidetone path causes a power up then it can be
hard to minimise pops as we first power up either the sidetone or the main
output path and then power the other, with the second power up potentially
introducing a DC offset.

Address this by introducing the concept of a weak path. If a path is marked
as weak then DAPM will ignore that path when walking the graph, though all
the relevant controls are still available to the application layer to allow
these paths to be configured.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dapm.h |    2 +
 sound/soc/soc-dapm.c     |   87 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 7415878..7c5465b 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -348,6 +348,8 @@ int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm);
 void snd_soc_dapm_free(struct snd_soc_dapm_context *dapm);
 int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 			    const struct snd_soc_dapm_route *route, int num);
+int snd_soc_dapm_weak_routes(struct snd_soc_dapm_context *dapm,
+			     const struct snd_soc_dapm_route *route, int num);
 
 /* dapm events */
 int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd,
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index fd2d774..746349f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -593,6 +593,9 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget)
 	}
 
 	list_for_each_entry(path, &widget->sinks, list_source) {
+		if (path->weak)
+			continue;
+
 		if (path->walked)
 			continue;
 
@@ -643,6 +646,9 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
 	}
 
 	list_for_each_entry(path, &widget->sources, list_sink) {
+		if (path->weak)
+			continue;
+
 		if (path->walked)
 			continue;
 
@@ -724,6 +730,9 @@ static int dapm_supply_check_power(struct snd_soc_dapm_widget *w)
 
 	/* Check if one of our outputs is connected */
 	list_for_each_entry(path, &w->sinks, list_source) {
+		if (path->weak)
+			continue;
+
 		if (path->connected &&
 		    !path->connected(path->source, path->sink))
 			continue;
@@ -1806,6 +1815,84 @@ int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_add_routes);
 
+static int snd_soc_dapm_weak_route(struct snd_soc_dapm_context *dapm,
+				   const struct snd_soc_dapm_route *route)
+{
+	struct snd_soc_dapm_widget *source = dapm_find_widget(dapm,
+							      route->source,
+							      true);
+	struct snd_soc_dapm_widget *sink = dapm_find_widget(dapm,
+							    route->sink,
+							    true);
+	struct snd_soc_dapm_path *path;
+	int count = 0;
+
+	if (!source) {
+		dev_err(dapm->dev, "Unable to find source %s for weak route\n",
+			route->source);
+		return -ENODEV;
+	}
+
+	if (!sink) {
+		dev_err(dapm->dev, "Unable to find sink %s for weak route\n",
+			route->sink);
+		return -ENODEV;
+	}
+
+	if (route->control || route->connected)
+		dev_warn(dapm->dev, "Ignoring control for weak route %s->%s\n",
+			 route->source, route->sink);
+
+	list_for_each_entry(path, &source->sinks, list_source) {
+		if (path->sink == sink) {
+			path->weak = 1;
+			count++;
+		}
+	}
+
+	if (count == 0)
+		dev_err(dapm->dev, "No path found for weak route %s->%s\n",
+			route->source, route->sink);
+	if (count > 1)
+		dev_warn(dapm->dev, "%d paths found for weak route %s->%s\n",
+			 count, route->source, route->sink);
+
+	return 0;
+}
+
+/**
+ * snd_soc_dapm_weak_routes - Mark routes between DAPM widgets as weak
+ * @dapm: DAPM context
+ * @route: audio routes
+ * @num: number of routes
+ *
+ * Mark existing routes matching those specified in the passed array
+ * as being weak, meaning that they are ignored for the purpose of
+ * power decisions.  The main intended use case is for sidetone paths
+ * which couple audio between other independent paths if they are both
+ * active in order to make the combination work better at the user
+ * level but which aren't intended to be "used".
+ *
+ * Note that CODEC drivers should not use this as sidetone type paths
+ * can frequently also be used as bypass paths.
+ */
+int snd_soc_dapm_weak_routes(struct snd_soc_dapm_context *dapm,
+			     const struct snd_soc_dapm_route *route, int num)
+{
+	int i, err;
+	int ret = 0;
+
+	for (i = 0; i < num; i++) {
+		err = snd_soc_dapm_weak_route(dapm, route);
+		if (err)
+			ret = err;
+		route++;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dapm_weak_routes);
+
 /**
  * snd_soc_dapm_new_widgets - add new dapm widgets
  * @dapm: DAPM context
-- 
1.7.5.4
