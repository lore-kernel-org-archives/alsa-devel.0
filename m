From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] ASoC: dapm: Add helper function to free a
	widget
Date: Tue, 21 Jul 2015 18:11:07 +0200
Message-ID: <1437495068-4104-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-101.synserver.de (smtp-out-101.synserver.de
 [212.40.185.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FFF0260560
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 18:11:12 +0200 (CEST)
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

snd_soc_tplg_widget_remove_all() has a verbatim copy of an older version of
the widget freeing code from dapm_free_widgets(). Add a new helper function
that takes care of freeing a widget and use it in both places.

This removes the duplicated code and also makes sure that future changes to
the widget freeing code only have to be made in one location.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Series depends on fix/dapm
---
 include/sound/soc-dapm.h |  1 +
 sound/soc/soc-dapm.c     | 38 ++++++++++++++++++++++----------------
 sound/soc/soc-topology.c | 25 +------------------------
 3 files changed, 24 insertions(+), 40 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 37d95a8..cadc7fc 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -397,6 +397,7 @@ int snd_soc_dapm_del_routes(struct snd_soc_dapm_context *dapm,
 			    const struct snd_soc_dapm_route *route, int num);
 int snd_soc_dapm_weak_routes(struct snd_soc_dapm_context *dapm,
 			     const struct snd_soc_dapm_route *route, int num);
+void snd_soc_dapm_free_widget(struct snd_soc_dapm_widget *w);
 
 /* dapm events */
 void snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1992568..7a57b01 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2315,30 +2315,36 @@ static void dapm_free_path(struct snd_soc_dapm_path *path)
 	kfree(path);
 }
 
+void snd_soc_dapm_free_widget(struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_dapm_path *p, *next_p;
+
+	list_del(&w->list);
+	/*
+	 * remove source and sink paths associated to this widget.
+	 * While removing the path, remove reference to it from both
+	 * source and sink widgets so that path is removed only once.
+	 */
+	list_for_each_entry_safe(p, next_p, &w->sources, list_sink)
+		dapm_free_path(p);
+
+	list_for_each_entry_safe(p, next_p, &w->sinks, list_source)
+		dapm_free_path(p);
+
+	kfree(w->kcontrols);
+	kfree(w->name);
+	kfree(w);
+}
+
 /* free all dapm widgets and resources */
 static void dapm_free_widgets(struct snd_soc_dapm_context *dapm)
 {
 	struct snd_soc_dapm_widget *w, *next_w;
-	struct snd_soc_dapm_path *p, *next_p;
 
 	list_for_each_entry_safe(w, next_w, &dapm->card->widgets, list) {
 		if (w->dapm != dapm)
 			continue;
-		list_del(&w->list);
-		/*
-		 * remove source and sink paths associated to this widget.
-		 * While removing the path, remove reference to it from both
-		 * source and sink widgets so that path is removed only once.
-		 */
-		list_for_each_entry_safe(p, next_p, &w->sources, list_sink)
-			dapm_free_path(p);
-
-		list_for_each_entry_safe(p, next_p, &w->sinks, list_source)
-			dapm_free_path(p);
-
-		kfree(w->kcontrols);
-		kfree(w->name);
-		kfree(w);
+		snd_soc_dapm_free_widget(w);
 	}
 }
 
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 4a838e4..df3ddf0 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1734,7 +1734,6 @@ void snd_soc_tplg_widget_remove_all(struct snd_soc_dapm_context *dapm,
 	u32 index)
 {
 	struct snd_soc_dapm_widget *w, *next_w;
-	struct snd_soc_dapm_path *p, *next_p;
 
 	list_for_each_entry_safe(w, next_w, &dapm->card->widgets, list) {
 
@@ -1746,31 +1745,9 @@ void snd_soc_tplg_widget_remove_all(struct snd_soc_dapm_context *dapm,
 		if (w->dobj.index != index &&
 			w->dobj.index != SND_SOC_TPLG_INDEX_ALL)
 			continue;
-
-		list_del(&w->list);
-
-		/*
-		 * remove source and sink paths associated to this widget.
-		 * While removing the path, remove reference to it from both
-		 * source and sink widgets so that path is removed only once.
-		 */
-		list_for_each_entry_safe(p, next_p, &w->sources, list_sink) {
-			list_del(&p->list_sink);
-			list_del(&p->list_source);
-			list_del(&p->list);
-			kfree(p);
-		}
-		list_for_each_entry_safe(p, next_p, &w->sinks, list_source) {
-			list_del(&p->list_sink);
-			list_del(&p->list_source);
-			list_del(&p->list);
-			kfree(p);
-		}
 		/* check and free and dynamic widget kcontrols */
 		snd_soc_tplg_widget_remove(w);
-		kfree(w->kcontrols);
-		kfree(w->name);
-		kfree(w);
+		snd_soc_dapm_free_widget(w);
 	}
 }
 EXPORT_SYMBOL_GPL(snd_soc_tplg_widget_remove_all);
-- 
2.1.4
