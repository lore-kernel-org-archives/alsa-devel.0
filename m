From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: [PATCH V1 11/11] ASoC: DaVinci: pcm,
	fix underruns by using sram
Date: Sat,  4 Jul 2009 19:30:01 -0700
Message-ID: <1246761001-21982-12-git-send-email-troy.kisky@boundarydevices.com>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-2-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-3-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-10-git-send-email-troy.kisky@boundarydevices.com>
	<1246761001-21982-11-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mpls-qmqp-03.inet.qwest.net (mpls-qmqp-03.inet.qwest.net
	[63.231.195.114])
	by alsa0.perex.cz (Postfix) with ESMTP id EE8EA10386F
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 04:30:12 +0200 (CEST)
In-Reply-To: <1246761001-21982-11-git-send-email-troy.kisky@boundarydevices.com>
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
Cc: davinci-linux-open-source@linux.davincidsp.com, broonie@sirena.org.uk, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Fix underruns by using dma to copy 1st to sram
in a ping/pong buffer style and then copying from
the sram to the ASP. This also has the advantage
of tolerating very long interrupt latency on dma
completion.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
---
 sound/soc/davinci/davinci-pcm.c |  520 ++++++++++++++++++++++++++++++---------
 1 files changed, 403 insertions(+), 117 deletions(-)

diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 2002fdc..754f0b2 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -3,6 +3,7 @@
  *
  * Author:      Vladimir Barinov, <vbarinov@embeddedalley.com>
  * Copyright:   (C) 2007 MontaVista Software, Inc., <source@mvista.com>
+ * added IRAM ping/pong (C) 2008 Troy Kisky <troy.kisky@boundarydevices.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -23,9 +24,31 @@
 
 #include <asm/dma.h>
 #include <mach/edma.h>
+#include <mach/sram.h>
 
 #include "davinci-pcm.h"
 
+#define DAVINCI_PCM_DEBUG 0
+#if DAVINCI_PCM_DEBUG
+#define DPRINTK(format, arg...) printk(KERN_DEBUG format, ## arg)
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
+#define DPRINTK(format, arg...) do {} while (0)
+static void print_buf_info(int lch, char *name)
+{
+}
+#endif
+
 static struct snd_pcm_hardware davinci_pcm_hardware = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
@@ -42,142 +65,323 @@ static struct snd_pcm_hardware davinci_pcm_hardware = {
 	.channels_max = 2,
 	.buffer_bytes_max = 128 * 1024,
 	.period_bytes_min = 32,
-	.period_bytes_max = 8 * 1024,
+	.period_bytes_max = 7 * 512,	/* This is size of ping + pong buffer*/
 	.periods_min = 16,
 	.periods_max = 255,
 	.fifo_size = 0,
 };
 
+/*
+ * How it works....
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
-	int period;		/* current DMA period */
-	int master_lch;		/* Master DMA channel */
-	int slave_lch;		/* linked parameter RAM reload slot */
-	struct davinci_pcm_dma_params *params;	/* DMA params */
+	int asp_master_lch;		/* Master DMA channel */
+	int asp_link_lch[2];	/* asp parameter link channel */
+	int ram_master_lch;
+	int ram_link_lch;
+	int ram_link_lch2;
+	struct edmacc_param asp_params;
+	struct edmacc_param ram_params;
 };
 
-static void davinci_pcm_enqueue_dma(struct snd_pcm_substream *substream)
+
+static void davinci_pcm_dma_irq(unsigned lch, u16 ch_status, void *data)
 {
+	struct snd_pcm_substream *substream = data;
 	struct davinci_runtime_data *prtd = substream->runtime->private_data;
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	int lch = prtd->slave_lch;
-	unsigned int period_size;
-	unsigned int dma_offset;
-	dma_addr_t dma_pos;
-	dma_addr_t src, dst;
-	unsigned int count;
-	unsigned int data_type = prtd->params->data_type;
-	unsigned int convert_mono_stereo = prtd->params->convert_mono_stereo;
-
-	period_size = snd_pcm_lib_period_bytes(substream);
-	dma_offset = prtd->period * period_size;
-	dma_pos = runtime->dma_addr + dma_offset;
+	print_buf_info(prtd->ram_master_lch, "i ram_master_lch");
+	pr_debug("davinci_pcm: lch=%d, status=0x%x\n", lch, ch_status);
+	if (unlikely(ch_status != DMA_COMPLETE))
+		return;
 
-	pr_debug("davinci_pcm: audio_set_dma_params_play channel = %d "
-		"dma_ptr = %x period_size=%x\n", lch, dma_pos, period_size);
+	if (snd_pcm_running(substream))
+		snd_pcm_period_elapsed(substream);
+}
 
