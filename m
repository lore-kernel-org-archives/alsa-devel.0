From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 8/8] ASoC: dapm: Use more aggressive caching
Date: Sat, 25 Oct 2014 17:42:03 +0200
Message-ID: <1414251723-25050-9-git-send-email-lars@metafoo.de>
References: <1414251723-25050-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-127.synserver.de (smtp-out-127.synserver.de
 [212.40.185.127])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A20926059A
 for <alsa-devel@alsa-project.org>; Sat, 25 Oct 2014 17:42:18 +0200 (CEST)
In-Reply-To: <1414251723-25050-1-git-send-email-lars@metafoo.de>
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

Currently we cache the number of input and output paths going to/from a
widget only within a power update sequence. But not in between power update
sequences.

But we know how changes to the DAPM graph affect the number of input (form a
source) and output (to a sink) paths of a widget and only need to
recalculate them if a operation has been performed that might have changed
them.
	* Adding/removing or connecting/disconnecting a path means that the for
	  the source of the path the number of output paths can change and for
	  the sink the number of input paths can change.
	* Connecting/disconnecting a widget has the same effect has connecting/
	  disconnecting all paths of the widget. So for the widget itself the
	  number of inputs and outputs can change, for all sinks of the widget
	  the number of inputs can change and for all sources of the widget the
	  number of outputs can change.
	* Activating/Deactivating a stream can either change the number of
	  outputs on the sources of the widget associated with the stream or the
	  number of inputs on the sinks.

Instead of always invalidating all cached numbers of input and output paths
for each power up or down sequence this patch restructures the code to only
invalidate the cached numbers when a operation that might change them has
been performed. This can greatly reduce the number of DAPM power checks for
some very common operations.

Since per DAPM operation typically only either change the number of inputs
or outputs the number of path checks is reduced by at least 50%. The number
of neighbor checks is also reduced about the same percentage, but since the
number of neighbors encountered when walking from sink to source is not the
same as when walking from source to sink the actual numbers will slightly
vary from card to card (e.g. for a mixer we see 1 neighbor when walking from
source to sink, but the number of inputs neighbors when walking from source
to sink).

Bigger improvements can be observed for widgets with multiple connected
inputs and output (e.g. mixers probably being the most widespread form of
this). Previously we had to re-calculate the number of inputs and outputs
on all input and output paths. With this change we only have to re-calculate
the number of outputs on the input path that got changed and the number of
inputs on the output paths.

E.g. imagine the following example:

	A --> B ----.
	            v
	M --> N --> Z <-- S <-- R
	            |
	            v
	            X

Widget Z has multiple input paths, if any change was made that cause Z to be
marked as dirty the power state of Z has to be re-computed. This requires to
know the number of inputs and outputs of Z, which requires to know the
number of inputs and outputs of all widgets on all paths from or to Z.
Previously this meant re-computing all inputs and outputs of all the path
going into or out of Z. With this patch in place only paths that actually
have changed need to be re-computed.

If the system is idle (or the part of the system affected by the changed
path) the number of path checks drops to either 0 or 1, regardless of how
large or complex the DAPM context is. 0 if there is no connected sink and no
connected source. 1 if there is either a connected source or sink, but not
both. The number of neighbor checks again will scale accordingly and will be
a constant number that is the number of inputs or outputs of the widget for
which we did the path check.

When loading a state file or switching between different profiles typically
multiple mixer and mux settings are changed, so we see the benefit of this
patch multiplied for these kinds of operations.

Testing with the ADAU1761 shows the following changes in DAPM stats for
changing a single Mixer switch for a Mixer with 5 inputs while the DAPM
context is idle.

         Power  Path  Neighbour
Before:  2      12    30
After:   2       1     2

For the same switch, but with a active playback stream the stat changed are
as follows.

         Power  Path  Neighbour
Before:  10     20    54
After:   10      7    21

Cumulative numbers for switching the audio profile which changes 7 controls
while the system is idle:

         Power  Path  Neighbour
Before:  16      80   170
After:   16       7    23

Cumulative numbers for switching the audio profile which changes 7 controls
while playback is active:

         Power  Path  Neighbour
Before:  51     123   273
After:   51      29   109

Starting (or stopping) the playback stream:

         Power  Path  Neighbour
Before:  34     34    117
After:   34     17    69

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Changes since v1:
	* Add dapm_assert_locked(w->dapm) to
	  dapm_widget_invalidate_{input,output}_paths.
	* Only call dapm_path_invalidate() in snd_soc_dapm_add_path() if the
	  card has already been instantiated.
	* Change '/**' to '/*' for static function documentation to prevent it
	  from showing up in the generated public API documentation
