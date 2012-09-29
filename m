From: Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
Subject: [PATCH] ALSA: aloop - add locking to timer access
Date: Sat, 29 Sep 2012 12:24:05 +0530
Message-ID: <1348901645-12451-1-git-send-email-omair.m.abdullah@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id EF8B32615CC
 for <alsa-devel@alsa-project.org>; Sat, 29 Sep 2012 08:53:20 +0200 (CEST)
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

When the loopback timer handler is running, calling del_timer() (for STOP
trigger) will not wait for the handler to complete before deactivating the
timer. The timer gets rescheduled in the handler as usual. Then a subsequent
START trigger will try to start the timer using add_timer() with a timer pending
leading to a kernel panic.

Serialize the calls to add_timer() and del_timer() using a spin lock to avoid
this.

Signed-off-by: Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
---
 sound/drivers/aloop.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 5a34355..0fe6d64 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -120,6 +120,7 @@ struct loopback_pcm {
 	unsigned int last_drift;
 	unsigned long last_jiffies;
 	struct timer_list timer;
+	spinlock_t timer_lock;
 };
 
 static struct platform_device *devices[SNDRV_CARDS];
@@ -170,6 +171,7 @@ static void loopback_timer_start(struct loopback_pcm *dpcm)
 	unsigned long tick;
 	unsigned int rate_shift = get_rate_shift(dpcm);
 
+	spin_lock(&dpcm->timer_lock);
 	if (rate_shift != dpcm->pcm_rate_shift) {
 		dpcm->pcm_rate_shift = rate_shift;
 		dpcm->period_size_frac = frac_pos(dpcm, dpcm->pcm_period_size);
@@ -182,12 +184,15 @@ static void loopback_timer_start(struct loopback_pcm *dpcm)
 	tick = (tick + dpcm->pcm_bps - 1) / dpcm->pcm_bps;
 	dpcm->timer.expires = jiffies + tick;
 	add_timer(&dpcm->timer);
+	spin_unlock(&dpcm->timer_lock);
 }
 
 static inline void loopback_timer_stop(struct loopback_pcm *dpcm)
 {
+	spin_lock(&dpcm->timer_lock);
 	del_timer(&dpcm->timer);
 	dpcm->timer.expires = 0;
+	spin_unlock(&dpcm->timer_lock);
 }
 
 #define CABLE_VALID_PLAYBACK	(1 << SNDRV_PCM_STREAM_PLAYBACK)
@@ -667,6 +672,7 @@ static int loopback_open(struct snd_pcm_substream *substream)
 	dpcm->substream = substream;
 	setup_timer(&dpcm->timer, loopback_timer_function,
 		    (unsigned long)dpcm);
+	spin_lock_init(&dpcm->timer_lock);
 
 	cable = loopback->cables[substream->number][dev];
 	if (!cable) {
-- 
1.7.4.1
