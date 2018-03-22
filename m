From: <twischer@de.adit-jv.com>
Subject: [PATCH - IOPLUG DRAIN 1/1] jack: Support
	snd_pcm_drain()
Date: Thu, 22 Mar 2018 14:48:57 +0100
Message-ID: <1521726537-7651-3-git-send-email-twischer@de.adit-jv.com>
References: <1521726537-7651-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EDD826739D
 for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2018 14:49:43 +0100 (CET)
In-Reply-To: <1521726537-7651-1-git-send-email-twischer@de.adit-jv.com>
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

Without this commit the JACK thread will be stopped
before the ALSA buffer was completely forwarded to
the JACK daemon.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index e3df4d2..5c4d0fc 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -85,7 +85,12 @@ static int pcm_poll_unblock_check(snd_pcm_ioplug_t *io)
 	snd_pcm_jack_t *jack = io->private_data;
 
 	avail = snd_pcm_avail_update(io->pcm);
-	if (avail < 0 || avail >= jack->min_avail) {
+	/* In draining state poll_fd is used to wait till all pending frames are
+	 * played. Therefore it has to be guarantee that a poll event is also
+	 * generated if the buffer contains less than min_avail frames.
+	 */
+	if (avail < 0 || avail >= jack->min_avail ||
+	    io->state == SND_PCM_STATE_DRAINING) {
 		write(jack->fd, &buf, 1);
 		return 1;
 	}
@@ -161,7 +166,8 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 		jack->areas[channel].step = jack->sample_bits;
 	}
 
-	if (io->state == SND_PCM_STATE_RUNNING) {
+	if (io->state == SND_PCM_STATE_RUNNING ||
+	    io->state == SND_PCM_STATE_DRAINING) {
 		snd_pcm_uframes_t hw_ptr = jack->hw_ptr;
 		const snd_pcm_uframes_t hw_avail = snd_pcm_ioplug_hw_avail(io, hw_ptr,
 									   io->appl_ptr);
@@ -307,6 +313,29 @@ static int snd_pcm_jack_start(snd_pcm_ioplug_t *io)
 	return 0;
 }
 
+static int snd_pcm_jack_drain(snd_pcm_ioplug_t *io)
+{
+	snd_pcm_jack_t *jack = io->private_data;
+
+	/* Immediately stop on capture device.
+	 * snd_pcm_jack_stop() will be automatically called
+	 * by snd_pcm_ioplug_drain()
+	 */
+	if (io->stream == SND_PCM_STREAM_CAPTURE)
+		return 0;
+
+	if (snd_pcm_ioplug_hw_avail(io, jack->hw_ptr, io->appl_ptr) <= 0) {
+		/* No data pending. Nothing to drain. */
+		return 0;
+	}
+
+	/* start device if not yet done */
+	if (!jack->activated)
+		snd_pcm_jack_start(io);
+
+	return -EAGAIN;
+}
+
 static int snd_pcm_jack_stop(snd_pcm_ioplug_t *io)
 {
 	snd_pcm_jack_t *jack = io->private_data;
@@ -333,6 +362,7 @@ static snd_pcm_ioplug_callback_t jack_pcm_callback = {
 	.stop = snd_pcm_jack_stop,
 	.pointer = snd_pcm_jack_pointer,
 	.prepare = snd_pcm_jack_prepare,
+	.drain = snd_pcm_jack_drain,
 	.poll_revents = snd_pcm_jack_poll_revents,
 };
 
-- 
2.7.4
