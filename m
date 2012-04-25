From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 1/5] ASoC: dpcm: Add Dynamic PCM core
	operations.
Date: Wed, 25 Apr 2012 12:12:49 +0100
Message-ID: <1335352373-5237-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog103.obsmtp.com (na3sys009aog103.obsmtp.com
	[74.125.149.71])
	by alsa0.perex.cz (Postfix) with ESMTP id B9CE11048A9
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Apr 2012 13:13:47 +0200 (CEST)
Received: by wgbds12 with SMTP id ds12so1657998wgb.19
	for <alsa-devel@alsa-project.org>; Wed, 25 Apr 2012 04:13:45 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The Dynamic PCM core allows digital audio data to be dynamically
routed between different ALSA PCMs and DAI links on SoC CPUs with
on chip DSP devices. e.g. audio data could be played on pcm:0,0 and
routed to any (or all) SoC DAI links.

Dynamic PCM introduces the concept of Front End (FE) PCMs and Back
End (BE) PCMs. The FE PCMs are normal ALSA PCM devices except that
they can dynamically route digital audio data to any supported BE
PCM. A BE PCM has no ALSA device, but represents a DAI link and it's
substream and audio HW parameters.

e.g. pcm:0,0 routing digital data to 2 external codecs.

FE pcm:0,0  ----> BE (McBSP.0) ----> CODEC 0
             +--> BE (McPDM.0) ----> CODEC 1

e.g. pcm:0,0 and pcm:0,1 routing digital data to 1 external codec.

FE pcm:0,0 ---
             +--> BE (McBSP.0) ----> CODEC
FE pcm:0,1 ---

The digital audio routing is controlled by the usual ALSA method
of mixer kcontrols. Dynamic PCM uses a DAPM graph to work out the
routing based upon the mixer settings and configures the BE PCMs
based on routing and the FE HW params.

DPCM is designed so that most ASoC component drivers will need no
modification at all. It's intended that existing CODEC, DAI and
platform drivers can be used in DPCM based audio devices without
any changes. However, there will be some cases where minor changes
are required (e.g. for very tightly coupled HW) and there are
helpers to support this too.

Somethimes the HW params of a FE and BE do not match or are
incompatible, so in these cases the machine driver can reconfigure
any hw_params and make any DSP perform sample rate / format conversion.

This patch adds the core DPCM code and contains :-

 o The FE and BE PCM operations.
 o FE and BE DAI link support.
 o FE and BE PCM creation.
 o BE support API.
 o BE and FE link management.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 include/sound/soc-dpcm.h |  132 +++++
 include/sound/soc.h      |   17 +
 sound/soc/soc-core.c     |    5 +
 sound/soc/soc-pcm.c      | 1246 ++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 1370 insertions(+), 30 deletions(-)
 create mode 100644 include/sound/soc-dpcm.h

diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
new file mode 100644
index 0000000..cd72c10
--- /dev/null
+++ b/include/sound/soc-dpcm.h
@@ -0,0 +1,132 @@
+/*
+ * linux/sound/soc-dpcm.h -- ALSA SoC Dynamic PCM Support
+ *
+ * Author:		Liam Girdwood <lrg@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_SND_SOC_DPCM_H
+#define __LINUX_SND_SOC_DPCM_H
+
+#include <linux/list.h>
+#include <sound/pcm.h>
+
+struct snd_soc_pcm_runtime;
+
+/*
+ * Types of runtime_update to perform. e.g. originated from FE PCM ops
+ * or audio route changes triggered by muxes/mixers.
+ */
+enum snd_soc_dpcm_update {
+	SND_SOC_DPCM_UPDATE_NO	= 0,
+	SND_SOC_DPCM_UPDATE_BE,
+	SND_SOC_DPCM_UPDATE_FE,
+};
+
+/*
+ * Dynamic PCM Frontend -> Backend link management states.
+ */
+enum snd_soc_dpcm_link_state {
+	SND_SOC_DPCM_LINK_STATE_NEW	= 0,	/* newly created link */
+	SND_SOC_DPCM_LINK_STATE_FREE,		/* link to be dismantled */
+};
+
+/*
+ * Dynamic PCM Frontend -> Backend link PCM states.
+ */
+enum snd_soc_dpcm_state {
+	SND_SOC_DPCM_STATE_NEW	= 0,
+	SND_SOC_DPCM_STATE_OPEN,
+	SND_SOC_DPCM_STATE_HW_PARAMS,
+	SND_SOC_DPCM_STATE_PREPARE,
+	SND_SOC_DPCM_STATE_START,
+	SND_SOC_DPCM_STATE_STOP,
+	SND_SOC_DPCM_STATE_PAUSED,
+	SND_SOC_DPCM_STATE_SUSPEND,
+	SND_SOC_DPCM_STATE_HW_FREE,
+	SND_SOC_DPCM_STATE_CLOSE,
+};
+
+/*
+ * Dynamic PCM trigger ordering. Triggering flexibility is required as some
+ * DSPs require triggering before/after their CPU platform and DAIs.
+ *
+ * i.e. some clients may want to manually order this call in their PCM
+ * trigger() whilst others will just use the regular core ordering.
+ */
+enum snd_soc_dpcm_trigger {
+	SND_SOC_DPCM_TRIGGER_PRE		= 0,
+	SND_SOC_DPCM_TRIGGER_POST,
+};
+
+/*
+ * Dynamic PCM link
+ * This links together a FE and BE DAI at runtime and stores the link
+ * state information and the hw_params configuration.
+ */
+struct snd_soc_dpcm {
+	/* FE and BE DAIs*/
+	struct snd_soc_pcm_runtime *be;
+	struct snd_soc_pcm_runtime *fe;
+
+	/* link state */
+	enum snd_soc_dpcm_link_state state;
+
+	/* list of BE and FE for this DPCM link */
+	struct list_head list_be;
+	struct list_head list_fe;
+
+	/* hw params for this link - may be different for each link */
+	struct snd_pcm_hw_params hw_params;
+};
+
+/*
+ * Dynamic PCM runtime data.
+ */
+struct snd_soc_dpcm_runtime {
+	struct list_head be_clients;
+	struct list_head fe_clients;
+
+	int users;
+	struct snd_pcm_runtime *runtime;
+	struct snd_pcm_hw_params hw_params;
+
+	/* state and update */
+	enum snd_soc_dpcm_update runtime_update;
+	enum snd_soc_dpcm_state state;
+};
+
+/* can this BE stop and free */
+int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
+		struct snd_soc_pcm_runtime *be, int stream);
+
+/* can this BE perform a hw_params() */
+int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
+		struct snd_soc_pcm_runtime *be, int stream);
+
+/* is the current PCM operation for this FE ? */
+int snd_soc_dpcm_fe_can_update(struct snd_soc_pcm_runtime *fe, int stream);
+
+/* is the current PCM operation for this BE ? */
+int snd_soc_dpcm_be_can_update(struct snd_soc_pcm_runtime *fe,
+		struct snd_soc_pcm_runtime *be, int stream);
+
+/* get the substream for this BE */
+struct snd_pcm_substream *
+	snd_soc_dpcm_get_substream(struct snd_soc_pcm_runtime *be, int stream);
+
+/* get the BE runtime state */
+enum snd_soc_dpcm_state
+	snd_soc_dpcm_be_get_state(struct snd_soc_pcm_runtime *be, int stream);
+
+/* set the BE runtime state */
+void snd_soc_dpcm_be_set_state(struct snd_soc_pcm_runtime *be, int stream,
+	enum snd_soc_dpcm_state state);
+
+/* internal use only */
+int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute);
+
+#endif
diff --git a/include/sound/soc.h b/include/sound/soc.h
index afc3204..c2eb563 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -274,6 +274,7 @@ struct snd_soc_jack_zone;
 struct snd_soc_jack_pin;
 struct snd_soc_cache_ops;
 #include <sound/soc-dapm.h>
