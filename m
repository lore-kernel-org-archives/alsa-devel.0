From: Benoit Cousson <bcousson@baylibre.com>
Subject: [RFT v2 6/6] ASoC: core: Add support for DAI multicodec
Date: Fri, 21 Mar 2014 16:27:30 +0100
Message-ID: <1395415650-20045-7-git-send-email-bcousson@baylibre.com>
References: <1395415650-20045-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
 [209.85.212.178])
 by alsa0.perex.cz (Postfix) with ESMTP id CE8E126547F
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 16:28:35 +0100 (CET)
Received: by mail-wi0-f178.google.com with SMTP id bs8so625858wib.11
 for <alsa-devel@alsa-project.org>; Fri, 21 Mar 2014 08:28:35 -0700 (PDT)
In-Reply-To: <1395415650-20045-1-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: Fabien Parent <fparent@baylibre.com>, alsa-devel@alsa-project.org, lars@metafoo.de, Misael Lopez Cruz <misael.lopez@ti.com>, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

From: Misael Lopez Cruz <misael.lopez@ti.com>

DAI link assumes a one to one mapping between CPU DAI and CODEC. In
some cases, the same CPU DAI can be connected to several codecs.
This is the case for example, if you connect two mono codecs to the
same I2S link in order to have a stereo card.
The current ASoC implementation does not allow such setup.

Add support for DAI links composed of a single CPU DAI and multiple
CODECs. Sound cards have to pass the CODECs array in the corresponding
DAI link through a new 'snd_soc_dai_link_codec' struct. Each CODEC in
this array is described in the same manner single CODEC DAIs are
(either DT/OF node or codec_name).

CPU DAI in a multicodec DAI link can have more channels than what each
CODEC has. The number of channels each CODEC is responsible for is
machine specific, hence it's fixed up in machine drivers in a similar
way to what DPCM does.

