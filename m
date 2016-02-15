From: Vaibhav Agarwal <vaibhav.agarwal@linaro.org>
Subject: [RFC 3/4] ASoC: Enable dynamic DAIlink insertion &
	removal
Date: Mon, 15 Feb 2016 17:49:31 +0530
Message-ID: <1455538772-24926-4-git-send-email-vaibhav.agarwal@linaro.org>
References: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D682261A3B
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 13:19:51 +0100 (CET)
Received: by mail-pa0-f54.google.com with SMTP id fl4so73490982pad.0
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 04:19:51 -0800 (PST)
In-Reply-To: <1455538772-24926-1-git-send-email-vaibhav.agarwal@linaro.org>
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
Cc: liam.r.girdwood@linux.intel.com, mengdong.lin@linux.intel.com, vinod.koul@intel.com, Vaibhav Agarwal <vaibhav.agarwal@linaro.org>, peter.ujfalusi@ti.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

This patch enables dynamic DAI link insertion & removal from
machine driver.
With the evolvement of modularized platforms, codecs can be
dynamically added to/removed from a platform.
Thus, there is a need to add FE/BE DAIs to an existing sound card
in response to codec inserted/removed.

Another kconfig option SND_SOC_DYNAMIC_DAILINK (default set to y)
is added to avoid compilation issues for client (machine, codec)
drivers with other kernel versions.

Limitations:
This patch enables support for new DAI links in response to new
codec driver & DAIs only.
The same can be extended for new platform drivers added/removed
as well.

Signed-off-by: Vaibhav Agarwal <vaibhav.agarwal@linaro.org>
---
 include/sound/soc-dapm.h |   7 +-
 include/sound/soc-dpcm.h |   1 +
 include/sound/soc.h      |   6 ++
 sound/soc/Kconfig        |   4 +
 sound/soc/soc-core.c     | 264 ++++++++++++++++++++++++++++++++++++++++++++++-
 sound/soc/soc-dapm.c     | 105 +++++++++++++++----
 sound/soc/soc-pcm.c      |  25 +++++
 7 files changed, 391 insertions(+), 21 deletions(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 9706946..f680e3a 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -384,7 +384,10 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 				 struct snd_soc_dai *dai);
 int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card);
-void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card);
+int snd_soc_dapm_link_dai_widgets_component(struct snd_soc_card *card,
+					    struct snd_soc_dapm_context *dapm);
+void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card,
+					   struct snd_soc_pcm_runtime *rtd);
 int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 			 const struct snd_soc_pcm_stream *params,
 			 unsigned int num_params,
@@ -620,6 +623,8 @@ struct snd_soc_dapm_context {
 	unsigned int idle_bias_off:1; /* Use BIAS_OFF instead of STANDBY */
 	/* Go to BIAS_OFF in suspend if the DAPM context is idle */
 	unsigned int suspend_bias_off:1;
+	/* registered dynamically in response to dynamic DAI links */
+	unsigned int dynamic_registered:1;
 	void (*seq_notifier)(struct snd_soc_dapm_context *,
 			     enum snd_soc_dapm_type, int);
 
diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index 8060590..ffac57d 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -144,6 +144,7 @@ int dpcm_process_paths(struct snd_soc_pcm_runtime *fe,
 	int stream, struct snd_soc_dapm_widget_list **list, int new);
 int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream);
 int dpcm_be_dai_shutdown(struct snd_soc_pcm_runtime *fe, int stream);