+#include <sound/soc-dpcm.h>
 
 #ifdef CONFIG_GPIOLIB
 struct snd_soc_jack_gpio;
@@ -760,23 +761,36 @@ struct snd_soc_dai_link {
 	const char *cpu_dai_name;
 	const struct device_node *cpu_dai_of_node;
 	const char *codec_dai_name;
+	int be_id;	/* optional ID for machine driver BE identification */
 
 	const struct snd_soc_pcm_stream *params;
 
 	unsigned int dai_fmt;           /* format to set on init */
 
+	enum snd_soc_dpcm_trigger trigger[2]; /* trigger type for DPCM */
+
 	/* Keep DAI active over suspend */
 	unsigned int ignore_suspend:1;
 
 	/* Symmetry requirements */
 	unsigned int symmetric_rates:1;
 
+	/* Do not create a PCM for this DAI link (Backend link) */
+	unsigned int no_pcm:1;
+
+	/* This DAI link can route to other DAI links at runtime (Frontend)*/
+	unsigned int dynamic:1;
+
 	/* pmdown_time is ignored at stop */
 	unsigned int ignore_pmdown_time:1;
 
 	/* codec/machine specific init - e.g. add machine controls */
 	int (*init)(struct snd_soc_pcm_runtime *rtd);
 
+	/* optional hw_params re-writing for BE and FE sync */
+	int (*be_hw_params_fixup)(struct snd_soc_pcm_runtime *rtd,
+			struct snd_pcm_hw_params *params);
+
 	/* machine stream operations */
 	struct snd_soc_ops *ops;
 };
@@ -908,6 +922,9 @@ struct snd_soc_pcm_runtime {
 
 	unsigned int dev_registered:1;
 
+	/* Dynamic PCM BE runtime data */
+	struct snd_soc_dpcm_runtime dpcm[2];
+
 	long pmdown_time;
 
 	/* runtime devices */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 5d308e9..1a2626d 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -39,6 +39,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/soc-dpcm.h>
 #include <sound/initval.h>
 
 #define CREATE_TRACE_POINTS
@@ -1161,6 +1162,10 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	rtd->dev->init_name = name;
 	dev_set_drvdata(rtd->dev, rtd);
 	mutex_init(&rtd->pcm_mutex);
+	INIT_LIST_HEAD(&rtd->dpcm[SNDRV_PCM_STREAM_PLAYBACK].be_clients);
+	INIT_LIST_HEAD(&rtd->dpcm[SNDRV_PCM_STREAM_CAPTURE].be_clients);
+	INIT_LIST_HEAD(&rtd->dpcm[SNDRV_PCM_STREAM_PLAYBACK].fe_clients);
+	INIT_LIST_HEAD(&rtd->dpcm[SNDRV_PCM_STREAM_CAPTURE].fe_clients);
 	ret = device_add(rtd->dev);
 	if (ret < 0) {
 		dev_err(card->dev,
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 26a60b4..458f116 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -22,12 +22,37 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
+#include <linux/export.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/soc-dpcm.h>
 #include <sound/initval.h>
 
+#define DPCM_MAX_BE_USERS	8
+
+/* DPCM stream event, send event to FE and all active BEs. */
+static int dpcm_dapm_stream_event(struct snd_soc_pcm_runtime *fe, int dir,
+	int event)
+{
+	struct snd_soc_dpcm *dpcm;
+
+	list_for_each_entry(dpcm, &fe->dpcm[dir].be_clients, list_be) {
+
+		struct snd_soc_pcm_runtime *be = dpcm->be;
+
+		dev_dbg(be->dev, "pm: BE %s event %d dir %d\n",
+				be->dai_link->name, event, dir);
+
+		snd_soc_dapm_stream_event(be, dir, event);
+	}
+
+	snd_soc_dapm_stream_event(fe, dir, event);
+
+	return 0;
+}
+
 static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream,
 					struct snd_soc_dai *soc_dai)
 {
@@ -156,6 +181,10 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		}
 	}
 
+	/* Dynamic PCM DAI links compat checks use dynamic capabilities */
+	if (rtd->dai_link->dynamic || rtd->dai_link->no_pcm)
+		goto dynamic;
+
 	/* Check that the codec and cpu DAIs are compatible */
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		runtime->hw.rate_min =
@@ -248,6 +277,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	pr_debug("asoc: min rate %d max rate %d\n", runtime->hw.rate_min,
 		 runtime->hw.rate_max);
 
+dynamic:
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		cpu_dai->playback_active++;
 		codec_dai->playback_active++;
@@ -633,6 +663,1025 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	return offset;
 }
 
