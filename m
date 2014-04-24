From: Benoit Cousson <bcousson@baylibre.com>
Subject: [RFT v3 3/3] ASoC: core: Add support for DAI multicodec
Date: Thu, 24 Apr 2014 14:01:46 +0200
Message-ID: <1398340906-5017-4-git-send-email-bcousson@baylibre.com>
References: <1398340906-5017-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f50.google.com (mail-wg0-f50.google.com [74.125.82.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 438AC265295
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 14:02:25 +0200 (CEST)
Received: by mail-wg0-f50.google.com with SMTP id x13so2108465wgg.21
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 05:02:24 -0700 (PDT)
In-Reply-To: <1398340906-5017-1-git-send-email-bcousson@baylibre.com>
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

Fix a trailing space in the header as well.

Based on an original code done by Misael.

Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 include/sound/soc-dai.h  |   5 +
 include/sound/soc.h      |  13 ++
 sound/soc/soc-compress.c |  83 +++++---
 sound/soc/soc-core.c     | 364 ++++++++++++++++++++++-----------
 sound/soc/soc-dapm.c     |  71 ++++---
 sound/soc/soc-pcm.c      | 512 ++++++++++++++++++++++++++++++++---------------
 6 files changed, 715 insertions(+), 333 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index fad7676..6985851 100644
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
index 0fadb3c..7933512 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -821,6 +821,12 @@ struct snd_soc_platform_driver {
 	int (*bespoke_trigger)(struct snd_pcm_substream *, int);
 };
 
+struct snd_soc_dai_link_component {
+	const char *name;
+	const struct device_node *of_node;
+	const char *dai_name;
+};
+
 struct snd_soc_platform {
 	const char *name;
 	int id;
@@ -870,6 +876,10 @@ struct snd_soc_dai_link {
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
@@ -1059,6 +1069,9 @@ struct snd_soc_pcm_runtime {
 	struct snd_soc_dai *codec_dai;
 	struct snd_soc_dai *cpu_dai;
 
+	struct snd_soc_dai **codec_dais;
+	unsigned int num_codecs;
+
 	struct delayed_work delayed_work;
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs_dpcm_root;
diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 91083e6..f7a19bd 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -153,14 +153,17 @@ static void close_delayed_work(struct work_struct *work)
 {
 	struct snd_soc_pcm_runtime *rtd =
 			container_of(work, struct snd_soc_pcm_runtime, delayed_work.work);
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int i;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
-	dev_dbg(rtd->dev, "ASoC: pop wq checking: %s status: %s waiting: %s\n",
-		 codec_dai->driver->playback.stream_name,
-		 codec_dai->playback_active ? "active" : "inactive",
-		 rtd->pop_wait ? "yes" : "no");
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
+		dev_dbg(rtd->dev, "ASoC: pop wq checking: %s status: %s waiting: %s\n",
+			 codec_dai->driver->playback.stream_name,
+			 codec_dai->playback_active ? "active" : "inactive",
+			 rtd->pop_wait ? "yes" : "no");
+	}
 
 	/* are we waiting on this codec DAI stream */
 	if (rtd->pop_wait == 1) {
@@ -177,8 +180,7 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int stream;
+	int stream, i;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -189,14 +191,18 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 
 	snd_soc_runtime_deactivate(rtd, stream);
 
-	snd_soc_dai_digital_mute(codec_dai, 1, cstream->direction);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
+
+		snd_soc_dai_digital_mute(codec_dai, 1, cstream->direction);
+
+		if (!codec_dai->active)
+			codec_dai->rate = 0;
+	}
 
 	if (!cpu_dai->active)
 		cpu_dai->rate = 0;
 
-	if (!codec_dai->active)
-		codec_dai->rate = 0;
-
 
 	if (rtd->dai_link->compr_ops && rtd->dai_link->compr_ops->shutdown)
 		rtd->dai_link->compr_ops->shutdown(cstream);
@@ -282,8 +288,7 @@ static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret = 0;
+	int i, ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -293,13 +298,19 @@ static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 			goto out;
 	}
 
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-		snd_soc_dai_digital_mute(codec_dai, 0, cstream->direction);
-		break;
-	case SNDRV_PCM_TRIGGER_STOP:
-		snd_soc_dai_digital_mute(codec_dai, 1, cstream->direction);
-		break;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
+
+		switch (cmd) {
+		case SNDRV_PCM_TRIGGER_START:
+			snd_soc_dai_digital_mute(codec_dai, 0,
+						 cstream->direction);
+			break;
+		case SNDRV_PCM_TRIGGER_STOP:
+			snd_soc_dai_digital_mute(codec_dai, 1,
+						 cstream->direction);
+			break;
+		}
 	}
 
 out:
@@ -620,23 +631,26 @@ int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_compr *compr;
 	struct snd_pcm *be_pcm;
 	char new_name[64];
-	int ret = 0, direction = 0;
+	int i, ret = 0, direction = 0;
 
-	/* check client and interface hw capabilities */
-	snprintf(new_name, sizeof(new_name), "%s %s-%d",
-			rtd->dai_link->stream_name, codec_dai->name, num);
 
-	if (codec_dai->driver->playback.channels_min)
-		direction = SND_COMPRESS_PLAYBACK;
-	else if (codec_dai->driver->capture.channels_min)
-		direction = SND_COMPRESS_CAPTURE;
-	else
-		return -EINVAL;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
+		/* check client and interface hw capabilities */
+		snprintf(new_name, sizeof(new_name), "%s %s-%d",
+			 rtd->dai_link->stream_name, codec_dai->name, num);
+
+		if (codec_dai->driver->playback.channels_min)
+			direction = SND_COMPRESS_PLAYBACK;
+		else if (codec_dai->driver->capture.channels_min)
+			direction = SND_COMPRESS_CAPTURE;
+		else
+			return -EINVAL;
+	}
 
 	compr = kzalloc(sizeof(*compr), GFP_KERNEL);
 	if (compr == NULL) {
@@ -690,8 +704,11 @@ int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 	rtd->compr = compr;
 	compr->private_data = rtd;
 
-	printk(KERN_INFO "compress asoc: %s <-> %s mapping ok\n", codec_dai->name,
-		cpu_dai->name);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
+		printk(KERN_INFO "compress asoc: %s <-> %s mapping ok\n",
+		       codec_dai->name, cpu_dai->name);
+	}
 	return ret;
 
 compr_err:
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f18112a..7f68492 100644
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
@@ -1024,8 +1050,8 @@ static void soc_remove_codec_dai(struct snd_soc_dai *codec_dai, int order)
 static void soc_remove_link_dais(struct snd_soc_card *card, int num, int order)
 {
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
-	struct snd_soc_dai *codec_dai = rtd->codec_dai, *cpu_dai = rtd->cpu_dai;
-	int err;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int i, err;
 
 	/* unregister the rtd device */
 	if (rtd->dev_registered) {
@@ -1036,7 +1062,8 @@ static void soc_remove_link_dais(struct snd_soc_card *card, int num, int order)
 	}
 
 	/* remove the CODEC DAI */
-	soc_remove_codec_dai(codec_dai, order);
+	for (i = 0; i < rtd->num_codecs; i++)
+		soc_remove_codec_dai(rtd->codec_dais[i], order);
 
 	/* remove the cpu_dai */
 	if (cpu_dai && cpu_dai->probed &&
@@ -1063,9 +1090,9 @@ static void soc_remove_link_components(struct snd_soc_card *card, int num,
 {
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_codec *codec;
+	int i;
 
 	/* remove the platform */
 	if (platform && platform->probed &&
@@ -1074,8 +1101,8 @@ static void soc_remove_link_components(struct snd_soc_card *card, int num,
 	}
 
 	/* remove the CODEC-side CODEC */
-	if (codec_dai) {
-		codec = codec_dai->codec;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec = rtd->codec_dais[i]->codec;
 		if (codec && codec->probed &&
 		    codec->driver->remove_order == order)
 			soc_remove_codec(codec);
@@ -1266,17 +1293,20 @@ static void rtd_release(struct device *dev)
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
 
@@ -1294,20 +1324,28 @@ static int soc_aux_dev_init(struct snd_soc_card *card,
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
+		snd_soc_dapm_new_widgets(rtd->codec_dais[i]->codec->dapm.card);
+
+		/* machine controls, routes and widgets are not prefixed */
+		temp[i] = rtd->codec_dais[i]->codec->name_prefix;
+		rtd->codec_dais[i]->codec->name_prefix = NULL;
+	}
 
 	/* do machine specific initialization */
 	if (dai_link->init) {
@@ -1316,15 +1354,15 @@ static int soc_dai_link_init(struct snd_soc_card *card,
 			return ret;
 	}
 
-	codec->name_prefix = temp;
+	for (i = 0; i < rtd->num_codecs; i++)
+		rtd->codec_dais[i]->codec->name_prefix = temp[i];
 
-	rtd->codec = codec;
+	devm_kfree(card->dev, temp);
 
 	return 0;
 }
 
 static int soc_post_component_init(struct snd_soc_card *card,
-				   struct snd_soc_codec *codec,
 				   int num, int dailess)
 {
 	struct snd_soc_dai_link *dai_link = NULL;
@@ -1337,12 +1375,12 @@ static int soc_post_component_init(struct snd_soc_card *card,
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
@@ -1368,7 +1406,7 @@ static int soc_post_component_init(struct snd_soc_card *card,
 	if (ret < 0) {
 		/* calling put_device() here to free the rtd->dev */
 		put_device(rtd->dev);
-		dev_err(card->dev,
+		dev_err(rtd->dev,
 			"ASoC: failed to register runtime device: %d\n", ret);
 		return ret;
 	}
@@ -1377,13 +1415,13 @@ static int soc_post_component_init(struct snd_soc_card *card,
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
@@ -1405,9 +1443,8 @@ static int soc_probe_link_components(struct snd_soc_card *card, int num,
 {
 	struct snd_soc_pcm_runtime *rtd = &card->rtd[num];
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_platform *platform = rtd->platform;
-	int ret;
+	int i, ret;
 
 	/* probe the CPU-side component, if it is a CODEC */
 	if (cpu_dai->codec &&
@@ -1418,12 +1455,14 @@ static int soc_probe_link_components(struct snd_soc_card *card, int num,
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
@@ -1502,19 +1541,18 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
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
@@ -1546,15 +1584,17 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
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
 
@@ -1586,16 +1626,21 @@ static int soc_probe_link_dais(struct snd_soc_card *card, int num, int order)
 						codec2codec_close_delayed_work);
 
 			/* link the DAI widgets */
-			ret = soc_link_dai_widgets(card, dai_link,
-					cpu_dai, codec_dai);
-			if (ret)
-				return ret;
+			for (i = 0; i < rtd->num_codecs; i++) {
+				ret = soc_link_dai_widgets(card, dai_link,
+						cpu_dai, rtd->codec_dais[i]);
+				if (ret)
+					return ret;
+			}
 		}
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
@@ -1635,7 +1680,20 @@ static int soc_register_ac97_codec(struct snd_soc_codec *codec,
 
 static int soc_register_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
 {
-	return soc_register_ac97_codec(rtd->codec, rtd->codec_dai);
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
 }
 
 static void soc_unregister_ac97_codec(struct snd_soc_codec *codec)
@@ -1648,7 +1706,10 @@ static void soc_unregister_ac97_codec(struct snd_soc_codec *codec)
 
 static void soc_unregister_ac97_dai_link(struct snd_soc_pcm_runtime *rtd)
 {
-	soc_unregister_ac97_codec(rtd->codec);
+	int i;
+
+	for (i = 0; i < rtd->num_codecs; i++)
+		soc_unregister_ac97_codec(rtd->codec_dais[i]->codec);
 }
 #endif
 
@@ -1695,7 +1756,7 @@ found:
 	if (ret < 0)
 		return ret;
 
-	ret = soc_post_component_init(card, codec, num, 1);
+	ret = soc_post_component_init(card, num, 1);
 
 out:
 	return ret;
@@ -1850,16 +1911,23 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
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
@@ -2059,10 +2127,15 @@ int snd_soc_poweroff(struct device *dev)
 
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
@@ -3624,17 +3697,26 @@ static int snd_soc_xlate_tdm_slot_mask(unsigned int slots,
 int snd_soc_dai_set_tdm_slot(struct snd_soc_dai *dai,
 	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
 {
+	int ret = 0;
+
 	if (dai->driver && dai->driver->ops->xlate_tdm_slot_mask)
 		dai->driver->ops->xlate_tdm_slot_mask(slots,
 						&tx_mask, &rx_mask);
 	else
 		snd_soc_xlate_tdm_slot_mask(slots, &tx_mask, &rx_mask);
 
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
 
@@ -3702,6 +3784,33 @@ int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute,
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
@@ -3710,7 +3819,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
  */
 int snd_soc_register_card(struct snd_soc_card *card)
 {
-	int i, ret;
+	int i, j, ret;
 
 	if (!card->name || !card->dev)
 		return -EINVAL;
@@ -3718,22 +3827,29 @@ int snd_soc_register_card(struct snd_soc_card *card)
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
@@ -3786,9 +3902,17 @@ int snd_soc_register_card(struct snd_soc_card *card)
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
+
 	INIT_LIST_HEAD(&card->list);
 	INIT_LIST_HEAD(&card->dapm_dirty);
 	card->instantiated = 0;
@@ -3801,10 +3925,16 @@ int snd_soc_register_card(struct snd_soc_card *card)
 
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
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a2475e1..a322f11 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2079,12 +2079,8 @@ int snd_soc_dapm_mixer_update_power(struct snd_soc_dapm_context *dapm,
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
@@ -2137,6 +2133,21 @@ static ssize_t dapm_widget_show(struct device *dev,
 	return count;
 }
 
+/* show dapm widget status in sys fs */
+static ssize_t dapm_widget_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct snd_soc_pcm_runtime *rtd = dev_get_drvdata(dev);
+	int i, count = 0;
+
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_soc_codec *codec = rtd->codec_dais[i]->codec;
+		count += dapm_widget_show_codec(codec, buf + count);
+	}
+
+	return count;
+}
+
 static DEVICE_ATTR(dapm_widget, 0444, dapm_widget_show, NULL);
 
 int snd_soc_dapm_sys_add(struct device *dev)
@@ -3397,24 +3408,17 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 	return 0;
 }
 
-void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
+static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
+					  struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_pcm_runtime *rtd = card->rtd;
-	struct snd_soc_dai *cpu_dai, *codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dapm_route r;
 	int i;
 
 	memset(&r, 0, sizeof(r));
 
-	/* for each BE DAI link... */
-	for (i = 0; i < card->num_rtd; i++) {
-		rtd = &card->rtd[i];
-		cpu_dai = rtd->cpu_dai;
-		codec_dai = rtd->codec_dai;
-
-		/* dynamic FE links have no fixed DAI mapping */
-		if (rtd->dai_link->dynamic)
-			continue;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
 
 		/* there is no point in connecting BE DAI links with dummies */
 		if (snd_soc_dai_is_dummy(codec_dai) ||
@@ -3442,17 +3446,32 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
 
 			snd_soc_dapm_add_route(&card->dapm, &r, true);
 		}
-
 	}
 }
 
-static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
-	int event)
+void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
 {
+	struct snd_soc_pcm_runtime *rtd = card->rtd;
+	int i;
+
+	/* for each BE DAI link... */
+	for (i = 0; i < card->num_rtd; i++) {
+		rtd = &card->rtd[i];
+
+		/* dynamic FE links have no fixed DAI mapping */
+		if (rtd->dai_link->dynamic)
+			continue;
+
+		dapm_connect_dai_link_widgets(card, rtd);
+	}
+}
 
+static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd,
+				  struct snd_soc_dai *cpu_dai,
+				  struct snd_soc_dai *codec_dai,
+				  int stream, int event)
+{
 	struct snd_soc_dapm_widget *w_cpu, *w_codec;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		w_cpu = cpu_dai->playback_widget;
@@ -3518,9 +3537,15 @@ void snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
 			      int event)
 {
 	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai;
+	int i;
 
 	mutex_lock_nested(&card->dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
-	soc_dapm_stream_event(rtd, stream, event);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = rtd->codec_dais[i];
+		soc_dapm_stream_event(rtd, cpu_dai, codec_dai, stream, event);
+	}
 	mutex_unlock(&card->dapm_mutex);
 }
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 88230ea..a56a1d5 100644
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
@@ -47,22 +47,26 @@
 void snd_soc_runtime_activate(struct snd_soc_pcm_runtime *rtd, int stream)
 {
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int i;
 
 	lockdep_assert_held(&rtd->pcm_mutex);
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		cpu_dai->playback_active++;
-		codec_dai->playback_active++;
+		for (i = 0; i < rtd->num_codecs; i++)
+			rtd->codec_dais[i]->playback_active++;
 	} else {
 		cpu_dai->capture_active++;
-		codec_dai->capture_active++;
+		for (i = 0; i < rtd->num_codecs; i++)
+			rtd->codec_dais[i]->capture_active++;
 	}
 
 	cpu_dai->active++;
-	codec_dai->active++;
 	cpu_dai->component->active++;
-	codec_dai->component->active++;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		rtd->codec_dais[i]->active++;
+		rtd->codec_dais[i]->component->active++;
+	}
 }
 
 /**
@@ -78,22 +82,26 @@ void snd_soc_runtime_activate(struct snd_soc_pcm_runtime *rtd, int stream)
 void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream)
 {
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int i;
 
 	lockdep_assert_held(&rtd->pcm_mutex);
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		cpu_dai->playback_active--;
-		codec_dai->playback_active--;
+		for (i = 0; i < rtd->num_codecs; i++)
+			rtd->codec_dais[i]->playback_active--;
 	} else {
 		cpu_dai->capture_active--;
-		codec_dai->capture_active--;
+		for (i = 0; i < rtd->num_codecs; i++)
+			rtd->codec_dais[i]->capture_active--;
 	}
 
 	cpu_dai->active--;
-	codec_dai->active--;
 	cpu_dai->component->active--;
-	codec_dai->component->active--;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		rtd->codec_dais[i]->component->active--;
+		rtd->codec_dais[i]->active--;
+	}
 }
 
 /**
@@ -107,11 +115,15 @@ void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream)
  */
 bool snd_soc_runtime_ignore_pmdown_time(struct snd_soc_pcm_runtime *rtd)
 {
+	int i, ignore = 0;
+
 	if (!rtd->pmdown_time || rtd->dai_link->ignore_pmdown_time)
 		return true;
 
-	return rtd->cpu_dai->component->ignore_pmdown_time &&
-			rtd->codec_dai->component->ignore_pmdown_time;
+	for (i = 0; (i < rtd->num_codecs) && !ignore; i++)
+		ignore |= rtd->codec_dais[i]->component->ignore_pmdown_time;
+
+	return rtd->cpu_dai->component->ignore_pmdown_time && ignore;
 }
 
 /**
@@ -222,8 +234,7 @@ static int soc_pcm_params_symmetry(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	unsigned int rate, channels, sample_bits, symmetry;
+	unsigned int rate, channels, sample_bits, symmetry, i;
 
 	rate = params_rate(params);
 	channels = params_channels(params);
@@ -231,8 +242,12 @@ static int soc_pcm_params_symmetry(struct snd_pcm_substream *substream,
 
 	/* reject unmatched parameters when applying symmetry */
 	symmetry = cpu_dai->driver->symmetric_rates ||
-		codec_dai->driver->symmetric_rates ||
 		rtd->dai_link->symmetric_rates;
+
+	for (i = 0; i < rtd->num_codecs; i++)
+		symmetry = rtd->codec_dais[i]->driver->symmetric_rates ||
+		           symmetry;
+
 	if (symmetry && cpu_dai->rate && cpu_dai->rate != rate) {
 		dev_err(rtd->dev, "ASoC: unmatched rate symmetry: %d - %d\n",
 				cpu_dai->rate, rate);
@@ -240,8 +255,12 @@ static int soc_pcm_params_symmetry(struct snd_pcm_substream *substream,
 	}
 
 	symmetry = cpu_dai->driver->symmetric_channels ||
-		codec_dai->driver->symmetric_channels ||
 		rtd->dai_link->symmetric_channels;
+
+	for (i = 0; i < rtd->num_codecs; i++)
+		symmetry = rtd->codec_dais[i]->driver->symmetric_channels ||
+		           symmetry;
+
 	if (symmetry && cpu_dai->channels && cpu_dai->channels != channels) {
 		dev_err(rtd->dev, "ASoC: unmatched channel symmetry: %d - %d\n",
 				cpu_dai->channels, channels);
@@ -249,8 +268,12 @@ static int soc_pcm_params_symmetry(struct snd_pcm_substream *substream,
 	}
 
 	symmetry = cpu_dai->driver->symmetric_samplebits ||
-		codec_dai->driver->symmetric_samplebits ||
 		rtd->dai_link->symmetric_samplebits;
+
+	for (i = 0; i < rtd->num_codecs; i++)
+		symmetry = rtd->codec_dais[i]->driver->symmetric_samplebits ||
+		           symmetry;
+
 	if (symmetry && cpu_dai->sample_bits && cpu_dai->sample_bits != sample_bits) {
 		dev_err(rtd->dev, "ASoC: unmatched sample bits symmetry: %d - %d\n",
 				cpu_dai->sample_bits, sample_bits);
@@ -264,15 +287,20 @@ static bool soc_pcm_has_symmetry(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai_driver *cpu_driver = rtd->cpu_dai->driver;
-	struct snd_soc_dai_driver *codec_driver = rtd->codec_dai->driver;
 	struct snd_soc_dai_link *link = rtd->dai_link;
+	unsigned int symmetry, i;
+
+	symmetry = cpu_driver->symmetric_rates || link->symmetric_rates ||
+		cpu_driver->symmetric_channels || link->symmetric_channels ||
+		cpu_driver->symmetric_samplebits || link->symmetric_samplebits;
 
-	return cpu_driver->symmetric_rates || codec_driver->symmetric_rates ||
-		link->symmetric_rates || cpu_driver->symmetric_channels ||
-		codec_driver->symmetric_channels || link->symmetric_channels ||
-		cpu_driver->symmetric_samplebits ||
-		codec_driver->symmetric_samplebits ||
-		link->symmetric_samplebits;
+	for (i = 0; i < rtd->num_codecs; i++)
+		symmetry = symmetry ||
+			rtd->codec_dais[i]->driver->symmetric_rates ||
+			rtd->codec_dais[i]->driver->symmetric_channels ||
+			rtd->codec_dais[i]->driver->symmetric_samplebits;
+
+	return symmetry;
 }
 
 /*
@@ -310,32 +338,65 @@ static void soc_pcm_apply_msb(struct snd_pcm_substream *substream,
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
+		codec_dai_drv = rtd->codec_dais[i]->driver;
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
@@ -349,15 +410,16 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_platform *platform = rtd->platform;
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
+		pinctrl_pm_select_default_state(rtd->codec_dais[i]->dev);
 	pm_runtime_get_sync(cpu_dai->dev);
-	pm_runtime_get_sync(codec_dai->dev);
+	for (i = 0; i < rtd->num_codecs; i++)
+		pm_runtime_get_sync(rtd->codec_dais[i]->dev);
 	pm_runtime_get_sync(platform->dev);
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
@@ -381,13 +443,23 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		}
 	}
 
-	if (codec_dai->driver->ops && codec_dai->driver->ops->startup) {
-		ret = codec_dai->driver->ops->startup(substream, codec_dai);
-		if (ret < 0) {
-			dev_err(codec_dai->dev, "ASoC: can't open codec"
-				" %s: %d\n", codec_dai->name, ret);
-			goto codec_dai_err;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = rtd->codec_dais[i];
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
@@ -404,13 +476,10 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
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
@@ -418,22 +487,22 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
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
+	soc_pcm_apply_msb(substream, rtd->codec_dais[0]);
 	soc_pcm_apply_msb(substream, cpu_dai);
 
 	/* Symmetry only applies if we've already got an active stream. */
@@ -443,14 +512,17 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 			goto config_err;
 	}
 
-	if (codec_dai->active) {
-		ret = soc_pcm_apply_symmetry(substream, codec_dai);
-		if (ret != 0)
-			goto config_err;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		if (rtd->codec_dais[i]->active) {
+			ret = soc_pcm_apply_symmetry(substream,
+						     rtd->codec_dais[i]);
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
@@ -469,10 +541,15 @@ config_err:
 		rtd->dai_link->ops->shutdown(substream);
 
 machine_err:
-	if (codec_dai->driver->ops->shutdown)
-		codec_dai->driver->ops->shutdown(substream, codec_dai);
+	i = rtd->num_codecs;
 
 codec_dai_err:
+	while (--i >= 0) {
+		codec_dai = rtd->codec_dais[i];
+		if (codec_dai->driver->ops->shutdown)
+			codec_dai->driver->ops->shutdown(substream, codec_dai);
+	}
+
 	if (platform->driver->ops && platform->driver->ops->close)
 		platform->driver->ops->close(substream);
 
@@ -483,10 +560,13 @@ out:
 	mutex_unlock(&rtd->pcm_mutex);
 
 	pm_runtime_put(platform->dev);
-	pm_runtime_put(codec_dai->dev);
+	for (i = 0; i < rtd->num_codecs; i++)
+		pm_runtime_put(rtd->codec_dais[i]->dev);
 	pm_runtime_put(cpu_dai->dev);
-	if (!codec_dai->active)
-		pinctrl_pm_select_sleep_state(codec_dai->dev);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		if (!rtd->codec_dais[i]->active)
+			pinctrl_pm_select_sleep_state(rtd->codec_dais[i]->dev);
+	}
 	if (!cpu_dai->active)
 		pinctrl_pm_select_sleep_state(cpu_dai->dev);
 
@@ -502,7 +582,7 @@ static void close_delayed_work(struct work_struct *work)
 {
 	struct snd_soc_pcm_runtime *rtd =
 			container_of(work, struct snd_soc_pcm_runtime, delayed_work.work);
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dais[0];
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -531,7 +611,8 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *codec_dai;
+	int i;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -541,14 +622,20 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	if (!cpu_dai->active)
 		cpu_dai->rate = 0;
 
-	if (!codec_dai->active)
-		codec_dai->rate = 0;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = rtd->codec_dais[i];
+		if (!codec_dai->active)
+			codec_dai->rate = 0;
+	}
 
 	if (cpu_dai->driver->ops->shutdown)
 		cpu_dai->driver->ops->shutdown(substream, cpu_dai);
 
-	if (codec_dai->driver->ops->shutdown)
-		codec_dai->driver->ops->shutdown(substream, codec_dai);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = rtd->codec_dais[i];
+		if (codec_dai->driver->ops->shutdown)
+			codec_dai->driver->ops->shutdown(substream, codec_dai);
+	}
 
 	if (rtd->dai_link->ops && rtd->dai_link->ops->shutdown)
 		rtd->dai_link->ops->shutdown(substream);
@@ -579,10 +666,13 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	mutex_unlock(&rtd->pcm_mutex);
 
 	pm_runtime_put(platform->dev);
-	pm_runtime_put(codec_dai->dev);
+	for (i = 0; i < rtd->num_codecs; i++)
+		pm_runtime_put(rtd->codec_dais[i]->dev);
 	pm_runtime_put(cpu_dai->dev);
-	if (!codec_dai->active)
-		pinctrl_pm_select_sleep_state(codec_dai->dev);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		if (!rtd->codec_dais[i]->active)
+			pinctrl_pm_select_sleep_state(rtd->codec_dais[i]->dev);
+	}
 	if (!cpu_dai->active)
 		pinctrl_pm_select_sleep_state(cpu_dai->dev);
 
@@ -599,8 +689,8 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret = 0;
+	struct snd_soc_dai *codec_dai;
+	int i, ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -622,12 +712,16 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 		}
 	}
 
-	if (codec_dai->driver->ops && codec_dai->driver->ops->prepare) {
-		ret = codec_dai->driver->ops->prepare(substream, codec_dai);
-		if (ret < 0) {
-			dev_err(codec_dai->dev, "ASoC: DAI prepare error: %d\n",
-				ret);
-			goto out;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = rtd->codec_dais[i];
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
 
@@ -650,13 +744,26 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	snd_soc_dapm_stream_event(rtd, substream->stream,
 			SND_SOC_DAPM_STREAM_START);
 
-	snd_soc_dai_digital_mute(codec_dai, 0, substream->stream);
+	for (i = 0; i < rtd->num_codecs; i++)
+		snd_soc_dai_digital_mute(rtd->codec_dais[i], 0,
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
@@ -668,8 +775,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret = 0;
+	int i, ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -686,13 +792,39 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	if (codec_dai->driver->ops && codec_dai->driver->ops->hw_params) {
-		ret = codec_dai->driver->ops->hw_params(substream, params, codec_dai);
-		if (ret < 0) {
-			dev_err(codec_dai->dev, "ASoC: can't set %s hw params:"
-				" %d\n", codec_dai->name, ret);
-			goto codec_err;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
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
@@ -719,11 +851,6 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
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
@@ -733,10 +860,16 @@ platform_err:
 		cpu_dai->driver->ops->hw_free(substream, cpu_dai);
 
 interface_err:
-	if (codec_dai->driver->ops && codec_dai->driver->ops->hw_free)
-		codec_dai->driver->ops->hw_free(substream, codec_dai);
+	i = rtd->num_codecs;
 
 codec_err:
+	while (--i >= 0) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
+		if (codec_dai->driver->ops && codec_dai->driver->ops->hw_free)
+			codec_dai->driver->ops->hw_free(substream, codec_dai);
+		codec_dai->rate = 0;
+	}
+
 	if (rtd->dai_link->ops && rtd->dai_link->ops->hw_free)
 		rtd->dai_link->ops->hw_free(substream);
 
@@ -752,8 +885,9 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *codec_dai;
 	bool playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
+	int i;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -764,16 +898,22 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 		cpu_dai->sample_bits = 0;
 	}
 
-	if (codec_dai->active == 1) {
-		codec_dai->rate = 0;
-		codec_dai->channels = 0;
-		codec_dai->sample_bits = 0;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = rtd->codec_dais[i];
+		if (codec_dai->active == 1) {
+			codec_dai->rate = 0;
+			codec_dai->channels = 0;
+			codec_dai->sample_bits = 0;
+		}
 	}
 
 	/* apply codec digital mute */
-	if ((playback && codec_dai->playback_active == 1) ||
-	    (!playback && codec_dai->capture_active == 1))
-		snd_soc_dai_digital_mute(codec_dai, 1, substream->stream);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		if ((playback && rtd->codec_dais[i]->playback_active == 1) ||
+		    (!playback && rtd->codec_dais[i]->capture_active == 1))
+			snd_soc_dai_digital_mute(rtd->codec_dais[i], 1,
+						 substream->stream);
+	}
 
 	/* free any machine hw params */
 	if (rtd->dai_link->ops && rtd->dai_link->ops->hw_free)
@@ -784,8 +924,11 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 		platform->driver->ops->hw_free(substream);
 
 	/* now free hw params for the DAIs  */
-	if (codec_dai->driver->ops && codec_dai->driver->ops->hw_free)
-		codec_dai->driver->ops->hw_free(substream, codec_dai);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = rtd->codec_dais[i];
+		if (codec_dai->driver->ops && codec_dai->driver->ops->hw_free)
+			codec_dai->driver->ops->hw_free(substream, codec_dai);
+	}
 
 	if (cpu_dai->driver->ops && cpu_dai->driver->ops->hw_free)
 		cpu_dai->driver->ops->hw_free(substream, cpu_dai);
@@ -799,13 +942,17 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
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
+		codec_dai = rtd->codec_dais[i];
+		if (codec_dai->driver->ops && codec_dai->driver->ops->trigger) {
+			ret = codec_dai->driver->ops->trigger(substream,
+							      cmd, codec_dai);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	if (platform->driver->ops && platform->driver->ops->trigger) {
@@ -828,14 +975,18 @@ static int soc_pcm_bespoke_trigger(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
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
+		codec_dai = rtd->codec_dais[i];
+		if (codec_dai->driver->ops &&
+		    codec_dai->driver->ops->bespoke_trigger) {
+			ret = codec_dai->driver->ops->bespoke_trigger(substream,
+								cmd, codec_dai);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	if (platform->driver->bespoke_trigger) {
@@ -861,10 +1012,12 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
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
@@ -872,11 +1025,21 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	if (cpu_dai->driver->ops && cpu_dai->driver->ops->delay)
 		delay += cpu_dai->driver->ops->delay(substream, cpu_dai);
 
-	if (codec_dai->driver->ops && codec_dai->driver->ops->delay)
-		delay += codec_dai->driver->ops->delay(substream, codec_dai);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = rtd->codec_dais[i];
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
+		delay += platform->driver->delay(substream, rtd->codec_dais[0]);
 
 	runtime->delay = delay;
 
@@ -979,7 +1142,7 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 		struct snd_soc_dapm_widget *widget, int stream)
 {
 	struct snd_soc_pcm_runtime *be;
-	int i;
+	int i, j;
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		for (i = 0; i < card->num_links; i++) {
@@ -988,9 +1151,14 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 			if (!be->dai_link->no_pcm)
 				continue;
 
-			if (be->cpu_dai->playback_widget == widget ||
-				be->codec_dai->playback_widget == widget)
+			if (be->cpu_dai->playback_widget == widget)
 				return be;
+
+			for (j = 0; j < be->num_codecs; j++) {
+				struct snd_soc_dai *dai = be->codec_dais[j];
+				if (dai->playback_widget == widget)
+					return be;
+			}
 		}
 	} else {
 
@@ -1000,9 +1168,14 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 			if (!be->dai_link->no_pcm)
 				continue;
 
-			if (be->cpu_dai->capture_widget == widget ||
-				be->codec_dai->capture_widget == widget)
+			if (be->cpu_dai->capture_widget == widget)
 				return be;
+
+			for (j = 0; j < be->num_codecs; j++) {
+				struct snd_soc_dai *dai = be->codec_dais[j];
+				if (dai->capture_widget == widget)
+					return be;
+			}
 		}
 	}
 
@@ -1065,6 +1238,7 @@ static int dpcm_prune_paths(struct snd_soc_pcm_runtime *fe, int stream,
 
 	/* Destroy any old FE <--> BE connections */
 	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+		unsigned int i;
 
 		/* is there a valid CPU DAI widget for this BE */
 		widget = dai_get_widget(dpcm->be->cpu_dai, stream);
@@ -1074,11 +1248,14 @@ static int dpcm_prune_paths(struct snd_soc_pcm_runtime *fe, int stream,
 			continue;
 
 		/* is there a valid CODEC DAI widget for this BE */
-		widget = dai_get_widget(dpcm->be->codec_dai, stream);
+		for (i = 0; i < dpcm->be->num_codecs; i++) {
+			struct snd_soc_dai *dai = dpcm->be->codec_dais[i];
+			widget = dai_get_widget(dai, stream);
 
-		/* prune the BE if it's no longer in our active list */
-		if (widget && widget_in_list(list, widget))
-			continue;
+			/* prune the BE if it's no longer in our active list */
+			if (widget && widget_in_list(list, widget))
+				continue;
+		}
 
 		dev_dbg(fe->dev, "ASoC: pruning %s BE %s for %s\n",
 			stream ? "capture" : "playback",
@@ -2107,16 +2284,22 @@ int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute)
 	list_for_each_entry(dpcm, clients, list_be) {
 
 		struct snd_soc_pcm_runtime *be = dpcm->be;
-		struct snd_soc_dai *dai = be->codec_dai;
-		struct snd_soc_dai_driver *drv = dai->driver;
+		int i;
 
 		if (be->dai_link->ignore_suspend)
 			continue;
 
-		dev_dbg(be->dev, "ASoC: BE digital mute %s\n", be->dai_link->name);
+		for (i = 0; i < be->num_codecs; i++) {
+			struct snd_soc_dai *dai = be->codec_dais[i];
+			struct snd_soc_dai_driver *drv = dai->driver;
+
+			dev_dbg(be->dev, "ASoC: BE digital mute %s\n",
+					 be->dai_link->name);
 
-		if (drv->ops && drv->ops->digital_mute && dai->playback_active)
-			drv->ops->digital_mute(dai, mute);
+			if (drv->ops && drv->ops->digital_mute &&
+							dai->playback_active)
+				drv->ops->digital_mute(dai, mute);
+		}
 	}
 
 	return 0;
@@ -2181,22 +2364,28 @@ static int dpcm_fe_dai_close(struct snd_pcm_substream *fe_substream)
 int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 {
 	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
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
+			codec_dai = rtd->codec_dais[i];
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
@@ -2222,7 +2411,9 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 				rtd->dai_link->stream_name);
 		else
 			snprintf(new_name, sizeof(new_name), "%s %s-%d",
-				rtd->dai_link->stream_name, codec_dai->name, num);
+				rtd->dai_link->stream_name,
+				(rtd->num_codecs > 1) ?
+				"multicodec" : rtd->codec_dai->name, num);
 
 		ret = snd_pcm_new(rtd->card->snd_card, new_name, num, playback,
 			capture, &pcm);
@@ -2295,8 +2486,9 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 
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
