From: eliot@blennerhassett.gen.nz
Subject: [PATCH 06/10] ALSA: asihpi: Add support for stream
	interrupt.
Date: Thu, 20 Nov 2014 16:22:53 +1300
Message-ID: <1416453777-7155-7-git-send-email-eliot@blennerhassett.gen.nz>
References: <1416453777-7155-1-git-send-email-eliot@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AFA6265885
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 04:25:45 +0100 (CET)
Received: from mxin1-orange.clear.net.nz
 (lb2-srcnat.clear.net.nz [203.97.32.237])
 by smtp3.clear.net.nz (CLEAR Net Mail)
 with ESMTP id <0NFB00629ITMQA30@smtp3.clear.net.nz> for
 alsa-devel@alsa-project.org; Thu, 20 Nov 2014 16:25:42 +1300 (NZDT)
In-reply-to: <1416453777-7155-1-git-send-email-eliot@blennerhassett.gen.nz>
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
Cc: tiwai@suse.de, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>

Some cards have a so-called low-latency mode, in which they present
a single multichannel stream with no mixing or samplerate conversion.
In this mode the card can generate an interrupt per internal processing
block (typically 32 or 64 frames)

Signed-off-by: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
---
 sound/pci/asihpi/asihpi.c       | 177 +++++++++++++++++++++++++++++++++-------
 sound/pci/asihpi/hpi6205.c      |  43 ++++++++--
 sound/pci/asihpi/hpi_internal.h |   4 +-
 sound/pci/asihpi/hpicmn.h       |  19 ++++-
 sound/pci/asihpi/hpioctl.c      | 124 ++++++++++++++++++++++++++--
 sound/pci/asihpi/hpios.h        |   4 +
 6 files changed, 321 insertions(+), 50 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 0752ba7..4200fec 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -1,6 +1,6 @@
 /*
  *  Asihpi soundcard
- *  Copyright (c) by AudioScience Inc <alsa@audioscience.com>
+ *  Copyright (c) by AudioScience Inc <support@audioscience.com>
  *
  *   This program is free software; you can redistribute it and/or modify
  *   it under the terms of version 2 of the GNU General Public License as
@@ -124,6 +124,16 @@ struct snd_card_asihpi {
 	struct pci_dev *pci;
 	struct hpi_adapter *hpi;
 
+	/* In low latency mode there is only one stream, a pointer to its
+	 * private data is stored here on trigger and cleared on stop.
+	 * The interrupt handler uses it as a parameter when calling
+	 * snd_card_asihpi_timer_function().
+	 */
+	struct snd_card_asihpi_pcm *llmode_streampriv;
+	struct tasklet_struct t;
+	void (*pcm_start)(struct snd_pcm_substream *substream);
+	void (*pcm_stop)(struct snd_pcm_substream *substream);
+
 	u32 h_mixer;
 	struct clk_cache cc;
 
@@ -544,6 +554,48 @@ static void snd_card_asihpi_pcm_timer_stop(struct snd_pcm_substream *substream)
 	del_timer(&dpcm->timer);
 }
 
+static void snd_card_asihpi_pcm_int_start(struct snd_pcm_substream *substream)
+{
+	struct snd_card_asihpi_pcm *dpcm;
+	struct snd_card_asihpi *card;
+
+	BUG_ON(!substream);
+
+	dpcm = (struct snd_card_asihpi_pcm *)substream->runtime->private_data;
+	card = snd_pcm_substream_chip(substream);
+
+	BUG_ON(in_interrupt());
+	tasklet_disable(&card->t);
+	card->llmode_streampriv = dpcm;
+	tasklet_enable(&card->t);
+
+	hpi_handle_error(hpi_adapter_set_property(card->hpi->adapter->index,
+		HPI_ADAPTER_PROPERTY_IRQ_RATE,
+		card->update_interval_frames, 0));
+}
+
+static void snd_card_asihpi_pcm_int_stop(struct snd_pcm_substream *substream)
+{
+	struct snd_card_asihpi_pcm *dpcm;
+	struct snd_card_asihpi *card;
+
+	BUG_ON(!substream);
+
+	dpcm = (struct snd_card_asihpi_pcm *)substream->runtime->private_data;
+	card = snd_pcm_substream_chip(substream);
+
+	hpi_handle_error(hpi_adapter_set_property(card->hpi->adapter->index,
+		HPI_ADAPTER_PROPERTY_IRQ_RATE, 0, 0));
+
+	if (in_interrupt())
+		card->llmode_streampriv = NULL;
+	else {
+		tasklet_disable(&card->t);
+		card->llmode_streampriv = NULL;
+		tasklet_enable(&card->t);
+	}
+}
+
 static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 					   int cmd)
 {
@@ -602,7 +654,7 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 				break;
 		}
 		/* start the master stream */