+/* connect a FE and BE */
+static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
+		struct snd_soc_pcm_runtime *be, int stream)
+{
+	struct snd_soc_dpcm *dpcm;
+
+	/* only add new dpcms */
+	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+		if (dpcm->be == be && dpcm->fe == fe)
+			return 0;
+	}
+
+	dpcm = kzalloc(sizeof(struct snd_soc_dpcm), GFP_KERNEL);
+	if (!dpcm)
+		return -ENOMEM;
+
+	dpcm->be = be;
+	dpcm->fe = fe;
+	be->dpcm[stream].runtime = fe->dpcm[stream].runtime;
+	dpcm->state = SND_SOC_DPCM_LINK_STATE_NEW;
+	list_add(&dpcm->list_be, &fe->dpcm[stream].be_clients);
+	list_add(&dpcm->list_fe, &be->dpcm[stream].fe_clients);
+
+	dev_dbg(fe->dev, "  connected new DPCM %s path %s %s %s\n",
+			stream ? "capture" : "playback",  fe->dai_link->name,
+			stream ? "<-" : "->", be->dai_link->name);
+
+	return 1;
+}
+
+/* reparent a BE onto another FE */
+static void dpcm_be_reparent(struct snd_soc_pcm_runtime *fe,
+			struct snd_soc_pcm_runtime *be, int stream)
+{
+	struct snd_soc_dpcm *dpcm;
+	struct snd_pcm_substream *fe_substream, *be_substream;
+
+	/* reparent if BE is connected to other FEs */
+	if (!be->dpcm[stream].users)
+		return;
+
+	be_substream = snd_soc_dpcm_get_substream(be, stream);
+
+	list_for_each_entry(dpcm, &be->dpcm[stream].fe_clients, list_fe) {
+		if (dpcm->fe == fe)
+			continue;
+
+		dev_dbg(fe->dev, "  reparent %s path %s %s %s\n",
+			stream ? "capture" : "playback",
+			dpcm->fe->dai_link->name,
+			stream ? "<-" : "->", dpcm->be->dai_link->name);
+
+		fe_substream = snd_soc_dpcm_get_substream(dpcm->fe, stream);
+		be_substream->runtime = fe_substream->runtime;
+		break;
+	}
+}
+
+/* disconnect a BE and FE */
+static void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
+{
+	struct snd_soc_dpcm *dpcm, *d;
+
+	list_for_each_entry_safe(dpcm, d, &fe->dpcm[stream].be_clients, list_be) {
+		dev_dbg(fe->dev, "BE %s disconnect check for %s\n",
+				stream ? "capture" : "playback",
+				dpcm->be->dai_link->name);
+
+		if (dpcm->state != SND_SOC_DPCM_LINK_STATE_FREE)
+			continue;
+
+		dev_dbg(fe->dev, "  freed DSP %s path %s %s %s\n",
+			stream ? "capture" : "playback", fe->dai_link->name,
+			stream ? "<-" : "->", dpcm->be->dai_link->name);
+
+		/* BEs still alive need new FE */
+		dpcm_be_reparent(fe, dpcm->be, stream);
+
+		list_del(&dpcm->list_be);
+		list_del(&dpcm->list_fe);
+		kfree(dpcm);
+	}
+}
+
+/* get BE for DAI widget and stream */
+static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
+		struct snd_soc_dapm_widget *widget, int stream)
+{
+	struct snd_soc_pcm_runtime *be;
+	int i;
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		for (i = 0; i < card->num_links; i++) {
+			be = &card->rtd[i];
+
+			if (be->cpu_dai->playback_widget == widget ||
+				be->codec_dai->playback_widget == widget)
+				return be;
+		}
+	} else {
+
+		for (i = 0; i < card->num_links; i++) {
+			be = &card->rtd[i];
+
+			if (be->cpu_dai->capture_widget == widget ||
+				be->codec_dai->capture_widget == widget)
+				return be;
+		}
+	}
+
+	dev_err(card->dev, "can't get %s BE for %s\n",
+		stream ? "capture" : "playback", widget->name);
+	return NULL;
+}
+
+static inline struct snd_soc_dapm_widget *
+	rtd_get_cpu_widget(struct snd_soc_pcm_runtime *rtd, int stream)
+{
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return rtd->cpu_dai->playback_widget;
+	else
+		return rtd->cpu_dai->capture_widget;
+}
+
+static inline struct snd_soc_dapm_widget *
+	rtd_get_codec_widget(struct snd_soc_pcm_runtime *rtd, int stream)
+{
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		return rtd->codec_dai->playback_widget;
+	else
+		return rtd->codec_dai->capture_widget;
+}
+
+static int widget_in_list(struct snd_soc_dapm_widget_list *list,
+		struct snd_soc_dapm_widget *widget)
+{
+	int i;
+
+	for (i = 0; i < list->num_widgets; i++) {
+		if (widget == list->widgets[i])
+			return 1;
+	}
+
+	return 0;
+}
+
+static int dpcm_path_get(struct snd_soc_pcm_runtime *fe,
+	int stream, struct snd_soc_dapm_widget_list **list_)
+{
+	struct snd_soc_dai *cpu_dai = fe->cpu_dai;
+	struct snd_soc_dapm_widget_list *list;
+	int paths;
+
+	list = kzalloc(sizeof(struct snd_soc_dapm_widget_list) +
+			sizeof(struct snd_soc_dapm_widget *), GFP_KERNEL);
+	if (list == NULL)
+		return -ENOMEM;
+
+	/* get number of valid DAI paths and their widgets */
+	paths = snd_soc_dapm_dai_get_connected_widgets(cpu_dai, stream, &list);
+
+	dev_dbg(fe->dev, "found %d audio %s paths\n", paths,
+			stream ? "capture" : "playback");
+
+	*list_ = list;
+	return paths;
+}
+
+static inline void dpcm_path_put(struct snd_soc_dapm_widget_list **list)
+{
+	kfree(*list);
+}
+
+static int dpcm_prune_paths(struct snd_soc_pcm_runtime *fe, int stream,
+	struct snd_soc_dapm_widget_list **list_)
+{
+	struct snd_soc_dpcm *dpcm;
+	struct snd_soc_dapm_widget_list *list = *list_;
+	struct snd_soc_dapm_widget *widget;
+	int prune = 0;
+
+	/* Destroy any old FE <--> BE connections */
+	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+
+		/* is there a valid CPU DAI widget for this BE */
+		widget = rtd_get_cpu_widget(dpcm->be, stream);
+
+		/* prune the BE if it's no longer in our active list */
+		if (widget && widget_in_list(list, widget))
+			continue;
+
+		/* is there a valid CODEC DAI widget for this BE */
+		widget = rtd_get_codec_widget(dpcm->be, stream);
+
+		/* prune the BE if it's no longer in our active list */
+		if (widget && widget_in_list(list, widget))
+			continue;
+
+		dev_dbg(fe->dev, "pruning %s BE %s for %s\n",
+			stream ? "capture" : "playback",
+			dpcm->be->dai_link->name, fe->dai_link->name);
+		dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
+		dpcm->be->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_BE;
+		prune++;
+	}
+
+	dev_dbg(fe->dev, "found %d old BE paths for pruning\n", prune);
+	return prune;
+}
+
+static int dpcm_add_paths(struct snd_soc_pcm_runtime *fe, int stream,
+	struct snd_soc_dapm_widget_list **list_)
+{
+	struct snd_soc_card *card = fe->card;
+	struct snd_soc_dapm_widget_list *list = *list_;
+	struct snd_soc_pcm_runtime *be;
+	int i, new = 0, err;
+
+	/* Create any new FE <--> BE connections */
+	for (i = 0; i < list->num_widgets; i++) {
+
+		if (list->widgets[i]->id != snd_soc_dapm_dai)
+			continue;
+
+		/* is there a valid BE rtd for this widget */
+		be = dpcm_get_be(card, list->widgets[i], stream);
+		if (!be) {
+			dev_err(fe->dev, "no BE found for %s\n",
+					list->widgets[i]->name);
+			continue;
+		}
+
+		/* make sure BE is a real BE */
+		if (!be->dai_link->no_pcm)
+			continue;
+
+		/* don't connect if FE is not running */
+		if (!fe->dpcm[stream].runtime)
+			continue;
+
+		/* newly connected FE and BE */
+		err = dpcm_be_connect(fe, be, stream);
+		if (err < 0) {
+			dev_err(fe->dev, "can't connect %s\n",
+				list->widgets[i]->name);
+			break;
+		} else if (err == 0) /* already connected */
+			continue;
+
+		/* new */
+		be->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_BE;
+		new++;
+	}
+
+	dev_dbg(fe->dev, "found %d new BE paths\n", new);
+	return new;
+}
+
+/*
+ * Find the corresponding BE DAIs that source or sink audio to this
+ * FE substream.
+ */
+static int dpcm_process_paths(struct snd_soc_pcm_runtime *fe,
+	int stream, struct snd_soc_dapm_widget_list **list, int new)
+{
+	if (new)
+		return dpcm_add_paths(fe, stream, list);
+	else
+		return dpcm_prune_paths(fe, stream, list);
+}
+
+static void dpcm_clear_pending_state(struct snd_soc_pcm_runtime *fe, int stream)
+{
+	struct snd_soc_dpcm *dpcm;
+
+	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be)
+		dpcm->be->dpcm[stream].runtime_update =
+						SND_SOC_DPCM_UPDATE_NO;
+}
+
+static void dpcm_be_dai_startup_unwind(struct snd_soc_pcm_runtime *fe,
+	int stream)
+{
+	struct snd_soc_dpcm *dpcm;
+
+	/* disable any enabled and non active backends */
+	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+
+		struct snd_soc_pcm_runtime *be = dpcm->be;
+		struct snd_pcm_substream *be_substream =
+			snd_soc_dpcm_get_substream(be, stream);
+
+		if (be->dpcm[stream].users == 0)
+			dev_err(be->dev, "no users %s at close - state %d\n",
+				stream ? "capture" : "playback",
+				be->dpcm[stream].state);
+
+		if (--be->dpcm[stream].users != 0)
+			continue;
+
+		if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_OPEN)
+			continue;
+
+		soc_pcm_close(be_substream);
+		be_substream->runtime = NULL;
+		be->dpcm[stream].state = SND_SOC_DPCM_STATE_CLOSE;
+	}
+}
+
+static int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
+{
+	struct snd_soc_dpcm *dpcm;
+	int err, count = 0;
+
+	/* only startup BE DAIs that are either sinks or sources to this FE DAI */
+	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+
+		struct snd_soc_pcm_runtime *be = dpcm->be;
+		struct snd_pcm_substream *be_substream =
+			snd_soc_dpcm_get_substream(be, stream);
+
+		/* is this op for this BE ? */
+		if (!snd_soc_dpcm_be_can_update(fe, be, stream))
+			continue;
+
+		/* first time the dpcm is open ? */
+		if (be->dpcm[stream].users == DPCM_MAX_BE_USERS)
+			dev_err(be->dev, "too many users %s at open %d\n",
+				stream ? "capture" : "playback",
+				be->dpcm[stream].state);
+
+		if (be->dpcm[stream].users++ != 0)
+			continue;
+
+		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_NEW) &&
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_CLOSE))
+			continue;
+
+		dev_dbg(be->dev, "dpcm: open BE %s\n", be->dai_link->name);
+
+		be_substream->runtime = be->dpcm[stream].runtime;
+		err = soc_pcm_open(be_substream);
+		if (err < 0) {
+			dev_err(be->dev, "BE open failed %d\n", err);
+			be->dpcm[stream].users--;
+			if (be->dpcm[stream].users < 0)
+				dev_err(be->dev, "no users %s at unwind %d\n",
+					stream ? "capture" : "playback",
+					be->dpcm[stream].state);
+
+			be->dpcm[stream].state = SND_SOC_DPCM_STATE_CLOSE;
+			goto unwind;
+		}
+
+		be->dpcm[stream].state = SND_SOC_DPCM_STATE_OPEN;
+		count++;
+	}
+
+	return count;
+
+unwind:
+	/* disable any enabled and non active backends */
+	list_for_each_entry_continue_reverse(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+		struct snd_soc_pcm_runtime *be = dpcm->be;
+		struct snd_pcm_substream *be_substream =
+			snd_soc_dpcm_get_substream(be, stream);
+
+		if (!snd_soc_dpcm_be_can_update(fe, be, stream))
+			continue;
+
+		if (be->dpcm[stream].users == 0)
+			dev_err(be->dev, "no users %s at close %d\n",
+				stream ? "capture" : "playback",
+				be->dpcm[stream].state);
+
+		if (--be->dpcm[stream].users != 0)
+			continue;
+
+		if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_OPEN)
+			continue;
+
+		soc_pcm_close(be_substream);
+		be_substream->runtime = NULL;
+		be->dpcm[stream].state = SND_SOC_DPCM_STATE_CLOSE;
+	}
+
+	return err;
+}
+
+void dpcm_set_fe_runtime(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai_driver *cpu_dai_drv = cpu_dai->driver;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		runtime->hw.rate_min = cpu_dai_drv->playback.rate_min;
+		runtime->hw.rate_max = cpu_dai_drv->playback.rate_max;
+		runtime->hw.channels_min = cpu_dai_drv->playback.channels_min;
+		runtime->hw.channels_max = cpu_dai_drv->playback.channels_max;
+		runtime->hw.formats &= cpu_dai_drv->playback.formats;
+		runtime->hw.rates = cpu_dai_drv->playback.rates;
+	} else {
+		runtime->hw.rate_min = cpu_dai_drv->capture.rate_min;
+		runtime->hw.rate_max = cpu_dai_drv->capture.rate_max;
+		runtime->hw.channels_min = cpu_dai_drv->capture.channels_min;
+		runtime->hw.channels_max = cpu_dai_drv->capture.channels_max;
+		runtime->hw.formats &= cpu_dai_drv->capture.formats;
+		runtime->hw.rates = cpu_dai_drv->capture.rates;
+	}
+}
+
+static int dpcm_fe_dai_startup(struct snd_pcm_substream *fe_substream)
+{
+	struct snd_soc_pcm_runtime *fe = fe_substream->private_data;
+	struct snd_pcm_runtime *runtime = fe_substream->runtime;
+	int stream = fe_substream->stream, ret = 0;
+
+	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
+
+	ret = dpcm_be_dai_startup(fe, fe_substream->stream);
+	if (ret < 0) {
+		dev_err(fe->dev,"dpcm: failed to start some BEs %d\n", ret);
+		goto be_err;
+	}
+
+	dev_dbg(fe->dev, "dpcm: open FE %s\n", fe->dai_link->name);
+
+	/* start the DAI frontend */
+	ret = soc_pcm_open(fe_substream);
+	if (ret < 0) {
+		dev_err(fe->dev,"dpcm: failed to start FE %d\n", ret);
+		goto unwind;
+	}
+
+	fe->dpcm[stream].state = SND_SOC_DPCM_STATE_OPEN;
+
+	dpcm_set_fe_runtime(fe_substream);
+	snd_pcm_limit_hw_rates(runtime);
+
+	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
+	return 0;
+
+unwind:
+	dpcm_be_dai_startup_unwind(fe, fe_substream->stream);
+be_err:
+	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
+	return ret;
+}
+
+static int dpcm_be_dai_shutdown(struct snd_soc_pcm_runtime *fe, int stream)
+{
+	struct snd_soc_dpcm *dpcm;
+
+	/* only shutdown BEs that are either sinks or sources to this FE DAI */
+	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+
+		struct snd_soc_pcm_runtime *be = dpcm->be;
+		struct snd_pcm_substream *be_substream =
+			snd_soc_dpcm_get_substream(be, stream);
+
+		/* is this op for this BE ? */
+		if (!snd_soc_dpcm_be_can_update(fe, be, stream))
+			continue;
+
+		if (be->dpcm[stream].users == 0)
+			dev_err(be->dev, "no users %s at close - state %d\n",
+				stream ? "capture" : "playback",
+				be->dpcm[stream].state);
+
+		if (--be->dpcm[stream].users != 0)
+			continue;
+
+		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE) &&
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_OPEN))
+			continue;
+
+		dev_dbg(be->dev, "dpcm: close BE %s\n",
+			dpcm->fe->dai_link->name);
+
+		soc_pcm_close(be_substream);
+		be_substream->runtime = NULL;
+
+		be->dpcm[stream].state = SND_SOC_DPCM_STATE_CLOSE;
+	}
+	return 0;
+}
+
+static int dpcm_fe_dai_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *fe = substream->private_data;
+	int stream = substream->stream;
+
+	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
+
+	/* shutdown the BEs */
+	dpcm_be_dai_shutdown(fe, substream->stream);
+
+	dev_dbg(fe->dev, "dpcm: close FE %s\n", fe->dai_link->name);
+
+	/* now shutdown the frontend */
+	soc_pcm_close(substream);
+
+	/* run the stream event for each BE */
+	dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_STOP);
+
+	fe->dpcm[stream].state = SND_SOC_DPCM_STATE_CLOSE;
+	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
+	return 0;
+}
+
+static int dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime *fe, int stream)
+{
+	struct snd_soc_dpcm *dpcm;
+
+	/* only hw_params backends that are either sinks or sources
+	 * to this frontend DAI */
+	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+
+		struct snd_soc_pcm_runtime *be = dpcm->be;
+		struct snd_pcm_substream *be_substream =
+			snd_soc_dpcm_get_substream(be, stream);
+
+		/* is this op for this BE ? */
+		if (!snd_soc_dpcm_be_can_update(fe, be, stream))
+			continue;
+
+		/* only free hw when no longer used - check all FEs */
+		if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
+				continue;
+
+		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE) &&
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
+			continue;
+
+		dev_dbg(be->dev, "dpcm: hw_free BE %s\n",
+			dpcm->fe->dai_link->name);
+
+		soc_pcm_hw_free(be_substream);
+
+		be->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_FREE;
+	}
+
+	return 0;
+}
+
+int dpcm_fe_dai_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *fe = substream->private_data;
+	int err, stream = substream->stream;
+
+	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
+
+	dev_dbg(fe->dev, "dpcm: hw_free FE %s\n", fe->dai_link->name);
+
+	/* call hw_free on the frontend */
+	err = soc_pcm_hw_free(substream);
+	if (err < 0)
+		dev_err(fe->dev,"dpcm: hw_free FE %s failed\n",
+			fe->dai_link->name);
+
+	/* only hw_params backends that are either sinks or sources
+	 * to this frontend DAI */
+	err = dpcm_be_dai_hw_free(fe, stream);
+
+	fe->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_FREE;
+	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
+
+	mutex_unlock(&fe->card->mutex);
+	return 0;
+}
+
+static int dpcm_be_dai_hw_params(struct snd_soc_pcm_runtime *fe, int stream)
+{
+	struct snd_soc_dpcm *dpcm;
+	int ret;
+
+	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+
+		struct snd_soc_pcm_runtime *be = dpcm->be;
+		struct snd_pcm_substream *be_substream =
+			snd_soc_dpcm_get_substream(be, stream);
+
+		/* is this op for this BE ? */
+		if (!snd_soc_dpcm_be_can_update(fe, be, stream))
+			continue;
+
+		/* only allow hw_params() if no connected FEs are running */
+		if (!snd_soc_dpcm_can_be_params(fe, be, stream))
+			continue;
+
+		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_OPEN) &&
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE))
+			continue;
+
+		dev_dbg(be->dev, "dpcm: hw_params BE %s\n",
+			dpcm->fe->dai_link->name);
+
+		/* copy params for each dpcm */
+		memcpy(&dpcm->hw_params, &fe->dpcm[stream].hw_params,
+				sizeof(struct snd_pcm_hw_params));
+
+		/* perform any hw_params fixups */
+		if (be->dai_link->be_hw_params_fixup) {
+			ret = be->dai_link->be_hw_params_fixup(be,
+					&dpcm->hw_params);
+			if (ret < 0) {
+				dev_err(be->dev,
+					"dpcm: hw_params BE fixup failed %d\n",
+					ret);
+				goto unwind;
+			}
+		}
+
+		ret = soc_pcm_hw_params(be_substream, &dpcm->hw_params);
+		if (ret < 0) {
+			dev_err(dpcm->be->dev,
+				"dpcm: hw_params BE failed %d\n", ret);
+			goto unwind;
+		}
+
+		be->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_PARAMS;
+	}
+	return 0;
+
+unwind:
+	/* disable any enabled and non active backends */
+	list_for_each_entry_continue_reverse(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+		struct snd_soc_pcm_runtime *be = dpcm->be;
+		struct snd_pcm_substream *be_substream =
+			snd_soc_dpcm_get_substream(be, stream);
+
+		if (!snd_soc_dpcm_be_can_update(fe, be, stream))
+			continue;
+
+		/* only allow hw_free() if no connected FEs are running */
+		if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
+			continue;
+
+		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_OPEN) &&
+		   (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
+		   (be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_FREE) &&
+		   (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
+			continue;
+
+		soc_pcm_hw_free(be_substream);
+	}
+
+	return ret;
+}
+
+int dpcm_fe_dai_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *fe = substream->private_data;
+	int ret, stream = substream->stream;
+
+	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
+
+	memcpy(&fe->dpcm[substream->stream].hw_params, params,
+			sizeof(struct snd_pcm_hw_params));
+	ret = dpcm_be_dai_hw_params(fe, substream->stream);
+	if (ret < 0) {
+		dev_err(fe->dev,"dpcm: hw_params BE failed %d\n", ret);
+		goto out;
+	}
+
+	dev_dbg(fe->dev, "dpcm: hw_params FE %s rate %d chan %x fmt %d\n",
+			fe->dai_link->name, params_rate(params),
+			params_channels(params), params_format(params));
+
+	/* call hw_params on the frontend */
+	ret = soc_pcm_hw_params(substream, params);
+	if (ret < 0) {
+		dev_err(fe->dev,"dpcm: hw_params FE failed %d\n", ret);
+		dpcm_be_dai_hw_free(fe, stream);
+	 } else
+		fe->dpcm[stream].state = SND_SOC_DPCM_STATE_HW_PARAMS;
+
+out:
+	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
+	mutex_unlock(&fe->card->mutex);
+	return ret;
+}
+
+static int dpcm_do_trigger(struct snd_soc_dpcm *dpcm,
+		struct snd_pcm_substream *substream, int cmd)
+{
+	int ret;
+
+	dev_dbg(dpcm->be->dev, "dpcm: trigger BE %s cmd %d\n",
+			dpcm->fe->dai_link->name, cmd);
+
+	ret = soc_pcm_trigger(substream, cmd);
+	if (ret < 0)
+		dev_err(dpcm->be->dev,"dpcm: trigger BE failed %d\n", ret);
+
+	return ret;
+}
+
+int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream, int cmd)
+{
+	struct snd_soc_dpcm *dpcm;
+	int ret = 0;
+
+	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+
+		struct snd_soc_pcm_runtime *be = dpcm->be;
+		struct snd_pcm_substream *be_substream =
+			snd_soc_dpcm_get_substream(be, stream);
+
+		/* is this op for this BE ? */
+		if (!snd_soc_dpcm_be_can_update(fe, be, stream))
+			continue;
+
+		switch (cmd) {
+		case SNDRV_PCM_TRIGGER_START:
+			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
+				continue;
+
+			ret = dpcm_do_trigger(dpcm, be_substream, cmd);
+			if (ret)
+				return ret;
+
+			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
+			break;
+		case SNDRV_PCM_TRIGGER_RESUME:
+			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND))
+				continue;
+
+			ret = dpcm_do_trigger(dpcm, be_substream, cmd);
+			if (ret)
+				return ret;
+
+			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
+			break;
+		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
+				continue;
+
+			ret = dpcm_do_trigger(dpcm, be_substream, cmd);
+			if (ret)
+				return ret;
+
+			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
+			break;
+		case SNDRV_PCM_TRIGGER_STOP:
+			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
+				continue;
+
+			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
+				continue;
+
+			ret = dpcm_do_trigger(dpcm, be_substream, cmd);
+			if (ret)
+				return ret;
+
+			be->dpcm[stream].state = SND_SOC_DPCM_STATE_STOP;
+			break;
+		case SNDRV_PCM_TRIGGER_SUSPEND:
+			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP)
+				continue;
+
+			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
+				continue;
+
+			ret = dpcm_do_trigger(dpcm, be_substream, cmd);
+			if (ret)
+				return ret;
+
+			be->dpcm[stream].state = SND_SOC_DPCM_STATE_SUSPEND;
+			break;
+		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
+				continue;
+
+			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
+				continue;
+
+			ret = dpcm_do_trigger(dpcm, be_substream, cmd);
+			if (ret)
+				return ret;
+
+			be->dpcm[stream].state = SND_SOC_DPCM_STATE_PAUSED;
+			break;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dpcm_be_dai_trigger);
+
+int dpcm_fe_dai_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_soc_pcm_runtime *fe = substream->private_data;
+	int stream = substream->stream, ret;
+	enum snd_soc_dpcm_trigger trigger = fe->dai_link->trigger[stream];
+
+	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
+
+	switch (trigger) {
+	case SND_SOC_DPCM_TRIGGER_PRE:
+		/* call trigger on the frontend before the backend. */
+
+		dev_dbg(fe->dev, "dpcm: pre trigger FE %s cmd %d\n",
+				fe->dai_link->name, cmd);
+
+		ret = soc_pcm_trigger(substream, cmd);
+		if (ret < 0) {
+			dev_err(fe->dev,"dpcm: trigger FE failed %d\n", ret);
+			goto out;
+		}
+
+		ret = dpcm_be_dai_trigger(fe, substream->stream, cmd);
+		break;
+	case SND_SOC_DPCM_TRIGGER_POST:
+		/* call trigger on the frontend after the backend. */
+
+		ret = dpcm_be_dai_trigger(fe, substream->stream, cmd);
+		if (ret < 0) {
+			dev_err(fe->dev,"dpcm: trigger FE failed %d\n", ret);
+			goto out;
+		}
+
+		dev_dbg(fe->dev, "dpcm: post trigger FE %s cmd %d\n",
+				fe->dai_link->name, cmd);
+
+		ret = soc_pcm_trigger(substream, cmd);
+		break;
+	default:
+		dev_err(fe->dev, "dpcm: invalid trigger cmd %d for %s\n", cmd,
+				fe->dai_link->name);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		fe->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		fe->dpcm[stream].state = SND_SOC_DPCM_STATE_STOP;
+		break;
+	}
+
+out:
+	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
+	return ret;
+}
+
+static int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
+{
+	struct snd_soc_dpcm *dpcm;
+	int ret = 0;
+
+	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+
+		struct snd_soc_pcm_runtime *be = dpcm->be;
+		struct snd_pcm_substream *be_substream =
+			snd_soc_dpcm_get_substream(be, stream);
+
+		/* is this op for this BE ? */
+		if (!snd_soc_dpcm_be_can_update(fe, be, stream))
+			continue;
+
+		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
+		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP))
+			continue;
+
+		dev_dbg(be->dev, "dpcm: prepare BE %s\n",
+			dpcm->fe->dai_link->name);
+
+		ret = soc_pcm_prepare(be_substream);
+		if (ret < 0) {
+			dev_err(be->dev, "dpcm: backend prepare failed %d\n",
+				ret);
+			break;
+		}
+
+		be->dpcm[stream].state = SND_SOC_DPCM_STATE_PREPARE;
+	}
+	return ret;
+}
+
+int dpcm_fe_dai_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *fe = substream->private_data;
+	int stream = substream->stream, ret = 0;
+
+	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+
+	dev_dbg(fe->dev, "dpcm: prepare FE %s\n", fe->dai_link->name);
+
+	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_FE;
+
+	/* there is no point preparing this FE if there are no BEs */
+	if (list_empty(&fe->dpcm[stream].be_clients)) {
+		dev_err(fe->dev, "dpcm: no backend DAIs enabled for %s\n",
+				fe->dai_link->name);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = dpcm_be_dai_prepare(fe, substream->stream);
+	if (ret < 0)
+		goto out;
+
+	/* call prepare on the frontend */
+	ret = soc_pcm_prepare(substream);
+	if (ret < 0) {
+		dev_err(fe->dev,"dpcm: prepare FE %s failed\n",
+			fe->dai_link->name);
+		goto out;
+	}
+
+	/* run the stream event for each BE */
+	dpcm_dapm_stream_event(fe, stream, SND_SOC_DAPM_STREAM_START);
+	fe->dpcm[stream].state = SND_SOC_DPCM_STATE_PREPARE;
+
+out:
+	fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
+	mutex_unlock(&fe->card->mutex);
+
+	return ret;
+}
+
+
+int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute)
+{
+	struct snd_soc_dpcm *dpcm;
+	struct list_head *clients =
+		&fe->dpcm[SNDRV_PCM_STREAM_PLAYBACK].be_clients;
+
+	list_for_each_entry(dpcm, clients, list_be) {
+
+		struct snd_soc_pcm_runtime *be = dpcm->be;
+		struct snd_soc_dai *dai = be->codec_dai;
+		struct snd_soc_dai_driver *drv = dai->driver;
+
+		if (be->dai_link->ignore_suspend)
+			continue;
+
+		dev_dbg(be->dev, "BE digital mute %s\n", be->dai_link->name);
+
+		if (drv->ops->digital_mute && dai->playback_active)
+				drv->ops->digital_mute(dai, mute);
+	}
+
+	return 0;
+}
+
+int dpcm_fe_dai_open(struct snd_pcm_substream *fe_substream)
+{
+	struct snd_soc_pcm_runtime *fe = fe_substream->private_data;
+	struct snd_soc_dpcm *dpcm;
+	struct snd_soc_dapm_widget_list *list;
+	int ret;
+	int stream = fe_substream->stream;
+
+	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	fe->dpcm[stream].runtime = fe_substream->runtime;
+
+	if (dpcm_path_get(fe, stream, &list) <= 0) {
+		dev_warn(fe->dev, "asoc: %s no valid %s route\n",
+			fe->dai_link->name, stream ? "capture" : "playback");
+			mutex_unlock(&fe->card->mutex);
+			return -EINVAL;
+	}
+
+	/* calculate valid and active FE <-> BE dpcms */
+	dpcm_process_paths(fe, stream, &list, 1);
+
+	ret = dpcm_fe_dai_startup(fe_substream);
+	if (ret < 0) {
+		/* clean up all links */
+		list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be)
+			dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
+
+		dpcm_be_disconnect(fe, stream);
+		fe->dpcm[stream].runtime = NULL;
+	}
+
+	dpcm_clear_pending_state(fe, stream);
+	dpcm_path_put(&list);
+	mutex_unlock(&fe->card->mutex);
+	return ret;
+}
+
+int dpcm_fe_dai_close(struct snd_pcm_substream *fe_substream)
+{
+	struct snd_soc_pcm_runtime *fe = fe_substream->private_data;
+	struct snd_soc_dpcm *dpcm;
+	int stream = fe_substream->stream, ret;
+
+	mutex_lock_nested(&fe->card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	ret = dpcm_fe_dai_shutdown(fe_substream);
+
+	/* mark FE's links ready to prune */
+	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be)
+		dpcm->state = SND_SOC_DPCM_LINK_STATE_FREE;
+
+	dpcm_be_disconnect(fe, stream);
+
+	fe->dpcm[stream].runtime = NULL;
+	mutex_unlock(&fe->card->mutex);
+	return ret;
+}
+
 /* create a new pcm */
 int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 {
@@ -640,56 +1689,92 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_pcm_ops *soc_pcm_ops = &rtd->ops;
 	struct snd_pcm *pcm;
 	char new_name[64];
 	int ret = 0, playback = 0, capture = 0;
 
-	soc_pcm_ops->open	= soc_pcm_open;
-	soc_pcm_ops->close	= soc_pcm_close;
-	soc_pcm_ops->hw_params	= soc_pcm_hw_params;
-	soc_pcm_ops->hw_free	= soc_pcm_hw_free;
-	soc_pcm_ops->prepare	= soc_pcm_prepare;
-	soc_pcm_ops->trigger	= soc_pcm_trigger;
-	soc_pcm_ops->pointer	= soc_pcm_pointer;
-
-	/* check client and interface hw capabilities */
-	snprintf(new_name, sizeof(new_name), "%s %s-%d",
-			rtd->dai_link->stream_name, codec_dai->name, num);
-
-	if (codec_dai->driver->playback.channels_min)
-		playback = 1;
-	if (codec_dai->driver->capture.channels_min)
-		capture = 1;
-
-	dev_dbg(rtd->card->dev, "registered pcm #%d %s\n",num,new_name);
-	ret = snd_pcm_new(rtd->card->snd_card, new_name,
-			num, playback, capture, &pcm);
+	if (rtd->dai_link->dynamic || rtd->dai_link->no_pcm) {
+		if (cpu_dai->driver->playback.channels_min)
+			playback = 1;
+		if (cpu_dai->driver->capture.channels_min)
+			capture = 1;
+	} else {
+		if (codec_dai->driver->playback.channels_min)
+			playback = 1;
+		if (codec_dai->driver->capture.channels_min)
+			capture = 1;
+	}
+
+	/* create the PCM */
+	if (rtd->dai_link->no_pcm) {
+		snprintf(new_name, sizeof(new_name), "(%s)",
+			rtd->dai_link->stream_name);
+
+		ret = snd_pcm_new_internal(rtd->card->snd_card, new_name, num,
+				playback, capture, &pcm);
+	} else {
+		if (rtd->dai_link->dynamic)
+			snprintf(new_name, sizeof(new_name), "%s (*)",
+				rtd->dai_link->stream_name);
+		else
+			snprintf(new_name, sizeof(new_name), "%s %s-%d",
+				rtd->dai_link->stream_name, codec_dai->name, num);
+
+		ret = snd_pcm_new(rtd->card->snd_card, new_name, num, playback,
+			capture, &pcm);
+	}
 	if (ret < 0) {
 		printk(KERN_ERR "asoc: can't create pcm for codec %s\n", codec->name);
 		return ret;
 	}
+	dev_dbg(rtd->card->dev, "registered pcm #%d %s\n",num, new_name);
 
 	/* DAPM dai link stream work */
 	INIT_DELAYED_WORK(&rtd->delayed_work, close_delayed_work);
 
 	rtd->pcm = pcm;
 	pcm->private_data = rtd;
+
+	if (rtd->dai_link->no_pcm) {
+		if (playback)
+			pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream->private_data = rtd;
+		if (capture)
+			pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream->private_data = rtd;
+		goto out;
+	}
+
+	/* ASoC PCM operations */
+	if (rtd->dai_link->dynamic) {
+		rtd->ops.open		= dpcm_fe_dai_open;
+		rtd->ops.hw_params	= dpcm_fe_dai_hw_params;
+		rtd->ops.prepare	= dpcm_fe_dai_prepare;
+		rtd->ops.trigger	= dpcm_fe_dai_trigger;
+		rtd->ops.hw_free	= dpcm_fe_dai_hw_free;
+		rtd->ops.close		= dpcm_fe_dai_close;
+		rtd->ops.pointer	= soc_pcm_pointer;
+	} else {
+		rtd->ops.open		= soc_pcm_open;
+		rtd->ops.hw_params	= soc_pcm_hw_params;
+		rtd->ops.prepare	= soc_pcm_prepare;
+		rtd->ops.trigger	= soc_pcm_trigger;
+		rtd->ops.hw_free	= soc_pcm_hw_free;
+		rtd->ops.close		= soc_pcm_close;
+		rtd->ops.pointer	= soc_pcm_pointer;
+	}
+
 	if (platform->driver->ops) {
-		soc_pcm_ops->mmap = platform->driver->ops->mmap;
-		soc_pcm_ops->pointer = platform->driver->ops->pointer;
-		soc_pcm_ops->ioctl = platform->driver->ops->ioctl;
-		soc_pcm_ops->copy = platform->driver->ops->copy;
-		soc_pcm_ops->silence = platform->driver->ops->silence;
-		soc_pcm_ops->ack = platform->driver->ops->ack;
-		soc_pcm_ops->page = platform->driver->ops->page;
+		rtd->ops.ack		= platform->driver->ops->ack;
+		rtd->ops.copy		= platform->driver->ops->copy;
+		rtd->ops.silence	= platform->driver->ops->silence;
+		rtd->ops.page		= platform->driver->ops->page;
+		rtd->ops.mmap		= platform->driver->ops->mmap;
 	}
 
 	if (playback)
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, soc_pcm_ops);
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &rtd->ops);
 
 	if (capture)
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, soc_pcm_ops);
+		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &rtd->ops);
 
 	if (platform->driver->pcm_new) {
 		ret = platform->driver->pcm_new(rtd);
@@ -700,7 +1785,108 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 	}
 
 	pcm->private_free = platform->driver->pcm_free;
