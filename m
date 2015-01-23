From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 12/16] ALSA: line6: Consolidate URB unlink and
	sync helpers
Date: Fri, 23 Jan 2015 18:13:19 +0100
Message-ID: <1422033203-23254-13-git-send-email-tiwai@suse.de>
References: <1422033203-23254-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CD3B265516
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 18:13:41 +0100 (CET)
In-Reply-To: <1422033203-23254-1-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

The codes to unlink and sync URBs are identical for both playback and
capture streams.  Consolidate to single helper functions.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/capture.c  | 52 ---------------------------
 sound/usb/line6/capture.h  |  4 ---
 sound/usb/line6/pcm.c      | 90 +++++++++++++++++++++++++++++++++++-----------
 sound/usb/line6/playback.c | 52 ---------------------------
 sound/usb/line6/playback.h |  4 ---
 5 files changed, 69 insertions(+), 133 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 439f1941eb56..1d477d7a42fb 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -85,58 +85,6 @@ int line6_submit_audio_in_all_urbs(struct snd_line6_pcm *line6pcm)
 }
 
 /*
-	Unlink all currently active capture URBs.
-*/
-void line6_unlink_audio_in_urbs(struct snd_line6_pcm *line6pcm)
-{
-	unsigned int i;
-
-	for (i = 0; i < LINE6_ISO_BUFFERS; i++) {
-		if (test_bit(i, &line6pcm->in.active_urbs)) {
-			if (!test_and_set_bit(i, &line6pcm->in.unlink_urbs)) {
-				struct urb *u = line6pcm->in.urbs[i];
-
-				usb_unlink_urb(u);
-			}
-		}
-	}
-}
-
-/*
-	Wait until unlinking of all currently active capture URBs has been
-	finished.
-*/
-void line6_wait_clear_audio_in_urbs(struct snd_line6_pcm *line6pcm)
-{
-	int timeout = HZ;
-	unsigned int i;
-	int alive;
-
-	do {
-		alive = 0;
-		for (i = 0; i < LINE6_ISO_BUFFERS; i++) {
-			if (test_bit(i, &line6pcm->in.active_urbs))
-				alive++;
-		}
-		if (!alive)
-			break;
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
-	} while (--timeout > 0);
-	if (alive)
-		snd_printk(KERN_ERR "timeout: still %d active urbs..\n", alive);
-}
-
-/*
-	Unlink all currently active capture URBs, and wait for finishing.
-*/
-void line6_unlink_wait_clear_audio_in_urbs(struct snd_line6_pcm *line6pcm)
-{
-	line6_unlink_audio_in_urbs(line6pcm);
-	line6_wait_clear_audio_in_urbs(line6pcm);
-}
-
-/*
 	Copy data into ALSA capture buffer.
 */
 void line6_capture_copy(struct snd_line6_pcm *line6pcm, char *fbuf, int fsize)
