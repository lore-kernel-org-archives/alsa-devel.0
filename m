From: eliot@blennerhassett.gen.nz
Subject: [PATCH 03/10] ALSA: asihpi: Logging format improvements
Date: Thu, 20 Nov 2014 16:22:50 +1300
Message-ID: <1416453777-7155-4-git-send-email-eliot@blennerhassett.gen.nz>
References: <1416453777-7155-1-git-send-email-eliot@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A704265864
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 04:25:41 +0100 (CET)
Received: from mxin1-orange.clear.net.nz
 (lb2-srcnat.clear.net.nz [203.97.32.237])
 by smtp5.clear.net.nz (CLEAR Net Mail)
 with ESMTP id <0NFB00DHKIUMR640@smtp5.clear.net.nz> for
 alsa-devel@alsa-project.org; Thu, 20 Nov 2014 16:25:40 +1300 (NZDT)
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

Signed-off-by: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
---
 sound/pci/asihpi/asihpi.c | 85 ++++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 46 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index dc49bea..0752ba7 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -288,21 +288,17 @@ static void print_hwparams(struct snd_pcm_substream *substream,
 {
 	char name[16];
 	snd_pcm_debug_name(substream, name, sizeof(name));
-	snd_printd("%s HWPARAMS\n", name);
-	snd_printd(" samplerate %d Hz\n", params_rate(p));
-	snd_printd(" channels %d\n", params_channels(p));
-	snd_printd(" format %d\n", params_format(p));
-	snd_printd(" subformat %d\n", params_subformat(p));
-	snd_printd(" buffer %d B\n", params_buffer_bytes(p));
-	snd_printd(" period %d B\n", params_period_bytes(p));
-	snd_printd(" access %d\n", params_access(p));
-	snd_printd(" period_size %d\n", params_period_size(p));
-	snd_printd(" periods %d\n", params_periods(p));
-	snd_printd(" buffer_size %d\n", params_buffer_size(p));
-	snd_printd(" %d B/s\n", params_rate(p) *
-		params_channels(p) *
+	snd_printdd("%s HWPARAMS\n", name);
+	snd_printdd(" samplerate=%dHz channels=%d format=%d subformat=%d\n",
+		params_rate(p), params_channels(p),
+		params_format(p), params_subformat(p));
+	snd_printdd(" buffer=%dB period=%dB period_size=%dB periods=%d\n",
+		params_buffer_bytes(p), params_period_bytes(p),
+		params_period_size(p), params_periods(p));
+	snd_printdd(" buffer_size=%d access=%d data_rate=%dB/s\n",
+		params_buffer_size(p), params_access(p),
+		params_rate(p) * params_channels(p) *
 		snd_pcm_format_width(params_format(p)) / 8);
-
 }
 
 static snd_pcm_format_t hpi_to_alsa_formats[] = {
@@ -480,7 +476,7 @@ static int snd_card_asihpi_pcm_hw_params(struct snd_pcm_substream *substream,
 			params_buffer_bytes(params),  runtime->dma_addr);
 		if (err == 0) {
 			snd_printdd(
-				"stream_host_buffer_attach succeeded %u %lu\n",
+				"stream_host_buffer_attach success %u %lu\n",
 				params_buffer_bytes(params),
 				(unsigned long)runtime->dma_addr);
 		} else {
@@ -490,12 +486,7 @@ static int snd_card_asihpi_pcm_hw_params(struct snd_pcm_substream *substream,
 		}
 
 		err = hpi_stream_get_info_ex(dpcm->h_stream, NULL,
-						&dpcm->hpi_buffer_attached,
-						NULL, NULL, NULL);
-
-		snd_printdd("stream_host_buffer_attach status 0x%x\n",
-				dpcm->hpi_buffer_attached);
-
+				&dpcm->hpi_buffer_attached, NULL, NULL, NULL);
 	}
 	bytes_per_sec = params_rate(params) * params_channels(params);
 	width = snd_pcm_format_width(params_format(params));
@@ -563,10 +554,10 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 	char name[16];
 
 	snd_pcm_debug_name(substream, name, sizeof(name));
-	snd_printdd("%s trigger\n", name);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
+		snd_printdd("%s trigger start\n", name);
 		snd_pcm_group_for_each_entry(s, substream) {
 			struct snd_pcm_runtime *runtime = s->runtime;
 			struct snd_card_asihpi_pcm *ds = runtime->private_data;
@@ -587,7 +578,7 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 				* data??
 				*/
 				unsigned int preload = ds->period_bytes * 1;
-				snd_printddd("%d preload x%x\n", s->number, preload);
+				snd_printddd("%d preload %d\n", s->number, preload);
 				hpi_handle_error(hpi_outstream_write_buf(
 						ds->h_stream,
 						&runtime->dma_area[0],
@@ -610,7 +601,6 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 			} else
 				break;
 		}
-		snd_printdd("start\n");
 		/* start the master stream */
 		snd_card_asihpi_pcm_timer_start(substream);
 		if ((substream->stream == SNDRV_PCM_STREAM_CAPTURE) ||
@@ -619,6 +609,7 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
+		snd_printdd("%s trigger stop\n", name);
 		snd_card_asihpi_pcm_timer_stop(substream);
 		snd_pcm_group_for_each_entry(s, substream) {
 			if (snd_pcm_substream_chip(s) != card)
@@ -637,7 +628,6 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 			} else
 				break;
 		}
-		snd_printdd("stop\n");
 
 		/* _prepare and _hwparams reset the stream */
 		hpi_handle_error(hpi_stream_stop(dpcm->h_stream));
@@ -650,12 +640,12 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 		break;
 
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		snd_printdd("pause release\n");
+		snd_printdd("%s trigger pause release\n", name);
 		hpi_handle_error(hpi_stream_start(dpcm->h_stream));
 		snd_card_asihpi_pcm_timer_start(substream);
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		snd_printdd("pause\n");
+		snd_printdd("%s trigger pause push\n", name);
 		snd_card_asihpi_pcm_timer_stop(substream);
 		hpi_handle_error(hpi_stream_stop(dpcm->h_stream));
 		break;
@@ -730,7 +720,6 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 
 	snd_pcm_debug_name(substream, name, sizeof(name));
 
-	snd_printdd("%s snd_card_asihpi_timer_function\n", name);
 
 	/* find minimum newdata and buffer pos in group */
 	snd_pcm_group_for_each_entry(s, substream) {
@@ -793,19 +782,20 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 				newdata);
 		}
 
-		snd_printdd("hw_ptr 0x%04lX, appl_ptr 0x%04lX\n",
+		snd_printddd("timer1, %s, %d, S=%d, elap=%d, rw=%d, dsp=%d, left=%d, aux=%d, space=%d, hw_ptr=%ld, appl_ptr=%ld\n",
+			name, s->number, state,
+			ds->pcm_buf_elapsed_dma_ofs,
+			ds->pcm_buf_host_rw_ofs,
+			pcm_buf_dma_ofs,
+			(int)bytes_avail,
+
+			(int)on_card_bytes,
+			buffer_size-bytes_avail,
 			(unsigned long)frames_to_bytes(runtime,
 						runtime->status->hw_ptr),
 			(unsigned long)frames_to_bytes(runtime,
-						runtime->control->appl_ptr));
-
-		snd_printdd("%d S=%d, "
-			"rw=0x%04X, dma=0x%04X, left=0x%04X, "
-			"aux=0x%04X space=0x%04X\n",
-			s->number, state,
-			ds->pcm_buf_host_rw_ofs, pcm_buf_dma_ofs,
-			(int)bytes_avail,
-			(int)on_card_bytes, buffer_size-bytes_avail);
+						runtime->control->appl_ptr)
+		);
 		loops++;
 	}
 	pcm_buf_dma_ofs = min_buf_pos;
