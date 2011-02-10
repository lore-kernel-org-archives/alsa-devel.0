From: linux@audioscience.com
Subject: [PATCH 06/28] Rewrite PCM timer function. Update
	control names.
Date: Thu, 10 Feb 2011 17:25:59 +1300
Message-ID: <1297311981-30448-7-git-send-email-linux@audioscience.com>
References: <1297311981-30448-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1297311981-30448-1-git-send-email-linux@audioscience.com>
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

Reported samples_played from card may be inaccurate, so don't use it.
Update control names to be closer to alsa standard practice.
Also fixed some accidentally lowercased strings.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 pci/asihpi/asihpi.c |  437 ++++++++++++++++++++++++--------------------------
 1 files changed, 210 insertions(+), 227 deletions(-)

diff --git a/pci/asihpi/asihpi.c b/pci/asihpi/asihpi.c
index c80b0b8..8bcde19 100644
--- a/pci/asihpi/asihpi.c
+++ b/pci/asihpi/asihpi.c
@@ -21,6 +21,7 @@
  *  would appreciate it if you grant us the right to use those modifications
  *  for any purpose including commercial applications.
  */
+
 /* >0: print Hw params, timer vars. >1: print stream write/copy sizes  */
 #define REALLY_VERBOSE_LOGGING 0
 
@@ -36,16 +37,19 @@
 #define VPRINTK2(...)
 #endif
 
-#ifndef ASI_STYLE_NAMES
-/* not sure how ALSA style name should look */
-#define ASI_STYLE_NAMES 1
-#endif
-
 #include "hpi_internal.h"
 #include "hpimsginit.h"
 #include "hpioctl.h"
 
+#ifndef KERNEL_ALSA_BUILD
+/* building in ALSA source tree */
+#include "adriver.h"
+#else
+/* building in kernel tree */
+#endif
+
 #include <linux/pci.h>