+void dpcm_fe_disconnect(struct snd_soc_pcm_runtime *be, int stream);
 void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream);
 void dpcm_clear_pending_state(struct snd_soc_pcm_runtime *fe, int stream);
 int dpcm_be_dai_hw_free(struct snd_soc_pcm_runtime *fe, int stream);
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 3dda0c4..44d8568 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -796,6 +796,8 @@ struct snd_soc_component {
 
 	unsigned int ignore_pmdown_time:1; /* pmdown_time is ignored at stop */
 	unsigned int registered_as_component:1;
+	/* registered dynamically in response to dynamic DAI links */
+	unsigned int dynamic_registered:1;
 
 	struct list_head list;
 	struct list_head list_aux; /* for auxiliary component of the card */
@@ -1682,6 +1684,10 @@ int snd_soc_add_dai_link(struct snd_soc_card *card,
 void snd_soc_remove_dai_link(struct snd_soc_card *card,
 			     struct snd_soc_dai_link *dai_link);
 
+int snd_soc_add_dailink(struct snd_soc_card *card,
+			struct snd_soc_dai_link *dai_link);
+void snd_soc_remove_dailink(struct snd_soc_card *card, const char *link_name);
+
 int snd_soc_register_dai(struct snd_soc_component *component,
 	struct snd_soc_dai_driver *dai_drv);
 
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 7ea66ee..a8bb03c 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -22,6 +22,10 @@ menuconfig SND_SOC
 
 if SND_SOC
 
+config SND_SOC_DYNAMIC_DAILINK
+	bool
+        default y
+
 config SND_SOC_AC97_BUS
 	bool
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2b83814..7049f9b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -67,6 +67,13 @@ static int pmdown_time = 5000;
 module_param(pmdown_time, int, 0);
 MODULE_PARM_DESC(pmdown_time, "DAPM stream powerdown time (msecs)");
 
+static int snd_soc_init_codec_cache(struct snd_soc_codec *codec);
+static int soc_probe_link_components(struct snd_soc_card *card,
+				     struct snd_soc_pcm_runtime *rtd,
+				     int order);
+static int soc_probe_link_dais(struct snd_soc_card *card,
+			       struct snd_soc_pcm_runtime *rtd, int order);
+
 /* returns the minimum number of bytes needed to represent
  * a particular given value */
 static int min_bytes_needed(unsigned long val)
@@ -1055,8 +1062,41 @@ _err_defer:
 	return  -EPROBE_DEFER;
 }
 
+static void soc_remove_component_controls(struct snd_soc_component *component)
+{
+	int i, ret, name_len;
+	const struct snd_kcontrol_new *controls = component->controls;
+	struct snd_card *card = component->card->snd_card;
+	const char *prefix, *long_name;
+
+	for (i = 0; i < component->num_controls; i++) {
+		const struct snd_kcontrol_new *control = &controls[i];
+		struct snd_ctl_elem_id id;
+
+		long_name = control->name;
+		prefix = component->name_prefix;
+		name_len = sizeof(id.name);
+		if (prefix)
+			snprintf(id.name, name_len, "%s %s", prefix,
+				 long_name);
+		else
+			strlcpy(id.name, long_name, sizeof(id.name));
+		id.numid = 0;
+		id.iface = control->iface;
+		id.device = control->device;
+		id.subdevice = control->subdevice;
+		id.index = control->index;
+		ret = snd_ctl_remove_id_locked(card, &id);
+		if (ret < 0) {
+			dev_err(component->dev, "%d: Failed to remove %s\n",
+				ret, control->name);
+		}
+	}
+}
+
 static void soc_remove_component(struct snd_soc_component *component)
 {
+	struct snd_soc_dapm_context *dapm;
 	if (!component->card)
 		return;
 
@@ -1065,6 +1105,17 @@ static void soc_remove_component(struct snd_soc_component *component)
 	if (component->ref_count)
 		return;
 
+	/*
+	 * should be done, only in case
+	 * component probed after card instantiation
+	 * assumptions:
+	 * relevant DAI links are already removed
+	 * mutex acquired for soc-card
+	 * semaphore acquired for sound card
+	 */
+	if (component->controls && component->dynamic_registered)
+		soc_remove_component_controls(component);
+
 	/* This is a HACK and will be removed soon */
 	if (component->codec)
 		list_del(&component->codec->card_list);
@@ -1072,9 +1123,12 @@ static void soc_remove_component(struct snd_soc_component *component)
 	if (component->remove)
 		component->remove(component);
 
-	snd_soc_dapm_free(snd_soc_component_get_dapm(component));
+	dapm = snd_soc_component_get_dapm(component);
+	snd_soc_dapm_free(dapm);
 
 	soc_cleanup_component_debugfs(component);
+	component->dynamic_registered = 0;
+	dapm->dynamic_registered = 0;
 	component->card = NULL;
 	module_put(component->dev->driver->owner);
 }
@@ -1143,6 +1197,28 @@ static void soc_remove_link_components(struct snd_soc_card *card,
 	}
 }
 