+out:
 	printk(KERN_INFO "asoc: %s <-> %s mapping ok\n", codec_dai->name,
 		cpu_dai->name);
 	return ret;
 }
+
+/* is the current PCM operation for this FE ? */
+int snd_soc_dpcm_fe_can_update(struct snd_soc_pcm_runtime *fe, int stream)
+{
+	if (fe->dpcm[stream].runtime_update == SND_SOC_DPCM_UPDATE_FE)
+		return 1;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dpcm_fe_can_update);
+
+/* is the current PCM operation for this BE ? */
+int snd_soc_dpcm_be_can_update(struct snd_soc_pcm_runtime *fe,
+		struct snd_soc_pcm_runtime *be, int stream)
+{
+	if ((fe->dpcm[stream].runtime_update == SND_SOC_DPCM_UPDATE_FE) ||
+	   ((fe->dpcm[stream].runtime_update == SND_SOC_DPCM_UPDATE_BE) &&
+		  be->dpcm[stream].runtime_update))
+		return 1;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dpcm_be_can_update);
+
+/* get the substream for this BE */
+struct snd_pcm_substream *
+	snd_soc_dpcm_get_substream(struct snd_soc_pcm_runtime *be, int stream)
+{
+	return be->pcm->streams[stream].substream;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dpcm_get_substream);
+
+/* get the BE runtime state */
+enum snd_soc_dpcm_state
+	snd_soc_dpcm_be_get_state(struct snd_soc_pcm_runtime *be, int stream)
+{
+	return be->dpcm[stream].state;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dpcm_be_get_state);
+
+/* set the BE runtime state */
+void snd_soc_dpcm_be_set_state(struct snd_soc_pcm_runtime *be,
+		int stream, enum snd_soc_dpcm_state state)
+{
+	be->dpcm[stream].state = state;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dpcm_be_set_state);
+
+/*
+ * We can only hw_free, stop, pause or suspend a BE DAI if any of it's FE
+ * are not running, paused or suspended for the specified stream direction.
+ */
+int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
+		struct snd_soc_pcm_runtime *be, int stream)
+{
+	struct snd_soc_dpcm *dpcm;
+	int state;
+
+	list_for_each_entry(dpcm, &be->dpcm[stream].fe_clients, list_fe) {
+
+		if (dpcm->fe == fe)
+			continue;
+
+		state = dpcm->fe->dpcm[stream].state;
+		if (state == SND_SOC_DPCM_STATE_START ||
+			state == SND_SOC_DPCM_STATE_PAUSED ||
+			state == SND_SOC_DPCM_STATE_SUSPEND)
+			return 0;
+	}
+
+	/* it's safe to free/stop this BE DAI */
+	return 1;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_free_stop);
+
+/*
+ * We can only change hw params a BE DAI if any of it's FE are not prepared,
+ * running, paused or suspended for the specified stream direction.
+ */
+int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
+		struct snd_soc_pcm_runtime *be, int stream)
+{
+	struct snd_soc_dpcm *dpcm;
+	int state;
+
+	list_for_each_entry(dpcm, &be->dpcm[stream].fe_clients, list_fe) {
+
+		if (dpcm->fe == fe)
+			continue;
+
+		state = dpcm->fe->dpcm[stream].state;
+		if (state == SND_SOC_DPCM_STATE_START ||
+			state == SND_SOC_DPCM_STATE_PAUSED ||
+			state == SND_SOC_DPCM_STATE_SUSPEND ||
+			state == SND_SOC_DPCM_STATE_PREPARE)
+			return 0;
+	}
+
+	/* it's safe to change hw_params */
+	return 1;
+}
+EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_params);
-- 
1.7.5.4
