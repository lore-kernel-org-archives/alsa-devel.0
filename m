From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/5] ALSA: line6: Clear prev_fbuf and
	prev_fsize properly
Date: Tue, 27 Jan 2015 17:13:14 +0100
Message-ID: <1422375197-17293-3-git-send-email-tiwai@suse.de>
References: <1422375197-17293-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 393D92608BC
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 17:13:19 +0100 (CET)
In-Reply-To: <1422375197-17293-1-git-send-email-tiwai@suse.de>
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

Clearing prev_fsize in line6_pcm_acquire() is pretty racy.
This can be called at any time while the stream is being played.
Rather better to clear prev_fbuf and prev_fsize at the proper place
like the stream stop for capture, and just after copying the monitor /
impulse data inside the spinlock.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/pcm.c      | 8 ++++----
 sound/usb/line6/playback.c | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index f75825995e24..dedbe24cbf60 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -171,8 +171,6 @@ int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int channels)
 
 	flags_final = 0;
 
-	line6pcm->prev_fbuf = NULL;
-
 	if (test_flags(flags_old, flags_new, LINE6_BITS_CAPTURE_BUFFER)) {
 		err = line6_alloc_stream_buffer(line6pcm, &line6pcm->in);
 		if (err < 0)
@@ -193,7 +191,6 @@ int line6_pcm_acquire(struct snd_line6_pcm *line6pcm, int channels)
 		}
 
 		line6pcm->in.count = 0;
-		line6pcm->prev_fsize = 0;
 		err = line6_submit_audio_in_all_urbs(line6pcm);
 
 		if (err < 0)
@@ -248,8 +245,11 @@ int line6_pcm_release(struct snd_line6_pcm *line6pcm, int channels)
 		flags_new = flags_old & ~channels;
 	} while (cmpxchg(&line6pcm->flags, flags_old, flags_new) != flags_old);
 
-	if (test_flags(flags_new, flags_old, LINE6_BITS_CAPTURE_STREAM))
+	if (test_flags(flags_new, flags_old, LINE6_BITS_CAPTURE_STREAM)) {
 		line6_unlink_audio_urbs(line6pcm, &line6pcm->in);
+		line6pcm->prev_fbuf = NULL;
+		line6pcm->prev_fsize = 0;
+	}
 
 	if (test_flags(flags_new, flags_old, LINE6_BITS_CAPTURE_BUFFER)) {
 		line6_wait_clear_audio_urbs(line6pcm, &line6pcm->in);
diff --git a/sound/usb/line6/playback.c b/sound/usb/line6/playback.c
index b1d376501616..c1063f1847c3 100644
--- a/sound/usb/line6/playback.c
+++ b/sound/usb/line6/playback.c
@@ -166,9 +166,7 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 		struct usb_iso_packet_descriptor *fout =
 		    &urb_out->iso_frame_desc[i];
 
-		if (line6pcm->flags & LINE6_BITS_CAPTURE_STREAM)
-			fsize = line6pcm->prev_fsize;
-
+		fsize = line6pcm->prev_fsize;
 		if (fsize == 0) {
 			int n;
 
@@ -263,6 +261,8 @@ static int submit_audio_out_urb(struct snd_line6_pcm *line6pcm)
 						   line6pcm->volume_monitor,
 						   bytes_per_frame);
 		}
+		line6pcm->prev_fbuf = NULL;
+		line6pcm->prev_fsize = 0;
 	}
 	spin_unlock(&line6pcm->in.lock);
 
-- 
2.2.2