Fix a trailing space in the header as well.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
[fparent@baylibre.com: Adapt to 3.14+]
Signed-off-by: Fabien Parent <fparent@baylibre.com>
[bcousson@baylibre.com: Change tdm mask fixup, add missing iteration
over codecs array]
Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---
 include/sound/soc-dai.h |   5 +
 include/sound/soc.h     |  16 ++
 sound/soc/soc-core.c    | 356 ++++++++++++++++++++++++++-------------
 sound/soc/soc-dapm.c    |  39 +++--
 sound/soc/soc-pcm.c     | 438 +++++++++++++++++++++++++++++++++---------------
 5 files changed, 596 insertions(+), 258 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 2f66d5e..5391e70 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -274,6 +274,11 @@ struct snd_soc_dai {
 	struct snd_soc_codec *codec;
 	struct snd_soc_component *component;
 
+	/* CODEC TDM slot masks and params (for fixup) */
+	unsigned int tx_mask;
+	unsigned int rx_mask;
+	struct snd_pcm_hw_params params[2];
+
 	struct snd_soc_card *card;
 
 	struct list_head list;
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0b83168..fd14ec6 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -830,6 +830,15 @@ struct snd_soc_platform_driver {
 	int (*bespoke_trigger)(struct snd_pcm_substream *, int);
 };
 
+struct snd_soc_dai_link_codec {
+	const char *codec_name;
+	const struct device_node *codec_of_node;
+	const char *codec_dai_name;
+
+	struct snd_soc_codec *codec;
+	struct snd_soc_dai *codec_dai;
+};
+
 struct snd_soc_platform {
 	const char *name;
 	int id;
@@ -878,6 +887,10 @@ struct snd_soc_dai_link {
 	const struct device_node *codec_of_node;
 	/* You MUST specify the DAI name within the codec */
 	const char *codec_dai_name;
+
+	struct snd_soc_dai_link_codec *codecs;
+	int num_codecs;
+
 	/*
 	 * You MAY specify the link's platform/PCM/DMA driver, either by
 	 * device name, or by DT/OF node, but not both. Some forms of link
@@ -1067,6 +1080,9 @@ struct snd_soc_pcm_runtime {
 	struct snd_soc_dai *codec_dai;
 	struct snd_soc_dai *cpu_dai;
 
+	struct snd_soc_dai_link_codec *codecs;
+	int num_codecs;
+
 	struct delayed_work delayed_work;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dpcm_root;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index cfa481e..6b6fc39 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -560,8 +560,9 @@ static void codec2codec_close_delayed_work(struct work_struct *work)
 int snd_soc_suspend(struct device *dev)
 {
 	struct snd_soc_card *card = dev_get_drvdata(dev);
+	struct snd_soc_dai_link_codec *codecs;
 	struct snd_soc_codec *codec;
-	int i;
+	int i, j;
 
 	/* If the initialization of this soc device failed, there is no codec
 	 * associated with it. Just bail out in this case.
@@ -581,14 +582,17 @@ int snd_soc_suspend(struct device *dev)
 
 	/* mute any active DACs */
 	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_dai *dai = card->rtd[i].codec_dai;
-		struct snd_soc_dai_driver *drv = dai->driver;
+		codecs = card->rtd[i].codecs;
+		for (j = 0; j < card->rtd[i].num_codecs; j++) {
+			struct snd_soc_dai *dai = codecs[j].codec_dai;
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
@@ -619,8 +623,12 @@ int snd_soc_suspend(struct device *dev)
 
 	/* close any waiting streams and save state */
 	for (i = 0; i < card->num_rtd; i++) {
+		codecs = card->rtd[i].codecs;
 		flush_delayed_work(&card->rtd[i].delayed_work);
-		card->rtd[i].codec->dapm.suspend_bias_level = card->rtd[i].codec->dapm.bias_level;
+		for (j = 0; j < card->rtd[i].num_codecs; j++) {
+			codecs[j].codec->dapm.suspend_bias_level =
+					codecs[j].codec->dapm.bias_level;
+		}
 	}
 
 	for (i = 0; i < card->num_rtd; i++) {
@@ -704,7 +712,7 @@ static void soc_resume_deferred(struct work_struct *work)
 	struct snd_soc_card *card =
 			container_of(work, struct snd_soc_card, deferred_resume_work);
 	struct snd_soc_codec *codec;
-	int i;
+	int i, j;
 
 	/* our power state is still SNDRV_CTL_POWER_D3hot from suspend time,
 	 * so userspace apps are blocked from touching us
@@ -765,14 +773,18 @@ static void soc_resume_deferred(struct work_struct *work)
 
 	/* unmute any active DACs */
 	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_dai *dai = card->rtd[i].codec_dai;
-		struct snd_soc_dai_driver *drv = dai->driver;
+		struct snd_soc_dai_link_codec *codecs = card->rtd[i].codecs;
 
-		if (card->rtd[i].dai_link->ignore_suspend)
-			continue;
+		for (j = 0; j < card->rtd[i].num_codecs; j++) {
+			struct snd_soc_dai *dai = codecs[j].codec_dai;
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
@@ -817,12 +829,19 @@ int snd_soc_resume(struct device *dev)
 
 	/* activate pins from sleep state */
 	for (i = 0; i < card->num_rtd; i++) {
-		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
-		struct snd_soc_dai *codec_dai = card->rtd[i].codec_dai;
+		struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
+		struct snd_soc_dai_link_codec *codecs = rtd->codecs;
+		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+		int j;
+
 		if (cpu_dai->active)
 			pinctrl_pm_select_default_state(cpu_dai->dev);
-		if (codec_dai->active)
-			pinctrl_pm_select_default_state(codec_dai->dev);
+
+		for (j = 0; j < rtd->num_codecs; j++) {
+			struct snd_soc_dai *codec_dai = codecs[j].codec_dai;
+			if (codec_dai->active)
+				pinctrl_pm_select_default_state(codec_dai->dev);
+		}
 	}
 
 	/* AC97 devices might have other drivers hanging off them so
@@ -854,8 +873,9 @@ EXPORT_SYMBOL_GPL(snd_soc_resume);
 static const struct snd_soc_dai_ops null_dai_ops = {
 };
 
-static struct snd_soc_codec *soc_find_codec(const struct device_node *codec_of_node,
-					    const char *codec_name)
+static struct snd_soc_codec *soc_find_codec(
+					const struct device_node *codec_of_node,
+					const char *codec_name)
 {
 	struct snd_soc_codec *codec;
 
@@ -893,9 +913,11 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
 	struct snd_soc_component *component;
+	struct snd_soc_dai_link_codec *codecs = dai_link->codecs;
 	struct snd_soc_platform *platform;
 	struct snd_soc_dai *cpu_dai;
 	const char *platform_name;
+	int i;
 
 	dev_dbg(card->dev, "ASoC: binding %s at idx %d\n", dai_link->name, num);
 
@@ -922,24 +944,35 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 		return -EPROBE_DEFER;
 	}
 
-	/* Find CODEC from registered list */
-	rtd->codec = soc_find_codec(dai_link->codec_of_node,
-				    dai_link->codec_name);
-	if (!rtd->codec) {
-		dev_err(card->dev, "ASoC: CODEC %s not registered\n",
-			dai_link->codec_name);
-		return -EPROBE_DEFER;
+	rtd->num_codecs = dai_link->num_codecs;
+	rtd->codecs = dai_link->codecs;
+
+	/* Find CODEC from registered CODECs */
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codecs[i].codec = soc_find_codec(codecs[i].codec_of_node,
+						 codecs[i].codec_name);
+		if (!codecs[i].codec) {
+			dev_err(card->dev, "ASoC: CODEC %s not registered\n",
+				codecs[i].codec_name);
+			return -EPROBE_DEFER;
+		}
 	}
 
-	/* Find CODEC DAI from registered list */
-	rtd->codec_dai = soc_find_codec_dai(rtd->codec,
-					    dai_link->codec_dai_name);
-	if (!rtd->codec_dai) {
-		dev_err(card->dev, "ASoC: CODEC DAI %s not registered\n",
-			dai_link->codec_dai_name);
-		return -EPROBE_DEFER;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codecs[i].codec_dai = soc_find_codec_dai(
+						codecs[i].codec,
+						codecs[i].codec_dai_name);
+		if (!codecs[i].codec_dai) {
+			dev_err(card->dev, "ASoC: CODEC DAI %s not registered\n",
+				codecs[i].codec_dai_name);
+			return -EPROBE_DEFER;
+		}
 	}
 
+	/* Single codec links expect codec and codec_dai in runtime data */
+	rtd->codec = codecs[0].codec;
+	rtd->codec_dai = codecs[0].codec_dai;
+
 	/* if there's no platform we match on the empty platform */
 	platform_name = dai_link->platform_name;
 	if (!platform_name && !dai_link->platform_of_node)
@@ -1031,8 +1064,8 @@ static void soc_remove_codec_dai(struct snd_soc_dai *codec_dai, int order)
 static void soc_remove_link_dais(struct snd_soc_card *card, int num, int order)
 {
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
-	struct snd_soc_dai *codec_dai = rtd->codec_dai, *cpu_dai = rtd->cpu_dai;
-	int err;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int i, err;
 
 	/* unregister the rtd device */
 	if (rtd->dev_registered) {
@@ -1043,7 +1076,8 @@ static void soc_remove_link_dais(struct snd_soc_card *card, int num, int order)
 	}
 
 	/* remove the CODEC DAI */
-	soc_remove_codec_dai(codec_dai, order);
+	for (i = 0; i < rtd->num_codecs; i++)
+		soc_remove_codec_dai(rtd->codecs[i].codec_dai, order);
 
 	/* remove the cpu_dai */
 	if (cpu_dai && cpu_dai->probed &&
@@ -1070,9 +1104,9 @@ static void soc_remove_link_components(struct snd_soc_card *card, int num,
 {
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_codec *codec;
+	int i;
 
 	/* remove the platform */
 	if (platform && platform->probed &&
@@ -1081,8 +1115,8 @@ static void soc_remove_link_components(struct snd_soc_card *card, int num,
 	}
 
 	/* remove the CODEC-side CODEC */
-	if (codec_dai) {
-		codec = codec_dai->codec;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec = rtd->codecs[i].codec;
 		if (codec && codec->probed &&
 		    codec->driver->remove_order == order)
 			soc_remove_codec(codec);
@@ -1268,17 +1302,20 @@ static void rtd_release(struct device *dev)
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
 	const char *temp;
 	int ret;
 
 	rtd->card = card;
 
+	codec = soc_find_codec(NULL, aux_dev->codec_name);
+	if (!codec)
+		return -EPROBE_DEFER;
+
 	temp = codec->name_prefix;
 	codec->name_prefix = NULL;
 
@@ -1296,20 +1333,29 @@ static int soc_aux_dev_init(struct snd_soc_card *card,
 	return 0;
 }
 
-static int soc_dai_link_init(struct snd_soc_card *card,
-			     struct snd_soc_codec *codec,
-			     int num)
+static int soc_dai_link_init(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_dai_link *dai_link =  &card->dai_link[num];
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
-	const char *temp;
-	int ret;
+	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
+	const char **temp;
+	int i, ret;
 
 	rtd->card = card;
 
-	/* machine controls, routes and widgets are not prefixed */
-	temp = codec->name_prefix;
-	codec->name_prefix = NULL;
+	temp = devm_kzalloc(card->dev, rtd->num_codecs * sizeof(char *),
+			    GFP_KERNEL);
+	if (!temp)
+		return -ENOMEM;
+
+	for (i = 0; i < rtd->num_codecs; i++) {
+		/* Make sure all DAPM widgets are instantiated */
+		snd_soc_dapm_new_widgets(codecs[i].codec->dapm.card);
+
+		/* machine controls, routes and widgets are not prefixed */
+		temp[i] = codecs[i].codec->name_prefix;
+		codecs[i].codec->name_prefix = NULL;
+	}
 
 	/* do machine specific initialization */
 	if (dai_link->init) {
@@ -1318,15 +1364,15 @@ static int soc_dai_link_init(struct snd_soc_card *card,
 			return ret;
 	}
 
-	codec->name_prefix = temp;
+	for (i = 0; i < rtd->num_codecs; i++)
+		codecs[i].codec->name_prefix = temp[i];
 
-	rtd->codec = codec;
+	devm_kfree(card->dev, temp);
 
 	return 0;
 }
 
 static int soc_post_component_init(struct snd_soc_card *card,
-				   struct snd_soc_codec *codec,
 				   int num, int dailess)
 {
 	struct snd_soc_dai_link *dai_link = NULL;
@@ -1339,12 +1385,12 @@ static int soc_post_component_init(struct snd_soc_card *card,
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
@@ -1370,7 +1416,7 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	if (ret < 0) {
 		/* calling put_device() here to free the rtd->dev */
 		put_device(rtd->dev);
-		dev_err(card->dev,
+		dev_err(rtd->dev,
 			"ASoC: failed to register runtime device: %d\n", ret);
 		return ret;
 	}
@@ -1379,13 +1425,13 @@ static int soc_post_component_init(struct snd_soc_card *card,
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
@@ -1407,9 +1453,9 @@ static int soc_probe_link_components(struct snd_soc_card *card, int num,
 {
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
 	struct snd_soc_platform *platform = rtd->platform;
-	int ret;
+	int i, ret;
 
 	/* probe the CPU-side component, if it is a CODEC */
 	if (cpu_dai->codec &&
@@ -1420,12 +1466,14 @@ static int soc_probe_link_components(struct snd_soc_card *card, int num,
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
+		if (!codecs[i].codec->probed &&
+		    codecs[i].codec->driver->probe_order == order) {
+			ret = soc_probe_codec(card, codecs[i].codec);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	/* probe the platform */
@@ -1504,19 +1552,19 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 {
 	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
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
+		codecs[i].codec_dai->card = card;
 
 	/* set default power off timeout */
 	rtd->pmdown_time = pmdown_time;
@@ -1548,15 +1596,17 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 	}
 
 	/* probe the CODEC DAI */
-	ret = soc_probe_codec_dai(card, codec_dai, order);
-	if (ret)
-		return ret;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		ret = soc_probe_codec_dai(card, codecs[i].codec_dai, order);
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
 
@@ -1588,16 +1638,21 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 						codec2codec_close_delayed_work);
 
 			/* link the DAI widgets */
-			ret = soc_link_dai_widgets(card, dai_link,
-					cpu_dai, codec_dai);
-			if (ret)
-				return ret;
+			for (i = 0; i < rtd->num_codecs; i++) {
+				ret = soc_link_dai_widgets(card, dai_link,
+						cpu_dai, codecs[i].codec_dai);
+				if (ret)
+					return ret;
+			}
 		}
 	}
 
 	/* add platform data for AC97 devices */
-	if (rtd->codec_dai->driver->ac97_control)
-		snd_ac97_dev_add_pdata(codec->ac97, rtd->cpu_dai->ac97_pdata);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		if (codecs[i].codec_dai->driver->ac97_control)
+			snd_ac97_dev_add_pdata(codecs[i].codec->ac97,
+					       rtd->cpu_dai->ac97_pdata);
+	}
 
 	return 0;
 }
@@ -1637,7 +1692,19 @@ static int soc_register_ac97_codec(struct snd_soc_codec *codec,
 
 static int soc_register_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
 {
-	return soc_register_ac97_codec(rtd->codec, rtd->codec_dai);
+	int i, ret;
+
+	for (i = 0; i < rtd->num_codecs; i++) {
+		ret = soc_register_ac97_codec(rtd->codecs[i].codec,
+					      rtd->codecs[i].codec_dai);
+		if (ret) {
+			while (--i >= 0)
+				soc_unregister_ac97_codec(rtd->codecs[i].codec);
+			return ret;
+		}
+	}
+
+	return 0;
 }
 
 static void soc_unregister_ac97_codec(struct snd_soc_codec *codec)
@@ -1650,7 +1717,10 @@ static void soc_unregister_ac97_codec(struct snd_soc_codec *codec)
 
 static void soc_unregister_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
 {
-	soc_unregister_ac97_codec(rtd->codec);
+	int i;
+
+	for (i = 0; i < rtd->num_codecs; i++)
+		soc_unregister_ac97_codec(rtd->codecs[i].codec);
 }
 #endif
 
@@ -1697,7 +1767,7 @@ found:
 	if (ret < 0)
 		return ret;
 
-	ret = soc_post_component_init(card, codec, num, 1);
+	ret = soc_post_component_init(card, num, 1);
 
 out:
 	return ret;
@@ -1853,16 +1923,22 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
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
+			struct snd_soc_dai_link_codec *codecs = rtd->codecs;
+			int j;
+
+			for (j = 0; j < rtd->num_codecs; j++) {
+				ret = snd_soc_dai_set_fmt(codecs[j].codec_dai,
+							  dai_fmt);
+				if (ret != 0 && ret != -ENOTSUPP)
+					dev_warn(codecs[j].codec_dai->dev,
+						 "ASoC: Failed to set DAI format: %d\n",
+						 ret);
+			}
 		}
 
 		/* If this is a regular CPU link there will be a platform */
@@ -2063,9 +2139,14 @@ int snd_soc_poweroff(struct device *dev)
 	/* deactivate pins to sleep state */
 	for (i = 0; i < card->num_rtd; i++) {
 		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
-		struct snd_soc_dai *codec_dai = card->rtd[i].codec_dai;
-		pinctrl_pm_select_sleep_state(codec_dai->dev);
+		struct snd_soc_dai_link_codec *codecs = card->rtd[i].codecs;
+		int j;
+
 		pinctrl_pm_select_sleep_state(cpu_dai->dev);
+		for (j = 0; j < card->rtd[i].num_codecs; j++) {
+			struct snd_soc_dai *codec_dai = codecs[j].codec_dai;
+			pinctrl_pm_select_sleep_state(codec_dai->dev);
+		}
 	}
 
 	return 0;
@@ -3770,17 +3851,26 @@ static int snd_soc_of_xlate_tdm_slot_mask(unsigned int slots,
 int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
 {
+	int ret = 0;
+
 	if (dai->driver && dai->driver->ops->of_xlate_tdm_slot_mask)
 		dai->driver->ops->of_xlate_tdm_slot_mask(slots,
 						&tx_mask, &rx_mask);
 	else
 		snd_soc_of_xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
 
+	if (dai->codec) {
+		dai->tx_mask = tx_mask;
+		dai->rx_mask = rx_mask;
+	}
+
 	if (dai->driver && dai->driver->ops->set_tdm_slot)
-		return dai->driver->ops->set_tdm_slot(dai, tx_mask, rx_mask,
+		ret = dai->driver->ops->set_tdm_slot(dai, tx_mask, rx_mask,
 				slots, slot_width);
 	else
 		return -ENOTSUPP;
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_set_tdm_slot);
 
@@ -3848,6 +3938,33 @@ int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute,
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
+					sizeof(struct snd_soc_dai_link_codec),
+					GFP_KERNEL);
+		if (!dai_link->codecs)
+			return -ENOMEM;
+
+		dai_link->codecs[0].codec_name = dai_link->codec_name;
+		dai_link->codecs[0].codec_of_node = dai_link->codec_of_node;
+		dai_link->codecs[0].codec_dai_name = dai_link->codec_dai_name;
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
@@ -3856,7 +3973,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
  */
 int snd_soc_register_card(struct snd_soc_card *card)
 {
-	int i, ret;
+	int i, j, ret;
 
 	if (!card->name || !card->dev)
 		return -EINVAL;
@@ -3864,22 +3981,29 @@ int snd_soc_register_card(struct snd_soc_card *card)
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
+			if (!!link->codecs[j].codec_name ==
+			    !!link->codecs[j].codec_of_node) {
+				dev_err(card->dev, "ASoC: Neither/both codec name/of_node are set for %s\n",
+					link->name);
+				return -EINVAL;
+			}
+			/* Codec DAI name must be specified */
+			if (!link->codecs[j].codec_dai_name) {
+				dev_err(card->dev, "ASoC: codec_dai_name not set for %s\n",
+					link->name);
+				return -EINVAL;
+			}
 		}
 
 		/*
@@ -3948,9 +4072,15 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	/* deactivate pins to sleep state */
 	for (i = 0; i < card->num_rtd; i++) {
 		struct snd_soc_dai *cpu_dai = card->rtd[i].cpu_dai;
-		struct snd_soc_dai *codec_dai = card->rtd[i].codec_dai;
-		if (!codec_dai->active)
-			pinctrl_pm_select_sleep_state(codec_dai->dev);
+		struct snd_soc_dai_link_codec *codecs = card->rtd[i].codecs;
+		int j;
+
+		for (j = 0; j < card->rtd[i].num_codecs; j++) {
+			struct snd_soc_dai *codec_dai = codecs[j].codec_dai;
+			if (!codec_dai->active)
+				pinctrl_pm_select_sleep_state(codec_dai->dev);
+		}
+
 		if (!cpu_dai->active)
 			pinctrl_pm_select_sleep_state(cpu_dai->dev);
 	}
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c8a780d..6c6b7bea 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2143,12 +2143,8 @@ int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_context *dapm,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_mixer_update_power);
 
-/* show dapm widget status in sys fs */
-static ssize_t dapm_widget_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
+static ssize_t dapm_widget_show_codec(struct snd_soc_codec *codec, char *buf)
 {
-	struct snd_soc_pcm_runtime *rtd = dev_get_drvdata(dev);
-	struct snd_soc_codec *codec =rtd->codec;
 	struct snd_soc_dapm_widget *w;
 	int count = 0;
 	char *state = "not set";
@@ -2201,6 +2197,22 @@ static ssize_t dapm_widget_show(struct device *dev,
 	return count;
 }
 
+/* show dapm widget status in sys fs */
+static ssize_t dapm_widget_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct snd_soc_pcm_runtime *rtd = dev_get_drvdata(dev);
+	struct snd_soc_codec *codec;
+	int i, count = 0;
+
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec = rtd->codecs[i].codec;
+		count += dapm_widget_show_codec(codec, buf + count);
+	}
+
+	return count;
+}
+
 static DEVICE_ATTR(dapm_widget, 0444, dapm_widget_show, NULL);
 
 int snd_soc_dapm_sys_add(struct device *dev)
@@ -3510,13 +3522,12 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
 	}
 }
 
-static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
-	int event)
+static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd,
+				  struct snd_soc_dai *cpu_dai,
+				  struct snd_soc_dai *codec_dai,
+				  int stream, int event)
 {
-
 	struct snd_soc_dapm_widget *w_cpu, *w_codec;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		w_cpu = cpu_dai->playback_widget;
@@ -3582,9 +3593,15 @@ void snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
 			      int event)
 {
 	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai;
+	int i;
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
-	soc_dapm_stream_event(rtd, stream, event);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = rtd->codecs[i].codec_dai;
+		soc_dapm_stream_event(rtd, cpu_dai, codec_dai, stream, event);
+	}
 	mutex_unlock(&card->dapm_mutex);
 }
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 330eaf0..01d6dd0 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -7,7 +7,7 @@
  * Copyright (C) 2010 Texas Instruments Inc.
  *
  * Authors: Liam Girdwood <lrg@ti.com>
- *          Mark Brown <broonie@opensource.wolfsonmicro.com>       
+ *          Mark Brown <broonie@opensource.wolfsonmicro.com>
  *
  *  This program is free software; you can redistribute  it and/or modify it
  *  under  the terms of  the GNU General  Public License as published by the
@@ -47,22 +47,27 @@
 void snd_soc_runtime_activate(struct snd_soc_pcm_runtime *rtd, int stream)
 {
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
+	int i;
 
 	lockdep_assert_held(&rtd->pcm_mutex);
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		cpu_dai->playback_active++;
-		codec_dai->playback_active++;
+		for (i = 0; i < rtd->num_codecs; i++)
+			codecs[i].codec_dai->playback_active++;
 	} else {
 		cpu_dai->capture_active++;
-		codec_dai->capture_active++;
+		for (i = 0; i < rtd->num_codecs; i++)
+			codecs[i].codec_dai->capture_active++;
 	}
 
 	cpu_dai->active++;
-	codec_dai->active++;
 	cpu_dai->component->active++;
-	codec_dai->component->active++;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codecs[i].codec_dai->active++;
+		codecs[i].codec_dai->component->active++;
+	}
 }
 
 /**
@@ -78,24 +83,30 @@ void snd_soc_runtime_activate(struct snd_soc_pcm_runtime *rtd, int stream)
 void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream)
 {
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
+	int i;
 
 	lockdep_assert_held(&rtd->pcm_mutex);
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		cpu_dai->playback_active--;
-		codec_dai->playback_active--;
+		for (i = 0; i < rtd->num_codecs; i++)
+			codecs[i].codec_dai->playback_active--;
 	} else {
 		cpu_dai->capture_active--;
-		codec_dai->capture_active--;
+		for (i = 0; i < rtd->num_codecs; i++)
+			codecs[i].codec_dai->capture_active--;
 	}
 
 	cpu_dai->active--;
-	codec_dai->active--;
 	cpu_dai->component->active--;
-	codec_dai->component->active--;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codecs[i].codec_dai->component->active--;
+		codecs[i].codec_dai->active--;
+	}
 }
 
+
 /**
  * snd_soc_runtime_ignore_pmdown_time() - Check whether to ignore the power down delay
  * @rtd: The ASoC PCM runtime that should be checked.
@@ -107,11 +118,16 @@ void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream)
  */
 bool snd_soc_runtime_ignore_pmdown_time(struct snd_soc_pcm_runtime *rtd)
 {
+	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
+	int i, ignore = 0;
+
 	if (!rtd->pmdown_time || rtd->dai_link->ignore_pmdown_time)
 		return true;
 
-	return rtd->cpu_dai->component->ignore_pmdown_time &&
-			rtd->codec_dai->component->ignore_pmdown_time;
+	for (i = 0; (i < rtd->num_codecs) && !ignore; i++)
+		ignore |= codecs[i].codec_dai->component->ignore_pmdown_time;
+
+	return rtd->cpu_dai->component->ignore_pmdown_time && ignore;
 }
 
 /**
@@ -310,32 +326,66 @@ static void soc_pcm_apply_msb(struct snd_pcm_substream *substream,
 	}
 }
 
-static void soc_pcm_init_runtime_hw(struct snd_pcm_runtime *runtime,
-	struct snd_soc_pcm_stream *codec_stream,
-	struct snd_soc_pcm_stream *cpu_stream)
+static void soc_pcm_init_runtime_hw(struct snd_pcm_substream *substream)
 {
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_pcm_hardware *hw = &runtime->hw;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai_driver *cpu_dai_drv = rtd->cpu_dai->driver;
+	struct snd_soc_dai_driver *codec_dai_drv;
+	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
+	struct snd_soc_pcm_stream *codec_stream;
+	struct snd_soc_pcm_stream *cpu_stream;
+	unsigned int chan_min = 0, chan_max = UINT_MAX;
+	unsigned int rate_min = 0, rate_max = UINT_MAX;
+	unsigned int rates = UINT_MAX;
+	u64 formats = ULLONG_MAX;
+	int i;
 
-	hw->channels_min = max(codec_stream->channels_min,
-		cpu_stream->channels_min);
-	hw->channels_max = min(codec_stream->channels_max,
-		cpu_stream->channels_max);
-	if (hw->formats)
-		hw->formats &= codec_stream->formats & cpu_stream->formats;
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		cpu_stream = &cpu_dai_drv->playback;
 	else
-		hw->formats = codec_stream->formats & cpu_stream->formats;
-	hw->rates = snd_pcm_rate_mask_intersect(codec_stream->rates,
-		cpu_stream->rates);
+		cpu_stream = &cpu_dai_drv->capture;
 
-	hw->rate_min = 0;
-	hw->rate_max = UINT_MAX;
+	/* first calculate min/max only for CODECs in the DAI link */
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai_drv = codecs[i].codec_dai->driver;
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			codec_stream = &codec_dai_drv->playback;
+		else
+			codec_stream = &codec_dai_drv->capture;
+		chan_min = max(chan_min, codec_stream->channels_min);
+		chan_max = min(chan_max, codec_stream->channels_max);
+		rate_min = max(rate_min, codec_stream->rate_min);
+		rate_max = min_not_zero(rate_max, codec_stream->rate_max);
+		formats &= codec_stream->formats;
+		rates = snd_pcm_rate_mask_intersect(codec_stream->rates, rates);
+	}
+
+	/*
+	 * chan min/max cannot be enforced if there are multiple CODEC DAIs
+	 * connected to a single CPU DAI, use CPU DAI's directly and let
+	 * channel allocation be fixed up later
+	 */
+	if (rtd->num_codecs > 1) {
+		chan_min = cpu_stream->channels_min;
+		chan_max = cpu_stream->channels_max;
+	}
+
+	hw->channels_min = max(chan_min, cpu_stream->channels_min);
+	hw->channels_max = min(chan_max, cpu_stream->channels_max);
+	if (hw->formats)
+		hw->formats &= formats & cpu_stream->formats;
+	else
+		hw->formats = formats & cpu_stream->formats;
+	hw->rates = snd_pcm_rate_mask_intersect(rates, cpu_stream->rates);
 
 	snd_pcm_limit_hw_rates(runtime);
 
 	hw->rate_min = max(hw->rate_min, cpu_stream->rate_min);
-	hw->rate_min = max(hw->rate_min, codec_stream->rate_min);
+	hw->rate_min = max(hw->rate_min, rate_min);
 	hw->rate_max = min_not_zero(hw->rate_max, cpu_stream->rate_max);
-	hw->rate_max = min_not_zero(hw->rate_max, codec_stream->rate_max);
+	hw->rate_max = min_not_zero(hw->rate_max, rate_max);
 }
 
 /*
@@ -348,16 +398,18 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai_driver *cpu_dai_drv = cpu_dai->driver;
-	struct snd_soc_dai_driver *codec_dai_drv = codec_dai->driver;
-	int ret = 0;
+	struct snd_soc_dai *codec_dai;
+	const char *codec_dai_name = "multicodec";
+	int i, ret = 0;
 
 	pinctrl_pm_select_default_state(cpu_dai->dev);
-	pinctrl_pm_select_default_state(codec_dai->dev);
+	for (i = 0; i < rtd->num_codecs; i++)
+		pinctrl_pm_select_default_state(codecs[i].codec_dai->dev);
 	pm_runtime_get_sync(cpu_dai->dev);
-	pm_runtime_get_sync(codec_dai->dev);
+	for (i = 0; i < rtd->num_codecs; i++)
+		pm_runtime_get_sync(codecs[i].codec_dai->dev);
 	pm_runtime_get_sync(platform->dev);
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
@@ -381,13 +433,23 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		}
 	}
 
-	if (codec_dai->driver->ops && codec_dai->driver->ops->startup) {
-		ret = codec_dai->driver->ops->startup(substream, codec_dai);
-		if (ret < 0) {
-			dev_err(codec_dai->dev, "ASoC: can't open codec"
-				" %s: %d\n", codec_dai->name, ret);
-			goto codec_dai_err;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = codecs[i].codec_dai;
+		if (codec_dai->driver->ops && codec_dai->driver->ops->startup) {
+			ret = codec_dai->driver->ops->startup(substream,
+							      codec_dai);
+			if (ret < 0) {
+				dev_err(codec_dai->dev,
+					"ASoC: can't open codec %s: %d\n",
+					codec_dai->name, ret);
+				goto codec_dai_err;
+			}
 		}
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			codec_dai->tx_mask = 0;
+		else
+			codec_dai->rx_mask = 0;
 	}
 
 	if (rtd->dai_link->ops && rtd->dai_link->ops->startup) {
@@ -404,13 +466,10 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		goto dynamic;
 
 	/* Check that the codec and cpu DAIs are compatible */
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		soc_pcm_init_runtime_hw(runtime, &codec_dai_drv->playback,
-			&cpu_dai_drv->playback);
-	} else {
-		soc_pcm_init_runtime_hw(runtime, &codec_dai_drv->capture,
-			&cpu_dai_drv->capture);
-	}
+	soc_pcm_init_runtime_hw(substream);
+
+	if (rtd->num_codecs == 1)
+		codec_dai_name = rtd->codec_dai->name;
 
 	if (soc_pcm_has_symmetry(substream))
 		runtime->hw.info |= SNDRV_PCM_INFO_JOINT_DUPLEX;
@@ -418,22 +477,22 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	ret = -EINVAL;
 	if (!runtime->hw.rates) {
 		printk(KERN_ERR "ASoC: %s <-> %s No matching rates\n",
-			codec_dai->name, cpu_dai->name);
+			codec_dai_name, cpu_dai->name);
 		goto config_err;
 	}
 	if (!runtime->hw.formats) {
 		printk(KERN_ERR "ASoC: %s <-> %s No matching formats\n",
-			codec_dai->name, cpu_dai->name);
+			codec_dai_name, cpu_dai->name);
 		goto config_err;
 	}
 	if (!runtime->hw.channels_min || !runtime->hw.channels_max ||
 	    runtime->hw.channels_min > runtime->hw.channels_max) {
 		printk(KERN_ERR "ASoC: %s <-> %s No matching channels\n",
-				codec_dai->name, cpu_dai->name);
+				codec_dai_name, cpu_dai->name);
 		goto config_err;
 	}
 
-	soc_pcm_apply_msb(substream, codec_dai);
+	soc_pcm_apply_msb(substream, codecs[0].codec_dai);
 	soc_pcm_apply_msb(substream, cpu_dai);
 
 	/* Symmetry only applies if we've already got an active stream. */
@@ -443,14 +502,17 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 			goto config_err;
 	}
 
-	if (codec_dai->active) {
-		ret = soc_pcm_apply_symmetry(substream, codec_dai);
-		if (ret != 0)
-			goto config_err;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		if (codecs[i].codec_dai->active) {
+			ret = soc_pcm_apply_symmetry(substream,
+						     codecs[i].codec_dai);
+			if (ret != 0)
+				goto config_err;
+		}
 	}
 
 	pr_debug("ASoC: %s <-> %s info:\n",
-			codec_dai->name, cpu_dai->name);
+			codec_dai_name, cpu_dai->name);
 	pr_debug("ASoC: rate mask 0x%x\n", runtime->hw.rates);
 	pr_debug("ASoC: min ch %d max ch %d\n", runtime->hw.channels_min,
 		 runtime->hw.channels_max);
@@ -469,10 +531,15 @@ config_err:
 		rtd->dai_link->ops->shutdown(substream);
 
 machine_err:
-	if (codec_dai->driver->ops->shutdown)
-		codec_dai->driver->ops->shutdown(substream, codec_dai);
+	i = rtd->num_codecs;
 
 codec_dai_err:
+	while (--i >= 0) {
+		codec_dai = codecs[i].codec_dai;
+		if (codec_dai->driver->ops->shutdown)
+			codec_dai->driver->ops->shutdown(substream, codec_dai);
+	}
+
 	if (platform->driver->ops && platform->driver->ops->close)
 		platform->driver->ops->close(substream);
 
@@ -483,10 +550,13 @@ out:
 	mutex_unlock(&rtd->pcm_mutex);
 
 	pm_runtime_put(platform->dev);
-	pm_runtime_put(codec_dai->dev);
+	for (i = 0; i < rtd->num_codecs; i++)
+		pm_runtime_put(codecs[i].codec_dai->dev);
 	pm_runtime_put(cpu_dai->dev);
-	if (!codec_dai->active)
-		pinctrl_pm_select_sleep_state(codec_dai->dev);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		if (!codecs[i].codec_dai->active)
+			pinctrl_pm_select_sleep_state(codecs[i].codec_dai->dev);
+	}
 	if (!cpu_dai->active)
 		pinctrl_pm_select_sleep_state(cpu_dai->dev);
 
