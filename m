From: Eliot Blennerhassett <linux@audioscience.com>
Subject: [PATCH] asihpi unify play/capture timer functions
Date: Thu, 09 Aug 2007 14:30:37 +1200
Message-ID: <200708091430.37094.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed; boundary="Boundary-00=_NxnuGuKGtijoqxm"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 0106B103890
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Aug 2007 04:30:06 +0200 (CEST)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JMH00ESBIXI4Q00@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 09 Aug 2007 14:29:43 +1200 (NZST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_NxnuGuKGtijoqxm
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Unify the playback and capture timer function.   A group of linked streams 
only uses one timer.
Cope with linked streams on more than one card (untested)

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>


--Boundary-00=_NxnuGuKGtijoqxm
Content-Type: text/x-diff;
  charset="utf-8";
  name="asihpi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="asihpi.patch"

diff -r 74474638024b pci/asihpi/asihpi.c
--- a/pci/asihpi/asihpi.c	Mon Aug 06 13:50:08 2007 +0200
+++ b/pci/asihpi/asihpi.c	Thu Aug 09 14:27:58 2007 +1200
@@ -95,11 +95,9 @@ static HPI_HSUBSYS *phSubSys;	/* handle 
 static HPI_HSUBSYS *phSubSys;	/* handle to HPI audio subsystem */
 
 /* defaults */
-#ifndef MAX_BUFFER_SIZE
-#define MAX_BUFFER_SIZE		(256*1024)
-#endif
-
-#define PRELOAD_PERIODS 2
+#define PERIODS_MIN 2
+#define PERIOD_BYTES_MIN  2304
+#define BUFFER_BYTES_MAX	(128*1024)
 
 /*#define TIMER_MILLISECONDS 20
 #define FORCE_TIMER_JIFFIES ((TIMER_MILLISECONDS * HZ + 999)/1000)
@@ -229,12 +227,12 @@ static inline u16 HPI_StreamGetInfoEx(HP
 {
 	if (HPI_HandleObject(hStream) == HPI_OBJ_OSTREAM)
 		return HPI_OutStreamGetInfoEx(hS, hStream, pwState,
+					      pdwBufferSize, pdwDataInBuffer,
+					      pdwSampleCount, pdwAuxiliaryData);
+	else
+		return HPI_InStreamGetInfoEx(hS, hStream, pwState,
 					     pdwBufferSize, pdwDataInBuffer,
 					     pdwSampleCount, pdwAuxiliaryData);
-	else
-		return HPI_InStreamGetInfoEx(hS, hStream, pwState,
-					      pdwBufferSize, pdwDataInBuffer,
-					      pdwSampleCount, pdwAuxiliaryData);
 }
 
 static inline u16 HPI_StreamGroupAdd(HPI_HSUBSYS * hS, HPI_HSTREAM hMaster,
@@ -383,7 +381,7 @@ static int snd_card_asihpi_pcm_hw_params
 				   "StreamHostBufferAttach succeeded\n");
 		} else {
 			snd_printd(KERN_INFO
-				   "StreamHostBufferAttach error(%d)\n", err);
+				   "StreamHostBufferAttach error %d\n", err);
 			return -ENOMEM;
 		}
 
@@ -391,10 +389,9 @@ static int snd_card_asihpi_pcm_hw_params
 					  &dpcm->hpi_buffer_attached, NULL,
 					  NULL, NULL);
 
-		snd_printd(KERN_INFO "StreamHostBufferAttach status(%d)\n",
+		snd_printd(KERN_INFO "StreamHostBufferAttach status 0x%x\n",
 			   dpcm->hpi_buffer_attached);
 	}
-
 	bytes_per_sec = params_rate(params) * params_channels(params);
 	bytes_per_sec *= snd_pcm_format_width(params_format(params));
 	bytes_per_sec /= 8;
@@ -404,7 +401,7 @@ static int snd_card_asihpi_pcm_hw_params
 	dpcm->bytes_per_sec = bytes_per_sec;
 	dpcm->pcm_size = params_buffer_bytes(params);
 	dpcm->pcm_count = params_period_bytes(params);
-	snd_printd(KERN_INFO "pcm_size %d, pcm_count %d\n",
+	snd_printd(KERN_INFO "pcm_size x%x, pcm_count x%x\n",
 		   dpcm->pcm_size, dpcm->pcm_count);
 
 #ifdef FORCE_TIMER_JIFFIES
@@ -455,26 +452,35 @@ static int snd_card_asihpi_trigger(struc
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		snd_pcm_group_for_each_entry(s, substream) {
-			struct snd_card_asihpi_pcm *ds;
+			struct snd_card_asihpi_pcm *ds =
+			    s->runtime->private_data;
 
 			if (snd_pcm_substream_chip(s) != card)
 				continue;
 
-			ds = s->runtime->private_data;
-
-			snd_card_asihpi_pcm_timer_start(s);
-
 			if (s->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 				if (card->support_mmap) {
-					HPI_OutStreamWriteBuf(phSubSys, ds->hStream, &s->runtime->dma_area[0], ds->pcm_size,	/* entire buffer preload?? */
-							      /*ds->pcm_count*PRELOAD_PERIODS, */
+					/* How do I know how much valid data is present in buffer?
+					 * Just guessing 2 periods, but if buffer is bigger it may
+					 * contain even more data
+					 */
+					unsigned int preload =
+					    ds->pcm_count * 2;
+					VPRINTK2("Preload x%x\n", preload);
+					HPI_OutStreamWriteBuf(phSubSys,
+							      ds->hStream,
+							      &s->runtime->
+							      dma_area[0],
+							      preload,
 							      &ds->Format);
+					ds->pcm_irq_pos =
+					    ds->pcm_irq_pos + preload;
 				}
 			}
 
 			if (card->support_grouping) {
-				snd_printd("\tGroup %dstream %d\n", s->stream,
-					   s->number);
+				VPRINTK1("\tGroup %dstream %d\n", s->stream,
+					 s->number);
 				e = HPI_HandleError(HPI_StreamGroupAdd
 						    (phSubSys, dpcm->hStream,
 						     ds->hStream));
@@ -487,20 +493,22 @@ static int snd_card_asihpi_trigger(struc
 		}
 		snd_printd("Start\n");
 		/* start the master stream */
+		snd_card_asihpi_pcm_timer_start(substream);
 		HPI_HandleError(HPI_StreamStart(phSubSys, dpcm->hStream));
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
+		snd_card_asihpi_pcm_timer_stop(substream);
 		snd_pcm_group_for_each_entry(s, substream) {
 			if (snd_pcm_substream_chip(s) != card)
 				continue;
-			snd_card_asihpi_pcm_timer_stop(s);
+
 			/*? workaround linked streams don't transition to SETUP 20070706 */
 			s->runtime->status->state = SNDRV_PCM_STATE_SETUP;
 
 			if (card->support_grouping) {
-				snd_printd("\tGroup %dstream %d\n", s->stream,
-					   s->number);
+				VPRINTK1("\tGroup %dstream %d\n", s->stream,
+					 s->number);
 				snd_pcm_trigger_done(s, substream);
 			} else
 				break;
@@ -554,66 +562,154 @@ static void snd_card_asihpi_runtime_free
 }
 
 /***************************** PLAYBACK OPS ****************/
-static void snd_card_asihpi_playback_timer_function(unsigned long data)
+
+#if 0
+/*algorithm outline
+ Without linking degenerates to getting single stream pos etc
+ Without mmap 2nd loop degenerates to snd_pcm_period_elapsed
+*/
+/*
+buf_pos=get_buf_pos(s);
+for_each_linked_stream(s) {
+	buf_pos=get_buf_pos(s);
+	min_buf_pos = modulo_min(min_buf_pos, buf_pos, pcm_size)
+	new_data = min(new_data, calc_new_data(buf_pos,irq_pos)
+}
+timer.expires = jiffies + predict_next_period_ready(min_buf_pos);
+for_each_linked_stream(s) {
+	s->buf_pos = min_buf_pos;
+	if (new_data > pcm_count) {
+		if (mmap) {
+			irq_pos = (irq_pos + pcm_count) % pcm_size;
+			if (playback) {
+				write(pcm_count);
+			} else {
+				read(pcm_count);
+			}
+		}
+		snd_pcm_period_elapsed(s);
+	}
+}
+*/
+#endif
+
+/** Minimum of 2 modulo values.  Works correctly when the difference between
+* the values is less than half the modulus
+*/
+static inline unsigned int modulo_min(unsigned int a, unsigned int b,
+				      unsigned long int modulus)
+{
+	unsigned int result;
+	if (((a - b) % modulus) < (modulus / 2))
+		result = b;
+	else
+		result = a;
+
+	return result;
+}
+
+/** Timer function, equivalent to interrupt service routine for cards
+*/
+static void snd_card_asihpi_timer_function(unsigned long data)
 {
 	struct snd_card_asihpi_pcm *dpcm = (struct snd_card_asihpi_pcm *)data;
 	struct snd_card_asihpi *card = snd_pcm_substream_chip(dpcm->substream);
-	struct snd_pcm_runtime *runtime = dpcm->substream->runtime;
-
-	unsigned int newdata;
-	unsigned int remdata;
-	unsigned int writedata;
-	u16 wState, err;
-	u32 dwBufferSize;
-	u32 dwDataToPlay;
-	u32 dwSamplesPlayed;
-	u32 dwAux;
-	unsigned int next_jiffies;
-
-	err = HPI_OutStreamGetInfoEx(phSubSys, dpcm->hStream, &wState,
-				     &dwBufferSize, &dwDataToPlay,
-				     &dwSamplesPlayed, &dwAux);
-	HPI_HandleError(err);
-
-	VPRINTK1(KERN_DEBUG
-		 "%d state=%d, played=%d, left=%d, aux=%d\n",
-		 dpcm->substream->number, wState,
-		 (int)dwSamplesPlayed, (int)dwDataToPlay, (int)dwAux);
-
-	VPRINTK1(KERN_INFO "PB timer hw_ptr %lu, appl_ptr %lu\n",
-		 runtime->status->hw_ptr, runtime->control->appl_ptr);
-
-	if ((wState == HPI_STATE_DRAINED)) {
-		snd_printd(KERN_WARNING "OStream %d drained\n",
-			   dpcm->substream->number);
-		snd_pcm_stop(dpcm->substream, SNDRV_PCM_STATE_XRUN);
-	}
-	dpcm->pcm_buf_pos = frames_to_bytes(runtime, dwSamplesPlayed);
-	newdata = (dpcm->pcm_buf_pos - dpcm->pcm_irq_pos) % dpcm->pcm_size;
+	struct snd_pcm_runtime *runtime;
+	struct snd_pcm_substream *s;
+	unsigned int newdata = 0;
+	unsigned int buf_pos, min_buf_pos = 0;
+	unsigned int remdata, xfercount, next_jiffies;
+	int first = 1;
+	u16 wState;
+	u32 dwBufferSize, dwDataAvail, dwSamplesPlayed, dwAux;
+
+	/* check all streams of the group, find minimum newdata and buffer pos */
+	snd_pcm_group_for_each_entry(s, dpcm->substream) {
+		struct snd_card_asihpi_pcm *ds = s->runtime->private_data;
+		runtime = s->runtime;
+
+		if (snd_pcm_substream_chip(s) != card)
+			continue;
+
+		HPI_HandleError(HPI_StreamGetInfoEx(phSubSys,
+						    ds->hStream, &wState,
+						    &dwBufferSize, &dwDataAvail,
+						    &dwSamplesPlayed, &dwAux));
+
+		if (wState == HPI_STATE_DRAINED) {
+			snd_printd(KERN_WARNING "OStream %d drained\n",
+				   s->number);
+			snd_pcm_stop(s, SNDRV_PCM_STATE_XRUN);
+		}
+
+		if (s->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			buf_pos = frames_to_bytes(runtime, dwSamplesPlayed);
+		} else {
+			buf_pos = dwDataAvail + ds->pcm_irq_pos;
+		}
+
+		if (first) {	/* can't statically init min when wraparound is involved */
+			min_buf_pos = buf_pos;
+			newdata = (buf_pos - ds->pcm_irq_pos) % ds->pcm_size;
+			first = 0;
+		} else {
+			min_buf_pos =
+			    modulo_min(min_buf_pos, buf_pos, UINT_MAX + 1L);
+			newdata =
+			    min((buf_pos - ds->pcm_irq_pos) % ds->pcm_size,
+				newdata);
+		}
+
+		VPRINTK1("PB timer hw_ptr x%04lX, appl_ptr x%04lX ",
+			 (unsigned long)frames_to_bytes(runtime,
+							runtime->status->
+							hw_ptr),
+			 (unsigned long)frames_to_bytes(runtime,
+							runtime->control->
+							appl_ptr));
+		VPRINTK1
+		    ("%d S=%d, irq=%04X, pos=x%04X, left=x%04X, aux=x%04X space=x%04X\n",
+		     s->number, wState, ds->pcm_irq_pos, buf_pos,
+		     (int)dwDataAvail, (int)dwAux, dwBufferSize - dwDataAvail);
+	}
+
 	remdata = newdata % dpcm->pcm_count;
-	writedata = newdata - remdata;
-
+	xfercount = newdata - remdata;	/* a multiple of pcm_count */
 	next_jiffies =
 	    ((dpcm->pcm_count - remdata) * HZ / dpcm->bytes_per_sec) + 1;
-	next_jiffies = max(next_jiffies, 4U * HZ / 1000U);
+	next_jiffies = max(next_jiffies, 2U * HZ / 1000U);
 	dpcm->timer.expires = jiffies + next_jiffies;
-
-	if (dpcm->respawn_timer)
+	VPRINTK1("jif %d buf pos x%04X newdata x%04X\n", next_jiffies,
+		 min_buf_pos, newdata);
+
+	snd_pcm_group_for_each_entry(s, dpcm->substream) {
+		struct snd_card_asihpi_pcm *ds = s->runtime->private_data;
+		ds->pcm_buf_pos = min_buf_pos;
+
+		if (xfercount) {
+			if (card->support_mmap) {
+				ds->pcm_irq_pos = ds->pcm_irq_pos + xfercount;
+				if (s->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+					VPRINTK2("Write OS%d x%04x\n",
+						 s->number, ds->pcm_count);
+					HPI_HandleError(HPI_OutStreamWriteBuf
+							(phSubSys, ds->hStream,
+							 NULL, xfercount,
+							 &ds->Format));
+				} else {
+					VPRINTK2("Read IS%d x%04x\n", s->number,
+						 dpcm->pcm_count);
+					HPI_HandleError(HPI_InStreamReadBuf
+							(phSubSys, ds->hStream,
+							 NULL, xfercount));
+				}
+			}	/* else R/W will be handled by read/write callbacks */
+			snd_pcm_period_elapsed(s);
+		}
+	}
+
+	if (dpcm->respawn_timer) {
 		add_timer(&dpcm->timer);
-	VPRINTK1(KERN_DEBUG "%d %d respawn %d\n", newdata, remdata,
-		 next_jiffies);
-
-	/*snd_printd(KERN_INFO "newdata=%d irq=%d buf=%d\n",newdata,dpcm->pcm_irq_pos,dpcm->pcm_buf_pos); */
-	if (newdata >= dpcm->pcm_count) {
-		if (card->support_mmap) {
-			VPRINTK2("OSW %d\n", writedata);
-			HPI_HandleError(HPI_OutStreamWriteBuf
-					(phSubSys, dpcm->hStream, NULL,
-					 writedata, &dpcm->Format));
-		}
-		dpcm->pcm_irq_pos = dpcm->pcm_irq_pos + writedata;
-		/* snd_printd(KERN_INFO "Period_elapsed irq=%d buf=%d\n",dpcm->pcm_irq_pos,dpcm->pcm_buf_pos); */
-		snd_pcm_period_elapsed(dpcm->substream);
 	}
 }
 
@@ -647,19 +743,22 @@ snd_card_asihpi_playback_pointer(struct 
 	u32 dwSamplesPlayed;
 	u16 err;
 
-	/* NOTE, can use samples played for playback position here and in timer fn
-	   because it LAGS the actual read pointer, and is a better representation
-	   of actual playout position
-	 */
-	err = HPI_OutStreamGetInfoEx(phSubSys, dpcm->hStream, NULL,
-				     NULL, NULL, &dwSamplesPlayed, NULL);
-	HPI_HandleError(err);
-
-	dpcm->pcm_buf_pos =
-	    (frames_to_bytes(runtime, dwSamplesPlayed)) % dpcm->pcm_size;
-
-	ptr = bytes_to_frames(runtime, dpcm->pcm_buf_pos);
-	VPRINTK2("Playback ptr %d\n", ptr);
+	if (!snd_pcm_stream_linked(substream)) {
+		/* NOTE, can use samples played for playback position here and in timer fn
+		   because it LAGS the actual read pointer, and is a better representation
+		   of actual playout position
+		 */
+		err = HPI_OutStreamGetInfoEx(phSubSys, dpcm->hStream, NULL,
+					     NULL, NULL,
+					     &dwSamplesPlayed, NULL);
+		HPI_HandleError(err);
+
+		dpcm->pcm_buf_pos = frames_to_bytes(runtime, dwSamplesPlayed);
+	}
+	/* else must return most conservative value found in timer func looping over all streams */
+
+	ptr = bytes_to_frames(runtime, dpcm->pcm_buf_pos % dpcm->pcm_size);
+	VPRINTK2("Playback ptr x%04lx\n", (unsigned long)ptr);
 	return ptr;
 }
 
@@ -697,11 +796,11 @@ static struct snd_pcm_hardware snd_card_
 static struct snd_pcm_hardware snd_card_asihpi_playback = {
 	.channels_min = 1,
 	.channels_max = 2,
-	.buffer_bytes_max = MAX_BUFFER_SIZE,
-	.period_bytes_min = 768,
-	.period_bytes_max = MAX_BUFFER_SIZE / PRELOAD_PERIODS,
-	.periods_min = PRELOAD_PERIODS,
-	.periods_max = MAX_BUFFER_SIZE / 768,
+	.buffer_bytes_max = BUFFER_BYTES_MAX,
+	.period_bytes_min = PERIOD_BYTES_MIN,
+	.period_bytes_max = BUFFER_BYTES_MAX / PERIODS_MIN,
+	.periods_min = PERIODS_MIN,
+	.periods_max = BUFFER_BYTES_MAX / PERIOD_BYTES_MIN,
 	.fifo_size = 0,
 };
 
@@ -734,7 +833,7 @@ static int snd_card_asihpi_playback_open
 
 	init_timer(&dpcm->timer);
 	dpcm->timer.data = (unsigned long)dpcm;
-	dpcm->timer.function = snd_card_asihpi_playback_timer_function;
+	dpcm->timer.function = snd_card_asihpi_timer_function;
 	dpcm->substream = substream;
 	runtime->private_data = dpcm;
 	runtime->private_free = snd_card_asihpi_runtime_free;
@@ -747,9 +846,14 @@ static int snd_card_asihpi_playback_open
 	snd_card_asihpi_playback.rate_max = 192000;
 	snd_card_asihpi_playback.info =
 	    SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_PAUSE;
+
 	if (card->support_mmap)
 		snd_card_asihpi_playback.info |=
 		    SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID;
+
+	if (card->support_grouping)
+		snd_card_asihpi_playback.info |= SNDRV_PCM_INFO_SYNC_START;
+
 	/* struct copy so can create initializer dynamically */
 	runtime->hw = snd_card_asihpi_playback;
 	/* make buffer size a power of 2. Strictly only necessary for HPI6205 adapters */
@@ -842,111 +946,19 @@ static struct snd_pcm_ops snd_card_asihp
 };
 
 /***************************** CAPTURE OPS ****************/
-static void snd_card_asihpi_capture_timer_function(unsigned long data)
-{
-	struct snd_card_asihpi_pcm *dpcm = (struct snd_card_asihpi_pcm *)data;
-	u16 wState, err;
-	u32 dwBufferSize, dwDataAvail, dwSamplesPlayed, dwAux;
-	u32 next_jiffies;
-
-	err =
-	    HPI_InStreamGetInfoEx(phSubSys, dpcm->hStream, &wState,
-				  &dwBufferSize, &dwDataAvail,
-				  &dwSamplesPlayed, &dwAux);
-	HPI_HandleError(err);
-
-	/* Used by capture_pointer */
-	dpcm->pcm_buf_pos = (dpcm->pcm_irq_pos + dwDataAvail) % dpcm->pcm_size;
-
-	VPRINTK1("Capture timer%d %d samples, %d left, pos %d, aux %d\n",
-		 dpcm->substream->number, (int)dwSamplesPlayed,
-		 (int)dwDataAvail, dpcm->pcm_buf_pos, dwAux);
-
-	/* schedule next timer when next complete period estimated to be available */
-	next_jiffies =
-	    ((dpcm->pcm_count -
-	      (dwDataAvail % dpcm->pcm_count)) * HZ / dpcm->bytes_per_sec) + 1;
-	/* minimum 4ms interval */
-	next_jiffies = max(next_jiffies, 4U * HZ / 1000U);
-	VPRINTK2("Cap next jiffies %d\n", next_jiffies);
-	dpcm->timer.expires = jiffies + next_jiffies;
-
-	if (dpcm->respawn_timer)
-		add_timer(&dpcm->timer);
-
-	if (dwDataAvail >= dpcm->pcm_count) {
-		snd_pcm_period_elapsed(dpcm->substream);
-	}
-}
-
-static void snd_card_asihpi_capture_timer_mmap_function(unsigned long data)
-{
-	struct snd_card_asihpi_pcm *dpcm = (struct snd_card_asihpi_pcm *)data;
-	u16 wState;
-	u32 dwBufferSize, dwDataAvail, dwSamplesPlayed, dwAux;
-
-	HPI_HandleError(HPI_InStreamGetInfoEx(phSubSys, dpcm->hStream, &wState,
-					      &dwBufferSize, &dwDataAvail,
-					      &dwSamplesPlayed, &dwAux));
-
-	/* If data is left over, make timer expire sooner  */
-	dpcm->timer.expires =
-	    ((dpcm->pcm_count -
-	      (dwDataAvail % dpcm->pcm_count)) * HZ / dpcm->bytes_per_sec) + 1 +
-	    jiffies;
-
-	if (dpcm->respawn_timer)
-		add_timer(&dpcm->timer);
-
-	if (dwDataAvail >= dpcm->pcm_count) {
-		struct snd_pcm_runtime *runtime = dpcm->substream->runtime;
-		size_t bs, len1, len2;
-
-		bs = frames_to_bytes(runtime, runtime->buffer_size);
-		len1 = bs - dpcm->pcm_buf_pos;
-
-		if (len1 >= dpcm->pcm_count) {
-			len1 = dpcm->pcm_count;
-			len2 = 0;
-		} else {
-			len2 = dpcm->pcm_count - len1;
-		}
-
-		VPRINTK2("ISR %d ", len1);
-		HPI_HandleError(HPI_InStreamReadBuf(phSubSys, dpcm->hStream,
-						    &runtime->dma_area[dpcm->
-								       pcm_buf_pos],
-						    len1));
-		if (len2) {
-
-			VPRINTK2("ISR %d \n", len2);
-			HPI_HandleError(HPI_InStreamReadBuf
-					(phSubSys, dpcm->hStream,
-					 &runtime->dma_area[0], len2));
-		} else {
-			VPRINTK2("\n");
-		}
-
-		/* Used by capture_pointer */
-		dpcm->pcm_buf_pos =
-		    (dpcm->pcm_buf_pos + dpcm->pcm_count) % dpcm->pcm_size;
-		snd_pcm_period_elapsed(dpcm->substream);
-	}
-}
-
 static snd_pcm_uframes_t
 snd_card_asihpi_capture_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
 
-	VPRINTK3("Capture pointer%d %d\n", substream->number,
+	VPRINTK3("Capture pointer%d x%04x\n", substream->number,
 		 dpcm->pcm_buf_pos);
-	/* NOTE (unlike playback) it is problematic to use actual 'dwSamplesPlayed
+	/* NOTE Unlike playback can't use actual dwSamplesPlayed
 	   for the capture position, because those samples aren't yet in
 	   the local buffer available for reading.
 	 */
-	return bytes_to_frames(runtime, dpcm->pcm_buf_pos);
+	return bytes_to_frames(runtime, dpcm->pcm_buf_pos % dpcm->pcm_size);
 }
 
 static int snd_card_asihpi_capture_ioctl(struct snd_pcm_substream *substream,
@@ -1000,11 +1012,11 @@ static struct snd_pcm_hardware snd_card_
 static struct snd_pcm_hardware snd_card_asihpi_capture = {
 	.channels_min = 1,
 	.channels_max = 2,
-	.buffer_bytes_max = MAX_BUFFER_SIZE / 2,
-	.period_bytes_min = 768,
-	.period_bytes_max = MAX_BUFFER_SIZE / 4,
-	.periods_min = 2,
-	.periods_max = MAX_BUFFER_SIZE / (2 * 768),
+	.buffer_bytes_max = BUFFER_BYTES_MAX,
+	.period_bytes_min = PERIOD_BYTES_MIN,
+	.period_bytes_max = BUFFER_BYTES_MAX / PERIODS_MIN,
+	.periods_min = PERIODS_MIN,
+	.periods_max = BUFFER_BYTES_MAX / PERIOD_BYTES_MIN,
 	.fifo_size = 0,
 };
 
@@ -1034,11 +1046,7 @@ static int snd_card_asihpi_capture_open(
 
 	init_timer(&dpcm->timer);
 	dpcm->timer.data = (unsigned long)dpcm;
-	if (card->support_mmap)
-		dpcm->timer.function =
-		    snd_card_asihpi_capture_timer_mmap_function;
-	else
-		dpcm->timer.function = snd_card_asihpi_capture_timer_function;
+	dpcm->timer.function = snd_card_asihpi_timer_function;
 	dpcm->substream = substream;
 	runtime->private_data = dpcm;
 	runtime->private_free = snd_card_asihpi_runtime_free;
@@ -1089,7 +1097,7 @@ static int snd_card_asihpi_capture_copy(
 					    runtime->dma_area, dwDataSize));
 
 	/* Used by capture_pointer */
-	dpcm->pcm_irq_pos = (dpcm->pcm_irq_pos + dwDataSize) % dpcm->pcm_size;
+	dpcm->pcm_irq_pos = dpcm->pcm_irq_pos + dwDataSize;
 
 	if (copy_to_user(dst, runtime->dma_area, dwDataSize))
 		return -EFAULT;
@@ -1152,7 +1160,7 @@ static int __devinit snd_card_asihpi_pcm
    MMAP emulation - WHY NOT? */
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_pci_data(asihpi->pci),
-					      64 * 1024, MAX_BUFFER_SIZE);
+					      64 * 1024, BUFFER_BYTES_MAX);
 
 	return 0;
 }

--Boundary-00=_NxnuGuKGtijoqxm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_NxnuGuKGtijoqxm--
