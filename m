From: "Dae R. Jeong" <threeearcat@gmail.com>
Subject: BUG: soft lockup in snd_virmidi_output_trigger
Date: Thu, 26 Jul 2018 14:53:26 +0900
Message-ID: <20180726055326.GA12625@dragonet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kt0755@gmail.com, bammanag@purdue.edu, syzkaller@googlegroups.com
List-Id: alsa-devel@alsa-project.org

Reporting the crash: BUG: soft lockup in snd_virmidi_output_trigger

This crash has been found in v4.18-rc3 using RaceFuzzer (a modified
version of Syzkaller), which we describe more at the end of this
report.

Note that this bug is previously reported by Syzkaller a few month ago.
(https://syzkaller.appspot.com/bug?id=642c927972318775e0ea1b4779ccd8624ce9e6f5)
Nonetheless, the crash still can be detected. We guess that the crash has
not fixed yet.
We report the crash log and the attached reproducer with a hope that they are
helpful to diagnose the crash and to fix a bug.

C Reproducer:
https://kiwi.cs.purdue.edu/static/race-fuzzer/repro-dab082.c

Kernel config:
https://kiwi.cs.purdue.edu/static/race-fuzzer/config-dab082

(Please disregard all code related to "should_hypercall" in the C repro,
as this is only for our debugging purposes using our own hypervisor.)


Crash log:
==================================================================
watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [syz-executor0:24261]
Modules linked in:
irq event stamp: 6692
hardirqs last  enabled at (6691): [<ffffffff84eb1f12>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
hardirqs last  enabled at (6691): [<ffffffff84eb1f12>] _raw_spin_unlock_irqrestore+0x62/0x90 kernel/locking/spinlock.c:184
hardirqs last disabled at (6692): [<ffffffff85000905>] interrupt_entry+0xb5/0xf0 arch/x86/entry/entry_64.S:625
softirqs last  enabled at (1468): [<ffffffff852005ff>] __do_softirq+0x5ff/0x7f4 kernel/softirq.c:314
softirqs last disabled at (1455): [<ffffffff8130de56>] invoke_softirq kernel/softirq.c:368 [inline]
softirqs last disabled at (1455): [<ffffffff8130de56>] irq_exit+0x126/0x130 kernel/softirq.c:408
CPU: 1 PID: 24261 Comm: syz-executor0 Not tainted 4.18.0-rc3 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.8.2-0-g33fbe13 by qemu-project.org 04/01/2014
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:783 [inline]
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x7d/0x90 kernel/locking/spinlock.c:184
Code: 0d c8 ce 16 7b 5b 41 5c 5d c3 e8 3e 0f 52 fc 48 c7 c7 68 b0 71 86 e8 62 4c 8d fc 48 83 3d 42 91 86 01 00 74 0e 48 89 df 57 9d <0f> 1f 44 00 00 eb cd 0f 0b 0f 0b 0f 1f 84 00 00 00 00 00 55 48 89 
RSP: 0018:ffff8801b8e4f7e8 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: 0000000000000282 RCX: ffffffff84eb1f1e
RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: 0000000000000282
RBP: ffff8801b8e4f7f8 R08: ffffed002573a06a R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88012b9d0348
R13: ffff8801e6417580 R14: ffff8801b8e4f868 R15: ffff8801e64175a8
FS:  00007f3447a49700(0000) GS:ffff8801f6d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3447a48db8 CR3: 00000001ee58d000 CR4: 00000000000006e0
Call Trace:
 spin_unlock_irqrestore include/linux/spinlock.h:365 [inline]
 snd_virmidi_output_trigger+0x37d/0x420 sound/core/seq/seq_virmidi.c:205
 snd_rawmidi_output_trigger sound/core/rawmidi.c:150 [inline]
 snd_rawmidi_kernel_write1+0x383/0x410 sound/core/rawmidi.c:1288
 snd_rawmidi_write+0x249/0xa50 sound/core/rawmidi.c:1338
 __vfs_write+0xf9/0x5d0 fs/read_write.c:485
 vfs_write+0x195/0x380 fs/read_write.c:549
 ksys_write+0xdb/0x1d0 fs/read_write.c:598
 __do_sys_write fs/read_write.c:610 [inline]
 __se_sys_write fs/read_write.c:607 [inline]
 __x64_sys_write+0x43/0x50 fs/read_write.c:607
 do_syscall_64+0x182/0x540 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44b939
Code: 8d 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b 6b fc ff c3 66 2e 0f 1f 84 00 00 00 00 
RSP: 002b:00007f3447a48b48 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000071bfa0 RCX: 000000000044b939
RDX: 000000002000010b RSI: 0000000020000100 RDI: 0000000000000013
RBP: 000000000000b7a8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3447a496d4
R13: 00000000ffffffff R14: 00000000006f7848 R15: 0000000000000000


= About RaceFuzzer

RaceFuzzer is a customized version of Syzkaller, specifically tailored
to find race condition bugs in the Linux kernel. While we leverage
many different technique, the notable feature of RaceFuzzer is in
leveraging a custom hypervisor (QEMU/KVM) to interleave the
scheduling. In particular, we modified the hypervisor to intentionally
stall a per-core execution, which is similar to supporting per-core
breakpoint functionality. This allows RaceFuzzer to force the kernel
to deterministically trigger racy condition (which may rarely happen
in practice due to randomness in scheduling).