@@ -502,7 +572,7 @@ static void close_delayed_work(struct work_struct *work)
 {
 	struct snd_soc_pcm_runtime *rtd =
 			container_of(work, struct snd_soc_pcm_runtime, delayed_work.work);
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *codec_dai = rtd->codecs[0].codec_dai;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -530,8 +600,10 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *codec_dai;
+	int i;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -541,14 +613,20 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	if (!cpu_dai->active)
 		cpu_dai->rate = 0;
 
-	if (!codec_dai->active)
-		codec_dai->rate = 0;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = codecs[i].codec_dai;
+		if (!codec_dai->active)
+			codec_dai->rate = 0;
+	}
 
 	if (cpu_dai->driver->ops->shutdown)
 		cpu_dai->driver->ops->shutdown(substream, cpu_dai);
 
-	if (codec_dai->driver->ops->shutdown)
-		codec_dai->driver->ops->shutdown(substream, codec_dai);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = codecs[i].codec_dai;
+		if (codec_dai->driver->ops->shutdown)
+			codec_dai->driver->ops->shutdown(substream, codec_dai);
+	}
 
 	if (rtd->dai_link->ops && rtd->dai_link->ops->shutdown)
 		rtd->dai_link->ops->shutdown(substream);
@@ -579,10 +657,13 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	mutex_unlock(&rtd->pcm_mutex);
 
 	pm_runtime_put(platform->dev);
