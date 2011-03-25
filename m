From: linux@audioscience.com
Subject: [PATCH 3/3] Update verbose debug print macros.
Date: Fri, 25 Mar 2011 15:25:48 +1300
Message-ID: <1301019948-3539-3-git-send-email-linux@audioscience.com>
References: <1301019948-3539-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1301019948-3539-1-git-send-email-linux@audioscience.com>
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

Replace local VPRINTK1 with snd_printdd.
Create local snd_printddd instead of VPRINTK2 for most verbose debug.
In most cases let snd_printk supply default level for messages.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/asihpi.c |  100 ++++++++++++++++++++++++---------------------------
 1 files changed, 47 insertions(+), 53 deletions(-)

diff --git a/pci/asihpi/asihpi.c b/pci/asihpi/asihpi.c
index c90d77a..f53a31e 100644
--- a/pci/asihpi/asihpi.c
+++ b/pci/asihpi/asihpi.c
@@ -22,21 +22,6 @@
  *  for any purpose including commercial applications.
  */
 
-/* >0: print Hw params, timer vars. >1: print stream write/copy sizes  */
-#define REALLY_VERBOSE_LOGGING 0
-
-#if REALLY_VERBOSE_LOGGING
-#define VPRINTK1 snd_printd
-#else
-#define VPRINTK1(...)
-#endif
-
-#if REALLY_VERBOSE_LOGGING > 1
-#define VPRINTK2 snd_printd
-#else
-#define VPRINTK2(...)
-#endif
-
 #include "hpi_internal.h"
 #include "hpimsginit.h"
 #include "hpioctl.h"
@@ -57,11 +42,25 @@
 #include <sound/tlv.h>
 #include <sound/hwdep.h>
 
-
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("AudioScience inc. <support@audioscience.com>");
 MODULE_DESCRIPTION("AudioScience ALSA ASI5000 ASI6000 ASI87xx ASI89xx");
 