-		snd_card_asihpi_pcm_timer_start(substream);
+		card->pcm_start(substream);
 		if ((substream->stream == SNDRV_PCM_STREAM_CAPTURE) ||
 			!card->can_dma)
 			hpi_handle_error(hpi_stream_start(dpcm->h_stream));
@@ -610,7 +662,7 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 
 	case SNDRV_PCM_TRIGGER_STOP:
 		snd_printdd("%s trigger stop\n", name);
-		snd_card_asihpi_pcm_timer_stop(substream);
+		card->pcm_stop(substream);
 		snd_pcm_group_for_each_entry(s, substream) {
 			if (snd_pcm_substream_chip(s) != card)
 				continue;
@@ -641,12 +693,12 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		snd_printdd("%s trigger pause release\n", name);
+		card->pcm_start(substream);
 		hpi_handle_error(hpi_stream_start(dpcm->h_stream));
-		snd_card_asihpi_pcm_timer_start(substream);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		snd_printdd("%s trigger pause push\n", name);
-		snd_card_asihpi_pcm_timer_stop(substream);
+		card->pcm_stop(substream);
 		hpi_handle_error(hpi_stream_stop(dpcm->h_stream));
 		break;
 	default:
@@ -718,8 +770,8 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 	u32 buffer_size, bytes_avail, samples_played, on_card_bytes;
 	char name[16];
 
-	snd_pcm_debug_name(substream, name, sizeof(name));
 
+	snd_pcm_debug_name(substream, name, sizeof(name));
 
 	/* find minimum newdata and buffer pos in group */
 	snd_pcm_group_for_each_entry(s, substream) {
@@ -782,7 +834,8 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 				newdata);
 		}
 
-		snd_printddd("timer1, %s, %d, S=%d, elap=%d, rw=%d, dsp=%d, left=%d, aux=%d, space=%d, hw_ptr=%ld, appl_ptr=%ld\n",
+		snd_printddd(
+			"timer1, %s, %d, S=%d, elap=%d, rw=%d, dsp=%d, left=%d, aux=%d, space=%d, hw_ptr=%ld, appl_ptr=%ld\n",
 			name, s->number, state,
 			ds->pcm_buf_elapsed_dma_ofs,
 			ds->pcm_buf_host_rw_ofs,
@@ -818,11 +871,13 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 
 	snd_pcm_group_for_each_entry(s, substream) {
 		struct snd_card_asihpi_pcm *ds = s->runtime->private_data;
+		runtime = s->runtime;
 
 		/* don't link Cap and Play */
 		if (substream->stream != s->stream)
 			continue;
 
+		/* Store dma offset for use by pointer callback */
 		ds->pcm_buf_dma_ofs = pcm_buf_dma_ofs;
 
 		if (xfercount &&
@@ -881,16 +936,38 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 							pd, xfer2));
 				}
 			}
+			/* ? host_rw_ofs always ahead of elapsed_dma_ofs by preload size? */
 			ds->pcm_buf_host_rw_ofs += xfercount;
 			ds->pcm_buf_elapsed_dma_ofs += xfercount;
 			snd_pcm_period_elapsed(s);
 		}
 	}
 
-	if (dpcm->respawn_timer)
+	if (!card->hpi->interrupt_mode && dpcm->respawn_timer)
 		add_timer(&dpcm->timer);
 }
 
+static void snd_card_asihpi_int_task(unsigned long data)
+{
+	struct hpi_adapter *a = (struct hpi_adapter *)data;
+	struct snd_card_asihpi *asihpi;
+
+	WARN_ON(!a || !a->snd_card || !a->snd_card->private_data);
+	asihpi = (struct snd_card_asihpi *)a->snd_card->private_data;
+	if (asihpi->llmode_streampriv)
+		snd_card_asihpi_timer_function(
+			(unsigned long)asihpi->llmode_streampriv);
+}
+
+static void snd_card_asihpi_isr(struct hpi_adapter *a)
+{
+	struct snd_card_asihpi *asihpi;
+
+	WARN_ON(!a || !a->snd_card || !a->snd_card->private_data);
+	asihpi = (struct snd_card_asihpi *)a->snd_card->private_data;
+	tasklet_schedule(&asihpi->t);
+}
+
 /***************************** PLAYBACK OPS ****************/
 static int snd_card_asihpi_playback_ioctl(struct snd_pcm_substream *substream,
 					  unsigned int cmd, void *arg)