-	pm_runtime_put(codec_dai->dev);
+	for (i = 0; i < rtd->num_codecs; i++)
+		pm_runtime_put(codecs[i].codec_dai->dev);
 	pm_runtime_put(cpu_dai->dev);
-	if (!codec_dai->active)
-		pinctrl_pm_select_sleep_state(codec_dai->dev);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		if (!codecs[i].codec_dai->active)
+			pinctrl_pm_select_sleep_state(codecs[i].codec_dai->dev);
+	}
 	if (!cpu_dai->active)
 		pinctrl_pm_select_sleep_state(cpu_dai->dev);
 
@@ -598,9 +679,10 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret = 0;
+	struct snd_soc_dai *codec_dai;
+	int i, ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -622,12 +704,16 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 		}
 	}
 
-	if (codec_dai->driver->ops && codec_dai->driver->ops->prepare) {
-		ret = codec_dai->driver->ops->prepare(substream, codec_dai);
-		if (ret < 0) {
-			dev_err(codec_dai->dev, "ASoC: DAI prepare error: %d\n",
-				ret);
-			goto out;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = codecs[i].codec_dai;
+		if (codec_dai->driver->ops && codec_dai->driver->ops->prepare) {
+			ret = codec_dai->driver->ops->prepare(substream,
+							      codec_dai);
+			if (ret < 0) {
+				dev_err(codec_dai->dev,
+					"ASoC: DAI prepare error: %d\n", ret);
+				goto out;
+			}
 		}
 	}
 
@@ -650,13 +736,26 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	snd_soc_dapm_stream_event(rtd, substream->stream,
 			SND_SOC_DAPM_STREAM_START);
 
-	snd_soc_dai_digital_mute(codec_dai, 0, substream->stream);
+	for (i = 0; i < rtd->num_codecs; i++)
+		snd_soc_dai_digital_mute(codecs[i].codec_dai, 0,
+					 substream->stream);
 
 out:
 	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
 }
 
