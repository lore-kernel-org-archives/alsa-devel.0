From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/13] ASoC: Consolidate platform and CODEC
	probe/remove
Date: Tue, 19 Aug 2014 15:51:19 +0200
Message-ID: <1408456290-13945-3-git-send-email-lars@metafoo.de>
References: <1408456290-13945-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-165.synserver.de (smtp-out-165.synserver.de
 [212.40.185.165])
 by alsa0.perex.cz (Postfix) with ESMTP id 378FD26566A
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 15:51:41 +0200 (CEST)
In-Reply-To: <1408456290-13945-1-git-send-email-lars@metafoo.de>
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

The platform and CODEC probe and remove code is now largely identical. This
patch consolidates it at the component level.

The resulting code is slightly larger due to all the boiler plate code setting
up the indirection for the table based control and DAPM registration.  Once all
drivers have been update to no longer use the snd_soc_codec_driver and
snd_soc_platform_driver specific fields for this the indirection can be removed
again.

This patch contains two noteworthy hacks that are only meant to be temporary to
be able to update drivers and the core in separate incremental patches.

The first hack is related to that some DPCM platforms expect that the DAPM
widgets for the DAIs of a snd_soc_component are created in the DAPM context of
the snd_soc_platform that has the same parent device. For handling this the
steal_sibling_dai_widgets attribute is introduced. It gets set for
snd_soc_platforms that register DAPM elements. When creating the DAI widgets for
a component this flag is checked and if it is found on one of the siblings the
component will not create any DAI widgets in its own DAPM context. If the
attribute is set on a platform it will look for siblings components and create
DAI widgets for them in its own context. The fix for this will be to update
the offending drivers to only register a single component rather than two.