+#include <linux/version.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/slab.h>
@@ -85,11 +89,11 @@ MODULE_PARM_DESC(enable_hpi_hwdep,
 
 /* identify driver */
 #ifdef KERNEL_ALSA_BUILD
-static char *build_info = "built using headers from kernel source";
+static char *build_info = "Built using headers from kernel source";
 module_param(build_info, charp, S_IRUGO);
 MODULE_PARM_DESC(build_info, "built using headers from kernel source");
 #else
-static char *build_info = "built within ALSA source";
+static char *build_info = "Built within ALSA source";
 module_param(build_info, charp, S_IRUGO);
 MODULE_PARM_DESC(build_info, "built within ALSA source");
 #endif
@@ -104,7 +108,7 @@ static struct hpi_hsubsys *ss;	/* handle to HPI audio subsystem */
 
 /* defaults */
 #define PERIODS_MIN 2
-#define PERIOD_BYTES_MIN  2304
+#define PERIOD_BYTES_MIN  2048
 #define BUFFER_BYTES_MAX (512 * 1024)
 
 /*#define TIMER_MILLISECONDS 20
@@ -155,8 +159,9 @@ struct snd_card_asihpi_pcm {
 	unsigned int pcm_size;
 	unsigned int pcm_count;
 	unsigned int bytes_per_sec;
-	unsigned int pcm_irq_pos;	/* IRQ position */
-	unsigned int pcm_buf_pos;	/* position in buffer */
+	unsigned int pcm_buf_host_rw_ofs; /* Host R/W pos */
+	unsigned int pcm_buf_dma_ofs;	/* DMA R/W offset in buffer */
+	unsigned int pcm_buf_elapsed_dma_ofs;	/* DMA R/W offset in buffer */
 	struct snd_pcm_substream *substream;
 	u32 h_stream;
 	struct hpi_format format;
@@ -244,14 +249,16 @@ static inline u16 hpi_stream_get_info_ex(
     u32        *pauxiliary_data
 )
 {
+	u16 e;
 	if (hpi_handle_object(h_stream)  ==  HPI_OBJ_OSTREAM)
-		return hpi_outstream_get_info_ex(hS, h_stream, pw_state,
+		e = hpi_outstream_get_info_ex(hS, h_stream, pw_state,
 					pbuffer_size, pdata_in_buffer,
 					psample_count, pauxiliary_data);
 	else
-		return hpi_instream_get_info_ex(hS, h_stream, pw_state,
+		e = hpi_instream_get_info_ex(hS, h_stream, pw_state,
 					pbuffer_size, pdata_in_buffer,
 					psample_count, pauxiliary_data);
+	return e;
 }
 
 static inline u16 hpi_stream_group_add(struct hpi_hsubsys *hS,
@@ -299,11 +306,11 @@ static void print_hwparams(struct snd_pcm_hw_params *p)
 {
 	snd_printd("HWPARAMS \n");
 	snd_printd("samplerate %d \n", params_rate(p));
-	snd_printd("channels %d \n", params_channels(p));
-	snd_printd("format %d \n", params_format(p));
+	snd_printd("Channels %d \n", params_channels(p));
+	snd_printd("Format %d \n", params_format(p));
 	snd_printd("subformat %d \n", params_subformat(p));
-	snd_printd("buffer bytes %d \n", params_buffer_bytes(p));
-	snd_printd("period bytes %d \n", params_period_bytes(p));
+	snd_printd("Buffer bytes %d \n", params_buffer_bytes(p));
+	snd_printd("Period bytes %d \n", params_period_bytes(p));
 	snd_printd("access %d \n", params_access(p));
 	snd_printd("period_size %d \n", params_period_size(p));
 	snd_printd("periods %d \n", params_periods(p));
@@ -383,7 +390,7 @@ static void snd_card_asihpi_pcm_samplerates(struct snd_card_asihpi *asihpi,
 					  HPI_CONTROL_SAMPLECLOCK, &h_control);
 		if (err) {
 			snd_printk(KERN_ERR
-				"no local sampleclock, err %d\n", err);
+				"No local sampleclock, err %d\n", err);
 		}
 
 		for (idx = 0; idx < 100; idx++) {
@@ -391,7 +398,7 @@ static void snd_card_asihpi_pcm_samplerates(struct snd_card_asihpi *asihpi,
 				h_control, idx, &sample_rate)) {
 				if (!idx)
 					snd_printk(KERN_ERR
-						"local rate query failed\n");
+						"Local rate query failed\n");
 
 				break;
 			}
@@ -525,11 +532,27 @@ static int snd_card_asihpi_pcm_hw_params(struct snd_pcm_substream *substream,
 	snd_printd(KERN_INFO "pcm_size=%d, pcm_count=%d, bps=%d\n",
 			dpcm->pcm_size, dpcm->pcm_count, bytes_per_sec);
 
-	dpcm->pcm_irq_pos = 0;
-	dpcm->pcm_buf_pos = 0;
 	return 0;
 }
 
+static int
+snd_card_asihpi_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
+	if (dpcm->hpi_buffer_attached)
+		hpi_stream_host_buffer_detach(ss, dpcm->h_stream);
+
+	snd_pcm_lib_free_pages(substream);
+	return 0;
+}
+
+static void snd_card_asihpi_runtime_free(struct snd_pcm_runtime *runtime)
+{
+	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
+	kfree(dpcm);
+}
+
 static void snd_card_asihpi_pcm_timer_start(struct snd_pcm_substream *
 					    substream)
 {
@@ -537,9 +560,8 @@ static void snd_card_asihpi_pcm_timer_start(struct snd_pcm_substream *
 	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
 	int expiry;
 
-	expiry = (dpcm->pcm_count * HZ / dpcm->bytes_per_sec);
-	/* wait longer the first time, for samples to propagate */
-	expiry = max(expiry, 20);
+	expiry = HZ / 100;; //? (dpcm->pcm_count * HZ / dpcm->bytes_per_sec);
+	expiry = max(expiry, 1); /* don't let it be zero! */
 	dpcm->timer.expires = jiffies + expiry;
 	dpcm->respawn_timer = 1;
 	add_timer(&dpcm->timer);
@@ -562,13 +584,13 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 	struct snd_pcm_substream *s;
 	u16 e;
 
-	snd_printd("trigger %dstream %d\n",
+	snd_printd("Trigger %dstream %d\n",
 			substream->stream, substream->number);
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		snd_pcm_group_for_each_entry(s, substream) {
-			struct snd_card_asihpi_pcm *ds;
-			ds = s->runtime->private_data;
+			struct snd_pcm_runtime *runtime = s->runtime;
+			struct snd_card_asihpi_pcm *ds = runtime->private_data;
 
 			if (snd_pcm_substream_chip(s) != card)
 				continue;
@@ -576,17 +598,19 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 			if ((s->stream == SNDRV_PCM_STREAM_PLAYBACK) &&
 				(card->support_mmap)) {
 				/* How do I know how much valid data is present
-				* in buffer? Just guessing 2 periods, but if
+				* in buffer? Must be at least one period!
+				* Guessing 2 periods, but if
 				* buffer is bigger it may contain even more
 				* data??
 				*/
-				unsigned int preload = ds->pcm_count * 2;
-				VPRINTK2("preload %d\n", preload);
+				unsigned int preload = ds->pcm_count * 1;
+				VPRINTK2("Preload x%x\n", preload);
 				hpi_handle_error(hpi_outstream_write_buf(
 						ss, ds->h_stream,
-						&s->runtime->dma_area[0],
+						&runtime->dma_area[0],
 						preload,
 						&ds->format));
+				ds->pcm_buf_host_rw_ofs = preload;
 			}
 
 			if (card->support_grouping) {
@@ -604,7 +628,7 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 			} else
 				break;
 		}
-		snd_printd("start\n");
+		snd_printd("Start\n");
 		/* start the master stream */
 		snd_card_asihpi_pcm_timer_start(substream);
 		hpi_handle_error(hpi_stream_start(ss, dpcm->h_stream));
@@ -627,7 +651,7 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 			} else
 				break;
 		}
-		snd_printd("stop\n");
+		snd_printd("Stop\n");
 
 		/* _prepare and _hwparams reset the stream */
 		hpi_handle_error(hpi_stream_stop(ss, dpcm->h_stream));
@@ -641,12 +665,12 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 		break;
 
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		snd_printd("pause release\n");
+		snd_printd("Pause release\n");
 		hpi_handle_error(hpi_stream_start(ss, dpcm->h_stream));
 		snd_card_asihpi_pcm_timer_start(substream);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		snd_printd("pause\n");
+		snd_printd("Pause\n");
 		snd_card_asihpi_pcm_timer_stop(substream);
 		hpi_handle_error(hpi_stream_stop(ss, dpcm->h_stream));
 		break;
@@ -658,38 +682,20 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int
-snd_card_asihpi_hw_free(struct snd_pcm_substream *substream)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
-	if (dpcm->hpi_buffer_attached)
-		hpi_stream_host_buffer_detach(ss, dpcm->h_stream);
-
-	snd_pcm_lib_free_pages(substream);
-	return 0;
-}
-
-static void snd_card_asihpi_runtime_free(struct snd_pcm_runtime *runtime)
-{
-	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
-	kfree(dpcm);
-}
-
 /*algorithm outline
  Without linking degenerates to getting single stream pos etc
  Without mmap 2nd loop degenerates to snd_pcm_period_elapsed
 */
 /*
-buf_pos=get_buf_pos(s);
+pcm_buf_dma_ofs=get_buf_pos(s);
 for_each_linked_stream(s) {
-	buf_pos=get_buf_pos(s);
-	min_buf_pos = modulo_min(min_buf_pos, buf_pos, pcm_size)
-	new_data = min(new_data, calc_new_data(buf_pos,irq_pos)
+	pcm_buf_dma_ofs=get_buf_pos(s);
+	min_buf_pos = modulo_min(min_buf_pos, pcm_buf_dma_ofs, pcm_size)
+	new_data = min(new_data, calc_new_data(pcm_buf_dma_ofs,irq_pos)
 }
 timer.expires = jiffies + predict_next_period_ready(min_buf_pos);
 for_each_linked_stream(s) {
-	s->buf_pos = min_buf_pos;
+	s->pcm_buf_dma_ofs = min_buf_pos;
 	if (new_data > pcm_count) {
 		if (mmap) {
 			irq_pos = (irq_pos + pcm_count) % pcm_size;
@@ -728,11 +734,11 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 	struct snd_pcm_runtime *runtime;
 	struct snd_pcm_substream *s;
 	unsigned int newdata = 0;
-	unsigned int buf_pos, min_buf_pos = 0;
+	unsigned int pcm_buf_dma_ofs, min_buf_pos = 0;
 	unsigned int remdata, xfercount, next_jiffies;
 	int first = 1;
 	u16 state;
-	u32 buffer_size, data_avail, samples_played, aux;
+	u32 buffer_size, bytes_avail, samples_played, on_card_bytes;
 
 	/* find minimum newdata and buffer pos in group */
 	snd_pcm_group_for_each_entry(s, dpcm->substream) {
@@ -744,35 +750,34 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 
 		hpi_handle_error(hpi_stream_get_info_ex(ss,
 					ds->h_stream, &state,
-					&buffer_size, &data_avail,
-					&samples_played, &aux));
+					&buffer_size, &bytes_avail,
+					&samples_played, &on_card_bytes));
 
 		/* number of bytes in on-card buffer */
-		runtime->delay = aux;
+		runtime->delay = on_card_bytes;
 
 		if (state == HPI_STATE_DRAINED) {
 			snd_printd(KERN_WARNING  "outstream %d drained\n",
 					s->number);
-			snd_pcm_stop(s, SNDRV_PCM_STATE_XRUN);
-			return;
+			//snd_pcm_stop(s, SNDRV_PCM_STATE_XRUN);
+			//return;
 		}
 
-		if (s->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			buf_pos = frames_to_bytes(runtime, samples_played);
-		} else {
-			buf_pos = data_avail + ds->pcm_irq_pos;
-		}
+		if (s->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			pcm_buf_dma_ofs = ds->pcm_buf_host_rw_ofs - bytes_avail;
+		else
+			pcm_buf_dma_ofs = bytes_avail + ds->pcm_buf_host_rw_ofs;
 
 		if (first) {
 			/* can't statically init min when wrap is involved */
-			min_buf_pos = buf_pos;
-			newdata = (buf_pos - ds->pcm_irq_pos) % ds->pcm_size;
+			min_buf_pos = pcm_buf_dma_ofs;
+			newdata = (pcm_buf_dma_ofs - ds->pcm_buf_elapsed_dma_ofs) % ds->pcm_size;
 			first = 0;
 		} else {
 			min_buf_pos =
-				modulo_min(min_buf_pos, buf_pos, UINT_MAX+1L);
+				modulo_min(min_buf_pos, pcm_buf_dma_ofs, UINT_MAX+1L);
 			newdata = min(
-				(buf_pos - ds->pcm_irq_pos) % ds->pcm_size,
+				(pcm_buf_dma_ofs - ds->pcm_buf_elapsed_dma_ofs) % ds->pcm_size,
 				newdata);
 		}
 
@@ -781,29 +786,40 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 						runtime->status->hw_ptr),
 			(unsigned long)frames_to_bytes(runtime,
 						runtime->control->appl_ptr));
