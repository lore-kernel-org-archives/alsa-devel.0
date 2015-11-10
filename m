From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v2] ASoC: damp: Reset dapm wcache after freeing
	damp widgets
Date: Tue, 10 Nov 2015 18:12:42 +0200
Message-ID: <1447171962-15736-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id EDC66265218
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 17:12:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: peter.ujfalusi@ti.com, lars@metafoo.de, Jyri Sarha <jsarha@ti.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org, balbi@ti.com
List-Id: alsa-devel@alsa-project.org

If there is anything in damp->path_source_cache or
damp->path_sink_cache, it can not be valid after the widgets have been
freed. Without this patch a repeated remove and load of a machine
driver may cause NULL pointer reference in dapm_wcache_lookup() when a
freed widget, not belonging to any list, is haunting in the wcache.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
Reported-by: Felipe Balbi <balbi@ti.com>
---
The patch fixes the problem reported here:
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-October/099431.html

For v2, followed Lars-Peter's suggestion here:
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-November/100335.html

 include/sound/soc-dapm.h | 1 +
 sound/soc/soc-dapm.c     | 7 +++++++
 sound/soc/soc-topology.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 5abba03..ddcbe33 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -398,6 +398,7 @@ int snd_soc_dapm_del_routes(struct snd_soc_dapm_context *dapm,
 int snd_soc_dapm_weak_routes(struct snd_soc_dapm_context *dapm,
 			     const struct snd_soc_dapm_route *route, int num);
 void snd_soc_dapm_free_widget(struct snd_soc_dapm_widget *w);
+void snd_soc_dapm_reset_cache(struct snd_soc_dapm_context *dapm);
 
 /* dapm events */
 void snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index ff8bda4..945a792 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2276,6 +2276,12 @@ void snd_soc_dapm_free_widget(struct snd_soc_dapm_widget *w)
 	kfree(w);
 }
 
+void snd_soc_dapm_reset_cache(struct snd_soc_dapm_context *dapm)
+{
+	dapm->path_sink_cache.widget = NULL;
+	dapm->path_source_cache.widget = NULL;
+}
+
 /* free all dapm widgets and resources */
 static void dapm_free_widgets(struct snd_soc_dapm_context *dapm)
 {
@@ -2286,6 +2292,7 @@ static void dapm_free_widgets(struct snd_soc_dapm_context *dapm)
 			continue;
 		snd_soc_dapm_free_widget(w);
 	}
+	snd_soc_dapm_reset_cache(dapm);
 }
 
 static struct snd_soc_dapm_widget *dapm_find_widget(
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 69d01cd..c6ee033 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1805,6 +1805,7 @@ void snd_soc_tplg_widget_remove_all(struct snd_soc_dapm_context *dapm,
 		snd_soc_tplg_widget_remove(w);
 		snd_soc_dapm_free_widget(w);
 	}
+	snd_soc_dapm_reset_cache(dapm);
 }
 EXPORT_SYMBOL_GPL(snd_soc_tplg_widget_remove_all);
 
-- 
1.9.1