---
 include/sound/soc-dapm.h |   1 +
 sound/soc/soc-dapm.c     | 161 ++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 154 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 43ca165..89823cf 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -569,6 +569,7 @@ struct snd_soc_dapm_widget {
 	struct list_head sinks;
 
 	/* used during DAPM updates */
+	struct list_head work_list;
 	struct list_head power_list;
 	struct list_head dirty;
 	int inputs;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 8e26c2b..6bf2c97 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -159,6 +159,116 @@ static void dapm_mark_dirty(struct snd_soc_dapm_widget *w, const char *reason)
 	}
 }
 
+/*
+ * dapm_widget_invalidate_input_paths() - Invalidate the cached number of input
+ *  paths
+ * @w: The widget for which to invalidate the cached number of input paths
+ *
+ * The function resets the cached number of inputs for the specified widget and
+ * all widgets that can be reached via outgoing paths from the widget.
+ *
+ * This function must be called if the number of input paths for a widget might
+ * have changed. E.g. if the source state of a widget changes or a path is added
+ * or activated with the widget as the sink.
+ */
+static void dapm_widget_invalidate_input_paths(struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_dapm_widget *sink;
+	struct snd_soc_dapm_path *p;
+	LIST_HEAD(list);
+
+	dapm_assert_locked(w->dapm);
+
+	if (w->inputs == -1)
+		return;
+
+	w->inputs = -1;
+	list_add_tail(&w->work_list, &list);
+
+	list_for_each_entry(w, &list, work_list) {
+		list_for_each_entry(p, &w->sinks, list_source) {
+			if (p->is_supply || p->weak || !p->connect)
+				continue;
+			sink = p->sink;
+			if (sink->inputs != -1) {
+				sink->inputs = -1;
+				list_add_tail(&sink->work_list, &list);
+			}
+		}
+	}
+}
+
+/*
+ * dapm_widget_invalidate_output_paths() - Invalidate the cached number of
+ *  output paths
+ * @w: The widget for which to invalidate the cached number of output paths
+ *
+ * Resets the cached number of outputs for the specified widget and all widgets
+ * that can be reached via incoming paths from the widget.
+ *
+ * This function must be called if the number of output paths for a widget might
+ * have changed. E.g. if the sink state of a widget changes or a path is added
+ * or activated with the widget as the source.
+ */
+static void dapm_widget_invalidate_output_paths(struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_dapm_widget *source;
+	struct snd_soc_dapm_path *p;
+	LIST_HEAD(list);
+
+	dapm_assert_locked(w->dapm);
+
+	if (w->outputs == -1)
+		return;
+
+	w->outputs = -1;
+	list_add_tail(&w->work_list, &list);
+
+	list_for_each_entry(w, &list, work_list) {
+		list_for_each_entry(p, &w->sources, list_sink) {
+			if (p->is_supply || p->weak || !p->connect)
+				continue;
+			source = p->source;
+			if (source->outputs != -1) {
+				source->outputs = -1;
+				list_add_tail(&source->work_list, &list);
+			}
+		}
+	}
+}
+
+/*
+ * dapm_path_invalidate() - Invalidates the cached number of inputs and outputs
+ *  for the widgets connected to a path
+ * @p: The path to invalidate
+ *
+ * Resets the cached number of inputs for the sink of the path and the cached
+ * number of outputs for the source of the path.
+ *
+ * This function must be called when a path is added, removed or the connected
+ * state changes.
+ */
+static void dapm_path_invalidate(struct snd_soc_dapm_path *p)
+{
+	/*
+	 * Weak paths or supply paths do not influence the number of input or
+	 * output paths of their neighbors.
+	 */
+	if (p->weak || p->is_supply)
+		return;
+
+	/*
+	 * The number of connected endpoints is the sum of the number of
+	 * connected endpoints of all neighbors. If a node with 0 connected
+	 * endpoints is either connected or disconnected that sum won't change,
+	 * so there is no need to re-check the path.
+	 */
+	if (p->source->inputs != 0)
+		dapm_widget_invalidate_input_paths(p->sink);
+	if (p->sink->outputs != 0)
+		dapm_widget_invalidate_output_paths(p->source);
+}
+
 void dapm_mark_endpoints_dirty(struct snd_soc_card *card)
 {
 	struct snd_soc_dapm_widget *w;
@@ -166,8 +276,13 @@ void dapm_mark_endpoints_dirty(struct snd_soc_card *card)
 	mutex_lock(&card->dapm_mutex);
 
 	list_for_each_entry(w, &card->widgets, list) {
-		if (w->is_sink || w->is_source)
+		if (w->is_sink || w->is_source) {
 			dapm_mark_dirty(w, "Rechecking endpoints");
+			if (w->is_sink)
+				dapm_widget_invalidate_output_paths(w);
+			if (w->is_source)
+				dapm_widget_invalidate_input_paths(w);
+		}
 	}
 
 	mutex_unlock(&card->dapm_mutex);
@@ -379,8 +494,6 @@ static void dapm_reset(struct snd_soc_card *card)
 	list_for_each_entry(w, &card->widgets, list) {
 		w->new_power = w->power;
 		w->power_checked = false;
-		w->inputs = -1;
-		w->outputs = -1;
 	}
 }
 
