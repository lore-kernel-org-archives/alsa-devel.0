From: mengdong.lin@intel.com
Subject: [PATCH v2 10/10] ASOC: topology: Add PCM DAIs
	dynamically when loading them
Date: Mon, 10 Aug 2015 22:48:45 +0800
Message-ID: <71fcd5340f44c26261883c416f4575cd52d38333.1439217448.git.mengdong.lin@intel.com>
References: <cover.1439217448.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 3403A2659CC
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 16:35:28 +0200 (CEST)
In-Reply-To: <cover.1439217448.git.mengdong.lin@intel.com>
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
Cc: tiwai@suse.de, Mengdong Lin <mengdong.lin@intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

Add PCM DAIs to ASoC core when loading them from topology.
Embed dobj in the DAI to free it when unloading.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 2df96b1..e8f0404 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -207,6 +207,7 @@ struct snd_soc_dai_driver {
 	const char *name;
 	unsigned int id;
 	unsigned int base;
+	struct snd_soc_dobj dobj;
 
 	/* DAI driver callbacks */
 	int (*probe)(struct snd_soc_dai *dai);
diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index 5405f64..a49c134 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -71,7 +71,6 @@ struct snd_soc_dobj {
 	union {
 		struct snd_soc_dobj_control control;
 		struct snd_soc_dobj_widget widget;
-		struct snd_soc_dobj_pcm_dai pcm_dai;
 	};
 	void *private; /* core does not touch this */
 };
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 0f8fa0d..6c0dd3f 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -499,6 +499,9 @@ static void remove_widget(struct snd_soc_component *comp,
 static void remove_pcm_dai(struct snd_soc_component *comp,
 	struct snd_soc_dobj *dobj, int pass)
 {
+	struct snd_soc_dai_driver *dai =
+		container_of(dobj, struct snd_soc_dai_driver, dobj);
+
 	if (pass != SOC_TPLG_PASS_PCM_DAI)
 		return;
 
@@ -506,7 +509,7 @@ static void remove_pcm_dai(struct snd_soc_component *comp,
 		dobj->ops->pcm_dai_unload(comp, dobj);
 
 	list_del(&dobj->list);
-	kfree(dobj);
+	kfree(dai);
 }
 
 /* bind a kcontrol to it's IO handlers */
@@ -1558,12 +1561,75 @@ static int soc_tplg_dapm_complete(struct soc_tplg *tplg)
 	return 0;
 }
 
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
+static int soc_tplg_pcm_dai_create(struct soc_tplg *tplg,
+	struct snd_soc_tplg_pcm_dai *dai)
+{
+	struct snd_soc_dai_driver *dai_drv;
+	struct snd_soc_pcm_stream *stream;
+	struct snd_soc_tplg_stream_caps *caps;
+
+	dai_drv = kzalloc(sizeof(struct snd_soc_dai_driver), GFP_KERNEL);
+	if (dai_drv == NULL)
+		return -ENOMEM;
+
+	dai_drv->name = dai->name;
+	dai_drv->id = dai->id;
+	dai_drv->compress_dai = dai->compress;
+
+	if (dai->playback) {
+		stream = &dai_drv->playback;
+		caps = &dai->capconf[SND_SOC_TPLG_STREAM_PLAYBACK].caps;
+
+		stream->stream_name = kstrdup(caps->name, GFP_KERNEL);
+		stream->channels_min = caps->channels_min;
+		stream->channels_max = caps->channels_max;
+		stream->rates = get_rates(caps->rate_min, caps->rate_max);
+		stream->formats = caps->formats;
+	}
+
+	if (dai->capture) {
+		stream = &dai_drv->capture;
+		caps = &dai->capconf[SND_SOC_TPLG_STREAM_CAPTURE].caps;
+
+		stream->stream_name = kstrdup(caps->name, GFP_KERNEL);
+		stream->channels_min = caps->channels_min;
+		stream->channels_max = caps->channels_max;
+		stream->rates = get_rates(caps->rate_min, caps->rate_max);
+		stream->formats = caps->formats;
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
 static int soc_tplg_pcm_dai_elems_load(struct soc_tplg *tplg,
 	struct snd_soc_tplg_hdr *hdr)
 {
 	struct snd_soc_tplg_pcm_dai *pcm_dai;
 	struct snd_soc_dobj *dobj;
 	int count = hdr->count;
+	int i;
 	int ret;
 
 	if (tplg->pass != SOC_TPLG_PASS_PCM_DAI)
@@ -1579,26 +1645,21 @@ static int soc_tplg_pcm_dai_elems_load(struct soc_tplg *tplg,
 		return -EINVAL;
 	}
 
-	dev_dbg(tplg->dev, "ASoC: adding %d PCM DAIs\n", count);
-	tplg->pos += sizeof(struct snd_soc_tplg_pcm_dai) * count;
-
-	dobj = kzalloc(sizeof(struct snd_soc_dobj), GFP_KERNEL);
-	if (dobj == NULL)
-		return -ENOMEM;
-
-	/* Call the platform driver call back to register the dais */
+	/* pass control to driver for optional further init */
 	ret = soc_tplg_pcm_dai_load(tplg, pcm_dai, count);
 	if (ret < 0) {
 		dev_err(tplg->comp->dev, "ASoC: PCM DAI loading failed\n");
 		goto err;
 	}
 
-	dobj->type = get_dobj_type(hdr, NULL);
-	dobj->pcm_dai.count = count;
-	dobj->pcm_dai.pd = pcm_dai;
-	dobj->ops = tplg->ops;
-	dobj->index = tplg->index;
-	list_add(&dobj->list, &tplg->comp->dobj_list);
+	/* register the dais */
+	for (i = 0; i < count; i++) {
+		soc_tplg_pcm_dai_create(tplg, pcm_dai);
+		pcm_dai++;
+	}
+
+	dev_dbg(tplg->dev, "ASoC: adding %d PCM DAIs\n", count);
+	tplg->pos += sizeof(struct snd_soc_tplg_pcm_dai) * count;
 	return 0;
 
 err:
-- 
1.9.1
