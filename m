From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 4/8] ASoC: dapm: Introduce toplevel widget
	categories
Date: Sat, 25 Oct 2014 17:41:59 +0200
Message-ID: <1414251723-25050-5-git-send-email-lars@metafoo.de>
References: <1414251723-25050-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-127.synserver.de (smtp-out-127.synserver.de
 [212.40.185.127])
 by alsa0.perex.cz (Postfix) with ESMTP id C0B3E26063A
 for <alsa-devel@alsa-project.org>; Sat, 25 Oct 2014 17:42:13 +0200 (CEST)
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

DAPM widgets can be classified into four categories:
	* supply: Supply widgets do not affect the power state of their
		non-supply widget neighbors and unlike other widgets a
		supply widget is not powered up when it is on an active
		path, but when at least on of its neighbors is powered up.
	* source: A source is a widget that receives data from outside the
		DAPM graph or generates data. This can for example be a
		microphone, the playback DMA or a signal generator. A source
		widget will be considered powered up if there is an active
		path to a sink widget.
	* sink: A sink is a widget that transmits data to somewhere outside
		of the DAPM graph. This can e.g. be a speaker or the capture
		DMA. A sink widget will be considered powered up if there is
		an active path from a source widget.
	* normal: Normal widgets are widgets not covered by the categories
		above. A normal widget will be considered powered up if it
		is on an active path between a source widget and a sink
		widget.

The way the number of input and output paths for a widget is calculated
depends on its category. There are a bunch of factors which decide which
category a widget is. Currently there is no formal classification of these
categories and we calculate the category of the widget based on these
factors whenever we want to know it. This is at least once for every widget
during each power update sequence. The factors which determine the category
of the widgets are mostly static though and if at all change rather seldom.
This patch introduces three new per widget flags, one for each of non-normal
widgets categories. Instead of re-computing the category each time we want
to know them the flags will be checked. For the majority of widgets the
category is solely determined by the widget id, which means it never changes
and only has to be set once when the widget is created. The only widgets
with dynamic categories are:

	snd_soc_dapm_dai_out: Is considered a sink iff the capture stream is
		active, otherwise normal.
	snd_soc_dapm_dai_in: Is considered a source iff the playback stream
		is active, otherwise normal.
	snd_soc_dapm_input: Is considered a sink iff it has no outgoing
		paths, otherwise normal.
	snd_soc_dapm_output: Is considered a source iff it has no incoming
		paths, otherwise normal.
	snd_soc_dapm_line: Is considered a sink iff it has no outgoing paths
		and is considered a source iff it has no incoming paths,
		otherwise normal.

For snd_soc_dapm_dai_out/snd_soc_dapm_dai_in widgets the category will be
updated when a stream is started or stopped. For the other dynamic widgets
the category will be updated when a path connecting to it is added or
removed.

Introducing those new widget categories allows to make
is_connected_{output,input}_ep, which are among the hottest paths of the
DAPM algorithm, more generic and significantly shorter.

The before and after sizes for is_connected_{output,input}_ep are:

On ARM (defconfig + CONFIG_SND_SOC):
	function                                     old     new   delta
	is_connected_output_ep                       480     340    -140
	is_connected_input_ep                        456     352    -104

On amd64 (defconfig + CONFIG_SND_SOC):
	function                                     old     new   delta
	is_connected_output_ep                       579     427    -152
	is_connected_input_ep                        563     427    -136

Which is about a 25%-30% decrease, other architectures are expected to have
similar numbers. At the same time the size of the snd_soc_dapm_widget struct
does not change since the new flags are stored in the same word as the
existing flags.

Note: that since the per widget 'ext' flag was only used to decide whether a
snd_soc_dapm_input or snd_soc_dapm_output widget was a source or a sink it
is now unused and can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Changes since v1:
	* Change '/**' to '/*' for static function documentation to prevent it
	  from showing up in the generated public API documentation