-	count = period_size / data_type;
 
+/*
+ * This is called after runtime->dma_addr, period_bytes and data_type are valid
+ */
+static int davinci_pcm_dma_setup(struct snd_pcm_substream *substream)
+{
+	unsigned short ram_src_cidx, ram_dst_cidx;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct davinci_runtime_data *prtd = runtime->private_data;
+	struct snd_dma_buffer *iram_dma =
+		(struct snd_dma_buffer *)substream->dma_buffer.private_data;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct davinci_pcm_dma_params *dma_data = rtd->dai->cpu_dai->dma_data;
+	unsigned int data_type = dma_data->data_type;
+	unsigned int convert_mono_stereo = dma_data->convert_mono_stereo;
+	/* divide by 2 for ping/pong */
+	unsigned int ping_size = snd_pcm_lib_period_bytes(substream) >> 1;
+	int lch = prtd->asp_link_lch[1];
+	if ((data_type == 0) || (data_type > 4)) {
+		printk(KERN_ERR "%s: data_type=%i\n", __func__, data_type);
+		return -EINVAL;
+	}
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		src = dma_pos;
-		dst = prtd->params->dma_addr;
-		if (convert_mono_stereo)
+		dma_addr_t asp_src_pong = iram_dma->addr + ping_size;
+		ram_src_cidx = ping_size;
+		ram_dst_cidx = -ping_size;
+		edma_set_src(lch, asp_src_pong, INCR, W8BIT);
+
+		lch = prtd->asp_link_lch[0];
+		if (convert_mono_stereo) {
 			edma_set_src_index(lch, 0, data_type);
-		else
+			lch = prtd->asp_link_lch[1];
+			edma_set_src_index(lch, 0, data_type);
+		} else {
+			edma_set_src_index(lch, data_type, 0);
+			lch = prtd->asp_link_lch[1];
 			edma_set_src_index(lch, data_type, 0);
-		edma_set_dest_index(lch, 0, 0);
+		}
+
+		lch = prtd->ram_link_lch;
+		edma_set_src(lch, runtime->dma_addr, INCR, W32BIT);
 	} else {
-		src = prtd->params->dma_addr;
-		dst = dma_pos;
-		edma_set_src_index(lch, 0, 0);
-		if (convert_mono_stereo)
+		dma_addr_t asp_dst_pong = iram_dma->addr + ping_size;
+		ram_src_cidx = -ping_size;
+		ram_dst_cidx = ping_size;
+		edma_set_dest(lch, asp_dst_pong, INCR, W8BIT);
+
+		lch = prtd->asp_link_lch[0];
+		if (convert_mono_stereo) {
+			edma_set_dest_index(lch, 0, data_type);
+			lch = prtd->asp_link_lch[1];
 			edma_set_dest_index(lch, 0, data_type);
-		else
+		} else {
+			edma_set_dest_index(lch, data_type, 0);
+			lch = prtd->asp_link_lch[1];
 			edma_set_dest_index(lch, data_type, 0);
+		}
+		lch = prtd->ram_link_lch;
+		edma_set_dest(lch, runtime->dma_addr, INCR, W32BIT);
 	}
 
-	edma_set_src(lch, src, INCR, W8BIT);
-	edma_set_dest(lch, dst, INCR, W8BIT);
+	lch = prtd->asp_link_lch[0];
 	if (convert_mono_stereo) {
 		/*
 		 * Each byte is sent twice, so
-		 * A_CNT * B_CNT * C_CNT = 2 * period_size
+		 * A_CNT * B_CNT * C_CNT = 2 * ping_size
 		 */
-		edma_set_transfer_params(lch, data_type, 2, count, 2, ASYNC);
+		edma_set_transfer_params(lch, data_type,
+				2, ping_size/data_type, 2, ASYNC);
+		lch = prtd->asp_link_lch[1];
+		edma_set_transfer_params(lch, data_type,
+				2, ping_size/data_type, 2, ASYNC);
 	} else {
-		edma_set_transfer_params(lch, data_type, count, 1, 0, ASYNC);
+		edma_set_transfer_params(lch, data_type,
+				ping_size/data_type, 1, 0, ASYNC);
+		lch = prtd->asp_link_lch[1];
+		edma_set_transfer_params(lch, data_type,
+				ping_size/data_type, 1, 0, ASYNC);
 	}
 
