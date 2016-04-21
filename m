From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hrtimer: Use manual start/stop in
	callback
Date: Thu, 21 Apr 2016 16:13:41 +0200
Message-ID: <1461248021-22624-3-git-send-email-tiwai@suse.de>
References: <1461248021-22624-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AA11B2666BD
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 16:13:42 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 495E8AC55
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 14:13:40 +0000 (UTC)
In-Reply-To: <1461248021-22624-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

With the new SNDRV_TIMER_HW_RET_CTRL flag, hrtimer can manage the
callback behavior more correctly.  Now it gets a return value from
snd_timer_interrupt() whether to reprogram or stop the timer, and it
can choose the right return value.

The biggest bonus by this change is that we can protect the whole
interrupt with a spinlock against start/stop calls from another
thread.  The patch adds a spinlock and converts the former atomic flag
into a normal bool flag.

Hopefully this fixes the still remaining races spotted (but fairly
rarely) by syzkaller fuzzer.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/hrtimer.c | 51 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/sound/core/hrtimer.c b/sound/core/hrtimer.c
index 656d9a9032dc..8a1b51473fd5 100644
--- a/sound/core/hrtimer.c
+++ b/sound/core/hrtimer.c
@@ -38,7 +38,8 @@ static unsigned int resolution;
 struct snd_hrtimer {
 	struct snd_timer *timer;
 	struct hrtimer hrt;
-	atomic_t running;
+	spinlock_t lock;
+	bool running;
 };
 
 static enum hrtimer_restart snd_hrtimer_callback(struct hrtimer *hrt)
@@ -46,16 +47,33 @@ static enum hrtimer_restart snd_hrtimer_callback(struct hrtimer *hrt)
 	struct snd_hrtimer *stime = container_of(hrt, struct snd_hrtimer, hrt);
 	struct snd_timer *t = stime->timer;
 	unsigned long oruns;
+	int irq_ret;
+	enum hrtimer_restart ret = HRTIMER_NORESTART;
+	unsigned long flags;
 
-	if (!atomic_read(&stime->running))
-		return HRTIMER_NORESTART;
+	spin_lock_irqsave(&stime->lock, flags);
+	if (!stime->running)
+		goto unlock;
 
 	oruns = hrtimer_forward_now(hrt, ns_to_ktime(t->sticks * resolution));
-	snd_timer_interrupt(stime->timer, t->sticks * oruns);
+	irq_ret = snd_timer_interrupt(stime->timer, t->sticks * oruns);
+
+	switch (irq_ret) {
+	case SNDRV_TIMER_RET_START:
+		hrtimer_start(&stime->hrt, ns_to_ktime(t->sticks * resolution),
+			      HRTIMER_MODE_REL);
+		/* fallthru */
+	case SNDRV_TIMER_RET_NONE:
+		ret = HRTIMER_RESTART;
+		break;
+	default:
+		stime->running = false;
+		break; /* HRTIMER_NORESTART */
+	}
 
-	if (!atomic_read(&stime->running))
-		return HRTIMER_NORESTART;
-	return HRTIMER_RESTART;
+ unlock:
+	spin_unlock_irqrestore(&stime->lock, flags);
+	return  ret;
 }
 
 static int snd_hrtimer_open(struct snd_timer *t)
@@ -68,7 +86,8 @@ static int snd_hrtimer_open(struct snd_timer *t)
 	hrtimer_init(&stime->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	stime->timer = t;
 	stime->hrt.function = snd_hrtimer_callback;
-	atomic_set(&stime->running, 0);
+	spin_lock_init(&stime->lock);
+	stime->running = false;
 	t->private_data = stime;
 	return 0;
 }
@@ -88,25 +107,31 @@ static int snd_hrtimer_close(struct snd_timer *t)
 static int snd_hrtimer_start(struct snd_timer *t)
 {
 	struct snd_hrtimer *stime = t->private_data;
+	unsigned long flags;
 
-	atomic_set(&stime->running, 0);
-	hrtimer_try_to_cancel(&stime->hrt);
+	spin_lock_irqsave(&stime->lock, flags);
 	hrtimer_start(&stime->hrt, ns_to_ktime(t->sticks * resolution),
 		      HRTIMER_MODE_REL);
-	atomic_set(&stime->running, 1);
+	stime->running = true;
+	spin_unlock_irqrestore(&stime->lock, flags);
 	return 0;
 }
 
 static int snd_hrtimer_stop(struct snd_timer *t)
 {
 	struct snd_hrtimer *stime = t->private_data;
-	atomic_set(&stime->running, 0);
+	unsigned long flags;
+
+	spin_lock_irqsave(&stime->lock, flags);
 	hrtimer_try_to_cancel(&stime->hrt);
+	stime->running = false;
+	spin_unlock_irqrestore(&stime->lock, flags);
 	return 0;
 }
 
 static struct snd_timer_hardware hrtimer_hw = {
-	.flags =	SNDRV_TIMER_HW_AUTO | SNDRV_TIMER_HW_TASKLET,
+	.flags =	SNDRV_TIMER_HW_AUTO | SNDRV_TIMER_HW_TASKLET |
+			SNDRV_TIMER_HW_RET_CTRL,
 	.open =		snd_hrtimer_open,
 	.close =	snd_hrtimer_close,
 	.start =	snd_hrtimer_start,
-- 
2.8.1
