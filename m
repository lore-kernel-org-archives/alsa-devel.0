From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: possible deadlock in snd_seq_deliver_event
Date: Fri, 27 Oct 2017 10:11:18 +0200
Message-ID: <CACT4Y+bQgSqHe5B+WEytzDX7Dkx0SdhhxJz9+FMgV7vMDbT7iA@mail.gmail.com>
References: <001a114089d614a0f4055c82d022@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f173.google.com (mail-io0-f173.google.com
 [209.85.223.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CC4C267456
 for <alsa-devel@alsa-project.org>; Fri, 27 Oct 2017 10:11:40 +0200 (CEST)
Received: by mail-io0-f173.google.com with SMTP id 134so11007195ioo.0
 for <alsa-devel@alsa-project.org>; Fri, 27 Oct 2017 01:11:40 -0700 (PDT)
In-Reply-To: <001a114089d614a0f4055c82d022@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: syzbot <bot+7feb8de6b4d6bf810cf098bef942cc387e79d0ad@syzkaller.appspotmail.com>
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com, Takashi Iwai <tiwai@suse.com>, Daniel Mentz <danielmentz@google.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 27, 2017 at 10:09 AM, syzbot
<bot+7feb8de6b4d6bf810cf098bef942cc387e79d0ad@syzkaller.appspotmail.com>
wrote:
> Hello,
>
> syzkaller hit the following crash on
> 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/master
> compiler: gcc (GCC) 7.1.1 20170620
> .config is attached
> Raw console output is attached.
> C reproducer is attached
> syzkaller reproducer is attached. See https://goo.gl/kgGztJ
> for information about syzkaller reproducers
>
>
> ============================================
> WARNING: possible recursive locking detected
> 4.14.0-rc1+ #88 Not tainted
> --------------------------------------------
> syzkaller883997/2981 is trying to acquire lock:
>  (&grp->list_mutex){++++}, at: [<ffffffff83d4dd49>] deliver_to_subscribers
> sound/core/seq/seq_clientmgr.c:666 [inline]
>  (&grp->list_mutex){++++}, at: [<ffffffff83d4dd49>]
> snd_seq_deliver_event+0x279/0x790 sound/core/seq/seq_clientmgr.c:807
>
> but task is already holding lock:
>  (&grp->list_mutex){++++}, at: [<ffffffff83d4dd49>] deliver_to_subscribers
> sound/core/seq/seq_clientmgr.c:666 [inline]
>  (&grp->list_mutex){++++}, at: [<ffffffff83d4dd49>]
> snd_seq_deliver_event+0x279/0x790 sound/core/seq/seq_clientmgr.c:807
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(&grp->list_mutex);
>   lock(&grp->list_mutex);
>
>  *** DEADLOCK ***
>
>  May be due to missing lock nesting notation
>
> 2 locks held by syzkaller883997/2981:
>  #0:  (register_mutex#4){+.+.}, at: [<ffffffff83d60ada>]
> odev_release+0x4a/0x70 sound/core/seq/oss/seq_oss.c:152
>  #1:  (&grp->list_mutex){++++}, at: [<ffffffff83d4dd49>]
> deliver_to_subscribers sound/core/seq/seq_clientmgr.c:666 [inline]
>  #1:  (&grp->list_mutex){++++}, at: [<ffffffff83d4dd49>]
> snd_seq_deliver_event+0x279/0x790 sound/core/seq/seq_clientmgr.c:807
>
> stack backtrace:
> CPU: 1 PID: 2981 Comm: syzkaller883997 Not tainted 4.14.0-rc1+ #88
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:16 [inline]
>  dump_stack+0x194/0x257 lib/dump_stack.c:52
>  print_deadlock_bug kernel/locking/lockdep.c:1797 [inline]
>  check_deadlock kernel/locking/lockdep.c:1844 [inline]
>  validate_chain kernel/locking/lockdep.c:2453 [inline]
>  __lock_acquire+0x1232/0x4620 kernel/locking/lockdep.c:3498
>  lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:4002
>  down_read+0x96/0x150 kernel/locking/rwsem.c:23
>  deliver_to_subscribers sound/core/seq/seq_clientmgr.c:666 [inline]
>  snd_seq_deliver_event+0x279/0x790 sound/core/seq/seq_clientmgr.c:807
>  snd_seq_kernel_client_dispatch+0x11e/0x150
> sound/core/seq/seq_clientmgr.c:2309
>  dummy_input+0x2c4/0x400 sound/core/seq/seq_dummy.c:104
>  snd_seq_deliver_single_event.constprop.11+0x2fb/0x940
> sound/core/seq/seq_clientmgr.c:621
>  deliver_to_subscribers sound/core/seq/seq_clientmgr.c:676 [inline]
>  snd_seq_deliver_event+0x318/0x790 sound/core/seq/seq_clientmgr.c:807
>  snd_seq_kernel_client_dispatch+0x11e/0x150
> sound/core/seq/seq_clientmgr.c:2309
>  dummy_input+0x2c4/0x400 sound/core/seq/seq_dummy.c:104
>  snd_seq_deliver_single_event.constprop.11+0x2fb/0x940
> sound/core/seq/seq_clientmgr.c:621
>  snd_seq_deliver_event+0x12c/0x790 sound/core/seq/seq_clientmgr.c:818
>  snd_seq_kernel_client_dispatch+0x11e/0x150
> sound/core/seq/seq_clientmgr.c:2309
>  snd_seq_oss_dispatch sound/core/seq/oss/seq_oss_device.h:150 [inline]
>  snd_seq_oss_midi_reset+0x44b/0x700 sound/core/seq/oss/seq_oss_midi.c:481
>  snd_seq_oss_synth_reset+0x398/0x980 sound/core/seq/oss/seq_oss_synth.c:416
>  snd_seq_oss_reset+0x6c/0x260 sound/core/seq/oss/seq_oss_init.c:448
>  snd_seq_oss_release+0x71/0x120 sound/core/seq/oss/seq_oss_init.c:425
>  odev_release+0x52/0x70 sound/core/seq/oss/seq_oss.c:153
>  __fput+0x333/0x7f0 fs/file_table.c:210
>  ____fput+0x15/0x20 fs/file_table.c:244
>  task_work_run+0x199/0x270 kernel/task_work.c:112
>  exit_task_work include/linux/task_work.h:21 [inline]
>  do_exit+0xa52/0x1b40 kernel/exit.c:865
>  do_group_exit+0x149/0x400 kernel/exit.c:968
>  SYSC_exit_group kernel/exit.c:979 [inline]
>  SyS_exit_group+0x1d/0x20 kernel/exit.c:977
>  entry_SYSCALL_64_fastpath+0x1f/0xbe
> RIP: 0033:0x442c58
> RSP: 002b:00007ffd15d4f8d8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000442c58
> RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
> RBP: 0000000000000082 R08: 00000000000000e7 R09: ffffffffffffffd0
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401ca0
> R13: 0000000000401d30 R14

I've just re-reproduced this on upstream
15f859ae5c43c7f0a064ed92d33f7a5bc5de6de0 (Oct 26):

============================================
WARNING: possible recursive locking detected
4.14.0-rc6+ #10 Not tainted
--------------------------------------------
a.out/3062 is trying to acquire lock:
 (&grp->list_mutex){++++}, at: [<ffffffff83d28879>]
deliver_to_subscribers sound/core/seq/seq_clientmgr.c:666 [inline]
 (&grp->list_mutex){++++}, at: [<ffffffff83d28879>]
snd_seq_deliver_event+0x279/0x790 sound/core/seq/seq_clientmgr.c:807

but task is already holding lock:
 (&grp->list_mutex){++++}, at: [<ffffffff83d28879>]
deliver_to_subscribers sound/core/seq/seq_clientmgr.c:666 [inline]
 (&grp->list_mutex){++++}, at: [<ffffffff83d28879>]
snd_seq_deliver_event+0x279/0x790 sound/core/seq/seq_clientmgr.c:807

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&grp->list_mutex);
  lock(&grp->list_mutex);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by a.out/3062:
 #0:  (register_mutex#4){+.+.}, at: [<ffffffff83d3b5da>]
odev_release+0x4a/0x70 sound/core/seq/oss/seq_oss.c:152
 #1:  (&grp->list_mutex){++++}, at: [<ffffffff83d28879>]
deliver_to_subscribers sound/core/seq/seq_clientmgr.c:666 [inline]
 #1:  (&grp->list_mutex){++++}, at: [<ffffffff83d28879>]
snd_seq_deliver_event+0x279/0x790 sound/core/seq/seq_clientmgr.c:807

stack backtrace:
CPU: 0 PID: 3062 Comm: a.out Not tainted 4.14.0-rc6+ #10
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:16 [inline]
 dump_stack+0x194/0x257 lib/dump_stack.c:52
 print_deadlock_bug kernel/locking/lockdep.c:1797 [inline]
 check_deadlock kernel/locking/lockdep.c:1844 [inline]
 validate_chain kernel/locking/lockdep.c:2445 [inline]
 __lock_acquire+0xed5/0x3d50 kernel/locking/lockdep.c:3490
 lock_acquire+0x1d5/0x580 kernel/locking/lockdep.c:3994
 down_read+0x96/0x150 kernel/locking/rwsem.c:23
 deliver_to_subscribers sound/core/seq/seq_clientmgr.c:666 [inline]
 snd_seq_deliver_event+0x279/0x790 sound/core/seq/seq_clientmgr.c:807
 snd_seq_kernel_client_dispatch+0x11e/0x150 sound/core/seq/seq_clientmgr.c:2313
 dummy_input+0x2c4/0x400 sound/core/seq/seq_dummy.c:104
 snd_seq_deliver_single_event.constprop.11+0x2fb/0x940
sound/core/seq/seq_clientmgr.c:621
 deliver_to_subscribers sound/core/seq/seq_clientmgr.c:676 [inline]
 snd_seq_deliver_event+0x318/0x790 sound/core/seq/seq_clientmgr.c:807
 snd_seq_kernel_client_dispatch+0x11e/0x150 sound/core/seq/seq_clientmgr.c:2313
 dummy_input+0x2c4/0x400 sound/core/seq/seq_dummy.c:104
 snd_seq_deliver_single_event.constprop.11+0x2fb/0x940
sound/core/seq/seq_clientmgr.c:621
 snd_seq_deliver_event+0x12c/0x790 sound/core/seq/seq_clientmgr.c:818
 snd_seq_kernel_client_dispatch+0x11e/0x150 sound/core/seq/seq_clientmgr.c:2313
 snd_seq_oss_dispatch sound/core/seq/oss/seq_oss_device.h:150 [inline]
 snd_seq_oss_midi_reset+0x44b/0x700 sound/core/seq/oss/seq_oss_midi.c:481
 snd_seq_oss_synth_reset+0x398/0x980 sound/core/seq/oss/seq_oss_synth.c:416
 snd_seq_oss_reset+0x6c/0x260 sound/core/seq/oss/seq_oss_init.c:448
 snd_seq_oss_release+0x71/0x120 sound/core/seq/oss/seq_oss_init.c:425
 odev_release+0x52/0x70 sound/core/seq/oss/seq_oss.c:153
 __fput+0x327/0x7e0 fs/file_table.c:210
 ____fput+0x15/0x20 fs/file_table.c:244
 task_work_run+0x199/0x270 kernel/task_work.c:112
 exit_task_work include/linux/task_work.h:21 [inline]
 do_exit+0x9b5/0x1ad0 kernel/exit.c:865
 do_group_exit+0x149/0x400 kernel/exit.c:968
 SYSC_exit_group kernel/exit.c:979 [inline]
 SyS_exit_group+0x1d/0x20 kernel/exit.c:977
 entry_SYSCALL_64_fastpath+0x1f/0xbe
RIP: 0033:0x437b99
RSP: 002b:00007ffe1b782328 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000437b99
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000082 R08: 000000000000003c R09: 00000000000000e7
R10: ffffffffffffffc0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000401c00 R14: 0000000000401c90 R15: 0000000000000000




> ---
> This bug is generated by a dumb bot. It may contain errors.
> See https://goo.gl/tpsmEJ for details.
> Direct all questions to syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report.
> Once a fix for this bug is committed, please reply to this email with:
> #syz fix: exact-commit-title
> To mark this as a duplicate of another syzbot report, please reply with:
> #syz dup: exact-subject-of-another-report
> If it's a one-off invalid bug report, please reply with:
> #syz invalid
> Note: if the crash happens again, it will cause creation of a new bug
> report.
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/001a114089d614a0f4055c82d022%40google.com.
> For more options, visit https://groups.google.com/d/optout.