diff --git a/sound/usb/line6/capture.h b/sound/usb/line6/capture.h
index 0939f400a405..3cc71bc70b21 100644
--- a/sound/usb/line6/capture.h
+++ b/sound/usb/line6/capture.h
@@ -26,10 +26,6 @@ extern void line6_capture_check_period(struct snd_line6_pcm *line6pcm,
 extern int line6_create_audio_in_urbs(struct snd_line6_pcm *line6pcm);
 extern void line6_free_capture_buffer(struct snd_line6_pcm *line6pcm);
 extern int line6_submit_audio_in_all_urbs(struct snd_line6_pcm *line6pcm);
-extern void line6_unlink_audio_in_urbs(struct snd_line6_pcm *line6pcm);
-extern void line6_unlink_wait_clear_audio_in_urbs(struct snd_line6_pcm
-						  *line6pcm);
-extern void line6_wait_clear_audio_in_urbs(struct snd_line6_pcm *line6pcm);
 extern int snd_line6_capture_trigger(struct snd_line6_pcm *line6pcm, int cmd);
 
 #endif
diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 738bfd82cecd..677419dcacf9 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -90,6 +90,47 @@ static int snd_line6_impulse_period_put(struct snd_kcontrol *kcontrol,
 	return 1;
 }
 
+/*
+	Unlink all currently active URBs.
+*/
+static void line6_unlink_audio_urbs(struct snd_line6_pcm *line6pcm,
+				    struct line6_pcm_stream *pcms)
+{
+	int i;
+
+	for (i = 0; i < LINE6_ISO_BUFFERS; i++) {
+		if (test_bit(i, &pcms->active_urbs)) {
+			if (!test_and_set_bit(i, &pcms->unlink_urbs))
+				usb_unlink_urb(pcms->urbs[i]);
+		}
+	}
+}
+
+/*
+	Wait until unlinking of all currently active URBs has been finished.
+*/
+static void line6_wait_clear_audio_urbs(struct snd_line6_pcm *line6pcm,
+					struct line6_pcm_stream *pcms)
+{
+	int timeout = HZ;
+	int i;
+	int alive;
+
+	do {
+		alive = 0;
+		for (i = 0; i < LINE6_ISO_BUFFERS; i++) {
+			if (test_bit(i, &pcms->active_urbs))
+				alive++;
+		}
+		if (!alive)
+			break;
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(1);
+	} while (--timeout > 0);
+	if (alive)
+		snd_printk(KERN_ERR "timeout: still %d active urbs..\n", alive);
+}
+
 static bool test_flags(unsigned long flags0, unsigned long flags1,
 		       unsigned long mask)
 {
@@ -202,18 +243,18 @@ int line6_pcm_release(struct snd_line6_pcm *line6pcm, int channels)
 	} while (cmpxchg(&line6pcm->flags, flags_old, flags_new) != flags_old);
 
 	if (test_flags(flags_new, flags_old, LINE6_BITS_CAPTURE_STREAM))
-		line6_unlink_audio_in_urbs(line6pcm);
+		line6_unlink_audio_urbs(line6pcm, &line6pcm->in);
 
 	if (test_flags(flags_new, flags_old, LINE6_BITS_CAPTURE_BUFFER)) {
-		line6_wait_clear_audio_in_urbs(line6pcm);
+		line6_wait_clear_audio_urbs(line6pcm, &line6pcm->in);
 		line6_free_capture_buffer(line6pcm);
 	}
 
 	if (test_flags(flags_new, flags_old, LINE6_BITS_PLAYBACK_STREAM))
-		line6_unlink_audio_out_urbs(line6pcm);
+		line6_unlink_audio_urbs(line6pcm, &line6pcm->out);
 
 	if (test_flags(flags_new, flags_old, LINE6_BITS_PLAYBACK_BUFFER)) {
-		line6_wait_clear_audio_out_urbs(line6pcm);
+		line6_wait_clear_audio_urbs(line6pcm, &line6pcm->out);
 		line6_free_playback_buffer(line6pcm);
 	}
 
@@ -325,21 +366,24 @@ static struct snd_kcontrol_new line6_controls[] = {
 /*
 	Cleanup the PCM device.
 */
-static void line6_cleanup_pcm(struct snd_pcm *pcm)
+static void cleanup_urbs(struct line6_pcm_stream *pcms)
 {
 	int i;
-	struct snd_line6_pcm *line6pcm = snd_pcm_chip(pcm);
 
 	for (i = 0; i < LINE6_ISO_BUFFERS; i++) {
-		if (line6pcm->out.urbs[i]) {
-			usb_kill_urb(line6pcm->out.urbs[i]);
-			usb_free_urb(line6pcm->out.urbs[i]);
-		}
-		if (line6pcm->in.urbs[i]) {
-			usb_kill_urb(line6pcm->in.urbs[i]);
-			usb_free_urb(line6pcm->in.urbs[i]);
+		if (pcms->urbs[i]) {
+			usb_kill_urb(pcms->urbs[i]);
+			usb_free_urb(pcms->urbs[i]);
 		}
 	}
+}
+
+static void line6_cleanup_pcm(struct snd_pcm *pcm)
+{
+	struct snd_line6_pcm *line6pcm = snd_pcm_chip(pcm);
+
+	cleanup_urbs(&line6pcm->out);
+	cleanup_urbs(&line6pcm->in);
 	kfree(line6pcm);
 }
 
@@ -374,8 +418,10 @@ static int snd_line6_new_pcm(struct usb_line6 *line6, struct snd_pcm **pcm_ret)
 */
 void line6_pcm_disconnect(struct snd_line6_pcm *line6pcm)
 {
-	line6_unlink_wait_clear_audio_out_urbs(line6pcm);
-	line6_unlink_wait_clear_audio_in_urbs(line6pcm);
+	line6_unlink_audio_urbs(line6pcm, &line6pcm->out);
+	line6_unlink_audio_urbs(line6pcm, &line6pcm->in);
+	line6_wait_clear_audio_urbs(line6pcm, &line6pcm->out);
+	line6_wait_clear_audio_urbs(line6pcm, &line6pcm->in);
 }
 
 /*
@@ -451,15 +497,17 @@ int snd_line6_prepare(struct snd_pcm_substream *substream)
 
 	switch (substream->stream) {
 	case SNDRV_PCM_STREAM_PLAYBACK:
-		if ((line6pcm->flags & LINE6_BITS_PLAYBACK_STREAM) == 0)
-			line6_unlink_wait_clear_audio_out_urbs(line6pcm);
-
+		if ((line6pcm->flags & LINE6_BITS_PLAYBACK_STREAM) == 0) {
+			line6_unlink_audio_urbs(line6pcm, &line6pcm->out);
+			line6_wait_clear_audio_urbs(line6pcm, &line6pcm->out);
+		}
 		break;
 
 	case SNDRV_PCM_STREAM_CAPTURE:
-		if ((line6pcm->flags & LINE6_BITS_CAPTURE_STREAM) == 0)
-			line6_unlink_wait_clear_audio_in_urbs(line6pcm);
-
+		if ((line6pcm->flags & LINE6_BITS_CAPTURE_STREAM) == 0) {
+			line6_unlink_audio_urbs(line6pcm, &line6pcm->in);
+			line6_wait_clear_audio_urbs(line6pcm, &line6pcm->in);
+		}
 		break;
 	}
 
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index d619c1718306..3820ed08b342 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -290,58 +290,6 @@ int line6_submit_audio_out_all_urbs(struct snd_line6_pcm *line6pcm)
 	return 0;
 }
 
-/*
-	Unlink all currently active playback URBs.
-*/
-void line6_unlink_audio_out_urbs(struct snd_line6_pcm *line6pcm)
-{
-	unsigned int i;
-
-	for (i = 0; i < LINE6_ISO_BUFFERS; i++) {
-		if (test_bit(i, &line6pcm->out.active_urbs)) {
-			if (!test_and_set_bit(i, &line6pcm->out.unlink_urbs)) {
-				struct urb *u = line6pcm->out.urbs[i];
-
-				usb_unlink_urb(u);
-			}
-		}
-	}
-}
-
-/*
-	Wait until unlinking of all currently active playback URBs has been
-	finished.
-*/
-void line6_wait_clear_audio_out_urbs(struct snd_line6_pcm *line6pcm)
-{
-	int timeout = HZ;
-	unsigned int i;
-	int alive;
-
-	do {
-		alive = 0;
-		for (i = 0; i < LINE6_ISO_BUFFERS; i++) {
-			if (test_bit(i, &line6pcm->out.active_urbs))
-				alive++;
-		}
-		if (!alive)
-			break;
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(1);
-	} while (--timeout > 0);
-	if (alive)
-		snd_printk(KERN_ERR "timeout: still %d active urbs..\n", alive);
-}
-
-/*
-	Unlink all currently active playback URBs, and wait for finishing.
-*/
-void line6_unlink_wait_clear_audio_out_urbs(struct snd_line6_pcm *line6pcm)
-{
-	line6_unlink_audio_out_urbs(line6pcm);
-	line6_wait_clear_audio_out_urbs(line6pcm);
-}
-
 void line6_free_playback_buffer(struct snd_line6_pcm *line6pcm)
 {
 	kfree(line6pcm->out.buffer);
diff --git a/sound/usb/line6/playback.h b/sound/usb/line6/playback.h
index 78a885113221..52a278353d3b 100644
--- a/sound/usb/line6/playback.h
+++ b/sound/usb/line6/playback.h
@@ -32,10 +32,6 @@ extern struct snd_pcm_ops snd_line6_playback_ops;
 extern int line6_create_audio_out_urbs(struct snd_line6_pcm *line6pcm);
 extern void line6_free_playback_buffer(struct snd_line6_pcm *line6pcm);
 extern int line6_submit_audio_out_all_urbs(struct snd_line6_pcm *line6pcm);
-extern void line6_unlink_audio_out_urbs(struct snd_line6_pcm *line6pcm);
-extern void line6_unlink_wait_clear_audio_out_urbs(struct snd_line6_pcm
-						   *line6pcm);
-extern void line6_wait_clear_audio_out_urbs(struct snd_line6_pcm *line6pcm);
 extern int snd_line6_playback_trigger(struct snd_line6_pcm *line6pcm, int cmd);
 
 #endif
-- 
2.2.2