+
 		VPRINTK1("%d S=%d, irq=%04X, pos=x%04X, left=x%04X,"
 			" aux=x%04X space=x%04X\n", s->number,
-			state,	ds->pcm_irq_pos, buf_pos, (int)data_avail,
-			(int)aux, buffer_size-data_avail);
+			state,	ds->pcm_buf_host_rw_ofs, pcm_buf_dma_ofs, (int)bytes_avail,
+			(int)on_card_bytes, buffer_size-bytes_avail);
 	}
+	pcm_buf_dma_ofs = min_buf_pos;
 
 	remdata = newdata % dpcm->pcm_count;
 	xfercount = newdata - remdata; /* a multiple of pcm_count */
-	next_jiffies = ((dpcm->pcm_count-remdata) * HZ / dpcm->bytes_per_sec)+1;
-	next_jiffies = max(next_jiffies, 2U * HZ / 1000U);
+	/* come back when on_card_bytes has decreased enough to allow
+	   write to happen, or when data has been consumed to make another
+	   period
+	*/
+	if (xfercount && (on_card_bytes  > dpcm->pcm_count))
+		next_jiffies = ((on_card_bytes - dpcm->pcm_count) * HZ / dpcm->bytes_per_sec);
+	else
+		next_jiffies = ((dpcm->pcm_count - remdata) * HZ / dpcm->bytes_per_sec);
+
+	next_jiffies = max(next_jiffies, 1U);
 	dpcm->timer.expires = jiffies + next_jiffies;
