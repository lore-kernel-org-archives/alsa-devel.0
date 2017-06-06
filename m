From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ALSA: timer: Wrap with spinlock for queue
	access
Date: Tue,  6 Jun 2017 17:00:43 +0200
Message-ID: <20170606150043.10525-5-tiwai@suse.de>
References: <20170606150043.10525-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 083C4266F11
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

For accessing the snd_timer_user queue indices, we take tu->qlock.
But it's forgotten in a couple of places.

The one in snd_timer_user_params() should be safe without the
spinlock as the timer is already stopped.  But it's better for
consistency.

The one in poll is just a read-out, so it's not inevitably needed, but
it'd be good to make the result consistent, too.

Tested-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 96cffb1be57f..148290ace756 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1755,6 +1755,7 @@ static int snd_timer_user_params(struct file *file,
 		if (err < 0)
 			goto _end;
 	}
+	spin_lock_irq(&tu->qlock);
 	tu->qhead = tu->qtail = tu->qused = 0;
 	if (tu->timeri->flags & SNDRV_TIMER_IFLG_EARLY_EVENT) {
 		if (tu->tread) {
@@ -1775,6 +1776,7 @@ static int snd_timer_user_params(struct file *file,
 	}
 	tu->filter = params.filter;
 	tu->ticks = params.ticks;
+	spin_unlock_irq(&tu->qlock);
 	err = 0;
  _end:
 	if (copy_to_user(_params, &params, sizeof(params)))
@@ -2022,10 +2024,12 @@ static unsigned int snd_timer_user_poll(struct file *file, poll_table * wait)
         poll_wait(file, &tu->qchange_sleep, wait);
 
 	mask = 0;
+	spin_lock_irq(&tu->qlock);
 	if (tu->qused)
 		mask |= POLLIN | POLLRDNORM;
 	if (tu->disconnected)
 		mask |= POLLERR;
+	spin_unlock_irq(&tu->qlock);
 
 	return mask;
 }
-- 
2.13.0