-	prtd->period++;
-	if (unlikely(prtd->period >= runtime->periods))
-		prtd->period = 0;
-}
 
-static void davinci_pcm_dma_irq(unsigned lch, u16 ch_status, void *data)
-{
-	struct snd_pcm_substream *substream = data;
-	struct davinci_runtime_data *prtd = substream->runtime->private_data;
-
-	pr_debug("davinci_pcm: lch=%d, status=0x%x\n", lch, ch_status);
+	lch = prtd->ram_link_lch;
+	edma_set_src_index(lch, ping_size, ram_src_cidx);
+	edma_set_dest_index(lch, ping_size, ram_dst_cidx);
+	edma_set_transfer_params(lch, ping_size, 2,
+			runtime->periods, 2, ASYNC);
 
-	if (unlikely(ch_status != DMA_COMPLETE))
-		return;
-
-	if (snd_pcm_running(substream)) {
-		snd_pcm_period_elapsed(substream);
-
-		spin_lock(&prtd->lock);
-		davinci_pcm_enqueue_dma(substream);
-		spin_unlock(&prtd->lock);
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
+/*
+ * when 1st started, ram -> iram dma channel will fill the entire iram
+ * Then, whenever a ping/pong asp buffer finishes, 1/2 iram will be filled
+ */
+		prtd->ram_params.link_bcntrld =
+			EDMA_CHAN_SLOT(prtd->ram_link_lch2) << 5;
 	}
+	return 0;
 }
 
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
 static int davinci_pcm_dma_request(struct snd_pcm_substream *substream)
 {
-	struct davinci_runtime_data *prtd = substream->runtime->private_data;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_dma_buffer *iram_dma =
+		(struct snd_dma_buffer *)substream->dma_buffer.private_data;
+	struct davinci_runtime_data *prtd = runtime->private_data;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct davinci_pcm_dma_params *dma_data = rtd->dai->cpu_dai->dma_data;
 	struct edmacc_param p_ram;
+
+	dma_addr_t asp_src_ping;
+	dma_addr_t asp_dst_ping;
+
 	int ret;
+	int lch;
 
-	if (!dma_data)
+	if ((!dma_data) || (!iram_dma))
 		return -ENODEV;
 
-	prtd->params = dma_data;
-
-	/* Request master DMA channel */
-	ret = edma_alloc_channel(prtd->params->channel,
+	/* Request ram master channel */
+	ret = prtd->ram_master_lch = edma_alloc_channel(EDMA_CHANNEL_ANY,
 				  davinci_pcm_dma_irq, substream,
-				  EVENTQ_0);
+				  EVENTQ_1);
 	if (ret < 0)
-		return ret;
-	prtd->master_lch = ret;
+		goto exit1;
 
-	/* Request parameter RAM reload slot */
-	ret = edma_alloc_slot(EDMA_SLOT_ANY);
-	if (ret < 0) {
-		edma_free_channel(prtd->master_lch);
-		return ret;
+	/* Request ram link channel */
+	ret = prtd->ram_link_lch = edma_alloc_slot(
+			EDMA_CTLR(prtd->ram_master_lch), EDMA_SLOT_ANY);
+	if (ret < 0)
+		goto exit2;
+
+	/* Request asp master DMA channel */
+	ret = prtd->asp_master_lch = edma_alloc_channel(dma_data->channel,
+			  davinci_pcm_dma_irq, substream,
+			  EVENTQ_0);
+	if (ret < 0)
+		goto exit3;
+
+	/* Request asp link channels */
+	ret = prtd->asp_link_lch[0] = edma_alloc_slot(
+			EDMA_CTLR(prtd->asp_master_lch), EDMA_SLOT_ANY);
+	if (ret < 0)
+		goto exit4;
+	ret = prtd->asp_link_lch[1] = edma_alloc_slot(
+			EDMA_CTLR(prtd->asp_master_lch), EDMA_SLOT_ANY);
+	if (ret < 0)
+		goto exit5;
+
+	prtd->ram_link_lch2 = -1;
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		ret = prtd->ram_link_lch2 = edma_alloc_slot(
+				EDMA_CTLR(prtd->ram_master_lch), EDMA_SLOT_ANY);
+		if (ret < 0)
+			goto exit6;
 	}
-	prtd->slave_lch = ret;
-
-	/* Issue transfer completion IRQ when the channel completes a
-	 * transfer, then always reload from the same slot (by a kind
-	 * of loopback link).  The completion IRQ handler will update
-	 * the reload slot with a new buffer.
-	 *
-	 * REVISIT save p_ram here after setting up everything except
-	 * the buffer and its length (ccnt) ... use it as a template
-	 * so davinci_pcm_enqueue_dma() takes less time in IRQ.
-	 */
-	edma_read_slot(prtd->slave_lch, &p_ram);
-	p_ram.opt |= TCINTEN | EDMA_TCC(prtd->master_lch);
-	p_ram.link_bcntrld = prtd->slave_lch << 5;
-	edma_write_slot(prtd->slave_lch, &p_ram);
+	/* circle ping-pong buffers */
+	edma_link(prtd->asp_link_lch[0], prtd->asp_link_lch[1]);
+	edma_link(prtd->asp_link_lch[1], prtd->asp_link_lch[0]);
+	/* circle ram buffers */
+	edma_link(prtd->ram_link_lch, prtd->ram_link_lch);
 
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
+	edma_read_slot(lch, &p_ram);
+	p_ram.opt &= ~(TCCMODE | EDMA_TCC(0x3f) | TCINTEN);
+	p_ram.opt |= TCCHEN | EDMA_TCC(prtd->ram_master_lch & 0x3f);
+	edma_write_slot(lch, &p_ram);
+
+	/* pong */
+	lch = prtd->asp_link_lch[1];
+	edma_set_src(lch, asp_src_ping, INCR, W16BIT);
+	edma_set_dest(lch, asp_dst_ping, INCR, W16BIT);
+	edma_set_src_index(lch, 0, 0);
+	edma_set_dest_index(lch, 0, 0);
+
+	edma_read_slot(lch, &p_ram);
+	p_ram.opt &= ~(TCCMODE | EDMA_TCC(0x3f));
+	/* interrupt after every pong completion */
+	p_ram.opt |= TCINTEN | TCCHEN | EDMA_TCC(
+			EDMA_CHAN_SLOT(prtd->ram_master_lch));
+	edma_write_slot(lch, &p_ram);
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
 	return 0;
+exit6:
+	edma_free_channel(prtd->ram_link_lch2);
+exit5:
+	edma_free_channel(prtd->asp_link_lch[0]);
+exit4:
+	edma_free_channel(prtd->asp_master_lch);
+exit3:
+	edma_free_channel(prtd->ram_link_lch);
+exit2:
+	edma_free_channel(prtd->ram_master_lch);
+exit1:
+	return ret;
 }
