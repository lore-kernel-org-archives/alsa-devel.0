From: Szymon Mielczarek <szymonx.mielczarek@linux.intel.com>
Subject: [RFC PATCH] ASoC: dapm: Invalidate only paths reachable for a given stream
Date: Fri,  9 Aug 2019 10:40:34 +0200
Message-ID: <20190809084034.26220-1-szymonx.mielczarek@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Cezary Rojewski <cezary.rojewski@intel.com>, Szymon Mielczarek <szymonx.mielczarek@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

By resetting the cached number of endpoints for all card's widgets we may
overwrite previously cached values for other streams. The situation may
happen especially when running streams simultaneously.

Signed-off-by: Szymon Mielczarek <szymonx.mielczarek@linux.intel.com>
---
 sound/soc/soc-dapm.c | 50 ++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index d09bdca63c62..10819b3e0b98 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1128,6 +1128,34 @@ static int dapm_widget_list_create(struct snd_soc_dapm_widget_list **list,
 	return 0;
 }
 
+/*
+ * Recursively reset the cached number of inputs or outputs for the specified
+ * widget and all widgets that can be reached via incoming or outcoming paths
+ * from the widget.
+ */
+static void invalidate_paths_ep(struct snd_soc_dapm_widget *widget,
+	enum snd_soc_dapm_direction dir)
+{
+	enum snd_soc_dapm_direction rdir = SND_SOC_DAPM_DIR_REVERSE(dir);
+	struct snd_soc_dapm_path *path;
+
+	widget->endpoints[dir] = -1;
+
+	snd_soc_dapm_widget_for_each_path(widget, rdir, path) {
+		if (path->weak || path->is_supply)
+			continue;
+
+		if (path->walking)
+			return;
+
+		if (path->connect) {
+			path->walking = 1;
+			invalidate_paths_ep(path->node[dir], dir);
+			path->walking = 0;
+		}
+	}
+}
+
 /*
  * Common implementation for is_connected_output_ep() and
  * is_connected_input_ep(). The function is inlined since the combined size of
@@ -1257,21 +1285,17 @@ int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 
-	/*
-	 * For is_connected_{output,input}_ep fully discover the graph we need
-	 * to reset the cached number of inputs and outputs.
-	 */
-	list_for_each_entry(w, &card->widgets, list) {
-		w->endpoints[SND_SOC_DAPM_DIR_IN] = -1;
-		w->endpoints[SND_SOC_DAPM_DIR_OUT] = -1;
-	}
-
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
-		paths = is_connected_output_ep(dai->playback_widget, &widgets,
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		w = dai->playback_widget;
+		invalidate_paths_ep(w, SND_SOC_DAPM_DIR_OUT);
+		paths = is_connected_output_ep(w, &widgets,
 				custom_stop_condition);
-	else
-		paths = is_connected_input_ep(dai->capture_widget, &widgets,
+	} else {
+		w = dai->capture_widget;
+		invalidate_paths_ep(w, SND_SOC_DAPM_DIR_IN);
+		paths = is_connected_input_ep(w, &widgets,
 				custom_stop_condition);
+	}
 
 	/* Drop starting point */
 	list_del(widgets.next);
-- 
2.17.1
