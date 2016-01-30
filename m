From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: deadlock between
	snd_pcm_oss_write/snd_pcm_oss_mmap
Date: Sat, 30 Jan 2016 21:30:43 +0100
Message-ID: <CACT4Y+YPpoKuc8KrN11aL-1DoNxYLEjv-QnCeu3ZKQjkPdJ7Bg@mail.gmail.com>
References: <CACT4Y+bVrBKDG0G2_AcUgUQa+X91VKTeS4v+wN7BSHwHtqn3kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 39FD526058E
 for <alsa-devel@alsa-project.org>; Sat, 30 Jan 2016 21:31:07 +0100 (CET)
Received: by mail-wm0-f53.google.com with SMTP id l66so23269776wml.0
 for <alsa-devel@alsa-project.org>; Sat, 30 Jan 2016 12:31:07 -0800 (PST)
In-Reply-To: <CACT4Y+bVrBKDG0G2_AcUgUQa+X91VKTeS4v+wN7BSHwHtqn3kQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Nicholas Mc Guire <hofrat@osadl.org>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Cc: Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Alexander Potapenko <glider@google.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 30, 2016 at 9:28 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> Hello,
>
> I've got the following deadlock report while running syzkaller fuzzer:
>
> [ INFO: possible circular locking dependency detected ]
> 4.5.0-rc1+ #305 Not tainted
> -------------------------------------------------------
> syz-executor/14254 is trying to acquire lock:
>  (&runtime->oss.params_lock){+.+.+.}, at: [<ffffffff8528a504>]
> snd_pcm_oss_change_params+0xd4/0x3540 sound/core/oss/pcm_oss.c:852
>
> but task is already holding lock:
>  (&mm->mmap_sem){++++++}, at: [<ffffffff816b267c>] vm_mmap_pgoff
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (&mm->mmap_sem){++++++}:
>        [<ffffffff8145b9dc>] lock_acquire+0x1dc/0x430
> kernel/locking/lockdep.c:3587
>        [<ffffffff816def51>] __might_fault+0x141/0x1d0 mm/memory.c:3802
>        [<     inline     >] copy_from_user ./arch/x86/include/asm/uaccess.h:714
>        [<     inline     >] snd_pcm_oss_write1 sound/core/oss/pcm_oss.c:1376
>        [<ffffffff852940f0>] snd_pcm_oss_write+0x250/0x700
> sound/core/oss/pcm_oss.c:2694
>        [<ffffffff817b90b3>] __vfs_write+0x113/0x480 fs/read_write.c:528
>        [<ffffffff817bab47>] vfs_write+0x167/0x4a0 fs/read_write.c:577
>        [<     inline     >] SYSC_write fs/read_write.c:624
>        [<ffffffff817bde31>] SyS_write+0x111/0x220 fs/read_write.c:616
>        [<ffffffff866531b6>] entry_SYSCALL_64_fastpath+0x16/0x7a
> arch/x86/entry/entry_64.S:185
>
> -> #0 (&runtime->oss.params_lock){+.+.+.}:
>        [<     inline     >] check_prev_add kernel/locking/lockdep.c:1855
>        [<     inline     >] check_prevs_add kernel/locking/lockdep.c:1960
>        [<     inline     >] validate_chain kernel/locking/lockdep.c:2146
>        [<ffffffff8145807b>] __lock_acquire+0x31eb/0x4700
> kernel/locking/lockdep.c:3208
>        [<ffffffff8145b9dc>] lock_acquire+0x1dc/0x430
> kernel/locking/lockdep.c:3587
>        [<     inline     >] __mutex_lock_common kernel/locking/mutex.c:518
>        [<ffffffff8664891c>] mutex_lock_interruptible_nested+0xbc/0xbe0
> kernel/locking/mutex.c:647
>        [<ffffffff8528a504>] snd_pcm_oss_change_params+0xd4/0x3540
> sound/core/oss/pcm_oss.c:852
>        [<ffffffff8528f01d>] snd_pcm_oss_mmap+0x3dd/0x4c0
> sound/core/oss/pcm_oss.c:2807
>        [<ffffffff81705747>] mmap_region+0x897/0x1010 mm/mmap.c:1624
>        [<ffffffff81706614>] do_mmap+0x754/0x990 mm/mmap.c:1403
>        [<     inline     >] do_mmap_pgoff include/linux/mm.h:1982
>        [<ffffffff816b26af>] vm_mmap_pgoff+0x15f/0x1b0 mm/util.c:328
>        [<     inline     >] SYSC_mmap_pgoff mm/mmap.c:1453
>        [<ffffffff816ff85a>] SyS_mmap_pgoff+0x34a/0x580 mm/mmap.c:1411
>        [<     inline     >] SYSC_mmap arch/x86/kernel/sys_x86_64.c:95
>        [<ffffffff811aeeb6>] SyS_mmap+0x16/0x20 arch/x86/kernel/sys_x86_64.c:86
>        [<ffffffff866531b6>] entry_SYSCALL_64_fastpath+0x16/0x7a
> arch/x86/entry/entry_64.S:185
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&mm->mmap_sem);
>                                lock(&runtime->oss.params_lock);
>                                lock(&mm->mmap_sem);
>   lock(&runtime->oss.params_lock);
>
>  *** DEADLOCK ***
>
> 1 lock held by syz-executor/14254:
>  #0:  (&mm->mmap_sem){++++++}, at: [<ffffffff816b267c>]
> vm_mmap_pgoff+0x12c/0x1b0 mm/util.c:327
>
> stack backtrace:
> CPU: 2 PID: 14254 Comm: syz-executor Not tainted 4.5.0-rc1+ #305
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
>  00000000ffffffff ffff88003214f780 ffffffff82be11ad ffffffff8959ac60
>  ffffffff8959ac60 ffffffff89573f60 ffff88003214f7d0 ffffffff814512a8
>  ffff8800333cdf00 ffff8800333ce742 0000000000000000 ffff8800333ce720
> Call Trace:
>  [<     inline     >] __dump_stack lib/dump_stack.c:15
>  [<ffffffff82be11ad>] dump_stack+0x6f/0xa2 lib/dump_stack.c:50
>  [<ffffffff814512a8>] print_circular_bug+0x288/0x340
> kernel/locking/lockdep.c:1228
>  [<     inline     >] check_prev_add kernel/locking/lockdep.c:1855
>  [<     inline     >] check_prevs_add kernel/locking/lockdep.c:1960
>  [<     inline     >] validate_chain kernel/locking/lockdep.c:2146
>  [<ffffffff8145807b>] __lock_acquire+0x31eb/0x4700 kernel/locking/lockdep.c:3208
>  [<ffffffff8145b9dc>] lock_acquire+0x1dc/0x430 kernel/locking/lockdep.c:3587
>  [<     inline     >] __mutex_lock_common kernel/locking/mutex.c:518
>  [<ffffffff8664891c>] mutex_lock_interruptible_nested+0xbc/0xbe0
> kernel/locking/mutex.c:647
>  [<ffffffff8528a504>] snd_pcm_oss_change_params+0xd4/0x3540
> sound/core/oss/pcm_oss.c:852
>  [<ffffffff8528f01d>] snd_pcm_oss_mmap+0x3dd/0x4c0 sound/core/oss/pcm_oss.c:2807
>  [<ffffffff81705747>] mmap_region+0x897/0x1010 mm/mmap.c:1624
>  [<ffffffff81706614>] do_mmap+0x754/0x990 mm/mmap.c:1403
>  [<     inline     >] do_mmap_pgoff include/linux/mm.h:1982
>  [<ffffffff816b26af>] vm_mmap_pgoff+0x15f/0x1b0 mm/util.c:328
>  [<     inline     >] SYSC_mmap_pgoff mm/mmap.c:1453
>  [<ffffffff816ff85a>] SyS_mmap_pgoff+0x34a/0x580 mm/mmap.c:1411
>  [<     inline     >] SYSC_mmap arch/x86/kernel/sys_x86_64.c:95
>  [<ffffffff811aeeb6>] SyS_mmap+0x16/0x20 arch/x86/kernel/sys_x86_64.c:86
>
>
> On commit 26cd83670f2f5a3d5b5514a1f7d96567cdb9558b.


