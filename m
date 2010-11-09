From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/2] ASoC: Update DAPM debug and error prints
Date: Tue,  9 Nov 2010 14:40:27 +0200
Message-ID: <1289306428-1067-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 45ED610384A
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2010 13:40:02 +0100 (CET)
Received: by ewy26 with SMTP id 26so681797ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 09 Nov 2010 04:40:02 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Switch printk and pr_ prints to dev_ variants. It is helpful to see
parent device of DAPM context especially when there are multiple DAPM
contexts (codecs currently).

This is mostly simple conversion. Exceptions are in snd_soc_dapm_set_pin
that prints also pin state, uniform "dapm: unknown pin" error prints from
snd_soc_dapm_set_pin, snd_soc_dapm_force_enable_pin and
snd_soc_dapm_ignore_suspend, and pop_dbg which is converted by an another
patch.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/soc-dapm.c |  100 +++++++++++++++++++++++++++----------------------
 1 files changed, 55 insertions(+), 45 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 960790c..e8997bb 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -319,8 +319,8 @@ static int dapm_update_bits(struct snd_soc_dapm_widget *widget)
 		pop_wait(card->pop_time);
 		snd_soc_write(codec, widget->reg, new);
 	}
-	pr_debug("reg %x old %x new %x change %d\n", widget->reg,
-		 old, new, change);
+	dev_dbg(dapm->dev, "reg %x old %x new %x change %d\n", widget->reg,
+		old, new, change);
 	return change;
 }
 
@@ -375,9 +375,9 @@ static int dapm_new_mixer(struct snd_soc_dapm_context *dapm,
 				path->long_name);
 			ret = snd_ctl_add(card, path->kcontrol);
 			if (ret < 0) {
-				printk(KERN_ERR "asoc: failed to add dapm kcontrol %s: %d\n",
-				       path->long_name,
-				       ret);
+				dev_err(dapm->dev,
+					"asoc: failed to add dapm kcontrol %s: %d\n",
+					path->long_name, ret);
 				kfree(path->long_name);
 				path->long_name = NULL;
 				return ret;
@@ -397,7 +397,7 @@ static int dapm_new_mux(struct snd_soc_dapm_context *dapm,
 	int ret = 0;
 
 	if (!w->num_kcontrols) {
-		printk(KERN_ERR "asoc: mux %s has no controls\n", w->name);
+		dev_err(dapm->dev, "asoc: mux %s has no controls\n", w->name);
 		return -EINVAL;
 	}
 
@@ -413,7 +413,7 @@ static int dapm_new_mux(struct snd_soc_dapm_context *dapm,
 	return ret;
 
 err:
-	printk(KERN_ERR "asoc: failed to add kcontrol %s\n", w->name);
+	dev_err(dapm->dev, "asoc: failed to add kcontrol %s\n", w->name);
 	return ret;
 }
 
@@ -422,7 +422,8 @@ static int dapm_new_pga(struct snd_soc_dapm_context *dapm,
 	struct snd_soc_dapm_widget *w)
 {
 	if (w->num_kcontrols)
-		pr_err("asoc: PGA controls not supported: '%s'\n", w->name);
+		dev_err(w->dapm->dev,
+			"asoc: PGA controls not supported: '%s'\n", w->name);
 
 	return 0;
 }
@@ -448,7 +449,8 @@ static int snd_soc_dapm_suspend_check(struct snd_soc_dapm_widget *widget)
 	case SNDRV_CTL_POWER_D3hot:
 	case SNDRV_CTL_POWER_D3cold:
 		if (widget->ignore_suspend)
-			pr_debug("%s ignoring suspend\n", widget->name);
+			dev_dbg(widget->dapm->dev, "%s ignoring suspend\n",
+				widget->name);
 		return widget->ignore_suspend;
 	default:
 		return 1;
@@ -579,7 +581,7 @@ static int dapm_generic_apply_power(struct snd_soc_dapm_widget *w)
 
 	/* call any power change event handlers */
 	if (w->event)
-		pr_debug("power %s event for %s flags %x\n",
+		dev_dbg(w->dapm->dev, "power %s event for %s flags %x\n",
 			 w->power ? "on" : "off",
 			 w->name, w->event_flags);
 
@@ -754,8 +756,9 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 				w->name);
 			ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMU);
 			if (ret < 0)
-				pr_err("%s: pre event failed: %d\n",
-				       w->name, ret);
+				dev_err(dapm->dev,
+					"%s: pre event failed: %d\n",
+					w->name, ret);
 		}
 
 		/* power down pre event */