@@ -823,7 +813,7 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 
 	next_jiffies = max(next_jiffies, 1U);
 	dpcm->timer.expires = jiffies + next_jiffies;
-	snd_printdd("jif %d buf pos 0x%04X newdata 0x%04X xfer 0x%04X\n",
+	snd_printddd("timer2, jif=%d, buf_pos=%d, newdata=%d, xfer=%d\n",
 			next_jiffies, pcm_buf_dma_ofs, newdata, xfercount);
 
 	snd_pcm_group_for_each_entry(s, substream) {
@@ -855,7 +845,7 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 			}
 
 			if (s->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-				snd_printddd("P%d write1 0x%04X 0x%04X\n",
+				snd_printddd("write1, P=%d, xfer=%d, buf_ofs=%d\n",
 					s->number, xfer1, buf_ofs);
 				hpi_handle_error(
 					hpi_outstream_write_buf(
@@ -865,7 +855,7 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 				if (xfer2) {
 					pd = s->runtime->dma_area;
 
-					snd_printddd("P%d write2 0x%04X 0x%04X\n",
+					snd_printddd("write2, P=%d, xfer=%d, buf_ofs=%d\n",
 							s->number,
 							xfercount - xfer1, buf_ofs);
 					hpi_handle_error(
@@ -875,7 +865,7 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 							&ds->format));
 				}
 			} else {
-				snd_printddd("C%d read1 0x%04x\n",
+				snd_printddd("read1, C=%d, xfer=%d\n",
 					s->number, xfer1);
 				hpi_handle_error(
 					hpi_instream_read_buf(
@@ -883,7 +873,7 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 						pd, xfer1));
 				if (xfer2) {
 					pd = s->runtime->dma_area;
-					snd_printddd("C%d read2 0x%04x\n",
+					snd_printddd("read2, C=%d, xfer=%d\n",
 						s->number, xfer2);
 					hpi_handle_error(
 						hpi_instream_read_buf(
@@ -936,7 +926,7 @@ snd_card_asihpi_playback_pointer(struct snd_pcm_substream *substream)
 	snd_pcm_debug_name(substream, name, sizeof(name));
 
 	ptr = bytes_to_frames(runtime, dpcm->pcm_buf_dma_ofs  % dpcm->buffer_bytes);
-	snd_printddd("%s pointer = 0x%04lx\n", name, (unsigned long)ptr);
+	snd_printddd("%s, pointer=%ld\n", name, (unsigned long)ptr);
 	return ptr;
 }
 
@@ -1084,9 +1074,10 @@ snd_card_asihpi_capture_pointer(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_card_asihpi_pcm *dpcm = runtime->private_data;
+	char name[16];
+	snd_pcm_debug_name(substream, name, sizeof(name));
 
-	snd_printddd("capture pointer %d=%d\n",
-			substream->number, dpcm->pcm_buf_dma_ofs);
+	snd_printddd("%s, pointer=%d\n", name, dpcm->pcm_buf_dma_ofs);
 	/* NOTE Unlike playback can't use actual samples_played
 		for the capture position, because those samples aren't yet in
 		the local buffer available for reading.
@@ -2870,6 +2861,8 @@ static int snd_asihpi_probe(struct pci_dev *pci_dev,
 		asihpi->in_min_chans = 1;
 	}
 
+	snd_printk(KERN_INFO "update_interval_frames: %d",
+		asihpi->update_interval_frames);
 	snd_printk(KERN_INFO "Has dma:%d, grouping:%d, mrx:%d\n",
 			asihpi->can_dma,
 			asihpi->support_grouping,
-- 
1.9.1
