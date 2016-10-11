From: mengdong.lin@linux.intel.com
Subject: [PATCH v6 02/11] ASoC: topology: Make PCM backward
	compatible from ABI v4
Date: Tue, 11 Oct 2016 14:36:49 +0800
Message-ID: <84e2ad13cc7ac401b62e421352b7af49fd7876a5.1476166990.git.mengdong.lin@linux.intel.com>
References: <cover.1476166990.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AFEA265284
 for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2016 08:36:03 +0200 (CEST)
In-Reply-To: <cover.1476166990.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This patch adds support for old version 4 of PCMs (FE DAI & DAI links).

Topology ABI v5 added new fields to stream caps and thus changed PCMs.
Since user space may still uses v4, kernel will check the ABI version by
comparing the object size. If user space uses v4 of PCMs, kernel will
create the latest version of PCMs from the old version, and use the new
version internally to create FE DAI & DAI links. Because these new created
PCM elements will be freed later, kernel need duplicate the name strings
of DAI driver and DAI links when creating them.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index c832b24..0f1c8eb 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -53,7 +53,6 @@
 #define SOC_TPLG_PASS_START	SOC_TPLG_PASS_MANIFEST
 #define SOC_TPLG_PASS_END	SOC_TPLG_PASS_BE_DAI
 
-
 /*
  * Old version of ABI structs, supported for backward compatibility.
  */
@@ -69,6 +68,39 @@ struct snd_soc_tplg_manifest_v4 {
 	struct snd_soc_tplg_private priv;
 } __packed;
 