-	VPRINTK1("jif %d buf pos x%04X newdata x%04X xc x%04X\n",
-			next_jiffies, min_buf_pos, newdata, xfercount);
+	VPRINTK1("jif %d buf pos x%04X newdata x%04X xfer x%04X\n",
+			next_jiffies, pcm_buf_dma_ofs, newdata, xfercount);
+
 
 	snd_pcm_group_for_each_entry(s, dpcm->substream) {
 		struct snd_card_asihpi_pcm *ds = s->runtime->private_data;
-		ds->pcm_buf_pos = min_buf_pos;
 
-		if (xfercount) {
+		ds->pcm_buf_dma_ofs = pcm_buf_dma_ofs;
+
+		if (xfercount && (on_card_bytes <= ds->pcm_count)) {
 			if (card->support_mmap) {
-				ds->pcm_irq_pos = ds->pcm_irq_pos + xfercount;
 				if (s->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-					VPRINTK2("write OS%d x%04x\n",
+					VPRINTK2("Write OS%d x%04x\n",
 							s->number,
 							ds->pcm_count);
 					hpi_handle_error(
@@ -814,15 +830,17 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 							xfercount,
 							&ds->format));
 				} else {
-					VPRINTK2("read IS%d x%04x\n",
+					VPRINTK2("Read IS%d x%04x\n",
 						s->number,
-						dpcm->pcm_count);
+						xfercount);
 					hpi_handle_error(
 						hpi_instream_read_buf(
 							ss, ds->h_stream,
 							NULL, xfercount));
 				}
+				ds->pcm_buf_host_rw_ofs = ds->pcm_buf_host_rw_ofs + xfercount;
 			} /* else R/W will be handled by read/write callbacks */
+			ds->pcm_buf_elapsed_dma_ofs = pcm_buf_dma_ofs;
 			snd_pcm_period_elapsed(s);
 		}
 	}
@@ -848,9 +866,9 @@ static int snd_card_asihpi_playback_prepare(struct snd_pcm_substream *
 	snd_printd(KERN_INFO "playback prepare %d\n", substream->number);
 
 	hpi_handle_error(hpi_outstream_reset(ss, dpcm->h_stream));
-	dpcm->pcm_irq_pos = 0;
-	dpcm->pcm_buf_pos = 0;
-
+	dpcm->pcm_buf_host_rw_ofs = 0;
+	dpcm->pcm_buf_dma_ofs = 0;
+	dpcm->pcm_buf_elapsed_dma_ofs = 0;
 	return 0;
 }
 
@@ -861,27 +879,8 @@ snd_card_asihpi_playback_pointer(struct snd_pcm_substream *substream)
 	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
 	snd_pcm_uframes_t ptr;
 
-	u32 samples_played;
-	u16 err;
-
-	if (!snd_pcm_stream_linked(substream)) {
-		/* NOTE, can use samples played for playback position here and
-		* in timer fn because it LAGS the actual read pointer, and is a
-		* better representation of actual playout position
-		*/
-		err = hpi_outstream_get_info_ex(ss, dpcm->h_stream, NULL,
-					NULL, NULL,
-					&samples_played, NULL);
-		hpi_handle_error(err);
-
-		dpcm->pcm_buf_pos = frames_to_bytes(runtime, samples_played);
-	}
-	/* else must return most conservative value found in timer func
-	 * by looping over all streams
-	 */
-
-	ptr = bytes_to_frames(runtime, dpcm->pcm_buf_pos  % dpcm->pcm_size);
-	VPRINTK2("playback_pointer=%04ld\n", (unsigned long)ptr);
+	ptr = bytes_to_frames(runtime, dpcm->pcm_buf_dma_ofs  % dpcm->pcm_size);
+	//VPRINTK2("playback_pointer=x%04lx\n", (unsigned long)ptr);
 	return ptr;
 }
 
@@ -998,7 +997,7 @@ static int snd_card_asihpi_playback_open(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
 		card->update_interval_frames);
 	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
-		card->update_interval_frames * 4, UINT_MAX);
+		card->update_interval_frames * 2, UINT_MAX);
 
 	snd_pcm_set_sync(substream);
 
@@ -1039,6 +1038,8 @@ static int snd_card_asihpi_playback_copy(struct snd_pcm_substream *substream,
 	hpi_handle_error(hpi_outstream_write_buf(ss, dpcm->h_stream,
 				runtime->dma_area, len, &dpcm->format));
 
+	dpcm->pcm_buf_host_rw_ofs = dpcm->pcm_buf_host_rw_ofs + len;
+
 	return 0;
 }
 
@@ -1091,13 +1092,13 @@ snd_card_asihpi_capture_pointer(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
 
-	VPRINTK2("capture pointer %d=%d\n",
-			substream->number, dpcm->pcm_buf_pos);
-	/* NOTE Unlike playback can't use actual dwSamplesPlayed
+	VPRINTK2("Capture pointer %d=%d\n",
+			substream->number, dpcm->pcm_buf_dma_ofs);
+	/* NOTE Unlike playback can't use actual samples_played
 		for the capture position, because those samples aren't yet in
 		the local buffer available for reading.
 	*/
-	return bytes_to_frames(runtime, dpcm->pcm_buf_pos % dpcm->pcm_size);
+	return bytes_to_frames(runtime, dpcm->pcm_buf_dma_ofs % dpcm->pcm_size);
 }
 
 static int snd_card_asihpi_capture_ioctl(struct snd_pcm_substream *substream,
@@ -1112,10 +1113,11 @@ static int snd_card_asihpi_capture_prepare(struct snd_pcm_substream *substream)
 	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
 
 	hpi_handle_error(hpi_instream_reset(ss, dpcm->h_stream));
-	dpcm->pcm_irq_pos = 0;
-	dpcm->pcm_buf_pos = 0;
+	dpcm->pcm_buf_host_rw_ofs = 0;
+	dpcm->pcm_buf_dma_ofs = 0;
+	dpcm->pcm_buf_elapsed_dma_ofs = 0;
 
-	snd_printd("capture prepare %d\n", substream->number);
+	snd_printd("Capture Prepare %d\n", substream->number);
 	return 0;
 }
 
