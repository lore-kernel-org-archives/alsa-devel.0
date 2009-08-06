From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH 5/5] ASoC: DaVinci: pcm,
	fix underruns by using sram
Date: Thu,  6 Aug 2009 16:55:35 -0700
Message-ID: <1249602935-1267-5-git-send-email-troy.kisky@boundarydevices.com>
References: <1249602935-1267-1-git-send-email-troy.kisky@boundarydevices.com>
	<1249602935-1267-2-git-send-email-troy.kisky@boundarydevices.com>
	<1249602935-1267-3-git-send-email-troy.kisky@boundarydevices.com>
	<1249602935-1267-4-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-02.inet.qwest.net (mpls-qmqp-02.inet.qwest.net
	[63.231.195.113])
	by alsa0.perex.cz (Postfix) with ESMTP id 696351037EA
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 01:55:33 +0200 (CEST)
In-Reply-To: <1249602935-1267-4-git-send-email-troy.kisky@boundarydevices.com>
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
Cc: alsa-devel@alsa-project.org, broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Fix underruns by using dma to copy 1st to sram
in a ping/pong buffer style and then copying from
the sram to the ASP. This also has the advantage
of tolerating very long interrupt latency on dma
completion.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 arch/arm/mach-davinci/include/mach/asp.h |    2 +
 sound/soc/davinci/davinci-i2s.c          |    5 +-
 sound/soc/davinci/davinci-pcm.c          |  471 +++++++++++++++++++++++++++---
 sound/soc/davinci/davinci-pcm.h          |    1 +
 4 files changed, 435 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/asp.h b/arch/arm/mach-davinci/include/mach/asp.h
index 73b60b6..0fdbf45 100644
--- a/arch/arm/mach-davinci/include/mach/asp.h
+++ b/arch/arm/mach-davinci/include/mach/asp.h
@@ -43,6 +43,8 @@ struct snd_platform_data {
 	 * when compared to previous behavior.
 	 */
 	unsigned disable_channel_combine:1;
+	unsigned sram_size_playback;
+	unsigned sram_size_capture;
 
 	/* McASP specific fields */
 	int tdm_slots;
diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 9587e00..129684d 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -559,8 +559,11 @@ static int davinci_i2s_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto err_release_region;
 	}