-
+/* I2S master (codec/cpudai) should start/stop dma request,
+ *  we shouldn't ignore them
+ *  codec AIC33 needs fixed
+ */
+#define BROKEN_MASTER 1
+#ifdef BROKEN_MASTER
 static int davinci_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct davinci_runtime_data *prtd = substream->runtime->private_data;
@@ -189,12 +393,12 @@ static int davinci_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		edma_start(prtd->master_lch);
+		edma_resume(prtd->asp_master_lch);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		edma_stop(prtd->master_lch);
+		edma_pause(prtd->asp_master_lch);
 		break;
 	default:
 		ret = -EINVAL;
@@ -205,19 +409,32 @@ static int davinci_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 
 	return ret;
 }
+#endif
 
 static int davinci_pcm_prepare(struct snd_pcm_substream *substream)
 {
+	int ret;
 	struct davinci_runtime_data *prtd = substream->runtime->private_data;
-	struct edmacc_param temp;
 
-	prtd->period = 0;
-	davinci_pcm_enqueue_dma(substream);
+	ret = davinci_pcm_dma_setup(substream);
+	if (ret < 0)
+		return ret;
+
+	edma_write_slot(prtd->ram_master_lch, &prtd->ram_params);
+	edma_write_slot(prtd->asp_master_lch, &prtd->asp_params);
 
-	/* Copy self-linked parameter RAM entry into master channel */
-	edma_read_slot(prtd->slave_lch, &temp);
-	edma_write_slot(prtd->master_lch, &temp);
+	print_buf_info(prtd->ram_master_lch, "ram_master_lch");
+	print_buf_info(prtd->ram_link_lch, "ram_link_lch");
+	print_buf_info(prtd->ram_link_lch2, "ram_link_lch2");
+	print_buf_info(prtd->asp_master_lch, "asp_master_lch");
+	print_buf_info(prtd->asp_link_lch[0], "asp_link_lch[0]");
+	print_buf_info(prtd->asp_link_lch[1], "asp_link_lch[1]");
 
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		/* copy 1st iram buffer */
+		edma_start(prtd->ram_master_lch);
+	}
+	edma_start(prtd->asp_master_lch);
 	return 0;
 }
 
