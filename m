From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ASoC: Intel: Fix Haswell/Broadwell DSP page
	table creation.
Date: Fri,  2 May 2014 16:56:30 +0100
Message-ID: <1399046194-5544-4-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1399046194-5544-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F76B261AC1
 for <alsa-devel@alsa-project.org>; Fri,  2 May 2014 17:56:54 +0200 (CEST)
In-Reply-To: <1399046194-5544-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix page table creation on Haswell and Broadwell to remove unsafe
virt_to_phys mappings and use more portable SG buffer. Use audio buffer
APIs to allocate DMA buffers.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/sst-haswell-pcm.c | 58 +++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/sound/soc/intel/sst-haswell-pcm.c b/sound/soc/intel/sst-haswell-pcm.c
index 0a32dd1..dc53f50 100644
--- a/sound/soc/intel/sst-haswell-pcm.c
+++ b/sound/soc/intel/sst-haswell-pcm.c
@@ -107,7 +107,7 @@ struct hsw_priv_data {
 	struct sst_hsw *hsw;
 
 	/* page tables */
-	unsigned char *pcm_pg[HSW_PCM_COUNT][2];
+	struct snd_dma_buffer dmab[HSW_PCM_COUNT][2];
 
 	/* DAI data */
 	struct hsw_pcm_data pcm[HSW_PCM_COUNT];
@@ -273,28 +273,26 @@ static const struct snd_kcontrol_new hsw_volume_controls[] = {
 };
 
 /* Create DMA buffer page table for DSP */
-static int create_adsp_page_table(struct hsw_priv_data *pdata,
-	struct snd_soc_pcm_runtime *rtd,
-	unsigned char *dma_area, size_t size, int pcm, int stream)
+static int create_adsp_page_table(struct snd_pcm_substream *substream,
+	struct hsw_priv_data *pdata, struct snd_soc_pcm_runtime *rtd,
+	unsigned char *dma_area, size_t size, int pcm)
 {
-	int i, pages;
+	struct snd_dma_buffer *dmab = snd_pcm_get_dma_buf(substream);
+	int i, pages, stream = substream->stream;
 
-	if (size % PAGE_SIZE)
-		pages = (size / PAGE_SIZE) + 1;
-	else
-		pages = size / PAGE_SIZE;
+	pages = snd_sgbuf_aligned_pages(size);
 
 	dev_dbg(rtd->dev, "generating page table for %p size 0x%zu pages %d\n",
 		dma_area, size, pages);
 
 	for (i = 0; i < pages; i++) {
 		u32 idx = (((i << 2) + i)) >> 1;
-		u32 pfn = (virt_to_phys(dma_area + i * PAGE_SIZE)) >> PAGE_SHIFT;
+		u32 pfn = snd_sgbuf_get_addr(dmab, i * PAGE_SIZE) >> PAGE_SHIFT;
 		u32 *pg_table;
 
 		dev_dbg(rtd->dev, "pfn i %i idx %d pfn %x\n", i, idx, pfn);
 
-		pg_table = (u32*)(pdata->pcm_pg[pcm][stream] + idx);
+		pg_table = (u32 *)(pdata->dmab[pcm][stream].area + idx);
 
 		if (i & 1)
 			*pg_table |= (pfn << 4);
@@ -317,6 +315,7 @@ static int hsw_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct sst_hsw *hsw = pdata->hsw;
 	struct sst_module *module_data;
 	struct sst_dsp *dsp;
+	struct snd_dma_buffer *dmab;
 	enum sst_hsw_stream_type stream_type;
 	enum sst_hsw_stream_path_id path_id;
 	u32 rate, bits, map, pages, module_id;
@@ -416,8 +415,10 @@ static int hsw_pcm_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	ret = create_adsp_page_table(pdata, rtd, runtime->dma_area,
-		runtime->dma_bytes, rtd->cpu_dai->id, substream->stream);
+	dmab = snd_pcm_get_dma_buf(substream);
+
+	ret = create_adsp_page_table(substream, pdata, rtd, runtime->dma_area,
+		runtime->dma_bytes, rtd->cpu_dai->id);
 	if (ret < 0)
 		return ret;
 
@@ -430,9 +431,9 @@ static int hsw_pcm_hw_params(struct snd_pcm_substream *substream,
 		pages = runtime->dma_bytes / PAGE_SIZE;
 
 	ret = sst_hsw_stream_buffer(hsw, pcm_data->stream,
-		virt_to_phys(pdata->pcm_pg[rtd->cpu_dai->id][substream->stream]),
+		pdata->dmab[rtd->cpu_dai->id][substream->stream].addr,
 		pages, runtime->dma_bytes, 0,
-		(u32)(virt_to_phys(runtime->dma_area) >> PAGE_SHIFT));
+		snd_sgbuf_get_addr(dmab, 0) >> PAGE_SHIFT);
 	if (ret < 0) {
 		dev_err(rtd->dev, "error: failed to set DMA buffer %d\n", ret);
 		return ret;
@@ -621,7 +622,7 @@ static struct snd_pcm_ops hsw_pcm_ops = {
 	.hw_free	= hsw_pcm_hw_free,
 	.trigger	= hsw_pcm_trigger,
 	.pointer	= hsw_pcm_pointer,
-	.mmap		= snd_pcm_lib_default_mmap,
+	.page		= snd_pcm_sgbuf_ops_page,
 };
 
 static void hsw_pcm_free(struct snd_pcm *pcm)
@@ -641,7 +642,7 @@ static int hsw_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream ||
 			pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
 		ret = snd_pcm_lib_preallocate_pages_for_all(pcm,
-			SNDRV_DMA_TYPE_DEV,
+			SNDRV_DMA_TYPE_DEV_SG,
 			rtd->card->dev,
 			hsw_pcm_hardware.buffer_bytes_max,
 			hsw_pcm_hardware.buffer_bytes_max);
@@ -742,7 +743,8 @@ static int hsw_pcm_probe(struct snd_soc_platform *platform)
 {
 	struct sst_pdata *pdata = dev_get_platdata(platform->dev);
 	struct hsw_priv_data *priv_data;
-	int i;
+	struct device *dma_dev = pdata->dma_dev;
+	int i, ret = 0;
 
 	if (!pdata)
 		return -ENODEV;
@@ -758,15 +760,17 @@ static int hsw_pcm_probe(struct snd_soc_platform *platform)
 
 		/* playback */
 		if (hsw_dais[i].playback.channels_min) {
-			priv_data->pcm_pg[i][0] = kzalloc(PAGE_SIZE, GFP_DMA);
-			if (priv_data->pcm_pg[i][0] == NULL)
+			ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, dma_dev,
+				PAGE_SIZE, &priv_data->dmab[i][0]);
+			if (ret < 0)
 				goto err;
 		}
 
 		/* capture */
 		if (hsw_dais[i].capture.channels_min) {
-			priv_data->pcm_pg[i][1] = kzalloc(PAGE_SIZE, GFP_DMA);
-			if (priv_data->pcm_pg[i][1] == NULL)
+			ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, dma_dev,
+				PAGE_SIZE, &priv_data->dmab[i][1]);
+			if (ret < 0)
 				goto err;
 		}
 	}
@@ -776,11 +780,11 @@ static int hsw_pcm_probe(struct snd_soc_platform *platform)
 err:
 	for (;i >= 0; i--) {
 		if (hsw_dais[i].playback.channels_min)
-			kfree(priv_data->pcm_pg[i][0]);
+			snd_dma_free_pages(&priv_data->dmab[i][0]);
 		if (hsw_dais[i].capture.channels_min)
-			kfree(priv_data->pcm_pg[i][1]);
+			snd_dma_free_pages(&priv_data->dmab[i][1]);
 	}
-	return -ENOMEM;
+	return ret;
 }
 
 static int hsw_pcm_remove(struct snd_soc_platform *platform)
@@ -791,9 +795,9 @@ static int hsw_pcm_remove(struct snd_soc_platform *platform)
 
 	for (i = 0; i < ARRAY_SIZE(hsw_dais); i++) {
 		if (hsw_dais[i].playback.channels_min)
-			kfree(priv_data->pcm_pg[i][0]);
+			snd_dma_free_pages(&priv_data->dmab[i][0]);
 		if (hsw_dais[i].capture.channels_min)
-			kfree(priv_data->pcm_pg[i][1]);
+			snd_dma_free_pages(&priv_data->dmab[i][1]);
 	}
 
 	return 0;
-- 
1.9.1