The second hack deals with the fact that the ASoC card suspend and resume code
still needs a list of CODECs that have been registered for the card. To handle
this the generic probe and remove path have a check to see if the component is
CODEC and if yes add/remove it to the card's CODEC list. While it is possible to
clean up the suspend/resume code to not need the CODEC list anymore this is a
bit of a chicken and egg problem since it will become easier to clean up the
suspend/resume code once there is a unified component layer.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h                   |  27 ++-
 sound/soc/soc-core.c                  | 335 ++++++++++++++++++----------------
 sound/soc/soc-generic-dmaengine-pcm.c |   4 +-
 3 files changed, 194 insertions(+), 172 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 4506de8..0e7e761 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -697,6 +697,10 @@ struct snd_soc_component_driver {
 	void (*seq_notifier)(struct snd_soc_component *, enum snd_soc_dapm_type,
 		int subseq);
 	int (*stream_event)(struct snd_soc_component *, int event);
+
+	/* probe ordering - for components with runtime dependencies */
+	int probe_order;
+	int remove_order;
 };
 
 struct snd_soc_component {
@@ -710,6 +714,7 @@ struct snd_soc_component {
 
 	unsigned int ignore_pmdown_time:1; /* pmdown_time is ignored at stop */
 	unsigned int registered_as_component:1;
+	unsigned int probed:1;
 
 	struct list_head list;
 
@@ -742,6 +747,18 @@ struct snd_soc_component {
 	struct snd_soc_dapm_context dapm;
 	struct snd_soc_dapm_context *dapm_ptr;
 
+	const struct snd_kcontrol_new *controls;
+	unsigned int num_controls;
+	const struct snd_soc_dapm_widget *dapm_widgets;
+	unsigned int num_dapm_widgets;
+	const struct snd_soc_dapm_route *dapm_routes;
+	unsigned int num_dapm_routes;
+	bool steal_sibling_dai_widgets;
+	struct snd_soc_codec *codec;
+
+	int (*probe)(struct snd_soc_component *);
+	void (*remove)(struct snd_soc_component *);
+
 #ifdef CONFIG_DEBUG_FS
 	void (*init_debugfs)(struct snd_soc_component *component);
 	const char *debugfs_prefix;
@@ -761,7 +778,6 @@ struct snd_soc_codec {
 	struct snd_ac97 *ac97;  /* for ad-hoc ac97 devices */
 	unsigned int cache_bypass:1; /* Suppress access to the cache */
 	unsigned int suspended:1; /* Codec is in suspend PM state */
-	unsigned int probed:1; /* Codec has been probed */
 	unsigned int ac97_registered:1; /* Codec has been AC97 registered */
 	unsigned int ac97_created:1; /* Codec has been created by SoC */
 	unsigned int cache_init:1; /* codec cache has been initialized */
@@ -827,10 +843,6 @@ struct snd_soc_codec_driver {
 			     enum snd_soc_dapm_type, int);
 
 	bool ignore_pmdown_time;  /* Doesn't benefit from pmdown delay */
-
-	/* probe ordering - for components with runtime dependencies */
-	int probe_order;
-	int remove_order;
 };
 
 /* SoC platform interface */
@@ -867,10 +879,6 @@ struct snd_soc_platform_driver {
 	/* platform stream compress ops */
 	const struct snd_compr_ops *compr_ops;
 
-	/* probe ordering - for components with runtime dependencies */
-	int probe_order;
-	int remove_order;
-
 	/* platform IO - used for platform DAPM */
 	unsigned int (*read)(struct snd_soc_platform *, unsigned int);
 	int (*write)(struct snd_soc_platform *, unsigned int, unsigned int);
@@ -888,7 +896,6 @@ struct snd_soc_platform {
 	const struct snd_soc_platform_driver *driver;
 
 	unsigned int suspended:1; /* platform is suspended */
-	unsigned int probed:1;
 
 	struct list_head list;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8d1e319..abc1a05 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -985,44 +985,20 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 	return 0;
 }
 
-static int soc_remove_platform(struct snd_soc_platform *platform)
+static void soc_remove_component(struct snd_soc_component *component)
 {
-	int ret;
-
-	if (platform->driver->remove) {
-		ret = platform->driver->remove(platform);
-		if (ret < 0)
-			dev_err(platform->dev, "ASoC: failed to remove %d\n",
-				ret);
-	}
-
-	/* Make sure all DAPM widgets are freed */
-	snd_soc_dapm_free(&platform->component.dapm);
-
-	soc_cleanup_component_debugfs(&platform->component);
-	platform->probed = 0;
-	module_put(platform->dev->driver->owner);
-
-	return 0;
-}
-
-static void soc_remove_codec(struct snd_soc_codec *codec)
-{
-	int err;
+	/* This is a HACK and will be removed soon */
+	if (component->codec)
+		list_del(&component->codec->card_list);
 
-	if (codec->driver->remove) {
-		err = codec->driver->remove(codec);
-		if (err < 0)
-			dev_err(codec->dev, "ASoC: failed to remove %d\n", err);
-	}
+	if (component->remove)
+		component->remove(component);
 
-	/* Make sure all DAPM widgets are freed */
-	snd_soc_dapm_free(&codec->dapm);
+	snd_soc_dapm_free(snd_soc_component_get_dapm(component));
 
-	soc_cleanup_component_debugfs(&codec->component);
-	codec->probed = 0;
-	list_del(&codec->card_list);
-	module_put(codec->dev->driver->owner);
+	soc_cleanup_component_debugfs(component);
+	component->probed = 0;
+	module_put(component->dev->driver->owner);
 }
 
 static void soc_remove_codec_dai(struct snd_soc_dai *codec_dai, int order)
@@ -1086,25 +1062,24 @@ static void soc_remove_link_components(struct snd_soc_card *card, int num,
 	int i;
 
 	/* remove the platform */
-	if (platform && platform->probed &&
-	    platform->driver->remove_order == order) {
-		soc_remove_platform(platform);
-	}
+	if (platform && platform->component.probed &&
+	    platform->component.driver->remove_order == order)
+		soc_remove_component(&platform->component);
 
 	/* remove the CODEC-side CODEC */
 	for (i = 0; i < rtd->num_codecs; i++) {
 		codec = rtd->codec_dais[i]->codec;
-		if (codec && codec->probed &&
-		    codec->driver->remove_order == order)
-			soc_remove_codec(codec);
+		if (codec && codec->component.probed &&
+		    codec->component.driver->remove_order == order)
+			soc_remove_component(&codec->component);
 	}
 
 	/* remove any CPU-side CODEC */
 	if (cpu_dai) {
 		codec = cpu_dai->codec;
-		if (codec && codec->probed &&
-		    codec->driver->remove_order == order)
-			soc_remove_codec(codec);
+		if (codec && codec->component.probed &&
+		    codec->component.driver->remove_order == order)
+			soc_remove_component(&codec->component);
 	}
 }
 
@@ -1146,137 +1121,108 @@ static void soc_set_name_prefix(struct snd_soc_card *card,
 	}
 }
 
-static int soc_probe_codec(struct snd_soc_card *card,
-			   struct snd_soc_codec *codec)
+static int soc_probe_component(struct snd_soc_card *card,
+	struct snd_soc_component *component)
 {
-	int ret = 0;
-	const struct snd_soc_codec_driver *driver = codec->driver;
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct snd_soc_component *dai_component, *component2;
 	struct snd_soc_dai *dai;
+	int ret;
 
-	codec->component.card = card;
-	codec->dapm.card = card;
-	soc_set_name_prefix(card, &codec->component);
+	component->card = card;
+	dapm->card = card;
+	soc_set_name_prefix(card, component);
 
-	if (!try_module_get(codec->dev->driver->owner))
+	if (!try_module_get(component->dev->driver->owner))
 		return -ENODEV;
 
-	soc_init_component_debugfs(&codec->component);
+	soc_init_component_debugfs(component);
 
-	if (driver->dapm_widgets) {
-		ret = snd_soc_dapm_new_controls(&codec->dapm,
-						driver->dapm_widgets,
-					 	driver->num_dapm_widgets);
+	if (component->dapm_widgets) {
+		ret = snd_soc_dapm_new_controls(dapm, component->dapm_widgets,
+			component->num_dapm_widgets);
 
 		if (ret != 0) {
-			dev_err(codec->dev,
+			dev_err(component->dev,
 				"Failed to create new controls %d\n", ret);
 			goto err_probe;
 		}
 	}
 
-	/* Create DAPM widgets for each DAI stream */
-	list_for_each_entry(dai, &codec->component.dai_list, list) {
-		ret = snd_soc_dapm_new_dai_widgets(&codec->dapm, dai);
+	/*
+	 * This is rather ugly, but certain platforms expect that the DAPM
+	 * widgets for the DAIs for components with the same parent device are
+	 * created in the platforms DAPM context. Until that is fixed we need to
+	 * keep this.
+	 */
+	if (component->steal_sibling_dai_widgets) {
+		dai_component = NULL;
+		list_for_each_entry(component2, &component_list, list) {
+			if (component == component2)
+				continue;
 
-		if (ret != 0) {
-			dev_err(codec->dev,
-				"Failed to create DAI widgets %d\n", ret);
-			goto err_probe;
+			if (component2->dev == component->dev &&
+			    !list_empty(&component2->dai_list)) {
+				dai_component = component2;
+				break;
+			}
 		}
-	}
-
-	codec->dapm.idle_bias_off = driver->idle_bias_off;
-
-	if (driver->probe) {
-		ret = driver->probe(codec);
-		if (ret < 0) {
-			dev_err(codec->dev,
-				"ASoC: failed to probe CODEC %d\n", ret);
-			goto err_probe;
+	} else {
+		dai_component = component;
+		list_for_each_entry(component2, &component_list, list) {
+			if (component2->dev == component->dev &&
+			    component2->steal_sibling_dai_widgets) {
+				dai_component = NULL;
+				break;
+			}
 		}
-		WARN(codec->dapm.idle_bias_off &&
-			codec->dapm.bias_level != SND_SOC_BIAS_OFF,
-			"codec %s can not start from non-off bias with idle_bias_off==1\n",
-			codec->component.name);
 	}
 
-	if (driver->controls)
-		snd_soc_add_codec_controls(codec, driver->controls,
-				     driver->num_controls);
-	if (driver->dapm_routes)
-		snd_soc_dapm_add_routes(&codec->dapm, driver->dapm_routes,
-					driver->num_dapm_routes);
-
-	/* mark codec as probed and add to card codec list */
-	codec->probed = 1;
-	list_add(&codec->card_list, &card->codec_dev_list);
-	list_add(&codec->dapm.list, &card->dapm_list);
-
-	return 0;
-
-err_probe:
-	soc_cleanup_component_debugfs(&codec->component);
-	module_put(codec->dev->driver->owner);
-
-	return ret;
-}
-
-static int soc_probe_platform(struct snd_soc_card *card,
-			   struct snd_soc_platform *platform)
-{
-	int ret = 0;
-	const struct snd_soc_platform_driver *driver = platform->driver;
-	struct snd_soc_component *component;
-	struct snd_soc_dai *dai;
-
-	platform->component.card = card;
-	platform->component.dapm.card = card;
-
-	if (!try_module_get(platform->dev->driver->owner))
-		return -ENODEV;
-
-	soc_init_component_debugfs(&platform->component);
-
-	if (driver->dapm_widgets)
-		snd_soc_dapm_new_controls(&platform->component.dapm,
-			driver->dapm_widgets, driver->num_dapm_widgets);
-
-	/* Create DAPM widgets for each DAI stream */
-	list_for_each_entry(component, &component_list, list) {
-		if (component->dev != platform->dev)
-			continue;
-		list_for_each_entry(dai, &component->dai_list, list)
-			snd_soc_dapm_new_dai_widgets(&platform->component.dapm,
-				dai);
+	if (dai_component) {
+		list_for_each_entry(dai, &dai_component->dai_list, list) {
+			snd_soc_dapm_new_dai_widgets(dapm, dai);
+			if (ret != 0) {
+				dev_err(component->dev,
+					"Failed to create DAI widgets %d\n",
+					ret);
+				goto err_probe;
+			}
+		}
 	}
 
-	platform->component.dapm.idle_bias_off = 1;
-
-	if (driver->probe) {
-		ret = driver->probe(platform);
+	if (component->probe) {
+		ret = component->probe(component);
 		if (ret < 0) {
-			dev_err(platform->dev,
-				"ASoC: failed to probe platform %d\n", ret);
+			dev_err(component->dev,
+				"ASoC: failed to probe component %d\n", ret);
 			goto err_probe;
 		}
+
+		WARN(dapm->idle_bias_off &&
+			dapm->bias_level != SND_SOC_BIAS_OFF,
+			"codec %s can not start from non-off bias with idle_bias_off==1\n",
+			component->name);
 	}
 
-	if (driver->controls)
-		snd_soc_add_platform_controls(platform, driver->controls,
-				     driver->num_controls);
-	if (driver->dapm_routes)
-		snd_soc_dapm_add_routes(&platform->component.dapm,
-			driver->dapm_routes, driver->num_dapm_routes);
+	if (component->controls)
+		snd_soc_add_component_controls(component, component->controls,
+				     component->num_controls);
+	if (component->dapm_routes)
+		snd_soc_dapm_add_routes(dapm, component->dapm_routes,
+					component->num_dapm_routes);
 
-	/* mark platform as probed and add to card platform list */
-	platform->probed = 1;
-	list_add(&platform->component.dapm.list, &card->dapm_list);
+	component->probed = 1;
+	list_add(&dapm->list, &card->dapm_list);
+
+	/* This is a HACK and will be removed soon */
+	if (component->codec)
+		list_add(&component->codec->card_list, &card->codec_dev_list);
 
 	return 0;
 
 err_probe:
-	soc_cleanup_component_debugfs(&platform->component);
-	module_put(platform->dev->driver->owner);
+	soc_cleanup_component_debugfs(component);
+	module_put(component->dev->driver->owner);
 
 	return ret;
 }
@@ -1334,33 +1280,36 @@ static int soc_probe_link_components(struct snd_soc_card *card, int num,
 				     int order)
 {
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_component *component;
 	int i, ret;
 
 	/* probe the CPU-side component, if it is a CODEC */
-	if (cpu_dai->codec &&
-	    !cpu_dai->codec->probed &&
-	    cpu_dai->codec->driver->probe_order == order) {
-		ret = soc_probe_codec(card, cpu_dai->codec);
-		if (ret < 0)
-			return ret;
+	if (rtd->cpu_dai->codec) {
+		component = &rtd->cpu_dai->codec->component;
+		if (!component->probed &&
+		    component->driver->probe_order == order) {
+			ret = soc_probe_component(card, component);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	/* probe the CODEC-side components */
 	for (i = 0; i < rtd->num_codecs; i++) {
-		if (!rtd->codec_dais[i]->codec->probed &&
-		    rtd->codec_dais[i]->codec->driver->probe_order == order) {
-			ret = soc_probe_codec(card, rtd->codec_dais[i]->codec);
+		component = &rtd->codec_dais[i]->codec->component;
+		if (!component->probed &&
+		    component->driver->probe_order == order) {
+			ret = soc_probe_component(card, component);
 			if (ret < 0)
 				return ret;
 		}
 	}
 
 	/* probe the platform */
-	if (!platform->probed &&
-	    platform->driver->probe_order == order) {
-		ret = soc_probe_platform(card, platform);
+	if (!platform->component.probed &&
+	    platform->component.driver->probe_order == order) {
+		ret = soc_probe_component(card, &platform->component);
 		if (ret < 0)
 			return ret;
 	}
@@ -1647,12 +1596,12 @@ static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
 	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
 	int ret;
 
-	if (rtd->codec->probed) {
+	if (rtd->codec->component.probed) {
 		dev_err(rtd->codec->dev, "ASoC: codec already probed\n");
 		return -EBUSY;
 	}
 
-	ret = soc_probe_codec(card, rtd->codec);
+	ret = soc_probe_component(card, &rtd->codec->component);
 	if (ret < 0)
 		return ret;
 
@@ -1681,8 +1630,8 @@ static void soc_remove_aux_dev(struct snd_soc_card *card, int num)
 		rtd->dev_registered = 0;
 	}
 
-	if (codec && codec->probed)
-		soc_remove_codec(codec);
+	if (codec && codec->component.probed)
+		soc_remove_component(&codec->component);
 }
 
 static int snd_soc_init_codec_cache(struct snd_soc_codec *codec)
@@ -4198,6 +4147,20 @@ found:
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_component);
 
+static int snd_soc_platform_drv_probe(struct snd_soc_component *component)
+{
+	struct snd_soc_platform *platform = snd_soc_component_to_platform(component);
+
+	return platform->driver->probe(platform);
+}
+
+static void snd_soc_platform_drv_remove(struct snd_soc_component *component)
+{
+	struct snd_soc_platform *platform = snd_soc_component_to_platform(component);
+
+	platform->driver->remove(platform);
+}
+
 static int snd_soc_platform_drv_write(struct snd_soc_component *component,
 	unsigned int reg, unsigned int val)
 {
@@ -4234,6 +4197,24 @@ int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 
 	platform->dev = dev;
 	platform->driver = platform_drv;
+	if (platform_drv->controls) {
+		platform->component.controls = platform_drv->controls;
+		platform->component.num_controls = platform_drv->num_controls;
+	}
+	if (platform_drv->dapm_widgets) {
+		platform->component.dapm_widgets = platform_drv->dapm_widgets;
+		platform->component.num_dapm_widgets = platform_drv->num_dapm_widgets;
+		platform->component.steal_sibling_dai_widgets = true;
+	}
+	if (platform_drv->dapm_routes) {
+		platform->component.dapm_routes = platform_drv->dapm_routes;
+		platform->component.num_dapm_routes = platform_drv->num_dapm_routes;
+	}
+
+	if (platform_drv->probe)
+		platform->component.probe = snd_soc_platform_drv_probe;
+	if (platform_drv->remove)
+		platform->component.remove = snd_soc_platform_drv_remove;
 	if (platform_drv->write)
 		platform->component.write = snd_soc_platform_drv_write;
 	if (platform_drv->read)
@@ -4363,6 +4344,20 @@ static void fixup_codec_formats(struct snd_soc_pcm_stream *stream)
 			stream->formats |= codec_format_map[i];
 }
 
+static int snd_soc_codec_drv_probe(struct snd_soc_component *component)
+{
+	struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
+
+	return codec->driver->probe(codec);
+}
+
+static void snd_soc_codec_drv_remove(struct snd_soc_component *component)
+{
+	struct snd_soc_codec *codec = snd_soc_component_to_codec(component);
+
+	codec->driver->remove(codec);
+}
+
 static int snd_soc_codec_drv_write(struct snd_soc_component *component,
 	unsigned int reg, unsigned int val)
 {
@@ -4411,12 +4406,30 @@ int snd_soc_register_codec(struct device *dev,
 		return -ENOMEM;
 
 	codec->component.dapm_ptr = &codec->dapm;
+	codec->component.codec = codec;
 
 	ret = snd_soc_component_initialize(&codec->component,
 			&codec_drv->component_driver, dev);
 	if (ret)
 		goto err_free;
 
+	if (codec_drv->controls) {
+		codec->component.controls = codec_drv->controls;
+		codec->component.num_controls = codec_drv->num_controls;
+	}
+	if (codec_drv->dapm_widgets) {
+		codec->component.dapm_widgets = codec_drv->dapm_widgets;
+		codec->component.num_dapm_widgets = codec_drv->num_dapm_widgets;
+	}
+	if (codec_drv->dapm_routes) {
+		codec->component.dapm_routes = codec_drv->dapm_routes;
+		codec->component.num_dapm_routes = codec_drv->num_dapm_routes;
+	}
+
+	if (codec_drv->probe)
+		codec->component.probe = snd_soc_codec_drv_probe;
+	if (codec_drv->remove)
+		codec->component.remove = snd_soc_codec_drv_remove;
 	if (codec_drv->write)
 		codec->component.write = snd_soc_codec_drv_write;
 	if (codec_drv->read)
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 6307f85..b329b84 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -336,10 +336,12 @@ static const struct snd_pcm_ops dmaengine_pcm_ops = {
 };
 
 static const struct snd_soc_platform_driver dmaengine_pcm_platform = {
+	.component_driver = {
+		.probe_order = SND_SOC_COMP_ORDER_LATE,
+	},
 	.ops		= &dmaengine_pcm_ops,
 	.pcm_new	= dmaengine_pcm_new,
 	.pcm_free	= dmaengine_pcm_free,
-	.probe_order	= SND_SOC_COMP_ORDER_LATE,
 };
 
 static const char * const dmaengine_pcm_dma_channel_names[] = {
-- 
1.8.0
