From: air icy <icytxw@gmail.com>
Subject: Re: UBSAN: Undefined behaviour in sound/core/timer.c
Date: Sun, 24 Jun 2018 15:11:42 +0800
Message-ID: <CAAzSK-xprFD+pFQ2HCOQgUZ+erC=U4rPZAPEtrWpmx_qPt_1uA@mail.gmail.com>
References: <CAAzSK-ytpsK31p1+_21gEzUT8R=q3+J3ZrhZD_VP=AOC8EfLmQ@mail.gmail.com>
 <s5hpo0geo2v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f67.google.com (mail-pl0-f67.google.com
 [209.85.160.67])
 by alsa0.perex.cz (Postfix) with ESMTP id D2DCC2673F2
 for <alsa-devel@alsa-project.org>; Sun, 24 Jun 2018 09:11:44 +0200 (CEST)
Received: by mail-pl0-f67.google.com with SMTP id d10-v6so5350997plo.5
 for <alsa-devel@alsa-project.org>; Sun, 24 Jun 2018 00:11:44 -0700 (PDT)
In-Reply-To: <s5hpo0geo2v.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

You are a responsible man.
I repro this bug in *https://github.com/lcytxw/bug_repro/tree/master/bug_200213
<https://github.com/lcytxw/bug_repro/tree/master/bug_200213>*
This patch is ok since I can't repro this bug anymore.

Thanks,
Icytxw

2018-06-24 13:43 GMT+08:00 Takashi Iwai <tiwai@suse.de>:

> On Sat, 23 Jun 2018 03:13:41 +0200,
> air icy wrote:
> >
> > Hi,
> > This bug was found in Linux Kernel v4.18-rc2
> > 1521                                         if (id.subdevice < 0)
> > 1522                                                 id.subdevice = 0;
> > 1523                                         else
> > 1524                                                 id.subdevice++;
> > 1525                                 }
> > 1526                         }
> >
> > $ cat report5
> > ============================================================
> ====================
> > UBSAN: Undefined behaviour in sound/core/timer.c:1524:19
> > signed integer overflow:
> > 2147483647 + 1 cannot be represented in type 'int'
> > CPU: 0 PID: 7737 Comm: syz-executor0 Not tainted 4.18.0-rc1 #2
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > rel-1.10.2-0-g5f4c7b1-prebuilt.qemu-project.org 04/01/2014
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x122/0x1c8 lib/dump_stack.c:113
> >  ubsan_epilogue+0x12/0x86 lib/ubsan.c:159
> >  handle_overflow+0x1c2/0x21f lib/ubsan.c:190
> >  __ubsan_handle_add_overflow+0x2a/0x31 lib/ubsan.c:198
> >  snd_timer_user_next_device sound/core/timer.c:1524 [inline]
> >  __snd_timer_user_ioctl+0x204d/0x2520 sound/core/timer.c:1939
> >  snd_timer_user_ioctl+0x67/0x95 sound/core/timer.c:1994
> >  vfs_ioctl fs/ioctl.c:46 [inline]
> >  do_vfs_ioctl+0x1e8/0x1340 fs/ioctl.c:686
> >  ksys_ioctl+0x9c/0xb0 fs/ioctl.c:701
> >  __do_sys_ioctl fs/ioctl.c:708 [inline]
> >  __se_sys_ioctl fs/ioctl.c:706 [inline]
> >  __x64_sys_ioctl+0x81/0xd0 fs/ioctl.c:706
> >  do_syscall_64+0xb8/0x3a0 arch/x86/entry/common.c:290
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x455a09
> > Code: 1d ba fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48
> > 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> > 01 f0 ff ff 0f 83 eb b9 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007f9d190edc68 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007f9d190ee6d4 RCX: 0000000000455a09
> > RDX: 0000000020000200 RSI: 00000000c0145401 RDI: 0000000000000013
> > RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> > R13: 0000000000000359 R14: 00000000006fa0f8 R15: 0000000000000000
> > ============================================================
> ====================
> > SELinux: unrecognized netlink message: protocol=0 nlmsg_type=7
> > sclass=netlink_route_socket pig=7762 comm=syz-executor0
> > SELinux: unrecognized netlink message: protocol=0 nlmsg_type=7
> > sclass=netlink_route_socket pig=7766 comm=syz-executor0
> > sr 1:0:0:0: [sr0] tag#0 FAILED Result: hostbyte=DID_OK
> driverbyte=DRIVER_SENSE
> > sr 1:0:0:0: [sr0] tag#0 Sense Key : Illegal Request [current]
> > sr 1:0:0:0: [sr0] tag#0 Add. Sense: Invalid command operation code
> > sr 1:0:0:0: [sr0] tag#0 CDB: Write(10) 2a 00 00 00 00 00 00 00 40 00
> > print_req_error: critical target error, dev sr0, sector 0
> > ...
> > sr 1:0:0:0: [sr0] tag#0 FAILED Result: hostbyte=DID_ERROR
> driverbyte=DRIVER_OK
> > sr 1:0:0:0: [sr0] tag#0 CDB: Write(16) 8a d0 47 23 7d 8d 1b 64 4d f6 e2
> 4e
> > sr 1:0:0:0: [sr0] tag#0 FAILED Result: hostbyte=DID_ERROR
> driverbyte=DRIVER_OK
> > sr 1:0:0:0: [sr0] tag#0 CDB: Write(16) 8a d0 47 23 7d 8d 1b 64 4d f6 e2
> 4e
> > audit: type=1326 audit(1529712149.140:4): auid=4294967295 uid=0 gid=0
> > ses=4294967295 subj=kernel pid=8226 comm="syz-executor1"
> > exe="/syz-executor1" sig=31 arch=c000003e syscall=202 compat=0
> > ip=0x455a09 code=0x0
> >
> > This bug can be repro, if you need it, please tell me.
> >
> > bugzilla url: https://bugzilla.kernel.org/show_bug.cgi?id=200213
>
> Thanks for the report.
> It looks like nothing too serious but still better to be addressed, of
> course.  Does the patch below cover it?
>
>
> Takashi
>
> ---
> --- a/sound/core/timer.c
> +++ b/sound/core/timer.c
> @@ -1520,7 +1520,7 @@ static int snd_timer_user_next_device(struct
> snd_timer_id __user *_tid)
>                                 } else {
>                                         if (id.subdevice < 0)
>                                                 id.subdevice = 0;
> -                                       else
> +                                       else if (id.subdevice < INT_MAX)
>                                                 id.subdevice++;
>                                 }
>                         }
>
