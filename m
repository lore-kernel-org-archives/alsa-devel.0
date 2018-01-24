From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK PCM plugin] jack: Use boundary as hw_ptr
	wrap around
Date: Wed, 24 Jan 2018 12:49:05 +0100
Message-ID: <1516794545-9868-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
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

This patch is depending on
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-January/130942.html

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index 3aed332..c22a5d0 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -40,6 +40,7 @@ typedef struct {
 
 	char **port_names;
 	unsigned int num_ports;
+	snd_pcm_uframes_t boundary;
 	unsigned int hw_ptr;
 	unsigned int sample_bits;
 	snd_pcm_uframes_t min_avail;
@@ -130,6 +131,21 @@ static int snd_pcm_jack_poll_revents(snd_pcm_ioplug_t *io,
 static snd_pcm_sframes_t snd_pcm_jack_pointer(snd_pcm_ioplug_t *io)
 {
 	snd_pcm_jack_t *jack = io->private_data;
+
+	/* ALSA library is calulating the delta between the last pointer and
+	 * the current one.
+	 * Normally it is expecting a value between 0 and buffer_size.
+	 * The following example would result in an negative delta
+	 * which would result in a hw_ptr which will be reduced.
+	 *  last_hw = jack->boundary - io->buffer_size
+	 *  hw = 0
+	 * But we cannot use
+	 * return jack->hw_ptr % io->buffer_size;
+	 * because in this case an update of
+	 * hw_ptr += io->buffer_size
+	 * would not be recognized by the ALSA library.
+	 * Therefore we are using jack->boundary as the wrap around.
+	 */
 	return jack->hw_ptr;
 }
 
@@ -162,7 +178,7 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 
 	while (xfer < nframes) {
 		snd_pcm_uframes_t frames = nframes - xfer;
-		snd_pcm_uframes_t offset = hw_ptr;
+		snd_pcm_uframes_t offset = hw_ptr % io->buffer_size;
 		snd_pcm_uframes_t cont = io->buffer_size - offset;
 
 		if (cont < frames)
@@ -176,7 +192,8 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 		}
 		
 		hw_ptr += frames;
-		hw_ptr %= io->buffer_size;
+		if (hw_ptr >= jack->boundary)
+			hw_ptr -= jack->boundary;
 		xfer += frames;
 	}
 	jack->hw_ptr = hw_ptr;
@@ -200,6 +217,8 @@ static int snd_pcm_jack_prepare(snd_pcm_ioplug_t *io)
 	err = snd_pcm_sw_params_current(io->pcm, swparams);
 	if (err == 0) {
 		snd_pcm_sw_params_get_avail_min(swparams, &jack->min_avail);
+		/* get boundary for available calulation */
+		snd_pcm_sw_params_get_boundary(swparams, &jack->boundary);
 	}
 
 	/* deactivate jack connections if this is XRUN recovery */
-- 
2.7.4