@@ -998,13 +1075,22 @@ static int snd_card_asihpi_playback_open(struct snd_pcm_substream *substream)
 	runtime->private_free = snd_card_asihpi_runtime_free;
 
 	memset(&snd_card_asihpi_playback, 0, sizeof(snd_card_asihpi_playback));
-	snd_card_asihpi_playback.buffer_bytes_max = BUFFER_BYTES_MAX;
-	snd_card_asihpi_playback.period_bytes_min = PERIOD_BYTES_MIN;
-	/*?snd_card_asihpi_playback.period_bytes_min =
-	card->out_max_chans * 4096; */
-	snd_card_asihpi_playback.period_bytes_max = BUFFER_BYTES_MAX / PERIODS_MIN;
-	snd_card_asihpi_playback.periods_min = PERIODS_MIN;
-	snd_card_asihpi_playback.periods_max = BUFFER_BYTES_MAX / PERIOD_BYTES_MIN;
+	if (!card->hpi->interrupt_mode) {
+		snd_card_asihpi_playback.buffer_bytes_max = BUFFER_BYTES_MAX;
+		snd_card_asihpi_playback.period_bytes_min = PERIOD_BYTES_MIN;
+		snd_card_asihpi_playback.period_bytes_max = BUFFER_BYTES_MAX / PERIODS_MIN;
+		snd_card_asihpi_playback.periods_min = PERIODS_MIN;
+		snd_card_asihpi_playback.periods_max = BUFFER_BYTES_MAX / PERIOD_BYTES_MIN;
+	} else {
+		size_t pbmin = card->update_interval_frames *
+			card->out_max_chans;
+		snd_card_asihpi_playback.buffer_bytes_max = BUFFER_BYTES_MAX;
+		snd_card_asihpi_playback.period_bytes_min = pbmin;
+		snd_card_asihpi_playback.period_bytes_max = BUFFER_BYTES_MAX / PERIODS_MIN;
+		snd_card_asihpi_playback.periods_min = PERIODS_MIN;
+		snd_card_asihpi_playback.periods_max = BUFFER_BYTES_MAX / pbmin;
+	}
+
 	/* snd_card_asihpi_playback.fifo_size = 0; */
 	snd_card_asihpi_playback.channels_max = card->out_max_chans;
 	snd_card_asihpi_playback.channels_min = card->out_min_chans;
@@ -1039,7 +1125,7 @@ static int snd_card_asihpi_playback_open(struct snd_pcm_substream *substream)
 		card->update_interval_frames);
 
 	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
-		card->update_interval_frames * 2, UINT_MAX);
+		card->update_interval_frames, UINT_MAX);
 
 	snd_printdd("playback open\n");
 
