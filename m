From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ALSA: seq_timer: use monotonic times internally
Date: Fri, 17 Jun 2016 17:10:32 +0200
Message-ID: <20160617151054.3993410-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The sequencer client manager reports timestamps in units of unsigned
32-bit seconds/nanoseconds, but that does not suffer from the y2038
overflow because it stores only the delta since the 'last_update'
time was recorded.

However, the use of the do_gettimeofday() function is problematic
and we have to replace it to avoid the overflow on on 32-bit
architectures.

This uses 'struct timespec64' to record 'last_update', and changes
the code to use monotonic timestamps that do not suffer from leap
seconds and settimeofday updates.

As a side-effect, the code can now use the timespec64_sub() helper
and become more readable and also avoid a multiplication to convert
from microseconds to nanoseconds.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/core/seq/seq_timer.c | 23 +++++++++--------------
 sound/core/seq/seq_timer.h |  2 +-
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/sound/core/seq/seq_timer.c b/sound/core/seq/seq_timer.c
index 293104926098..dcc102813aef 100644
--- a/sound/core/seq/seq_timer.c
+++ b/sound/core/seq/seq_timer.c
@@ -165,7 +165,7 @@ static void snd_seq_timer_interrupt(struct snd_timer_instance *timeri,
 	snd_seq_timer_update_tick(&tmr->tick, resolution);
 
 	/* register actual time of this timer update */
-	do_gettimeofday(&tmr->last_update);
+	ktime_get_ts64(&tmr->last_update);
 
 	spin_unlock_irqrestore(&tmr->lock, flags);
 
@@ -392,7 +392,7 @@ static int seq_timer_start(struct snd_seq_timer *tmr)
 		return -EINVAL;
 	snd_timer_start(tmr->timeri, tmr->ticks);
 	tmr->running = 1;
-	do_gettimeofday(&tmr->last_update);
+	ktime_get_ts64(&tmr->last_update);
 	return 0;
 }
 
@@ -420,7 +420,7 @@ static int seq_timer_continue(struct snd_seq_timer *tmr)
 	}
 	snd_timer_start(tmr->timeri, tmr->ticks);
 	tmr->running = 1;
-	do_gettimeofday(&tmr->last_update);
+	ktime_get_ts64(&tmr->last_update);
 	return 0;
 }
 
@@ -444,17 +444,12 @@ snd_seq_real_time_t snd_seq_timer_get_cur_time(struct snd_seq_timer *tmr)
 	spin_lock_irqsave(&tmr->lock, flags);
 	cur_time = tmr->cur_time;
 	if (tmr->running) { 
-		struct timeval tm;
-		int usec;
-		do_gettimeofday(&tm);
-		usec = (int)(tm.tv_usec - tmr->last_update.tv_usec);
-		if (usec < 0) {
-			cur_time.tv_nsec += (1000000 + usec) * 1000;
-			cur_time.tv_sec += tm.tv_sec - tmr->last_update.tv_sec - 1;
-		} else {
-			cur_time.tv_nsec += usec * 1000;
-			cur_time.tv_sec += tm.tv_sec - tmr->last_update.tv_sec;
-		}
+		struct timespec64 tm;
+
+		ktime_get_ts64(&tm);
+		tm = timespec64_sub(tm, tmr->last_update);
+		cur_time.tv_nsec = tm.tv_nsec;
+		cur_time.tv_sec = tm.tv_sec;
 		snd_seq_sanity_real_time(&cur_time);
 	}
 	spin_unlock_irqrestore(&tmr->lock, flags);
diff --git a/sound/core/seq/seq_timer.h b/sound/core/seq/seq_timer.h
index 88dfb71805ae..9506b661fe5b 100644
--- a/sound/core/seq/seq_timer.h
+++ b/sound/core/seq/seq_timer.h
@@ -52,7 +52,7 @@ struct snd_seq_timer {
 	unsigned int skew;
 	unsigned int skew_base;
 
-	struct timeval 		last_update;	 /* time of last clock update, used for interpolation */
+	struct timespec64	last_update;	 /* time of last clock update, used for interpolation */
 
 	spinlock_t lock;
 };
-- 
2.9.0
