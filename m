From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Make aux_dev more like a generic
	component" to the asoc tree
Date: Sun, 10 Jan 2016 12:50:44 +0000
Message-ID: <E1aIFSG-0001HZ-VD@debutante>
References: <1452058171-32688-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 787602605EA
 for <alsa-devel@alsa-project.org>; Sun, 10 Jan 2016 13:50:54 +0100 (CET)
In-Reply-To: <1452058171-32688-1-git-send-email-mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Make aux_dev more like a generic component

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From f2ed6b07645ed29c1e090ead2e41066385cba3ea Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Wed, 6 Jan 2016 13:29:31 +0800
Subject: [PATCH] ASoC: Make aux_dev more like a generic component

aux_dev is mainly used by the machine driver to specify analog devices,
which are registered as codecs. Making it more like a generic component
can help the machine driver to use it to specify any component with
topology info by name.

Details:
- Remove the stub 'rtd_aux' array from the soc card.
- Add a list 'aux_comp_list' to store the components of aux_devs.
  And add a list head 'list_aux' to struct snd_soc_component, for adding
  such components to the above list.
- Add a 'init' ops to a component for machine specific init.
  soc_bind_aux_dev() will set it to be aux_dev's init. And it will be
  called when probing the component.
- soc_bind_aux_dev() will also search components by name of an aux_dev,
  since it may not be a codec.
- Move probing of aux_devs before checking new DAI links brought by
  topology.
- Move removal of aux_devs later than removal of links. Because topology
  of aux components may register DAIs and the DAI drivers will go with
  removal of the aux components, we want soc_remove_link_dais() to remove
  the DAIs at first.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  |   8 ++-
 sound/soc/soc-core.c | 146 +++++++++++++++++++++++++++------------------------
 2 files changed, 83 insertions(+), 71 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9d1383e8d039..5bc5def6af02 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -787,6 +787,7 @@ struct snd_soc_component {
 	unsigned int registered_as_component:1;
 
 	struct list_head list;
+	struct list_head list_aux; /* for auxiliary component of the card */
 
 	struct snd_soc_dai_driver *dai_drv;
 	int num_dai;
@@ -830,6 +831,9 @@ struct snd_soc_component {
 	int (*probe)(struct snd_soc_component *);
 	void (*remove)(struct snd_soc_component *);
 
+	/* machine specific init */
+	int (*init)(struct snd_soc_component *component);
+
 #ifdef CONFIG_DEBUG_FS
 	void (*init_debugfs)(struct snd_soc_component *component);
 	const char *debugfs_prefix;
@@ -1130,8 +1134,7 @@ struct snd_soc_card {
 	 */
 	struct snd_soc_aux_dev *aux_dev;
 	int num_aux_devs;
-	struct snd_soc_pcm_runtime *rtd_aux;
-	int num_aux_rtd;
+	struct list_head aux_comp_list;
 
 	const struct snd_kcontrol_new *controls;
 	int num_controls;
@@ -1537,6 +1540,7 @@ static inline void snd_soc_initialize_card_lists(struct snd_soc_card *card)
 	INIT_LIST_HEAD(&card->widgets);
 	INIT_LIST_HEAD(&card->paths);
 	INIT_LIST_HEAD(&card->dapm_list);
+	INIT_LIST_HEAD(&card->aux_comp_list);
 }
 
 static inline bool snd_soc_volsw_is_stereo(struct soc_mixer_control *mc)
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c572673a5a24..c10bd668659c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1413,6 +1413,16 @@ static int soc_probe_component(struct snd_soc_card *card,
 			component->name);
 	}
 
+	/* machine specific init */
+	if (component->init) {
+		ret = component->init(component);
+		if (ret < 0) {
+			dev_err(component->dev,
+				"Failed to do machine specific init %d\n", ret);
+			goto err_probe;
+		}
+	}
+
 	if (component->controls)
 		snd_soc_add_component_controls(component, component->controls,
 				     component->num_controls);
@@ -1657,65 +1667,81 @@ static int soc_probe_link_dais(struct snd_soc_card *card,
 
 static int soc_bind_aux_dev(struct snd_soc_card *card, int num)
 {
-	struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
 	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
-	const char *name = aux_dev->codec_name;
-
-	rtd->component = soc_find_component(aux_dev->codec_of_node, name);
-	if (!rtd->component) {
-		if (aux_dev->codec_of_node)
-			name = of_node_full_name(aux_dev->codec_of_node);
-
-		dev_err(card->dev, "ASoC: %s not registered\n", name);
-		return -EPROBE_DEFER;
+	struct snd_soc_component *component;
+	const char *name;
+	struct device_node *codec_of_node;
+
+	if (aux_dev->codec_of_node || aux_dev->codec_name) {
+		/* codecs, usually analog devices */
+		name = aux_dev->codec_name;
+		codec_of_node = aux_dev->codec_of_node;
+		component = soc_find_component(codec_of_node, name);
+		if (!component) {
+			if (codec_of_node)
+				name = of_node_full_name(codec_of_node);
+			goto err_defer;
+		}
+	} else if (aux_dev->name) {
+		/* generic components */
+		name = aux_dev->name;
+		component = soc_find_component(NULL, name);
+		if (!component)
+			goto err_defer;
+	} else {
+		dev_err(card->dev, "ASoC: Invalid auxiliary device\n");
+		return -EINVAL;
 	}
 
-	/*
-	 * Some places still reference rtd->codec, so we have to keep that
-	 * initialized if the component is a CODEC. Once all those references
-	 * have been removed, this code can be removed as well.
-	 */
-	 rtd->codec = rtd->component->codec;
-
+	component->init = aux_dev->init;
+	list_add(&component->list_aux, &card->aux_comp_list);
 	return 0;
+
+err_defer:
+	dev_err(card->dev, "ASoC: %s not registered\n", name);
+	return -EPROBE_DEFER;
 }
 
-static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
+static int soc_probe_aux_devices(struct snd_soc_card *card)
 {
-	struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
-	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
+	struct snd_soc_component *comp;
+	int order;
 	int ret;
 
-	ret = soc_probe_component(card, rtd->component);
-	if (ret < 0)
-		return ret;
-
-	/* do machine specific initialization */
-	if (aux_dev->init) {
-		ret = aux_dev->init(rtd->component);
-		if (ret < 0) {
-			dev_err(card->dev, "ASoC: failed to init %s: %d\n",
-				aux_dev->name, ret);
-			return ret;
+	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
+		order++) {
+		list_for_each_entry(comp, &card->aux_comp_list, list_aux) {
+			if (comp->driver->probe_order == order) {
+				ret = soc_probe_component(card,	comp);
+				if (ret < 0) {
+					dev_err(card->dev,
+						"ASoC: failed to probe aux component %s %d\n",
+						comp->name, ret);
+					return ret;
+				}
+			}
 		}
 	}
 
-	return soc_post_component_init(rtd, aux_dev->name);
+	return 0;
 }
 
-static void soc_remove_aux_dev(struct snd_soc_card *card, int num)
+static void soc_remove_aux_devices(struct snd_soc_card *card)
 {
-	struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
-	struct snd_soc_component *component = rtd->component;
+	struct snd_soc_component *comp, *_comp;
+	int order;
 
-	/* unregister the rtd device */
-	if (rtd->dev_registered) {
-		device_unregister(rtd->dev);
-		rtd->dev_registered = 0;
+	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
+		order++) {
+		list_for_each_entry_safe(comp, _comp,
+			&card->aux_comp_list, list_aux) {
+			if (comp->driver->remove_order == order) {
+				soc_remove_component(comp);
+				/* remove it from the card's aux_comp_list */
+				list_del(&comp->list_aux);
+			}
+		}
 	}
-
-	if (component)
-		soc_remove_component(component);
 }
 
 static int snd_soc_init_codec_cache(struct snd_soc_codec *codec)
@@ -1894,6 +1920,11 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 		}
 	}
 
+	/* probe auxiliary components */
+	ret = soc_probe_aux_devices(card);
+	if (ret < 0)
+		goto probe_dai_err;
+
 	/* Find new DAI links added during probing components and bind them.
 	 * Components with topology may bring new DAIs and DAI links.
 	 */
@@ -1923,16 +1954,6 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 		}
 	}
 