@@ -227,20 +444,44 @@ davinci_pcm_pointer(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct davinci_runtime_data *prtd = runtime->private_data;
 	unsigned int offset;
-	dma_addr_t count;
-	dma_addr_t src, dst;
+	int count_asp, count_ram;
+	int mod_ram;
+	dma_addr_t ram_src, ram_dst;
+	dma_addr_t asp_src, asp_dst;
+	unsigned int period_size = snd_pcm_lib_period_bytes(substream);
 
 	spin_lock(&prtd->lock);
-
-	edma_get_position(prtd->master_lch, &src, &dst);
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		count = src - runtime->dma_addr;
-	else
-		count = dst - runtime->dma_addr;
-
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		/* reading ram before asp should be safe
+		 * as long as the asp transfers less than a ping size
+		 * of bytes between the 2 reads
+		 */
+		edma_get_position(prtd->ram_master_lch,
+				&ram_src, &ram_dst);
+		edma_get_position(prtd->asp_master_lch,
+				&asp_src, &asp_dst);
+		count_asp = asp_src - prtd->asp_params.src;
+		count_ram = ram_src - prtd->ram_params.src;
+		mod_ram = count_ram % period_size;
+		mod_ram -= count_asp;
+		if (mod_ram < 0)
+			mod_ram += period_size;
+		else if (mod_ram == 0) {
+			if (snd_pcm_running(substream))
+				mod_ram += period_size;
+		}
+		count_ram -= mod_ram;
+		if (count_ram < 0)
+			count_ram += period_size * runtime->periods;
+	} else {
+		edma_get_position(prtd->ram_master_lch,
+				&ram_src, &ram_dst);
+		count_ram = ram_dst - prtd->ram_params.dst;
+	}
 	spin_unlock(&prtd->lock);
 
-	offset = bytes_to_frames(runtime, count);
+	offset = bytes_to_frames(runtime, count_ram);
+	DPRINTK("count_ram=0x%x\n", count_ram);
 	if (offset >= runtime->buffer_size)
 		offset = 0;
 
@@ -254,6 +495,11 @@ static int davinci_pcm_open(struct snd_pcm_substream *substream)
 	int ret = 0;
 
 	snd_soc_set_runtime_hwparams(substream, &davinci_pcm_hardware);
