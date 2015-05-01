From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] ASoC: dapm: Add demux support
Date: Fri,  1 May 2015 18:02:43 +0200
Message-ID: <1430496165-13917-2-git-send-email-lars@metafoo.de>
References: <1430496165-13917-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-017.synserver.de
 [212.40.185.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D57A260708
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 19:15:53 +0200 (CEST)
In-Reply-To: <1430496165-13917-1-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

A demux is conceptually similar to a mux. Where a mux has multiple input
and one output and selects one of the inputs to be connected to the output,
the demux has one input and multiple outputs and selects one of the outputs
to which the input gets connected.

This similarity makes it straight forward to support them in DAPM using the
existing mux support, we only need to swap sinks and sources when initially
setting up the paths.

The only slightly tricky part is that there can only be one control per
path. Since mixers/muxes are at the sink of a path and a demux is at the
source and both types want a control it is not possible to directly connect
a demux output to a mixer/mux input. The patch adds some sanity checks to
make sure that this does not happen.

Drivers who want to model hardware which directly connects a demux output
to a mixer/mux input can do this by inserting a dummy widget between the
two. E.g.:

	{ "Dummy", "Demux Control", "Demux" },
	{ "Mixer", "Mixer Control", "Dummy" },

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dapm.h |   5 +++
 sound/soc/soc-dapm.c     | 112 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 102 insertions(+), 15 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index b659d9f..bfc415e 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -107,6 +107,10 @@ struct device;
 {	.id = snd_soc_dapm_mux, .name = wname, \
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = 1}
+#define SND_SOC_DAPM_DEMUX(wname, wreg, wshift, winvert, wcontrols) \
+{	.id = snd_soc_dapm_demux, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
+	.kcontrol_news = wcontrols, .num_kcontrols = 1}
 
 /* Simplified versions of above macros, assuming wncontrols = ARRAY_SIZE(wcontrols) */
 #define SOC_PGA_ARRAY(wname, wreg, wshift, winvert,\
@@ -452,6 +456,7 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_input = 0,		/* input pin */
 	snd_soc_dapm_output,		/* output pin */
 	snd_soc_dapm_mux,			/* selects 1 analog signal from many inputs */
+	snd_soc_dapm_demux,			/* connects the input to one of multiple outputs */
 	snd_soc_dapm_mixer,			/* mixes several analog signals together */
 	snd_soc_dapm_mixer_named_ctl,		/* mixer with named controls */
 	snd_soc_dapm_pga,			/* programmable gain/attenuation (volume) */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5c159f4..a2e5f22 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -70,6 +70,7 @@ static int dapm_up_seq[] = {
 	[snd_soc_dapm_aif_out] = 4,
 	[snd_soc_dapm_mic] = 5,
 	[snd_soc_dapm_mux] = 6,
+	[snd_soc_dapm_demux] = 6,
 	[snd_soc_dapm_dac] = 7,
 	[snd_soc_dapm_switch] = 8,
 	[snd_soc_dapm_mixer] = 8,
@@ -100,6 +101,7 @@ static int dapm_down_seq[] = {
 	[snd_soc_dapm_mic] = 7,
 	[snd_soc_dapm_micbias] = 8,
 	[snd_soc_dapm_mux] = 9,
+	[snd_soc_dapm_demux] = 9,
 	[snd_soc_dapm_aif_in] = 10,
 	[snd_soc_dapm_aif_out] = 10,
 	[snd_soc_dapm_dai_in] = 10,
@@ -356,6 +358,7 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 			}
 		}
 		break;
+	case snd_soc_dapm_demux:
 	case snd_soc_dapm_mux:
 		e = (struct soc_enum *)kcontrol->private_value;
 
@@ -639,9 +642,10 @@ out:
 
 /* connect mux widget to its interconnecting audio paths */
 static int dapm_connect_mux(struct snd_soc_dapm_context *dapm,
-	struct snd_soc_dapm_path *path, const char *control_name)
+	struct snd_soc_dapm_path *path, const char *control_name,
+	struct snd_soc_dapm_widget *w)
 {
-	const struct snd_kcontrol_new *kcontrol = &path->sink->kcontrol_news[0];
+	const struct snd_kcontrol_new *kcontrol = &w->kcontrol_news[0];
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	unsigned int val, item;
 	int i;
@@ -781,6 +785,7 @@ static int dapm_create_or_share_mixmux_kcontrol(struct snd_soc_dapm_widget *w,
 				wname_in_long_name = false;
 				kcname_in_long_name = true;
 				break;
+			case snd_soc_dapm_demux:
 			case snd_soc_dapm_mux:
 				wname_in_long_name = true;
 				kcname_in_long_name = false;
@@ -886,17 +891,32 @@ static int dapm_new_mux(struct snd_soc_dapm_widget *w)
 {
 	struct snd_soc_dapm_context *dapm = w->dapm;
 	struct snd_soc_dapm_path *path;
+	struct list_head *paths;
+	const char *type;
 	int ret;
 
+	switch (w->id) {
+	case snd_soc_dapm_mux:
+		paths = &w->sources;
+		type = "mux";
+		break;
+	case snd_soc_dapm_demux:
+		paths = &w->sinks;
+		type = "demux";
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	if (w->num_kcontrols != 1) {
 		dev_err(dapm->dev,
-			"ASoC: mux %s has incorrect number of controls\n",
+			"ASoC: %s %s has incorrect number of controls\n", type,
 			w->name);
 		return -EINVAL;
 	}
 
-	if (list_empty(&w->sources)) {
-		dev_err(dapm->dev, "ASoC: mux %s has no paths\n", w->name);
+	if (list_empty(paths)) {
+		dev_err(dapm->dev, "ASoC: %s %s has no paths\n", type, w->name);
 		return -EINVAL;
 	}
 
@@ -904,9 +924,16 @@ static int dapm_new_mux(struct snd_soc_dapm_widget *w)
 	if (ret < 0)
 		return ret;
 
-	list_for_each_entry(path, &w->sources, list_sink) {
-		if (path->name)
-			dapm_kcontrol_add_path(w->kcontrols[0], path);
+	if (w->id == snd_soc_dapm_mux) {
+		list_for_each_entry(path, &w->sources, list_sink) {
+			if (path->name)
+				dapm_kcontrol_add_path(w->kcontrols[0], path);
+		}
+	} else {
+		list_for_each_entry(path, &w->sinks, list_source) {
+			if (path->name)
+				dapm_kcontrol_add_path(w->kcontrols[0], path);
+		}
 	}
 
 	return 0;
@@ -2414,6 +2441,50 @@ static void dapm_update_widget_flags(struct snd_soc_dapm_widget *w)
 	}
 }
 
+static int snd_soc_dapm_check_dynamic_path(struct snd_soc_dapm_context *dapm,
+	struct snd_soc_dapm_widget *source, struct snd_soc_dapm_widget *sink,
+	const char *control)
+{
+	bool dynamic_source = false;
+	bool dynamic_sink = false;
+
+	if (!control)
+		return 0;
+
+	switch (source->id) {
+	case snd_soc_dapm_demux:
+		dynamic_source = true;
+		break;
+	default:
+		break;
+	}
+
+	switch (sink->id) {
+	case snd_soc_dapm_mux:
+	case snd_soc_dapm_switch:
+	case snd_soc_dapm_mixer:
+	case snd_soc_dapm_mixer_named_ctl:
+		dynamic_sink = true;
+		break;
+	default:
+		break;
+	}
+
+	if (dynamic_source && dynamic_sink) {
+		dev_err(dapm->dev,
+			"Direct connection between demux and mixer/mux not supported for path %s -> [%s] -> %s\n",
+			source->name, control, sink->name);
+		return -EINVAL;
+	} else if (!dynamic_source && !dynamic_sink) {
+		dev_err(dapm->dev,
+			"Control not supported for path %s -> [%s] -> %s\n",
+			source->name, control, sink->name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *wsource, struct snd_soc_dapm_widget *wsink,
 	const char *control,
@@ -2444,6 +2515,10 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 		return -EINVAL;
 	}
 
+	ret = snd_soc_dapm_check_dynamic_path(dapm, wsource, wsink, control);
+	if (ret)
+		return ret;
+
 	path = kzalloc(sizeof(struct snd_soc_dapm_path), GFP_KERNEL);
 	if (!path)
 		return -ENOMEM;
@@ -2463,10 +2538,19 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 	if (control == NULL) {
 		path->connect = 1;
 	} else {
-		/* connect dynamic paths */
+		switch (wsource->id) {
+		case snd_soc_dapm_demux:
+			ret = dapm_connect_mux(dapm, path, control, wsource);
+			if (ret)
+				goto err;
+			break;
+		default:
+			break;
+		}
+
 		switch (wsink->id) {
 		case snd_soc_dapm_mux:
-			ret = dapm_connect_mux(dapm, path, control);
+			ret = dapm_connect_mux(dapm, path, control, wsink);
 			if (ret != 0)
 				goto err;
 			break;
@@ -2478,11 +2562,7 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 				goto err;
 			break;
 		default:
-			dev_err(dapm->dev,
-				"Control not supported for path %s -> [%s] -> %s\n",
-				wsource->name, control, wsink->name);
-			ret = -EINVAL;
-			goto err;
+			break;
 		}
 	}
 
@@ -2815,6 +2895,7 @@ int snd_soc_dapm_new_widgets(struct snd_soc_card *card)
 			dapm_new_mixer(w);
 			break;
 		case snd_soc_dapm_mux:
+		case snd_soc_dapm_demux:
 			dapm_new_mux(w);
 			break;
 		case snd_soc_dapm_pga:
@@ -3219,6 +3300,7 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 		w->power_check = dapm_always_on_check_power;
 		break;
 	case snd_soc_dapm_mux:
+	case snd_soc_dapm_demux:
 	case snd_soc_dapm_switch:
 	case snd_soc_dapm_mixer:
 	case snd_soc_dapm_mixer_named_ctl:
-- 
1.8.0
