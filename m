From: Benoit Cousson <bcousson@baylibre.com>
Subject: [RFC] ASoC: core: Add support for DAI multicodec
Date: Tue, 11 Mar 2014 12:17:24 +0100
Message-ID: <1394536644-21438-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 07BB4261696
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 12:17:34 +0100 (CET)
Received: by mail-wg0-f47.google.com with SMTP id x12so9847292wgg.18
 for <alsa-devel@alsa-project.org>; Tue, 11 Mar 2014 04:17:34 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Misael Lopez Cruz <misael.lopez@ti.com>, Benoit Cousson <bcousson@baylibre.com>
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

Add few helpers to make the code more readable and fix a trailing
space in the header as well.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
[bcousson@baylibre.com: Adapt the original series to 3.14]
Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---

Hi Mark and Liam,

I'm not sure this is the only way to address that problem, but
both Misa and myself were facing the same issue on different platforms,
and we didn't find any straighforward way to do that.

To avoid breaking all the exiting ASoC implementation, this approach
is adding extra attributes for multiple codecs and does not enforce
moving every single codec pointer to a multicodec array. 

The patch is based on 3.14-rc6.

Comments are welcome.

Thanks,
Benoit

---
 include/sound/soc.h  |  20 ++
 sound/soc/soc-core.c | 511 ++++++++++++++++++++++++++++++++++-----------------
 sound/soc/soc-dapm.c |  39 ++--
 sound/soc/soc-pcm.c  | 412 ++++++++++++++++++++++++++++-------------
 4 files changed, 677 insertions(+), 305 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9a00147..c17351c 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -818,6 +818,19 @@ struct snd_soc_platform_driver {
 	int (*bespoke_trigger)(struct snd_pcm_substream *, int);
 };
 