-	if (pdata)
+	if (pdata) {
 		dev->disable_channel_combine = pdata->disable_channel_combine;
+		davinci_i2s_pcm_out.sram_size = pdata->sram_size_playback;
+		davinci_i2s_pcm_in.sram_size = pdata->sram_size_capture;
+	}
 	dev->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dev->clk)) {
 		ret = -ENODEV;
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 3489f18..191cf4f 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -3,6 +3,7 @@
  *
  * Author:      Vladimir Barinov, <vbarinov@embeddedalley.com>
  * Copyright:   (C) 2007 MontaVista Software, Inc., <source@mvista.com>
+ * added SRAM ping/pong (C) 2008 Troy Kisky <troy.kisky@boundarydevices.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -23,9 +24,28 @@
 
 #include <asm/dma.h>
 #include <mach/edma.h>
+#include <mach/sram.h>
 
 #include "davinci-pcm.h"
 
+#ifdef DEBUG
+static void print_buf_info(int lch, char *name)
+{
+	struct edmacc_param p;
+	if (lch < 0)
+		return;
+	edma_read_slot(lch, &p);
+	printk(KERN_DEBUG "%s: 0x%x, opt=%x, src=%x, a_b_cnt=%x dst=%x\n",
+			name, lch, p.opt, p.src, p.a_b_cnt, p.dst);
+	printk(KERN_DEBUG "    src_dst_bidx=%x link_bcntrld=%x src_dst_cidx=%x ccnt=%x\n",
+			p.src_dst_bidx, p.link_bcntrld, p.src_dst_cidx, p.ccnt);
+}
+#else
+static void print_buf_info(int lch, char *name)
+{
+}
+#endif
+
 static struct snd_pcm_hardware davinci_pcm_hardware = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
@@ -48,14 +68,58 @@ static struct snd_pcm_hardware davinci_pcm_hardware = {
 	.fifo_size = 0,
 };
 
+/*
+ * How ping/pong works....
+ *
+ * Playback:
+ * ram_params - copys 2*ping_size from start of SDRAM to iram,
+ * 	links to ram_link_lch2
+ * ram_link_lch2 - copys rest of SDRAM to iram in ping_size units,
+ * 	links to ram_link_lch
+ * ram_link_lch - copys entire SDRAM to iram in ping_size uints,
+ * 	links to self
+ *
+ * asp_params - same as asp_link_lch[0]
+ * asp_link_lch[0] - copys from lower half of iram to asp port
+ * 	links to asp_link_lch[1], triggers iram copy event on completion
+ * asp_link_lch[1] - copys from upper half of iram to asp port
+ * 	links to asp_link_lch[0], triggers iram copy event on completion
+ * 	triggers interrupt only needed to let upper SOC levels update position
+ * 	in stream on completion
+ *
+ * When playback is started:
+ * 	ram_params started
+ * 	asp_params started
+ *
+ * Capture:
+ * ram_params - same as ram_link_lch,
+ * 	links to ram_link_lch
+ * ram_link_lch - same as playback
+ * 	links to self
+ *
+ * asp_params - same as playback
+ * asp_link_lch[0] - same as playback
+ * asp_link_lch[1] - same as playback
+ *
+ * When capture is started:
+ * 	asp_params started
+ */
 struct davinci_runtime_data {
 	spinlock_t lock;
 	int period;		/* current DMA period */
 	int asp_master_lch;	/* Master DMA channel */
 	int asp_link_lch[2];	/* asp parameter link channel, ping/pong */
 	struct davinci_pcm_dma_params *params;	/* DMA params */
+	int ram_master_lch;
+	int ram_link_lch;
+	int ram_link_lch2;
+	struct edmacc_param asp_params;
+	struct edmacc_param ram_params;
 };
 
+/*
+ * Not used with ping/pong
+ */
 static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
 {
 	struct davinci_runtime_data *prtd = substream->runtime->private_data;
@@ -107,48 +171,280 @@ static void davinci_pcm_dma_irq(unsigned lch, u16 ch_status, void *data)
 	struct snd_pcm_substream *substream = data;
 	struct davinci_runtime_data *prtd = substream->runtime->private_data;
 
+	print_buf_info(prtd->ram_master_lch, "i ram_master_lch");
 	pr_debug("davinci_pcm: lch=%d, status=0x%x\n", lch, ch_status);
 
 	if (unlikely(ch_status != DMA_COMPLETE))
 		return;
 
 	if (snd_pcm_running(substream)) {
+		if (prtd->ram_master_lch < 0) {
+			/* No ping/pong must fix up link dma data*/
+			spin_lock(&prtd->lock);
+			davinci_pcm_enqueue_dma(substream);
+			spin_unlock(&prtd->lock);
+		}
 		snd_pcm_period_elapsed(substream);
+	}
+}
+
+static int allocate_sram(struct snd_pcm_substream *substream, unsigned size)
+{
+	struct snd_dma_buffer *buf = &substream->dma_buffer;
+	struct snd_dma_buffer *iram_dma = NULL;
+	dma_addr_t iram_phys = 0;
+	void *iram_virt = NULL;
+
+	if (buf->private_data || !size)
+		return 0;
+
+	davinci_pcm_hardware.period_bytes_max = size;
+	iram_virt = sram_alloc(size, &iram_phys);
+	if (!iram_virt)
+		goto exit1;
+	iram_dma = kzalloc(sizeof(*iram_dma), GFP_KERNEL);
+	if (!iram_dma)
+		goto exit2;
+	iram_dma->area = iram_virt;
+	iram_dma->addr = iram_phys;
+	memset(iram_dma->area, 0, size);
+	iram_dma->bytes = size;
+	buf->private_data = iram_dma;
+	return 0;
+exit2:
+	if (iram_virt)
+		sram_free(iram_virt, size);
+exit1:
+	return -ENOMEM;
+}
+
+/*
+ * Only used with ping/pong.
+ * This is called after runtime->dma_addr, period_bytes and data_type are valid
+ */
+static int ping_pong_dma_setup(struct snd_pcm_substream *substream)
+{
+	unsigned short ram_src_cidx, ram_dst_cidx;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct davinci_runtime_data *prtd = runtime->private_data;
+	struct snd_dma_buffer *iram_dma =
+		(struct snd_dma_buffer *)substream->dma_buffer.private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct davinci_pcm_dma_params *dma_data = rtd->dai->cpu_dai->dma_data;
+	unsigned int data_type = dma_data->data_type;
+	/* divide by 2 for ping/pong */
+	unsigned int ping_size = snd_pcm_lib_period_bytes(substream) >> 1;
+	int lch = prtd->asp_link_lch[1];
+	if ((data_type == 0) || (data_type > 4)) {
+		printk(KERN_ERR "%s: data_type=%i\n", __func__, data_type);
+		return -EINVAL;
+	}
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		dma_addr_t asp_src_pong = iram_dma->addr + ping_size;
+		ram_src_cidx = ping_size;
+		ram_dst_cidx = -ping_size;
+		edma_set_src(lch, asp_src_pong, INCR, W8BIT);
+
+		lch = prtd->asp_link_lch[0];
+		edma_set_src_index(lch, data_type, 0);
+		lch = prtd->asp_link_lch[1];
+		edma_set_src_index(lch, data_type, 0);
+
+		lch = prtd->ram_link_lch;
+		edma_set_src(lch, runtime->dma_addr, INCR, W32BIT);
+	} else {
+		dma_addr_t asp_dst_pong = iram_dma->addr + ping_size;
+		ram_src_cidx = -ping_size;
+		ram_dst_cidx = ping_size;
+		edma_set_dest(lch, asp_dst_pong, INCR, W8BIT);
+
+		lch = prtd->asp_link_lch[0];
+		edma_set_dest_index(lch, data_type, 0);
+		lch = prtd->asp_link_lch[1];
+		edma_set_dest_index(lch, data_type, 0);
+
+		lch = prtd->ram_link_lch;
+		edma_set_dest(lch, runtime->dma_addr, INCR, W32BIT);
+	}
 
-		spin_lock(&prtd->lock);
-		davinci_pcm_enqueue_dma(substream);
-		spin_unlock(&prtd->lock);
+	lch = prtd->asp_link_lch[0];
+	edma_set_transfer_params(lch, data_type,
+			ping_size/data_type, 1, 0, ASYNC);
+	lch = prtd->asp_link_lch[1];
+	edma_set_transfer_params(lch, data_type,
+			ping_size/data_type, 1, 0, ASYNC);
+
+	lch = prtd->ram_link_lch;
+	edma_set_src_index(lch, ping_size, ram_src_cidx);
+	edma_set_dest_index(lch, ping_size, ram_dst_cidx);
+	edma_set_transfer_params(lch, ping_size, 2,
+			runtime->periods, 2, ASYNC);
+
+	/* init master params */
+	edma_read_slot(prtd->asp_link_lch[0], &prtd->asp_params);
+	edma_read_slot(prtd->ram_link_lch, &prtd->ram_params);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		struct edmacc_param p_ram;
+		/* Copy entire iram buffer before playback started */
+		prtd->ram_params.a_b_cnt = (1 << 16) | (ping_size << 1);
+		/* 0 dst_bidx */
+		prtd->ram_params.src_dst_bidx = (ping_size << 1);
+		/* 0 dst_cidx */
+		prtd->ram_params.src_dst_cidx = (ping_size << 1);
+		prtd->ram_params.ccnt = 1;
+
+		/* Skip 1st period */
+		edma_read_slot(prtd->ram_link_lch, &p_ram);
+		p_ram.src += (ping_size << 1);
+		p_ram.ccnt -= 1;
+		edma_write_slot(prtd->ram_link_lch2, &p_ram);
+		/*
+		 * When 1st started, ram -> iram dma channel will fill the
+		 * entire iram.  Then, whenever a ping/pong asp buffer finishes,
+		 * 1/2 iram will be filled.
+		 */
+		prtd->ram_params.link_bcntrld =
+			EDMA_CHAN_SLOT(prtd->ram_link_lch2) << 5;
 	}
