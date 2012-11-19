From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH 1/4] ASoC: dapm: Standardise ASoC DAPM messages
Date: Mon, 19 Nov 2012 14:39:12 +0000
Message-ID: <1353335955-5249-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 914282650FD
 for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2012 15:39:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Currently ASoC has a mixture of message prefixes e.g. "ASoC", "asoc"
or none and message types e.g. pr_debug or dev_dbg.

Make sure all ASoC core messages use the same "ASoC" prefix and
convert any component device specific messages to use dev_dbg
instead of pr_debug.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-dapm.c |  134 ++++++++++++++++++++++++++++----------------------
 1 file changed, 74 insertions(+), 60 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6e35bca..1e36bc8 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -220,7 +220,7 @@ static int soc_widget_read(struct snd_soc_dapm_widget *w, int reg)
 	else if (w->platform)
 		return snd_soc_platform_read(w->platform, reg);
 
-	dev_err(w->dapm->dev, "no valid widget read method\n");
+	dev_err(w->dapm->dev, "ASoC: no valid widget read method\n");
 	return -1;
 }
 
@@ -231,7 +231,7 @@ static int soc_widget_write(struct snd_soc_dapm_widget *w, int reg, int val)
 	else if (w->platform)
 		return snd_soc_platform_write(w->platform, reg, val);
 
-	dev_err(w->dapm->dev, "no valid widget write method\n");
+	dev_err(w->dapm->dev, "ASoC: no valid widget write method\n");
 	return -1;
 }
 
@@ -546,7 +546,7 @@ static int dapm_new_mixer(struct snd_soc_dapm_widget *w)
 			wlist = kzalloc(wlistsize, GFP_KERNEL);
 			if (wlist == NULL) {
 				dev_err(dapm->dev,
-					"asoc: can't allocate widget list for %s\n",
+					"ASoC: can't allocate widget list for %s\n",
 					w->name);
 				return -ENOMEM;
 			}
@@ -595,9 +595,9 @@ static int dapm_new_mixer(struct snd_soc_dapm_widget *w)
 						      prefix);
 			ret = snd_ctl_add(card, path->kcontrol);
 			if (ret < 0) {
-				dev_err(dapm->dev,
-					"asoc: failed to add dapm kcontrol %s: %d\n",
-					path->long_name, ret);
+				dev_err(dapm->dev, "ASoC: failed to add widget"
+					" %s dapm kcontrol %s: %d\n",
+					w->name, path->long_name, ret);
 				kfree(wlist);
 				kfree(path->long_name);
 				path->long_name = NULL;
@@ -626,7 +626,7 @@ static int dapm_new_mux(struct snd_soc_dapm_widget *w)
 
 	if (w->num_kcontrols != 1) {
 		dev_err(dapm->dev,
-			"asoc: mux %s has incorrect number of controls\n",
+			"ASoC: mux %s has incorrect number of controls\n",
 			w->name);
 		return -EINVAL;
 	}
@@ -645,7 +645,7 @@ static int dapm_new_mux(struct snd_soc_dapm_widget *w)
 	wlist = krealloc(wlist, wlistsize, GFP_KERNEL);
 	if (wlist == NULL) {
 		dev_err(dapm->dev,
-			"asoc: can't allocate widget list for %s\n", w->name);
+			"ASoC: can't allocate widget list for %s\n", w->name);
 		return -ENOMEM;
 	}
 	wlist->num_widgets = wlistentries;
