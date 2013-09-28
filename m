From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC] ALSA: Reduce delay for a blocking pcm_drain.
Date: Fri, 27 Sep 2013 20:59:45 -0700
Message-ID: <1380340785-30427-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f74.google.com (mail-qe0-f74.google.com
 [209.85.128.74])
 by alsa0.perex.cz (Postfix) with ESMTP id B44EC2650DD
 for <alsa-devel@alsa-project.org>; Sat, 28 Sep 2013 06:00:10 +0200 (CEST)
Received: by mail-qe0-f74.google.com with SMTP id a11so333489qen.5
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 21:00:09 -0700 (PDT)
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

This patch addresses two issues related to calling snd_pcm_drain.

If no_period_wakeup is set, then snd_pcm_drain would wait
MAX_SCHEDULE_TIMEOUT jiffies, without a wakeup pending this will leave
the calling task blocked indefinitely.  Instead block for double the
buffer size played back at a low sample rate (4k chosen arbitrarily).

Also if the stream is running with period wakeups but with a long
period, the delay could be seconds.  If only a small part of the
buffer is being used, this is unnecessary.  Instead wait for the
remaining samples to play out, plus one millisecond.  This allows
systems that fill the buffer only part way to still do a blocking
drain before closing to avoid losing samples.

Change-Id: I84ee1a52d9bdf80ea6065fb9533e565d3e6c8021
Signed-off-by: Dylan Reid <dgreid@chromium.org>
---

This can be worked around in user space as well by using a nonblocking drain and
sleeping based on how many samples are queued.  Would that be the right thing to
do or is this (or something similar) worth fixing here.

To test this I opened a pcm and set no period wakeups, played a few samples and
then called drain, which hung indefinitely.  Using a USB headset with a
max period size of 128k but only 15ms of the buffer filled, having the
drain time shorter without losing samples makes a blocking call
feasible.

---
 sound/core/pcm_native.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index f4aaf5a..a5f0695 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1481,7 +1481,7 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 	}
 
 	for (;;) {
-		long tout;
+		long tout, tout_ms;
 		struct snd_pcm_runtime *to_check;
 		if (signal_pending(current)) {
 			result = -ERESTARTSYS;
@@ -1505,16 +1505,13 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 		snd_pcm_stream_unlock_irq(substream);
 		up_read(&snd_pcm_link_rwsem);
 		snd_power_unlock(card);
-		if (runtime->no_period_wakeup)
-			tout = MAX_SCHEDULE_TIMEOUT;
-		else {
-			tout = 10;
-			if (runtime->rate) {
-				long t = runtime->period_size * 2 / runtime->rate;
-				tout = max(t, tout);
-			}
-			tout = msecs_to_jiffies(tout * 1000);
+		tout_ms = runtime->buffer_size * 2 * 1000 / 4000;
+		if (runtime->rate) {
+			snd_pcm_sframes_t hw_avail;
+			hw_avail = snd_pcm_playback_hw_avail(runtime);
+			tout_ms = 1 + hw_avail * 1000 / runtime->rate;
 		}
+		tout = msecs_to_jiffies(tout_ms);
 		tout = schedule_timeout_interruptible(tout);
 		snd_power_lock(card);
 		down_read(&snd_pcm_link_rwsem);
-- 
1.8.1.3.605.g02339dd