+	return 0;
+}
+
+/* 1 asp tx or rx channel using 2 parameter channels
+ * 1 ram to/from iram channel using 1 parameter channel
+ *
+ * Playback
+ * ram copy channel kicks off first,
+ * 1st ram copy of entire iram buffer completion kicks off asp channel
+ * asp tcc always kicks off ram copy of 1/2 iram buffer
+ *
+ * Record
+ * asp channel starts, tcc kicks off ram copy
+ */
+static int request_ping_pong(struct snd_pcm_substream *substream,
+		struct davinci_runtime_data *prtd,
+		struct snd_dma_buffer *iram_dma)
+{
+	dma_addr_t asp_src_ping;
+	dma_addr_t asp_dst_ping;
+	int lch;
+	struct davinci_pcm_dma_params *dma_data = prtd->params;
+
+	/* Request ram master channel */
+	lch = prtd->ram_master_lch = edma_alloc_channel(EDMA_CHANNEL_ANY,
+				  davinci_pcm_dma_irq, substream,
+				  EVENTQ_1);
+	if (lch < 0)
+		goto exit1;
+
+	/* Request ram link channel */
+	lch = prtd->ram_link_lch = edma_alloc_slot(
+			EDMA_CTLR(prtd->ram_master_lch), EDMA_SLOT_ANY);
+	if (lch < 0)
+		goto exit2;
+
+	lch = prtd->asp_link_lch[1] = edma_alloc_slot(
+			EDMA_CTLR(prtd->asp_master_lch), EDMA_SLOT_ANY);
+	if (lch < 0)
+		goto exit3;
+
+	prtd->ram_link_lch2 = -1;
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		lch = prtd->ram_link_lch2 = edma_alloc_slot(
+			EDMA_CTLR(prtd->ram_master_lch), EDMA_SLOT_ANY);
+		if (lch < 0)
+			goto exit4;
+	}
+	/* circle ping-pong buffers */
+	edma_link(prtd->asp_link_lch[0], prtd->asp_link_lch[1]);
+	edma_link(prtd->asp_link_lch[1], prtd->asp_link_lch[0]);
+	/* circle ram buffers */
+	edma_link(prtd->ram_link_lch, prtd->ram_link_lch);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		asp_src_ping = iram_dma->addr;
+		asp_dst_ping = dma_data->dma_addr;	/* fifo */
+	} else {
+		asp_src_ping = dma_data->dma_addr;	/* fifo */
+		asp_dst_ping = iram_dma->addr;
+	}
+	/* ping */
+	lch = prtd->asp_link_lch[0];
+	edma_set_src(lch, asp_src_ping, INCR, W16BIT);
+	edma_set_dest(lch, asp_dst_ping, INCR, W16BIT);
+	edma_set_src_index(lch, 0, 0);
+	edma_set_dest_index(lch, 0, 0);
+
+	edma_read_slot(lch, &prtd->asp_params);
+	prtd->asp_params.opt &= ~(TCCMODE | EDMA_TCC(0x3f) | TCINTEN);
+	prtd->asp_params.opt |= TCCHEN | EDMA_TCC(prtd->ram_master_lch & 0x3f);
+	edma_write_slot(lch, &prtd->asp_params);
+
+	/* pong */
+	lch = prtd->asp_link_lch[1];
+	edma_set_src(lch, asp_src_ping, INCR, W16BIT);
+	edma_set_dest(lch, asp_dst_ping, INCR, W16BIT);
+	edma_set_src_index(lch, 0, 0);
+	edma_set_dest_index(lch, 0, 0);
+
+	edma_read_slot(lch, &prtd->asp_params);
+	prtd->asp_params.opt &= ~(TCCMODE | EDMA_TCC(0x3f));
+	/* interrupt after every pong completion */
+	prtd->asp_params.opt |= TCINTEN | TCCHEN |
+		EDMA_TCC(EDMA_CHAN_SLOT(prtd->ram_master_lch));
+	edma_write_slot(lch, &prtd->asp_params);
+
+	/* ram */
+	lch = prtd->ram_link_lch;
+	edma_set_src(lch, iram_dma->addr, INCR, W32BIT);
+	edma_set_dest(lch, iram_dma->addr, INCR, W32BIT);
+	pr_debug("%s: audio dma channels/slots in use for ram:%u %u %u,"
+		"for asp:%u %u %u\n", __func__,
+		prtd->ram_master_lch, prtd->ram_link_lch, prtd->ram_link_lch2,
+		prtd->asp_master_lch, prtd->asp_link_lch[0],
+		prtd->asp_link_lch[1]);
+	return 0;
+exit4:
+	edma_free_channel(prtd->asp_link_lch[1]);
+	prtd->asp_link_lch[1] = -1;
+exit3:
+	edma_free_channel(prtd->ram_link_lch);
+	prtd->ram_link_lch = -1;
+exit2:
+	edma_free_channel(prtd->ram_master_lch);
+	prtd->ram_master_lch = -1;
+exit1:
+	return lch;
 }
 
 static int davinci_pcm_dma_request(struct snd_pcm_substream *substream)
 {
+	struct snd_dma_buffer *iram_dma;
 	struct davinci_runtime_data *prtd = substream->runtime->private_data;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct davinci_pcm_dma_params *dma_data = rtd->dai->cpu_dai->dma_data;
-	struct edmacc_param p_ram;
-	int ret;
+	int lch;
 
 	if (!dma_data)
 		return -ENODEV;
 
 	prtd->params = dma_data;
 
-	/* Request master DMA channel */
-	ret = edma_alloc_channel(prtd->params->channel,
-				  davinci_pcm_dma_irq, substream,
-				  EVENTQ_0);
-	if (ret < 0)
-		return ret;
-	prtd->asp_master_lch = ret;
+	/* Request asp master DMA channel */
+	lch = prtd->asp_master_lch = edma_alloc_channel(dma_data->channel,
+			davinci_pcm_dma_irq, substream, EVENTQ_0);
+	if (lch < 0)
+		goto exit1;
 
-	/* Request parameter RAM reload slot */
-	ret = edma_alloc_slot(EDMA_CTLR(prtd->asp_master_lch), EDMA_SLOT_ANY);
-	if (ret < 0) {
-		edma_free_channel(prtd->asp_master_lch);
-		return ret;
-	}
-	prtd->asp_link_lch[0] = ret;
+	/* Request asp link channels */
+	lch = prtd->asp_link_lch[0] = edma_alloc_slot(
+			EDMA_CTLR(prtd->asp_master_lch), EDMA_SLOT_ANY);
+	if (lch < 0)
+		goto exit2;
+
+	allocate_sram(substream, dma_data->sram_size);
+	iram_dma = (struct snd_dma_buffer *)substream->dma_buffer.private_data;
+	if (iram_dma)
+		return request_ping_pong(substream, prtd, iram_dma);
 
 	/* Issue transfer completion IRQ when the channel completes a
 	 * transfer, then always reload from the same slot (by a kind
@@ -159,12 +455,17 @@ static int davinci_pcm_dma_request(struct snd_pcm_substream *substream)
 	 * the buffer and its length (ccnt) ... use it as a template
 	 * so davinci_pcm_enqueue_dma() takes less time in IRQ.
 	 */
-	edma_read_slot(prtd->asp_link_lch[0], &p_ram);
-	p_ram.opt |= TCINTEN | EDMA_TCC(EDMA_CHAN_SLOT(prtd->asp_master_lch));
-	p_ram.link_bcntrld = EDMA_CHAN_SLOT(prtd->asp_link_lch[0]) << 5;
-	edma_write_slot(prtd->asp_link_lch[0], &p_ram);
-
+	edma_read_slot(lch, &prtd->asp_params);
+	prtd->asp_params.opt |= TCINTEN |
+		EDMA_TCC(EDMA_CHAN_SLOT(prtd->asp_master_lch));
+	prtd->asp_params.link_bcntrld = EDMA_CHAN_SLOT(lch) << 5;
+	edma_write_slot(lch, &prtd->asp_params);
 	return 0;
+exit2:
+	edma_free_channel(prtd->asp_master_lch);
+	prtd->asp_master_lch = -1;
+exit1:
+	return lch;
 }
 
 static int davinci_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
