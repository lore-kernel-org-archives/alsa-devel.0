From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/4] ALSA: timer: Fix race between read and
	ioctl
Date: Tue,  6 Jun 2017 17:00:40 +0200
Message-ID: <20170606150043.10525-2-tiwai@suse.de>
References: <20170606150043.10525-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 05266266F0E
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

The read from ALSA timer device, the function snd_timer_user_tread(),
may access to an uninitialized struct snd_timer_user fields when the
read is concurrently performed while the ioctl like
snd_timer_user_tselect() is invoked.  We have already fixed the races
among ioctls via a mutex, but we seem to have forgotten the race
between read vs ioctl.

This patch simply applies (more exactly extends the already applied
range of) tu->ioctl_lock in snd_timer_user_tread() for closing the
race window.

Reported-by: Alexander Potapenko <glider@google.com>
Tested-by: Alexander Potapenko <glider@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 2f836ca09860..1118bd8e2d3c 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1959,6 +1959,7 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 
 	tu = file->private_data;
 	unit = tu->tread ? sizeof(struct snd_timer_tread) : sizeof(struct snd_timer_read);
+	mutex_lock(&tu->ioctl_lock);
 	spin_lock_irq(&tu->qlock);
 	while ((long)count - result >= unit) {
 		while (!tu->qused) {
@@ -1974,7 +1975,9 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 			add_wait_queue(&tu->qchange_sleep, &wait);
 
 			spin_unlock_irq(&tu->qlock);
+			mutex_unlock(&tu->ioctl_lock);
 			schedule();
+			mutex_lock(&tu->ioctl_lock);
 			spin_lock_irq(&tu->qlock);
 
 			remove_wait_queue(&tu->qchange_sleep, &wait);
@@ -1994,7 +1997,6 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 		tu->qused--;
 		spin_unlock_irq(&tu->qlock);
 
-		mutex_lock(&tu->ioctl_lock);
 		if (tu->tread) {
 			if (copy_to_user(buffer, &tu->tqueue[qhead],
 					 sizeof(struct snd_timer_tread)))
@@ -2004,7 +2006,6 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 					 sizeof(struct snd_timer_read)))
 				err = -EFAULT;
 		}
-		mutex_unlock(&tu->ioctl_lock);
 
 		spin_lock_irq(&tu->qlock);
 		if (err < 0)
@@ -2014,6 +2015,7 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 	}
  _error:
 	spin_unlock_irq(&tu->qlock);
+	mutex_unlock(&tu->ioctl_lock);
 	return result > 0 ? result : err;
 }
 
-- 
2.13.0
