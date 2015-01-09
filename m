From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: Intel: Split hsw_pcm_data for playback
	and capture
Date: Fri,  9 Jan 2015 14:36:36 +0800
Message-ID: <1420785396-15067-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 2077A2605E9
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 07:35:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

There may be 2 pcm streams for a same DAI at most, and these 2
streams should have different hsw_pcm_data, e.g. they have
different persistent data, so here we need split hsw_pcm_data
for playback and capture, to make sure they won't be mixed
and keep cleaned.

Signed-off-by: Jie Yang <yang.jie@intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-haswell-pcm.c | 91 ++++++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 30 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 5448f79..ad7f4a5 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -135,7 +135,17 @@ struct hsw_priv_data {
 	struct snd_dma_buffer dmab[HSW_PCM_COUNT][2];
 
 	/* DAI data */
-	struct hsw_pcm_data pcm[HSW_PCM_COUNT];
+	struct hsw_pcm_data pcm[HSW_PCM_COUNT][2];
+};
+
+
+/* static mappings between PCMs and modules - may be dynamic in future */
+static struct hsw_pcm_module_map mod_map[] = {
+	{HSW_PCM_DAI_ID_SYSTEM, 0, SST_HSW_MODULE_PCM_SYSTEM},
+	{HSW_PCM_DAI_ID_OFFLOAD0, 0, SST_HSW_MODULE_PCM},
+	{HSW_PCM_DAI_ID_OFFLOAD1, 0, SST_HSW_MODULE_PCM},
+	{HSW_PCM_DAI_ID_LOOPBACK, 1, SST_HSW_MODULE_PCM_REFERENCE},
+	{HSW_PCM_DAI_ID_SYSTEM, 1, SST_HSW_MODULE_PCM_CAPTURE},
 };
 
 static u32 hsw_notify_pointer(struct sst_hsw_stream *stream, void *data);
