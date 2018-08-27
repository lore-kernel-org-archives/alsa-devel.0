From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 8/8] ALSA: intel_hdmi: Use the new non-cached
	allocation
Date: Mon, 27 Aug 2018 10:59:53 +0200
Message-ID: <20180827085953.10614-9-tiwai@suse.de>
References: <20180827085953.10614-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 182AC267865
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2018 11:00:03 +0200 (CEST)
In-Reply-To: <20180827085953.10614-1-tiwai@suse.de>
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
Cc: Hans Hu <HansHu@zhaoxin.com>
List-Id: alsa-devel@alsa-project.org

The HDMI LPE audio driver requires the non-cached page allocations for
its buffers.  With the recent support of SNDRV_DMA_TYPE_DEV_UC type,
we can reduce lots of codes in the driver side and let the memalloc
core doing it properly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 29 +++--------------------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index fa7dca5a68c8..83d76c345940 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -30,7 +30,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
-#include <asm/set_memory.h>
 #include <sound/core.h>
 #include <sound/asoundef.h>
 #include <sound/pcm.h>
@@ -1141,8 +1140,7 @@ static int had_pcm_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *hw_params)
 {
 	struct snd_intelhad *intelhaddata;
-	unsigned long addr;
-	int pages, buf_size, retval;
+	int buf_size, retval;
 
 	intelhaddata = snd_pcm_substream_chip(substream);
 	buf_size = params_buffer_bytes(hw_params);
@@ -1151,17 +1149,6 @@ static int had_pcm_hw_params(struct snd_pcm_substream *substream,
 		return retval;
 	dev_dbg(intelhaddata->dev, "%s:allocated memory = %d\n",
 		__func__, buf_size);
-	/* mark the pages as uncached region */
-	addr = (unsigned long) substream->runtime->dma_area;
-	pages = (substream->runtime->dma_bytes + PAGE_SIZE - 1) / PAGE_SIZE;
-	retval = set_memory_uc(addr, pages);
-	if (retval) {
-		dev_err(intelhaddata->dev, "set_memory_uc failed.Error:%d\n",
-			retval);
-		return retval;
-	}
-	memset(substream->runtime->dma_area, 0, buf_size);
-
 	return retval;
 }
 
@@ -1171,21 +1158,11 @@ static int had_pcm_hw_params(struct snd_pcm_substream *substream,
 static int had_pcm_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_intelhad *intelhaddata;
-	unsigned long addr;
-	u32 pages;
 
 	intelhaddata = snd_pcm_substream_chip(substream);
 	had_do_reset(intelhaddata);
 
-	/* mark back the pages as cached/writeback region before the free */
-	if (substream->runtime->dma_area != NULL) {
-		addr = (unsigned long) substream->runtime->dma_area;
-		pages = (substream->runtime->dma_bytes + PAGE_SIZE - 1) /
-								PAGE_SIZE;
-		set_memory_wb(addr, pages);
-		return snd_pcm_lib_free_pages(substream);
-	}
-	return 0;
+	return snd_pcm_lib_free_pages(substream);
 }
 
 /*
@@ -1860,7 +1837,7 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 		 * try to allocate 600k buffer as default which is large enough
 		 */
 		snd_pcm_lib_preallocate_pages_for_all(pcm,
-						      SNDRV_DMA_TYPE_DEV, NULL,
+						      SNDRV_DMA_TYPE_DEV_UC, NULL,
 						      HAD_DEFAULT_BUFFER, HAD_MAX_BUFFER);
 
 		/* create controls */
-- 
2.18.0