-	for (i = 0; i < card->num_aux_devs; i++) {
-		ret = soc_probe_aux_dev(card, i);
-		if (ret < 0) {
-			dev_err(card->dev,
-				"ASoC: failed to add auxiliary devices %d\n",
-				ret);
-			goto probe_aux_dev_err;
-		}
-	}
-
 	snd_soc_dapm_link_dai_widgets(card);
 	snd_soc_dapm_connect_dai_link_widgets(card);
 
@@ -1992,8 +2013,7 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	return 0;
 
 probe_aux_dev_err:
-	for (i = 0; i < card->num_aux_devs; i++)
-		soc_remove_aux_dev(card, i);
+	soc_remove_aux_devices(card);
 
 probe_dai_err:
 	soc_remove_dai_links(card);
@@ -2039,20 +2059,18 @@ static int soc_probe(struct platform_device *pdev)
 static int soc_cleanup_card_resources(struct snd_soc_card *card)
 {
 	struct snd_soc_pcm_runtime *rtd;
-	int i;
 
 	/* make sure any delayed work runs */
 	list_for_each_entry(rtd, &card->rtd_list, list)
 		flush_delayed_work(&rtd->delayed_work);
 
-	/* remove auxiliary devices */
-	for (i = 0; i < card->num_aux_devs; i++)
-		soc_remove_aux_dev(card, i);
-
 	/* remove and free each DAI */
 	soc_remove_dai_links(card);
 	soc_remove_pcm_runtimes(card);
 
+	/* remove auxiliary devices */
+	soc_remove_aux_devices(card);
+
 	soc_cleanup_card_debugfs(card);
 
 	/* remove the card */
@@ -2608,16 +2626,6 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	INIT_LIST_HEAD(&card->rtd_list);
 	card->num_rtd = 0;
 
-	card->rtd_aux = devm_kzalloc(card->dev,
-				 sizeof(struct snd_soc_pcm_runtime) *
-				 card->num_aux_devs,
-				 GFP_KERNEL);
-	if (card->rtd_aux == NULL)
-		return -ENOMEM;
-
-	for (i = 0; i < card->num_aux_devs; i++)
-		card->rtd_aux[i].card = card;
-
 	INIT_LIST_HEAD(&card->dapm_dirty);
 	INIT_LIST_HEAD(&card->dobj_list);
 	card->instantiated = 0;
-- 
2.7.0.rc3
