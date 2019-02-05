From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/20] ASoC: intel: Drop superfluous PCM
	preallocation error checks
Date: Tue,  5 Feb 2019 20:42:12 +0100
Message-ID: <20190205194221.25924-12-tiwai@suse.de>
References: <20190205194221.25924-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 70FE2267917
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 20:42:28 +0100 (CET)
In-Reply-To: <20190205194221.25924-1-tiwai@suse.de>
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
Cc: Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

snd_pcm_lib_preallocate_pages() and co always succeed, so the error
check is simply redundant.  Drop it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |  9 ++-------
 sound/soc/intel/baytrail/sst-baytrail-pcm.c  | 15 ++++-----------
 sound/soc/intel/haswell/sst-haswell-pcm.c    | 10 ++--------
 sound/soc/intel/skylake/skl-pcm.c            |  9 ++-------
 4 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 91a2436ce952..985abda3bfbb 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -687,20 +687,15 @@ static int sst_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *dai = rtd->cpu_dai;
 	struct snd_pcm *pcm = rtd->pcm;
-	int retval = 0;
 
 	if (dai->driver->playback.channels_min ||
 			dai->driver->capture.channels_min) {
-		retval =  snd_pcm_lib_preallocate_pages_for_all(pcm,
+		snd_pcm_lib_preallocate_pages_for_all(pcm,
 			SNDRV_DMA_TYPE_CONTINUOUS,
 			snd_dma_continuous_data(GFP_DMA),
 			SST_MIN_BUFFER, SST_MAX_BUFFER);
-		if (retval) {
-			dev_err(rtd->dev, "dma buffer allocation failure\n");
-			return retval;
-		}
 	}
-	return retval;
+	return 0;
 }
 
 static int sst_soc_probe(struct snd_soc_component *component)
diff --git a/sound/soc/intel/baytrail/sst-baytrail-pcm.c b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
index aabb35bf6b96..aa358073ac0f 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-pcm.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-pcm.c
@@ -327,23 +327,16 @@ static int sst_byt_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	size_t size;
 	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
 	struct sst_pdata *pdata = dev_get_platdata(component->dev);
-	int ret = 0;
 
 	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream ||
 	    pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
 		size = sst_byt_pcm_hardware.buffer_bytes_max;
-		ret = snd_pcm_lib_preallocate_pages_for_all(pcm,
-							    SNDRV_DMA_TYPE_DEV,
-							    pdata->dma_dev,
-							    size, size);
-		if (ret) {
-			dev_err(rtd->dev, "dma buffer allocation failed %d\n",
-				ret);
-			return ret;
-		}
+		snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
+						      pdata->dma_dev,
+						      size, size);
 	}
 
-	return ret;
+	return 0;
 }
 
 static struct snd_soc_dai_driver byt_dais[] = {
diff --git a/sound/soc/intel/haswell/sst-haswell-pcm.c b/sound/soc/intel/haswell/sst-haswell-pcm.c
index fe2c826e710c..f21a7f2c11c2 100644
--- a/sound/soc/intel/haswell/sst-haswell-pcm.c
+++ b/sound/soc/intel/haswell/sst-haswell-pcm.c
@@ -946,27 +946,21 @@ static int hsw_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	struct sst_pdata *pdata = dev_get_platdata(component->dev);
 	struct hsw_priv_data *priv_data = dev_get_drvdata(component->dev);
 	struct device *dev = pdata->dma_dev;
-	int ret = 0;
 
 	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream ||
 			pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
-		ret = snd_pcm_lib_preallocate_pages_for_all(pcm,
+		snd_pcm_lib_preallocate_pages_for_all(pcm,
 			SNDRV_DMA_TYPE_DEV_SG,
 			dev,
 			hsw_pcm_hardware.buffer_bytes_max,
 			hsw_pcm_hardware.buffer_bytes_max);
-		if (ret) {
-			dev_err(rtd->dev, "dma buffer allocation failed %d\n",
-				ret);
-			return ret;
-		}
 	}
 	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream)
 		priv_data->pcm[rtd->cpu_dai->id][SNDRV_PCM_STREAM_PLAYBACK].hsw_pcm = pcm;
 	if (pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream)
 		priv_data->pcm[rtd->cpu_dai->id][SNDRV_PCM_STREAM_CAPTURE].hsw_pcm = pcm;
 
-	return ret;
+	return 0;
 }
 
 #define HSW_FORMATS \
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 557f80c0bfe5..20c88c677473 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1289,7 +1289,6 @@ static int skl_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	struct hdac_bus *bus = dev_get_drvdata(dai->dev);
 	struct snd_pcm *pcm = rtd->pcm;
 	unsigned int size;
-	int retval = 0;
 	struct skl *skl = bus_to_skl(bus);
 
 	if (dai->driver->playback.channels_min ||
@@ -1298,17 +1297,13 @@ static int skl_pcm_new(struct snd_soc_pcm_runtime *rtd)
 		size = CONFIG_SND_HDA_PREALLOC_SIZE * 1024;
 		if (size > MAX_PREALLOC_SIZE)
 			size = MAX_PREALLOC_SIZE;
-		retval = snd_pcm_lib_preallocate_pages_for_all(pcm,
+		snd_pcm_lib_preallocate_pages_for_all(pcm,
 						SNDRV_DMA_TYPE_DEV_SG,
 						snd_dma_pci_data(skl->pci),
 						size, MAX_PREALLOC_SIZE);
-		if (retval) {
-			dev_err(dai->dev, "dma buffer allocation fail\n");
-			return retval;
-		}
 	}
 
-	return retval;
+	return 0;
 }
 
 static int skl_get_module_info(struct skl *skl, struct skl_module_cfg *mconfig)
-- 
2.16.4