+static void soc_remove_dai_link(struct snd_soc_card *card,
+				struct snd_soc_pcm_runtime *rtd)
+{
+	int order;
+	struct snd_soc_dai_link *link;
+
+	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
+			order++)
+		soc_remove_link_dais(card, rtd, order);
+
+	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
+			order++)
+		soc_remove_link_components(card, rtd, order);
+
+	link = rtd->dai_link;
+	if (link->dobj.type == SND_SOC_DOBJ_DAI_LINK)
+		dev_warn(card->dev, "Topology forgot to remove link %s?\n",
+			 link->name);
+	list_del(&link->list);
+	card->num_dai_links--;
+}
+
 static void soc_remove_dai_links(struct snd_soc_card *card)
 {
 	int order;
@@ -1339,6 +1415,175 @@ void snd_soc_remove_dai_link(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_soc_remove_dai_link);
 
+/**
+ * snd_soc_add_dailink - add DAI link to an instantiated sound card.
+ *
+ * @card: Sound card identifier to add DAI link to
+ * @dai_link: dai_link configuration to add
+ *
+ * Return 0 for success, else error.
+ */
+int snd_soc_add_dailink(struct snd_soc_card *card,
+			struct snd_soc_dai_link *dai_link)
+{
+	int ret, order;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_codec *codec;
+	struct snd_soc_dapm_context *dapm;
+
+	if (!card)
+		return -EINVAL;
+
+	mutex_lock(&card->mutex);
+	/* init check DAI link */
+	ret = soc_init_dai_link(card, dai_link);
+	if (ret)
+		goto init_error;
+
+	/* bind DAIs */
+	ret = soc_bind_dai_link(card, dai_link);
+	if (ret)
+		goto init_error;
+	rtd = snd_soc_get_pcm_runtime(card, dai_link->name);
+
+	ret = snd_soc_add_dai_link(card, dai_link);
+	if (ret)
+		goto base_error;
+
+	if (!card->instantiated) {
+		dev_info(card->dev,
+			 "ASoC: card not yet instantiated, can exit here\n");
+		mutex_unlock(&card->mutex);
+		return 0;
+	}
+
+	/* initialize the register cache for each available codec */
+	list_for_each_entry(codec, &codec_list, list) {
+		if (codec->cache_init)
+			continue;
+		ret = snd_soc_init_codec_cache(codec);
+		if (ret < 0)
+			goto probe_dai_err;
+	}
+
+	/* probe all components used by DAI link on this card */
+	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
+	     order++) {
+		ret = soc_probe_link_components(card, rtd, order);
+		if (ret < 0) {
+			dev_err(card->dev, "ASoC: failed to probe %s link components, %d\n",
+				dai_link->name, ret);
+			goto probe_dai_err;
+		}
+	}
+
+	/* Find new DAI links added during probing components and bind them.
+	 * Components with topology may bring new DAIs and DAI links.
+	 */
+	list_for_each_entry(dai_link, &card->dai_link_list, list) {
+		if (soc_is_dai_link_bound(card, dai_link))
+			continue;
+
+		ret = soc_init_dai_link(card, dai_link);
+		if (ret)
+			goto probe_dai_err;
+		ret = soc_bind_dai_link(card, dai_link);
+		if (ret)
+			goto probe_dai_err;
+	}
+
+
+	/* probe DAI links on this card */
+	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
+	     order++) {
+		ret = soc_probe_link_dais(card, rtd, order);
+		if (ret < 0) {
+			dev_err(card->dev, "ASoC: failed to probe %s dai link,%d\n",
+				dai_link->name, ret);
+			goto probe_dai_err;
+		}
+	}
+
+	dapm = &rtd->codec->component.dapm;
+	snd_soc_dapm_new_widgets(card);
+	snd_soc_dapm_link_dai_widgets_component(card, dapm);
+	snd_soc_dapm_connect_dai_link_widgets(card, rtd);
+	snd_device_register(rtd->card->snd_card, rtd->pcm);
+	snd_soc_dapm_sync(&card->dapm);
+	mutex_unlock(&card->mutex);
+
+	return 0;
+
+probe_dai_err:
+	soc_remove_dai_link(card, rtd);
+base_error:
+	list_del(&rtd->list);
+	card->num_rtd--;
+	soc_free_pcm_runtime(rtd);
+init_error:
+	mutex_unlock(&card->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_add_dailink);
+
+/**
+ * snd_soc_remove_dailink - Remove DAI link from the active sound card
+ *
+ * @card_name: Sound card identifier to remove DAI link from
+ * @link_name: DAI link identfier to remove
+ */
+void snd_soc_remove_dailink(struct snd_soc_card *card, const char *link_name)
+{
+	int ret;
+	struct snd_soc_dai_link *dai_link;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_card *sndcard = card->snd_card;
+
+	if (!card)
+		return;
+
+	rtd = snd_soc_get_pcm_runtime(card, link_name);
+	if (!rtd) {
+		dev_err(card->dev, "DAI link not found\n");
+		return;
+	}
+
+	dai_link = rtd->dai_link;
+
+	/* check if link is active */
+	if (rtd->codec_dai->active) {
+		mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
+		if (rtd->codec_dai->playback_active)
+			dpcm_dapm_stream_event(rtd, SNDRV_PCM_STREAM_PLAYBACK,
+					       SND_SOC_DAPM_STREAM_STOP);
+		if (rtd->codec_dai->capture_active)
+			dpcm_dapm_stream_event(rtd, SNDRV_PCM_STREAM_CAPTURE,
+					       SND_SOC_DAPM_STREAM_STOP);
+		mutex_unlock(&rtd->pcm_mutex);
+		ret = soc_dpcm_runtime_update(rtd->card);
+	}
+	cancel_delayed_work_sync(&rtd->delayed_work);
+
+	down_write(&sndcard->controls_rwsem);
+	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_RUNTIME);
+	/* in case of BE DAI, update fe_clients list */
+	if (dai_link->no_pcm) {
+		dpcm_fe_disconnect(rtd, SNDRV_PCM_STREAM_PLAYBACK);
+		dpcm_fe_disconnect(rtd, SNDRV_PCM_STREAM_CAPTURE);
+	}
+
+	/* free associated PCM device */
+	snd_device_free(rtd->card->snd_card, rtd->pcm);
+	soc_remove_dai_link(card, rtd);
+	list_del(&rtd->list);
+	card->num_rtd--;
+	soc_free_pcm_runtime(rtd);
+
+	mutex_unlock(&card->mutex);
+	up_write(&sndcard->controls_rwsem);
+}
+EXPORT_SYMBOL_GPL(snd_soc_remove_dailink);
+
 static void soc_set_name_prefix(struct snd_soc_card *card,
 				struct snd_soc_component *component)
 {
@@ -1439,6 +1684,11 @@ static int soc_probe_component(struct snd_soc_card *card,
 		snd_soc_dapm_add_routes(dapm, component->dapm_routes,
 					component->num_dapm_routes);
 
+	if (card->instantiated) {
+		component->dynamic_registered = 1;
+		dapm->dynamic_registered = 1;
+	}
+
 	list_add(&dapm->list, &card->dapm_list);
 
 	/* This is a HACK and will be removed soon */
@@ -1968,7 +2218,17 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	}
 
 	snd_soc_dapm_link_dai_widgets(card);
-	snd_soc_dapm_connect_dai_link_widgets(card);
+	/* for each BE DAI link... */
+	list_for_each_entry(rtd, &card->rtd_list, list)  {
+		/*
+		 * dynamic FE links have no fixed DAI mapping.
+		 * CODEC<->CODEC links have no direct connection.
+		 */
+		if (rtd->dai_link->dynamic || rtd->dai_link->params)
+			continue;
+
+		snd_soc_dapm_connect_dai_link_widgets(card, rtd);
+	}
 
 	if (card->controls)
 		snd_soc_add_card_controls(card, card->controls, card->num_controls);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 0d37079..dedc0ba 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2272,6 +2272,34 @@ static void dapm_free_path(struct snd_soc_dapm_path *path)
 	kfree(path);
 }
 