+static void soc_pcm_codec_params_fixup(struct snd_pcm_hw_params *params,
+				       unsigned int mask)
+{
+	struct snd_interval *interval;
+	int channels = hweight_long(mask);
+
+	interval = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	interval->min = channels;
+	interval->max = channels;
+}
+
 /*
  * Called by ALSA when the hardware params are set by application. This
  * function can also be called multiple times and can allocate buffers
@@ -667,9 +766,9 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret = 0;
+	int i, ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -686,13 +785,39 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	if (codec_dai->driver->ops && codec_dai->driver->ops->hw_params) {
-		ret = codec_dai->driver->ops->hw_params(substream, params, codec_dai);
-		if (ret < 0) {
-			dev_err(codec_dai->dev, "ASoC: can't set %s hw params:"
-				" %d\n", codec_dai->name, ret);
-			goto codec_err;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_soc_dai *codec_dai = codecs[i].codec_dai;
+		struct snd_pcm_hw_params *codec_params;
+
+		codec_params = &codec_dai->params[substream->stream];
+
+		/* copy params for each codec */
+		memcpy(codec_params, params, sizeof(struct snd_pcm_hw_params));
+
+		/* fixup params based on TDM slot masks */
+		if (codec_dai->tx_mask)
+			soc_pcm_codec_params_fixup(codec_params,
+						   codec_dai->tx_mask);
+		if (codec_dai->rx_mask)
+			soc_pcm_codec_params_fixup(codec_params,
+						   codec_dai->rx_mask);
+
+		if (codec_dai->driver->ops &&
+		    codec_dai->driver->ops->hw_params) {
+			ret = codec_dai->driver->ops->hw_params(substream,
+						codec_params, codec_dai);
+			if (ret < 0) {
+				dev_err(codec_dai->dev,
+					"ASoC: can't set %s hw params: %d\n",
+					codec_dai->name, ret);
+				goto codec_err;
+			}
 		}