+	/* ensure that buffer size is a multiple of period size */
+	ret = snd_pcm_hw_constraint_integer(runtime,
+						SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		return ret;
 
 	prtd = kzalloc(sizeof(struct davinci_runtime_data), GFP_KERNEL);
 	if (prtd == NULL)
@@ -277,13 +523,22 @@ static int davinci_pcm_close(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct davinci_runtime_data *prtd = runtime->private_data;
 
-	edma_unlink(prtd->slave_lch);
-
-	edma_free_slot(prtd->slave_lch);
-	edma_free_channel(prtd->master_lch);
-
+	edma_stop(prtd->ram_master_lch);
+	edma_stop(prtd->asp_master_lch);
+	edma_unlink(prtd->asp_link_lch[0]);
+	edma_unlink(prtd->asp_link_lch[1]);
+	edma_unlink(prtd->ram_link_lch);
+
+	edma_free_slot(prtd->asp_link_lch[0]);
+	edma_free_slot(prtd->asp_link_lch[1]);
+	edma_free_channel(prtd->asp_master_lch);
+	edma_free_slot(prtd->ram_link_lch);
+	if (prtd->ram_link_lch2 != -1) {
+		edma_free_slot(prtd->ram_link_lch2);
+		prtd->ram_link_lch2 = -1;
+	}
+	edma_free_channel(prtd->ram_master_lch);
 	kfree(prtd);
-
 	return 0;
 }
 
@@ -317,7 +572,9 @@ static struct snd_pcm_ops davinci_pcm_ops = {
 	.hw_params = 	davinci_pcm_hw_params,
 	.hw_free = 	davinci_pcm_hw_free,
 	.prepare = 	davinci_pcm_prepare,
-	.trigger = 	davinci_pcm_trigger,
+#ifdef BROKEN_MASTER
+	.trigger =	davinci_pcm_trigger,
+#endif
 	.pointer = 	davinci_pcm_pointer,
 	.mmap = 	davinci_pcm_mmap,
 };
@@ -327,21 +584,44 @@ static int davinci_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
 	struct snd_pcm_substream *substream = pcm->streams[stream].substream;
 	struct snd_dma_buffer *buf = &substream->dma_buffer;
 	size_t size = davinci_pcm_hardware.buffer_bytes_max;
+	struct snd_dma_buffer *iram_dma = NULL;
+	dma_addr_t iram_phys = 0;
+	void *iram_virt = NULL;
+	unsigned int iram_size = davinci_pcm_hardware.period_bytes_max;
 
 	buf->dev.type = SNDRV_DMA_TYPE_DEV;
 	buf->dev.dev = pcm->card->dev;
 	buf->private_data = NULL;
+	buf->bytes = size;
 	buf->area = dma_alloc_writecombine(pcm->card->dev, size,
 					   &buf->addr, GFP_KERNEL);
 
 	pr_debug("davinci_pcm: preallocate_dma_buffer: area=%p, addr=%p, "
 		"size=%d\n", (void *) buf->area, (void *) buf->addr, size);
 
-	if (!buf->area)
-		return -ENOMEM;
 
-	buf->bytes = size;
+	if (!buf->area)
+		goto exit1;
+	iram_virt = sram_alloc(iram_size, &iram_phys);
+	if (!iram_virt)
+		goto exit2;
+	iram_dma = kzalloc(sizeof(*iram_dma), GFP_KERNEL);
+	if (!iram_dma)
+		goto exit3;
+	iram_dma->area = iram_virt;
+	iram_dma->addr = iram_phys;
+	memset(iram_dma->area, 0, iram_size);
+	buf->private_data = iram_dma ;
 	return 0;
+	kfree(iram_dma);
+exit3:
+	if (iram_virt)
+		sram_free(iram_virt, iram_size);
+exit2:
+	dma_free_writecombine(pcm->card->dev, size, buf->area, buf->addr);
+	buf->area = NULL;
+exit1:
+	return -ENOMEM;
 }
 
 static void davinci_pcm_free(struct snd_pcm *pcm)
@@ -351,6 +631,8 @@ static void davinci_pcm_free(struct snd_pcm *pcm)
 	int stream;
 
 	for (stream = 0; stream < 2; stream++) {
+		unsigned int iram_size = davinci_pcm_hardware.period_bytes_max;
+		struct snd_dma_buffer *iram_dma;
 		substream = pcm->streams[stream].substream;
 		if (!substream)
 			continue;
@@ -362,6 +644,11 @@ static void davinci_pcm_free(struct snd_pcm *pcm)
 		dma_free_writecombine(pcm->card->dev, buf->bytes,
 				      buf->area, buf->addr);
 		buf->area = NULL;
+		iram_dma = (struct snd_dma_buffer *)buf->private_data;
+		if (iram_dma) {
+			sram_free(iram_dma->area, iram_size);
+			kfree(iram_dma);
+		}
 	}
 }
 
@@ -379,18 +666,17 @@ static int davinci_pcm_new(struct snd_card *card,
 
 	if (dai->playback.channels_min) {
 		ret = davinci_pcm_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_PLAYBACK);
+				SNDRV_PCM_STREAM_PLAYBACK);
 		if (ret)
 			return ret;
 	}
 
 	if (dai->capture.channels_min) {
 		ret = davinci_pcm_preallocate_dma_buffer(pcm,
-			SNDRV_PCM_STREAM_CAPTURE);
+				SNDRV_PCM_STREAM_CAPTURE);
 		if (ret)
 			return ret;
 	}
-
 	return 0;
 }
 
-- 
1.5.6.3