@@ -178,12 +479,12 @@ static int davinci_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		edma_start(prtd->asp_master_lch);
+		edma_resume(prtd->asp_master_lch);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		edma_stop(prtd->asp_master_lch);
+		edma_pause(prtd->asp_master_lch);
 		break;
 	default:
 		ret = -EINVAL;
@@ -198,14 +499,35 @@ static int davinci_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 static int davinci_pcm_prepare(struct snd_pcm_substream *substream)
 {
 	struct davinci_runtime_data *prtd = substream->runtime->private_data;
-	struct edmacc_param temp;
 
+	if (prtd->ram_master_lch >= 0) {
+		int ret = ping_pong_dma_setup(substream);
+		if (ret < 0)
+			return ret;
+
+		edma_write_slot(prtd->ram_master_lch, &prtd->ram_params);
+		edma_write_slot(prtd->asp_master_lch, &prtd->asp_params);
+
+		print_buf_info(prtd->ram_master_lch, "ram_master_lch");
+		print_buf_info(prtd->ram_link_lch, "ram_link_lch");
+		print_buf_info(prtd->ram_link_lch2, "ram_link_lch2");
+		print_buf_info(prtd->asp_master_lch, "asp_master_lch");
+		print_buf_info(prtd->asp_link_lch[0], "asp_link_lch[0]");
+		print_buf_info(prtd->asp_link_lch[1], "asp_link_lch[1]");
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			/* copy 1st iram buffer */
+			edma_start(prtd->ram_master_lch);
+		}
+		edma_start(prtd->asp_master_lch);
+		return 0;
+	}
 	prtd->period = 0;
 	davinci_pcm_enqueue_dma(substream);
 
 	/* Copy self-linked parameter RAM entry into master channel */
