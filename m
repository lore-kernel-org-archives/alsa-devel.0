From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK plugin 1/4] jack: Do not Xrun the ALSA
	buffer
Date: Thu, 1 Mar 2018 14:14:05 +0100
Message-ID: <1519910048-19732-2-git-send-email-twischer@de.adit-jv.com>
References: <s5hd10qyg05.wl-tiwai@suse.de>
 <1519910048-19732-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id A4A6926732A
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 14:14:52 +0100 (CET)
In-Reply-To: <1519910048-19732-1-git-send-email-twischer@de.adit-jv.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

when the JACK thread is requesting too many audio frames

Playback:
Without this commit the ALSA audio buffer
will be played with endless repeats as long as the user application
has not provided new audio data.
Therefore this garbage will be played as long as the user application
has not called snd_pcm_stop() after an Xrun.
With this fix the rest of the JACK buffer will be filled
with silence.

Capture:
Without this commit the audio data in the ALSA buffer would be
overwritten.
With this commit the new data from the JACK buffer
will not be copied.
Therefore the existing data in the ALSA buffer
will not be overwritten.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index c547cbb..c3ed9fb 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -54,6 +54,68 @@ typedef struct {
 
 static int snd_pcm_jack_stop(snd_pcm_ioplug_t *io);
 
+
+static inline snd_pcm_uframes_t snd_pcm_jack_playback_avail(const snd_pcm_ioplug_t* const io,
+                                                            const snd_pcm_uframes_t hw_ptr,
+                                                            const snd_pcm_uframes_t appl_ptr)
+{
+	const snd_pcm_jack_t* const jack = io->private_data;
+
+	/* cannot use io->hw_ptr without calling snd_pcm_avail_update()
+	 * because it is not guranteed that snd_pcm_jack_pointer() was already
+	 * called
+	 */
+	snd_pcm_sframes_t avail;
+	avail = hw_ptr + io->buffer_size - appl_ptr;
+	if (avail < 0)
+		avail += jack->boundary;
+	else if ((snd_pcm_uframes_t) avail >= jack->boundary)
+		avail -= jack->boundary;
+	return avail;
+}
+
+static inline snd_pcm_uframes_t snd_pcm_jack_capture_avail(const snd_pcm_ioplug_t* const io,
+                                                           const snd_pcm_uframes_t hw_ptr,
+                                                           const snd_pcm_uframes_t appl_ptr)
+{
+	const snd_pcm_jack_t* const jack = io->private_data;
+
+	/* cannot use io->hw_ptr without calling snd_pcm_avail_update()
+	 * because it is not guranteed that snd_pcm_jack_pointer() was already
+	 * called
+	 */
+	snd_pcm_sframes_t avail;
+	avail = hw_ptr - appl_ptr;
+	if (avail < 0)
+		avail += jack->boundary;
+	return avail;
+}
+
+static inline snd_pcm_uframes_t snd_pcm_jack_avail(const snd_pcm_ioplug_t* const io,
+                                                   const snd_pcm_uframes_t hw_ptr,
+                                                   const snd_pcm_uframes_t appl_ptr)
+{
+	return (io->stream == SND_PCM_STREAM_PLAYBACK) ?
+	                        snd_pcm_jack_playback_avail(io, hw_ptr, appl_ptr) :
+	                        snd_pcm_jack_capture_avail(io, hw_ptr, appl_ptr);
+}
+
+static inline snd_pcm_uframes_t snd_pcm_jack_hw_avail(const snd_pcm_ioplug_t* const io,
+                                                      const snd_pcm_uframes_t hw_ptr,
+                                                      const snd_pcm_uframes_t appl_ptr)
+{
+	/* available data/space which can be transfered by the user application */
+	const snd_pcm_uframes_t user_avail = snd_pcm_jack_avail(io, hw_ptr,
+	                                                        appl_ptr);
+
+	if (user_avail > io->buffer_size) {
+		/* there was an Xrun */
+		return 0;
+	}
+	/* available data/space which can be transfered by the DMA */
+	return io->buffer_size - user_avail;
+}
+
 static int pcm_poll_block_check(snd_pcm_ioplug_t *io)
 {
 	static char buf[32];
@@ -144,7 +206,6 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 {
 	snd_pcm_jack_t *jack = io->private_data;
 	snd_pcm_uframes_t hw_ptr;
-	const snd_pcm_channel_area_t *areas;
 	snd_pcm_uframes_t xfer = 0;
 	unsigned int channel;
 	
@@ -154,40 +215,57 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 		jack->areas[channel].first = 0;
 		jack->areas[channel].step = jack->sample_bits;
 	}
-		
-	if (io->state != SND_PCM_STATE_RUNNING) {
-		if (io->stream == SND_PCM_STREAM_PLAYBACK) {
-			for (channel = 0; channel < io->channels; channel++)
-				snd_pcm_area_silence(&jack->areas[channel], 0, nframes, io->format);
-			return 0;
-		}
-	}
 
 	hw_ptr = jack->hw_ptr;
-	areas = snd_pcm_ioplug_mmap_areas(io);
-
-	while (xfer < nframes) {
-		snd_pcm_uframes_t frames = nframes - xfer;
-		snd_pcm_uframes_t offset = hw_ptr % io->buffer_size;
-		snd_pcm_uframes_t cont = io->buffer_size - offset;
-
-		if (cont < frames)
-			frames = cont;
+	if (io->state == SND_PCM_STATE_RUNNING) {
+		const snd_pcm_channel_area_t *areas = snd_pcm_ioplug_mmap_areas(io);
+
+		while (xfer < nframes) {
+			snd_pcm_uframes_t frames = nframes - xfer;
+			snd_pcm_uframes_t offset = hw_ptr % io->buffer_size;
+			snd_pcm_uframes_t cont = io->buffer_size - offset;
+			snd_pcm_uframes_t hw_avail =
+			                snd_pcm_jack_hw_avail(io, hw_ptr,
+			                                      io->appl_ptr);
+
+			/* stop copying if there is no more data available */
+			if (hw_avail <= 0)
+				break;
+
+			/* split the snd_pcm_area_copy() function into two parts
+			 * if the data to copy passes the buffer wrap around
+			 */
+			if (cont < frames)
+				frames = cont;
+
+			if (hw_avail < frames)
+				frames = hw_avail;
+
+			for (channel = 0; channel < io->channels; channel++) {
+				if (io->stream == SND_PCM_STREAM_PLAYBACK)
+					snd_pcm_area_copy(&jack->areas[channel], xfer, &areas[channel], offset, frames, io->format);
+				else
+					snd_pcm_area_copy(&areas[channel], offset, &jack->areas[channel], xfer, frames, io->format);
+			}
 
-		for (channel = 0; channel < io->channels; channel++) {
-			if (io->stream == SND_PCM_STREAM_PLAYBACK)
-				snd_pcm_area_copy(&jack->areas[channel], xfer, &areas[channel], offset, frames, io->format);
-			else
-				snd_pcm_area_copy(&areas[channel], offset, &jack->areas[channel], xfer, frames, io->format);
+			hw_ptr += frames;
+			if (hw_ptr >= jack->boundary)
+				hw_ptr -= jack->boundary;
+			xfer += frames;
 		}
-		
-		hw_ptr += frames;
-		if (hw_ptr >= jack->boundary)
-			hw_ptr -= jack->boundary;
-		xfer += frames;
 	}
 	jack->hw_ptr = hw_ptr;
 
+	/* check if requested frames were copied */
+	if (xfer < nframes) {
+		/* always fill the not yet written JACK buffer with silence */
+		if (io->stream == SND_PCM_STREAM_PLAYBACK) {
+			const snd_pcm_uframes_t samples = nframes - xfer;
+			for (channel = 0; channel < io->channels; channel++)
+				snd_pcm_area_silence(&jack->areas[channel], xfer, samples, io->format);
+		}
+	}
+
 	pcm_poll_unblock_check(io); /* unblock socket for polling if needed */
 
 	return 0;
-- 
2.7.4