+static void snd_soc_dapm_remove_kcontrols(struct snd_soc_dapm_widget *w)
+{
+	int i, ret;
+	struct snd_kcontrol *kctl;
+	struct snd_soc_dapm_context *dapm = w->dapm;
+	struct snd_card *card = dapm->card->snd_card;
+
+	if (!w->num_kcontrols)
+		return;
+
+	for (i = 0; i < w->num_kcontrols; i++) {
+		kctl = w->kcontrols[i];
+		if (!kctl) {
+			dev_err(dapm->dev, "%s: Failed to find %d kcontrol\n",
+				w->name, i);
+			continue;
+		}
+		dev_dbg(dapm->dev, "Remove %d: %s\n", kctl->id.numid,
+			kctl->id.name);
+		ret = snd_ctl_remove_id_locked(card, &kctl->id);
+		if (ret < 0) {
+			dev_err(dapm->dev, "Err %d: while remove %s:%s\n", ret,
+				w->name, kctl->id.name);
+		}
+	}
+	w->num_kcontrols = 0;
+}
+
 void snd_soc_dapm_free_widget(struct snd_soc_dapm_widget *w)
 {
 	struct snd_soc_dapm_path *p, *next_p;
@@ -2288,6 +2316,12 @@ void snd_soc_dapm_free_widget(struct snd_soc_dapm_widget *w)
 			dapm_free_path(p);
 	}
 
