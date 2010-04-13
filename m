From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC] ALSA: pcm_lib - read/write IO improvement
Date: Tue, 13 Apr 2010 14:49:59 +0300
Message-ID: <20100413144959.601bb9db.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f219.google.com (mail-ew0-f219.google.com
	[209.85.219.219])
	by alsa0.perex.cz (Postfix) with ESMTP id BCF731037F7
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 13:49:54 +0200 (CEST)
Received: by ewy19 with SMTP id 19so1671211ewy.22
	for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2010 04:49:53 -0700 (PDT)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi

I've noticed a problem with the ALSA read/write IO as it tries to pad
buffer as full/empty as possible after each wake-up. Then there is no
wake-up during the next period interrupt since avail < avail_min and
effectively there could be very short time left for wake-up on an
interrupt after that.

What I've seen on OMAP3 and Intel HDA that typically avail_max is only
a frame or two less than size of two periods. I.e. very near to xrun
when using a buffer with two periods.

I came up with two ideas. The first one won't do padding and the second
one which does the padding as currently but checks are there available
frames in the next period and does a wake-up if necessary (even if the
avail < avail_min).

With the first one, the avail_max is typically a few frames more than
the size of one period. With the second one it's a few frames less than
size of one period.

So by not doing the padding the distance to xrun is about the same and
the wake-up semantics remains the same. I understood from the thread
below that not all applications like if the wake-up happens before
avail >= avail_min what would happen with the second idea.

http://mailman.alsa-project.org/pipermail/alsa-devel/2009-December/023986.html


-- 
Jarkko

========================== RFC 1 ==========================
From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ALSA: pcm_lib - Do not copy less than avail_min amount of frames in RW IO

Copying less than avail_min amount of frames after each wake-up, i.e. by
padding buffer as full/empty as possible by following the running HW pointer
can actually cause xrun to be more possible than without padding.

Padding causes that the avail is less than the avail_min when the next
period interrupt occurs and thus no wake-up at that time. However, period
interrupt following that one will see a situation where the avail is near
the size of two periods. I.e. there could be only few frames left before
xrun would happen if the buffer size is only two periods.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/core/pcm_lib.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index a2ff861..a47a010 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1821,7 +1821,7 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream,
 		if (runtime->status->state == SNDRV_PCM_STATE_RUNNING)
 			snd_pcm_update_hw_ptr(substream);
 		avail = snd_pcm_playback_avail(runtime);
-		if (!avail) {
+		if (avail < runtime->control->avail_min) {
 			if (nonblock) {
 				err = -EAGAIN;
 				goto _end_unlock;
@@ -2043,7 +2043,7 @@ static snd_pcm_sframes_t snd_pcm_lib_read1(struct snd_pcm_substream *substream,
 		if (runtime->status->state == SNDRV_PCM_STATE_RUNNING)
 			snd_pcm_update_hw_ptr(substream);
 		avail = snd_pcm_capture_avail(runtime);
-		if (!avail) {
+		if (avail < runtime->control->avail_min) {
 			if (runtime->status->state ==
 			    SNDRV_PCM_STATE_DRAINING) {
 				snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
-- 

========================== RFC 2 ==========================
From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH] ALSA: pcm_lib - Do wake-up and copy if the next period has available frames

It is possible that the next period has only a few frames before xrun would
happen after next interrupt but wakeup does not happen now since the avail
is less than the avail_min threshold.

This patch adds a wake-up and copy check if the appl_ptr is less than end of
next period so that application can transfer data already now.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/core/pcm_lib.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index a2ff861..424873d 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -268,7 +268,7 @@ static void xrun_log_show(struct snd_pcm_substream *substream)
 int snd_pcm_update_state(struct snd_pcm_substream *substream,
 			 struct snd_pcm_runtime *runtime)
 {
-	snd_pcm_uframes_t avail;
+	snd_pcm_uframes_t avail, next_end;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		avail = snd_pcm_playback_avail(runtime);
@@ -287,7 +287,11 @@ int snd_pcm_update_state(struct snd_pcm_substream *substream,
 			return -EPIPE;
 		}
 	}
-	if (avail >= runtime->control->avail_min)
+	next_end = runtime->hw_ptr_interrupt + 2 * runtime->period_size - 1;
+	if (next_end >=runtime->boundary)
+		next_end -= runtime->boundary;
+	if (avail >= runtime->control->avail_min ||
+	    runtime->control->appl_ptr <= next_end)
 		wake_up(runtime->twake ? &runtime->tsleep : &runtime->sleep);
 	return 0;
 }
@@ -1707,7 +1711,7 @@ static int wait_for_avail_min(struct snd_pcm_substream *substream,
 	int is_playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	wait_queue_t wait;
 	int err = 0;
-	snd_pcm_uframes_t avail = 0;
+	snd_pcm_uframes_t avail = 0, next_end;
 	long tout;
 
 	init_waitqueue_entry(&wait, current);
@@ -1750,7 +1754,12 @@ static int wait_for_avail_min(struct snd_pcm_substream *substream,
 			avail = snd_pcm_playback_avail(runtime);
 		else
 			avail = snd_pcm_capture_avail(runtime);
-		if (avail >= runtime->control->avail_min)
+		next_end = runtime->hw_ptr_interrupt +
+			   2 * runtime->period_size - 1;
+		if (next_end >=runtime->boundary)
+			next_end -= runtime->boundary;
+		if (avail >= runtime->control->avail_min ||
+		    runtime->control->appl_ptr <= next_end)
 			break;
 	}
  _endloop:
-- 