---
 include/sound/soc-dapm.h |   4 +-
 sound/soc/soc-dapm.c     | 210 +++++++++++++++++++++--------------------------
 2 files changed, 95 insertions(+), 119 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index ebb93f2..8cf3aad 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -543,11 +543,13 @@ struct snd_soc_dapm_widget {
 	unsigned char active:1;			/* active stream on DAC, ADC's */
 	unsigned char connected:1;		/* connected codec pin */
 	unsigned char new:1;			/* cnew complete */
-	unsigned char ext:1;			/* has external widgets */
 	unsigned char force:1;			/* force state */
 	unsigned char ignore_suspend:1;         /* kept enabled over suspend */
 	unsigned char new_power:1;		/* power from this run */
 	unsigned char power_checked:1;		/* power checked this run */
+	unsigned char is_supply:1;		/* Widget is a supply type widget */
+	unsigned char is_sink:1;		/* Widget is a sink type widget */
+	unsigned char is_source:1;		/* Widget is a source type widget */
 	int subseq;				/* sort within widget type */
 
 	int (*power_check)(struct snd_soc_dapm_widget *w);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c49df10..2cad5f7 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -821,43 +821,12 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget,
 
 	DAPM_UPDATE_STAT(widget, path_checks);
 
-	switch (widget->id) {
-	case snd_soc_dapm_supply:
-	case snd_soc_dapm_regulator_supply:
-	case snd_soc_dapm_clock_supply:
-	case snd_soc_dapm_kcontrol:
+	if (widget->is_supply)
 		return 0;
-	default:
-		break;
-	}
 
-	switch (widget->id) {
-	case snd_soc_dapm_adc:
-	case snd_soc_dapm_aif_out:
-	case snd_soc_dapm_dai_out:
-		if (widget->active) {
-			widget->outputs = snd_soc_dapm_suspend_check(widget);
-			return widget->outputs;
-		}
-	default:
-		break;
-	}
-
-	if (widget->connected) {
-		/* connected pin ? */
-		if (widget->id == snd_soc_dapm_output && !widget->ext) {
-			widget->outputs = snd_soc_dapm_suspend_check(widget);
-			return widget->outputs;
-		}
-
-		/* connected jack or spk ? */
-		if (widget->id == snd_soc_dapm_hp ||
-		    widget->id == snd_soc_dapm_spk ||
-		    (widget->id == snd_soc_dapm_line &&
-		     !list_empty(&widget->sources))) {
-			widget->outputs = snd_soc_dapm_suspend_check(widget);
-			return widget->outputs;
-		}
+	if (widget->is_sink && widget->connected) {
+		widget->outputs = snd_soc_dapm_suspend_check(widget);
+		return widget->outputs;
 	}
 
 	list_for_each_entry(path, &widget->sinks, list_source) {
@@ -913,55 +882,12 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
 
 	DAPM_UPDATE_STAT(widget, path_checks);
 
-	switch (widget->id) {
-	case snd_soc_dapm_supply:
-	case snd_soc_dapm_regulator_supply:
-	case snd_soc_dapm_clock_supply:
-	case snd_soc_dapm_kcontrol:
+	if (widget->is_supply)
 		return 0;
-	default:
-		break;
-	}
-
-	/* active stream ? */
-	switch (widget->id) {
-	case snd_soc_dapm_dac:
-	case snd_soc_dapm_aif_in:
-	case snd_soc_dapm_dai_in:
-		if (widget->active) {
-			widget->inputs = snd_soc_dapm_suspend_check(widget);
-			return widget->inputs;
-		}
-	default:
-		break;
-	}
-
-	if (widget->connected) {
-		/* connected pin ? */
-		if (widget->id == snd_soc_dapm_input && !widget->ext) {
-			widget->inputs = snd_soc_dapm_suspend_check(widget);
-			return widget->inputs;
-		}
 
-		/* connected VMID/Bias for lower pops */
-		if (widget->id == snd_soc_dapm_vmid) {
-			widget->inputs = snd_soc_dapm_suspend_check(widget);
-			return widget->inputs;
-		}
-
-		/* connected jack ? */
-		if (widget->id == snd_soc_dapm_mic ||
-		    (widget->id == snd_soc_dapm_line &&
-		     !list_empty(&widget->sinks))) {
-			widget->inputs = snd_soc_dapm_suspend_check(widget);
-			return widget->inputs;
-		}
-
-		/* signal generator */
-		if (widget->id == snd_soc_dapm_siggen) {
-			widget->inputs = snd_soc_dapm_suspend_check(widget);
-			return widget->inputs;
-		}
+	if (widget->is_source && widget->connected) {
+		widget->inputs = snd_soc_dapm_suspend_check(widget);
+		return widget->inputs;
 	}
 
 	list_for_each_entry(path, &widget->sources, list_sink) {
@@ -1554,18 +1480,11 @@ static void dapm_widget_set_power(struct snd_soc_dapm_widget *w, bool power,
 	list_for_each_entry(path, &w->sources, list_sink)
 		dapm_widget_set_peer_power(path->source, power, path->connect);
 
-	switch (w->id) {
-	case snd_soc_dapm_supply:
-	case snd_soc_dapm_regulator_supply:
-	case snd_soc_dapm_clock_supply:
-	case snd_soc_dapm_kcontrol:
-		/* Supplies can't affect their outputs, only their inputs */
-		break;
-	default:
+	/* Supplies can't affect their outputs, only their inputs */
+	if (!w->is_supply) {
 		list_for_each_entry(path, &w->sinks, list_source)
 			dapm_widget_set_peer_power(path->sink, power,
 						   path->connect);
-		break;
 	}
 
 	if (power)
@@ -2226,6 +2145,53 @@ int snd_soc_dapm_sync(struct snd_soc_dapm_context *dapm)
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_sync);
 
+/*
+ * dapm_update_widget_flags() - Re-compute widget sink and source flags
+ * @w: The widget for which to update the flags
+ *
+ * Some widgets have a dynamic category which depends on which neighbors they
+ * are connected to. This function update the category for these widgets.
+ *
+ * This function must be called whenever a path is added or removed to a widget.
+ */
+static void dapm_update_widget_flags(struct snd_soc_dapm_widget *w)
+{
+	struct snd_soc_dapm_path *p;
+
+	switch (w->id) {
+	case snd_soc_dapm_input:
+		w->is_source = 1;
+		list_for_each_entry(p, &w->sources, list_sink) {
+			if (p->source->id == snd_soc_dapm_micbias ||
+				p->source->id == snd_soc_dapm_mic ||
+				p->source->id == snd_soc_dapm_line ||
+				p->source->id == snd_soc_dapm_output) {
+					w->is_source = 0;
+					break;
+			}
+		}
+		break;
+	case snd_soc_dapm_output:
+		w->is_sink = 1;
+		list_for_each_entry(p, &w->sinks, list_source) {
+			if (p->sink->id == snd_soc_dapm_spk ||
+				p->sink->id == snd_soc_dapm_hp ||
+				p->sink->id == snd_soc_dapm_line ||
+				p->sink->id == snd_soc_dapm_input) {
+					w->is_sink = 0;
+					break;
+			}
+		}
+		break;
+	case snd_soc_dapm_line:
+		w->is_sink = !list_empty(&w->sources);
+		w->is_source = !list_empty(&w->sinks);
+		break;
+	default:
+		break;
+	}
+}
+
 static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *wsource, struct snd_soc_dapm_widget *wsink,
 	const char *control,
@@ -2247,22 +2213,6 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 	INIT_LIST_HEAD(&path->list_source);
 	INIT_LIST_HEAD(&path->list_sink);
 
-	/* check for external widgets */
-	if (wsink->id == snd_soc_dapm_input) {
-		if (wsource->id == snd_soc_dapm_micbias ||
-			wsource->id == snd_soc_dapm_mic ||
-			wsource->id == snd_soc_dapm_line ||
-			wsource->id == snd_soc_dapm_output)
-			wsink->ext = 1;
-	}
-	if (wsource->id == snd_soc_dapm_output) {
-		if (wsink->id == snd_soc_dapm_spk ||
-			wsink->id == snd_soc_dapm_hp ||
-			wsink->id == snd_soc_dapm_line ||
-			wsink->id == snd_soc_dapm_input)
-			wsource->ext = 1;
-	}
-
 	/* connect static paths */
 	if (control == NULL) {
 		path->connect = 1;
@@ -2294,6 +2244,9 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 	list_add(&path->list_sink, &wsink->sources);
 	list_add(&path->list_source, &wsource->sinks);
 
+	dapm_update_widget_flags(wsource);
+	dapm_update_widget_flags(wsink);
+
 	dapm_mark_dirty(wsource, "Route added");
 	dapm_mark_dirty(wsink, "Route added");
 
@@ -2377,6 +2330,7 @@ err:
 static int snd_soc_dapm_del_route(struct snd_soc_dapm_context *dapm,
 				  const struct snd_soc_dapm_route *route)
 {
+	struct snd_soc_dapm_widget *wsource, *wsink;
 	struct snd_soc_dapm_path *path, *p;
 	const char *sink;
 	const char *source;
@@ -2414,10 +2368,17 @@ static int snd_soc_dapm_del_route(struct snd_soc_dapm_context *dapm,
 	}
 
 	if (path) {
-		dapm_mark_dirty(path->source, "Route removed");
-		dapm_mark_dirty(path->sink, "Route removed");
+		wsource = path->source;
+		wsink = path->sink;
+
+		dapm_mark_dirty(wsource, "Route removed");
+		dapm_mark_dirty(wsink, "Route removed");
 
 		dapm_free_path(path);
+
+		/* Update any path related flags */
+		dapm_update_widget_flags(wsource);
+		dapm_update_widget_flags(wsink);
 	} else {
 		dev_warn(dapm->dev, "ASoC: Route %s->%s does not exist\n",
 			 source, sink);
@@ -2975,26 +2936,33 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	}
 
 	switch (w->id) {
-	case snd_soc_dapm_switch:
-	case snd_soc_dapm_mixer:
-	case snd_soc_dapm_mixer_named_ctl:
+	case snd_soc_dapm_mic:
+	case snd_soc_dapm_input:
+		w->is_source = 1;
 		w->power_check = dapm_generic_check_power;
 		break;
-	case snd_soc_dapm_mux:
+	case snd_soc_dapm_spk:
+	case snd_soc_dapm_hp:
+	case snd_soc_dapm_output:
+		w->is_sink = 1;
 		w->power_check = dapm_generic_check_power;
 		break;
+	case snd_soc_dapm_vmid:
+	case snd_soc_dapm_siggen:
+		w->is_source = 1;
+		w->power_check = dapm_always_on_check_power;
+		break;
+	case snd_soc_dapm_mux:
+	case snd_soc_dapm_switch:
+	case snd_soc_dapm_mixer:
+	case snd_soc_dapm_mixer_named_ctl:
 	case snd_soc_dapm_adc:
 	case snd_soc_dapm_aif_out:
 	case snd_soc_dapm_dac:
 	case snd_soc_dapm_aif_in:
 	case snd_soc_dapm_pga:
 	case snd_soc_dapm_out_drv:
-	case snd_soc_dapm_input:
-	case snd_soc_dapm_output:
 	case snd_soc_dapm_micbias:
-	case snd_soc_dapm_spk:
-	case snd_soc_dapm_hp:
-	case snd_soc_dapm_mic:
 	case snd_soc_dapm_line:
 	case snd_soc_dapm_dai_link:
 	case snd_soc_dapm_dai_out:
@@ -3005,6 +2973,7 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	case snd_soc_dapm_regulator_supply:
 	case snd_soc_dapm_clock_supply:
 	case snd_soc_dapm_kcontrol:
+		w->is_supply = 1;
 		w->power_check = dapm_supply_check_power;
 		break;
 	default:
@@ -3368,6 +3337,11 @@ static void soc_dapm_dai_stream_event(struct snd_soc_dai *dai, int stream,
 		case SND_SOC_DAPM_STREAM_PAUSE_RELEASE:
 			break;
 		}
+
+		if (w->id == snd_soc_dapm_dai_in)
+			w->is_source = w->active;
+		else
+			w->is_sink = w->active;
 	}
 }
 
-- 
1.8.0