+struct snd_soc_dai_link_codec {
+	const char *codec_name;
+	const struct device_node *codec_of_node;
+	const char *codec_dai_name;
+
+	struct snd_soc_codec *codec;
+	struct snd_soc_dai *codec_dai;
+
+	int (*hw_params_fixup)(struct snd_soc_pcm_runtime *rtd,
+			       struct snd_pcm_hw_params *params);
+	struct snd_pcm_hw_params hw_params;
+};
+
 struct snd_soc_platform {
 	const char *name;
 	int id;
@@ -866,6 +879,10 @@ struct snd_soc_dai_link {
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
@@ -1055,6 +1072,9 @@ struct snd_soc_pcm_runtime {
 	struct snd_soc_dai *codec_dai;
 	struct snd_soc_dai *cpu_dai;
 
+	struct snd_soc_dai_link_codec *codecs;
+	int num_codecs;
+
 	struct delayed_work delayed_work;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dpcm_root;
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fe1df50..1a6c2d0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -557,8 +557,9 @@ static void codec2codec_close_delayed_work(struct work_struct *work)
 int snd_soc_suspend(struct device *dev)
 {
 	struct snd_soc_card *card = dev_get_drvdata(dev);
+	struct snd_soc_dai_link_codec *codecs;
 	struct snd_soc_codec *codec;
-	int i;
+	int i, j;
 
 	/* If the initialization of this soc device failed, there is no codec
 	 * associated with it. Just bail out in this case.
@@ -578,14 +579,17 @@ int snd_soc_suspend(struct device *dev)
 
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
@@ -616,8 +620,12 @@ int snd_soc_suspend(struct device *dev)
 
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
@@ -700,8 +708,9 @@ static void soc_resume_deferred(struct work_struct *work)
 {
 	struct snd_soc_card *card =
 			container_of(work, struct snd_soc_card, deferred_resume_work);
+	struct snd_soc_dai_link_codec *codecs;
 	struct snd_soc_codec *codec;
-	int i;
+	int i, j;
 
 	/* our power state is still SNDRV_CTL_POWER_D3hot from suspend time,
 	 * so userspace apps are blocked from touching us
@@ -762,14 +771,17 @@ static void soc_resume_deferred(struct work_struct *work)
 
 	/* unmute any active DACs */
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
-			drv->ops->digital_mute(dai, 0);
+			if (drv->ops->digital_mute && dai->playback_active)
+				drv->ops->digital_mute(dai, 0);
+		}
 	}
 
 	for (i = 0; i < card->num_rtd; i++) {
@@ -851,14 +863,51 @@ EXPORT_SYMBOL_GPL(snd_soc_resume);
 static const struct snd_soc_dai_ops null_dai_ops = {
 };
 
+static struct snd_soc_codec *soc_find_codec(
+					const struct device_node *codec_of_node,
+					const char *codec_name)
+{
+	struct snd_soc_codec *codec;
+
+	list_for_each_entry(codec, &codec_list, list) {
+		if (codec_of_node) {
+			if (codec->dev->of_node != codec_of_node)
+				continue;
+		} else {
+			if (strcmp(codec->name, codec_name))
+				continue;
+		}
+
+		return codec;
+	}
+
+	return NULL;
+}
+
+static struct snd_soc_dai *soc_find_codec_dai(struct snd_soc_codec *codec,
+					      const char *codec_dai_name)
+{
+	struct snd_soc_dai *codec_dai;
+
+	list_for_each_entry(codec_dai, &dai_list, list) {
+		if (codec->dev == codec_dai->dev &&
+			!strcmp(codec_dai->name, codec_dai_name)) {
+			return codec_dai;
+		}
+	}
+
+	return NULL;
+}
+
 static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 {
 	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
-	struct snd_soc_codec *codec;
+	struct snd_soc_dai_link_codec *codecs = dai_link->codecs;
 	struct snd_soc_platform *platform;
-	struct snd_soc_dai *codec_dai, *cpu_dai;
+	struct snd_soc_dai *cpu_dai;
 	const char *platform_name;
+	int i;
 
 	dev_dbg(card->dev, "ASoC: binding %s at idx %d\n", dai_link->name, num);
 
@@ -883,43 +932,34 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 		return -EPROBE_DEFER;
 	}
 
-	/* Find CODEC from registered CODECs */
-	list_for_each_entry(codec, &codec_list, list) {
-		if (dai_link->codec_of_node) {
-			if (codec->dev->of_node != dai_link->codec_of_node)
-				continue;
-		} else {
-			if (strcmp(codec->name, dai_link->codec_name))
-				continue;
-		}
-
-		rtd->codec = codec;
-
-		/*
-		 * CODEC found, so find CODEC DAI from registered DAIs from
-		 * this CODEC
-		 */
-		list_for_each_entry(codec_dai, &dai_list, list) {
-			if (codec->dev == codec_dai->dev &&
-				!strcmp(codec_dai->name,
-					dai_link->codec_dai_name)) {
+	rtd->num_codecs = dai_link->num_codecs;
+	rtd->codecs = dai_link->codecs;
 
-				rtd->codec_dai = codec_dai;
-			}
+	/* Find CODEC from registered CODECs */
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codecs[i].codec = soc_find_codec(codecs[i].codec_of_node,
+						 codecs[i].codec_name);
+		if (!codecs[i].codec) {
+			dev_err(card->dev, "ASoC: CODEC %s not registered\n",
+				codecs[i].codec_name);
+			return -EPROBE_DEFER;
 		}
+	}
 
-		if (!rtd->codec_dai) {
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codecs[i].codec_dai = soc_find_codec_dai(
+						codecs[i].codec,
+						codecs[i].codec_dai_name);
+		if (!codecs[i].codec_dai) {
 			dev_err(card->dev, "ASoC: CODEC DAI %s not registered\n",
-				dai_link->codec_dai_name);
+				codecs[i].codec_dai_name);
 			return -EPROBE_DEFER;
 		}
 	}
 
-	if (!rtd->codec) {
-		dev_err(card->dev, "ASoC: CODEC %s not registered\n",
-			dai_link->codec_name);
-		return -EPROBE_DEFER;
-	}
+	/* Single codec links expect codec and codec_dai in runtime data */
+	rtd->codec = codecs[0].codec;
+	rtd->codec_dai = codecs[0].codec_dai;
 
 	/* if there's no platform we match on the empty platform */
 	platform_name = dai_link->platform_name;
@@ -994,8 +1034,9 @@ static void soc_remove_codec(struct snd_soc_codec *codec)
 static void soc_remove_link_dais(struct snd_soc_card *card, int num, int order)
 {
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
-	struct snd_soc_dai *codec_dai = rtd->codec_dai, *cpu_dai = rtd->cpu_dai;
-	int err;
+	struct snd_soc_dai *codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int i, err;
 
 	/* unregister the rtd device */
 	if (rtd->dev_registered) {
@@ -1006,17 +1047,20 @@ static void soc_remove_link_dais(struct snd_soc_card *card, int num, int order)
 	}
 
 	/* remove the CODEC DAI */
-	if (codec_dai && codec_dai->probed &&
-			codec_dai->driver->remove_order == order) {
-		if (codec_dai->driver->remove) {
-			err = codec_dai->driver->remove(codec_dai);
-			if (err < 0)
-				dev_err(codec_dai->dev,
-					"ASoC: failed to remove %s: %d\n",
-					codec_dai->name, err);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = rtd->codecs[i].codec_dai;
+		if (codec_dai && codec_dai->probed &&
+				codec_dai->driver->remove_order == order) {
+			if (codec_dai->driver->remove) {
+				err = codec_dai->driver->remove(codec_dai);
+				if (err < 0)
+					dev_err(codec_dai->dev,
+						"ASoC: failed to remove %s: %d\n",
+						codec_dai->name, err);
+			}
+			codec_dai->probed = 0;
+			list_del(&codec_dai->card_list);
 		}
-		codec_dai->probed = 0;
-		list_del(&codec_dai->card_list);
 	}
 
 	/* remove the cpu_dai */
@@ -1044,9 +1088,9 @@ static void soc_remove_link_components(struct snd_soc_card *card, int num,
 {
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_codec *codec;
+	int i;
 
 	/* remove the platform */
 	if (platform && platform->probed &&
@@ -1055,8 +1099,8 @@ static void soc_remove_link_components(struct snd_soc_card *card, int num,
 	}
 
 	/* remove the CODEC-side CODEC */
-	if (codec_dai) {
-		codec = codec_dai->codec;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec = rtd->codecs[i].codec;
 		if (codec && codec->probed &&
 		    codec->driver->remove_order == order)
 			soc_remove_codec(codec);
@@ -1239,45 +1283,106 @@ static void rtd_release(struct device *dev)
 	kfree(dev);
 }
 
+static int soc_aux_dev_init(struct snd_soc_card *card, int num)
+{
+	struct snd_soc_aux_dev *aux_dev = &card->aux_dev[num];
+	struct snd_soc_pcm_runtime *rtd = &card->rtd_aux[num];
+	struct snd_soc_codec *codec;
+	const char *temp;
+	int ret;
+
+	rtd->card = card;
+
+	codec = soc_find_codec(NULL, aux_dev->codec_name);
+	if (!codec)
+		return -EPROBE_DEFER;
+
+	/* Make sure all DAPM widgets are instantiated */
+	snd_soc_dapm_new_widgets(codec->dapm.card);
+
+	temp = codec->name_prefix;
+	codec->name_prefix = NULL;
+
+	/* do machine specific initialization */
+	if (aux_dev->init) {
+		ret = aux_dev->init(&codec->dapm);
+		if (ret < 0)
+			return ret;
+	}
+
+	codec->name_prefix = temp;
+
+	rtd->codec = codec;
+
+	return 0;
+}
+
+static int soc_dai_link_init(struct snd_soc_card *card, int num)
+{
+	struct snd_soc_dai_link *dai_link =  &card->dai_link[num];
+	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
+	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
+	const char **temp;
+	int i, ret;
+
+	rtd->card = card;
+
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
+
+	/* do machine specific initialization */
+	if (dai_link->init) {
+		ret = dai_link->init(rtd);
+		if (ret < 0)
+			return ret;
+	}
+
+	for (i = 0; i < rtd->num_codecs; i++)
+		codecs[i].codec->name_prefix = temp[i];
+
+	devm_kfree(card->dev, temp);
+
+	return 0;
+}
+
 static int soc_post_component_init(struct snd_soc_card *card,
-				   struct snd_soc_codec *codec,
 				   int num, int dailess)
 {
 	struct snd_soc_dai_link *dai_link = NULL;
 	struct snd_soc_aux_dev *aux_dev = NULL;
 	struct snd_soc_pcm_runtime *rtd;
-	const char *temp, *name;
+	const char *name;
 	int ret = 0;
 
 	if (!dailess) {
 		dai_link = &card->dai_link[num];
 		rtd = &card->rtd[num];
 		name = dai_link->name;
+		ret = soc_dai_link_init(card, num);
 	} else {
 		aux_dev = &card->aux_dev[num];
 		rtd = &card->rtd_aux[num];
 		name = aux_dev->name;
+		ret = soc_aux_dev_init(card, num);
 	}
-	rtd->card = card;
-
-	/* machine controls, routes and widgets are not prefixed */
-	temp = codec->name_prefix;
-	codec->name_prefix = NULL;
 
-	/* do machine specific initialization */
-	if (!dailess && dai_link->init)
-		ret = dai_link->init(rtd);
-	else if (dailess && aux_dev->init)
-		ret = aux_dev->init(&codec->dapm);
 	if (ret < 0) {
 		dev_err(card->dev, "ASoC: failed to init %s: %d\n", name, ret);
 		return ret;
 	}
-	codec->name_prefix = temp;
 
 	/* register the rtd device */
-	rtd->codec = codec;
-
 	rtd->dev = kzalloc(sizeof(struct device), GFP_KERNEL);
 	if (!rtd->dev)
 		return -ENOMEM;
@@ -1295,7 +1400,7 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	if (ret < 0) {
 		/* calling put_device() here to free the rtd->dev */
 		put_device(rtd->dev);
-		dev_err(card->dev,
+		dev_err(rtd->dev,
 			"ASoC: failed to register runtime device: %d\n", ret);
 		return ret;
 	}
@@ -1304,13 +1409,13 @@ static int soc_post_component_init(struct snd_soc_card *card,
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
@@ -1332,9 +1437,9 @@ static int soc_probe_link_components(struct snd_soc_card *card, int num,
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
@@ -1345,12 +1450,14 @@ static int soc_probe_link_components(struct snd_soc_card *card, int num,
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
@@ -1364,24 +1471,61 @@ static int soc_probe_link_components(struct snd_soc_card *card, int num,
 	return 0;
 }
 
+static int soc_link_dai_widgets(struct snd_soc_card *card,
+				struct snd_soc_dai_link *dai_link,
+				struct snd_soc_dai *cpu_dai,
+				struct snd_soc_dai *codec_dai)
+{
+	struct snd_soc_dapm_widget *play_w, *capture_w;
+	int ret;
+
+	/* link the DAI widgets */
+	play_w = codec_dai->playback_widget;
+	capture_w = cpu_dai->capture_widget;
+	if (play_w && capture_w) {
+		ret = snd_soc_dapm_new_pcm(card, dai_link->params,
+					   capture_w, play_w);
+		if (ret != 0) {
+			dev_err(card->dev, "ASoC: Can't link %s to %s: %d\n",
+				play_w->name, capture_w->name, ret);
+			return ret;
+		}
+	}
+
+	play_w = cpu_dai->playback_widget;
+	capture_w = codec_dai->capture_widget;
+	if (play_w && capture_w) {
+		ret = snd_soc_dapm_new_pcm(card, dai_link->params,
+					   capture_w, play_w);
+		if (ret != 0) {
+			dev_err(card->dev, "ASoC: Can't link %s to %s: %d\n",
+				play_w->name, capture_w->name, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+
 static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 {
 	struct snd_soc_dai_link *dai_link = &card->dai_link[num];
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
 	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dapm_widget *play_w, *capture_w;
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
@@ -1413,27 +1557,31 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 	}
 
 	/* probe the CODEC DAI */
-	if (!codec_dai->probed && codec_dai->driver->probe_order == order) {
-		if (codec_dai->driver->probe) {
-			ret = codec_dai->driver->probe(codec_dai);
-			if (ret < 0) {
-				dev_err(codec_dai->dev,
-					"ASoC: failed to probe CODEC DAI %s: %d\n",
-					codec_dai->name, ret);
-				return ret;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = codecs[i].codec_dai;
+		if (!codec_dai->probed &&
+				codec_dai->driver->probe_order == order) {
+			if (codec_dai->driver->probe) {
+				ret = codec_dai->driver->probe(codec_dai);
+				if (ret < 0) {
+					dev_err(codec_dai->dev,
+						"ASoC: failed to probe CODEC DAI %s: %d\n",
+						codec_dai->name, ret);
+					return ret;
+				}
 			}
-		}
 
-		/* mark codec_dai as probed and add to card dai list */
-		codec_dai->probed = 1;
-		list_add(&codec_dai->card_list, &card->dai_dev_list);
+			/* mark codec_dai as probed and add to card dai list */
+			codec_dai->probed = 1;
+			list_add(&codec_dai->card_list, &card->dai_dev_list);
+		}
 	}
 
 	/* complete DAI probe during last probe */
 	if (order != SND_SOC_COMP_ORDER_LAST)
 		return 0;
 
-	ret = soc_post_component_init(card, codec, num, 0);
+	ret = soc_post_component_init(card, num, 0);
 	if (ret)
 		return ret;
 
@@ -1465,35 +1613,21 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 						codec2codec_close_delayed_work);
 
 			/* link the DAI widgets */
-			play_w = codec_dai->playback_widget;
-			capture_w = cpu_dai->capture_widget;
-			if (play_w && capture_w) {
-				ret = snd_soc_dapm_new_pcm(card, dai_link->params,
-						   capture_w, play_w);
-				if (ret != 0) {
-					dev_err(card->dev, "ASoC: Can't link %s to %s: %d\n",
-						play_w->name, capture_w->name, ret);
+			for (i = 0; i < rtd->num_codecs; i++) {
+				ret = soc_link_dai_widgets(card, dai_link,
+						cpu_dai, codecs[i].codec_dai);
+				if (ret)
 					return ret;
-				}
-			}
-
-			play_w = cpu_dai->playback_widget;
-			capture_w = codec_dai->capture_widget;
-			if (play_w && capture_w) {
-				ret = snd_soc_dapm_new_pcm(card, dai_link->params,
-						   capture_w, play_w);
-				if (ret != 0) {
-					dev_err(card->dev, "ASoC: Can't link %s to %s: %d\n",
-						play_w->name, capture_w->name, ret);
-					return ret;
-				}
 			}
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
@@ -1501,31 +1635,42 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 #ifdef CONFIG_SND_SOC_AC97_BUS
 static int soc_register_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
 {
-	int ret;
+	int i, ret;
+	codec_dai;
+	codec;
 
-	/* Only instantiate AC97 if not already done by the adaptor
-	 * for the generic AC97 subsystem.
-	 */
-	if (rtd->codec_dai->driver->ac97_control && !rtd->codec->ac97_registered) {
-		/*
-		 * It is possible that the AC97 device is already registered to
-		 * the device subsystem. This happens when the device is created
-		 * via snd_ac97_mixer(). Currently only SoC codec that does so
-		 * is the generic AC97 glue but others migh emerge.
-		 *
-		 * In those cases we don't try to register the device again.
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec = rtd->codec;
+		codec_dai = rtd->codec_dai;
+
+		/* Only instantiate AC97 if not already done by the adaptor
+		 * for the generic AC97 subsystem.
 		 */
-		if (!rtd->codec->ac97_created)
-			return 0;
+		if (codec_dai->driver->ac97_control &&
+				!codec->ac97_registered) {
+			/*
+			 * It is possible that the AC97 device is already
+			 * registered to the device subsystem. This happens when
+			 * the device is created via snd_ac97_mixer(). Currently
+			 * only SoC codec that does so is the generic AC97 glue
+			 * but others migh emerge.
+			 *
+			 * In those cases we don't try to register the device
+			 * again.
+			 */
+			if (!codec->ac97_created)
+				return 0;
+
+			ret = soc_ac97_dev_register(codec);
+			if (ret < 0) {
+				dev_err(codec->dev,
+					"ASoC: AC97 device register failed: %d\n",
+					ret);
+				return ret;
+			}
 
-		ret = soc_ac97_dev_register(rtd->codec);
-		if (ret < 0) {
-			dev_err(rtd->codec->dev,
-				"ASoC: AC97 device register failed: %d\n", ret);
-			return ret;
+			codec->ac97_registered = 1;
 		}
-
-		rtd->codec->ac97_registered = 1;
 	}
 	return 0;
 }
@@ -1582,7 +1727,7 @@ found:
 	if (ret < 0)
 		return ret;
 
-	ret = soc_post_component_init(card, codec, num, 1);
+	ret = soc_post_component_init(card, num, 1);
 
 out:
 	return ret;
@@ -3694,6 +3839,33 @@ int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute,
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
@@ -3702,7 +3874,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
  */
 int snd_soc_register_card(struct snd_soc_card *card)
 {
-	int i, ret;
+	int i, j, ret;
 
 	if (!card->name || !card->dev)
 		return -EINVAL;
@@ -3710,22 +3882,29 @@ int snd_soc_register_card(struct snd_soc_card *card)
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
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b9dc6ac..f4b4e2a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2192,12 +2192,8 @@ int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_context *dapm,
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
@@ -2250,6 +2246,22 @@ static ssize_t dapm_widget_show(struct device *dev,
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
@@ -3684,13 +3696,12 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
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
@@ -3756,9 +3767,15 @@ void snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
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
index 47e1ce7..9d0bb9e 100644
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
@@ -230,32 +230,67 @@ static void soc_pcm_apply_msb(struct snd_pcm_substream *substream,
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
+	unsigned int sig_bits;
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
@@ -268,16 +303,18 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
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
@@ -301,12 +338,17 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
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
 	}
 
@@ -324,13 +366,10 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
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
@@ -338,22 +377,22 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
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
@@ -363,14 +402,17 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
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
@@ -380,14 +422,18 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 dynamic:
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
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
-	rtd->codec->active++;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codecs[i].codec_dai->active++;
+		codecs[i].codec->active++;
+	}
 	mutex_unlock(&rtd->pcm_mutex);
 	return 0;
 
@@ -396,10 +442,15 @@ config_err:
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
 
@@ -410,10 +461,13 @@ out:
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
 
@@ -429,7 +483,7 @@ static void close_delayed_work(struct work_struct *work)
 {
 	struct snd_soc_pcm_runtime *rtd =
 			container_of(work, struct snd_soc_pcm_runtime, delayed_work.work);
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *codec_dai = rtd->codecs[0].codec_dai;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -457,36 +511,47 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_dai_link_codec *codecs = rtd->codecs;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dai *codec_dai;
+	int i;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
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
-	codec->active--;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codecs[i].codec_dai->active--;
+		codecs[i].codec->active--;
+	}
 
 	/* clear the corresponding DAIs rate when inactive */
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
@@ -496,8 +561,13 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	cpu_dai->runtime = NULL;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		if (!rtd->pmdown_time || codec->ignore_pmdown_time ||
-		    rtd->dai_link->ignore_pmdown_time) {
+		int ignore = rtd->dai_link->ignore_pmdown_time ||
+			     !rtd->pmdown_time;
+
+		for (i = 0; (i < rtd->num_codecs) && !ignore; i++)
+			ignore |= codecs[i].codec->ignore_pmdown_time;
+
+		if (ignore) {
 			/* powered down playback stream now */
 			snd_soc_dapm_stream_event(rtd,
 						  SNDRV_PCM_STREAM_PLAYBACK,
@@ -518,10 +588,13 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
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
 
@@ -537,9 +610,10 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
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
 
@@ -561,12 +635,16 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
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
 
@@ -589,7 +667,9 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	snd_soc_dapm_stream_event(rtd, substream->stream,
 			SND_SOC_DAPM_STREAM_START);
 
-	snd_soc_dai_digital_mute(codec_dai, 0, substream->stream);
+	for (i = 0; i < rtd->num_codecs; i++)
+		snd_soc_dai_digital_mute(codecs[i].codec_dai, 0,
+					 substream->stream);
 
 out:
 	mutex_unlock(&rtd->pcm_mutex);
@@ -606,9 +686,10 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
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
 
@@ -625,13 +706,38 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	if (codec_dai->driver->ops && codec_dai->driver->ops->hw_params) {
-		ret = codec_dai->driver->ops->hw_params(substream, params, codec_dai);
-		if (ret < 0) {
-			dev_err(codec_dai->dev, "ASoC: can't set %s hw params:"
-				" %d\n", codec_dai->name, ret);
-			goto codec_err;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_pcm_hw_params *codec_params;
+
+		codec_dai = codecs[i].codec_dai;
+		codec_params = &codecs[i].hw_params;
+
+		/* copy params for each codec */
+		memcpy(codec_params, params, sizeof(struct snd_pcm_hw_params));
+
+		if (codecs[i].hw_params_fixup) {
+			ret = codecs[i].hw_params_fixup(rtd, codec_params);
+			if (ret < 0) {
+				dev_err(codec_dai->dev,
+					"ASoC: multicodec hw_params fixup failed %d\n",
+					ret);
+				goto codec_err;
+			}
 		}
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
+		}
+
+		codec_dai->rate = params_rate(codec_params);
 	}
 
 	if (cpu_dai->driver->ops && cpu_dai->driver->ops->hw_params) {
@@ -672,10 +778,16 @@ platform_err:
 		cpu_dai->driver->ops->hw_free(substream, cpu_dai);
 
 interface_err:
-	if (codec_dai->driver->ops && codec_dai->driver->ops->hw_free)
-		codec_dai->driver->ops->hw_free(substream, codec_dai);
+	i = rtd->num_codecs;
 
 codec_err:
+	while (--i >= 0) {
+		codec_dai = codecs[i].codec_dai;
+		if (codec_dai->driver->ops && codec_dai->driver->ops->hw_free)
+			codec_dai->driver->ops->hw_free(substream, codec_dai);
+		codec_dai->rate = 0;
+	}
+
 	if (rtd->dai_link->ops && rtd->dai_link->ops->hw_free)
 		rtd->dai_link->ops->hw_free(substream);
 
@@ -690,9 +802,11 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
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
 
@@ -703,16 +817,21 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
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
@@ -723,8 +842,11 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
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
@@ -737,14 +859,19 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
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
@@ -766,15 +893,20 @@ static int soc_pcm_bespoke_trigger(struct snd_pcm_substream *substream,
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
@@ -799,11 +931,14 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
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
@@ -811,11 +946,22 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
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
 
@@ -2129,22 +2275,29 @@ static int dpcm_fe_dai_close(struct snd_pcm_substream *fe_substream)
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
@@ -2170,7 +2323,9 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 				rtd->dai_link->stream_name);
 		else
 			snprintf(new_name, sizeof(new_name), "%s %s-%d",
-				rtd->dai_link->stream_name, codec_dai->name, num);
+				rtd->dai_link->stream_name,
+				(rtd->num_codecs > 1) ?
+				"multicodec" : rtd->codec_dai->name, num);
 
 		ret = snd_pcm_new(rtd->card->snd_card, new_name, num, playback,
 			capture, &pcm);
@@ -2243,8 +2398,9 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 
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
