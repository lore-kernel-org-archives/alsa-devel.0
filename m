From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/2] ASoC: Intel: Use ACPI device for Baytrail
	PCM buffer allocation
Date: Fri,  9 May 2014 16:47:44 +0300
Message-ID: <1399643264-7669-2-git-send-email-jarkko.nikula@linux.intel.com>
References: <1399643264-7669-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 05344261A5A
 for <alsa-devel@alsa-project.org>; Fri,  9 May 2014 15:48:21 +0200 (CEST)
In-Reply-To: <1399643264-7669-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

This follows the same idea than commit 10df350977b1
("ASoC: Intel: Fix Audio DSP usage when IOMMU is enabled.") by using only
ACPI device for all DMA allocations. Since DMA masking is already done in
firmware loading it can be removed from here.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/sst-baytrail-pcm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/sst-baytrail-pcm.c b/sound/soc/intel/sst-baytrail-pcm.c
index 00a2118d20f5..0afb3491f5f0 100644
--- a/sound/soc/intel/sst-baytrail-pcm.c
+++ b/sound/soc/intel/sst-baytrail-pcm.c
@@ -319,18 +319,16 @@ static int sst_byt_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_pcm *pcm = rtd->pcm;
 	size_t size;
+	struct snd_soc_platform *platform = rtd->platform;
+	struct sst_pdata *pdata = dev_get_platdata(platform->dev);
 	int ret = 0;
 
-	ret = dma_coerce_mask_and_coherent(rtd->card->dev, DMA_BIT_MASK(32));
-	if (ret)
-		return ret;
-
 	if (pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream ||
 	    pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream) {
 		size = sst_byt_pcm_hardware.buffer_bytes_max;
 		ret = snd_pcm_lib_preallocate_pages_for_all(pcm,
 							    SNDRV_DMA_TYPE_DEV,
-							    rtd->card->dev,
+							    pdata->dma_dev,
 							    size, size);
 		if (ret) {
 			dev_err(rtd->dev, "dma buffer allocation failed %d\n",
-- 
2.0.0.rc0