@@ -1105,8 +1191,6 @@ static int snd_card_asihpi_capture_prepare(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-
-
 static u64 snd_card_asihpi_capture_formats(struct snd_card_asihpi *asihpi,
 					u32 h_stream)
 {
@@ -1173,11 +1257,21 @@ static int snd_card_asihpi_capture_open(struct snd_pcm_substream *substream)
 	runtime->private_free = snd_card_asihpi_runtime_free;
 
 	memset(&snd_card_asihpi_capture, 0, sizeof(snd_card_asihpi_capture));
-	snd_card_asihpi_capture.buffer_bytes_max = BUFFER_BYTES_MAX;
-	snd_card_asihpi_capture.period_bytes_min = PERIOD_BYTES_MIN;
-	snd_card_asihpi_capture.period_bytes_max = BUFFER_BYTES_MAX / PERIODS_MIN;
-	snd_card_asihpi_capture.periods_min = PERIODS_MIN;
-	snd_card_asihpi_capture.periods_max = BUFFER_BYTES_MAX / PERIOD_BYTES_MIN;
+	if (!card->hpi->interrupt_mode) {
+		snd_card_asihpi_capture.buffer_bytes_max = BUFFER_BYTES_MAX;
+		snd_card_asihpi_capture.period_bytes_min = PERIOD_BYTES_MIN;
+		snd_card_asihpi_capture.period_bytes_max = BUFFER_BYTES_MAX / PERIODS_MIN;
+		snd_card_asihpi_capture.periods_min = PERIODS_MIN;
+		snd_card_asihpi_capture.periods_max = BUFFER_BYTES_MAX / PERIOD_BYTES_MIN;
+	} else {
+		size_t pbmin = card->update_interval_frames *
+			card->out_max_chans;
+		snd_card_asihpi_capture.buffer_bytes_max = BUFFER_BYTES_MAX;
+		snd_card_asihpi_capture.period_bytes_min = pbmin;
+		snd_card_asihpi_capture.period_bytes_max = BUFFER_BYTES_MAX / PERIODS_MIN;
+		snd_card_asihpi_capture.periods_min = PERIODS_MIN;
+		snd_card_asihpi_capture.periods_max = BUFFER_BYTES_MAX / pbmin;
+	}
 	/* snd_card_asihpi_capture.fifo_size = 0; */
 	snd_card_asihpi_capture.channels_max = card->in_max_chans;
 	snd_card_asihpi_capture.channels_min = card->in_min_chans;
@@ -1202,7 +1296,7 @@ static int snd_card_asihpi_capture_open(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
 		card->update_interval_frames);
 	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
-		card->update_interval_frames * 2, UINT_MAX);
+		card->update_interval_frames, UINT_MAX);
 
 	snd_pcm_set_sync(substream);
 