@@ -931,10 +1044,19 @@ int snd_soc_dapm_dai_get_connected_widgets(struct snd_soc_dai *dai, int stream,
 	struct snd_soc_dapm_widget_list **list)
 {
 	struct snd_soc_card *card = dai->card;
+	struct snd_soc_dapm_widget *w;
 	int paths;
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
-	dapm_reset(card);
+
+	/*
+	 * For is_connected_{output,input}_ep fully discover the graph we need
+	 * to reset the cached number of inputs and outputs.
+	 */
+	list_for_each_entry(w, &card->widgets, list) {
+		w->inputs = -1;
+		w->outputs = -1;
+	}
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
 		paths = is_connected_output_ep(dai->playback_widget, list);
@@ -1846,6 +1968,7 @@ static void soc_dapm_connect_path(struct snd_soc_dapm_path *path,
 	path->connect = connect;
 	dapm_mark_dirty(path->source, reason);
 	dapm_mark_dirty(path->sink, reason);
+	dapm_path_invalidate(path);
 }
 
 /* test and update the power status of a mux widget */
@@ -2084,8 +2207,11 @@ static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
 		return -EINVAL;
 	}
 
-	if (w->connected != status)
+	if (w->connected != status) {
 		dapm_mark_dirty(w, "pin configuration");
+		dapm_widget_invalidate_input_paths(w);
+		dapm_widget_invalidate_output_paths(w);
+	}
 
 	w->connected = status;
 	if (status == 0)
@@ -2267,6 +2393,9 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 	dapm_mark_dirty(wsource, "Route added");
 	dapm_mark_dirty(wsink, "Route added");
 
+	if (dapm->card->instantiated && path->connect)
+		dapm_path_invalidate(path);
+
 	return 0;
 err:
 	kfree(path);
@@ -2390,6 +2519,8 @@ static int snd_soc_dapm_del_route(struct snd_soc_dapm_context *dapm,
 
 		dapm_mark_dirty(wsource, "Route removed");
 		dapm_mark_dirty(wsink, "Route removed");
+		if (path->connect)
+			dapm_path_invalidate(path);
 
 		dapm_free_path(path);
 
@@ -3007,6 +3138,9 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	INIT_LIST_HEAD(&w->dirty);
 	list_add(&w->list, &dapm->card->widgets);
 
+	w->inputs = -1;
+	w->outputs = -1;
+
 	/* machine layer set ups unconnected pins and insertions */
 	w->connected = 1;
 	return w;
@@ -3355,10 +3489,13 @@ static void soc_dapm_dai_stream_event(struct snd_soc_dai *dai, int stream,
 			break;
 		}
 
-		if (w->id == snd_soc_dapm_dai_in)
+		if (w->id == snd_soc_dapm_dai_in) {
 			w->is_source = w->active;
-		else
+			dapm_widget_invalidate_input_paths(w);
+		} else {
 			w->is_sink = w->active;
+			dapm_widget_invalidate_output_paths(w);
+		}
 	}
 }
 
@@ -3485,7 +3622,15 @@ int snd_soc_dapm_force_enable_pin_unlocked(struct snd_soc_dapm_context *dapm,
 	}
 
 	dev_dbg(w->dapm->dev, "ASoC: force enable pin %s\n", pin);
-	w->connected = 1;
+	if (!w->connected) {
+		/*
+		 * w->force does not affect the number of input or output paths,
+		 * so we only have to recheck if w->connected is changed
+		 */
+		dapm_widget_invalidate_input_paths(w);
+		dapm_widget_invalidate_output_paths(w);
+		w->connected = 1;
+	}
 	w->force = 1;
 	dapm_mark_dirty(w, "force enable");
 
-- 
1.8.0