@@ -765,8 +768,9 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 				w->name);
 			ret = w->event(w, NULL, SND_SOC_DAPM_PRE_PMD);
 			if (ret < 0)
-				pr_err("%s: pre event failed: %d\n",
-				       w->name, ret);
+				dev_err(dapm->dev,
+					"%s: pre event failed: %d\n",
+					w->name, ret);
 		}
 	}
 
@@ -787,8 +791,9 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 			ret = w->event(w,
 				       NULL, SND_SOC_DAPM_POST_PMU);
 			if (ret < 0)
-				pr_err("%s: post event failed: %d\n",
-				       w->name, ret);
+				dev_err(dapm->dev,
+					"%s: post event failed: %d\n",
+					w->name, ret);
 		}
 
 		/* power down post event */
@@ -798,8 +803,9 @@ static void dapm_seq_run_coalesced(struct snd_soc_dapm_context *dapm,
 				w->name);
 			ret = w->event(w, NULL, SND_SOC_DAPM_POST_PMD);
 			if (ret < 0)
-				pr_err("%s: post event failed: %d\n",
-				       w->name, ret);
+				dev_err(dapm->dev,
+					"%s: post event failed: %d\n",
+					w->name, ret);
 		}
 	}
 }
@@ -880,8 +886,8 @@ static void dapm_seq_run(struct snd_soc_dapm_context *dapm,
 		}
 
 		if (ret < 0)
-			pr_err("Failed to apply widget power: %d\n",
-			       ret);
+			dev_err(w->dapm->dev,
+				"Failed to apply widget power: %d\n", ret);
 	}
 
 	if (!list_empty(&pending))
@@ -975,7 +981,8 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 		ret = snd_soc_dapm_set_bias_level(card, dapm,
 						  SND_SOC_BIAS_STANDBY);
 		if (ret != 0)
-			pr_err("Failed to turn on bias: %d\n", ret);
+			dev_err(dapm->dev,
+				"Failed to turn on bias: %d\n", ret);
 	}
 
 	/* If we're changing to all on or all off then prepare */
@@ -983,7 +990,8 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	    (!sys_power && dapm->bias_level == SND_SOC_BIAS_ON)) {
 		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_PREPARE);
 		if (ret != 0)
-			pr_err("Failed to prepare bias: %d\n", ret);
+			dev_err(dapm->dev,
+				"Failed to prepare bias: %d\n", ret);
 	}
 
 	/* Power down widgets first; try to avoid amplifying pops. */
@@ -996,7 +1004,8 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	if (dapm->bias_level == SND_SOC_BIAS_PREPARE && !sys_power) {
 		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_STANDBY);
 		if (ret != 0)
-			pr_err("Failed to apply standby bias: %d\n", ret);
+			dev_err(dapm->dev,
+				"Failed to apply standby bias: %d\n", ret);
 	}
 
 	/* If we're in standby and can support bias off then do that */
@@ -1004,14 +1013,16 @@ static int dapm_power_widgets(struct snd_soc_dapm_context *dapm, int event)
 	    dapm->idle_bias_off) {
 		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_OFF);
 		if (ret != 0)
-			pr_err("Failed to turn off bias: %d\n", ret);
+			dev_err(dapm->dev,
+				"Failed to turn off bias: %d\n", ret);
 	}
 
 	/* If we just powered up then move to active bias */
 	if (dapm->bias_level == SND_SOC_BIAS_PREPARE && sys_power) {
 		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_ON);
 		if (ret != 0)
-			pr_err("Failed to apply active bias: %d\n", ret);
+			dev_err(dapm->dev,
+				"Failed to apply active bias: %d\n", ret);
 	}
 
 	pop_dbg(card->pop_time, "DAPM sequencing finished, waiting %dms\n",
@@ -1111,9 +1122,9 @@ void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm)
 					dapm->debugfs_dapm, w,
 					&dapm_widget_power_fops);
 		if (!d)