+#if defined CONFIG_SND_DEBUG_VERBOSE
+/**
+ * snd_printddd - very verbose debug printk
+ * @format: format string
+ *
+ * Works like snd_printk() for debugging purposes.
+ * Ignored when CONFIG_SND_DEBUG_VERBOSE is not set.
+ * Must set snd module debug parameter to 3 to enable at runtime.
+ */
+#define snd_printddd(format, args...) \
+	__snd_printk(3, __FILE__, __LINE__, format, ##args)
+#else
+#define snd_printddd(format, args...)	do { } while (0)
+#endif
+
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;
@@ -289,7 +288,6 @@ static u16 handle_error(u16 err, int line, char *filename)
 #define hpi_handle_error(x)  handle_error(x, __LINE__, __FILE__)
 
 /***************************** GENERAL PCM ****************/
-#if REALLY_VERBOSE_LOGGING
 static void print_hwparams(struct snd_pcm_hw_params *p)
 {
 	snd_printd("HWPARAMS \n");
@@ -304,9 +302,6 @@ static void print_hwparams(struct snd_pcm_hw_params *p)
 	snd_printd("periods %d \n", params_periods(p));
 	snd_printd("buffer_size %d \n", params_buffer_size(p));
 }
-#else
-#define print_hwparams(x)
-#endif
 
 static snd_pcm_format_t hpi_to_alsa_formats[] = {
 	-1,			/* INVALID */
@@ -464,7 +459,7 @@ static int snd_card_asihpi_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (err)
 		return err;
 
-	VPRINTK1(KERN_INFO "format %d, %d chans, %d_hz\n",
+	snd_printdd("format %d, %d chans, %d_hz\n",
 				format, params_channels(params),
 				params_rate(params));
 
@@ -487,13 +482,12 @@ static int snd_card_asihpi_pcm_hw_params(struct snd_pcm_substream *substream,
 		err = hpi_stream_host_buffer_attach(dpcm->h_stream,
 			params_buffer_bytes(params),  runtime->dma_addr);
 		if (err == 0) {
-			VPRINTK1(KERN_INFO
+			snd_printdd(
 				"stream_host_buffer_attach succeeded %u %lu\n",
 				params_buffer_bytes(params),
 				(unsigned long)runtime->dma_addr);
 		} else {
-			snd_printd(KERN_INFO
-					"stream_host_buffer_attach error %d\n",
+			snd_printd("stream_host_buffer_attach error %d\n",
 					err);
 			return -ENOMEM;
 		}
@@ -502,7 +496,7 @@ static int snd_card_asihpi_pcm_hw_params(struct snd_pcm_substream *substream,
 						&dpcm->hpi_buffer_attached,
 						NULL, NULL, NULL);
 
-		VPRINTK1(KERN_INFO "stream_host_buffer_attach status 0x%x\n",
+		snd_printdd("stream_host_buffer_attach status 0x%x\n",
 				dpcm->hpi_buffer_attached);
 	}
 	bytes_per_sec = params_rate(params) * params_channels(params);
@@ -515,7 +509,7 @@ static int snd_card_asihpi_pcm_hw_params(struct snd_pcm_substream *substream,
 	dpcm->bytes_per_sec = bytes_per_sec;
 	dpcm->buffer_bytes = params_buffer_bytes(params);
 	dpcm->period_bytes = params_period_bytes(params);
-	VPRINTK1(KERN_INFO "buffer_bytes=%d, period_bytes=%d, bps=%d\n",
+	snd_printdd("buffer_bytes=%d, period_bytes=%d, bps=%d\n",
 			dpcm->buffer_bytes, dpcm->period_bytes, bytes_per_sec);
 
 	return 0;
@@ -571,7 +565,7 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 	struct snd_pcm_substream *s;
 	u16 e;
 
-	VPRINTK1(KERN_INFO "%c%d trigger\n",
+	snd_printdd("%c%d trigger\n",
 			SCHR(substream->stream), substream->number);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -595,7 +589,7 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 				* data??
 				*/
 				unsigned int preload = ds->period_bytes * 1;
-				VPRINTK2(KERN_INFO "%d preload x%x\n", s->number, preload);
+				snd_printddd("%d preload x%x\n", s->number, preload);
 				hpi_handle_error(hpi_outstream_write_buf(
 						ds->h_stream,
 						&runtime->dma_area[0],
@@ -605,7 +599,7 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 			}
 
 			if (card->support_grouping) {
-				VPRINTK1(KERN_INFO "\t%c%d group\n",
+				snd_printdd("\t%c%d group\n",
 						SCHR(s->stream),
 						s->number);
 				e = hpi_stream_group_add(
@@ -620,7 +614,7 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 			} else
 				break;
 		}
-		VPRINTK1(KERN_INFO "start\n");
+		snd_printdd("start\n");
 		/* start the master stream */
 		snd_card_asihpi_pcm_timer_start(substream);
 		if ((substream->stream == SNDRV_PCM_STREAM_CAPTURE) ||
@@ -642,14 +636,14 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 			s->runtime->status->state = SNDRV_PCM_STATE_SETUP;
 
 			if (card->support_grouping) {
-				VPRINTK1(KERN_INFO "\t%c%d group\n",
+				snd_printdd("\t%c%d group\n",
 				SCHR(s->stream),
 					s->number);
 				snd_pcm_trigger_done(s, substream);
 			} else
 				break;
 		}
-		VPRINTK1(KERN_INFO "stop\n");
+		snd_printdd("stop\n");
 
 		/* _prepare and _hwparams reset the stream */
 		hpi_handle_error(hpi_stream_stop(dpcm->h_stream));
@@ -662,12 +656,12 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 		break;
 
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		VPRINTK1(KERN_INFO "pause release\n");
+		snd_printdd("pause release\n");
 		hpi_handle_error(hpi_stream_start(dpcm->h_stream));
 		snd_card_asihpi_pcm_timer_start(substream);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		VPRINTK1(KERN_INFO "pause\n");
+		snd_printdd("pause\n");
 		snd_card_asihpi_pcm_timer_stop(substream);
 		hpi_handle_error(hpi_stream_stop(dpcm->h_stream));
 		break;
@@ -739,7 +733,7 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 	u16 state;
 	u32 buffer_size, bytes_avail, samples_played, on_card_bytes;
 
-	VPRINTK1(KERN_INFO "%c%d snd_card_asihpi_timer_function\n",
+	snd_printdd("%c%d snd_card_asihpi_timer_function\n",
 				SCHR(substream->stream), substream->number);
 
 	/* find minimum newdata and buffer pos in group */
@@ -768,10 +762,10 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 				if ((bytes_avail == 0) &&
 				    (on_card_bytes < ds->pcm_buf_host_rw_ofs)) {
 					hpi_handle_error(hpi_stream_start(ds->h_stream));
-					VPRINTK1(KERN_INFO "P%d start\n", s->number);
+					snd_printdd("P%d start\n", s->number);
 				}
 			} else if (state == HPI_STATE_DRAINED) {
-				VPRINTK1(KERN_WARNING "P%d drained\n",
+				snd_printd(KERN_WARNING "P%d drained\n",
 						s->number);
 				/*snd_pcm_stop(s, SNDRV_PCM_STATE_XRUN);
 				continue; */
@@ -792,13 +786,13 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 				newdata);
 		}
 
-		VPRINTK1(KERN_INFO "PB timer hw_ptr x%04lX, appl_ptr x%04lX\n",
+		snd_printdd("hw_ptr x%04lX, appl_ptr x%04lX\n",
 			(unsigned long)frames_to_bytes(runtime,
 						runtime->status->hw_ptr),
 			(unsigned long)frames_to_bytes(runtime,
 						runtime->control->appl_ptr));
 
-		VPRINTK1(KERN_INFO "%d %c%d S=%d, rw=%04X, dma=x%04X, left=x%04X,"
+		snd_printdd("%d %c%d S=%d, rw=%04X, dma=x%04X, left=x%04X,"
 			" aux=x%04X space=x%04X\n",
 			loops, SCHR(s->stream),	s->number,
 			state,	ds->pcm_buf_host_rw_ofs, pcm_buf_dma_ofs, (int)bytes_avail,
@@ -820,7 +814,7 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 
 	next_jiffies = max(next_jiffies, 1U);
 	dpcm->timer.expires = jiffies + next_jiffies;
-	VPRINTK1(KERN_INFO "jif %d buf pos x%04X newdata x%04X xfer x%04X\n",
+	snd_printdd("jif %d buf pos x%04X newdata x%04X xfer x%04X\n",
 			next_jiffies, pcm_buf_dma_ofs, newdata, xfercount);
 
 	snd_pcm_group_for_each_entry(s, substream) {
@@ -835,7 +829,7 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 		if (xfercount && (on_card_bytes <= ds->period_bytes)) {
 			if (card->support_mmap) {
 				if (s->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-					VPRINTK2(KERN_INFO "P%d write x%04x\n",
+					snd_printddd("P%d write x%04x\n",
 							s->number,
 							ds->period_bytes);
 					hpi_handle_error(
@@ -846,7 +840,7 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 							xfercount,
 							&ds->format));
 				} else {
-					VPRINTK2(KERN_INFO "C%d read x%04x\n",
+					snd_printddd("C%d read x%04x\n",
 						s->number,
 						xfercount);
 					hpi_handle_error(
@@ -869,7 +863,7 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 static int snd_card_asihpi_playback_ioctl(struct snd_pcm_substream *substream,
 					  unsigned int cmd, void *arg)
 {
-	/* snd_printd(KERN_INFO "Playback ioctl %d\n", cmd); */
+	snd_printdd(KERN_INFO "Playback ioctl %d\n", cmd);
 	return snd_pcm_lib_ioctl(substream, cmd, arg);
 }
 
@@ -879,7 +873,7 @@ static int snd_card_asihpi_playback_prepare(struct snd_pcm_substream *
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
 
-	VPRINTK1(KERN_INFO "playback prepare %d\n", substream->number);
+	snd_printdd("playback prepare %d\n", substream->number);
 
 	hpi_handle_error(hpi_outstream_reset(dpcm->h_stream));
 	dpcm->pcm_buf_host_rw_ofs = 0;
@@ -896,7 +890,7 @@ snd_card_asihpi_playback_pointer(struct snd_pcm_substream *substream)
 	snd_pcm_uframes_t ptr;
 
 	ptr = bytes_to_frames(runtime, dpcm->pcm_buf_dma_ofs  % dpcm->buffer_bytes);
-	/* VPRINTK2(KERN_INFO "playback_pointer=x%04lx\n", (unsigned long)ptr); */
+	snd_printddd("playback_pointer=x%04lx\n", (unsigned long)ptr);
 	return ptr;
 }
 
@@ -1018,7 +1012,7 @@ static int snd_card_asihpi_playback_open(struct snd_pcm_substream *substream)
 
 	snd_pcm_set_sync(substream);
 
-	VPRINTK1(KERN_INFO "playback open\n");
+	snd_printdd("playback open\n");
 
 	return 0;
 }
@@ -1029,7 +1023,7 @@ static int snd_card_asihpi_playback_close(struct snd_pcm_substream *substream)
 	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
 
 	hpi_handle_error(hpi_outstream_close(dpcm->h_stream));
-	VPRINTK1(KERN_INFO "playback close\n");
+	snd_printdd("playback close\n");
 
 	return 0;
 }
@@ -1049,7 +1043,7 @@ static int snd_card_asihpi_playback_copy(struct snd_pcm_substream *substream,
 	if (copy_from_user(runtime->dma_area, src, len))
 		return -EFAULT;
 
-	VPRINTK2(KERN_DEBUG "playback copy%d %u bytes\n",
+	snd_printddd("playback copy%d %u bytes\n",
 			substream->number, len);
 
 	hpi_handle_error(hpi_outstream_write_buf(dpcm->h_stream,
@@ -1104,7 +1098,7 @@ snd_card_asihpi_capture_pointer(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
 
-	VPRINTK2(KERN_INFO "capture pointer %d=%d\n",
+	snd_printddd("capture pointer %d=%d\n",
 			substream->number, dpcm->pcm_buf_dma_ofs);
 	/* NOTE Unlike playback can't use actual samples_played
 		for the capture position, because those samples aren't yet in
@@ -1129,7 +1123,7 @@ static int snd_card_asihpi_capture_prepare(struct snd_pcm_substream *substream)
 	dpcm->pcm_buf_dma_ofs = 0;
 	dpcm->pcm_buf_elapsed_dma_ofs = 0;
 
-	VPRINTK1("Capture Prepare %d\n", substream->number);
+	snd_printdd("Capture Prepare %d\n", substream->number);
 	return 0;
 }
 
@@ -1192,7 +1186,7 @@ static int snd_card_asihpi_capture_open(struct snd_pcm_substream *substream)
 	if (dpcm == NULL)
 		return -ENOMEM;
 
-	VPRINTK1("hpi_instream_open adapter %d stream %d\n",
+	snd_printdd("capture open adapter %d stream %d\n",
 		   card->adapter_index, substream->number);
 
 	err = hpi_handle_error(
@@ -1262,7 +1256,7 @@ static int snd_card_asihpi_capture_copy(struct snd_pcm_substream *substream,
 
 	len = frames_to_bytes(runtime, count);
 
-	VPRINTK2(KERN_INFO "capture copy%d %d bytes\n", substream->number, len);
+	snd_printddd("capture copy%d %d bytes\n", substream->number, len);
 	hpi_handle_error(hpi_instream_read_buf(dpcm->h_stream,
 				runtime->dma_area, len));
 
@@ -2906,7 +2900,6 @@ static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 			asihpi->support_mrx
 	      );
 
-
 	err = snd_card_asihpi_pcm_new(asihpi, 0, pcm_substreams);
 	if (err < 0) {
 		snd_printk(KERN_ERR "pcm_new failed\n");
@@ -2941,6 +2934,7 @@ static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 	sprintf(card->longname, "%s %i",
 			card->shortname, asihpi->adapter_index);
 	err = snd_card_register(card);
+
 	if (!err) {
 		hpi_card->snd_card_asihpi = card;
 		dev++;
-- 
1.7.0.4
