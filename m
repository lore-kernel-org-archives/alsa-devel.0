From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 07/12] ASoC: dapm: Remove path 'walked' flag
Date: Mon, 20 Oct 2014 19:36:39 +0200
Message-ID: <1413826604-3212-8-git-send-email-lars@metafoo.de>
References: <1413826604-3212-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id D1E3C2658C8
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 19:36:52 +0200 (CEST)
In-Reply-To: <1413826604-3212-1-git-send-email-lars@metafoo.de>
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

The 'walked' flag was used to avoid walking paths that have already been
walked. But since we started caching the number of inputs and outputs of a
path we never actually get into a situation where we try to walk a path that
has the 'walked' flag set.

There are two cases in which we can end up walking a path multiple times
within a single run of is_connected_output_ep() or is_connected_input_ep().

1) If a path splits up and rejoins later:

	     .--> C ---v
	A -> B         E --> F
	     '--> D ---^

When walking from A to F we'll end up at E twice, once via C and once via D.
But since we do a depth first search we'll fully discover the path and
initialize the number of outputs/inputs of the widget the first time we get
there. The second time we get there we'll use the cached value and not
bother to check any of the paths again. So we'll never see a path where
'walked' is set in this case.

2) If there is a circle:

	A --> B <-- C <-.--> F
	      '--> D ---'

When walking from A to F we'll end up twice at B. But since there is a
circle the 'walking' flag will still be set on B once we get there the
second time. This means we won't look at any of it's outgoing paths. So in
this case we won't ever see a path where 'walked' is set either.

So it is safe to remove the flag. This on one hand means we remove some
always true checks from one of the hottest paths of the DAPM algorithm and
on the other hand means we do not have to do the tedious clearing of the
flag after checking the number inputs or outputs of a widget.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |  1 -
 sound/soc/soc-dapm.c     | 49 ++----------------------------------------------
 2 files changed, 2 insertions(+), 48 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 3a4d7da..ebb93f2 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -508,7 +508,6 @@ struct snd_soc_dapm_path {
 
 	/* status */
 	u32 connect:1;	/* source and sink widgets are connected */
-	u32 walked:1;	/* path has been walked */
 	u32 walking:1;  /* path is in the process of being walked */
 	u32 weak:1;	/* path ignored for power management */
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 8f40c35..b5f2f4d8 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -747,34 +747,6 @@ static int dapm_new_pga(struct snd_soc_dapm_widget *w)
 	return 0;
 }
 
-/* reset 'walked' bit for each dapm path */
-static void dapm_clear_walk_output(struct snd_soc_dapm_context *dapm,
-				   struct list_head *sink)
-{
-	struct snd_soc_dapm_path *p;
-
-	list_for_each_entry(p, sink, list_source) {
-		if (p->walked) {
-			p->walked = 0;
-			dapm_clear_walk_output(dapm, &p->sink->sinks);
-		}
-	}
-}
-
-static void dapm_clear_walk_input(struct snd_soc_dapm_context *dapm,
-				  struct list_head *source)
-{
-	struct snd_soc_dapm_path *p;
-
-	list_for_each_entry(p, source, list_sink) {
-		if (p->walked) {
-			p->walked = 0;
-			dapm_clear_walk_input(dapm, &p->source->sources);
-		}
-	}
-}
-
-
 /* We implement power down on suspend by checking the power state of
  * the ALSA card - when we are suspending the ALSA state for the card
  * is set to D3.
@@ -897,13 +869,9 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget,
 		if (path->walking)
 			return 1;
 
-		if (path->walked)
-			continue;
-
 		trace_snd_soc_dapm_output_path(widget, path);
 
 		if (path->connect) {
-			path->walked = 1;
 			path->walking = 1;
 
 			/* do we need to add this widget to the list ? */
@@ -1005,13 +973,9 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
 		if (path->walking)
 			return 1;
 
-		if (path->walked)
-			continue;
-
 		trace_snd_soc_dapm_input_path(widget, path);
 
 		if (path->connect) {
-			path->walked = 1;
 			path->walking = 1;
 
 			/* do we need to add this widget to the list ? */
@@ -1059,15 +1023,10 @@ int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
 	dapm_reset(card);
 
-	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
 		paths = is_connected_output_ep(dai->playback_widget, list);
-		dapm_clear_walk_output(&card->dapm,
-				       &dai->playback_widget->sinks);
-	} else {
+	else
 		paths = is_connected_input_ep(dai->capture_widget, list);
-		dapm_clear_walk_input(&card->dapm,
-				      &dai->capture_widget->sources);
-	}
 
 	trace_snd_soc_dapm_connected(paths, stream);
 	mutex_unlock(&card->dapm_mutex);
@@ -1156,9 +1115,7 @@ static int dapm_generic_check_power(struct snd_soc_dapm_widget *w)
 	DAPM_UPDATE_STAT(w, power_checks);
 
 	in = is_connected_input_ep(w, NULL);
-	dapm_clear_walk_input(w->dapm, &w->sources);
 	out = is_connected_output_ep(w, NULL);
-	dapm_clear_walk_output(w->dapm, &w->sinks);
 	return out != 0 && in != 0;
 }
 
@@ -1816,9 +1773,7 @@ static ssize_t dapm_widget_power_read_file(struct file *file,
 		return -ENOMEM;
 
 	in = is_connected_input_ep(w, NULL);
-	dapm_clear_walk_input(w->dapm, &w->sources);
 	out = is_connected_output_ep(w, NULL);
-	dapm_clear_walk_output(w->dapm, &w->sinks);
 
 	ret = snprintf(buf, PAGE_SIZE, "%s: %s%s  in %d out %d",
 		       w->name, w->power ? "On" : "Off",
-- 
1.8.0