Similar for snd_pcm_oss_read:

[   90.050883] [ INFO: possible circular locking dependency detected ]
[   90.050883] 4.5.0-rc1+ #305 Not tainted
[   90.050883] -------------------------------------------------------
[   90.050883] syz-executor/11689 is trying to acquire lock:
[   90.050883]  (&runtime->oss.params_lock){+.+.+.}, at:
[<ffffffff8528a504>] snd_pcm_oss_change_params+0xd4/0x3540
[   90.050883]
[   90.050883] but task is already holding lock:
[   90.050883]  (&mm->mmap_sem){++++++}, at: [<ffffffff816b267c>]
vm_mmap_pgoff+0x12c/0x1b0
[   90.050883]
[   90.050883] which lock already depends on the new lock.
[   90.050883]
[   90.050883]
[   90.050883] the existing dependency chain (in reverse order) is:
[   90.050883]
-> #1 (&mm->mmap_sem){++++++}:
[   90.050883]        [<ffffffff8145b9dc>] lock_acquire+0x1dc/0x430
[   90.050883]        [<ffffffff816def51>] __might_fault+0x141/0x1d0
[   90.050883]        [<ffffffff85295062>] snd_pcm_oss_read+0x262/0x560
[   90.050883]        [<ffffffff817b7183>] __vfs_read+0x113/0x460
[   90.050883]        [<ffffffff817ba7d6>] vfs_read+0x106/0x310
[   90.050883]        [<ffffffff817bdc11>] SyS_read+0x111/0x220
[   90.050883]        [<ffffffff866531b6>] entry_SYSCALL_64_fastpath+0x16/0x7a
[   90.050883]
-> #0 (&runtime->oss.params_lock){+.+.+.}:
[   90.050883]        [<ffffffff8145807b>] __lock_acquire+0x31eb/0x4700
[   90.050883]        [<ffffffff8145b9dc>] lock_acquire+0x1dc/0x430
[   90.050883]        [<ffffffff8664891c>]
mutex_lock_interruptible_nested+0xbc/0xbe0
[   90.050883]        [<ffffffff8528a504>] snd_pcm_oss_change_params+0xd4/0x3540
[   90.050883]        [<ffffffff8528f01d>] snd_pcm_oss_mmap+0x3dd/0x4c0
[   90.050883]        [<ffffffff81705747>] mmap_region+0x897/0x1010
[   90.050883]        [<ffffffff81706614>] do_mmap+0x754/0x990
[   90.050883]        [<ffffffff816b26af>] vm_mmap_pgoff+0x15f/0x1b0
[   90.050883]        [<ffffffff816ff85a>] SyS_mmap_pgoff+0x34a/0x580
[   90.050883]        [<ffffffff811aeeb6>] SyS_mmap+0x16/0x20
[   90.050883]        [<ffffffff866531b6>] entry_SYSCALL_64_fastpath+0x16/0x7a
