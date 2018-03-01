From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK plugin 4/4] jack: Support snd_pcm_drain()
Date: Thu, 1 Mar 2018 14:14:08 +0100
Message-ID: <1519910048-19732-5-git-send-email-twischer@de.adit-jv.com>
References: <s5hd10qyg05.wl-tiwai@suse.de>
 <1519910048-19732-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id C486B2678F3
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 14:15:05 +0100 (CET)
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

Block on drain till available samples played

Without this commit the JACK thread will be stopped
before the ALSA buffer was completely forwarded to
the JACK daemon.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index 79aa79b..f457dc4 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -28,6 +28,17 @@
 #include <alsa/asoundlib.h>
 #include <alsa/pcm_external.h>
 
+/* ALSA supports up to 64 periods per buffer.
+ * Therefore at least 64 retries are valid and
+ * should not be handled as an error case
+ */
+#define MAX_DRAIN_RETRIES	100
+/* ALSA supports a a period with 8192 frames.
+ * This would result in ~170ms at 48kHz.
+ * Therefore a time out of 1 second is sufficient
+ */
+#define DRAIN_TIMEOUT		1000
+
 typedef enum _jack_format {
 	SND_PCM_JACK_FORMAT_RAW
 } snd_pcm_jack_format_t;
@@ -146,7 +157,13 @@ static int pcm_poll_unblock_check(snd_pcm_ioplug_t *io)
 	snd_pcm_jack_t *jack = io->private_data;
 
 	avail = snd_pcm_avail_update(io->pcm);
-	if (avail < 0 || avail >= jack->min_avail) {
+	/* In draining state poll_fd is used to wait
+	 * till all pending frames are played.
+	 * Therefore it has to be guarantee that a poll event is also generated
+	 * if the buffer contains less than min_avail frames
+	 */
+	if (avail < 0 || avail >= jack->min_avail ||
+	    jack->state == SND_PCM_STATE_DRAINING) {
 		write(jack->fd, &buf, 1);
 		return 1;
 	}
@@ -232,7 +249,8 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 	}
 
 	hw_ptr = jack->hw_ptr;
-	if (jack->state == SND_PCM_STATE_RUNNING) {
+	if (jack->state == SND_PCM_STATE_RUNNING ||
+	    jack->state == SND_PCM_STATE_DRAINING) {
 		const snd_pcm_channel_area_t *areas = snd_pcm_ioplug_mmap_areas(io);
 
 		while (xfer < nframes) {
@@ -392,6 +410,61 @@ static int snd_pcm_jack_start(snd_pcm_ioplug_t *io)
 	return err;
 }
 
+static int snd_pcm_jack_drain(snd_pcm_ioplug_t *io)
+{
+	snd_pcm_jack_t *jack = io->private_data;
+	const snd_pcm_state_t state = jack->state;
+	unsigned int retries = MAX_DRAIN_RETRIES;
+	char buf[32];
+
+	/* Immediately stop on capture device.
+	 * snd_pcm_jack_stop() will be automatically called
+	 * by snd_pcm_ioplug_drain()
+	 */
+	if (io->stream == SND_PCM_STREAM_CAPTURE) {
+		return 0;
+	}
+
+	if (snd_pcm_jack_hw_avail(io, jack->hw_ptr, io->appl_ptr) <= 0) {
+		/* No data pending. Nothing to drain. */
+		return 0;
+	}
+
+	/* start device if not yet done */
+	if (state == SND_PCM_STATE_PREPARED) {
+		snd_pcm_jack_start(io);
+	}
+
+	/* FIXME: io->state will not be set to SND_PCM_STATE_DRAINING by the
+	 * ALSA library before calling this function.
+	 * Therefore this state has to be stored internally.
+	 */
+	jack->state = SND_PCM_STATE_DRAINING;
+
+	struct pollfd pfd;
+	pfd.fd = io->poll_fd;
+	pfd.events = io->poll_events | POLLERR | POLLNVAL;
+
+	while (snd_pcm_jack_hw_avail(io, jack->hw_ptr, io->appl_ptr) > 0) {
+		if (retries <= 0) {
+			SNDERR("Pending frames not yet processed.");
+			return -ETIMEDOUT;
+		}
+
+		if (poll(&pfd, 1, DRAIN_TIMEOUT) < 0) {
+			SNDERR("Waiting for next JACK process callback failed (err %d)",
+			       -errno);
+			return -errno;
+		}
+
+		/* clean pending events. */
+		while (read(io->poll_fd, &buf, sizeof(buf)) == sizeof(buf))
+			;
+	}
+
+	return 0;
+}
+
 static int snd_pcm_jack_stop(snd_pcm_ioplug_t *io)
 {
 	snd_pcm_jack_t *jack = io->private_data;
@@ -423,6 +496,7 @@ static snd_pcm_ioplug_callback_t jack_pcm_callback = {
 	.stop = snd_pcm_jack_stop,
 	.pointer = snd_pcm_jack_pointer,
 	.prepare = snd_pcm_jack_prepare,
+	.drain = snd_pcm_jack_drain,
 	.poll_revents = snd_pcm_jack_poll_revents,
 };
 
-- 
2.7.4