+
+		codec_dai->rate = params_rate(codec_params);
+		codec_dai->channels = params_channels(codec_params);
+		codec_dai->sample_bits = snd_pcm_format_physical_width(
+						params_format(codec_params));
 	}
 
 	if (cpu_dai->driver->ops && cpu_dai->driver->ops->hw_params) {
@@ -719,11 +844,6 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	cpu_dai->sample_bits =
 		snd_pcm_format_physical_width(params_format(params));
 
-	codec_dai->rate = params_rate(params);
-	codec_dai->channels = params_channels(params);
-	codec_dai->sample_bits =
-		snd_pcm_format_physical_width(params_format(params));
-
 out:
 	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
@@ -733,10 +853,16 @@ platform_err:
 		cpu_dai->driver->ops->hw_free(substream, cpu_dai);
 
 interface_err:
-	if (codec_dai->driver->ops && codec_dai->driver->ops->hw_free)
-		codec_dai->driver->ops->hw_free(substream, codec_dai);
+	i = rtd->num_codecs;
 
 codec_err:
+	while (--i >= 0) {
+		struct snd_soc_dai *codec_dai = codecs[i].codec_dai;
+		if (codec_dai->driver->ops && codec_dai->driver->ops->hw_free)
+			codec_dai->driver->ops->hw_free(substream, codec_dai);
+		codec_dai->rate = 0;
+	}
+
 	if (rtd->dai_link->ops && rtd->dai_link->ops->hw_free)
 		rtd->dai_link->ops->hw_free(substream);
 
@@ -751,9 +877,11 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *codec_dai;
 	bool playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
+	int i;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -764,16 +892,21 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 		cpu_dai->sample_bits = 0;
 	}
 
