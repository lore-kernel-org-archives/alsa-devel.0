From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/8] ASoC: dapm: Implement and instantiate DAI
	widgets
Date: Thu, 16 Feb 2012 21:56:08 -0800
Message-ID: <1329458170-22119-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A3D0F103A55
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 06:56:17 +0100 (CET)
In-Reply-To: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

In order to allow us to do smarter things with DAI links create DAPM
widgets which directly represent the DAIs in the DAPM graph. These are
automatically created from the DAIs as we probe the card with references
held in both directions between the widget and the DAI.

The widgets are not made available for direct instantiation by drivers,
they are created automatically from the DAIs.  Drivers should be updated
to create stream routes using DAPM maps rather than by annotating AIF
and DAC widgets with streams.

In order to ease transition to this model from existing drivers we
automatically create DAPM routes between the DAI widgets and the existing
stream widgets which are started and stopped by the DAI widgets, though
the old stream handling mechanism is still in place.  This also has the
nice effect of removing non-DAPM devices as any device with a DAI
acquires a widget automatically which will allow future simplifications
to the core DAPM logic.

The intention is that in future the AIF and DAI widgets will gain the
ability to interact such that we are able to manage activity on
individual channels independantly rather than powering up and down the
entire AIF as we do currently.

Currently we only generate these for CODECs, mostly as I have no systems
with non-CODEC DAPM to integrate with. It should be a simple matter of
programming to add the additional hookup for these.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dai.h  |    4 ++
 include/sound/soc-dapm.h |    4 ++
 sound/soc/soc-core.c     |   11 ++++
 sound/soc/soc-dapm.c     |  135 +++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 146 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 1a2b08c..d474128 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -17,6 +17,7 @@
 #include <linux/list.h>
 
 struct snd_pcm_substream;
+struct snd_soc_dapm_widget;
 
 /*
  * DAI hardware audio formats.
@@ -238,6 +239,9 @@ struct snd_soc_dai {
 	unsigned char pop_wait:1;
 	unsigned char probed:1;
 
+	struct snd_soc_dapm_widget *playback_widget;
+	struct snd_soc_dapm_widget *capture_widget;
+
 	/* DAI DMA data */
 	void *playback_dma_data;
 	void *capture_dma_data;
diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 91eb812..e46107f 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -355,6 +355,9 @@ int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 	const struct snd_soc_dapm_widget *widget,
 	int num);
+int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
+				 struct snd_soc_dai *dai);
+int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card);
 
 /* dapm path setup */
 int snd_soc_dapm_new_widgets(struct snd_soc_dapm_context *dapm);
@@ -425,6 +428,7 @@ enum snd_soc_dapm_type {
 	snd_soc_dapm_aif_in,		/* audio interface input */
 	snd_soc_dapm_aif_out,		/* audio interface output */
 	snd_soc_dapm_siggen,		/* signal generator */
+	snd_soc_dapm_dai,		/* link to DAI structure */
 };
 
 /*
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index bfcf5d7..1a0cec9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1010,6 +1010,7 @@ static int soc_probe_codec(struct snd_soc_card *card,
 {
 	int ret = 0;
 	const struct snd_soc_codec_driver *driver = codec->driver;
+	struct snd_soc_dai *dai;
 
 	codec->card = card;
 	codec->dapm.card = card;
@@ -1024,6 +1025,14 @@ static int soc_probe_codec(struct snd_soc_card *card,
 		snd_soc_dapm_new_controls(&codec->dapm, driver->dapm_widgets,
 					  driver->num_dapm_widgets);
 
+	/* Create DAPM widgets for each DAI stream */
+	list_for_each_entry(dai, &dai_list, list) {
+		if (dai->dev != codec->dev)
+			continue;
+
+		snd_soc_dapm_new_dai_widgets(&codec->dapm, dai);
+	}
+
 	codec->dapm.idle_bias_off = driver->idle_bias_off;
 
 	if (driver->probe) {
@@ -1500,6 +1509,8 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 		}
 	}
 
