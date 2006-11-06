From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] sound/core/control.c: remove dead code
Date: Mon, 6 Nov 2006 19:30:18 +0100
Message-ID: <20061106183018.GB8099@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 18394260
	for <alsa-devel@alsa-project.org>; Mon,  6 Nov 2006 19:30:22 +0100 (MET)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: perex@suse.cz, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch removes some obviously dead code spotted by the Coverity 
checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/sound/core/control.c.old	2006-11-06 19:11:32.000000000 +0100
+++ linux-2.6/sound/core/control.c	2006-11-06 19:11:52.000000000 +0100
@@ -1267,23 +1267,23 @@ static ssize_t snd_ctl_read(struct file 
 			if ((file->f_flags & O_NONBLOCK) != 0 || result > 0) {
 				err = -EAGAIN;
 				goto __end_lock;
 			}
 			init_waitqueue_entry(&wait, current);
 			add_wait_queue(&ctl->change_sleep, &wait);
 			set_current_state(TASK_INTERRUPTIBLE);
 			spin_unlock_irq(&ctl->read_lock);
 			schedule();
 			remove_wait_queue(&ctl->change_sleep, &wait);
 			if (signal_pending(current))
-				return result > 0 ? result : -ERESTARTSYS;
+				return -ERESTARTSYS;
 			spin_lock_irq(&ctl->read_lock);
 		}
 		kev = snd_kctl_event(ctl->events.next);
 		ev.type = SNDRV_CTL_EVENT_ELEM;
 		ev.data.elem.mask = kev->mask;
 		ev.data.elem.id = kev->id;
 		list_del(&kev->list);
 		spin_unlock_irq(&ctl->read_lock);
 		kfree(kev);
 		if (copy_to_user(buffer, &ev, sizeof(struct snd_ctl_event))) {
 			err = -EFAULT;

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
