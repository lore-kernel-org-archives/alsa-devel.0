From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK 1/1] jack: Do not Xrun the ALSA buffer
Date: Tue, 13 Mar 2018 09:34:44 +0100
Message-ID: <1520930084-17449-4-git-send-email-twischer@de.adit-jv.com>
References: <1520007674-14618-4-git-send-email-twischer@de.adit-jv.com>
 <1520930084-17449-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 01B2E267275
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 09:35:42 +0100 (CET)
In-Reply-To: <1520930084-17449-1-git-send-email-twischer@de.adit-jv.com>
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
Without this commit the ALSA audio buffer will be played with endless
repeats as long as the user application has not provided new audio data.
Therefore this garbage will be played as long as the user application has
not called snd_pcm_stop() after an Xrun. With this fix the rest of the
JACK buffer will be filled with silence.

Capture:
Without this commit the audio data in the ALSA buffer would be
overwritten. With this commit the new data from the JACK buffer will not
be copied. Therefore the existing data in the ALSA buffer will not be
overwritten.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index c547cbb..7c7c230 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -54,6 +54,7 @@ typedef struct {
 
 static int snd_pcm_jack_stop(snd_pcm_ioplug_t *io);
 
+
 static int pcm_poll_block_check(snd_pcm_ioplug_t *io)
 {
 	static char buf[32];
@@ -143,8 +144,6 @@ static int
 snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 {
 	snd_pcm_jack_t *jack = io->private_data;
-	snd_pcm_uframes_t hw_ptr;
-	const snd_pcm_channel_area_t *areas;
 	snd_pcm_uframes_t xfer = 0;
 	unsigned int channel;
 	
@@ -154,39 +153,50 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
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
 
-	hw_ptr = jack->hw_ptr;
-	areas = snd_pcm_ioplug_mmap_areas(io);
+	if (io->state == SND_PCM_STATE_RUNNING) {
+		snd_pcm_uframes_t hw_ptr = jack->hw_ptr;
+		const snd_pcm_uframes_t hw_avail = snd_pcm_ioplug_hw_avail(io, hw_ptr,
+									   io->appl_ptr);
 
-	while (xfer < nframes) {
-		snd_pcm_uframes_t frames = nframes - xfer;
-		snd_pcm_uframes_t offset = hw_ptr % io->buffer_size;
-		snd_pcm_uframes_t cont = io->buffer_size - offset;
+		if (hw_avail > 0) {
+			const snd_pcm_channel_area_t *areas = snd_pcm_ioplug_mmap_areas(io);
+			const snd_pcm_uframes_t offset = hw_ptr % io->buffer_size;
 
-		if (cont < frames)
-			frames = cont;
+			xfer = nframes;
+			if (xfer > hw_avail)
+				xfer = hw_avail;
 
-		for (channel = 0; channel < io->channels; channel++) {
 			if (io->stream == SND_PCM_STREAM_PLAYBACK)
-				snd_pcm_area_copy(&jack->areas[channel], xfer, &areas[channel], offset, frames, io->format);
+				snd_pcm_areas_copy_wrap(jack->areas, 0, nframes,
+							areas, offset,
+							io->buffer_size,
+							io->channels, xfer,
+							io->format);
 			else
-				snd_pcm_area_copy(&areas[channel], offset, &jack->areas[channel], xfer, frames, io->format);
+				snd_pcm_areas_copy_wrap(areas, offset,
+							io->buffer_size,
+							jack->areas, 0, nframes,
+							io->channels, xfer,
+							io->format);
+
+			hw_ptr += xfer;
+			if (hw_ptr >= jack->boundary)
+				hw_ptr -= jack->boundary;
+			jack->hw_ptr = hw_ptr;
+		}
+	}
+
+	/* check if requested frames were copied */
+	if (xfer < nframes) {
+		/* always fill the not yet written JACK buffer with silence */
+		if (io->stream == SND_PCM_STREAM_PLAYBACK) {
+			const snd_pcm_uframes_t frames = nframes - xfer;
+
+			snd_pcm_areas_silence(jack->areas, io->channels, xfer,
+					      frames, io->format);
 		}
-		
-		hw_ptr += frames;
-		if (hw_ptr >= jack->boundary)
-			hw_ptr -= jack->boundary;
-		xfer += frames;
 	}
-	jack->hw_ptr = hw_ptr;
 
 	pcm_poll_unblock_check(io); /* unblock socket for polling if needed */
 
-- 
2.7.4
