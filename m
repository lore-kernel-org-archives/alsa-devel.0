From: noreply@alsa-project.org
Subject: [ALSA - driver 0000367]: alsamixer problems with preempt
Date: Tue, 6 Jul 2004 14:28:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <fe9713c2f9616054a4b86833c2d5b2bd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


A BUGNOTE has been added to this bug.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=3D000=
0367
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Reported By:                Safari
Assigned To:               =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Project:                    ALSA - driver
Bug ID:                     367
Category:                   CORE - control
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:              =20
Kernel Version:             2.6.7-bk18 + gcc-3.4.0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Date Submitted:             07-06-2004 06:24 CEST
Last Modified:              07-06-2004 14:28 CEST
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Summary:                    alsamixer problems with preempt
Description:=20
when I for example mute channels in alsamixer, I get "bad: scheduling whi=
le
atomic!".

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

----------------------------------------------------------------------
 jesse - 07-06-2004 13:31 CEST=20
----------------------------------------------------------------------
I got some similar messages here when I try to run xmms with alsa plugin =
on
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
                        if ((file->f_flags & O_NONBLOCK) !=3D 0 || result=
 >
0) {
                                err =3D -EAGAIN;
-                               goto out;
+                               goto __end;
                        }
                        init_waitqueue_entry(&wait, current);
                        add_wait_queue(&ctl->change_sleep, &wait);
@@ -1135,7 +1135,7 @@ static ssize_t snd_ctl_read(struct file
                kfree(kev);
                if (copy_to_user(buffer, &ev, sizeof(snd_ctl_event_t))) {
                        err =3D -EFAULT;
-                       goto __end;
+                       goto out;
                }
                spin_lock_irq(&ctl->read_lock);
                buffer +=3D sizeof(snd_ctl_event_t);

----------------------------------------------------------------------
 Safari - 07-06-2004 14:28 CEST=20
----------------------------------------------------------------------
yup, after I applied the patch, spinlocks are now correctly handled
and alsamixer does not freak out.   thanks for the patch :)

Bug History
Date Modified  Username       Field                    Change            =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
07-06-04 06:24 Safari         New Bug                                    =
 =20
07-06-04 06:24 Safari         Kernel Version            =3D> 2.6.7-bk18 +
gcc-3.4.0
07-06-04 13:31 jesse          Bugnote Added: 0001384                     =
 =20
07-06-04 14:28 Safari         Bugnote Added: 0001385                     =
 =20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
