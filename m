From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ALSA: timer: Improve user queue
	reallocation
Date: Tue,  6 Jun 2017 17:00:42 +0200
Message-ID: <20170606150043.10525-4-tiwai@suse.de>
References: <20170606150043.10525-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 07069266F0F
 for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2017 17:00:50 +0200 (CEST)
In-Reply-To: <20170606150043.10525-1-tiwai@suse.de>
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
Cc: Kostya Serebryany <kcc@google.com>, Alexander Potapenko <glider@google.com>, Dmitriy Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@google.com>
List-Id: alsa-devel@alsa-project.org

ALSA timer may reallocate the user queue upon request, and it happens
at three places for now: at opening, at SNDRV_TIMER_IOCTL_PARAMS, and
at SNDRV_TIMER_IOCTL_SELECT.  However, the last one,
snd_timer_user_tselect(), doesn't need to reallocate the buffer since
it doesn't change the queue size.  It does just because tu->tread
might have been changed before starting the timer.

Instead of *_SELECT ioctl, we should reallocate the queue at
SNDRV_TIMER_IOCTL_TREAD; then the timer is guaranteed to be stopped,
thus we can reassign the buffer more safely.

This patch implements that with a slight code refactoring.
Essentially, the patch achieves:
- Introduce realloc_user_queue() for (re-)allocating the ring buffer,
  and call it from all places.  Also, realloc_user_queue() uses
  kcalloc() for avoiding possible leaks.
- Add the buffer reallocation at SNDRV_TIMER_IOCTL_TREAD.  When it
  fails, tu->tread is restored to the old value, too.
- Drop the buffer reallocation at snd_timer_user_tselect().

Tested-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 94 +++++++++++++++++++++++++-----------------------------
 1 file changed, 43 insertions(+), 51 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index cd67d1c12cf1..96cffb1be57f 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1327,6 +1327,33 @@ static void snd_timer_user_tinterrupt(struct snd_timer_instance *timeri,
 	wake_up(&tu->qchange_sleep);
 }
 
+static int realloc_user_queue(struct snd_timer_user *tu, int size)
+{
+	struct snd_timer_read *queue = NULL;
+	struct snd_timer_tread *tqueue = NULL;
+
+	if (tu->tread) {
+		tqueue = kcalloc(size, sizeof(*tqueue), GFP_KERNEL);
+		if (!tqueue)
+			return -ENOMEM;
+	} else {
+		queue = kcalloc(size, sizeof(*queue), GFP_KERNEL);
+		if (!queue)
+			return -ENOMEM;
+	}
+
+	spin_lock_irq(&tu->qlock);
+	kfree(tu->queue);
+	kfree(tu->tqueue);
+	tu->queue_size = size;
+	tu->queue = queue;
+	tu->tqueue = tqueue;
+	tu->qhead = tu->qtail = tu->qused = 0;
+	spin_unlock_irq(&tu->qlock);
+
+	return 0;
+}
+
 static int snd_timer_user_open(struct inode *inode, struct file *file)
 {
 	struct snd_timer_user *tu;
@@ -1343,10 +1370,7 @@ static int snd_timer_user_open(struct inode *inode, struct file *file)
 	init_waitqueue_head(&tu->qchange_sleep);
 	mutex_init(&tu->ioctl_lock);
 	tu->ticks = 1;
-	tu->queue_size = 128;
-	tu->queue = kmalloc(tu->queue_size * sizeof(struct snd_timer_read),
-			    GFP_KERNEL);
-	if (tu->queue == NULL) {
+	if (realloc_user_queue(tu, 128) < 0) {
 		kfree(tu);
 		return -ENOMEM;
 	}
@@ -1618,34 +1642,12 @@ static int snd_timer_user_tselect(struct file *file,
 	if (err < 0)
 		goto __err;
 
-	tu->qhead = tu->qtail = tu->qused = 0;
-	kfree(tu->queue);
-	tu->queue = NULL;
-	kfree(tu->tqueue);
-	tu->tqueue = NULL;
-	if (tu->tread) {
-		tu->tqueue = kmalloc(tu->queue_size * sizeof(struct snd_timer_tread),
-				     GFP_KERNEL);
-		if (tu->tqueue == NULL)
-			err = -ENOMEM;
-	} else {
-		tu->queue = kmalloc(tu->queue_size * sizeof(struct snd_timer_read),
-				    GFP_KERNEL);
-		if (tu->queue == NULL)
-			err = -ENOMEM;
-	}
-
-      	if (err < 0) {
-		snd_timer_close(tu->timeri);
-      		tu->timeri = NULL;
-      	} else {
-		tu->timeri->flags |= SNDRV_TIMER_IFLG_FAST;
-		tu->timeri->callback = tu->tread
+	tu->timeri->flags |= SNDRV_TIMER_IFLG_FAST;
+	tu->timeri->callback = tu->tread
 			? snd_timer_user_tinterrupt : snd_timer_user_interrupt;
-		tu->timeri->ccallback = snd_timer_user_ccallback;
-		tu->timeri->callback_data = (void *)tu;
-		tu->timeri->disconnect = snd_timer_user_disconnect;
-	}
+	tu->timeri->ccallback = snd_timer_user_ccallback;
+	tu->timeri->callback_data = (void *)tu;
+	tu->timeri->disconnect = snd_timer_user_disconnect;
 
       __err:
 	return err;
@@ -1687,8 +1689,6 @@ static int snd_timer_user_params(struct file *file,
 	struct snd_timer_user *tu;
 	struct snd_timer_params params;
 	struct snd_timer *t;
-	struct snd_timer_read *tr;
-	struct snd_timer_tread *ttr;
 	int err;
 
 	tu = file->private_data;
@@ -1751,23 +1751,9 @@ static int snd_timer_user_params(struct file *file,
 	spin_unlock_irq(&t->lock);
 	if (params.queue_size > 0 &&
 	    (unsigned int)tu->queue_size != params.queue_size) {
-		if (tu->tread) {
-			ttr = kmalloc(params.queue_size * sizeof(*ttr),
-				      GFP_KERNEL);
-			if (ttr) {
-				kfree(tu->tqueue);
-				tu->queue_size = params.queue_size;
-				tu->tqueue = ttr;
-			}
-		} else {
-			tr = kmalloc(params.queue_size * sizeof(*tr),
-				     GFP_KERNEL);
-			if (tr) {
-				kfree(tu->queue);
-				tu->queue_size = params.queue_size;
-				tu->queue = tr;
-			}
-		}
+		err = realloc_user_queue(tu, params.queue_size);
+		if (err < 0)
+			goto _end;
 	}
 	tu->qhead = tu->qtail = tu->qused = 0;
 	if (tu->timeri->flags & SNDRV_TIMER_IFLG_EARLY_EVENT) {
@@ -1891,13 +1877,19 @@ static long __snd_timer_user_ioctl(struct file *file, unsigned int cmd,
 		return snd_timer_user_next_device(argp);
 	case SNDRV_TIMER_IOCTL_TREAD:
 	{
-		int xarg;
+		int xarg, old_tread;
 
 		if (tu->timeri)	/* too late */
 			return -EBUSY;
 		if (get_user(xarg, p))
 			return -EFAULT;
+		old_tread = tu->tread;
 		tu->tread = xarg ? 1 : 0;
+		if (tu->tread != old_tread &&
+		    realloc_user_queue(tu, tu->queue_size) < 0) {
+			tu->tread = old_tread;
+			return -ENOMEM;
+		}
 		return 0;
 	}
 	case SNDRV_TIMER_IOCTL_GINFO:
-- 
2.13.0
