From: Benoit Cousson <bcousson@baylibre.com>
Subject: [PATCH v4 3/8] ASoC: core: Add initial support for DAI
	multicodec
Date: Tue,  1 Jul 2014 09:47:56 +0200
Message-ID: <1404200881-32253-4-git-send-email-bcousson@baylibre.com>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f171.google.com (mail-we0-f171.google.com
 [74.125.82.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B4D2264F34
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 09:48:59 +0200 (CEST)
Received: by mail-we0-f171.google.com with SMTP id q58so9280720wes.2
 for <alsa-devel@alsa-project.org>; Tue, 01 Jul 2014 00:48:59 -0700 (PDT)
In-Reply-To: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de
Cc: Fabien Parent <fparent@baylibre.com>, misael.lopez@ti.com, alsa-devel@alsa-project.org, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

DAI link assumes a one to one mapping between CPU DAI and CODEC. In
some cases, the same CPU DAI can be connected to several codecs.
This is the case for example, if you connect two mono codecs to the
same I2S link in order to have a stereo card.
The current ASoC implementation does not allow such setup.

Add support for DAI links composed of a single CPU DAI and multiple
CODECs. Sound cards have to pass the CODECs array in the corresponding
DAI link through a new 'snd_soc_dai_link_component' struct. Each CODEC in
this array is described in the same manner single CODEC DAIs are
(either DT/OF node or codec_name).

Based on an original code done by Misael.

Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 include/sound/soc-dai.h |   4 +
 include/sound/soc.h     |  13 ++
 sound/soc/soc-core.c    | 337 ++++++++++++++++++++++++++++++++----------------
 3 files changed, 242 insertions(+), 112 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 031be2a..e8b3080 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -272,6 +272,10 @@ struct snd_soc_dai {
 	struct snd_soc_codec *codec;
 	struct snd_soc_component *component;
 
+	/* CODEC TDM slot masks and params (for fixup) */
+	unsigned int tx_mask;
+	unsigned int rx_mask;
+
 	struct snd_soc_card *card;
 
 	struct list_head list;
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9a5b4f6..f2142cf 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -846,6 +846,12 @@ struct snd_soc_platform_driver {
 	int (*bespoke_trigger)(struct snd_pcm_substream *, int);
 };
 
+struct snd_soc_dai_link_component {
+	const char *name;
+	const struct device_node *of_node;
+	const char *dai_name;
+};
+
 struct snd_soc_platform {
 	struct device *dev;
 	const struct snd_soc_platform_driver *driver;
@@ -891,6 +897,10 @@ struct snd_soc_dai_link {
 	const struct device_node *codec_of_node;
 	/* You MUST specify the DAI name within the codec */
 	const char *codec_dai_name;
+
+	struct snd_soc_dai_link_component *codecs;
+	unsigned int num_codecs;
+
 	/*
 	 * You MAY specify the link's platform/PCM/DMA driver, either by
 	 * device name, or by DT/OF node, but not both. Some forms of link
@@ -1089,6 +1099,9 @@ struct snd_soc_pcm_runtime {
 	struct snd_soc_dai *codec_dai;
 	struct snd_soc_dai *cpu_dai;
 
+	struct snd_soc_dai **codec_dais;
+	unsigned int num_codecs;
+
 	struct delayed_work delayed_work;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dpcm_root;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 37a965c..3764150 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -554,7 +554,7 @@ int snd_soc_suspend(struct device *dev)
 {
 	struct snd_soc_card *card = dev_get_drvdata(dev);
 	struct snd_soc_codec *codec;
-	int i;
+	int i, j;
 
 	/* If the initialization of this soc device failed, there is no codec
 	 * associated with it. Just bail out in this case.
@@ -574,14 +574,16 @@ int snd_soc_suspend(struct device *dev)
 
 	/* mute any active DACs */
 	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_dai *dai = card->rtd[i].codec_dai;
-		struct snd_soc_dai_driver *drv = dai->driver;
+		for (j = 0; j < card->rtd[i].num_codecs; j++) {
+			struct snd_soc_dai *dai = card->rtd[i].codec_dais[j];
+			struct snd_soc_dai_driver *drv = dai->driver;
 
-		if (card->rtd[i].dai_link->ignore_suspend)
-			continue;
+			if (card->rtd[i].dai_link->ignore_suspend)
+				continue;
 
-		if (drv->ops->digital_mute && dai->playback_active)
-			drv->ops->digital_mute(dai, 1);
+			if (drv->ops->digital_mute && dai->playback_active)
+				drv->ops->digital_mute(dai, 1);
+		}
 	}
 
 	/* suspend all pcms */
@@ -612,8 +614,12 @@ int snd_soc_suspend(struct device *dev)
 
 	/* close any waiting streams and save state */
 	for (i = 0; i < card->num_rtd; i++) {
+		struct snd_soc_dai **codec_dais = card->rtd[i].codec_dais;
 		flush_delayed_work(&card->rtd[i].delayed_work);
-		card->rtd[i].codec->dapm.suspend_bias_level = card->rtd[i].codec->dapm.bias_level;
+		for (j = 0; j < card->rtd[i].num_codecs; j++) {
+			codec_dais[j]->codec->dapm.suspend_bias_level =
+					codec_dais[j]->codec->dapm.bias_level;
+		}
 	}
 
 	for (i = 0; i < card->num_rtd; i++) {
@@ -697,7 +703,7 @@ static void soc_resume_deferred(struct work_struct *work)
 	struct snd_soc_card *card =
 			container_of(work, struct snd_soc_card, deferred_resume_work);
 	struct snd_soc_codec *codec;
-	int i;
+	int i, j;
 
 	/* our power state is still SNDRV_CTL_POWER_D3hot from suspend time,
 	 * so userspace apps are blocked from touching us
@@ -758,14 +764,17 @@ static void soc_resume_deferred(struct work_struct *work)
 
 	/* unmute any active DACs */
 	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_dai *dai = card->rtd[i].codec_dai;
-		struct snd_soc_dai_driver *drv = dai->driver;
 
-		if (card->rtd[i].dai_link->ignore_suspend)
-			continue;
+		for (j = 0; j < card->rtd[i].num_codecs; j++) {
+			struct snd_soc_dai *dai = card->rtd[i].codec_dais[j];
+			struct snd_soc_dai_driver *drv = dai->driver;
+
+			if (card->rtd[i].dai_link->ignore_suspend)
+				continue;
 
-		if (drv->ops->digital_mute && dai->playback_active)
-			drv->ops->digital_mute(dai, 0);
+			if (drv->ops->digital_mute && dai->playback_active)
+				drv->ops->digital_mute(dai, 0);
+		}
 	}
 
 	for (i = 0; i < card->num_rtd; i++) {
@@ -810,12 +819,19 @@ int snd_soc_resume(struct device *dev)
 
 	/* activate pins from sleep state */
 	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
-		struct snd_soc_dai *codec_dai = card->rtd[i].codec_dai;
+		struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
+		struct snd_soc_dai **codec_dais = rtd->codec_dais;
+		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+		int j;
+
 		if (cpu_dai->active)
 			pinctrl_pm_select_default_state(cpu_dai->dev);
-		if (codec_dai->active)
-			pinctrl_pm_select_default_state(codec_dai->dev);
+
+		for (j = 0; j < rtd->num_codecs; j++) {
+			struct snd_soc_dai *codec_dai = codec_dais[j];
+			if (codec_dai->active)
+				pinctrl_pm_select_default_state(codec_dai->dev);
+		}
 	}
 
 	/* AC97 devices might have other drivers hanging off them so
@@ -847,8 +863,9 @@ EXPORT_SYMBOL_GPL(snd_soc_resume);
 static const struct snd_soc_dai_ops null_dai_ops = {
 };
 
-static struct snd_soc_codec *soc_find_codec(const struct device_node *codec_of_node,
-					    const char *codec_name)
+static struct snd_soc_codec *soc_find_codec(
+					const struct device_node *codec_of_node,
+					const char *codec_name)
 {
 	struct snd_soc_codec *codec;
 
@@ -886,9 +903,12 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
 	struct snd_soc_component *component;
+	struct snd_soc_dai_link_component *codecs = dai_link->codecs;
+	struct snd_soc_dai **codec_dais = rtd->codec_dais;
 	struct snd_soc_platform *platform;
 	struct snd_soc_dai *cpu_dai;
 	const char *platform_name;
+	int i;
 
 	dev_dbg(card->dev, "ASoC: binding %s at idx %d\n", dai_link->name, num);
 
@@ -915,24 +935,30 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 		return -EPROBE_DEFER;
 	}
 
-	/* Find CODEC from registered list */
-	rtd->codec = soc_find_codec(dai_link->codec_of_node,
-				    dai_link->codec_name);
-	if (!rtd->codec) {
-		dev_err(card->dev, "ASoC: CODEC %s not registered\n",
-			dai_link->codec_name);
-		return -EPROBE_DEFER;
-	}
+	rtd->num_codecs = dai_link->num_codecs;
 
-	/* Find CODEC DAI from registered list */
-	rtd->codec_dai = soc_find_codec_dai(rtd->codec,
-					    dai_link->codec_dai_name);
-	if (!rtd->codec_dai) {
-		dev_err(card->dev, "ASoC: CODEC DAI %s not registered\n",
-			dai_link->codec_dai_name);
-		return -EPROBE_DEFER;
+	/* Find CODEC from registered CODECs */
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_soc_codec *codec;
+		codec = soc_find_codec(codecs[i].of_node, codecs[i].name);
+		if (!codec) {
+			dev_err(card->dev, "ASoC: CODEC %s not registered\n",
+				codecs[i].name);
+			return -EPROBE_DEFER;
+		}
+
+		codec_dais[i] = soc_find_codec_dai(codec, codecs[i].dai_name);
+		if (!codec_dais[i]) {
+			dev_err(card->dev, "ASoC: CODEC DAI %s not registered\n",
+				codecs[i].dai_name);
+			return -EPROBE_DEFER;
+		}
 	}
 
+	/* Single codec links expect codec and codec_dai in runtime data */
+	rtd->codec_dai = codec_dais[0];
+	rtd->codec = rtd->codec_dai->codec;
+
 	/* if there's no platform we match on the empty platform */
 	platform_name = dai_link->platform_name;
 	if (!platform_name && !dai_link->platform_of_node)
@@ -1023,8 +1049,8 @@ static void soc_remove_codec_dai(struct snd_soc_dai *codec_dai, int order)
 static void soc_remove_link_dais(struct snd_soc_card *card, int num, int order)
 {
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
-	struct snd_soc_dai *codec_dai = rtd->codec_dai, *cpu_dai = rtd->cpu_dai;
-	int err;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int i, err;
 
 	/* unregister the rtd device */
 	if (rtd->dev_registered) {
@@ -1035,7 +1061,8 @@ static void soc_remove_link_dais(struct snd_soc_card *card, int num, int order)
 	}
 
 	/* remove the CODEC DAI */
-	soc_remove_codec_dai(codec_dai, order);
+	for (i = 0; i < rtd->num_codecs; i++)
+		soc_remove_codec_dai(rtd->codec_dais[i], order);
 
 	/* remove the cpu_dai */
 	if (cpu_dai && cpu_dai->probed &&
@@ -1058,9 +1085,9 @@ static void soc_remove_link_components(struct snd_soc_card *card, int num,
 {
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_codec *codec;
+	int i;
 
 	/* remove the platform */
 	if (platform && platform->probed &&
@@ -1069,8 +1096,8 @@ static void soc_remove_link_components(struct snd_soc_card *card, int num,
 	}
 
 	/* remove the CODEC-side CODEC */
-	if (codec_dai) {
-		codec = codec_dai->codec;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec = rtd->codec_dais[i]->codec;
 		if (codec && codec->probed &&
 		    codec->driver->remove_order == order)
 			soc_remove_codec(codec);
@@ -1264,16 +1291,19 @@ static void rtd_release(struct device *dev)
 	kfree(dev);
 }
 
-static int soc_aux_dev_init(struct snd_soc_card *card,
-			    struct snd_soc_codec *codec,
-			    int num)
+static int soc_aux_dev_init(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
 	struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
+	struct snd_soc_codec *codec;
 	int ret;
 
 	rtd->card = card;
 
+	codec = soc_find_codec(NULL, aux_dev->codec_name);
+	if (!codec)
+		return -EPROBE_DEFER;
+
 	/* do machine specific initialization */
 	if (aux_dev->init) {
 		ret = aux_dev->init(&codec->dapm);
@@ -1286,16 +1316,19 @@ static int soc_aux_dev_init(struct snd_soc_card *card,
 	return 0;
 }
 
-static int soc_dai_link_init(struct snd_soc_card *card,
-			     struct snd_soc_codec *codec,
-			     int num)
+static int soc_dai_link_init(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_dai_link *dai_link =  &card->dai_link[num];
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
-	int ret;
+	int i, ret;
 
 	rtd->card = card;
 
+	for (i = 0; i < rtd->num_codecs; i++) {
+		/* Make sure all DAPM widgets are instantiated */
+		snd_soc_dapm_new_widgets(rtd->codec_dais[i]->codec->dapm.card);
+	}
+
 	/* do machine specific initialization */
 	if (dai_link->init) {
 		ret = dai_link->init(rtd);
@@ -1303,13 +1336,10 @@ static int soc_dai_link_init(struct snd_soc_card *card,
 			return ret;
 	}
 
-	rtd->codec = codec;
-
 	return 0;
 }
 
 static int soc_post_component_init(struct snd_soc_card *card,
-				   struct snd_soc_codec *codec,
 				   int num, int dailess)
 {
 	struct snd_soc_dai_link *dai_link = NULL;
@@ -1322,12 +1352,12 @@ static int soc_post_component_init(struct snd_soc_card *card,
 		dai_link = &card->dai_link[num];
 		rtd = &card->rtd[num];
 		name = dai_link->name;
-		ret = soc_dai_link_init(card, codec, num);
+		ret = soc_dai_link_init(card, num);
 	} else {
 		aux_dev = &card->aux_dev[num];
 		rtd = &card->rtd_aux[num];
 		name = aux_dev->name;
-		ret = soc_aux_dev_init(card, codec, num);
+		ret = soc_aux_dev_init(card, num);
 	}
 
 	if (ret < 0) {
@@ -1353,7 +1383,7 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	if (ret < 0) {
 		/* calling put_device() here to free the rtd->dev */
 		put_device(rtd->dev);
-		dev_err(card->dev,
+		dev_err(rtd->dev,
 			"ASoC: failed to register runtime device: %d\n", ret);
 		return ret;
 	}
@@ -1362,13 +1392,13 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	/* add DAPM sysfs entries for this codec */
 	ret = snd_soc_dapm_sys_add(rtd->dev);
 	if (ret < 0)
-		dev_err(codec->dev,
+		dev_err(rtd->dev,
 			"ASoC: failed to add codec dapm sysfs entries: %d\n", ret);
 
 	/* add codec sysfs entries */
 	ret = device_create_file(rtd->dev, &dev_attr_codec_reg);
 	if (ret < 0)
-		dev_err(codec->dev,
+		dev_err(rtd->dev,
 			"ASoC: failed to add codec sysfs files: %d\n", ret);
 
 #ifdef CONFIG_DEBUG_FS
@@ -1390,9 +1420,8 @@ static int soc_probe_link_components(struct snd_soc_card *card, int num,
 {
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_platform *platform = rtd->platform;
-	int ret;
+	int i, ret;
 
 	/* probe the CPU-side component, if it is a CODEC */
 	if (cpu_dai->codec &&
@@ -1403,12 +1432,14 @@ static int soc_probe_link_components(struct snd_soc_card *card, int num,
 			return ret;
 	}
 
-	/* probe the CODEC-side component */
-	if (!codec_dai->codec->probed &&
-	    codec_dai->codec->driver->probe_order == order) {
-		ret = soc_probe_codec(card, codec_dai->codec);
-		if (ret < 0)
-			return ret;
+	/* probe the CODEC-side components */
+	for (i = 0; i < rtd->num_codecs; i++) {
+		if (!rtd->codec_dais[i]->codec->probed &&
+		    rtd->codec_dais[i]->codec->driver->probe_order == order) {
+			ret = soc_probe_codec(card, rtd->codec_dais[i]->codec);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	/* probe the platform */
@@ -1487,19 +1518,18 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 {
 	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
-	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret;
+	int i, ret;
 
 	dev_dbg(card->dev, "ASoC: probe %s dai link %d late %d\n",
 			card->name, num, order);
 
 	/* config components */
 	cpu_dai->platform = platform;
-	codec_dai->card = card;
 	cpu_dai->card = card;
+	for (i = 0; i < rtd->num_codecs; i++)
+		rtd->codec_dais[i]->card = card;
 
 	/* set default power off timeout */
 	rtd->pmdown_time = pmdown_time;
@@ -1526,15 +1556,17 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 	}
 
 	/* probe the CODEC DAI */
-	ret = soc_probe_codec_dai(card, codec_dai, order);
-	if (ret)
-		return ret;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		ret = soc_probe_codec_dai(card, rtd->codec_dais[i], order);
+		if (ret)
+			return ret;
+	}
 
 	/* complete DAI probe during last probe */
 	if (order != SND_SOC_COMP_ORDER_LAST)
 		return 0;
 
-	ret = soc_post_component_init(card, codec, num, 0);
+	ret = soc_post_component_init(card, num, 0);
 	if (ret)
 		return ret;
 
@@ -1573,8 +1605,11 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 	}
 
 	/* add platform data for AC97 devices */
-	if (rtd->codec_dai->driver->ac97_control)
-		snd_ac97_dev_add_pdata(codec->ac97, rtd->cpu_dai->ac97_pdata);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		if (rtd->codec_dais[i]->driver->ac97_control)
+			snd_ac97_dev_add_pdata(rtd->codec_dais[i]->codec->ac97,
+					       rtd->cpu_dai->ac97_pdata);
+	}
 
 	return 0;
 }
@@ -1612,11 +1647,6 @@ static int soc_register_ac97_codec(struct snd_soc_codec *codec,
 	return 0;
 }
 
-static int soc_register_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
-{
-	return soc_register_ac97_codec(rtd->codec, rtd->codec_dai);
-}
-
 static void soc_unregister_ac97_codec(struct snd_soc_codec *codec)
 {
 	if (codec->ac97_registered) {
@@ -1625,9 +1655,30 @@ static void soc_unregister_ac97_codec(struct snd_soc_codec *codec)
 	}
 }
 
+static int soc_register_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
+{
+	int i, ret;
+
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
+
+		ret = soc_register_ac97_codec(codec_dai->codec, codec_dai);
+		if (ret) {
+			while (--i >= 0)
+				soc_unregister_ac97_codec(codec_dai->codec);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static void soc_unregister_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
 {
-	soc_unregister_ac97_codec(rtd->codec);
+	int i;
+
+	for (i = 0; i < rtd->num_codecs; i++)
+		soc_unregister_ac97_codec(rtd->codec_dais[i]->codec);
 }
 #endif
 
@@ -1691,7 +1742,7 @@ static int soc_probe_aux_dev(struct snd_soc_card *card, int num)
 	if (ret < 0)
 		return ret;
 
-	ret = soc_post_component_init(card, codec, num, 1);
+	ret = soc_post_component_init(card, num, 1);
 
 	return ret;
 }
@@ -1845,16 +1896,23 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 					card->num_dapm_routes);
 
 	for (i = 0; i < card->num_links; i++) {
+		struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
 		dai_link = &card->dai_link[i];
 		dai_fmt = dai_link->dai_fmt;
 
 		if (dai_fmt) {
-			ret = snd_soc_dai_set_fmt(card->rtd[i].codec_dai,
-						  dai_fmt);
-			if (ret != 0 && ret != -ENOTSUPP)
-				dev_warn(card->rtd[i].codec_dai->dev,
-					 "ASoC: Failed to set DAI format: %d\n",
-					 ret);
+			struct snd_soc_dai **codec_dais = rtd->codec_dais;
+			int j;
+
+			for (j = 0; j < rtd->num_codecs; j++) {
+				struct snd_soc_dai *codec_dai = codec_dais[j];
+
+				ret = snd_soc_dai_set_fmt(codec_dai, dai_fmt);
+				if (ret != 0 && ret != -ENOTSUPP)
+					dev_warn(codec_dai->dev,
+						 "ASoC: Failed to set DAI format: %d\n",
+						 ret);
+			}
 		}
 
 		/* If this is a regular CPU link there will be a platform */
@@ -2053,10 +2111,15 @@ int snd_soc_poweroff(struct device *dev)
 
 	/* deactivate pins to sleep state */
 	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
-		struct snd_soc_dai *codec_dai = card->rtd[i].codec_dai;
-		pinctrl_pm_select_sleep_state(codec_dai->dev);
+		struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
+		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+		int j;
+
 		pinctrl_pm_select_sleep_state(cpu_dai->dev);
+		for (j = 0; j < rtd->num_codecs; j++) {
+			struct snd_soc_dai *codec_dai = rtd->codec_dais[j];
+			pinctrl_pm_select_sleep_state(codec_dai->dev);
+		}
 	}
 
 	return 0;
@@ -3636,6 +3699,9 @@ int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 	else
 		snd_soc_xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
 
+	dai->tx_mask = tx_mask;
+	dai->rx_mask = rx_mask;
+
 	if (dai->driver && dai->driver->ops->set_tdm_slot)
 		return dai->driver->ops->set_tdm_slot(dai, tx_mask, rx_mask,
 				slots, slot_width);
@@ -3708,6 +3774,33 @@ int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
 
+static int snd_soc_init_multicodec(struct snd_soc_card *card,
+				   struct snd_soc_dai_link *dai_link)
+{
+	/* Legacy codec/codec_dai link is a single entry in multicodec */
+	if (dai_link->codec_name || dai_link->codec_of_node ||
+	    dai_link->codec_dai_name) {
+		dai_link->num_codecs = 1;
+
+		dai_link->codecs = devm_kzalloc(card->dev,
+				sizeof(struct snd_soc_dai_link_component),
+				GFP_KERNEL);
+		if (!dai_link->codecs)
+			return -ENOMEM;
+
+		dai_link->codecs[0].name = dai_link->codec_name;
+		dai_link->codecs[0].of_node = dai_link->codec_of_node;
+		dai_link->codecs[0].dai_name = dai_link->codec_dai_name;
+	}
+
+	if (!dai_link->codecs) {
+		dev_err(card->dev, "ASoC: DAI link has no CODECs\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * snd_soc_register_card - Register a card with the ASoC core
  *
@@ -3716,7 +3809,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
  */
 int snd_soc_register_card(struct snd_soc_card *card)
 {
-	int i, ret;
+	int i, j, ret;
 
 	if (!card->name || !card->dev)
 		return -EINVAL;
@@ -3724,22 +3817,29 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	for (i = 0; i < card->num_links; i++) {
 		struct snd_soc_dai_link *link = &card->dai_link[i];
 
-		/*
-		 * Codec must be specified by 1 of name or OF node,
-		 * not both or neither.
-		 */
-		if (!!link->codec_name == !!link->codec_of_node) {
-			dev_err(card->dev,
-				"ASoC: Neither/both codec name/of_node are set for %s\n",
-				link->name);
-			return -EINVAL;
+		ret = snd_soc_init_multicodec(card, link);
+		if (ret) {
+			dev_err(card->dev, "ASoC: failed to init multicodec\n");
+			return ret;
 		}
-		/* Codec DAI name must be specified */
-		if (!link->codec_dai_name) {
-			dev_err(card->dev,
-				"ASoC: codec_dai_name not set for %s\n",
-				link->name);
-			return -EINVAL;
+
+		for (j = 0; j < link->num_codecs; j++) {
+			/*
+			 * Codec must be specified by 1 of name or OF node,
+			 * not both or neither.
+			 */
+			if (!!link->codecs[j].name ==
+			    !!link->codecs[j].of_node) {
+				dev_err(card->dev, "ASoC: Neither/both codec name/of_node are set for %s\n",
+					link->name);
+				return -EINVAL;
+			}
+			/* Codec DAI name must be specified */
+			if (!link->codecs[j].dai_name) {
+				dev_err(card->dev, "ASoC: codec_dai_name not set for %s\n",
+					link->name);
+				return -EINVAL;
+			}
 		}
 
 		/*
@@ -3792,8 +3892,15 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	card->num_rtd = 0;
 	card->rtd_aux = &card->rtd[card->num_links];
 
-	for (i = 0; i < card->num_links; i++)
+	for (i = 0; i < card->num_links; i++) {
 		card->rtd[i].dai_link = &card->dai_link[i];
+		card->rtd[i].codec_dais = devm_kzalloc(card->dev,
+					sizeof(struct snd_soc_dai *) *
+					(card->rtd[i].dai_link->num_codecs),
+					GFP_KERNEL);
+		if (card->rtd->codec_dais == NULL)
+			return -ENOMEM;
+	}
 
 	INIT_LIST_HEAD(&card->dapm_dirty);
 	card->instantiated = 0;
@@ -3806,10 +3913,16 @@ int snd_soc_register_card(struct snd_soc_card *card)
 
 	/* deactivate pins to sleep state */
 	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
-		struct snd_soc_dai *codec_dai = card->rtd[i].codec_dai;
-		if (!codec_dai->active)
-			pinctrl_pm_select_sleep_state(codec_dai->dev);
+		struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
+		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+		int j;
+
+		for (j = 0; j < rtd->num_codecs; j++) {
+			struct snd_soc_dai *codec_dai = rtd->codec_dais[j];
+			if (!codec_dai->active)
+				pinctrl_pm_select_sleep_state(codec_dai->dev);
+		}
+
 		if (!cpu_dai->active)
 			pinctrl_pm_select_sleep_state(cpu_dai->dev);
 	}
-- 
1.9.1
