From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK PCM plugin 6/7] jack: Report Xruns to
	user application
Date: Wed, 24 Jan 2018 13:00:41 +0100
Message-ID: <1516795241-10219-4-git-send-email-twischer@de.adit-jv.com>
References: <1516795241-10219-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1516795241-10219-1-git-send-email-twischer@de.adit-jv.com>
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

Only increasing the hw_ptr is not sufficient
because it will not be evaluated by the ALSA library
to detect an Xrun.

In addition there is a raise where and Xrun detected by the JACK thread
could not be detected in the ALSA thread.
- In playback use case
- The hw_ptr will be increased by the JACK thread (hw_ptr > appl_ptr =>
over run)
- But the ALSA thread increases the appl_ptr before evaluating the
hw_ptr
- Therefore the hw_ptr < appl_ptr again
- ALSA will not detect the over run which was already detected by the
JACK thread

Therefore an additional variable is required to report an Xrun from the
JACK thread to ALSA.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index a42c8b5..e75aadc 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -198,6 +198,17 @@ static snd_pcm_sframes_t snd_pcm_jack_pointer(snd_pcm_ioplug_t *io)
 {
 	snd_pcm_jack_t *jack = io->private_data;
 
+#ifdef TEST_SIMULATE_XRUNS
+	static int i=0;
+	if (++i > 1000) {
+		i = 0;
+		return -EPIPE;
+	}
+#endif
+
+	if (jack->state == SND_PCM_STATE_XRUN)
+		return -EPIPE;
+
 	/* ALSA library is calulating the delta between the last pointer and
 	 * the current one.
 	 * Normally it is expecting a value between 0 and buffer_size.
@@ -278,6 +289,25 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 			for (channel = 0; channel < io->channels; channel++)
 				snd_pcm_area_silence(&jack->areas[channel], xfer, samples, io->format);
 		}
+
+		if (io->stream == SND_PCM_STREAM_PLAYBACK &&
+		    jack->state == SND_PCM_STATE_PREPARED) {
+			/* After activating this JACK client with
+			 * jack_activate() this process callback will be called.
+			 * But the processing of snd_pcm_jack_start() would take
+			 * a while longer due to the jack_connect() calls.
+			 * Therefore the device was already started
+			 * but it is not yet in RUNNING state.
+			 * Due to this expected behaviour it is not an under run.
+			 * In Capture use case the buffer should be filled
+			 * and if the application is not fast enough
+			 * to read the data in the buffer
+			 * it is a valid over run.
+			 */
+		} else {
+			/* report Xrun to user application */
+			jack->state = SND_PCM_STATE_XRUN;
+		}
 	}
 
 	pcm_poll_unblock_check(io); /* unblock socket for polling if needed */
-- 
2.7.4
