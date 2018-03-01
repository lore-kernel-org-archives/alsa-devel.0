From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK plugin 3/4] jack: Report Xruns to user
	application
Date: Thu, 1 Mar 2018 14:14:07 +0100
Message-ID: <1519910048-19732-4-git-send-email-twischer@de.adit-jv.com>
References: <s5hd10qyg05.wl-tiwai@suse.de>
 <1519910048-19732-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id D75772678AD
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 14:14:59 +0100 (CET)
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
index 0dff0d2..79aa79b 100644
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
 #ifdef SND_PCM_IOPLUG_FLAG_BOUNDARY_WA
 	return jack->hw_ptr;
 #else
@@ -268,6 +279,25 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
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