+	/*
+	 * remove associated kcontrols,
+	 * in case added dynamically
+	 */
+	if (w->dapm->dynamic_registered && w->num_kcontrols)
+		snd_soc_dapm_remove_kcontrols(w);
 	kfree(w->kcontrols);
 	kfree_const(w->name);
 	kfree(w);
@@ -3778,6 +3812,58 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 	return 0;
 }
 
+int snd_soc_dapm_link_dai_widgets_component(struct snd_soc_card *card,
+					    struct snd_soc_dapm_context *dapm)
+{
+	struct snd_soc_dapm_widget *dai_w, *w;
+	struct snd_soc_dapm_widget *src, *sink;
+	struct snd_soc_dai *dai;
+
+	/* For each DAI widget... */
+	list_for_each_entry(dai_w, &card->widgets, list) {
+		if (dai_w->dapm != dapm)
+			continue;
+		switch (dai_w->id) {
+		case snd_soc_dapm_dai_in:
+		case snd_soc_dapm_dai_out:
+			break;
+		default:
+			continue;
+		}
+
+		dai = dai_w->priv;
+
+		/* ...find all widgets with the same stream and link them */
+		list_for_each_entry(w, &card->widgets, list) {
+			if (w->dapm != dai_w->dapm)
+				continue;
+
+			switch (w->id) {
+			case snd_soc_dapm_dai_in:
+			case snd_soc_dapm_dai_out:
+				continue;
+			default:
+				break;
+			}
+
+			if (!w->sname || !strstr(w->sname, dai_w->sname))
+				continue;
+
+			if (dai_w->id == snd_soc_dapm_dai_in) {
+				src = dai_w;
+				sink = w;
+			} else {
+				src = w;
+				sink = dai_w;
+			}
+			dev_dbg(dai->dev, "%s -> %s\n", src->name, sink->name);
+			snd_soc_dapm_add_path(w->dapm, src, sink, NULL, NULL);
+		}
+	}
+
+	return 0;
+}
+
 int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 {
 	struct snd_soc_dapm_widget *dai_w, *w;
@@ -3827,7 +3913,7 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 	return 0;
 }
 
-static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
+void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 					  struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
@@ -3903,23 +3989,6 @@ static void soc_dapm_dai_stream_event(struct snd_soc_dai *dai, int stream,
 	}
 }
 
-void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
-{
-	struct snd_soc_pcm_runtime *rtd;
-
-	/* for each BE DAI link... */
-	list_for_each_entry(rtd, &card->rtd_list, list)  {
-		/*
-		 * dynamic FE links have no fixed DAI mapping.
-		 * CODEC<->CODEC links have no direct connection.
-		 */
-		if (rtd->dai_link->dynamic || rtd->dai_link->params)
-			continue;
-
-		dapm_connect_dai_link_widgets(card, rtd);
-	}
-}
-
 static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
 	int event)
 {
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index aa99dac..903cfd5 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1192,6 +1192,31 @@ static void dpcm_be_reparent(struct snd_soc_pcm_runtime *fe,
 }
 
 /* disconnect a BE and FE */
+void dpcm_fe_disconnect(struct snd_soc_pcm_runtime *be, int stream)
+{
+	struct snd_soc_dpcm *dpcm, *d;
+
+	list_for_each_entry_safe(dpcm, d, &be->dpcm[stream].fe_clients,
+				 list_fe) {
+		dev_dbg(be->dev, "ASoC: BE %s disconnect check for %s\n",
+				stream ? "capture" : "playback",
+				dpcm->fe->dai_link->name);
+
+		dev_dbg(be->dev, "  freed DSP %s path %s %s %s\n",
+			stream ? "capture" : "playback", be->dai_link->name,
+			stream ? "<-" : "->", dpcm->fe->dai_link->name);
+
+#ifdef CONFIG_DEBUG_FS
+		debugfs_remove(dpcm->debugfs_state);
+#endif
+		/* FE still alive, update it's BE client list */
+		list_del(&dpcm->list_be);
+		list_del(&dpcm->list_fe);
+		kfree(dpcm);
+	}
+}
+
+/* disconnect a BE and FE */
 void dpcm_be_disconnect(struct snd_soc_pcm_runtime *fe, int stream)
 {
 	struct snd_soc_dpcm *dpcm, *d;
-- 
2.1.4
