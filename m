From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 2/4] ASoC: DaVinci: pcm,
	rename variables in prep for ping/pong
Date: Wed, 18 Nov 2009 17:49:52 -0700
Message-ID: <1258591794-18416-2-git-send-email-troy.kisky@boundarydevices.com>
References: <1258591794-18416-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-01.inet.qwest.net (mpls-qmqp-01.inet.qwest.net
	[63.231.195.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 110FB103876
	for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2009 01:50:05 +0100 (CET)
In-Reply-To: <1258591794-18416-1-git-send-email-troy.kisky@boundarydevices.com>
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
Cc: broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Rename variable master_lch to asp_channel
Rename variable slave_lch to asp_link[0]
Rename local variables:
	lch to link
	count to asp_count
	src to asp_src
	dst to asp_dst

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 sound/soc/davinci/davinci-pcm.c |   66 +++++++++++++++++++-------------------
 1 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 187ee96..42a657e 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -51,8 +51,8 @@ static struct snd_pcm_hardware davinci_pcm_hardware = {
 struct davinci_runtime_data {
 	spinlock_t lock;
 	int period;		/* current DMA period */
-	int master_lch;		/* Master DMA channel */
-	int slave_lch;		/* linked parameter RAM reload slot */
+	int asp_channel;	/* Master DMA channel */
+	int asp_link[2];	/* asp parameter link channel, ping/pong */
 	struct davinci_pcm_dma_params *params;	/* DMA params */
 };
 
@@ -60,7 +60,7 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
 {
 	struct davinci_runtime_data *prtd = substream->runtime->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	int lch = prtd->slave_lch;
+	int link = prtd->asp_link[0];
 	unsigned int period_size;
 	unsigned int dma_offset;
 	dma_addr_t dma_pos;
@@ -78,7 +78,7 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
 	fifo_level = prtd->params->fifo_level;
 
 	pr_debug("davinci_pcm: audio_set_dma_params_play channel = %d "
-		"dma_ptr = %x period_size=%x\n", lch, dma_pos, period_size);
+		"dma_ptr = %x period_size=%x\n", link, dma_pos, period_size);
 
 	data_type = prtd->params->data_type;
 	count = period_size / data_type;
@@ -102,16 +102,16 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
 	}
 
 	acnt = prtd->params->acnt;
-	edma_set_src(lch, src, INCR, W8BIT);
-	edma_set_dest(lch, dst, INCR, W8BIT);
+	edma_set_src(link, src, INCR, W8BIT);
+	edma_set_dest(link, dst, INCR, W8BIT);
 
-	edma_set_src_index(lch, src_bidx, src_cidx);
-	edma_set_dest_index(lch, dst_bidx, dst_cidx);
+	edma_set_src_index(link, src_bidx, src_cidx);
+	edma_set_dest_index(link, dst_bidx, dst_cidx);
 
 	if (!fifo_level)
-		edma_set_transfer_params(lch, acnt, count, 1, 0, ASYNC);
+		edma_set_transfer_params(link, acnt, count, 1, 0, ASYNC);
 	else
-		edma_set_transfer_params(lch, acnt, fifo_level, count,
+		edma_set_transfer_params(link, acnt, fifo_level, count,
 							fifo_level, ABSYNC);
 
 	prtd->period++;
@@ -119,12 +119,12 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
 		prtd->period = 0;
 }
 
-static void davinci_pcm_dma_irq(unsigned lch, u16 ch_status, void *data)
+static void davinci_pcm_dma_irq(unsigned link, u16 ch_status, void *data)
 {
 	struct snd_pcm_substream *substream = data;
 	struct davinci_runtime_data *prtd = substream->runtime->private_data;
 
-	pr_debug("davinci_pcm: lch=%d, status=0x%x\n", lch, ch_status);
+	pr_debug("davinci_pcm: link=%d, status=0x%x\n", link, ch_status);
 
 	if (unlikely(ch_status != DMA_COMPLETE))
 		return;
@@ -150,15 +150,15 @@ static int davinci_pcm_dma_request(struct snd_pcm_substream *substream)
 				  EVENTQ_0);
 	if (ret < 0)
 		return ret;
-	prtd->master_lch = ret;
+	prtd->asp_channel = ret;
 
 	/* Request parameter RAM reload slot */
-	ret = edma_alloc_slot(EDMA_CTLR(prtd->master_lch), EDMA_SLOT_ANY);
+	ret = edma_alloc_slot(EDMA_CTLR(prtd->asp_channel), EDMA_SLOT_ANY);
 	if (ret < 0) {
-		edma_free_channel(prtd->master_lch);
+		edma_free_channel(prtd->asp_channel);
 		return ret;
 	}
-	prtd->slave_lch = ret;
+	prtd->asp_link[0] = ret;
 
 	/* Issue transfer completion IRQ when the channel completes a
 	 * transfer, then always reload from the same slot (by a kind
@@ -169,10 +169,10 @@ static int davinci_pcm_dma_request(struct snd_pcm_substream *substream)
 	 * the buffer and its length (ccnt) ... use it as a template
 	 * so davinci_pcm_enqueue_dma() takes less time in IRQ.
 	 */
-	edma_read_slot(prtd->slave_lch, &p_ram);
-	p_ram.opt |= TCINTEN | EDMA_TCC(EDMA_CHAN_SLOT(prtd->master_lch));
-	p_ram.link_bcntrld = EDMA_CHAN_SLOT(prtd->slave_lch) << 5;
-	edma_write_slot(prtd->slave_lch, &p_ram);
+	edma_read_slot(prtd->asp_link[0], &p_ram);
+	p_ram.opt |= TCINTEN | EDMA_TCC(EDMA_CHAN_SLOT(prtd->asp_channel));
+	p_ram.link_bcntrld = EDMA_CHAN_SLOT(prtd->asp_link[0]) << 5;
+	edma_write_slot(prtd->asp_link[0], &p_ram);
 
 	return 0;
 }
@@ -188,12 +188,12 @@ static int davinci_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		edma_start(prtd->master_lch);
+		edma_start(prtd->asp_channel);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		edma_stop(prtd->master_lch);
+		edma_stop(prtd->asp_channel);
 		break;
 	default:
 		ret = -EINVAL;
@@ -214,8 +214,8 @@ static int davinci_pcm_prepare(struct snd_pcm_substream *substream)
 	davinci_pcm_enqueue_dma(substream);
 
 	/* Copy self-linked parameter RAM entry into master channel */
-	edma_read_slot(prtd->slave_lch, &temp);
-	edma_write_slot(prtd->master_lch, &temp);
+	edma_read_slot(prtd->asp_link[0], &temp);
+	edma_write_slot(prtd->asp_channel, &temp);
 	davinci_pcm_enqueue_dma(substream);
 
 	return 0;
@@ -227,20 +227,20 @@ davinci_pcm_pointer(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct davinci_runtime_data *prtd = runtime->private_data;
 	unsigned int offset;
-	dma_addr_t count;
-	dma_addr_t src, dst;
+	int asp_count;
+	dma_addr_t asp_src, asp_dst;
 
 	spin_lock(&prtd->lock);
 
-	edma_get_position(prtd->master_lch, &src, &dst);
+	edma_get_position(prtd->asp_channel, &asp_src, &asp_dst);
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		count = src - runtime->dma_addr;
+		asp_count = asp_src - runtime->dma_addr;
 	else
-		count = dst - runtime->dma_addr;
+		asp_count = asp_dst - runtime->dma_addr;
 
 	spin_unlock(&prtd->lock);
 
-	offset = bytes_to_frames(runtime, count);
+	offset = bytes_to_frames(runtime, asp_count);
 	if (offset >= runtime->buffer_size)
 		offset = 0;
 
@@ -289,10 +289,10 @@ static int davinci_pcm_close(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct davinci_runtime_data *prtd = runtime->private_data;
 
-	edma_unlink(prtd->slave_lch);
+	edma_unlink(prtd->asp_link[0]);
 
-	edma_free_slot(prtd->slave_lch);
-	edma_free_channel(prtd->master_lch);
+	edma_free_slot(prtd->asp_link[0]);
+	edma_free_channel(prtd->asp_channel);
 
 	kfree(prtd);
 
-- 
1.5.6.3
