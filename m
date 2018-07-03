From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK IO plug 2/2] jack: Update poll_fd also
	in draining state
Date: Tue, 3 Jul 2018 15:59:23 +0200
Message-ID: <1530626363-8808-4-git-send-email-twischer@de.adit-jv.com>
References: <1530626363-8808-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1530626363-8808-1-git-send-email-twischer@de.adit-jv.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org, tiwai@suse.de
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

to support snd_pcm_drain for the JACK IO plugin.
With this changes there will be an poll_fd event in DRAINING state even if
the min_avail was not yet reached. Otherwise the application would never
recognize that all samples were processed by JACK.
In addition the JACK real-time thread is also processing when in DRAINING
state and not only when in RUNNING or PREPARE state.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index 5a57e13..98a6f7e 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -66,6 +66,7 @@ static int pcm_poll_block_check(snd_pcm_ioplug_t *io)
 	snd_pcm_jack_t *jack = io->private_data;
 
 	if (io->state == SND_PCM_STATE_RUNNING ||
+	    io->state == SND_PCM_STATE_DRAINING ||
 	    (io->state == SND_PCM_STATE_PREPARED && io->stream == SND_PCM_STREAM_CAPTURE)) {
 		avail = snd_pcm_ioplug_avail(io, jack->hw_ptr, io->appl_ptr);
 		if (avail < jack->min_avail) {
@@ -85,7 +86,12 @@ static int pcm_poll_unblock_check(snd_pcm_ioplug_t *io)
 	snd_pcm_jack_t *jack = io->private_data;
 
 	avail = snd_pcm_ioplug_avail(io, jack->hw_ptr, io->appl_ptr);
-	if (avail >= jack->min_avail) {
+	/* In draining state poll_fd is used to wait
+	 * till all pending frames are played.
+	 * Therefore it has to be guarantee that a poll event is also generated
+	 * if the buffer contains less than min_avail frames
+	 */
+	if (avail >= jack->min_avail || io->state == SND_PCM_STATE_DRAINING) {
 		write(jack->fd, &buf, 1);
 		return 1;
 	}
@@ -161,7 +167,8 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 		jack->areas[channel].step = jack->sample_bits;
 	}
 
-	if (io->state == SND_PCM_STATE_RUNNING) {
+	if (io->state == SND_PCM_STATE_RUNNING ||
+	    io->state == SND_PCM_STATE_DRAINING) {
 		snd_pcm_uframes_t hw_ptr = jack->hw_ptr;
 		const snd_pcm_uframes_t hw_avail = snd_pcm_ioplug_hw_avail(io, hw_ptr,
 									   io->appl_ptr);
-- 
2.7.4
