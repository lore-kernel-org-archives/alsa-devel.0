From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: timer: Fix race at concurrent reads
Date: Tue,  9 Feb 2016 12:24:10 +0100
Message-ID: <1455017050-21603-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AAD9261785
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2016 12:24:11 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 32A1CAC8E
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2016 11:24:11 +0000 (UTC)
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

snd_timer_user_read() has a potential race among parallel reads, as
qhead and qused are updated outside the critical section due to
copy_to_user() calls.  Move them into the critical section, and also
sanitize the relevant code a bit.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index a0405b0078c6..dca817fc7894 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1933,6 +1933,7 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 {
 	struct snd_timer_user *tu;
 	long result = 0, unit;
+	int qhead;
 	int err = 0;
 
 	tu = file->private_data;
@@ -1944,7 +1945,7 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 
 			if ((file->f_flags & O_NONBLOCK) != 0 || result > 0) {
 				err = -EAGAIN;
-				break;
+				goto _error;
 			}
 
 			set_current_state(TASK_INTERRUPTIBLE);
@@ -1959,42 +1960,37 @@ static ssize_t snd_timer_user_read(struct file *file, char __user *buffer,
 
 			if (tu->disconnected) {
 				err = -ENODEV;
-				break;
+				goto _error;
 			}
 			if (signal_pending(current)) {
 				err = -ERESTARTSYS;
-				break;
+				goto _error;
 			}
 		}
 
+		qhead = tu->qhead++;
+		tu->qhead %= tu->queue_size;
 		spin_unlock_irq(&tu->qlock);
-		if (err < 0)
-			goto _error;
 
 		if (tu->tread) {
-			if (copy_to_user(buffer, &tu->tqueue[tu->qhead++],
-					 sizeof(struct snd_timer_tread))) {
+			if (copy_to_user(buffer, &tu->tqueue[qhead],
+					 sizeof(struct snd_timer_tread)))
 				err = -EFAULT;
-				goto _error;
-			}
 		} else {
-			if (copy_to_user(buffer, &tu->queue[tu->qhead++],
-					 sizeof(struct snd_timer_read))) {
+			if (copy_to_user(buffer, &tu->queue[qhead],
+					 sizeof(struct snd_timer_read)))
 				err = -EFAULT;
-				goto _error;
-			}
 		}
 
-		tu->qhead %= tu->queue_size;
-
-		result += unit;
-		buffer += unit;
-
 		spin_lock_irq(&tu->qlock);
 		tu->qused--;
+		if (err < 0)
+			goto _error;
+		result += unit;
+		buffer += unit;
 	}
-	spin_unlock_irq(&tu->qlock);
  _error:
+	spin_unlock_irq(&tu->qlock);
 	return result > 0 ? result : err;
 }
 
-- 
2.7.1
