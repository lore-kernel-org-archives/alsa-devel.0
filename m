From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Invalidate only paths reachable for a given stream" to the asoc tree
Date: Mon, 12 Aug 2019 14:09:50 +0100 (BST)
Message-ID: <20190812130950.5D45B2740CBD@ypsilon.sirena.org.uk>
References: <20190809084034.26220-1-szymonx.mielczarek@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190809084034.26220-1-szymonx.mielczarek@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Szymon Mielczarek <szymonx.mielczarek@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Cezary Rojewski <cezary.rojewski@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Invalidate only paths reachable for a given stream

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 872f3ac583cb00c14a4dc86b1511cf98618dd671 Mon Sep 17 00:00:00 2001
From: Szymon Mielczarek <szymonx.mielczarek@linux.intel.com>
Date: Fri, 9 Aug 2019 10:40:34 +0200
Subject: [PATCH] ASoC: dapm: Invalidate only paths reachable for a given
 stream

By resetting the cached number of endpoints for all card's widgets we may
overwrite previously cached values for other streams. The situation may
happen especially when running streams simultaneously.

Signed-off-by: Szymon Mielczarek <szymonx.mielczarek@linux.intel.com>
Link: https://lore.kernel.org/r/20190809084034.26220-1-szymonx.mielczarek@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