-	edma_read_slot(prtd->asp_link_lch[0], &temp);
-	edma_write_slot(prtd->asp_master_lch, &temp);
+	edma_read_slot(prtd->asp_link_lch[0], &prtd->asp_params);
+	edma_write_slot(prtd->asp_master_lch, &prtd->asp_params);
 	davinci_pcm_enqueue_dma(substream);
 
 	return 0;
@@ -217,20 +539,53 @@ davinci_pcm_pointer(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct davinci_runtime_data *prtd = runtime->private_data;
 	unsigned int offset;
-	dma_addr_t count;
-	dma_addr_t src, dst;
+	int asp_count;
+	dma_addr_t asp_src, asp_dst;
 
 	spin_lock(&prtd->lock);
-
-	edma_get_position(prtd->asp_master_lch, &src, &dst);
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		count = src - runtime->dma_addr;
-	else
-		count = dst - runtime->dma_addr;
-
+	if (prtd->ram_master_lch >= 0) {
+		int ram_count;
+		int mod_ram;
+		dma_addr_t ram_src, ram_dst;
+		unsigned int period_size = snd_pcm_lib_period_bytes(substream);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			/* reading ram before asp should be safe
+			 * as long as the asp transfers less than a ping size
+			 * of bytes between the 2 reads
+			 */
+			edma_get_position(prtd->ram_master_lch,
+					&ram_src, &ram_dst);
+			edma_get_position(prtd->asp_master_lch,
+					&asp_src, &asp_dst);
+			asp_count = asp_src - prtd->asp_params.src;
+			ram_count = ram_src - prtd->ram_params.src;
+			mod_ram = ram_count % period_size;
+			mod_ram -= asp_count;
+			if (mod_ram < 0)
+				mod_ram += period_size;
+			else if (mod_ram == 0) {
+				if (snd_pcm_running(substream))
+					mod_ram += period_size;
+			}
+			ram_count -= mod_ram;
+			if (ram_count < 0)
+				ram_count += period_size * runtime->periods;
+		} else {
+			edma_get_position(prtd->ram_master_lch,
+					&ram_src, &ram_dst);
+			ram_count = ram_dst - prtd->ram_params.dst;
+		}
+		asp_count = ram_count;
+	} else {
+		edma_get_position(prtd->asp_master_lch, &asp_src, &asp_dst);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			asp_count = asp_src - runtime->dma_addr;
+		else
+			asp_count = asp_dst - runtime->dma_addr;
+	}
 	spin_unlock(&prtd->lock);
 