@@ -677,7 +677,7 @@ static int dapm_new_mux(struct snd_soc_dapm_widget *w)
 					name + prefix_len, prefix);
 		ret = snd_ctl_add(card, kcontrol);
 		if (ret < 0) {
-			dev_err(dapm->dev, "failed to add kcontrol %s: %d\n",
+			dev_err(dapm->dev, "ASoC: failed to add kcontrol %s: %d\n",
 				w->name, ret);
 			kfree(wlist);
 			return ret;
@@ -699,7 +699,7 @@ static int dapm_new_pga(struct snd_soc_dapm_widget *w)
 {
 	if (w->num_kcontrols)
 		dev_err(w->dapm->dev,
-			"asoc: PGA controls not supported: '%s'\n", w->name);
+			"ASoC: PGA controls not supported: '%s'\n", w->name);
 
 	return 0;
 }
@@ -725,7 +725,7 @@ static int snd_soc_dapm_suspend_check(struct snd_soc_dapm_widget *widget)
 	case SNDRV_CTL_POWER_D3hot:
 	case SNDRV_CTL_POWER_D3cold:
 		if (widget->ignore_suspend)
-			dev_dbg(widget->dapm->dev, "%s ignoring suspend\n",
+			dev_dbg(widget->dapm->dev, "ASoC: %s ignoring suspend\n",
 				widget->name);
 		return widget->ignore_suspend;
 	default:
@@ -757,14 +757,14 @@ static int dapm_list_add_widget(struct snd_soc_dapm_widget_list **list,
 			wlistentries * sizeof(struct snd_soc_dapm_widget *);
 	*list = krealloc(wlist, wlistsize, GFP_KERNEL);
 	if (*list == NULL) {
-		dev_err(w->dapm->dev, "can't allocate widget list for %s\n",
+		dev_err(w->dapm->dev, "ASoC: can't allocate widget list for %s\n",
 			w->name);
 		return -ENOMEM;
 	}
 	wlist = *list;
 
 	/* insert the widget */
-	dev_dbg(w->dapm->dev, "added %s in widget list pos %d\n",
+	dev_dbg(w->dapm->dev, "ASoC: added %s in widget list pos %d\n",
 			w->name, wlist->num_widgets);
 
 	wlist->widgets[wlist->num_widgets] = w;
@@ -844,7 +844,8 @@ static int is_connected_output_ep(struct snd_soc_dapm_widget *widget,
 				int err;
 				err = dapm_list_add_widget(list, path->sink);
 				if (err < 0) {
-					dev_err(widget->dapm->dev, "could not add widget %s\n",
+					dev_err(widget->dapm->dev,
+						"ASoC: could not add widget %s\n",
 						widget->name);
 					return con;
 				}
@@ -943,7 +944,8 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
 				int err;
 				err = dapm_list_add_widget(list, path->source);
 				if (err < 0) {
-					dev_err(widget->dapm->dev, "could not add widget %s\n",
+					dev_err(widget->dapm->dev,
+						"ASoC: could not add widget %s\n",
 						widget->name);
 					return con;
 				}
@@ -1024,7 +1026,7 @@ int dapm_regulator_event(struct snd_soc_dapm_widget *w,
 			ret = regulator_allow_bypass(w->regulator, true);
 			if (ret != 0)
 				dev_warn(w->dapm->dev,
-					 "Failed to bypass %s: %d\n",
+					 "ASoC: Failed to bypass %s: %d\n",
 					 w->name, ret);
 		}
 
@@ -1034,7 +1036,7 @@ int dapm_regulator_event(struct snd_soc_dapm_widget *w,
 			ret = regulator_allow_bypass(w->regulator, false);
 			if (ret != 0)
 				dev_warn(w->dapm->dev,
-					 "Failed to unbypass %s: %d\n",
+					 "ASoC: Failed to unbypass %s: %d\n",
 					 w->name, ret);
 		}
 
@@ -1253,7 +1255,7 @@ static void dapm_seq_check_event(struct snd_soc_dapm_context *dapm,
 		ret = w->event(w, NULL, event);
 		trace_snd_soc_dapm_widget_event_done(w, event);
 		if (ret < 0)
-			pr_err("%s: %s event failed: %d\n",
+			dev_err(dapm->dev, "ASoC: %s: %s event failed: %d\n",
 			       ev_name, w->name, ret);
 	}
 }
@@ -1402,7 +1404,7 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
 
 		if (ret < 0)
 			dev_err(w->dapm->dev,
-				"Failed to apply widget power: %d\n", ret);
+				"ASoC: Failed to apply widget power: %d\n", ret);
 	}
 
 	if (!list_empty(&pending))
@@ -1431,20 +1433,21 @@ static void dapm_widget_update(struct snd_soc_dapm_context *dapm)
 	    (w->event_flags & SND_SOC_DAPM_PRE_REG)) {
 		ret = w->event(w, update->kcontrol, SND_SOC_DAPM_PRE_REG);
 		if (ret != 0)
-			pr_err("%s DAPM pre-event failed: %d\n",
+			dev_err(dapm->dev, "ASoC: %s DAPM pre-event failed: %d\n",
 			       w->name, ret);
 	}
 
 	ret = soc_widget_update_bits_locked(w, update->reg, update->mask,
 				  update->val);
 	if (ret < 0)
-		pr_err("%s DAPM update failed: %d\n", w->name, ret);
+		dev_err(dapm->dev, "ASoC: %s DAPM update failed: %d\n",
+			w->name, ret);
 
 	if (w->event &&
 	    (w->event_flags & SND_SOC_DAPM_POST_REG)) {
 		ret = w->event(w, update->kcontrol, SND_SOC_DAPM_POST_REG);
 		if (ret != 0)
-			pr_err("%s DAPM post-event failed: %d\n",
+			dev_err(dapm->dev, "ASoC: %s DAPM post-event failed: %d\n",
 			       w->name, ret);
 	}
 }
@@ -1466,7 +1469,7 @@ static void dapm_pre_sequence_async(void *data, async_cookie_t cookie)
 		ret = snd_soc_dapm_set_bias_level(d, SND_SOC_BIAS_STANDBY);
 		if (ret != 0)
 			dev_err(d->dev,
-				"Failed to turn on bias: %d\n", ret);
+				"ASoC: Failed to turn on bias: %d\n", ret);
 	}
 
 	/* Prepare for a STADDBY->ON or ON->STANDBY transition */
@@ -1474,7 +1477,7 @@ static void dapm_pre_sequence_async(void *data, async_cookie_t cookie)
 		ret = snd_soc_dapm_set_bias_level(d, SND_SOC_BIAS_PREPARE);
 		if (ret != 0)
 			dev_err(d->dev,
-				"Failed to prepare bias: %d\n", ret);
+				"ASoC: Failed to prepare bias: %d\n", ret);
 	}
 }
 
@@ -1492,7 +1495,7 @@ static void dapm_post_sequence_async(void *data, async_cookie_t cookie)
 	     d->target_bias_level == SND_SOC_BIAS_OFF)) {
 		ret = snd_soc_dapm_set_bias_level(d, SND_SOC_BIAS_STANDBY);
 		if (ret != 0)
-			dev_err(d->dev, "Failed to apply standby bias: %d\n",
+			dev_err(d->dev, "ASoC: Failed to apply standby bias: %d\n",
 				ret);
 	}
 
@@ -1501,7 +1504,8 @@ static void dapm_post_sequence_async(void *data, async_cookie_t cookie)
 	    d->target_bias_level == SND_SOC_BIAS_OFF) {
 		ret = snd_soc_dapm_set_bias_level(d, SND_SOC_BIAS_OFF);
 		if (ret != 0)
-			dev_err(d->dev, "Failed to turn off bias: %d\n", ret);
+			dev_err(d->dev, "ASoC: Failed to turn off bias: %d\n",
+				ret);
 
 		if (d->dev)
 			pm_runtime_put(d->dev);
@@ -1512,7 +1516,7 @@ static void dapm_post_sequence_async(void *data, async_cookie_t cookie)
 	    d->target_bias_level == SND_SOC_BIAS_ON) {
 		ret = snd_soc_dapm_set_bias_level(d, SND_SOC_BIAS_ON);
 		if (ret != 0)
-			dev_err(d->dev, "Failed to apply active bias: %d\n",
+			dev_err(d->dev, "ASoC: Failed to apply active bias: %d\n",
 				ret);
 	}
 }
