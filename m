From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK 1/1] jack: Report Xruns to user
	application
Date: Fri, 16 Mar 2018 15:23:32 +0100
Message-ID: <1521210212-30923-2-git-send-email-twischer@de.adit-jv.com>
References: <1519910048-19732-4-git-send-email-twischer@de.adit-jv.com>
 <1521210212-30923-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id EA3A026753D
 for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2018 15:23:47 +0100 (CET)
In-Reply-To: <1521210212-30923-1-git-send-email-twischer@de.adit-jv.com>
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
Cc: tiwai@suse.de, Timo Wischer <twischer@de.adit-jv.com>
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

Only increasing the hw_ptr is not sufficient
because it will not be evaluated by the ALSA library
to detect an Xrun.

In addition there is a raise where an Xrun detected by the JACK thread
could not be detected in the ALSA thread.
- In playback use case
- The hw_ptr will be increased by the JACK thread
  (hw_ptr > appl_ptr => Xrun)
- But the ALSA thread increases the appl_ptr before evaluating the
hw_ptr
- Therefore the hw_ptr < appl_ptr again
- ALSA will not detect the Xrun which was already detected by the
JACK thread

Therefore an additional variable is required to report an Xrun from the
JACK thread to ALSA.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index 7c7c230..a655668 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -20,6 +20,7 @@
  *
  */
 
+#include <stdbool.h>
 #include <byteswap.h>
 #include <sys/shm.h>
 #include <sys/types.h>
@@ -50,6 +51,9 @@ typedef struct {
 
 	jack_port_t **ports;
 	jack_client_t *client;
+
+	/* JACK thread -> ALSA thread */
+	bool xrun_detected;
 } snd_pcm_jack_t;
 
 static int snd_pcm_jack_stop(snd_pcm_ioplug_t *io);
@@ -133,6 +137,9 @@ static snd_pcm_sframes_t snd_pcm_jack_pointer(snd_pcm_ioplug_t *io)
 {
 	snd_pcm_jack_t *jack = io->private_data;
 
+	if (jack->xrun_detected)
+		return -EPIPE;
+
 #ifdef SND_PCM_IOPLUG_FLAG_BOUNDARY_WA
 	return jack->hw_ptr;
 #else
@@ -196,6 +203,20 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 			snd_pcm_areas_silence(jack->areas, io->channels, xfer,
 					      frames, io->format);
 		}
+
+		if (io->state == SND_PCM_STATE_PREPARED) {
+			/* After activating this JACK client with
+			 * jack_activate() this process callback will be called.
+			 * But the processing of snd_pcm_jack_start() would take
+			 * a while longer due to the jack_connect() calls.
+			 * Therefore the device was already started
+			 * but it is not yet in RUNNING state.
+			 * Due to this expected behaviour it is not an Xrun.
+			 */
+		} else {
+			/* report Xrun to user application */
+			jack->xrun_detected = true;
+		}
 	}
 
 	pcm_poll_unblock_check(io); /* unblock socket for polling if needed */
@@ -211,6 +232,7 @@ static int snd_pcm_jack_prepare(snd_pcm_ioplug_t *io)
 	int err;
 
 	jack->hw_ptr = 0;
+	jack->xrun_detected = false;
 
 	jack->min_avail = io->period_size;
 	snd_pcm_sw_params_alloca(&swparams);
-- 
2.7.4
