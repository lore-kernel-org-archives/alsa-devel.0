From: Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
Subject: [PATCH] ALSA: aloop - do not reschedule timer if
	deleted
Date: Wed, 17 Oct 2012 19:05:46 +0530
Message-ID: <1350480946-11732-1-git-send-email-omair.m.abdullah@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CC470265229
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2012 15:35:02 +0200 (CEST)
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@linux.intel.com>, Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

If the timer is deleted while the timer handler is running, it may get
rescheduled and an unnecessary period elapsed will be sent.

Add a flag to reschedule the timer only if it has not been stopped.

Signed-off-by: Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
---
 sound/drivers/aloop.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 0fe6d64..fec4e17 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -121,6 +121,7 @@ struct loopback_pcm {
 	unsigned long last_jiffies;
 	struct timer_list timer;
 	spinlock_t timer_lock;
+	bool timer_stopped;
 };
 
 static struct platform_device *devices[SNDRV_CARDS];
@@ -166,12 +167,11 @@ static inline unsigned int get_rate_shift(struct loopback_pcm *dpcm)
 	return get_setup(dpcm)->rate_shift;
 }
 
-static void loopback_timer_start(struct loopback_pcm *dpcm)
+static void do_timer_start(struct loopback_pcm *dpcm)
 {
 	unsigned long tick;
 	unsigned int rate_shift = get_rate_shift(dpcm);
 
-	spin_lock(&dpcm->timer_lock);
 	if (rate_shift != dpcm->pcm_rate_shift) {
 		dpcm->pcm_rate_shift = rate_shift;
 		dpcm->period_size_frac = frac_pos(dpcm, dpcm->pcm_period_size);
@@ -184,6 +184,13 @@ static void loopback_timer_start(struct loopback_pcm *dpcm)
 	tick = (tick + dpcm->pcm_bps - 1) / dpcm->pcm_bps;
 	dpcm->timer.expires = jiffies + tick;
 	add_timer(&dpcm->timer);
+}
+
+static inline void loopback_timer_start(struct loopback_pcm *dpcm)
+{
+	spin_lock(&dpcm->timer_lock);
+	dpcm->timer_stopped = false;
+	do_timer_start(dpcm);
 	spin_unlock(&dpcm->timer_lock);
 }
 
@@ -192,6 +199,7 @@ static inline void loopback_timer_stop(struct loopback_pcm *dpcm)
 	spin_lock(&dpcm->timer_lock);
 	del_timer(&dpcm->timer);
 	dpcm->timer.expires = 0;
+	dpcm->timer_stopped = true;
 	spin_unlock(&dpcm->timer_lock);
 }
 
@@ -540,7 +548,13 @@ static void loopback_timer_function(unsigned long data)
 
 	running = loopback_pos_update(dpcm->cable);
 	if (running & (1 << dpcm->substream->stream)) {
-		loopback_timer_start(dpcm);
+		spin_lock(&dpcm->timer_lock);
+		if (dpcm->timer_stopped) {
+			spin_unlock(&dpcm->timer_lock);
+			return;
+		}
+		do_timer_start(dpcm);
+		spin_unlock(&dpcm->timer_lock);
 		if (dpcm->period_update_pending) {
 			dpcm->period_update_pending = 0;
 			snd_pcm_period_elapsed(dpcm->substream);
@@ -670,6 +684,7 @@ static int loopback_open(struct snd_pcm_substream *substream)
 	}
 	dpcm->loopback = loopback;
 	dpcm->substream = substream;
+	dpcm->timer_stopped = true;
 	setup_timer(&dpcm->timer, loopback_timer_function,
 		    (unsigned long)dpcm);
 	spin_lock_init(&dpcm->timer_lock);
-- 
1.7.4.1