@@ -1838,7 +1842,7 @@ void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
 
 	if (!dapm->debugfs_dapm) {
 		dev_warn(dapm->dev,
-		       "Failed to create DAPM debugfs directory\n");
+		       "ASoC: Failed to create DAPM debugfs directory\n");
 		return;
 	}
 
@@ -2123,7 +2127,7 @@ static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *w = dapm_find_widget(dapm, pin, true);
 
 	if (!w) {
-		dev_err(dapm->dev, "dapm: unknown pin %s\n", pin);
+		dev_err(dapm->dev, "ASoC: DAPM unknown pin %s\n", pin);
 		return -EINVAL;
 	}
 
@@ -2212,8 +2216,16 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	if (!wsource)
 		wsource = wtsource;
 
-	if (wsource == NULL || wsink == NULL)
+	if (wsource == NULL) {
+		dev_err(dapm->dev, "ASoC: no source widget found for %s\n",
+			route->source);
 		return -ENODEV;
+	}
+	if (wsink == NULL) {
+		dev_err(dapm->dev, "ASoC: no sink widget found for %s\n",
+			route->sink);
+		return -ENODEV;
+	}
 
 	path = kzalloc(sizeof(struct snd_soc_dapm_path), GFP_KERNEL);
 	if (!path)
@@ -2308,7 +2320,7 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	return 0;
 
 err:
