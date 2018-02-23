From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK PCM plugin] jack: Use boundary as hw_ptr
	wrap around
Date: Fri, 23 Feb 2018 15:18:08 +0100
Message-ID: <1519395488-6735-1-git-send-email-twischer@de.adit-jv.com>
References: <s5heflbizjq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id BB16F2678CE
 for <alsa-devel@alsa-project.org>; Fri, 23 Feb 2018 15:18:36 +0100 (CET)
In-Reply-To: <s5heflbizjq.wl-tiwai@suse.de>
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

instead of using buffer_size as wrap around.

This is required to detect Xruns.

It is also required to allow the JACK thread
to processes the whole ALSA audio buffer at once
without calling snd_pcm_avail_update() in between.

For example when the hw_ptr will be updated with
hw_ptr += buffer_size
and it is using the buffer_size as wrap around
hw_ptr %= buffer_size
would result in the same value as before the add operation.

Due to that the user application would not recognize
that the complete audio buffer was copied.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

---

Here the updated version which only returns
hw_ptr >= buffer_size if supported
by the ALSA library on compile time

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index 3aed332..c547cbb 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -40,7 +40,8 @@ typedef struct {
 
 	char **port_names;
 	unsigned int num_ports;
-	unsigned int hw_ptr;
+	snd_pcm_uframes_t boundary;
+	snd_pcm_uframes_t hw_ptr;
 	unsigned int sample_bits;
 	snd_pcm_uframes_t min_avail;
 
@@ -130,7 +131,12 @@ static int snd_pcm_jack_poll_revents(snd_pcm_ioplug_t *io,
 static snd_pcm_sframes_t snd_pcm_jack_pointer(snd_pcm_ioplug_t *io)
 {
 	snd_pcm_jack_t *jack = io->private_data;
+
+#ifdef SND_PCM_IOPLUG_FLAG_BOUNDARY_WA
 	return jack->hw_ptr;
+#else
+	return jack->hw_ptr % io->buffer_size;
+#endif
 }
 
 static int
@@ -162,7 +168,7 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 
 	while (xfer < nframes) {
 		snd_pcm_uframes_t frames = nframes - xfer;
-		snd_pcm_uframes_t offset = hw_ptr;
+		snd_pcm_uframes_t offset = hw_ptr % io->buffer_size;
 		snd_pcm_uframes_t cont = io->buffer_size - offset;
 
 		if (cont < frames)
@@ -176,7 +182,8 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 		}
 		
 		hw_ptr += frames;
-		hw_ptr %= io->buffer_size;
+		if (hw_ptr >= jack->boundary)
+			hw_ptr -= jack->boundary;
 		xfer += frames;
 	}
 	jack->hw_ptr = hw_ptr;
@@ -200,6 +207,8 @@ static int snd_pcm_jack_prepare(snd_pcm_ioplug_t *io)
 	err = snd_pcm_sw_params_current(io->pcm, swparams);
 	if (err == 0) {
 		snd_pcm_sw_params_get_avail_min(swparams, &jack->min_avail);
+		/* get boundary for available calulation */
+		snd_pcm_sw_params_get_boundary(swparams, &jack->boundary);
 	}
 
 	/* deactivate jack connections if this is XRUN recovery */
@@ -452,6 +461,12 @@ static int snd_pcm_jack_open(snd_pcm_t **pcmp, const char *name,
 	jack->io.poll_events = POLLIN;
 	jack->io.mmap_rw = 1;
 
+#ifdef SND_PCM_IOPLUG_FLAG_BOUNDARY_WA
+	jack->io.flags = SND_PCM_IOPLUG_FLAG_BOUNDARY_WA;
+#else
+#warning hw_ptr updates of buffer_size will not be recognized by the ALSA library. Consider to update your ALSA library.
+#endif
+
 	err = snd_pcm_ioplug_create(&jack->io, name, stream, mode);
 	if (err < 0) {
 		snd_pcm_jack_free(jack);
-- 
2.7.4
