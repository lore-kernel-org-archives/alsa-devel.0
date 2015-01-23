From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 14/16] ALSA: line6: Consolidate PCM stream
	buffer allocation and free
Date: Fri, 23 Jan 2015 18:13:21 +0100
Message-ID: <1422033203-23254-15-git-send-email-tiwai@suse.de>
References: <1422033203-23254-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 919EC2654E5
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

The PCM stream buffer allocation and free are identical for both
playback and capture streams.  Provide single helper functions.
These are used only in pcm.c, thus they can be even static.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/capture.c  |  6 ------
 sound/usb/line6/capture.h  |  1 -
 sound/usb/line6/pcm.c      | 53 +++++++++++++++++++++++++---------------------
 sound/usb/line6/playback.c |  6 ------
 sound/usb/line6/playback.h |  1 -
 5 files changed, 29 insertions(+), 38 deletions(-)

diff --git a/sound/usb/line6/capture.c b/sound/usb/line6/capture.c
index 1d477d7a42fb..47cfcc2ab387 100644
--- a/sound/usb/line6/capture.c
+++ b/sound/usb/line6/capture.c
@@ -141,12 +141,6 @@ void line6_capture_check_period(struct snd_line6_pcm *line6pcm, int length)
 	}
 }
 
-void line6_free_capture_buffer(struct snd_line6_pcm *line6pcm)
-{
-	kfree(line6pcm->in.buffer);
-	line6pcm->in.buffer = NULL;
-}
-
 /*
  * Callback for completed capture URB.
  */
diff --git a/sound/usb/line6/capture.h b/sound/usb/line6/capture.h
index 3cc71bc70b21..db062e7200a6 100644
--- a/sound/usb/line6/capture.h
+++ b/sound/usb/line6/capture.h
@@ -24,7 +24,6 @@ extern void line6_capture_copy(struct snd_line6_pcm *line6pcm, char *fbuf,
 extern void line6_capture_check_period(struct snd_line6_pcm *line6pcm,
 				       int length);
 extern int line6_create_audio_in_urbs(struct snd_line6_pcm *line6pcm);
-extern void line6_free_capture_buffer(struct snd_line6_pcm *line6pcm);
 extern int line6_submit_audio_in_all_urbs(struct snd_line6_pcm *line6pcm);
 extern int snd_line6_capture_trigger(struct snd_line6_pcm *line6pcm, int cmd);
 
diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 4152d92105b1..f75825995e24 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -132,6 +132,27 @@ static void line6_wait_clear_audio_urbs(struct snd_line6_pcm *line6pcm,
 			"timeout: still %d active urbs..\n", alive);
 }
 
+static int line6_alloc_stream_buffer(struct snd_line6_pcm *line6pcm,
+				     struct line6_pcm_stream *pcms)
+{
+	/* Invoked multiple times in a row so allocate once only */
+	if (pcms->buffer)
+		return 0;
+
+	pcms->buffer = kmalloc(LINE6_ISO_BUFFERS * LINE6_ISO_PACKETS *
+			       line6pcm->max_packet_size, GFP_KERNEL);
+	if (!pcms->buffer)
+		return -ENOMEM;
+	return 0;
+}
+
+static void line6_free_stream_buffer(struct snd_line6_pcm *line6pcm,
+				     struct line6_pcm_stream *pcms)
+{
+	kfree(pcms->buffer);
+	pcms->buffer = NULL;
+}
+
 static bool test_flags(unsigned long flags0, unsigned long flags1,
 		       unsigned long mask)
 {
@@ -153,17 +174,9 @@ int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int channels)
 	line6pcm->prev_fbuf = NULL;
 
 	if (test_flags(flags_old, flags_new, LINE6_BITS_CAPTURE_BUFFER)) {
-		/* Invoked multiple times in a row so allocate once only */
-		if (!line6pcm->in.buffer) {
-			line6pcm->in.buffer =
-				kmalloc(LINE6_ISO_BUFFERS * LINE6_ISO_PACKETS *
-					line6pcm->max_packet_size, GFP_KERNEL);
-			if (!line6pcm->in.buffer) {
-				err = -ENOMEM;
-				goto pcm_acquire_error;
-			}
-		}
-
+		err = line6_alloc_stream_buffer(line6pcm, &line6pcm->in);
+		if (err < 0)
+			goto pcm_acquire_error;
 		flags_final |= channels & LINE6_BITS_CAPTURE_BUFFER;
 	}
 
@@ -190,17 +203,9 @@ int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int channels)
 	}
 
 	if (test_flags(flags_old, flags_new, LINE6_BITS_PLAYBACK_BUFFER)) {
-		/* Invoked multiple times in a row so allocate once only */
-		if (!line6pcm->out.buffer) {
-			line6pcm->out.buffer =
-				kmalloc(LINE6_ISO_BUFFERS * LINE6_ISO_PACKETS *
-					line6pcm->max_packet_size, GFP_KERNEL);
-			if (!line6pcm->out.buffer) {
-				err = -ENOMEM;
-				goto pcm_acquire_error;
-			}
-		}
-
+		err = line6_alloc_stream_buffer(line6pcm, &line6pcm->out);
+		if (err < 0)
+			goto pcm_acquire_error;
 		flags_final |= channels & LINE6_BITS_PLAYBACK_BUFFER;
 	}
 
@@ -248,7 +253,7 @@ int line6_pcm_release(struct snd_line6_pcm *line6pcm, int channels)
 
 	if (test_flags(flags_new, flags_old, LINE6_BITS_CAPTURE_BUFFER)) {
 		line6_wait_clear_audio_urbs(line6pcm, &line6pcm->in);
-		line6_free_capture_buffer(line6pcm);
+		line6_free_stream_buffer(line6pcm, &line6pcm->in);
 	}
 
 	if (test_flags(flags_new, flags_old, LINE6_BITS_PLAYBACK_STREAM))
@@ -256,7 +261,7 @@ int line6_pcm_release(struct snd_line6_pcm *line6pcm, int channels)
 
 	if (test_flags(flags_new, flags_old, LINE6_BITS_PLAYBACK_BUFFER)) {
 		line6_wait_clear_audio_urbs(line6pcm, &line6pcm->out);
-		line6_free_playback_buffer(line6pcm);
+		line6_free_stream_buffer(line6pcm, &line6pcm->out);
 	}
 
 	return 0;
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index 3820ed08b342..750d91dced57 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -290,12 +290,6 @@ int line6_submit_audio_out_all_urbs(struct snd_line6_pcm *line6pcm)
 	return 0;
 }
 
-void line6_free_playback_buffer(struct snd_line6_pcm *line6pcm)
-{
-	kfree(line6pcm->out.buffer);
-	line6pcm->out.buffer = NULL;
-}
-
 /*
 	Callback for completed playback URB.
 */
diff --git a/sound/usb/line6/playback.h b/sound/usb/line6/playback.h
index 52a278353d3b..f6a9e18f87b6 100644
--- a/sound/usb/line6/playback.h
+++ b/sound/usb/line6/playback.h
@@ -30,7 +30,6 @@
 extern struct snd_pcm_ops snd_line6_playback_ops;
 
 extern int line6_create_audio_out_urbs(struct snd_line6_pcm *line6pcm);
-extern void line6_free_playback_buffer(struct snd_line6_pcm *line6pcm);
 extern int line6_submit_audio_out_all_urbs(struct snd_line6_pcm *line6pcm);
 extern int snd_line6_playback_trigger(struct snd_line6_pcm *line6pcm, int cmd);
 
-- 
2.2.2
