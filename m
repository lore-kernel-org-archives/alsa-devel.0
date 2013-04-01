From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Only clear paths we've walked
Date: Mon,  1 Apr 2013 12:51:25 +0100
Message-ID: <1364817085-8202-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B488A264F03
 for <alsa-devel@alsa-project.org>; Mon,  1 Apr 2013 13:51:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ryo Tsutsui <Ryo.Tsutsui@wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Ryo Tsutsui <Ryo.Tsutsui@wolfsonmicro.com>

When clearing the walked flags there is no need to clear all paths, we
only need to clear the paths we actually walked. This means we can split
dapm_clear_walk() into input and output versions and rather than going
through all DAPM paths we can recurse down the path until we encounter
paths we have not yet walked.

This reduces the number of operations we need to perform and improves
cache locality.

[Pulled out of the vendor tree that the patch was originally generated
for by me, any bugs were introduced in that process -- broonie]

Signed-off-by: Ryo Tsutsui <Ryo.Tsutsui@wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   47 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 0a395eb..93def6f 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -707,14 +707,33 @@ static int dapm_new_pga(struct snd_soc_dapm_widget *w)
 }
 
 /* reset 'walked' bit for each dapm path */
-static inline void dapm_clear_walk(struct snd_soc_dapm_context *dapm)
+static void dapm_clear_walk_output(struct snd_soc_dapm_context *dapm,
+				   struct list_head *sink)
 {
 	struct snd_soc_dapm_path *p;
 
-	list_for_each_entry(p, &dapm->card->paths, list)
-		p->walked = 0;
+	list_for_each_entry(p, sink, list_source) {
+		if (p->walked) {
+			p->walked = 0;
+			dapm_clear_walk_output(dapm, &p->sink->sinks);
+		}
+	}
+}
+
+static void dapm_clear_walk_input(struct snd_soc_dapm_context *dapm,
+				  struct list_head *source)
+{
+	struct snd_soc_dapm_path *p;
+
+	list_for_each_entry(p, source, list_sink) {
+		if (p->walked) {
+			p->walked = 0;
+			dapm_clear_walk_input(dapm, &p->source->sources);
+		}
+	}
 }
 
+
 /* We implement power down on suspend by checking the power state of
  * the ALSA card - when we are suspending the ALSA state for the card
  * is set to D3.
@@ -997,13 +1016,17 @@ int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 	dapm_reset(card);
 
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		paths = is_connected_output_ep(dai->playback_widget, list);
-	else
+		dapm_clear_walk_output(&card->dapm,
+				       &dai->playback_widget->sinks);
+	} else {
 		paths = is_connected_input_ep(dai->capture_widget, list);
+		dapm_clear_walk_input(&card->dapm,
+				      &dai->capture_widget->sources);
+	}
 
 	trace_snd_soc_dapm_connected(paths, stream);
-	dapm_clear_walk(&card->dapm);
 	mutex_unlock(&card->dapm_mutex);
 
 	return paths;
@@ -1106,9 +1129,9 @@ static int dapm_generic_check_power(struct snd_soc_dapm_widget *w)
 	DAPM_UPDATE_STAT(w, power_checks);
 
 	in = is_connected_input_ep(w, NULL);
-	dapm_clear_walk(w->dapm);
+	dapm_clear_walk_input(w->dapm, &w->sources);
 	out = is_connected_output_ep(w, NULL);
-	dapm_clear_walk(w->dapm);
+	dapm_clear_walk_output(w->dapm, &w->sinks);
 	return out != 0 && in != 0;
 }
 
@@ -1131,7 +1154,7 @@ static int dapm_adc_check_power(struct snd_soc_dapm_widget *w)
 
 	if (w->active) {
 		in = is_connected_input_ep(w, NULL);
-		dapm_clear_walk(w->dapm);
+		dapm_clear_walk_input(w->dapm, &w->sources);
 		return in != 0;
 	} else {
 		return dapm_generic_check_power(w);
@@ -1147,7 +1170,7 @@ static int dapm_dac_check_power(struct snd_soc_dapm_widget *w)
 
 	if (w->active) {
 		out = is_connected_output_ep(w, NULL);
-		dapm_clear_walk(w->dapm);
+		dapm_clear_walk_output(w->dapm, &w->sinks);
 		return out != 0;
 	} else {
 		return dapm_generic_check_power(w);
@@ -1775,9 +1798,9 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 		return -ENOMEM;
 
 	in = is_connected_input_ep(w, NULL);
-	dapm_clear_walk(w->dapm);
+	dapm_clear_walk_input(w->dapm, &w->sources);
 	out = is_connected_output_ep(w, NULL);
-	dapm_clear_walk(w->dapm);
+	dapm_clear_walk_output(w->dapm, &w->sinks);
 
 	ret = snprintf(buf, PAGE_SIZE, "%s: %s%s  in %d out %d",
 		       w->name, w->power ? "On" : "Off",
-- 
1.7.10.4