@@ -168,9 +178,14 @@ static int hsw_stream_volume_put(struct snd_kcontrol *kcontrol,
 		(struct soc_mixer_control *)kcontrol->private_value;
 	struct hsw_priv_data *pdata =
 		snd_soc_platform_get_drvdata(platform);
-	struct hsw_pcm_data *pcm_data = &pdata->pcm[mc->reg];
+	struct hsw_pcm_data *pcm_data;
 	struct sst_hsw *hsw = pdata->hsw;
 	u32 volume;
+	int dai, stream;
+
+	dai = mod_map[mc->reg].dai_id;
+	stream = mod_map[mc->reg].stream;
+	pcm_data = &pdata->pcm[dai][stream];
 
 	mutex_lock(&pcm_data->mutex);
 	pm_runtime_get_sync(pdata->dev);
@@ -212,9 +227,14 @@ static int hsw_stream_volume_get(struct snd_kcontrol *kcontrol,
 		(struct soc_mixer_control *)kcontrol->private_value;
 	struct hsw_priv_data *pdata =
 		snd_soc_platform_get_drvdata(platform);
-	struct hsw_pcm_data *pcm_data = &pdata->pcm[mc->reg];
+	struct hsw_pcm_data *pcm_data;
 	struct sst_hsw *hsw = pdata->hsw;
 	u32 volume;
+	int dai, stream;
+
+	dai = mod_map[mc->reg].dai_id;
+	stream = mod_map[mc->reg].stream;
+	pcm_data = &pdata->pcm[dai][stream];
 
 	mutex_lock(&pcm_data->mutex);
 	pm_runtime_get_sync(pdata->dev);
@@ -309,7 +329,7 @@ static const struct snd_kcontrol_new hsw_volume_controls[] = {
 		ARRAY_SIZE(volume_map) - 1, 0,
 		hsw_stream_volume_get, hsw_stream_volume_put, hsw_vol_tlv),
 	/* Mic Capture volume */
-	SOC_DOUBLE_EXT_TLV("Mic Capture Volume", 0, 0, 8,
+	SOC_DOUBLE_EXT_TLV("Mic Capture Volume", 4, 0, 8,
 		ARRAY_SIZE(volume_map) - 1, 0,
 		hsw_stream_volume_get, hsw_stream_volume_put, hsw_vol_tlv),
 };
@@ -353,7 +373,7 @@ static int hsw_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct hsw_priv_data *pdata =
 		snd_soc_platform_get_drvdata(rtd->platform);
-	struct hsw_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(rtd);
+	struct hsw_pcm_data *pcm_data;
 	struct sst_hsw *hsw = pdata->hsw;
 	struct sst_module *module_data;
 	struct sst_dsp *dsp;
@@ -362,7 +382,10 @@ static int hsw_pcm_hw_params(struct snd_pcm_substream *substream,
 	enum sst_hsw_stream_path_id path_id;
 	u32 rate, bits, map, pages, module_id;
 	u8 channels;
-	int ret;
+	int ret, dai;
+
+	dai = mod_map[rtd->cpu_dai->id].dai_id;
+	pcm_data = &pdata->pcm[dai][substream->stream];
 
 	/* check if we are being called a subsequent time */
 	if (pcm_data->allocated) {
@@ -552,8 +575,12 @@ static int hsw_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct hsw_priv_data *pdata =
 		snd_soc_platform_get_drvdata(rtd->platform);
-	struct hsw_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(rtd);
+	struct hsw_pcm_data *pcm_data;
 	struct sst_hsw *hsw = pdata->hsw;
+	int dai;
+
+	dai = mod_map[rtd->cpu_dai->id].dai_id;
+	pcm_data = &pdata->pcm[dai][substream->stream];
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -597,11 +624,16 @@ static snd_pcm_uframes_t hsw_pcm_pointer(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct hsw_priv_data *pdata =
 		snd_soc_platform_get_drvdata(rtd->platform);
-	struct hsw_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(rtd);
+	struct hsw_pcm_data *pcm_data;
 	struct sst_hsw *hsw = pdata->hsw;
 	snd_pcm_uframes_t offset;
 	uint64_t ppos;
-	u32 position = sst_hsw_get_dsp_position(hsw, pcm_data->stream);
+	u32 position;
+	int dai;
+
+	dai = mod_map[rtd->cpu_dai->id].dai_id;
+	pcm_data = &pdata->pcm[dai][substream->stream];
+	position = sst_hsw_get_dsp_position(hsw, pcm_data->stream);
 
 	offset = bytes_to_frames(runtime, position);
 	ppos = sst_hsw_get_dsp_presentation_position(hsw, pcm_data->stream);
@@ -618,8 +650,10 @@ static int hsw_pcm_open(struct snd_pcm_substream *substream)
 		snd_soc_platform_get_drvdata(rtd->platform);
 	struct hsw_pcm_data *pcm_data;
 	struct sst_hsw *hsw = pdata->hsw;
+	int dai;
 
-	pcm_data = &pdata->pcm[rtd->cpu_dai->id];
+	dai = mod_map[rtd->cpu_dai->id].dai_id;
+	pcm_data = &pdata->pcm[dai][substream->stream];
 
 	mutex_lock(&pcm_data->mutex);
 	pm_runtime_get_sync(pdata->dev);
@@ -648,9 +682,12 @@ static int hsw_pcm_close(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct hsw_priv_data *pdata =
 		snd_soc_platform_get_drvdata(rtd->platform);
-	struct hsw_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(rtd);
+	struct hsw_pcm_data *pcm_data;
 	struct sst_hsw *hsw = pdata->hsw;
-	int ret;
+	int ret, dai;
+
+	dai = mod_map[rtd->cpu_dai->id].dai_id;
+	pcm_data = &pdata->pcm[dai][substream->stream];
 
 	mutex_lock(&pcm_data->mutex);
 	ret = sst_hsw_stream_reset(hsw, pcm_data->stream);
@@ -685,15 +722,6 @@ static struct snd_pcm_ops hsw_pcm_ops = {
 	.page		= snd_pcm_sgbuf_ops_page,
 };
 
-/* static mappings between PCMs and modules - may be dynamic in future */
-static struct hsw_pcm_module_map mod_map[] = {
-	{HSW_PCM_DAI_ID_SYSTEM, 0, SST_HSW_MODULE_PCM_SYSTEM},
-	{HSW_PCM_DAI_ID_OFFLOAD0, 0, SST_HSW_MODULE_PCM},
-	{HSW_PCM_DAI_ID_OFFLOAD1, 0, SST_HSW_MODULE_PCM},
-	{HSW_PCM_DAI_ID_LOOPBACK, 1, SST_HSW_MODULE_PCM_REFERENCE},
-	{HSW_PCM_DAI_ID_SYSTEM, 1, SST_HSW_MODULE_PCM_CAPTURE},
-};
-
 static int hsw_pcm_create_modules(struct hsw_priv_data *pdata)
 {
 	struct sst_hsw *hsw = pdata->hsw;
@@ -701,7 +729,7 @@ static int hsw_pcm_create_modules(struct hsw_priv_data *pdata)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(mod_map); i++) {
-		pcm_data = &pdata->pcm[i];
+		pcm_data = &pdata->pcm[mod_map[i].dai_id][mod_map[i].stream];
 
 		/* create new runtime module, use same offset if recreated */
 		pcm_data->runtime = sst_hsw_runtime_module_create(hsw,
@@ -716,7 +744,7 @@ static int hsw_pcm_create_modules(struct hsw_priv_data *pdata)
 
 err:
 	for (--i; i >= 0; i--) {
-		pcm_data = &pdata->pcm[i];
+		pcm_data = &pdata->pcm[mod_map[i].dai_id][mod_map[i].stream];
 		sst_hsw_runtime_module_free(pcm_data->runtime);
 	}
 
@@ -729,7 +757,7 @@ static void hsw_pcm_free_modules(struct hsw_priv_data *pdata)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(mod_map); i++) {
-		pcm_data = &pdata->pcm[i];
+		pcm_data = &pdata->pcm[mod_map[i].dai_id][mod_map[i].stream];
 
 		sst_hsw_runtime_module_free(pcm_data->runtime);
 	}
@@ -757,7 +785,10 @@ static int hsw_pcm_new(struct snd_soc_pcm_runtime *rtd)
 			return ret;
 		}
 	}
-	priv_data->pcm[rtd->cpu_dai->id].hsw_pcm = pcm;
+	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream)
+		priv_data->pcm[rtd->cpu_dai->id][SNDRV_PCM_STREAM_PLAYBACK].hsw_pcm = pcm;
+	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream)
+		priv_data->pcm[rtd->cpu_dai->id][SNDRV_PCM_STREAM_CAPTURE].hsw_pcm = pcm;
 
 	return ret;
 }
@@ -866,10 +897,9 @@ static int hsw_pcm_probe(struct snd_soc_platform *platform)
 	/* allocate DSP buffer page tables */
 	for (i = 0; i < ARRAY_SIZE(hsw_dais); i++) {
 
-		mutex_init(&priv_data->pcm[i].mutex);
-
 		/* playback */
 		if (hsw_dais[i].playback.channels_min) {
+			mutex_init(&priv_data->pcm[i][SNDRV_PCM_STREAM_PLAYBACK].mutex);
 			ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, dma_dev,
 				PAGE_SIZE, &priv_data->dmab[i][0]);
 			if (ret < 0)
@@ -878,6 +908,7 @@ static int hsw_pcm_probe(struct snd_soc_platform *platform)
 
 		/* capture */
 		if (hsw_dais[i].capture.channels_min) {
+			mutex_init(&priv_data->pcm[i][SNDRV_PCM_STREAM_CAPTURE].mutex);
 			ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, dma_dev,
 				PAGE_SIZE, &priv_data->dmab[i][1]);
 			if (ret < 0)
@@ -1076,7 +1107,7 @@ static void hsw_pcm_complete(struct device *dev)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(mod_map); i++) {
-		pcm_data = &pdata->pcm[i];
+		pcm_data = &pdata->pcm[mod_map[i].dai_id][mod_map[i].stream];
 
 		if (!pcm_data->substream)
 			continue;
@@ -1110,7 +1141,7 @@ static int hsw_pcm_prepare(struct device *dev)
 		return 0;
 	/* suspend all active streams */
 	for (i = 0; i < ARRAY_SIZE(mod_map); i++) {
-		pcm_data = &pdata->pcm[i];
+		pcm_data = &pdata->pcm[mod_map[i].dai_id][mod_map[i].stream];
 
 		if (!pcm_data->substream)
 			continue;
@@ -1129,7 +1160,7 @@ static int hsw_pcm_prepare(struct device *dev)
 
 	/* preserve persistent memory */
 	for (i = 0; i < ARRAY_SIZE(mod_map); i++) {
-		pcm_data = &pdata->pcm[i];
+		pcm_data = &pdata->pcm[mod_map[i].dai_id][mod_map[i].stream];
 
 		if (!pcm_data->substream)
 			continue;
-- 
1.9.1
