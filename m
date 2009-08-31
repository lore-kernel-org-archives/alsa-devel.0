From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 2/3] ASoC: DaVinci: pcm,
	rename variables in prep for ping/pong
Date: Mon, 31 Aug 2009 16:31:44 -0700
Message-ID: <1251761505-11353-2-git-send-email-troy.kisky@boundarydevices.com>
References: <1251761505-11353-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-05.inet.qwest.net (mpls-qmqp-05.inet.qwest.net
	[63.231.195.116])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A9CB10381F
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Sep 2009 01:31:38 +0200 (CEST)
In-Reply-To: <1251761505-11353-1-git-send-email-troy.kisky@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: davinci-linux-open-source@linux.davincidsp.com
Cc: avm@ti.com, alsa-devel@alsa-project.org, broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Rename variable master_lch to asp_master_lch
Rename variable slave_lch to asp_link_lch[0]
Rename local variables:
	count to asp_count
	src to asp_src
	dst to asp_dst

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 sound/soc/davinci/davinci-pcm.c |   48 +++++++++++++++++++-------------------
 1 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 2f7da49..a96655c 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -51,8 +51,8 @@ static struct snd_pcm_hardware davinci_pcm_hardware = {
 struct davinci_runtime_data {
 	spinlock_t lock;
 	int period;		/* current DMA period */
-	int master_lch;		/* Master DMA channel */
-	int slave_lch;		/* linked parameter RAM reload slot */
+	int asp_master_lch;	/* Master DMA channel */
+	int asp_link_lch[2];	/* asp parameter link channel, ping/pong */
 	struct davinci_pcm_dma_params *params;	/* DMA params */
 };
 
@@ -60,7 +60,7 @@ static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
 {
 	struct davinci_runtime_data *prtd = substream->runtime->private_data;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	int lch = prtd->slave_lch;
+	int lch = prtd->asp_link_lch[0];
 	unsigned int period_size;
 	unsigned int dma_offset;
 	dma_addr_t dma_pos;
@@ -142,15 +142,15 @@ static int davinci_pcm_dma_request(struct snd_pcm_substream *substream)
 				  EVENTQ_0);
 	if (ret < 0)
 		return ret;
-	prtd->master_lch = ret;
+	prtd->asp_master_lch = ret;
 
 	/* Request parameter RAM reload slot */
-	ret = edma_alloc_slot(EDMA_CTLR(prtd->master_lch), EDMA_SLOT_ANY);
+	ret = edma_alloc_slot(EDMA_CTLR(prtd->asp_master_lch), EDMA_SLOT_ANY);
 	if (ret < 0) {
-		edma_free_channel(prtd->master_lch);
+		edma_free_channel(prtd->asp_master_lch);
 		return ret;
 	}
-	prtd->slave_lch = ret;
+	prtd->asp_link_lch[0] = ret;
 
 	/* Issue transfer completion IRQ when the channel completes a
 	 * transfer, then always reload from the same slot (by a kind
@@ -161,10 +161,10 @@ static int davinci_pcm_dma_request(struct snd_pcm_substream *substream)
 	 * the buffer and its length (ccnt) ... use it as a template
 	 * so davinci_pcm_enqueue_dma() takes less time in IRQ.
 	 */
-	edma_read_slot(prtd->slave_lch, &p_ram);
-	p_ram.opt |= TCINTEN | EDMA_TCC(EDMA_CHAN_SLOT(prtd->master_lch));
-	p_ram.link_bcntrld = EDMA_CHAN_SLOT(prtd->slave_lch) << 5;
-	edma_write_slot(prtd->slave_lch, &p_ram);
+	edma_read_slot(prtd->asp_link_lch[0], &p_ram);
+	p_ram.opt |= TCINTEN | EDMA_TCC(EDMA_CHAN_SLOT(prtd->asp_master_lch));
+	p_ram.link_bcntrld = EDMA_CHAN_SLOT(prtd->asp_link_lch[0]) << 5;
+	edma_write_slot(prtd->asp_link_lch[0], &p_ram);
 
 	return 0;
 }
@@ -180,12 +180,12 @@ static int davinci_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		edma_start(prtd->master_lch);
+		edma_start(prtd->asp_master_lch);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		edma_stop(prtd->master_lch);
+		edma_stop(prtd->asp_master_lch);
 		break;
 	default:
 		ret = -EINVAL;
@@ -206,8 +206,8 @@ static int davinci_pcm_prepare(struct snd_pcm_substream *substream)
 	davinci_pcm_enqueue_dma(substream);
 
 	/* Copy self-linked parameter RAM entry into master channel */
-	edma_read_slot(prtd->slave_lch, &temp);
-	edma_write_slot(prtd->master_lch, &temp);
+	edma_read_slot(prtd->asp_link_lch[0], &temp);
+	edma_write_slot(prtd->asp_master_lch, &temp);
 	davinci_pcm_enqueue_dma(substream);
 
 	return 0;
@@ -219,20 +219,20 @@ davinci_pcm_pointer(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct davinci_runtime_data *prtd = runtime->private_data;
 	unsigned int offset;
-	dma_addr_t count;
-	dma_addr_t src, dst;
+	int asp_count;
+	dma_addr_t asp_src, asp_dst;
 
 	spin_lock(&prtd->lock);
 
-	edma_get_position(prtd->master_lch, &src, &dst);
+	edma_get_position(prtd->asp_master_lch, &asp_src, &asp_dst);
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
 
@@ -274,10 +274,10 @@ static int davinci_pcm_close(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct davinci_runtime_data *prtd = runtime->private_data;
 
-	edma_unlink(prtd->slave_lch);
+	edma_unlink(prtd->asp_link_lch[0]);
 
-	edma_free_slot(prtd->slave_lch);
-	edma_free_channel(prtd->master_lch);
+	edma_free_slot(prtd->asp_link_lch[0]);
+	edma_free_channel(prtd->asp_master_lch);
 
 	kfree(prtd);
 
-- 
1.5.6.3