@@ -1209,6 +1211,9 @@ static int snd_card_asihpi_capture_open(struct snd_pcm_substream *substream)
 		snd_card_asihpi_capture.info |= SNDRV_PCM_INFO_MMAP |
 						SNDRV_PCM_INFO_MMAP_VALID;
 
+	if (card->support_grouping)
+		snd_card_asihpi_capture.info |= SNDRV_PCM_INFO_SYNC_START;
+
 	runtime->hw = snd_card_asihpi_capture;
 
 	if (card->support_mmap)
@@ -1241,18 +1246,17 @@ static int snd_card_asihpi_capture_copy(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
-	u32 data_size;
+	u32 len;
 
-	data_size = frames_to_bytes(runtime, count);
+	len = frames_to_bytes(runtime, count);
 
-	VPRINTK2("capture copy%d %d bytes\n", substream->number, data_size);
+	VPRINTK2("Capture copy%d %d bytes\n", substream->number, len);
 	hpi_handle_error(hpi_instream_read_buf(ss, dpcm->h_stream,
-				runtime->dma_area, data_size));
+				runtime->dma_area, len));
 
-	/* Used by capture_pointer */
-	dpcm->pcm_irq_pos = dpcm->pcm_irq_pos + data_size;
+	dpcm->pcm_buf_host_rw_ofs = dpcm->pcm_buf_host_rw_ofs + len;
 
-	if (copy_to_user(dst, runtime->dma_area, data_size))
+	if (copy_to_user(dst, runtime->dma_area, len))
 		return -EFAULT;
 
 	return 0;
