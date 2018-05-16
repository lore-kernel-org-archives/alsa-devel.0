From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: timer: Assure timer resolution
	access always locked
Date: Thu, 17 May 2018 00:10:48 +0200
Message-ID: <20180516221048.32221-2-tiwai@suse.de>
References: <20180516221048.32221-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 54E252673A4
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 00:10:53 +0200 (CEST)
In-Reply-To: <20180516221048.32221-1-tiwai@suse.de>
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
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: alsa-devel@alsa-project.org

There are still many places calling the timer's hw.c_resolution
callback without lock, and this may lead to some races, as we faced in
the commit a820ccbe21e8 ("ALSA: pcm: Fix UAF at PCM release via PCM
timer access").

This patch changes snd_timer_resolution() to take the timer->lock for
avoiding the races.  A place calling this function already inside the
lock (from the notifier) is replaced with the
snd_timer_hw_resolution() accordingly, as well as wrapping with the
lock around another place calling snd_timer_hw_resolution(), too.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_timer.c |  4 +---
 sound/core/timer.c         | 21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/sound/core/seq/seq_timer.c b/sound/core/seq/seq_timer.c
index 23167578231f..f587d0e27476 100644
--- a/sound/core/seq/seq_timer.c
+++ b/sound/core/seq/seq_timer.c
@@ -371,9 +371,7 @@ static int initialize_timer(struct snd_seq_timer *tmr)
 
 	tmr->ticks = 1;
 	if (!(t->hw.flags & SNDRV_TIMER_HW_SLAVE)) {
-		unsigned long r = t->hw.resolution;
-		if (! r && t->hw.c_resolution)
-			r = t->hw.c_resolution(t);
+		unsigned long r = snd_timer_resolution(tmr->timeri);
 		if (r) {
 			tmr->ticks = (unsigned int)(1000000000uL / (r * freq));
 			if (! tmr->ticks)
diff --git a/sound/core/timer.c b/sound/core/timer.c
index 23b941df9c43..753a9b9a0074 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -438,19 +438,24 @@ static unsigned long snd_timer_hw_resolution(struct snd_timer *timer)
 unsigned long snd_timer_resolution(struct snd_timer_instance *timeri)
 {
 	struct snd_timer * timer;
+	unsigned long ret = 0;
+	unsigned long flags;
 
 	if (timeri == NULL)
 		return 0;
 	timer = timeri->timer;
-	if (timer)
-		return snd_timer_hw_resolution(timer);
+	if (timer) {
+		spin_lock_irqsave(&timer->lock, flags);
+		ret = snd_timer_hw_resolution(timer);
+		spin_unlock_irqrestore(&timer->lock, flags);
+	}
 	return 0;
 }
 EXPORT_SYMBOL(snd_timer_resolution);
 
 static void snd_timer_notify1(struct snd_timer_instance *ti, int event)
 {
-	struct snd_timer *timer;
+	struct snd_timer *timer = ti->timer;
 	unsigned long resolution = 0;
 	struct snd_timer_instance *ts;
 	struct timespec tstamp;
@@ -462,14 +467,14 @@ static void snd_timer_notify1(struct snd_timer_instance *ti, int event)
 	if (snd_BUG_ON(event < SNDRV_TIMER_EVENT_START ||
 		       event > SNDRV_TIMER_EVENT_PAUSE))
 		return;
-	if (event == SNDRV_TIMER_EVENT_START ||
-	    event == SNDRV_TIMER_EVENT_CONTINUE)
-		resolution = snd_timer_resolution(ti);
+	if (timer &&
+	    (event == SNDRV_TIMER_EVENT_START ||
+	     event == SNDRV_TIMER_EVENT_CONTINUE))
+		resolution = snd_timer_hw_resolution(timer);
 	if (ti->ccallback)
 		ti->ccallback(ti, event, &tstamp, resolution);
 	if (ti->flags & SNDRV_TIMER_IFLG_SLAVE)
 		return;
-	timer = ti->timer;
 	if (timer == NULL)
 		return;
 	if (timer->hw.flags & SNDRV_TIMER_HW_SLAVE)
@@ -1654,6 +1659,7 @@ static int snd_timer_user_gstatus(struct file *file,
 	mutex_lock(&register_mutex);
 	t = snd_timer_find(&tid);
 	if (t != NULL) {
+		spin_lock_irq(&t->lock);
 		gstatus.resolution = snd_timer_hw_resolution(t);
 		if (t->hw.precise_resolution) {
 			t->hw.precise_resolution(t, &gstatus.resolution_num,
@@ -1662,6 +1668,7 @@ static int snd_timer_user_gstatus(struct file *file,
 			gstatus.resolution_num = gstatus.resolution;
 			gstatus.resolution_den = 1000000000uL;
 		}
+		spin_unlock_irq(&t->lock);
 	} else {
 		err = -ENODEV;
 	}
-- 
2.16.3
