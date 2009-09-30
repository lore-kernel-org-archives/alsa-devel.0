From: Chaithrika U S <chaithrika@ti.com>
Subject: [PATCH] ASoC: DaVinci: McASP FIFO related updates
Date: Wed, 30 Sep 2009 17:32:27 -0400
Message-ID: <1254346347-21711-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id A4E02103805
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Sep 2009 14:16:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: khilman@deeprootsystems.com, Chaithrika U S <chaithrika@ti.com>, davinci-linux-open-source@linux.davincidsp.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The DMA params for McASP with FIFO has been updated so that it works for
various FIFO levels. A member- 'fifo_level' has been added to the DMA
params data structure. The fifo_level can be adjusted by the tx[rx]_numevt
platform data. This is relevant only for DA8xx/OMAP-L1xx platforms. This
implementation has been tested for numevt values 1, 2, 4, 8.

Signed-off-by: Chaithrika U S <chaithrika@ti.com>
---
Applies to ALSA GIT tree on branch topic/asoc at
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=shortlog;
h=topic/asoc

 sound/soc/davinci/davinci-i2s.c   |    2 ++
 sound/soc/davinci/davinci-mcasp.c |   17 +++++++----------
 sound/soc/davinci/davinci-pcm.c   |   21 ++++++++++++++++++---
 sound/soc/davinci/davinci-pcm.h   |    1 +
 4 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 4ae7070..2ab8093 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -397,6 +397,8 @@ static int davinci_i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	dma_params->acnt  = dma_params->data_type;
+	dma_params->fifo_level = 0;
+
 	rcr |= DAVINCI_MCBSP_RCR_RFRLEN1(1);
 	xcr |= DAVINCI_MCBSP_XCR_XFRLEN1(1);
 
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 5d1f98a..50ad051 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -714,16 +714,13 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 	struct davinci_pcm_dma_params *dma_params =
 					&dev->dma_params[substream->stream];
 	int word_length;
-	u8 numevt;
+	u8 fifo_level;
 
 	davinci_hw_common_param(dev, substream->stream);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		numevt = dev->txnumevt;
+		fifo_level = dev->txnumevt;
 	else
-		numevt = dev->rxnumevt;
-
-	if (!numevt)
-		numevt = 1;
+		fifo_level = dev->rxnumevt;
 
 	if (dev->op_mode == DAVINCI_MCASP_DIT_MODE)
 		davinci_hw_dit_param(dev);
@@ -751,12 +748,12 @@ static int davinci_mcasp_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	if (dev->version == MCASP_VERSION_2) {
-		dma_params->data_type *= numevt;
-		dma_params->acnt = 4 * numevt;
-	} else
+	if (dev->version == MCASP_VERSION_2 && !fifo_level)
+		dma_params->acnt = 4;
+	else
 		dma_params->acnt = dma_params->data_type;
 
+	dma_params->fifo_level = fifo_level;
 	davinci_config_channel_size(dev, word_length);
 
 	return 0;
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 359e99e..1152d8b 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -66,38 +66,53 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
 	dma_addr_t dma_pos;
 	dma_addr_t src, dst;
 	unsigned short src_bidx, dst_bidx;
+	unsigned short src_cidx, dst_cidx;
 	unsigned int data_type;
 	unsigned short acnt;
 	unsigned int count;
+	unsigned int fifo_level;
 
 	period_size = snd_pcm_lib_period_bytes(substream);
 	dma_offset = prtd->period * period_size;
 	dma_pos = runtime->dma_addr + dma_offset;
+	fifo_level = prtd->params->fifo_level;
 
 	pr_debug("davinci_pcm: audio_set_dma_params_play channel = %d "
 		"dma_ptr = %x period_size=%x\n", lch, dma_pos, period_size);
 
 	data_type = prtd->params->data_type;
 	count = period_size / data_type;
+	if (fifo_level)
+		count /= fifo_level;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		src = dma_pos;
 		dst = prtd->params->dma_addr;
 		src_bidx = data_type;
 		dst_bidx = 0;
+		src_cidx = data_type * fifo_level;
+		dst_cidx = 0;
 	} else {
 		src = prtd->params->dma_addr;
 		dst = dma_pos;
 		src_bidx = 0;
 		dst_bidx = data_type;
+		src_cidx = 0;
+		dst_cidx = data_type * fifo_level;
 	}
 
 	acnt = prtd->params->acnt;
 	edma_set_src(lch, src, INCR, W8BIT);
 	edma_set_dest(lch, dst, INCR, W8BIT);
-	edma_set_src_index(lch, src_bidx, 0);
-	edma_set_dest_index(lch, dst_bidx, 0);
-	edma_set_transfer_params(lch, acnt, count, 1, 0, ASYNC);
+
+	edma_set_src_index(lch, src_bidx, src_cidx);
+	edma_set_dest_index(lch, dst_bidx, dst_cidx);
+
+	if (!fifo_level)
+		edma_set_transfer_params(lch, acnt, count, 1, 0, ASYNC);
+	else
+		edma_set_transfer_params(lch, acnt, fifo_level, count,
+							fifo_level, ABSYNC);
 
 	prtd->period++;
 	if (unlikely(prtd->period >= runtime->periods))
diff --git a/sound/soc/davinci/davinci-pcm.h b/sound/soc/davinci/davinci-pcm.h
index 8746606..c8b0d2b 100644
--- a/sound/soc/davinci/davinci-pcm.h
+++ b/sound/soc/davinci/davinci-pcm.h
@@ -23,6 +23,7 @@ struct davinci_pcm_dma_params {
 	enum dma_event_q eventq_no;	/* event queue number */
 	unsigned char data_type;	/* xfer data type */
 	unsigned char convert_mono_stereo;
+	unsigned int fifo_level;
 };
 
 
-- 
1.5.6