@@ -1287,7 +1291,7 @@ static int __devinit snd_card_asihpi_pcm_new(struct snd_card_asihpi *asihpi,
 	struct snd_pcm *pcm;
 	int err;
 
-	err = snd_pcm_new(asihpi->card, "asihpi PCM", device,
+	err = snd_pcm_new(asihpi->card, "Asihpi PCM", device,
 			 asihpi->num_outstreams, asihpi->num_instreams,
 			 &pcm);
 	if (err < 0)
@@ -1307,7 +1311,7 @@ static int __devinit snd_card_asihpi_pcm_new(struct snd_card_asihpi *asihpi,
 
 	pcm->private_data = asihpi;
 	pcm->info_flags = 0;
-	strcpy(pcm->name, "asihpi PCM");
+	strcpy(pcm->name, "Asihpi PCM");
 
 	/*? do we want to emulate MMAP for non-BBM cards?
 	Jack doesn't work with ALSAs MMAP emulation - WHY NOT? */
@@ -1330,7 +1334,7 @@ struct hpi_control {
 	char name[44]; /* copied to snd_ctl_elem_id.name[44]; */
 };
 
-static char *asihpi_tuner_band_names[] =
+static const char * const asihpi_tuner_band_names[] =
 {
 	"invalid",
 	"AM",
@@ -1349,70 +1353,38 @@ compile_time_assert(
 		(HPI_TUNER_BAND_LAST+1)),
 	assert_tuner_band_names_size);
 
-#if ASI_STYLE_NAMES
-static char *asihpi_src_names[] =
+static const char * const asihpi_src_names[] =
 {
 	"no source",
-	"outstream",
-	"line_in",
-	"aes_in",
-	"tuner",
+	"PCM",
+	"Line",
+	"Digital",
+	"Tuner",
 	"RF",
-	"clock",
-	"bitstr",
-	"mic",
-	"cobranet",
-	"analog_in",
-	"adapter",
+	"Clock",
+	"Bitstream",
+	"Microphone",
+	"Cobranet",
+	"Analog",
+	"Adapter",
 };
-#else
-static char *asihpi_src_names[] =
-{
-	"no source",
-	"PCM playback",
-	"line in",
-	"digital in",
-	"tuner",
-	"RF",
-	"clock",
-	"bitstream",
-	"mic",
-	"cobranet in",
-	"analog in",
-	"adapter",
-};
-#endif
 
 compile_time_assert(
 	(ARRAY_SIZE(asihpi_src_names) ==
 		(HPI_SOURCENODE_LAST_INDEX-HPI_SOURCENODE_NONE+1)),
 	assert_src_names_size);
 
-#if ASI_STYLE_NAMES
-static char *asihpi_dst_names[] =
-{
-	"no destination",
-	"instream",
-	"line_out",
-	"aes_out",
-	"RF",
-	"speaker" ,
-	"cobranet",
-	"analog_out",
-};
-#else
-static char *asihpi_dst_names[] =
+static const char * const asihpi_dst_names[] =
 {
 	"no destination",
-	"PCM capture",
-	"line out",
-	"digital out",
+	"PCM",
+	"Line",
+	"Digital",
 	"RF",
-	"speaker",
-	"cobranet out",
-	"analog out"
+	"Speaker",
+	"Cobranet Out",
+	"Analog"
 };
-#endif
 
 compile_time_assert(
 	(ARRAY_SIZE(asihpi_dst_names) ==
@@ -1438,30 +1410,43 @@ static void asihpi_ctl_init(struct snd_kcontrol_new *snd_control,
 				struct hpi_control *hpi_ctl,
 				char *name)
 {
+	char *dir = "";
 	memset(snd_control, 0, sizeof(*snd_control));
 	snd_control->name = hpi_ctl->name;
 	snd_control->private_value = hpi_ctl->h_control;
 	snd_control->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 	snd_control->index = 0;
 
+	if (hpi_ctl->dst_node_type + HPI_DESTNODE_NONE == HPI_DESTNODE_ISTREAM)
+		dir = "Capture ";  /* On or towards a PCM capture destination*/
+	else if ((hpi_ctl->src_node_type + HPI_SOURCENODE_NONE != HPI_SOURCENODE_OSTREAM) &&
+		(!hpi_ctl->dst_node_type))
+		dir = "Capture "; /* On a source node that is not PCM playback */
+	else if ((hpi_ctl->src_node_type + HPI_SOURCENODE_NONE != HPI_SOURCENODE_OSTREAM) &&
+		(hpi_ctl->dst_node_type))
+		dir = "Monitor Playback "; /* Between an input and an output */
+	else
+		dir = "Playback "; /* PCM Playback source, or  output node */
+
 	if (hpi_ctl->src_node_type && hpi_ctl->dst_node_type)
-		sprintf(hpi_ctl->name, "%s%d to %s%d %s",
+		sprintf(hpi_ctl->name, "%s%d %s%d %s%s",
 			asihpi_src_names[hpi_ctl->src_node_type],
 			hpi_ctl->src_node_index,
 			asihpi_dst_names[hpi_ctl->dst_node_type],
 			hpi_ctl->dst_node_index,
-			name);
+			dir, name);
 	else if (hpi_ctl->dst_node_type) {
-		sprintf(hpi_ctl->name, "%s%d %s",
+		sprintf(hpi_ctl->name, "%s %d %s%s",
 		asihpi_dst_names[hpi_ctl->dst_node_type],
 		hpi_ctl->dst_node_index,
-		name);
+		dir, name);
 	} else {
-		sprintf(hpi_ctl->name, "%s%d %s",
+		sprintf(hpi_ctl->name, "%s %d %s%s",
 		asihpi_src_names[hpi_ctl->src_node_type],
 		hpi_ctl->src_node_index,
-		name);
+		dir, name);
 	}
+	// printk(KERN_INFO "adding %s %d to %d ",  hpi_ctl->name, hpi_ctl->src_node_type, hpi_ctl->dst_node_type);
 }
 
 /*------------------------------------------------------------
@@ -1534,7 +1519,7 @@ static int __devinit snd_asihpi_volume_add(struct snd_card_asihpi *asihpi,
 	struct snd_card *card = asihpi->card;
 	struct snd_kcontrol_new snd_control;
 
-	asihpi_ctl_init(&snd_control, hpi_ctl, "volume");
+	asihpi_ctl_init(&snd_control, hpi_ctl, "Volume");
 	snd_control.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
 				SNDRV_CTL_ELEM_ACCESS_TLV_READ;
 	snd_control.info = snd_asihpi_volume_info;
@@ -1617,7 +1602,7 @@ static int __devinit snd_asihpi_level_add(struct snd_card_asihpi *asihpi,
 	struct snd_kcontrol_new snd_control;
 
 	/* can't use 'volume' cos some nodes have volume as well */
-	asihpi_ctl_init(&snd_control, hpi_ctl, "level");
+	asihpi_ctl_init(&snd_control, hpi_ctl, "Level");
 	snd_control.access = SNDRV_CTL_ELEM_ACCESS_READWRITE |
 				SNDRV_CTL_ELEM_ACCESS_TLV_READ;
 	snd_control.info = snd_asihpi_level_info;
@@ -1633,7 +1618,7 @@ static int __devinit snd_asihpi_level_add(struct snd_card_asihpi *asihpi,
  ------------------------------------------------------------*/
 
 /* AESEBU format */
-static char *asihpi_aesebu_format_names[] =
+static const char * const asihpi_aesebu_format_names[] =
 {
 	"N/A",
 	"S/PDIF",
@@ -1742,7 +1727,7 @@ static int __devinit snd_asihpi_aesebu_rx_add(struct snd_card_asihpi *asihpi,
 	struct snd_card *card = asihpi->card;
 	struct snd_kcontrol_new snd_control;
 
-	asihpi_ctl_init(&snd_control, hpi_ctl, "format");
+	asihpi_ctl_init(&snd_control, hpi_ctl, "Format");
 	snd_control.access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
 	snd_control.info = snd_asihpi_aesebu_format_info;
 	snd_control.get = snd_asihpi_aesebu_rx_format_get;
@@ -1752,7 +1737,7 @@ static int __devinit snd_asihpi_aesebu_rx_add(struct snd_card_asihpi *asihpi,
 	if (ctl_add(card, &snd_control, asihpi) < 0)
 		return -EINVAL;
 
-	asihpi_ctl_init(&snd_control, hpi_ctl, "status");
+	asihpi_ctl_init(&snd_control, hpi_ctl, "Status");
 	snd_control.access =
 	    SNDRV_CTL_ELEM_ACCESS_VOLATILE | SNDRV_CTL_ELEM_ACCESS_READ;
 	snd_control.info = snd_asihpi_aesebu_rxstatus_info;
@@ -1780,7 +1765,7 @@ static int __devinit snd_asihpi_aesebu_tx_add(struct snd_card_asihpi *asihpi,
 	struct snd_card *card = asihpi->card;
 	struct snd_kcontrol_new snd_control;
 
-	asihpi_ctl_init(&snd_control, hpi_ctl, "format");
+	asihpi_ctl_init(&snd_control, hpi_ctl, "Format");
 	snd_control.access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
 	snd_control.info = snd_asihpi_aesebu_format_info;
 	snd_control.get = snd_asihpi_aesebu_tx_format_get;
@@ -2027,7 +2012,7 @@ static int __devinit snd_asihpi_tuner_add(struct snd_card_asihpi *asihpi,
 	snd_control.access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
 
 	if (!hpi_tuner_get_gain(ss, hpi_ctl->h_control, NULL)) {
-		asihpi_ctl_init(&snd_control, hpi_ctl, "gain");
+		asihpi_ctl_init(&snd_control, hpi_ctl, "Gain");
 		snd_control.info = snd_asihpi_tuner_gain_info;
 		snd_control.get = snd_asihpi_tuner_gain_get;
 		snd_control.put = snd_asihpi_tuner_gain_put;
@@ -2036,7 +2021,7 @@ static int __devinit snd_asihpi_tuner_add(struct snd_card_asihpi *asihpi,
 			return -EINVAL;
 	}
 
-	asihpi_ctl_init(&snd_control, hpi_ctl, "band");
+	asihpi_ctl_init(&snd_control, hpi_ctl, "Band");
 	snd_control.info = snd_asihpi_tuner_band_info;
 	snd_control.get = snd_asihpi_tuner_band_get;
 	snd_control.put = snd_asihpi_tuner_band_put;
@@ -2044,7 +2029,7 @@ static int __devinit snd_asihpi_tuner_add(struct snd_card_asihpi *asihpi,
 	if (ctl_add(card, &snd_control, asihpi) < 0)
 		return -EINVAL;
 
-	asihpi_ctl_init(&snd_control, hpi_ctl, "freq");
+	asihpi_ctl_init(&snd_control, hpi_ctl, "Freq");
 	snd_control.info = snd_asihpi_tuner_freq_info;
 	snd_control.get = snd_asihpi_tuner_freq_get;
 	snd_control.put = snd_asihpi_tuner_freq_put;
@@ -2120,7 +2105,7 @@ static int __devinit snd_asihpi_meter_add(struct snd_card_asihpi *asihpi,
 	struct snd_card *card = asihpi->card;
 	struct snd_kcontrol_new snd_control;
 
-	asihpi_ctl_init(&snd_control, hpi_ctl, "meter");
+	asihpi_ctl_init(&snd_control, hpi_ctl, "Meter");
 	snd_control.access =
 	    SNDRV_CTL_ELEM_ACCESS_VOLATILE | SNDRV_CTL_ELEM_ACCESS_READ;
 	snd_control.info = snd_asihpi_meter_info;
@@ -2201,7 +2186,7 @@ static int snd_asihpi_mux_get(struct snd_kcontrol *kcontrol,
 		}
 	}
 	snd_printd(KERN_WARNING
-		"control %x failed to match mux source %hu %hu\n",
+		"Control %x failed to match mux source %hu %hu\n",
 		h_control, source_type, source_index);
 	ucontrol->value.enumerated.item[0] = 0;
 	return 0;
@@ -2234,11 +2219,7 @@ static int  __devinit snd_asihpi_mux_add(struct snd_card_asihpi *asihpi,
 	struct snd_card *card = asihpi->card;
 	struct snd_kcontrol_new snd_control;
 
-#if ASI_STYLE_NAMES
-	asihpi_ctl_init(&snd_control, hpi_ctl, "multiplexer");
-#else
-	asihpi_ctl_init(&snd_control, hpi_ctl, "route");
-#endif
+	asihpi_ctl_init(&snd_control, hpi_ctl, "Route");
 	snd_control.access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
 	snd_control.info = snd_asihpi_mux_info;
 	snd_control.get = snd_asihpi_mux_get;
@@ -2254,33 +2235,38 @@ static int  __devinit snd_asihpi_mux_add(struct snd_card_asihpi *asihpi,
 static int snd_asihpi_cmode_info(struct snd_kcontrol *kcontrol,
 				 struct snd_ctl_elem_info *uinfo)
 {
-	static char *mode_names[HPI_CHANNEL_MODE_LAST] = {
-		"normal", "swap",
-		"from_left", "from_right",
-		"to_left", "to_right"
+	static const char * const mode_names[HPI_CHANNEL_MODE_LAST + 1] = {
+		"invalid",
+		"Normal", "Swap",
+		"From Left", "From Right",
+		"To Left", "To Right"
 	};
 
 	u32 h_control = kcontrol->private_value;
 	u16 mode;
 	int i;
+	u16 mode_map[6];
+	int valid_modes = 0;
 
 	/* HPI channel mode values can be from 1 to 6
 	Some adapters only support a contiguous subset
 	*/
 	for (i = 0; i < HPI_CHANNEL_MODE_LAST; i++)
-		if (hpi_channel_mode_query_mode(
-			ss,  h_control, i, &mode))
-			break;
+		if (!hpi_channel_mode_query_mode(
+			ss,  h_control, i, &mode)) {
+			mode_map[valid_modes] = mode;
+			valid_modes++;
+			}
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
-	uinfo->value.enumerated.items = i;
+	uinfo->value.enumerated.items = valid_modes;
 
-	if (uinfo->value.enumerated.item >= i)
-		uinfo->value.enumerated.item = i - 1;
+	if (uinfo->value.enumerated.item >= valid_modes)
+		uinfo->value.enumerated.item = valid_modes - 1;
 
 	strcpy(uinfo->value.enumerated.name,
-	       mode_names[uinfo->value.enumerated.item]);
+	       mode_names[mode_map[uinfo->value.enumerated.item]]);
 
 	return 0;
 }
@@ -2319,7 +2305,7 @@ static int __devinit snd_asihpi_cmode_add(struct snd_card_asihpi *asihpi,
 	struct snd_card *card = asihpi->card;
 	struct snd_kcontrol_new snd_control;
 
-	asihpi_ctl_init(&snd_control, hpi_ctl, "channel mode");
+	asihpi_ctl_init(&snd_control, hpi_ctl, "Mode");
 	snd_control.access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
 	snd_control.info = snd_asihpi_cmode_info;
 	snd_control.get = snd_asihpi_cmode_get;
@@ -2331,15 +2317,12 @@ static int __devinit snd_asihpi_cmode_add(struct snd_card_asihpi *asihpi,
 /*------------------------------------------------------------
    Sampleclock source  controls
  ------------------------------------------------------------*/
-
 static char *sampleclock_sources[MAX_CLOCKSOURCES] =
-    { "N/A", "local PLL", "AES/EBU sync", "word external", "word header",
-	  "SMPTE", "AES/EBU in1", "auto", "network", "invalid",
-	  "prev module",
-	  "AES/EBU in2", "AES/EBU in3", "AES/EBU in4", "AES/EBU in5",
-	  "AES/EBU in6", "AES/EBU in7", "AES/EBU in8"};
-
-
+{ "N/A", "Local PLL", "Digital Sync", "Word External", "Word Header",
+	  "SMPTE", "Digital1", "Auto", "Network", "Invalid",
+	  "Prev Module",
+	  "Digital2", "Digital3", "Digital4", "Digital5",
+	  "Digital6", "Digital7", "Digital8"};
 
 static int snd_asihpi_clksrc_info(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_info *uinfo)
@@ -2528,7 +2511,7 @@ static int __devinit snd_asihpi_sampleclock_add(struct snd_card_asihpi *asihpi,
 		}
 	clkcache->count = i;
 
-	asihpi_ctl_init(&snd_control, hpi_ctl, "source");
+	asihpi_ctl_init(&snd_control, hpi_ctl, "Source");
 	snd_control.access = SNDRV_CTL_ELEM_ACCESS_READWRITE ;
 	snd_control.info = snd_asihpi_clksrc_info;
 	snd_control.get = snd_asihpi_clksrc_get;
@@ -2538,7 +2521,7 @@ static int __devinit snd_asihpi_sampleclock_add(struct snd_card_asihpi *asihpi,
 
 
 	if (clkcache->has_local) {
-		asihpi_ctl_init(&snd_control, hpi_ctl, "local_rate");
+		asihpi_ctl_init(&snd_control, hpi_ctl, "Localrate");
 		snd_control.access = SNDRV_CTL_ELEM_ACCESS_READWRITE ;
 		snd_control.info = snd_asihpi_clklocal_info;
 		snd_control.get = snd_asihpi_clklocal_get;
@@ -2549,7 +2532,7 @@ static int __devinit snd_asihpi_sampleclock_add(struct snd_card_asihpi *asihpi,
 			return -EINVAL;
 	}
 
-	asihpi_ctl_init(&snd_control, hpi_ctl, "rate");
+	asihpi_ctl_init(&snd_control, hpi_ctl, "Rate");
 	snd_control.access =
 	    SNDRV_CTL_ELEM_ACCESS_VOLATILE | SNDRV_CTL_ELEM_ACCESS_READ;
 	snd_control.info = snd_asihpi_clkrate_info;
@@ -2571,7 +2554,7 @@ static int __devinit snd_card_asihpi_mixer_new(struct snd_card_asihpi *asihpi)
 
 	if (snd_BUG_ON(!asihpi))
 		return -EINVAL;
-	strcpy(card->mixername, "asihpi mixer");
+	strcpy(card->mixername, "Asihpi Mixer");
 
 	err =
 	    hpi_mixer_open(ss, asihpi->adapter_index,
@@ -2597,7 +2580,7 @@ static int __devinit snd_card_asihpi_mixer_new(struct snd_card_asihpi *asihpi)
 			if (err == HPI_ERROR_CONTROL_DISABLED) {
 				if (mixer_dump)
 					snd_printk(KERN_INFO
-						   "disabled HPI control(%d)\n",
+						   "Disabled HPI Control(%d)\n",
 						   idx);
 				continue;
 			} else
@@ -2662,7 +2645,7 @@ static int __devinit snd_card_asihpi_mixer_new(struct snd_card_asihpi *asihpi)
 		default:
 			if (mixer_dump)
 				snd_printk(KERN_INFO
-					"untranslated HPI control"
+					"Untranslated HPI Control"
 					"(%d) %d %d %d %d %d\n",
 					idx,
 					hpi_ctl.control_type,
@@ -2841,7 +2824,7 @@ static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 		if (err < 0)
 			return err;
 		snd_printk(KERN_WARNING
-			"**** WARNING **** adapter index %d->ALSA index %d\n",
+			"**** WARNING **** Adapter index %d->ALSA index %d\n",
 			hpi_card->index, card->number);
 	}
 
@@ -2859,7 +2842,7 @@ static int __devinit snd_asihpi_probe(struct pci_dev *pci_dev,
 	version = asihpi->version;
 	snd_printk(KERN_INFO "adapter ID=%4X index=%d num_outstreams=%d "
 			"num_instreams=%d S/N=%d\n"
-			"hw version %c%d DSP code version %03d\n",
+			"Hw Version %c%d DSP code version %03d\n",
 			asihpi->type, asihpi->adapter_index,
 			asihpi->num_outstreams,
 			asihpi->num_instreams, asihpi->serial_number,
-- 
1.7.0.4
