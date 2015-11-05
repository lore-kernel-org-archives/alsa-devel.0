From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 11/13] ASoC: topology: Add PCM DAIs
	dynamically when loading them
Date: Thu,  5 Nov 2015 17:59:57 +0800
Message-ID: <0c003371834c517cf996e1cef1e5e31beaa2e5b2.1446717205.git.mengdong.lin@linux.intel.com>
References: <cover.1446717205.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 5938D265AF2
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 10:44:32 +0100 (CET)
In-Reply-To: <cover.1446717205.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Add PCM DAIs to ASoC core when loading them from topology.

More:
1. Embed dobj in the DAI to free it when unloading.
2. Change tplg load ops for DAI:
   - only process a DAI
   - pass the dai driver pointer to device driver for extra initialization.
     The device driver can just work on the dai driver object.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 212eaaf..964b7de 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -222,6 +222,7 @@ struct snd_soc_dai_driver {
 	const char *name;
 	unsigned int id;
 	unsigned int base;
+	struct snd_soc_dobj dobj;
 
 	/* DAI driver callbacks */
 	int (*probe)(struct snd_soc_dai *dai);
diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index ea387ed..b51c207 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -56,12 +56,6 @@ struct snd_soc_dobj_widget {
 	unsigned int kcontrol_enum:1;	/* this widget is an enum kcontrol */
 };
 
-/* dynamic PCM DAI object */
-struct snd_soc_dobj_pcm_dai {
-	struct snd_soc_tplg_pcm_dai *pd;
-	unsigned int count;
-};
-
 /* generic dynamic object - all dynamic objects belong to this struct */
 struct snd_soc_dobj {
 	enum snd_soc_dobj_type type;
@@ -71,7 +65,6 @@ struct snd_soc_dobj {
 	union {
 		struct snd_soc_dobj_control control;
 		struct snd_soc_dobj_widget widget;
-		struct snd_soc_dobj_pcm_dai pcm_dai;
 	};
 	void *private; /* core does not touch this */
 };
@@ -124,10 +117,10 @@ struct snd_soc_tplg_ops {
 	int (*widget_unload)(struct snd_soc_component *,
 		struct snd_soc_dobj *);
 
-	/* FE - used for any driver specific init */
-	int (*pcm_dai_load)(struct snd_soc_component *,
-		struct snd_soc_tplg_pcm_dai *pcm_dai, int num_fe);
-	int (*pcm_dai_unload)(struct snd_soc_component *,
+	/* FE DAI - used for any driver specific init */
+	int (*dai_load)(struct snd_soc_component *,
+		struct snd_soc_dai_driver *dai);
+	int (*dai_unload)(struct snd_soc_component *,
 		struct snd_soc_dobj *);
 
 	/* callback to handle vendor bespoke data */
diff --git a/include/sound/soc.h b/include/sound/soc.h
index a6e6a1b..4d07a9e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -27,7 +27,6 @@
 #include <sound/compress_driver.h>
 #include <sound/control.h>
 #include <sound/ac97_codec.h>
-#include <sound/soc-topology.h>
 
 /*
  * Convenience kcontrol builders
@@ -393,6 +392,7 @@ struct snd_soc_jack_zone;
 struct snd_soc_jack_pin;
 #include <sound/soc-dapm.h>
 #include <sound/soc-dpcm.h>
+#include <sound/soc-topology.h>
 
 struct snd_soc_jack_gpio;
 
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 8d7ec80..2201261 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -330,12 +330,12 @@ static int soc_tplg_widget_load(struct soc_tplg *tplg,
 	return 0;
 }
 
-/* pass dynamic FEs configurations to component driver */
-static int soc_tplg_pcm_dai_load(struct soc_tplg *tplg,
-	struct snd_soc_tplg_pcm_dai *pcm_dai, int num_pcm_dai)
+/* pass dynamic FE DAI configurations to component driver */
+static int soc_tplg_dai_load(struct soc_tplg *tplg,
+	struct snd_soc_dai_driver *dai)
 {
-	if (tplg->comp && tplg->ops && tplg->ops->pcm_dai_load)
-		return tplg->ops->pcm_dai_load(tplg->comp, pcm_dai, num_pcm_dai);
+	if (tplg->comp && tplg->ops && tplg->ops->dai_load)
+		return tplg->ops->dai_load(tplg->comp, dai);
 
 	return 0;
 }
@@ -499,14 +499,17 @@ static void remove_widget(struct snd_soc_component *comp,
 static void remove_pcm_dai(struct snd_soc_component *comp,
 	struct snd_soc_dobj *dobj, int pass)
 {
+	struct snd_soc_dai_driver *dai =
+		container_of(dobj, struct snd_soc_dai_driver, dobj);
+
 	if (pass != SOC_TPLG_PASS_PCM_DAI)
 		return;
 
-	if (dobj->ops && dobj->ops->pcm_dai_unload)
-		dobj->ops->pcm_dai_unload(comp, dobj);
+	if (dobj->ops && dobj->ops->dai_unload)
+		dobj->ops->dai_unload(comp, dobj);
 
 	list_del(&dobj->list);
-	kfree(dobj);
+	kfree(dai);
 }
 
 /* bind a kcontrol to it's IO handlers */
@@ -1544,18 +1547,93 @@ static int soc_tplg_dapm_complete(struct soc_tplg *tplg)
 	return 0;
 }
 
-static int soc_tplg_pcm_dai_elems_load(struct soc_tplg *tplg,
+static unsigned int get_rates(unsigned int rate_min, unsigned int rate_max)
+{
+	static int pcm_rates[] = {
+		5512, 8000, 11025, 16000, 22050, 32000, 44100, 48000,
+		64000, 88200, 96000, 176400, 192000,
+	};
+	unsigned int rates = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pcm_rates); i++) {
+		if (pcm_rates[i] >= rate_min && pcm_rates[i] <= rate_max)
+			rates |= 1 << i;
+	}
+
+	return rates;
+}
+
+static int soc_tplg_dai_create(struct soc_tplg *tplg,
+	struct snd_soc_tplg_pcm *pcm)
+{
+	struct snd_soc_dai_driver *dai_drv;
+	struct snd_soc_pcm_stream *stream;
+	struct snd_soc_tplg_stream_caps *caps;
+	int ret;
+
+	dai_drv = kzalloc(sizeof(struct snd_soc_dai_driver), GFP_KERNEL);
+	if (dai_drv == NULL)
+		return -ENOMEM;
+
+	dai_drv->name = pcm->dai_name;
+	dai_drv->id = pcm->dai_id;
+
+	if (pcm->playback) {
+		stream = &dai_drv->playback;
+		caps = &pcm->caps[SND_SOC_TPLG_STREAM_PLAYBACK];
+
+		stream->stream_name = kstrdup(caps->name, GFP_KERNEL);
+		stream->channels_min = caps->channels_min;
+		stream->channels_max = caps->channels_max;
+		stream->rates = get_rates(caps->rate_min, caps->rate_max);
+		stream->formats = caps->formats;
+	}
+
+	if (pcm->capture) {
+		stream = &dai_drv->capture;
+		caps = &pcm->caps[SND_SOC_TPLG_STREAM_CAPTURE];
+
+		stream->stream_name = kstrdup(caps->name, GFP_KERNEL);
+		stream->channels_min = caps->channels_min;
+		stream->channels_max = caps->channels_max;
+		stream->rates = get_rates(caps->rate_min, caps->rate_max);
+		stream->formats = caps->formats;
+	}
+
+	/* pass control to component driver for optional further init */
+	ret = soc_tplg_dai_load(tplg, dai_drv);
+	if (ret < 0) {
+		dev_err(tplg->comp->dev, "ASoC: DAI loading failed\n");
+		kfree(dai_drv);
+		return ret;
+	}
+
+	dai_drv->dobj.index = tplg->index;
+	dai_drv->dobj.ops = tplg->ops;
+	dai_drv->dobj.type = SND_SOC_DOBJ_PCM;
+	list_add(&dai_drv->dobj.list, &tplg->comp->dobj_list);
+
+	return snd_soc_add_dai(tplg->comp, dai_drv);
+}
+
+static int soc_tplg_pcm_create(struct soc_tplg *tplg,
+	struct snd_soc_tplg_pcm *pcm)
+{
+	return soc_tplg_dai_create(tplg, pcm);
+}
+
+static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 	struct snd_soc_tplg_hdr *hdr)
 {
-	struct snd_soc_tplg_pcm_dai *pcm_dai;
-	struct snd_soc_dobj *dobj;
+	struct snd_soc_tplg_pcm *pcm;
 	int count = hdr->count;
-	int ret;
+	int i;
 
 	if (tplg->pass != SOC_TPLG_PASS_PCM_DAI)
 		return 0;
 
-	pcm_dai = (struct snd_soc_tplg_pcm_dai *)tplg->pos;
+	pcm = (struct snd_soc_tplg_pcm *)tplg->pos;
 
 	if (soc_tplg_check_elem_count(tplg,
 		sizeof(struct snd_soc_tplg_pcm), count,
@@ -1565,31 +1643,16 @@ static int soc_tplg_pcm_dai_elems_load(struct soc_tplg *tplg,
 		return -EINVAL;
 	}
 
+	/* create the FE DAIs and DAI links */
+	for (i = 0; i < count; i++) {
+		soc_tplg_pcm_create(tplg, pcm);
+		pcm++;
+	}
+
 	dev_dbg(tplg->dev, "ASoC: adding %d PCM DAIs\n", count);
 	tplg->pos += sizeof(struct snd_soc_tplg_pcm) * count;
 
-	dobj = kzalloc(sizeof(struct snd_soc_dobj), GFP_KERNEL);
-	if (dobj == NULL)
-		return -ENOMEM;
-
-	/* Call the platform driver call back to register the dais */
-	ret = soc_tplg_pcm_dai_load(tplg, pcm_dai, count);
-	if (ret < 0) {
-		dev_err(tplg->comp->dev, "ASoC: PCM DAI loading failed\n");
-		goto err;
-	}
-
-	dobj->type = get_dobj_type(hdr, NULL);
-	dobj->pcm_dai.count = count;
-	dobj->pcm_dai.pd = pcm_dai;
-	dobj->ops = tplg->ops;
-	dobj->index = tplg->index;
-	list_add(&dobj->list, &tplg->comp->dobj_list);
 	return 0;
-
-err:
-	kfree(dobj);
-	return ret;
 }
 
 static int soc_tplg_manifest_load(struct soc_tplg *tplg,
@@ -1683,7 +1746,7 @@ static int soc_tplg_load_header(struct soc_tplg *tplg,
 	case SND_SOC_TPLG_TYPE_PCM:
 	case SND_SOC_TPLG_TYPE_DAI_LINK:
 	case SND_SOC_TPLG_TYPE_CODEC_LINK:
-		return soc_tplg_pcm_dai_elems_load(tplg, hdr);
+		return soc_tplg_pcm_elems_load(tplg, hdr);
 	case SND_SOC_TPLG_TYPE_MANIFEST:
 		return soc_tplg_manifest_load(tplg, hdr);
 	default:
-- 
1.9.1