@@ -2447,15 +2541,19 @@ static int snd_asihpi_clkrate_get(struct snd_kcontrol *kcontrol,
 static int snd_asihpi_sampleclock_add(struct snd_card_asihpi *asihpi,
 				      struct hpi_control *hpi_ctl)
 {
-	struct snd_card *card = asihpi->card;
+	struct snd_card *card;
 	struct snd_kcontrol_new snd_control;
 
-	struct clk_cache *clkcache = &asihpi->cc;
+	struct clk_cache *clkcache;
 	u32 hSC =  hpi_ctl->h_control;
 	int has_aes_in = 0;
 	int i, j;
 	u16 source;
 
+	if (snd_BUG_ON(!asihpi))
+		return -EINVAL;
+	card = asihpi->card;
+	clkcache = &asihpi->cc;
 	snd_control.private_value = hpi_ctl->h_control;
 
 	clkcache->has_local = 0;
@@ -2811,6 +2909,7 @@ static int snd_asihpi_probe(struct pci_dev *pci_dev,
 	asihpi->card = card;
 	asihpi->pci = pci_dev;
 	asihpi->hpi = hpi;
+	hpi->snd_card = card;
 
 	snd_printk(KERN_INFO "adapter ID=%4X index=%d\n",
 			asihpi->hpi->adapter->type, adapter_index);
@@ -2833,8 +2932,16 @@ static int snd_asihpi_probe(struct pci_dev *pci_dev,
 	if (err)
 		asihpi->update_interval_frames = 512;
 
-	if (!asihpi->can_dma)
-		asihpi->update_interval_frames *= 2;
+	if (hpi->interrupt_mode) {
+		asihpi->pcm_start = snd_card_asihpi_pcm_int_start;
+		asihpi->pcm_stop = snd_card_asihpi_pcm_int_stop;
+		tasklet_init(&asihpi->t, snd_card_asihpi_int_task,
+			(unsigned long)hpi);
+		hpi->interrupt_callback = snd_card_asihpi_isr;
+	} else {
+		asihpi->pcm_start = snd_card_asihpi_pcm_timer_start;
+		asihpi->pcm_stop = snd_card_asihpi_pcm_timer_stop;
+	}
 
 	hpi_handle_error(hpi_instream_open(adapter_index,
 			     0, &h_stream));
@@ -2844,6 +2951,9 @@ static int snd_asihpi_probe(struct pci_dev *pci_dev,
 
 	hpi_handle_error(hpi_instream_close(h_stream));
 
+	if (!asihpi->can_dma)
+		asihpi->update_interval_frames *= 2;
+
 	err = hpi_adapter_get_property(adapter_index,
 		HPI_ADAPTER_PROPERTY_CURCHANNELS,
 		&asihpi->in_max_chans, &asihpi->out_max_chans);
@@ -2903,7 +3013,6 @@ static int snd_asihpi_probe(struct pci_dev *pci_dev,
 	err = snd_card_register(card);
 
 	if (!err) {
-		hpi->snd_card = card;
 		dev++;
 		return 0;
 	}
@@ -2917,6 +3026,16 @@ __nodev:
 static void snd_asihpi_remove(struct pci_dev *pci_dev)
 {
 	struct hpi_adapter *hpi = pci_get_drvdata(pci_dev);
+	struct snd_card_asihpi *asihpi = hpi->snd_card->private_data;
+
+	/* Stop interrupts */
+	if (hpi->interrupt_mode) {
+		hpi->interrupt_callback = NULL;
+		hpi_handle_error(hpi_adapter_set_property(hpi->adapter->index,
+			HPI_ADAPTER_PROPERTY_IRQ_RATE, 0, 0));
+		tasklet_kill(&asihpi->t);
+	}
+
 	snd_card_free(hpi->snd_card);
 	hpi->snd_card = NULL;
 	asihpi_adapter_remove(pci_dev);
diff --git a/sound/pci/asihpi/hpi6205.c b/sound/pci/asihpi/hpi6205.c
index 4f28738..8d5abfa 100644
--- a/sound/pci/asihpi/hpi6205.c
+++ b/sound/pci/asihpi/hpi6205.c
@@ -1,7 +1,7 @@
 /******************************************************************************
 
     AudioScience HPI driver
-    Copyright (C) 1997-2011  AudioScience Inc. <support@audioscience.com>
+    Copyright (C) 1997-2014  AudioScience Inc. <support@audioscience.com>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of version 2 of the GNU General Public License as
@@ -163,6 +163,9 @@ static u16 create_adapter_obj(struct hpi_adapter_obj *pao,
 
 static void delete_adapter_obj(struct hpi_adapter_obj *pao);
 
+static int adapter_irq_query_and_clear(struct hpi_adapter_obj *pao,
+	u32 message);
+
 static void outstream_host_buffer_allocate(struct hpi_adapter_obj *pao,
 	struct hpi_message *phm, struct hpi_response *phr);
 
@@ -283,7 +286,6 @@ static void adapter_message(struct hpi_adapter_obj *pao,
 	case HPI_ADAPTER_DELETE:
 		adapter_delete(pao, phm, phr);
 		break;
-
 	default:
 		hw_message(pao, phm, phr);
 		break;
@@ -673,6 +675,12 @@ static u16 create_adapter_obj(struct hpi_adapter_obj *pao,
 
 	HPI_DEBUG_LOG(INFO, "bootload DSP OK\n");
 
+	pao->irq_query_and_clear = adapter_irq_query_and_clear;
+	pao->instream_host_buffer_status =
+		phw->p_interface_buffer->instream_host_buffer_status;
+	pao->outstream_host_buffer_status =
+		phw->p_interface_buffer->outstream_host_buffer_status;
+
 	return hpi_add_adapter(pao);
 }
 
@@ -713,6 +721,21 @@ static void delete_adapter_obj(struct hpi_adapter_obj *pao)
 
 /*****************************************************************************/
 /* Adapter functions */
+static int adapter_irq_query_and_clear(struct hpi_adapter_obj *pao,
+	u32 message)
+{
+	struct hpi_hw_obj *phw = pao->priv;
+	u32 hsr = 0;
+
+	hsr = ioread32(phw->prHSR);
+	if (hsr & C6205_HSR_INTSRC) {
+		/* reset the interrupt from the DSP */
+		iowrite32(C6205_HSR_INTSRC, phw->prHSR);
+		return HPI_IRQ_MIXER;
+	}
+
+	return HPI_IRQ_NONE;
+}
 
 /*****************************************************************************/
 /* OutStream Host buffer functions */
@@ -1331,17 +1354,21 @@ static u16 adapter_boot_load_dsp(struct hpi_adapter_obj *pao,
 	if (boot_code_id[1] != 0) {
 		/* DSP 1 is a C6713 */
 		/* CLKX0 <- '1' release the C6205 bootmode pulldowns */
-		boot_loader_write_mem32(pao, 0, (0x018C0024L), 0x00002202);
+		boot_loader_write_mem32(pao, 0, 0x018C0024, 0x00002202);
 		hpios_delay_micro_seconds(100);
 		/* Reset the 6713 #1 - revB */
 		boot_loader_write_mem32(pao, 0, C6205_BAR0_TIMER1_CTL, 0);
-
-		/* dummy read every 4 words for 6205 advisory 1.4.4 */
-		boot_loader_read_mem32(pao, 0, 0);
-
+		/* value of bit 3 is unknown after DSP reset, other bits shoudl be 0 */
+		if (0 != (boot_loader_read_mem32(pao, 0,
+					(C6205_BAR0_TIMER1_CTL)) & ~8))
+			return HPI6205_ERROR_6205_REG;
 		hpios_delay_micro_seconds(100);
+
 		/* Release C6713 from reset - revB */
 		boot_loader_write_mem32(pao, 0, C6205_BAR0_TIMER1_CTL, 4);
+		if (4 != (boot_loader_read_mem32(pao, 0,
+					(C6205_BAR0_TIMER1_CTL)) & ~8))
+			return HPI6205_ERROR_6205_REG;
 		hpios_delay_micro_seconds(100);
 	}
 
@@ -2089,7 +2116,7 @@ static u16 message_response_sequence(struct hpi_adapter_obj *pao,
 		return 0;
 	}
 
-	/* Assume buffer of type struct bus_master_interface
+	/* Assume buffer of type struct bus_master_interface_62
 	   is allocated "noncacheable" */
 
 	if (!wait_dsp_ack(phw, H620_HIF_IDLE, HPI6205_TIMEOUT)) {
diff --git a/sound/pci/asihpi/hpi_internal.h b/sound/pci/asihpi/hpi_internal.h
index c9bdc28..48380ce 100644
--- a/sound/pci/asihpi/hpi_internal.h
+++ b/sound/pci/asihpi/hpi_internal.h
@@ -686,8 +686,8 @@ union hpi_adapterx_msg {
 		u16 value;
 	} test_assert;
 	struct {
-		u32 yes;
-	} irq_query;
+		u32 message;
+	} irq;
 	u32 pad[3];
 };
 
diff --git a/sound/pci/asihpi/hpicmn.h b/sound/pci/asihpi/hpicmn.h
index e441212..46629c2 100644
--- a/sound/pci/asihpi/hpicmn.h
+++ b/sound/pci/asihpi/hpicmn.h
@@ -1,7 +1,7 @@
 /**
 
     AudioScience HPI driver
-    Copyright (C) 1997-2011  AudioScience Inc. <support@audioscience.com>
+    Copyright (C) 1997-2014  AudioScience Inc. <support@audioscience.com>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of version 2 of the GNU General Public License as
@@ -21,7 +21,11 @@
 struct hpi_adapter_obj;
 
 /* a function that takes an adapter obj and returns an int */
-typedef int adapter_int_func(struct hpi_adapter_obj *pao);
+typedef int adapter_int_func(struct hpi_adapter_obj *pao, u32 message);
+
+#define HPI_IRQ_NONE		(0)
+#define HPI_IRQ_MESSAGE		(1)
+#define HPI_IRQ_MIXER		(2)
 
 struct hpi_adapter_obj {
 	struct hpi_pci pci;	/* PCI info - bus#,dev#,address etc */
@@ -33,6 +37,9 @@ struct hpi_adapter_obj {
 	u16 dsp_crashed;
 	u16 has_control_cache;
 	void *priv;
+	adapter_int_func *irq_query_and_clear;
+	struct hpi_hostbuffer_status *instream_host_buffer_status;
+	struct hpi_hostbuffer_status *outstream_host_buffer_status;
 };
 
 struct hpi_control_cache {
@@ -55,13 +62,21 @@ void hpi_delete_adapter(struct hpi_adapter_obj *pao);
 
 short hpi_check_control_cache(struct hpi_control_cache *pC,
 	struct hpi_message *phm, struct hpi_response *phr);
+
+short hpi_check_control_cache_single(struct hpi_control_cache_single *pC,
+	struct hpi_message *phm, struct hpi_response *phr);
+
 struct hpi_control_cache *hpi_alloc_control_cache(const u32
 	number_of_controls, const u32 size_in_bytes, u8 *pDSP_control_buffer);
+
 void hpi_free_control_cache(struct hpi_control_cache *p_cache);
 
 void hpi_cmn_control_cache_sync_to_msg(struct hpi_control_cache *pC,
 	struct hpi_message *phm, struct hpi_response *phr);
 
+void hpi_cmn_control_cache_sync_to_msg_single(struct hpi_control_cache_single
+	*pC, struct hpi_message *phm, struct hpi_response *phr);
+
 u16 hpi_validate_response(struct hpi_message *phm, struct hpi_response *phr);
 
 hpi_handler_func HPI_COMMON;
diff --git a/sound/pci/asihpi/hpioctl.c b/sound/pci/asihpi/hpioctl.c
index 7f02720..9454932 100644
--- a/sound/pci/asihpi/hpioctl.c
+++ b/sound/pci/asihpi/hpioctl.c
@@ -1,7 +1,8 @@
 /*******************************************************************************
-
     AudioScience HPI driver
-    Copyright (C) 1997-2011  AudioScience Inc. <support@audioscience.com>
+    Common Linux HPI ioctl and module probe/remove functions
+
+    Copyright (C) 1997-2014  AudioScience Inc. <support@audioscience.com>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of version 2 of the GNU General Public License as
@@ -12,11 +13,6 @@
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
 
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-
-Common Linux HPI ioctl and module probe/remove functions
 *******************************************************************************/
 #define SOURCEFILE_NAME "hpioctl.c"
 
@@ -29,6 +25,7 @@ Common Linux HPI ioctl and module probe/remove functions
 #include "hpicmn.h"
 
 #include <linux/fs.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/moduleparam.h>
 #include <asm/uaccess.h>
@@ -307,10 +304,38 @@ out:
 	return err;
 }
 
+static int asihpi_irq_count;
+
+static irqreturn_t asihpi_isr(int irq, void *dev_id)
+{
+	struct hpi_adapter *a = dev_id;
+	int handled;
+
+	if (!a->adapter->irq_query_and_clear) {
+		pr_err("asihpi_isr ASI%04X:%d no handler\n", a->adapter->type,
+			a->adapter->index);
+		return IRQ_NONE;
+	}
+
+	handled = a->adapter->irq_query_and_clear(a->adapter, 0);
+
+	if (!handled)
+		return IRQ_NONE;
+
+	asihpi_irq_count++;
+	/* printk(KERN_INFO "asihpi_isr %d ASI%04X:%d irq handled\n",
+	   asihpi_irq_count, a->adapter->type, a->adapter->index); */
+
+	if (a->interrupt_callback)
+		a->interrupt_callback(a);
+
+	return IRQ_HANDLED;
+}
+
 int asihpi_adapter_probe(struct pci_dev *pci_dev,
 			 const struct pci_device_id *pci_id)
 {
-	int idx, nm;
+	int idx, nm, low_latency_mode = 0, irq_supported = 0;
 	int adapter_index;
 	unsigned int memlen;
 	struct hpi_message hm;
@@ -388,8 +413,39 @@ int asihpi_adapter_probe(struct pci_dev *pci_dev,
 	hm.adapter_index = adapter.adapter->index;
 	hpi_send_recv_ex(&hm, &hr, HOWNER_KERNEL);
 
-	if (hr.error)
+	if (hr.error) {
+		HPI_DEBUG_LOG(ERROR, "HPI_ADAPTER_OPEN failed, aborting\n");
+		goto err;
+	}
+
+	/* Check if current mode == Low Latency mode */
+	hpi_init_message_response(&hm, &hr, HPI_OBJ_ADAPTER,
+		HPI_ADAPTER_GET_MODE);
+	hm.adapter_index = adapter.adapter->index;
+	hpi_send_recv_ex(&hm, &hr, HOWNER_KERNEL);
+
+	if (hr.error) {
+		HPI_DEBUG_LOG(ERROR,
+			"HPI_ADAPTER_GET_MODE failed, aborting\n");
 		goto err;
+	}
+
+	if (hr.u.ax.mode.adapter_mode == HPI_ADAPTER_MODE_LOW_LATENCY)
+		low_latency_mode = 1;
+
+	/* Check if IRQs are supported */
+	hpi_init_message_response(&hm, &hr, HPI_OBJ_ADAPTER,
+		HPI_ADAPTER_GET_PROPERTY);
+	hm.adapter_index = adapter.adapter->index;
+	hm.u.ax.property_set.property = HPI_ADAPTER_PROPERTY_SUPPORTS_IRQ;
+	hpi_send_recv_ex(&hm, &hr, HOWNER_KERNEL);
+	if (hr.error || !hr.u.ax.property_get.parameter1) {
+		dev_info(&pci_dev->dev,
+			"IRQs not supported by adapter at index %d\n",
+			adapter.adapter->index);
+	} else {
+		irq_supported = 1;
+	}
 
 	/* WARNING can't init mutex in 'adapter'
 	 * and then copy it to adapters[] ?!?!
@@ -398,6 +454,44 @@ int asihpi_adapter_probe(struct pci_dev *pci_dev,
 	mutex_init(&adapters[adapter_index].mutex);
 	pci_set_drvdata(pci_dev, &adapters[adapter_index]);
 
+	if (low_latency_mode && irq_supported) {
+		if (!adapter.adapter->irq_query_and_clear) {
+			dev_err(&pci_dev->dev,
+				"no IRQ handler for adapter %d, aborting\n",
+				adapter.adapter->index);
+			goto err;
+		}
+
+		/* Disable IRQ generation on DSP side by setting the rate to 0 */
+		hpi_init_message_response(&hm, &hr, HPI_OBJ_ADAPTER,
+			HPI_ADAPTER_SET_PROPERTY);
+		hm.adapter_index = adapter.adapter->index;
+		hm.u.ax.property_set.property = HPI_ADAPTER_PROPERTY_IRQ_RATE;
+		hm.u.ax.property_set.parameter1 = 0;
+		hm.u.ax.property_set.parameter2 = 0;
+		hpi_send_recv_ex(&hm, &hr, HOWNER_KERNEL);
+		if (hr.error) {
+			HPI_DEBUG_LOG(ERROR,
+				"HPI_ADAPTER_GET_MODE failed, aborting\n");
+			goto err;
+		}
+
+		/* Note: request_irq calls asihpi_isr here */
+		if (request_irq(pci_dev->irq, asihpi_isr, IRQF_SHARED,
+				"asihpi", &adapters[adapter_index])) {
+			dev_err(&pci_dev->dev, "request_irq(%d) failed\n",
+				pci_dev->irq);
+			goto err;
+		}
+
+		adapters[adapter_index].interrupt_mode = 1;
+
+		dev_info(&pci_dev->dev, "using irq %d\n", pci_dev->irq);
+		adapters[adapter_index].irq = pci_dev->irq;
+	} else {
+		dev_info(&pci_dev->dev, "using polled mode\n");
+	}
+
 	dev_info(&pci_dev->dev, "probe succeeded for ASI%04X HPI index %d\n",
 		 adapter.adapter->type, adapter_index);
 
@@ -431,6 +525,15 @@ void asihpi_adapter_remove(struct pci_dev *pci_dev)
 	pa = pci_get_drvdata(pci_dev);
 	pci = pa->adapter->pci;
 
+	/* Disable IRQ generation on DSP side */
+	hpi_init_message_response(&hm, &hr, HPI_OBJ_ADAPTER,
+		HPI_ADAPTER_SET_PROPERTY);
+	hm.adapter_index = pa->adapter->index;
+	hm.u.ax.property_set.property = HPI_ADAPTER_PROPERTY_IRQ_RATE;
+	hm.u.ax.property_set.parameter1 = 0;
+	hm.u.ax.property_set.parameter2 = 0;
+	hpi_send_recv_ex(&hm, &hr, HOWNER_KERNEL);
+
 	hpi_init_message_response(&hm, &hr, HPI_OBJ_ADAPTER,
 		HPI_ADAPTER_DELETE);
 	hm.adapter_index = pa->adapter->index;
@@ -442,6 +545,9 @@ void asihpi_adapter_remove(struct pci_dev *pci_dev)
 			iounmap(pci.ap_mem_base[idx]);
 	}
 
+	if (pa->irq)
+		free_irq(pa->irq, pa);
+
 	if (pa->p_buffer)
 		vfree(pa->p_buffer);
 
diff --git a/sound/pci/asihpi/hpios.h b/sound/pci/asihpi/hpios.h
index d17d017..4e38360 100644
--- a/sound/pci/asihpi/hpios.h
+++ b/sound/pci/asihpi/hpios.h
@@ -151,6 +151,10 @@ struct hpi_adapter {
 	struct hpi_adapter_obj *adapter;
 	struct snd_card *snd_card;
 
+	int irq;
+	int interrupt_mode;
+	void (*interrupt_callback) (struct hpi_adapter *);
+
 	/* mutex prevents contention for one card
 	   between multiple user programs (via ioctl) */
 	struct mutex mutex;
-- 
1.9.1