-	if (codec_dai->active == 1) {
-		codec_dai->rate = 0;
-		codec_dai->channels = 0;
-		codec_dai->sample_bits = 0;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = codecs[i].codec_dai;
+		if (codec_dai->active == 1)
+			codec_dai->rate = 0;
+			codec_dai->channels = 0;
+			codec_dai->sample_bits = 0;
 	}
 
 	/* apply codec digital mute */
-	if ((playback && codec_dai->playback_active == 1) ||
-	    (!playback && codec_dai->capture_active == 1))
-		snd_soc_dai_digital_mute(codec_dai, 1, substream->stream);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		if ((playback && codecs[i].codec_dai->playback_active == 1) ||
+		    (!playback && codecs[i].codec_dai->capture_active == 1))
+			snd_soc_dai_digital_mute(codecs[i].codec_dai, 1,
+						 substream->stream);
+	}
 
 	/* free any machine hw params */
 	if (rtd->dai_link->ops && rtd->dai_link->ops->hw_free)
@@ -784,8 +917,11 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 		platform->driver->ops->hw_free(substream);
 
 	/* now free hw params for the DAIs  */
-	if (codec_dai->driver->ops && codec_dai->driver->ops->hw_free)
-		codec_dai->driver->ops->hw_free(substream, codec_dai);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = codecs[i].codec_dai;
+		if (codec_dai->driver->ops && codec_dai->driver->ops->hw_free)
+			codec_dai->driver->ops->hw_free(substream, codec_dai);
+	}
 
 	if (cpu_dai->driver->ops && cpu_dai->driver->ops->hw_free)
 		cpu_dai->driver->ops->hw_free(substream, cpu_dai);
