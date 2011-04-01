From: linux@audioscience.com
Subject: [snd-asihpi 4/8] Allow older non DMA capable cards to
 use MMAP. Emulate the DMA using read and write functions,
 get rid of copy & silence callbacks that were used only by older cards.
Date: Fri, 01 Apr 2011 15:59:48 +1300
Message-ID: <1301626792-13705-5-git-send-email-linux@audioscience.com>
References: <1301626792-13705-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1301626792-13705-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/asihpi.c |  205 +++++++++++++++++---------------------------------
 1 files changed, 70 insertions(+), 135 deletions(-)

diff --git a/pci/asihpi/asihpi.c b/pci/asihpi/asihpi.c
index a5226e3..d5258aa 100644
--- a/pci/asihpi/asihpi.c
+++ b/pci/asihpi/asihpi.c
@@ -42,6 +42,7 @@
 #include <sound/tlv.h>
 #include <sound/hwdep.h>
 
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("AudioScience inc. <support@audioscience.com>");
 MODULE_DESCRIPTION("AudioScience ALSA ASI5000 ASI6000 ASI87xx ASI89xx");
@@ -146,7 +147,7 @@ struct snd_card_asihpi {
 	u32 h_mixer;
 	struct clk_cache cc;
 
-	u16 support_mmap;
+	u16 can_dma;
 	u16 support_grouping;
 	u16 support_mrx;
 	u16 update_interval_frames;
@@ -491,8 +492,7 @@ static int snd_card_asihpi_pcm_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	dpcm->hpi_buffer_attached = 0;
-	if (card->support_mmap) {
-
+	if (card->can_dma) {
 		err = hpi_stream_host_buffer_attach(dpcm->h_stream,
 			params_buffer_bytes(params),  runtime->dma_addr);
 		if (err == 0) {
@@ -594,8 +594,7 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 				continue;
 
 			ds->drained_count = 0;
-			if ((s->stream == SNDRV_PCM_STREAM_PLAYBACK) &&
-				(card->support_mmap)) {
+			if (s->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 				/* How do I know how much valid data is present
 				* in buffer? Must be at least one period!
 				* Guessing 2 periods, but if
@@ -630,7 +629,7 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 		/* start the master stream */
 		snd_card_asihpi_pcm_timer_start(substream);
 		if ((substream->stream == SNDRV_PCM_STREAM_CAPTURE) ||
-			!card->support_mmap)
+			!card->can_dma)
 			hpi_handle_error(hpi_stream_start(dpcm->h_stream));
 		break;
 
@@ -766,6 +765,9 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 		/* number of bytes in on-card buffer */
 		runtime->delay = on_card_bytes;
 
+		if (!card->can_dma)
+			on_card_bytes = bytes_avail;
+
 		if (s->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			pcm_buf_dma_ofs = ds->pcm_buf_host_rw_ofs - bytes_avail;
 			if (state == HPI_STATE_STOPPED) {
@@ -844,30 +846,63 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 
 		ds->pcm_buf_dma_ofs = pcm_buf_dma_ofs;
 
-		if (xfercount && (on_card_bytes <= ds->period_bytes)) {
-			if (card->support_mmap) {
-				if (s->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-					snd_printddd("P%d write x%04x\n",
+		if (xfercount &&
+			/* Limit use of on card fifo for playback */
+			((on_card_bytes <= ds->period_bytes) ||
+			(s->stream == SNDRV_PCM_STREAM_CAPTURE)))
+
+		{
+
+			unsigned int buf_ofs = ds->pcm_buf_host_rw_ofs % ds->buffer_bytes;
+			unsigned int xfer1, xfer2;
+			char *pd = &s->runtime->dma_area[buf_ofs];
+
+			if (card->can_dma) {
+				xfer1 = xfercount;
+				xfer2 = 0;
+			} else {
+				xfer1 = min(xfercount, ds->buffer_bytes - buf_ofs);
+				xfer2 = xfercount - xfer1;
+			}
+
+			if (s->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+				snd_printddd("P%d write1 0x%04X 0x%04X\n",
+					s->number, xfer1, buf_ofs);
+				hpi_handle_error(
+					hpi_outstream_write_buf(
+						ds->h_stream, pd, xfer1,
+						&ds->format));
+
+				if (xfer2) {
+					pd = s->runtime->dma_area;
+
+					snd_printddd("P%d write2 0x%04X 0x%04X\n",
 							s->number,
-							ds->period_bytes);
+							xfercount - xfer1, buf_ofs);
 					hpi_handle_error(
 						hpi_outstream_write_buf(
-							ds->h_stream,
-							&s->runtime->
-								dma_area[0],
-							xfercount,
+							ds->h_stream, pd,
+							xfercount - xfer1,
 							&ds->format));
-				} else {
-					snd_printddd("C%d read x%04x\n",
-						s->number,
-						xfercount);
+				}
+			} else {
+				snd_printddd("C%d read1 0x%04x\n",
+					s->number, xfer1);
+				hpi_handle_error(
+					hpi_instream_read_buf(
+						ds->h_stream,
+						pd, xfer1));
+				if (xfer2) {
+					pd = s->runtime->dma_area;
+					snd_printddd("C%d read2 0x%04x\n",
+						s->number, xfer2);
 					hpi_handle_error(
 						hpi_instream_read_buf(
 							ds->h_stream,
-							NULL, xfercount));
+							pd, xfer2));
 				}
-				ds->pcm_buf_host_rw_ofs = ds->pcm_buf_host_rw_ofs + xfercount;
-			} /* else R/W will be handled by read/write callbacks */
+			}
+			ds->pcm_buf_host_rw_ofs = ds->pcm_buf_host_rw_ofs + xfercount;
 			ds->pcm_buf_elapsed_dma_ofs = pcm_buf_dma_ofs;
 			snd_pcm_period_elapsed(s);
 		}
@@ -1004,11 +1039,9 @@ static int snd_card_asihpi_playback_open(struct snd_pcm_substream *substream)
 					SNDRV_PCM_INFO_DOUBLE |
 					SNDRV_PCM_INFO_BATCH |
 					SNDRV_PCM_INFO_BLOCK_TRANSFER |
-					SNDRV_PCM_INFO_PAUSE;
-
-	if (card->support_mmap)
-		snd_card_asihpi_playback.info |= SNDRV_PCM_INFO_MMAP |
-						SNDRV_PCM_INFO_MMAP_VALID;
+					SNDRV_PCM_INFO_PAUSE |
+					SNDRV_PCM_INFO_MMAP |
+					SNDRV_PCM_INFO_MMAP_VALID;
 
 	if (card->support_grouping)
 		snd_card_asihpi_playback.info |= SNDRV_PCM_INFO_SYNC_START;
@@ -1016,7 +1049,7 @@ static int snd_card_asihpi_playback_open(struct snd_pcm_substream *substream)
 	/* struct is copied, so can create initializer dynamically */
 	runtime->hw = snd_card_asihpi_playback;
 
-	if (card->support_mmap)
+	if (card->can_dma)
 		err = snd_pcm_hw_constraint_pow2(runtime, 0,
 					SNDRV_PCM_HW_PARAM_BUFFER_BYTES);
 	if (err < 0)
@@ -1046,58 +1079,6 @@ static int snd_card_asihpi_playback_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int snd_card_asihpi_playback_copy(struct snd_pcm_substream *substream,
-					int channel,
-					snd_pcm_uframes_t pos,
-					void __user *src,
-					snd_pcm_uframes_t count)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
-	unsigned int len;
-
-	len = frames_to_bytes(runtime, count);
-
-	if (copy_from_user(runtime->dma_area, src, len))
-		return -EFAULT;
-
-	snd_printddd("playback copy%d %u bytes\n",
-			substream->number, len);
-
-	hpi_handle_error(hpi_outstream_write_buf(dpcm->h_stream,
-				runtime->dma_area, len, &dpcm->format));
-
-	dpcm->pcm_buf_host_rw_ofs += len;
-
-	return 0;
-}
-
-static int snd_card_asihpi_playback_silence(struct snd_pcm_substream *
-					    substream, int channel,
-					    snd_pcm_uframes_t pos,
-					    snd_pcm_uframes_t count)
-{
-	/* Usually writes silence to DMA buffer, which should be overwritten
-	by real audio later.  Our fifos cannot be overwritten, and are not
-	free-running DMAs. Silence is output on fifo underflow.
-	This callback is still required to allow the copy callback to be used.
-	*/
-	return 0;
-}
-
-static struct snd_pcm_ops snd_card_asihpi_playback_ops = {
-	.open = snd_card_asihpi_playback_open,
-	.close = snd_card_asihpi_playback_close,
-	.ioctl = snd_card_asihpi_playback_ioctl,
-	.hw_params = snd_card_asihpi_pcm_hw_params,
-	.hw_free = snd_card_asihpi_hw_free,
-	.prepare = snd_card_asihpi_playback_prepare,
-	.trigger = snd_card_asihpi_trigger,
-	.pointer = snd_card_asihpi_playback_pointer,
-	.copy = snd_card_asihpi_playback_copy,
-	.silence = snd_card_asihpi_playback_silence,
-};
-
 static struct snd_pcm_ops snd_card_asihpi_playback_mmap_ops = {
 	.open = snd_card_asihpi_playback_open,
 	.close = snd_card_asihpi_playback_close,
@@ -1229,18 +1210,16 @@ static int snd_card_asihpi_capture_open(struct snd_pcm_substream *substream)
 	snd_card_asihpi_capture_format(card, dpcm->h_stream,
 				       &snd_card_asihpi_capture);
 	snd_card_asihpi_pcm_samplerates(card,  &snd_card_asihpi_capture);
-	snd_card_asihpi_capture.info = SNDRV_PCM_INFO_INTERLEAVED;
-
-	if (card->support_mmap)
-		snd_card_asihpi_capture.info |= SNDRV_PCM_INFO_MMAP |
-						SNDRV_PCM_INFO_MMAP_VALID;
+	snd_card_asihpi_capture.info = SNDRV_PCM_INFO_INTERLEAVED |
+					SNDRV_PCM_INFO_MMAP |
+					SNDRV_PCM_INFO_MMAP_VALID;
 
 	if (card->support_grouping)
 		snd_card_asihpi_capture.info |= SNDRV_PCM_INFO_SYNC_START;
 
 	runtime->hw = snd_card_asihpi_capture;
 
-	if (card->support_mmap)
+	if (card->can_dma)
 		err = snd_pcm_hw_constraint_pow2(runtime, 0,
 					SNDRV_PCM_HW_PARAM_BUFFER_BYTES);
 	if (err < 0)
@@ -1264,28 +1243,6 @@ static int snd_card_asihpi_capture_close(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static int snd_card_asihpi_capture_copy(struct snd_pcm_substream *substream,
-				int channel, snd_pcm_uframes_t pos,
-				void __user *dst, snd_pcm_uframes_t count)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
-	u32 len;
-
-	len = frames_to_bytes(runtime, count);
-
-	snd_printddd("capture copy%d %d bytes\n", substream->number, len);
-	hpi_handle_error(hpi_instream_read_buf(dpcm->h_stream,
-				runtime->dma_area, len));
-
-	dpcm->pcm_buf_host_rw_ofs = dpcm->pcm_buf_host_rw_ofs + len;
-
-	if (copy_to_user(dst, runtime->dma_area, len))
-		return -EFAULT;
-
-	return 0;
-}
-
 static struct snd_pcm_ops snd_card_asihpi_capture_mmap_ops = {
 	.open = snd_card_asihpi_capture_open,
 	.close = snd_card_asihpi_capture_close,
@@ -1297,18 +1254,6 @@ static struct snd_pcm_ops snd_card_asihpi_capture_mmap_ops = {
 	.pointer = snd_card_asihpi_capture_pointer,
 };
 
-static struct snd_pcm_ops snd_card_asihpi_capture_ops = {
-	.open = snd_card_asihpi_capture_open,
-	.close = snd_card_asihpi_capture_close,
-	.ioctl = snd_card_asihpi_capture_ioctl,
-	.hw_params = snd_card_asihpi_pcm_hw_params,
-	.hw_free = snd_card_asihpi_hw_free,
-	.prepare = snd_card_asihpi_capture_prepare,
-	.trigger = snd_card_asihpi_trigger,
-	.pointer = snd_card_asihpi_capture_pointer,
-	.copy = snd_card_asihpi_capture_copy
-};
-
 static int __devinit snd_card_asihpi_pcm_new(struct snd_card_asihpi *asihpi,
 				      int device, int substreams)
 {
@@ -1321,17 +1266,10 @@ static int __devinit snd_card_asihpi_pcm_new(struct snd_card_asihpi *asihpi,
 	if (err < 0)
 		return err;
 	/* pointer to ops struct is stored, dont change ops afterwards! */
-	if (asihpi->support_mmap) {
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
 				&snd_card_asihpi_playback_mmap_ops);
 		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
 				&snd_card_asihpi_capture_mmap_ops);
-	} else {
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
-				&snd_card_asihpi_playback_ops);
-		snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE,
-				&snd_card_asihpi_capture_ops);
-	}
 
 	pcm->private_data = asihpi;
 	pcm->info_flags = 0;
@@ -2895,14 +2833,14 @@ static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 	if (err)
 		asihpi->update_interval_frames = 512;
 
-	if (!asihpi->support_mmap)
+	if (!asihpi->can_dma)
 		asihpi->update_interval_frames *= 2;
 
 	hpi_handle_error(hpi_instream_open(asihpi->adapter_index,
 			     0, &h_stream));
 
 	err = hpi_instream_host_buffer_free(h_stream);
-	asihpi->support_mmap = (!err);
+	asihpi->can_dma = (!err);
 
 	hpi_handle_error(hpi_instream_close(h_stream));
 
@@ -2914,8 +2852,8 @@ static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 		asihpi->out_max_chans = 2;
 	}
 
-	snd_printk(KERN_INFO "supports mmap:%d grouping:%d mrx:%d\n",
-			asihpi->support_mmap,
+	snd_printk(KERN_INFO "has dma:%d, grouping:%d, mrx:%d\n",
+			asihpi->can_dma,
 			asihpi->support_grouping,
 			asihpi->support_mrx
 	      );
@@ -2945,10 +2883,7 @@ static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 	    by enable_hwdep  module param*/
 	snd_asihpi_hpi_new(asihpi, 0, NULL);
 
-	if (asihpi->support_mmap)
-		strcpy(card->driver, "ASIHPI-MMAP");
-	else
-		strcpy(card->driver, "ASIHPI");
+	strcpy(card->driver, "ASIHPI");
 
 	sprintf(card->shortname, "AudioScience ASI%4X", asihpi->type);
 	sprintf(card->longname, "%s %i",
-- 
1.7.0.4
