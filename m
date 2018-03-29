From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] pcm: ioplug: Implement proper drain behavior
Date: Thu, 29 Mar 2018 10:02:11 +0200
Message-ID: <20180329080211.24316-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C618266FA1
 for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2018 10:02:14 +0200 (CEST)
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
Cc: Timo Wischer <twischer@de.adit-jv.com>
List-Id: alsa-devel@alsa-project.org

This patch fixes the draining behavior of ioplug in the following
ways:

- When no draining ioplug callback is defined, implement the draining
  loop using snd_pcm_wait*() and sync with the drain finishes.
  This is equivalent with the implementation in the kernel write().
  Similarly as in kernel code, for non-blocking mode, it returns
  immediately after setting DRAINING state.

- The hw_ptr update function checks the PCM state and stops the stream
  if the draining finishes.

- When draining ioplug callback is defined, leave the whole draining
  operation to it.  The callback is supposed to return -EAGAIN for
  non-blocking case, too.

- When an unexpected error happens during draining, it drops the
  stream, for a safety reason.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

The patch was slightly changed from the draft version.
e.g. hw_ptr_update() is called at the beginning of the loop, so that
it's updated for non-blocking mode, too.  And, the stream is dropped
in case of unexpected errors.

Also, this patch requires the previous fix ("pcm: Skip avail_min check
during draining").

 src/pcm/pcm_ioplug.c | 76 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 67 insertions(+), 9 deletions(-)

diff --git a/src/pcm/pcm_ioplug.c b/src/pcm/pcm_ioplug.c
index 8c0ed4836365..db64853b3136 100644
--- a/src/pcm/pcm_ioplug.c
+++ b/src/pcm/pcm_ioplug.c
@@ -47,6 +47,11 @@ typedef struct snd_pcm_ioplug_priv {
 	snd_htimestamp_t trigger_tstamp;
 } ioplug_priv_t;
 
+static int snd_pcm_ioplug_drop(snd_pcm_t *pcm);
+static int snd_pcm_ioplug_poll_descriptors_count(snd_pcm_t *pcm);
+static int snd_pcm_ioplug_poll_descriptors(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int space);
+static int snd_pcm_ioplug_poll_revents(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int nfds, unsigned short *revents);
+
 /* update the hw pointer */
 /* called in lock */
 static void snd_pcm_ioplug_hw_ptr_update(snd_pcm_t *pcm)
@@ -57,6 +62,7 @@ static void snd_pcm_ioplug_hw_ptr_update(snd_pcm_t *pcm)
 	hw = io->data->callback->pointer(io->data);
 	if (hw >= 0) {
 		snd_pcm_uframes_t delta;
+		snd_pcm_uframes_t avail;
 
 		if ((snd_pcm_uframes_t)hw >= io->last_hw)
 			delta = hw - io->last_hw;
@@ -67,9 +73,19 @@ static void snd_pcm_ioplug_hw_ptr_update(snd_pcm_t *pcm)
 			delta = wrap_point + hw - io->last_hw;
 		}
 		snd_pcm_mmap_hw_forward(io->data->pcm, delta);
+		/* stop the stream if all samples are drained */
+		if (io->data->state == SND_PCM_STATE_DRAINING) {
+			avail = snd_pcm_mmap_avail(pcm);
+			if (avail >= pcm->buffer_size)
+				snd_pcm_ioplug_drop(pcm);
+		}
 		io->last_hw = (snd_pcm_uframes_t)hw;
-	} else
-		io->data->state = SNDRV_PCM_STATE_XRUN;
+	} else {
+		if (io->data->state == SND_PCM_STATE_DRAINING)
+			snd_pcm_ioplug_drop(pcm);
+		else
+			io->data->state = SNDRV_PCM_STATE_XRUN;
+	}
 }
 
 static int snd_pcm_ioplug_info(snd_pcm_t *pcm, snd_pcm_info_t *info)
@@ -488,20 +504,62 @@ static int snd_pcm_ioplug_drop(snd_pcm_t *pcm)
 	return 0;
 }
 
+static int ioplug_drain_via_poll(snd_pcm_t *pcm)
+{
+	ioplug_priv_t *io = pcm->private_data;
+
+	while (io->data->state == SND_PCM_STATE_DRAINING) {
+		snd_pcm_ioplug_hw_ptr_update(pcm);
+		if (io->data->state != SND_PCM_STATE_DRAINING)
+			break;
+		/* in non-blocking mode, let application to poll() by itself */
+		if (io->data->nonblock)
+			return -EAGAIN;
+		if (snd_pcm_wait_nocheck(pcm, -1) < 0)
+			break;
+	}
+
+	return 0; /* force to drop at error */
+}
+
 /* need own locking */
 static int snd_pcm_ioplug_drain(snd_pcm_t *pcm)
 {
 	ioplug_priv_t *io = pcm->private_data;
-	int err;
+	int err = 0;
 
-	if (io->data->state == SND_PCM_STATE_OPEN)
+	snd_pcm_lock(pcm);
+	switch (io->data->state) {
+	case SND_PCM_STATE_OPEN:
+	case SND_PCM_STATE_DISCONNECTED:
+	case SND_PCM_STATE_SUSPENDED:
 		return -EBADFD;
+	case SND_PCM_STATE_PREPARED:
+		if (pcm->stream == SND_PCM_STREAM_PLAYBACK) {
+			err = snd_pcm_ioplug_start(pcm);
+			if (err < 0)
+				goto unlock;
+			io->data->state = SND_PCM_STATE_DRAINING;
+		}
+		break;
+	case SND_PCM_STATE_RUNNING:
+		io->data->state = SND_PCM_STATE_DRAINING;
+		break;
+	}
 
-	io->data->state = SND_PCM_STATE_DRAINING;
-	if (io->data->callback->drain)
-		io->data->callback->drain(io->data);
-	snd_pcm_lock(pcm);
-	err = snd_pcm_ioplug_drop(pcm);
+	if (io->data->state == SND_PCM_STATE_DRAINING) {
+		if (io->data->callback->drain) {
+			snd_pcm_unlock(pcm); /* let plugin own locking */
+			err = io->data->callback->drain(io->data);
+			snd_pcm_lock(pcm);
+		} else {
+			err = ioplug_drain_via_poll(pcm);
+		}
+	}
+
+ unlock:
+	if (!err && io->data->state != SND_PCM_STATE_SETUP)
+		snd_pcm_ioplug_drop(pcm);
 	snd_pcm_unlock(pcm);
 	return err;
 }
-- 
2.16.2
