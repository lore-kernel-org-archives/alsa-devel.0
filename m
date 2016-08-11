From: Andrej Krutak <dev@andree.sk>
Subject: [PATCH 10/15] ALSA: line6: Add proper locks for hwdep
	open/release/read
Date: Thu, 11 Aug 2016 21:02:22 +0200
Message-ID: <1470942147-19848-11-git-send-email-dev@andree.sk>
References: <1470942147-19848-1-git-send-email-dev@andree.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id B80DE267754
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 21:04:06 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id i5so932975wmg.2
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 12:04:06 -0700 (PDT)
In-Reply-To: <1470942147-19848-1-git-send-email-dev@andree.sk>
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
Cc: Andrej Krutak <dev@andree.sk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Andrej Krutak <dev@andree.sk>
---
 sound/usb/line6/driver.c | 16 +++++++++++-----
 sound/usb/line6/driver.h |  3 ++-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 0a0e324..344465f 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -541,8 +541,7 @@ static int line6_hwdep_open(struct snd_hwdep *hw, struct file *file)
 	line6->buffer_circular.head = 0;
 	line6->buffer_circular.tail = 0;
 	sema_init(&line6->buffer_circular.sem, 0);
-
-	line6->buffer_circular.active = 1;
+	spin_lock_init(&line6->buffer_circular.read_lock);
 
 	line6->buffer_circular.data =
 		kmalloc(LINE6_MESSAGE_MAXLEN * LINE6_MESSAGE_MAXCOUNT, GFP_KERNEL);
@@ -567,7 +566,7 @@ static int line6_hwdep_release(struct snd_hwdep *hw, struct file *file)
 
 	/* By this time, no readers are waiting, we can safely recreate the
 	 * semaphore at next open. */
-	line6->buffer_circular.active = 0;
+	clear_bit(0, &line6->buffer_circular.active);
 
 	kfree(line6->buffer_circular.data);
 	kfree(line6->buffer_circular.data_len);
@@ -581,18 +580,23 @@ line6_hwdep_read(struct snd_hwdep *hwdep, char __user *buf, long count,
 {
 	struct usb_line6 *line6 = hwdep->private_data;
 	unsigned long tail;
+	long rv = 0;
 
 	if (down_interruptible(&line6->buffer_circular.sem)) {
 		return -ERESTARTSYS;
 	}
 	/* There must an item now in the buffer... */
 
+	spin_lock(&line6->buffer_circular.read_lock);
+
 	tail = line6->buffer_circular.tail;
 
 	if (line6->buffer_circular.data_len[tail] > count) {
 		/* Buffer too small; allow re-read of the current item... */
 		up(&line6->buffer_circular.sem);
-		return -EINVAL;
+
+		rv = -EINVAL;
+		goto end;
 	}
 
 	if (copy_to_user(buf,
@@ -608,7 +612,9 @@ line6_hwdep_read(struct snd_hwdep *hwdep, char __user *buf, long count,
 	smp_store_release(&line6->buffer_circular.tail,
 				(tail + 1) & (LINE6_MESSAGE_MAXCOUNT - 1));
 
-	return 0;
+end:
+	spin_unlock(&line6->buffer_circular.read_lock);
+	return rv;
 }
 
 /* Write directly (no buffering) to device by user*/
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index f4ab6cd..05e155c 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -159,12 +159,13 @@ struct usb_line6 {
 
 	/* Circular buffer for non-MIDI control messages */
 	struct {
-		int active;
+		unsigned long active;
 		char *data;
 		int *data_len;
 		unsigned long head, tail;
 		/* Actually is up'd # of items in the buffer - times */
 		struct semaphore sem;
+		spinlock_t read_lock;
 	} buffer_circular;
 
 	/* If MIDI is supported, buffer_message contains the pre-processed data;
-- 
1.9.1