@@ -798,14 +934,19 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret;
-
-	if (codec_dai->driver->ops && codec_dai->driver->ops->trigger) {
-		ret = codec_dai->driver->ops->trigger(substream, cmd, codec_dai);
-		if (ret < 0)
-			return ret;
+	struct snd_soc_dai *codec_dai;
+	int i, ret;
+
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = codecs[i].codec_dai;
+		if (codec_dai->driver->ops && codec_dai->driver->ops->trigger) {
+			ret = codec_dai->driver->ops->trigger(substream,
+							      cmd, codec_dai);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	if (platform->driver->ops && platform->driver->ops->trigger) {
@@ -827,15 +968,20 @@ static int soc_pcm_bespoke_trigger(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret;
-
-	if (codec_dai->driver->ops &&
-	    codec_dai->driver->ops->bespoke_trigger) {
-		ret = codec_dai->driver->ops->bespoke_trigger(substream, cmd, codec_dai);
-		if (ret < 0)
-			return ret;
+	struct snd_soc_dai *codec_dai;
+	int i, ret;
+
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = codecs[i].codec_dai;
+		if (codec_dai->driver->ops &&
+		    codec_dai->driver->ops->bespoke_trigger) {
+			ret = codec_dai->driver->ops->bespoke_trigger(substream,
+								cmd, codec_dai);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	if (platform->driver->bespoke_trigger) {
@@ -860,11 +1006,14 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *codec_dai;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_uframes_t offset = 0;
 	snd_pcm_sframes_t delay = 0;
+	snd_pcm_sframes_t codec_delay = 0;
+	int i;
 
 	if (platform->driver->ops && platform->driver->ops->pointer)
 		offset = platform->driver->ops->pointer(substream);
@@ -872,11 +1021,22 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	if (cpu_dai->driver->ops && cpu_dai->driver->ops->delay)
 		delay += cpu_dai->driver->ops->delay(substream, cpu_dai);
 
-	if (codec_dai->driver->ops && codec_dai->driver->ops->delay)
-		delay += codec_dai->driver->ops->delay(substream, codec_dai);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = codecs[i].codec_dai;
+		if (codec_dai->driver->ops && codec_dai->driver->ops->delay)
+			codec_delay = max(codec_delay,
+					codec_dai->driver->ops->delay(substream,
+								    codec_dai));
+	}
+	delay += codec_delay;
 
+	/*
+	 * None of the existing platform drivers implement delay(), so
+	 * for now the codec_dai of first multicodec entry is used
+	 */
 	if (platform->driver->delay)
-		delay += platform->driver->delay(substream, codec_dai);
+		delay += platform->driver->delay(substream,
+						 codecs[0].codec_dai);
 
 	runtime->delay = delay;
 
@@ -2193,22 +2353,29 @@ static int dpcm_fe_dai_close(struct snd_pcm_substream *fe_substream)
 int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 {
 	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
+	struct snd_soc_dai *codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_pcm *pcm;
 	char new_name[64];
 	int ret = 0, playback = 0, capture = 0;
+	int i;
 
 	if (rtd->dai_link->dynamic || rtd->dai_link->no_pcm) {
 		playback = rtd->dai_link->dpcm_playback;
 		capture = rtd->dai_link->dpcm_capture;
 	} else {
-		if (codec_dai->driver->playback.channels_min &&
-		    cpu_dai->driver->playback.channels_min)
-			playback = 1;
-		if (codec_dai->driver->capture.channels_min &&
-		    cpu_dai->driver->capture.channels_min)
-			capture = 1;
+		for (i = 0; i < rtd->num_codecs; i++) {
+			codec_dai = codecs[i].codec_dai;
+			if (codec_dai->driver->playback.channels_min &&
+			    cpu_dai->driver->playback.channels_min)
+				playback++;
+			if (codec_dai->driver->capture.channels_min &&
+			    cpu_dai->driver->capture.channels_min)
+				capture++;
+		}
+		capture = (rtd->num_codecs == capture);
+		playback = (rtd->num_codecs == playback);
 	}
 
 	if (rtd->dai_link->playback_only) {
@@ -2234,7 +2401,9 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 				rtd->dai_link->stream_name);
 		else
 			snprintf(new_name, sizeof(new_name), "%s %s-%d",
-				rtd->dai_link->stream_name, codec_dai->name, num);
+				rtd->dai_link->stream_name,
+				(rtd->num_codecs > 1) ?
+				"multicodec" : rtd->codec_dai->name, num);
 
 		ret = snd_pcm_new(rtd->card->snd_card, new_name, num, playback,
 			capture, &pcm);
@@ -2307,8 +2476,9 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 
 	pcm->private_free = platform->driver->pcm_free;
 out:
-	dev_info(rtd->card->dev, "%s <-> %s mapping ok\n", codec_dai->name,
-		cpu_dai->name);
+	dev_info(rtd->card->dev, "%s <-> %s mapping ok\n",
+		 (rtd->num_codecs > 1) ? "multicodec" : rtd->codec_dai->name,
+		 cpu_dai->name);
 	return ret;
 }
 
-- 
1.8.3.2
