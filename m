From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] rawmidi/ctl/timer read() blocks too long
Date: Mon, 05 Aug 2002 10:43:36 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D4E3AB8.9E3A1271@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org


When read() can return some data, is mustn't sleep.
The behaviour of snd_ctl_hw_read() doesn't change as it reads only one
event at a time anyway.
The behaviour of snd_rawmidi_read() does change, but now it's compatible
to OSS rawmidi devices.

I added set_current_state(TASK_RUNNING) to snd_timer_user_read() because
other sleep loops have this, too.
Furthermore, if there is an error when some data has already been read
successfully, snd_timer_user_read() should return this data instead of
the error.


diff -ur alsa-kernel.org/core/control.c alsa-kernel/core/control.c
--- alsa-kernel.org/core/control.c	Sat Aug  3 18:01:01 2002
+++ alsa-kernel/core/control.c	Sun Aug  4 16:54:37 2002
@@ -660,7 +660,7 @@
 		snd_kctl_event_t *kev;
 		while (list_empty(&ctl->events)) {
 			wait_queue_t wait;
-			if (file->f_flags & O_NONBLOCK) {
+			if (file->f_flags & O_NONBLOCK || result > 0) {
 				err = -EAGAIN;
 				goto __end;
 			}
diff -ur alsa-kernel.org/core/rawmidi.c alsa-kernel/core/rawmidi.c
--- alsa-kernel.org/core/rawmidi.c	Sat Aug  3 18:01:01 2002
+++ alsa-kernel/core/rawmidi.c	Sun Aug  4 16:40:29 2002
@@ -943,7 +943,7 @@
 		spin_lock_irq(&runtime->lock);
 		while (!snd_rawmidi_ready(substream)) {
 			wait_queue_t wait;
-			if (file->f_flags & O_NONBLOCK) {
+			if (file->f_flags & O_NONBLOCK || result > 0) {
 				spin_unlock_irq(&runtime->lock);
 				return result > 0 ? result : -EAGAIN;
 			}
diff -ur alsa-kernel.org/core/timer.c alsa-kernel/core/timer.c
--- alsa-kernel.org/core/timer.c	Sat Aug  3 18:01:01 2002
+++ alsa-kernel/core/timer.c	Sun Aug  4 16:44:41 2002
@@ -1270,7 +1270,7 @@
 		while (!tu->qused) {
 			wait_queue_t wait;
 
-			if (file->f_flags & O_NONBLOCK) {
+			if (file->f_flags & O_NONBLOCK || result > 0) {
 				spin_unlock_irq(&tu->qlock);
 				err = -EAGAIN;
 				break;
@@ -1285,6 +1285,7 @@
 			spin_lock_irq(&tu->qlock);
 
 			remove_wait_queue(&tu->qchange_sleep, &wait);
+			set_current_state(TASK_RUNNING);
 
 			if (signal_pending(current)) {
 				err = -ERESTARTSYS;
@@ -1307,7 +1308,7 @@
 		result += sizeof(snd_timer_read_t);
 		buffer += sizeof(snd_timer_read_t);
 	}
-	return err? err: result;
+	return result > 0 ? result : err;
 }
 
 static unsigned int snd_timer_user_poll(struct file *file, poll_table * wait)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