+	snd_soc_dapm_link_dai_widgets(card);
+
 	if (card->controls)
 		snd_soc_add_card_controls(card, card->controls, card->num_controls);
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 21c7b31..ebf1a60 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -53,6 +53,7 @@ static int dapm_up_seq[] = {
 	[snd_soc_dapm_supply] = 1,
 	[snd_soc_dapm_regulator_supply] = 1,
 	[snd_soc_dapm_micbias] = 2,
+	[snd_soc_dapm_dai] = 3,
 	[snd_soc_dapm_aif_in] = 3,
 	[snd_soc_dapm_aif_out] = 3,
 	[snd_soc_dapm_mic] = 4,
@@ -87,6 +88,7 @@ static int dapm_down_seq[] = {
 	[snd_soc_dapm_value_mux] = 9,
 	[snd_soc_dapm_aif_in] = 10,
 	[snd_soc_dapm_aif_out] = 10,
+	[snd_soc_dapm_dai] = 10,
 	[snd_soc_dapm_regulator_supply] = 11,
 	[snd_soc_dapm_supply] = 11,
 	[snd_soc_dapm_post] = 12,
@@ -366,6 +368,7 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
 	case snd_soc_dapm_regulator_supply:
 	case snd_soc_dapm_aif_in:
 	case snd_soc_dapm_aif_out:
+	case snd_soc_dapm_dai:
 	case snd_soc_dapm_hp:
 	case snd_soc_dapm_mic:
 	case snd_soc_dapm_spk:
@@ -523,17 +526,17 @@ static int dapm_new_mixer(struct snd_soc_dapm_widget *w)
 				 * for widgets so cut the prefix off
 				 * the front of the widget name.
 				 */
-				snprintf(path->long_name, name_len, "%s %s",
-					 w->name + prefix_len,
+				snprintf((char *)path->long_name, name_len,
+					 "%s %s", w->name + prefix_len,
 					 w->kcontrol_news[i].name);
 				break;
 			case snd_soc_dapm_mixer_named_ctl:
-				snprintf(path->long_name, name_len, "%s",
-					 w->kcontrol_news[i].name);
+				snprintf((char *)path->long_name, name_len,
+					 "%s", w->kcontrol_news[i].name);
 				break;
 			}
 
-			path->long_name[name_len - 1] = '\0';
+			((char *)path->long_name)[name_len - 1] = '\0';
 
 			path->kcontrol = snd_soc_cnew(&w->kcontrol_news[i],
 						      wlist, path->long_name,
@@ -567,7 +570,7 @@ static int dapm_new_mux(struct snd_soc_dapm_widget *w)
 	struct snd_soc_dapm_widget_list *wlist;
 	int shared, wlistentries;
 	size_t wlistsize;
-	char *name;
+	const char *name;
 
 	if (w->num_kcontrols != 1) {
 		dev_err(dapm->dev,
@@ -703,6 +706,7 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget)
 	switch (widget->id) {
 	case snd_soc_dapm_adc:
 	case snd_soc_dapm_aif_out:
+	case snd_soc_dapm_dai:
 		if (widget->active) {
 			widget->outputs = snd_soc_dapm_suspend_check(widget);
 			return widget->outputs;
@@ -774,6 +778,7 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget)
 	switch (widget->id) {
 	case snd_soc_dapm_dac:
 	case snd_soc_dapm_aif_in:
+	case snd_soc_dapm_dai:
 		if (widget->active) {
 			widget->inputs = snd_soc_dapm_suspend_check(widget);
 			return widget->inputs;
@@ -893,6 +898,13 @@ static int dapm_generic_check_power(struct snd_soc_dapm_widget *w)
 	return out != 0 && in != 0;
 }
 
+static int dapm_dai_check_power(struct snd_soc_dapm_widget *w)
+{
+	DAPM_UPDATE_STAT(w, power_checks);
+
+	return w->active;
+}
+
 /* Check to see if an ADC has power */
 static int dapm_adc_check_power(struct snd_soc_dapm_widget *w)
 {
@@ -2052,6 +2064,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	case snd_soc_dapm_regulator_supply:
 	case snd_soc_dapm_aif_in:
 	case snd_soc_dapm_aif_out:
+	case snd_soc_dapm_dai:
 		list_add(&path->list, &dapm->card->paths);
 		list_add(&path->list_sink, &wsink->sources);
 		list_add(&path->list_source, &wsource->sinks);
@@ -2735,10 +2748,10 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 		return NULL;
 	}
 	if (dapm->codec && dapm->codec->name_prefix)
-		snprintf(w->name, name_len, "%s %s",
+		snprintf((char *)w->name, name_len, "%s %s",
 			dapm->codec->name_prefix, widget->name);
 	else
-		snprintf(w->name, name_len, "%s", widget->name);
+		snprintf((char *)w->name, name_len, "%s", widget->name);
 
 	switch (w->id) {
 	case snd_soc_dapm_switch:
@@ -2774,6 +2787,9 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	case snd_soc_dapm_regulator_supply:
 		w->power_check = dapm_supply_check_power;
 		break;
+	case snd_soc_dapm_dai:
+		w->power_check = dapm_dai_check_power;
+		break;
 	default:
 		w->power_check = dapm_always_on_check_power;
 		break;
@@ -2825,6 +2841,109 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_new_controls);
 
+int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
+				 struct snd_soc_dai *dai)
+{
+	struct snd_soc_dapm_widget template;
+	struct snd_soc_dapm_widget *w;
+
+	WARN_ON(dapm->dev != dai->dev);
+
+	memset(&template, 0, sizeof(template));
+	template.reg = SND_SOC_NOPM;
+
+	if (dai->driver->playback.stream_name) {
+		template.id = snd_soc_dapm_dai;
+		template.name = dai->driver->playback.stream_name;
+		template.sname = dai->driver->playback.stream_name;
+
+		dev_dbg(dai->dev, "adding %s widget\n",
+			template.name);
+
+		w = snd_soc_dapm_new_control(dapm, &template);
+		if (!w) {
+			dev_err(dapm->dev, "Failed to create %s widget\n",
+				dai->driver->playback.stream_name);
+		}
+
+		w->priv = dai;
+		dai->playback_widget = w;
+	}
+
+	if (dai->driver->capture.stream_name) {
+		template.id = snd_soc_dapm_dai;
+		template.name = dai->driver->capture.stream_name;
+		template.sname = dai->driver->capture.stream_name;
+
+		dev_dbg(dai->dev, "adding %s widget\n",
+			template.name);
+
+		w = snd_soc_dapm_new_control(dapm, &template);
+		if (!w) {
+			dev_err(dapm->dev, "Failed to create %s widget\n",
+				dai->driver->capture.stream_name);
+		}
+
+		w->priv = dai;
+		dai->capture_widget = w;
+	}
+
+	return 0;
+}
+
+int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
+{
+	struct snd_soc_dapm_widget *dai_w, *w;
+	struct snd_soc_dai *dai;
+	struct snd_soc_dapm_route r;
+
+	memset(&r, 0, sizeof(r));
+
+	/* For each DAI widget... */
+	list_for_each_entry(dai_w, &card->widgets, list) {
+		if (dai_w->id != snd_soc_dapm_dai)
+			continue;
+
+		dai = dai_w->priv;
+
+		/* ...find all widgets with the same stream and link them */
+		list_for_each_entry(w, &card->widgets, list) {
+			if (w->dapm != dai_w->dapm)
+				continue;
+
+			if (w->id == snd_soc_dapm_dai)
+				continue;
+
+			if (!w->sname)
+				continue;
+
+			if (dai->driver->playback.stream_name &&
+			    strstr(w->sname,
+				   dai->driver->playback.stream_name)) {
+				r.source = dai->playback_widget->name;
+				r.sink = w->name;
+				dev_dbg(dai->dev, "%s -> %s\n",
+					 r.source, r.sink);
+
+				snd_soc_dapm_add_route(w->dapm, &r);
+			}
+
+			if (dai->driver->capture.stream_name &&
+			    strstr(w->sname,
+				   dai->driver->capture.stream_name)) {
+				r.source = w->name;
+				r.sink = dai->capture_widget->name;
+				dev_dbg(dai->dev, "%s -> %s\n",
+					r.source, r.sink);
+
+				snd_soc_dapm_add_route(w->dapm, &r);
+			}
+		}
+	}
+
+	return 0;
+}
+
 static void soc_dapm_stream_event(struct snd_soc_dapm_context *dapm,
 				  int stream, struct snd_soc_dai *dai,
 				  int event)
-- 
1.7.9.rc1