-	dev_warn(dapm->dev, "asoc: no dapm match for %s --> %s --> %s\n",
+	dev_warn(dapm->dev, "ASoC: no dapm match for %s --> %s --> %s\n",
 		 source, control, sink);
 	kfree(path);
 	return ret;
@@ -2325,7 +2337,7 @@ static int snd_soc_dapm_del_route(struct snd_soc_dapm_context *dapm,
 
 	if (route->control) {
 		dev_err(dapm->dev,
-			"Removal of routes with controls not supported\n");
+			"ASoC: Removal of routes with controls not supported\n");
 		return -EINVAL;
 	}
 
@@ -2360,7 +2372,7 @@ static int snd_soc_dapm_del_route(struct snd_soc_dapm_context *dapm,
 		list_del(&path->list_source);
 		kfree(path);
 	} else {
-		dev_warn(dapm->dev, "Route %s->%s does not exist\n",
+		dev_warn(dapm->dev, "ASoC: Route %s->%s does not exist\n",
 			 source, sink);
 	}
 
@@ -2389,8 +2401,10 @@ int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 	for (i = 0; i < num; i++) {
 		r = snd_soc_dapm_add_route(dapm, route);
 		if (r < 0) {
-			dev_err(dapm->dev, "Failed to add route %s->%s\n",
-				route->source, route->sink);
+			dev_err(dapm->dev, "ASoC: Failed to add route %s -> %s -> %s\n",
+				route->source,
+				route->control ? route->control : "direct",
+				route->sink);
 			ret = r;
 		}
 		route++;
@@ -2438,19 +2452,19 @@ static int snd_soc_dapm_weak_route(struct snd_soc_dapm_context *dapm,
 	int count = 0;
 
 	if (!source) {
-		dev_err(dapm->dev, "Unable to find source %s for weak route\n",
+		dev_err(dapm->dev, "ASoC: Unable to find source %s for weak route\n",
 			route->source);
 		return -ENODEV;
 	}
 
 	if (!sink) {
-		dev_err(dapm->dev, "Unable to find sink %s for weak route\n",
+		dev_err(dapm->dev, "ASoC: Unable to find sink %s for weak route\n",
 			route->sink);
 		return -ENODEV;
 	}
 
 	if (route->control || route->connected)
-		dev_warn(dapm->dev, "Ignoring control for weak route %s->%s\n",
+		dev_warn(dapm->dev, "ASoC: Ignoring control for weak route %s->%s\n",
 			 route->source, route->sink);
 
 	list_for_each_entry(path, &source->sinks, list_source) {
@@ -2461,10 +2475,10 @@ static int snd_soc_dapm_weak_route(struct snd_soc_dapm_context *dapm,
 	}
 
 	if (count == 0)
-		dev_err(dapm->dev, "No path found for weak route %s->%s\n",
+		dev_err(dapm->dev, "ASoC: No path found for weak route %s->%s\n",
 			route->source, route->sink);
 	if (count > 1)
-		dev_warn(dapm->dev, "%d paths found for weak route %s->%s\n",
+		dev_warn(dapm->dev, "ASoC: %d paths found for weak route %s->%s\n",
 			 count, route->source, route->sink);
 
 	return 0;
@@ -2601,7 +2615,7 @@ int snd_soc_dapm_get_volsw(struct snd_kcontrol *kcontrol,
 
 	if (snd_soc_volsw_is_stereo(mc))
 		dev_warn(widget->dapm->dev,
-			 "Control '%s' is stereo, which is not supported\n",
+			 "ASoC: Control '%s' is stereo, which is not supported\n",
 			 kcontrol->id.name);
 
 	ucontrol->value.integer.value[0] =
@@ -2644,7 +2658,7 @@ int snd_soc_dapm_put_volsw(struct snd_kcontrol *kcontrol,
 
 	if (snd_soc_volsw_is_stereo(mc))
 		dev_warn(widget->dapm->dev,
-			 "Control '%s' is stereo, which is not supported\n",
+			 "ASoC: Control '%s' is stereo, which is not supported\n",
 			 kcontrol->id.name);
 
 	val = (ucontrol->value.integer.value[0] & mask);
@@ -3021,7 +3035,7 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 		w->regulator = devm_regulator_get(dapm->dev, w->name);
 		if (IS_ERR(w->regulator)) {
 			ret = PTR_ERR(w->regulator);
-			dev_err(dapm->dev, "Failed to request %s: %d\n",
+			dev_err(dapm->dev, "ASoC: Failed to request %s: %d\n",
 				w->name, ret);
 			return NULL;
 		}
@@ -3031,7 +3045,7 @@ snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 		w->clk = devm_clk_get(dapm->dev, w->name);
 		if (IS_ERR(w->clk)) {
 			ret = PTR_ERR(w->clk);
-			dev_err(dapm->dev, "Failed to request %s: %d\n",
+			dev_err(dapm->dev, "ASoC: Failed to request %s: %d\n",
 				w->name, ret);
 			return NULL;
 		}
@@ -3182,7 +3196,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 	if (config->formats) {
 		fmt = ffs(config->formats) - 1;
 	} else {
-		dev_warn(w->dapm->dev, "Invalid format %llx specified\n",
+		dev_warn(w->dapm->dev, "ASoC: Invalid format %llx specified\n",
 			 config->formats);
 		fmt = 0;
 	}
@@ -3215,7 +3229,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 							     params, source);
 			if (ret != 0) {
 				dev_err(source->dev,
-					"hw_params() failed: %d\n", ret);
+					"ASoC: hw_params() failed: %d\n", ret);
 				goto out;
 			}
 		}
@@ -3226,7 +3240,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 							   sink);
 			if (ret != 0) {
 				dev_err(sink->dev,
-					"hw_params() failed: %d\n", ret);
+					"ASoC: hw_params() failed: %d\n", ret);
 				goto out;
 			}
 		}
@@ -3235,14 +3249,14 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_POST_PMU:
 		ret = snd_soc_dai_digital_mute(sink, 0);
 		if (ret != 0 && ret != -ENOTSUPP)
-			dev_warn(sink->dev, "Failed to unmute: %d\n", ret);
+			dev_warn(sink->dev, "ASoC: Failed to unmute: %d\n", ret);
 		ret = 0;
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
 		ret = snd_soc_dai_digital_mute(sink, 1);
 		if (ret != 0 && ret != -ENOTSUPP)
-			dev_warn(sink->dev, "Failed to mute: %d\n", ret);
+			dev_warn(sink->dev, "ASoC: Failed to mute: %d\n", ret);
 		ret = 0;
 		break;
 
@@ -3281,11 +3295,11 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
 	template.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
 		SND_SOC_DAPM_PRE_PMD;
 
-	dev_dbg(card->dev, "adding %s widget\n", link_name);
+	dev_dbg(card->dev, "ASoC: adding %s widget\n", link_name);
 
 	w = snd_soc_dapm_new_control(&card->dapm, &template);
 	if (!w) {
-		dev_err(card->dev, "Failed to create %s widget\n",
+		dev_err(card->dev, "ASoC: Failed to create %s widget\n",
 			link_name);
 		return -ENOMEM;
 	}
@@ -3319,12 +3333,12 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 		template.name = dai->driver->playback.stream_name;
 		template.sname = dai->driver->playback.stream_name;
 
-		dev_dbg(dai->dev, "adding %s widget\n",
+		dev_dbg(dai->dev, "ASoC: adding %s widget\n",
 			template.name);
 
 		w = snd_soc_dapm_new_control(dapm, &template);
 		if (!w) {
-			dev_err(dapm->dev, "Failed to create %s widget\n",
+			dev_err(dapm->dev, "ASoC: Failed to create %s widget\n",
 				dai->driver->playback.stream_name);
 		}
 
@@ -3337,12 +3351,12 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm,
 		template.name = dai->driver->capture.stream_name;
 		template.sname = dai->driver->capture.stream_name;
 
-		dev_dbg(dai->dev, "adding %s widget\n",
+		dev_dbg(dai->dev, "ASoC: adding %s widget\n",
 			template.name);
 
 		w = snd_soc_dapm_new_control(dapm, &template);
 		if (!w) {
-			dev_err(dapm->dev, "Failed to create %s widget\n",
+			dev_err(dapm->dev, "ASoC: Failed to create %s widget\n",
 				dai->driver->capture.stream_name);
 		}
 
@@ -3518,11 +3532,11 @@ int snd_soc_dapm_force_enable_pin(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *w = dapm_find_widget(dapm, pin, true);
 
 	if (!w) {
-		dev_err(dapm->dev, "dapm: unknown pin %s\n", pin);
+		dev_err(dapm->dev, "ASoC: unknown pin %s\n", pin);
 		return -EINVAL;
 	}
 
-	dev_dbg(w->dapm->dev, "dapm: force enable pin %s\n", pin);
+	dev_dbg(w->dapm->dev, "ASoC: force enable pin %s\n", pin);
 	w->connected = 1;
 	w->force = 1;
 	dapm_mark_dirty(w, "force enable");
@@ -3605,7 +3619,7 @@ int snd_soc_dapm_ignore_suspend(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *w = dapm_find_widget(dapm, pin, false);
 
 	if (!w) {
-		dev_err(dapm->dev, "dapm: unknown pin %s\n", pin);
+		dev_err(dapm->dev, "ASoC: unknown pin %s\n", pin);
 		return -EINVAL;
 	}
 
@@ -3664,7 +3678,7 @@ void snd_soc_dapm_auto_nc_codec_pins(struct snd_soc_codec *codec)
 	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	struct snd_soc_dapm_widget *w;
 
-	dev_dbg(codec->dev, "Auto NC: DAPMs: card:%p codec:%p\n",
+	dev_dbg(codec->dev, "ASoC: Auto NC: DAPMs: card:%p codec:%p\n",
 		&card->dapm, &codec->dapm);
 
 	list_for_each_entry(w, &card->widgets, list) {
@@ -3674,7 +3688,7 @@ void snd_soc_dapm_auto_nc_codec_pins(struct snd_soc_codec *codec)
 		case snd_soc_dapm_input:
 		case snd_soc_dapm_output:
 		case snd_soc_dapm_micbias:
-			dev_dbg(codec->dev, "Auto NC: Checking widget %s\n",
+			dev_dbg(codec->dev, "ASoC: Auto NC: Checking widget %s\n",
 				w->name);
 			if (!snd_soc_dapm_widget_in_card_paths(card, w)) {
 				dev_dbg(codec->dev,
-- 
1.7.10.4