+/* Stream Capabilities v4 */
+struct snd_soc_tplg_stream_caps_v4 {
+	__le32 size;		/* in bytes of this structure */
+	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	__le64 formats;	/* supported formats SNDRV_PCM_FMTBIT_* */
+	__le32 rates;		/* supported rates SNDRV_PCM_RATE_* */
+	__le32 rate_min;	/* min rate */
+	__le32 rate_max;	/* max rate */
+	__le32 channels_min;	/* min channels */
+	__le32 channels_max;	/* max channels */
+	__le32 periods_min;	/* min number of periods */
+	__le32 periods_max;	/* max number of periods */
+	__le32 period_size_min;	/* min period size bytes */
+	__le32 period_size_max;	/* max period size bytes */
+	__le32 buffer_size_min;	/* min buffer size bytes */
+	__le32 buffer_size_max;	/* max buffer size bytes */
+} __packed;
+
+/* PCM v4 */
+struct snd_soc_tplg_pcm_v4 {
+	__le32 size;		/* in bytes of this structure */
+	char pcm_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	char dai_name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	__le32 pcm_id;		/* unique ID - used to match with DAI link */
+	__le32 dai_id;		/* unique ID - used to match */
+	__le32 playback;	/* supports playback mode */
+	__le32 capture;		/* supports capture mode */
+	__le32 compress;	/* 1 = compressed; 0 = PCM */
+	struct snd_soc_tplg_stream stream[SND_SOC_TPLG_STREAM_CONFIG_MAX]; /* for DAI link */
+	__le32 num_streams;	/* number of streams */
+	struct snd_soc_tplg_stream_caps_v4 caps[2]; /* playback and capture for DAI */
+} __packed;
+
 /* topology context */
 struct soc_tplg {
 	const struct firmware *fw;
@@ -491,6 +523,7 @@ static void remove_dai(struct snd_soc_component *comp,
 	if (dobj->ops && dobj->ops->dai_unload)
 		dobj->ops->dai_unload(comp, dobj);
 
+	kfree(dai_drv->name);
 	list_del(&dobj->list);
 	kfree(dai_drv);
 }
@@ -508,6 +541,10 @@ static void remove_link(struct snd_soc_component *comp,
 	if (dobj->ops && dobj->ops->link_unload)
 		dobj->ops->link_unload(comp, dobj);
 
+	kfree(link->name);
+	kfree(link->stream_name);
+	kfree(link->cpu_dai_name);
+
 	list_del(&dobj->list);
 	snd_soc_remove_dai_link(comp->card, link);
 	kfree(link);
@@ -1606,7 +1643,8 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	if (dai_drv == NULL)
 		return -ENOMEM;
 
-	dai_drv->name = pcm->dai_name;
+	if (strlen(pcm->dai_name))
+		dai_drv->name = kstrdup(pcm->dai_name, GFP_KERNEL);
 	dai_drv->id = pcm->dai_id;
 
 	if (pcm->playback) {
@@ -1649,11 +1687,15 @@ static int soc_tplg_link_create(struct soc_tplg *tplg,
 	if (link == NULL)
 		return -ENOMEM;
 
-	link->name = pcm->pcm_name;
-	link->stream_name = pcm->pcm_name;
+	if (strlen(pcm->pcm_name)) {
+		link->name = kstrdup(pcm->pcm_name, GFP_KERNEL);
+		link->stream_name = kstrdup(pcm->pcm_name, GFP_KERNEL);
+	}
 	link->id = pcm->pcm_id;
 
-	link->cpu_dai_name = pcm->dai_name;
+	if (strlen(pcm->dai_name))
+		link->cpu_dai_name = kstrdup(pcm->dai_name, GFP_KERNEL);
+
 	link->codec_name = "snd-soc-dummy";
 	link->codec_dai_name = "snd-soc-dummy-dai";
 
@@ -1692,38 +1734,127 @@ static int soc_tplg_pcm_create(struct soc_tplg *tplg,
 	return  soc_tplg_link_create(tplg, pcm);
 }
 
+/* copy stream caps from the old version 4 of source */
+static void stream_caps_new_ver(struct snd_soc_tplg_stream_caps *dest,
+				struct snd_soc_tplg_stream_caps_v4 *src)
+{
+	dest->size = sizeof(*dest);
+	memcpy(dest->name, src->name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	dest->formats = src->formats;
+	dest->rates = src->rates;
+	dest->rate_min = src->rate_min;
+	dest->rate_max = src->rate_max;
+	dest->channels_min = src->channels_min;
+	dest->channels_max = src->channels_max;
+	dest->periods_min = src->periods_min;
+	dest->periods_max = src->periods_max;
+	dest->period_size_min = src->period_size_min;
+	dest->period_size_max = src->period_size_max;
+	dest->buffer_size_min = src->buffer_size_min;
+	dest->buffer_size_max = src->buffer_size_max;
+}
+
+/**
+ * pcm_new_ver - Create the new version of PCM from the old version.
+ * @tplg: topology context
+ * @src: older version of pcm as a source
+ * @pcm: latest version of pcm created from the source
+ *
+ * Support from vesion 4. User should free the returned pcm manually.
+ */
+static int pcm_new_ver(struct soc_tplg *tplg,
+		       struct snd_soc_tplg_pcm *src,
+		       struct snd_soc_tplg_pcm **pcm)
+{
+	struct snd_soc_tplg_pcm *dest;
+	struct snd_soc_tplg_pcm_v4 *src_v4;
+	int i;
+
+	*pcm = NULL;
+
+	if (src->size != sizeof(*src_v4)) {
+		dev_err(tplg->dev, "ASoC: invalid PCM size\n");
+		return -EINVAL;
+	}
+
+	dev_warn(tplg->dev, "ASoC: old version of PCM\n");
+	src_v4 = (struct snd_soc_tplg_pcm_v4 *)src;
+	dest = kzalloc(sizeof(*dest), GFP_KERNEL);
+	if (!dest)
+		return -ENOMEM;
+
+	dest->size = sizeof(*dest);	/* size of latest abi version */
+	memcpy(dest->pcm_name, src_v4->pcm_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	memcpy(dest->dai_name, src_v4->dai_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	dest->pcm_id = src_v4->pcm_id;
+	dest->dai_id = src_v4->dai_id;
+	dest->playback = src_v4->playback;
+	dest->capture = src_v4->capture;
+	dest->compress = src_v4->compress;
+	dest->num_streams = src_v4->num_streams;
+	for (i = 0; i < dest->num_streams; i++)
+		memcpy(&dest->stream[i], &src_v4->stream[i],
+		       sizeof(struct snd_soc_tplg_stream));
+
+	for (i = 0; i < 2; i++)
+		stream_caps_new_ver(&dest->caps[i], &src_v4->caps[i]);
+
+	*pcm = dest;
+	return 0;
+}
+
 static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 	struct snd_soc_tplg_hdr *hdr)
 {
-	struct snd_soc_tplg_pcm *pcm;
+	struct snd_soc_tplg_pcm *pcm, *_pcm;
 	int count = hdr->count;
-	int i;
+	int i, err;
+	bool abi_match;
 
 	if (tplg->pass != SOC_TPLG_PASS_PCM_DAI)
 		return 0;
 
+	/* check the element size and count */
+	pcm = (struct snd_soc_tplg_pcm *)tplg->pos;
+	if (pcm->size > sizeof(struct snd_soc_tplg_pcm)
+		|| pcm->size < sizeof(struct snd_soc_tplg_pcm_v4)) {
+		dev_err(tplg->dev, "ASoC: invalid size %d for PCM elems\n",
+			pcm->size);
+		return -EINVAL;
+	}
+
 	if (soc_tplg_check_elem_count(tplg,
-		sizeof(struct snd_soc_tplg_pcm), count,
+		pcm->size, count,
 		hdr->payload_size, "PCM DAI")) {
 		dev_err(tplg->dev, "ASoC: invalid count %d for PCM DAI elems\n",
 			count);
 		return -EINVAL;
 	}
 
-	/* create the FE DAIs and DAI links */
-	pcm = (struct snd_soc_tplg_pcm *)tplg->pos;
 	for (i = 0; i < count; i++) {
-		if (pcm->size != sizeof(*pcm)) {
-			dev_err(tplg->dev, "ASoC: invalid pcm size\n");
-			return -EINVAL;
+		pcm = (struct snd_soc_tplg_pcm *)tplg->pos;
+
+		/* check ABI version by size, create a new version of pcm
+		 * if abi not match.
+		 */
+		if (pcm->size == sizeof(*pcm)) {
+			abi_match = true;
+			_pcm = pcm;
+		} else {
+			abi_match = false;
+			err = pcm_new_ver(tplg, pcm, &_pcm);
 		}
 
-		soc_tplg_pcm_create(tplg, pcm);
-		pcm++;
+		/* create the FE DAIs and DAI links */
+		soc_tplg_pcm_create(tplg, _pcm);
+
+		if (!abi_match)
+			kfree(_pcm); /* free the duplicated one */
+
+		tplg->pos += pcm->size; /* offset by version-specific size */
 	}
 
 	dev_dbg(tplg->dev, "ASoC: adding %d PCM DAIs\n", count);
-	tplg->pos += sizeof(struct snd_soc_tplg_pcm) * count;
 
 	return 0;
 }
-- 
2.5.0
