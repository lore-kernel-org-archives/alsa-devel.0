From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: control: add .flush operation to release
	blocked operation
Date: Sat, 25 Jul 2015 20:54:00 +0900
Message-ID: <1437825240-11222-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1437825240-11222-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EE292606CD
 for <alsa-devel@alsa-project.org>; Sat, 25 Jul 2015 13:54:16 +0200 (CEST)
In-Reply-To: <1437825240-11222-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ALSA control character devices doesn't release blocking state for
read(2) operations when a file descriptor corresponding to the character
device is closed by close(2). This is due to a blocking loop of
snd_ctl_read() has no breaking point for this event.

Additionally, the read(2) operation reports EBADFD when executed in a
state of unsubscription. On the other hand, this operation continue
to be blocked after unsubscribe operation. In this case, the read(2)
operation should return with EBADFD.

Furthermore, poll(2) operation for the character device can report
some events after close(2).

This commit solves these issues, by adding flush file operation.
The file descriptor becomes unsubscribed state after close(2) operation.
Then, read(2) and poll(2) operations return with expected results.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/core/control.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 196a6fe..0337c16 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -113,6 +113,21 @@ static void snd_ctl_empty_read_queue(struct snd_ctl_file * ctl)
 	spin_unlock_irqrestore(&ctl->read_lock, flags);
 }
 
+static int snd_ctl_flush(struct file *filp, fl_owner_t id)
+{
+	struct snd_ctl_file *cfile = filp->private_data;
+
+	spin_lock(&cfile->read_lock);
+
+	/* Release blocking operations. */
+	cfile->subscribed = 0;
+	wake_up(&cfile->change_sleep);
+
+	spin_unlock(&cfile->read_lock);
+
+	return 0;
+}
+
 static int snd_ctl_release(struct inode *inode, struct file *file)
 {
 	unsigned long flags;
@@ -1380,13 +1395,16 @@ static int snd_ctl_subscribe_events(struct snd_ctl_file *file, int __user *ptr)
 			return -EFAULT;
 		return 0;
 	}
+
+	/* TODO: mutual exclusives. */
 	if (subscribe) {
 		file->subscribed = 1;
-		return 0;
 	} else if (file->subscribed) {
 		snd_ctl_empty_read_queue(file);
 		file->subscribed = 0;
 	}
+	wake_up(&cfile->change_sleep);
+
 	return 0;
 }
 
@@ -1553,6 +1571,8 @@ static ssize_t snd_ctl_read(struct file *file, char __user *buffer,
 			remove_wait_queue(&ctl->change_sleep, &wait);
 			if (ctl->card->shutdown)
 				return -ENODEV;
+			if (ctl->subscribed == 0)
+				return -EBADFD;
 			if (signal_pending(current))
 				return -ERESTARTSYS;
 			spin_lock_irq(&ctl->read_lock);
@@ -1581,17 +1601,20 @@ static ssize_t snd_ctl_read(struct file *file, char __user *buffer,
 
 static unsigned int snd_ctl_poll(struct file *file, poll_table * wait)
 {
-	unsigned int mask;
-	struct snd_ctl_file *ctl;
+	struct snd_ctl_file *ctl = file->private_data;
+	unsigned int mask = 0;
 
-	ctl = file->private_data;
 	if (!ctl->subscribed)
 		return 0;
+
 	poll_wait(file, &ctl->change_sleep, wait);
 
-	mask = 0;
-	if (!list_empty(&ctl->events))
-		mask |= POLLIN | POLLRDNORM;
+	spin_lock(&ctl->read_lock);
+
+	if (!list_empty(&ctl->events) && ctl->subscribed == 1)
+		mask = POLLIN | POLLRDNORM;
+
+	spin_unlock(&ctl->read_lock);
 
 	return mask;
 }
@@ -1733,6 +1756,7 @@ static const struct file_operations snd_ctl_f_ops =
 	.owner =	THIS_MODULE,
 	.read =		snd_ctl_read,
 	.open =		snd_ctl_open,
+	.flush =	snd_ctl_flush,
 	.release =	snd_ctl_release,
 	.llseek =	no_llseek,
 	.poll =		snd_ctl_poll,
-- 
2.1.4
