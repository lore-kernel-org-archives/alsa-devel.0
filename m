From: David Dillow <dave@thedillows.org>
Subject: [PATCH] ALSA: pcm_lib: avoid timing jitter in
	snd_pcm_read/write()
Date: Sat, 26 Jun 2010 18:13:20 -0400
Message-ID: <1277590400.2438.15.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from amavis-smtp.knology.net (amavis-smtp.knology.net [75.76.199.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 26A0C2454D
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 00:13:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, linux@schou.dk
List-Id: alsa-devel@alsa-project.org

When using poll() to wait for the next period -- or avail_min samples --
one gets a consistent delay for each system call that is usually just a
little short of the selected period time. However, When using
snd_pcm_read/write(), one gets a jittery delay that alternates between
less than a millisecond and approximately two period times. This is
caused by snd_pcm_lib_{read,write}1() transferring any available samples
to the user's buffer and adjusting the application pointer prior to
sleeping to the end of the current period. When the next period
interrupt occurs, there is then less than avail_min samples remaining to
be transferred in the period, so we end up sleeping until a second
period occurs.
    
This is solved by using runtime->twake as the number of samples needed
for a wakeup in addition to selecting the proper wait queue to wake in
snd_pcm_update_state(). This requires twake to be non-zero when used
by snd_pcm_lib_{read,write}1() even if avail_min is zero.
    
Signed-off-by: Dave Dillow <dave@thedillows.org>
---
Hans, you may want this one as well for the SIS7019, as it gives more
margin to deal with captured data on alternating calls into the stack.

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index dd76cde..83c6fa6 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -313,7 +313,7 @@ struct snd_pcm_runtime {
 	struct snd_pcm_mmap_control *control;
 
 	/* -- locking / scheduling -- */
-	unsigned int twake: 1;		/* do transfer (!poll) wakeup */
+	snd_pcm_uframes_t twake; 	/* do transfer (!poll) wakeup if non-zero */
 	wait_queue_head_t sleep;	/* poll sleep */
 	wait_queue_head_t tsleep;	/* transfer sleep */
 	struct fasync_struct *fasync;
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index e9d98be..bcf95d3 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -287,8 +287,11 @@ int snd_pcm_update_state(struct snd_pcm_substream *substream,
 			return -EPIPE;
 		}
 	}
-	if (avail >= runtime->control->avail_min)
-		wake_up(runtime->twake ? &runtime->tsleep : &runtime->sleep);
+	if (runtime->twake) {
+		if (avail >= runtime->twake)
+			wake_up(&runtime->tsleep);
+	} else if (avail >= runtime->control->avail_min)
+		wake_up(&runtime->sleep);
 	return 0;
 }
 
@@ -1707,7 +1710,7 @@ EXPORT_SYMBOL(snd_pcm_period_elapsed);
  * The available space is stored on availp.  When err = 0 and avail = 0
  * on the capture stream, it indicates the stream is in DRAINING state.
  */
-static int wait_for_avail_min(struct snd_pcm_substream *substream,
+static int wait_for_avail(struct snd_pcm_substream *substream,
 			      snd_pcm_uframes_t *availp)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
@@ -1757,7 +1760,7 @@ static int wait_for_avail_min(struct snd_pcm_substream *substream,
 			avail = snd_pcm_playback_avail(runtime);
 		else
 			avail = snd_pcm_capture_avail(runtime);
-		if (avail >= runtime->control->avail_min)
+		if (avail >= runtime->twake)
 			break;
 	}
  _endloop:
@@ -1820,7 +1823,7 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream,
 		goto _end_unlock;
 	}
 
-	runtime->twake = 1;
+	runtime->twake = runtime->control->avail_min ? : 1;
 	while (size > 0) {
 		snd_pcm_uframes_t frames, appl_ptr, appl_ofs;
 		snd_pcm_uframes_t avail;
@@ -1833,7 +1836,9 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream,
 				err = -EAGAIN;
 				goto _end_unlock;
 			}
-			err = wait_for_avail_min(substream, &avail);
+			runtime->twake = min_t(snd_pcm_uframes_t, size,
+					runtime->control->avail_min ? : 1);
+			err = wait_for_avail(substream, &avail);
 			if (err < 0)
 				goto _end_unlock;
 		}
@@ -2042,7 +2047,7 @@ static snd_pcm_sframes_t snd_pcm_lib_read1(struct snd_pcm_substream *substream,
 		goto _end_unlock;
 	}
 
-	runtime->twake = 1;
+	runtime->twake = runtime->control->avail_min ? : 1;
 	while (size > 0) {
 		snd_pcm_uframes_t frames, appl_ptr, appl_ofs;
 		snd_pcm_uframes_t avail;
@@ -2060,7 +2065,9 @@ static snd_pcm_sframes_t snd_pcm_lib_read1(struct snd_pcm_substream *substream,
 				err = -EAGAIN;
 				goto _end_unlock;
 			}
-			err = wait_for_avail_min(substream, &avail);
+			runtime->twake = min_t(snd_pcm_uframes_t, size,
+					runtime->control->avail_min ? : 1);
+			err = wait_for_avail(substream, &avail);
 			if (err < 0)
 				goto _end_unlock;
 			if (!avail)
