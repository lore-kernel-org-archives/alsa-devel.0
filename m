From: noreply@alsa-project.org
Subject: [ALSA - driver 0000367]: alsamixer problems with preempt
Date: Fri, 16 Jul 2004 12:08:58 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716100858.819EA26008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BE84F254
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:08:58 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000367
======================================================================
Reported By:                Safari
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     367
Category:                   CORE - control
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.6.7-bk18 + gcc-3.4.0
Resolution:                 fixed
======================================================================
Date Submitted:             07-06-2004 06:24 CEST
Last Modified:              07-16-2004 12:08 CEST
======================================================================
Summary:                    alsamixer problems with preempt
Description: 
when I for example mute channels in alsamixer, I get "bad: scheduling while
atomic!".

======================================================================

----------------------------------------------------------------------
 jesse - 07-06-2004 13:31 CEST 
----------------------------------------------------------------------
I got some similar messages here when I try to run xmms with alsa plugin on
2.6.7-bk18.

Jul  6 12:05:10 libra kernel: [<c0105c77>] dump_stack+0x17/0x20
Jul  6 12:05:10 libra kernel: [<c028a300>] schedule+0x4c0/0x4d0
Jul  6 12:05:10 libra kernel: [<c028a77e>] io_schedule+0xe/0x20
Jul  6 12:05:10 libra kernel: [<c0134f05>] __lock_page+0xb5/0xe0
Jul  6 12:05:10 libra kernel: [<c01356e7>]
do_generic_mapping_read+0x397/0x440
Jul  6 12:05:10 libra kernel: [<c0135a30>]
__generic_file_aio_read+0x1d0/0x200
Jul  6 12:05:10 libra kernel: [<c0135b24>] generic_file_read+0x64/0x80
Jul  6 12:05:10 libra kernel: [<c01528a2>] vfs_read+0xa2/0x100
Jul  6 12:05:10 libra kernel: [<c0152ad5>] sys_read+0x35/0x60
Jul  6 12:05:10 libra kernel: [<c0104e89>] sysenter_past_esp+0x52/0x71
Jul  6 12:05:10 libra kernel: [<c0105c77>] dump_stack+0x17/0x20
Jul  6 12:05:10 libra kernel: [<c028a300>] schedule+0x4c0/0x4d0
Jul  6 12:05:10 libra kernel: [<c0104f02>] work_resched+0x5/0x16
Jul  6 12:05:10 libra kernel: [<c0105c77>] dump_stack+0x17/0x20
Jul  6 12:05:10 libra kernel: [<c028a300>] schedule+0x4c0/0x4d0
Jul  6 12:05:10 libra kernel: [<c0104f02>] work_resched+0x5/0x16
Jul  6 12:05:10 libra kernel: [<c0105c77>] dump_stack+0x17/0x20
Jul  6 12:05:10 libra kernel: [<c028a300>] schedule+0x4c0/0x4d0
Jul  6 12:05:10 libra kernel: [<c0104f02>] work_resched+0x5/0x16

After doing this, I can get rid of this problem...

--- linux/sound/core/control.c.orig     2004-07-06 18:38:55.000000000
+0800
+++ linux/sound/core/control.c  2004-07-06 18:39:30.000000000 +0800
@@ -1114,7 +1114,7 @@ static ssize_t snd_ctl_read(struct file
                        wait_queue_t wait;
                        if ((file->f_flags & O_NONBLOCK) != 0 || result >
0) {
                                err = -EAGAIN;
-                               goto out;
+                               goto __end;
                        }
                        init_waitqueue_entry(&wait, current);
                        add_wait_queue(&ctl->change_sleep, &wait);
@@ -1135,7 +1135,7 @@ static ssize_t snd_ctl_read(struct file
                kfree(kev);
                if (copy_to_user(buffer, &ev, sizeof(snd_ctl_event_t))) {
                        err = -EFAULT;
-                       goto __end;
+                       goto out;
                }
                spin_lock_irq(&ctl->read_lock);
                buffer += sizeof(snd_ctl_event_t);

----------------------------------------------------------------------
 Safari - 07-06-2004 14:28 CEST 
----------------------------------------------------------------------
yup, after I applied the patch, spinlocks are now correctly handled
and alsamixer does not freak out.   thanks for the patch :)

----------------------------------------------------------------------
 tiwai - 07-16-2004 12:08 CEST 
----------------------------------------------------------------------
Should have been fixed on cvs.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-06-04 06:24 Safari         New Bug                                      
07-06-04 06:24 Safari         Kernel Version            => 2.6.7-bk18 + gcc-3.4.0
07-06-04 13:31 jesse          Bugnote Added: 0001384                       
07-06-04 14:28 Safari         Bugnote Added: 0001385                       
07-16-04 12:08 tiwai          Bugnote Added: 0001446                       
07-16-04 12:08 tiwai          Assigned To               => tiwai           
07-16-04 12:08 tiwai          Resolution               open => fixed       
07-16-04 12:08 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