-			printk(KERN_WARNING
-			       "ASoC: Failed to create %s debugfs file\n",
-			       w->name);
+			dev_warn(w->dapm->dev,
+				"ASoC: Failed to create %s debugfs file\n",
+				w->name);
 	}
 }
 #else
@@ -1279,7 +1290,8 @@ static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
 
 	list_for_each_entry(w, &dapm->widgets, list) {
 		if (!strcmp(w->name, pin)) {
-			pr_debug("dapm: %s: pin %s\n", dapm->codec->name, pin);
+			dev_dbg(w->dapm->dev, "dapm: pin %s = %d\n",
+				pin, status);
 			w->connected = status;
 			/* Allow disabling of forced pins */
 			if (status == 0)
@@ -1288,8 +1300,7 @@ static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
 		}
 	}
 
-	pr_err("dapm: %s: configuring unknown pin %s\n",
-	       dapm->codec->name, pin);
+	dev_err(dapm->dev, "dapm: unknown pin %s\n", pin);
 	return -EINVAL;
 }
 
@@ -1415,8 +1426,8 @@ static int snd_soc_dapm_add_route(struct snd_soc_dapm_context *dapm,
 	return 0;
 
 err:
-	printk(KERN_WARNING "asoc: no dapm match for %s --> %s --> %s\n", source,
-		control, sink);
+	dev_warn(dapm->dev, "asoc: no dapm match for %s --> %s --> %s\n",
+		 source, control, sink);
 	kfree(path);
 	return ret;
 }
@@ -1442,9 +1453,8 @@ int snd_soc_dapm_add_routes(struct snd_soc_dapm_context *dapm,
 	for (i = 0; i < num; i++) {
 		ret = snd_soc_dapm_add_route(dapm, route);
 		if (ret < 0) {
-			printk(KERN_ERR "Failed to add route %s->%s\n",
-			       route->source,
-			       route->sink);
+			dev_err(dapm->dev, "Failed to add route %s->%s\n",
+				route->source, route->sink);
 			return ret;
 		}
 		route++;
@@ -1982,9 +1992,9 @@ int snd_soc_dapm_new_controls(struct snd_soc_dapm_context *dapm,
 	for (i = 0; i < num; i++) {
 		ret = snd_soc_dapm_new_control(dapm, widget);
 		if (ret < 0) {
-			printk(KERN_ERR
-			       "ASoC: Failed to create DAPM control %s: %d\n",
-			       widget->name, ret);
+			dev_err(dapm->dev,
+				"ASoC: Failed to create DAPM control %s: %d\n",
+				widget->name, ret);
 			return ret;
 		}
 		widget++;
@@ -2002,8 +2012,8 @@ static void soc_dapm_stream_event(struct snd_soc_dapm_context *dapm,
 	{
 		if (!w->sname)
 			continue;
-		pr_debug("widget %s\n %s stream %s event %d\n",
-			 w->name, w->sname, stream, event);
+		dev_dbg(w->dapm->dev, "widget %s\n %s stream %s event %d\n",
+			w->name, w->sname, stream, event);
 		if (strstr(w->sname, stream)) {
 			switch(event) {
 			case SND_SOC_DAPM_STREAM_START:
@@ -2085,15 +2095,15 @@ int snd_soc_dapm_force_enable_pin(struct snd_soc_dapm_context *dapm,
 
 	list_for_each_entry(w, &dapm->widgets, list) {
 		if (!strcmp(w->name, pin)) {
-			pr_debug("dapm: %s: pin %s\n", dapm->codec->name, pin);
+			dev_dbg(w->dapm->dev,
+				"dapm: force enable pin %s\n", pin);
 			w->connected = 1;
 			w->force = 1;
 			return 0;
 		}
 	}
 
-	pr_err("dapm: %s: configuring unknown pin %s\n",
-	       dapm->codec->name, pin);
+	dev_err(dapm->dev, "dapm: unknown pin %s\n", pin);
 	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_force_enable_pin);
@@ -2180,7 +2190,7 @@ int snd_soc_dapm_ignore_suspend(struct snd_soc_dapm_context *dapm,
 		}
 	}
 
-	pr_err("Unknown DAPM pin: %s\n", pin);
+	dev_err(dapm->dev, "dapm: unknown pin %s\n", pin);
 	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_ignore_suspend);
-- 
1.7.2.3