-	offset = bytes_to_frames(runtime, count);
+	offset = bytes_to_frames(runtime, asp_count);
 	if (offset >= runtime->buffer_size)
 		offset = 0;
 
@@ -255,6 +610,11 @@ static int davinci_pcm_open(struct snd_pcm_substream *substream)
 		return -ENOMEM;
 
 	spin_lock_init(&prtd->lock);
+	prtd->asp_master_lch = -1;
+	prtd->asp_link_lch[0] = prtd->asp_link_lch[1] = -1;
+	prtd->ram_master_lch = -1;
+	prtd->ram_link_lch = -1;
+	prtd->ram_link_lch2 = -1;
 
 	runtime->private_data = prtd;
 
@@ -272,10 +632,29 @@ static int davinci_pcm_close(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct davinci_runtime_data *prtd = runtime->private_data;
 
-	edma_unlink(prtd->asp_link_lch[0]);
-
-	edma_free_slot(prtd->asp_link_lch[0]);
-	edma_free_channel(prtd->asp_master_lch);
+	if (prtd->ram_master_lch >= 0)
+		edma_stop(prtd->ram_master_lch);
+	if (prtd->asp_master_lch >= 0)
+		edma_stop(prtd->asp_master_lch);
+	if (prtd->asp_link_lch[0] >= 0)
+		edma_unlink(prtd->asp_link_lch[0]);
+	if (prtd->asp_link_lch[1] >= 0)
+		edma_unlink(prtd->asp_link_lch[1]);
+	if (prtd->ram_link_lch >= 0)
+		edma_unlink(prtd->ram_link_lch);
+
+	if (prtd->asp_link_lch[0] >= 0)
+		edma_free_slot(prtd->asp_link_lch[0]);
+	if (prtd->asp_link_lch[1] >= 0)
+		edma_free_slot(prtd->asp_link_lch[1]);
+	if (prtd->asp_master_lch >= 0)
+		edma_free_channel(prtd->asp_master_lch);
+	if (prtd->ram_link_lch >= 0)
+		edma_free_slot(prtd->ram_link_lch);
+	if (prtd->ram_link_lch2 >= 0)
+		edma_free_slot(prtd->ram_link_lch2);
+	if (prtd->ram_master_lch >= 0)
+		edma_free_channel(prtd->ram_master_lch);
 
 	kfree(prtd);
 
@@ -346,6 +725,7 @@ static void davinci_pcm_free(struct snd_pcm *pcm)
 	int stream;
 
 	for (stream = 0; stream < 2; stream++) {
+		struct snd_dma_buffer *iram_dma;
 		substream = pcm->streams[stream].substream;
 		if (!substream)
 			continue;
@@ -357,6 +737,11 @@ static void davinci_pcm_free(struct snd_pcm *pcm)
 		dma_free_writecombine(pcm->card->dev, buf->bytes,
 				      buf->area, buf->addr);
 		buf->area = NULL;
+		iram_dma = (struct snd_dma_buffer *)buf->private_data;
+		if (iram_dma) {
+			sram_free(iram_dma->area, iram_dma->bytes);
+			kfree(iram_dma);
+		}
 	}
 }
 
diff --git a/sound/soc/davinci/davinci-pcm.h b/sound/soc/davinci/davinci-pcm.h
index eb4287f..8d66b35 100644
--- a/sound/soc/davinci/davinci-pcm.h
+++ b/sound/soc/davinci/davinci-pcm.h
@@ -20,6 +20,7 @@ struct davinci_pcm_dma_params {
 	char *name;			/* stream identifier */
 	int channel;			/* sync dma channel ID */
 	dma_addr_t dma_addr;		/* device physical address for DMA */
+	unsigned sram_size;
 	enum dma_event_q eventq_no;	/* event queue number */
 	unsigned char data_type;	/* xfer data type */
 	unsigned char convert_mono_stereo;
-- 
1.5.6.3
