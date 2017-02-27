From: Dmitry Vyukov <dvyukov@google.com>
Subject: sound: spinlock lockup in snd_timer_user_tinterrupt
Date: Mon, 27 Feb 2017 21:46:48 +0100
Message-ID: <CACT4Y+ZpcRxd68_chu4v7pvZxhV34PDMhMCA_dMkODrRT+w=tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f170.google.com (mail-ua0-f170.google.com
 [209.85.217.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A751266CCC
 for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2017 21:47:09 +0100 (CET)
Received: by mail-ua0-f170.google.com with SMTP id 40so70422578uau.2
 for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2017 12:47:09 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Cc: syzkaller <syzkaller@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

Hello,

The following program locks up system:
https://gist.githubusercontent.com/dvyukov/1b5cdca7f0fc6254afd4816901160e4c/raw/024c53be2112c83e5d64f3e4d5e8aa38ded727e3/gistfile1.txt


BUG: spinlock lockup suspected on CPU#1, syz-executor0/6018
 lock: kvm_count_lock+0x0/0x60, .magic: dead4ead, .owner:
syz-executor0/6001, .owner_cpu: 2
CPU: 1 PID: 6018 Comm: syz-executor0 Not tainted 4.10.0-rc8+ #228
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:15 [inline]
 dump_stack+0x2ee/0x3ef lib/dump_stack.c:51
 spin_dump+0x14d/0x280 kernel/locking/spinlock_debug.c:67
 __spin_lock_debug kernel/locking/spinlock_debug.c:117 [inline]
 do_raw_spin_lock+0x2c1/0x5b0 kernel/locking/spinlock_debug.c:137
 __raw_spin_lock include/linux/spinlock_api_smp.h:145 [inline]
 _raw_spin_lock+0x3b/0x50 kernel/locking/spinlock.c:151
 hardware_enable_all arch/x86/kvm/../../../virt/kvm/kvm_main.c:3324 [inline]
 kvm_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:632 [inline]
 kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:3173 [inline]
 kvm_dev_ioctl+0x984/0x11b0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3217
 vfs_ioctl fs/ioctl.c:43 [inline]
 do_vfs_ioctl+0x1bf/0x1790 fs/ioctl.c:683
 SYSC_ioctl fs/ioctl.c:698 [inline]
 SyS_ioctl+0x8f/0xc0 fs/ioctl.c:689
 entry_SYSCALL_64_fastpath+0x1f/0xc2
RIP: 0033:0x4458b9
RSP: 002b:00007fb0cb7b7b58 EFLAGS: 00000286 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000017 RCX: 00000000004458b9
RDX: 0000000000000000 RSI: 000000000000ae01 RDI: 0000000000000017
RBP: 00000000006dfa10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000708150
R13: 0000000020000000 R14: 0000000000fff000 R15: 0000000000000003
NMI backtrace for cpu 1
CPU: 1 PID: 6018 Comm: syz-executor0 Not tainted 4.10.0-rc8+ #228
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:15 [inline]
 dump_stack+0x2ee/0x3ef lib/dump_stack.c:51
 nmi_cpu_backtrace+0xfd/0x120 lib/nmi_backtrace.c:99
 nmi_trigger_cpumask_backtrace+0x11d/0x170 lib/nmi_backtrace.c:60
 arch_trigger_cpumask_backtrace+0x14/0x20 arch/x86/kernel/apic/hw_nmi.c:37
 trigger_all_cpu_backtrace include/linux/nmi.h:58 [inline]
 __spin_lock_debug kernel/locking/spinlock_debug.c:119 [inline]
 do_raw_spin_lock+0x2cf/0x5b0 kernel/locking/spinlock_debug.c:137
 __raw_spin_lock include/linux/spinlock_api_smp.h:145 [inline]
 _raw_spin_lock+0x3b/0x50 kernel/locking/spinlock.c:151
 hardware_enable_all arch/x86/kvm/../../../virt/kvm/kvm_main.c:3324 [inline]
 kvm_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:632 [inline]
 kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:3173 [inline]
 kvm_dev_ioctl+0x984/0x11b0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3217
 vfs_ioctl fs/ioctl.c:43 [inline]
 do_vfs_ioctl+0x1bf/0x1790 fs/ioctl.c:683
 SYSC_ioctl fs/ioctl.c:698 [inline]
 SyS_ioctl+0x8f/0xc0 fs/ioctl.c:689
 entry_SYSCALL_64_fastpath+0x1f/0xc2
RIP: 0033:0x4458b9
RSP: 002b:00007fb0cb7b7b58 EFLAGS: 00000286 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000017 RCX: 00000000004458b9
RDX: 0000000000000000 RSI: 000000000000ae01 RDI: 0000000000000017
RBP: 00000000006dfa10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000708150
R13: 0000000020000000 R14: 0000000000fff000 R15: 0000000000000003
Sending NMI from CPU 1 to CPUs 0,2-3:
NMI backtrace for cpu 0 skipped: idling at pc 0xffffffff84288cb6
NMI backtrace for cpu 2
CPU: 2 PID: 6001 Comm: syz-executor0 Not tainted 4.10.0-rc8+ #228
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
task: ffff880049720640 task.stack: ffff880024a38000
RIP: 0010:rep_nop arch/x86/include/asm/processor.h:616 [inline]
RIP: 0010:cpu_relax arch/x86/include/asm/processor.h:621 [inline]
RIP: 0010:csd_lock_wait kernel/smp.c:99 [inline]
RIP: 0010:smp_call_function_many+0x75c/0x930 kernel/smp.c:455
RSP: 0018:ffff880024a3f6a0 EFLAGS: 00000246
RAX: 0000000000010000 RBX: ffffe8ffffd052d0 RCX: ffffc90000ab5000
RDX: 0000000000010000 RSI: ffffffff8167f79a RDI: ffffffff84ba1ad8
RBP: ffff880024a3f8c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000006 R11: 0000000000000000 R12: ffffe8ffffd052e8
R13: dffffc0000000000 R14: 0000000000000003 R15: ffffed0004947eeb
FS:  00007fb0cb7fa700(0000) GS:ffff880089e00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000006dfa10 CR3: 0000000051171000 CR4: 00000000000006e0
DR0: 0000000020000000 DR1: 0000000020000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 smp_call_function kernel/smp.c:479 [inline]
 on_each_cpu+0x109/0x330 kernel/smp.c:589
 hardware_enable_all arch/x86/kvm/../../../virt/kvm/kvm_main.c:3329 [inline]
 kvm_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:632 [inline]
 kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:3173 [inline]
 kvm_dev_ioctl+0xbe2/0x11b0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3217
 vfs_ioctl fs/ioctl.c:43 [inline]
 do_vfs_ioctl+0x1bf/0x1790 fs/ioctl.c:683
 SYSC_ioctl fs/ioctl.c:698 [inline]
 SyS_ioctl+0x8f/0xc0 fs/ioctl.c:689
 entry_SYSCALL_64_fastpath+0x1f/0xc2
RIP: 0033:0x4458b9
RSP: 002b:00007fb0cb7f9b58 EFLAGS: 00000286 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000017 RCX: 00000000004458b9
RDX: 0000000000000000 RSI: 000000000000ae01 RDI: 0000000000000017
RBP: 00000000006dfa10 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000708000
R13: 0000000020000000 R14: 0000000000fff000 R15: 0000000000000003
Code: 3c 03 0f 8e d0 01 00 00 44 89 b5 98 fe ff ff 41 83 e6 01 41 c6
07 f8 74 51 4d 89 e6 41 83 e6 07 41 83 c6 03 e8 66 af 0a 00 f3 90 <4c>
89 e0 41 c6 07 04 48 c1 e8 03 42 0f b6 04 28 41 38 c6 7c 08
NMI backtrace for cpu 3
CPU: 3 PID: 5984 Comm: syz-executor3 Not tainted 4.10.0-rc8+ #228
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
task: ffff88004a566500 task.stack: ffff88002f9f0000
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:767 [inline]
RIP: 0010:lock_release+0x86c/0xe90 kernel/locking/lockdep.c:3775
RSP: 0018:ffff880089f073e8 EFLAGS: 00000082
RAX: dffffc0000000000 RBX: ffff88004a566500 RCX: 1ffff100113e0ea2
RDX: 1ffffffff09d8a95 RSI: 0000000000000001 RDI: 0000000000000082
RBP: ffff880089f07638 R08: ffffe8ffffd32500 R09: 0000000000000001
R10: 1ffff100113e0e6e R11: ffff88009fff70dd R12: ffff880086136d60
R13: 0000000000000001 R14: ffff88004a566d20 R15: 0000000000000002
FS:  00007f366abbe700(0000) GS:ffff880089f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005642b47a21e8 CR3: 000000003d684000 CR4: 00000000000006e0
Call Trace:
 <IRQ>
 __raw_spin_unlock include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock+0x1a/0x30 kernel/locking/spinlock.c:183
 spin_unlock include/linux/spinlock.h:347 [inline]
 snd_timer_user_tinterrupt+0x54d/0x950 sound/core/timer.c:1322
 snd_timer_interrupt.part.12+0xa8f/0x1480 sound/core/timer.c:799
 snd_timer_interrupt+0x88/0xb0 sound/core/timer.c:719
 snd_hrtimer_callback+0x1f0/0x3c0 sound/core/hrtimer.c:64
 __run_hrtimer kernel/time/hrtimer.c:1238 [inline]
 __hrtimer_run_queues+0x385/0xf80 kernel/time/hrtimer.c:1302
 hrtimer_interrupt+0x1c2/0x5e0 kernel/time/hrtimer.c:1336
 local_apic_timer_interrupt+0x6f/0xe0 arch/x86/kernel/apic/apic.c:936
 smp_apic_timer_interrupt+0x71/0xa0 arch/x86/kernel/apic/apic.c:960
 apic_timer_interrupt+0x93/0xa0 arch/x86/entry/entry_64.S:487
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:767 [inline]
RIP: 0010:__raw_spin_unlock_irqrestore
include/linux/spinlock_api_smp.h:162 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x144/0x200 kernel/locking/spinlock.c:191
RSP: 0018:ffff88002f9f7568 EFLAGS: 00000282 ORIG_RAX: ffffffffffffff10
RAX: 1ffffffff09d8a95 RBX: 1ffff10005f3eead RCX: 0000000000000006
RDX: 1ffff10005f3eed1 RSI: ffff88004a566cf8 RDI: 0000000000000282
RBP: ffff88002f9f7728 R08: ffffe8ffffd32500 R09: 0000000000000000
R10: 0000000000000006 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000282 R14: ffff88004c077bf0 R15: 0000000000000000
 </IRQ>
 spin_unlock_irqrestore include/linux/spinlock.h:362 [inline]
 snd_timer_start1+0x1e3/0x950 sound/core/timer.c:480
 snd_timer_start+0x5d/0xa0 sound/core/timer.c:589
 snd_timer_user_start.isra.7+0xde/0x130 sound/core/timer.c:1823
 __snd_timer_user_ioctl sound/core/timer.c:1910 [inline]
 snd_timer_user_ioctl+0x79d/0x34a0 sound/core/timer.c:1931
 vfs_ioctl fs/ioctl.c:43 [inline]
 do_vfs_ioctl+0x1bf/0x1790 fs/ioctl.c:683
 SYSC_ioctl fs/ioctl.c:698 [inline]
 SyS_ioctl+0x8f/0xc0 fs/ioctl.c:689
 entry_SYSCALL_64_fastpath+0x1f/0xc2
RIP: 0033:0x4458b9
RSP: 002b:00007f366abbdb58 EFLAGS: 00000286 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000017 RCX: 00000000004458b9
RDX: 0000000000000000 RSI: 00000000000054a0 RDI: 0000000000000017
RBP: 00000000006e0680 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 00000000007080a8
R13: 000000002002f000 R14: 0000000000001000 R15: 0000000000000003
Code: 04 02 f8 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 99 03 00 00 48
83 3d fb 94 92 03 00 0f 84 c4 02 00 00 48 8b bd 00 fe ff ff 57 9d <0f>
1f 44 00 00 48 b8 00 00 00 00 00 fc ff df 48 03 85 10 fe ff



Or:

[  393.912269] NMI backtrace for cpu 2
[  393.912271] CPU: 2 PID: 2937 Comm: a.out Not tainted 4.10.0+ #229
[  393.912274] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Bochs 01/01/2011
[  393.912276] task: ffff88006353c400 task.stack: ffff880066da0000
[  393.912277] RIP: 0010:__lock_acquire+0xc9/0x3430
kernel/locking/lockdep.c:3204
[  393.912279] RSP: 0018:ffff88006d106f68 EFLAGS: 00000086
[  393.912282] RAX: ffffed000da20e03 RBX: 1ffff1000da20ea0 RCX: 0000000000000000
[  393.912285] RDX: dffffc0000000000 RSI: 0000000000000000 RDI: ffff8800681416c8
[  393.912287] RBP: ffff88006d1074a0 R08: 0000000000000001 R09: 0000000000000001
[  393.912289] R10: ffff8800681416c8 R11: 0000000000000000 R12: ffff88006d107720
[  393.912291] R13: ffff88006353c400 R14: 0000000000000000 R15: 0000000000000001
[  393.912294] FS:  000000000082f880(0000) GS:ffff88006d100000(0000)
knlGS:0000000000000000
[  393.912295] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  393.912298] CR2: 000000002001cfb0 CR3: 000000006ae13000 CR4: 00000000001406e0
[  393.912299] Call Trace:
[  393.912300]  <IRQ>
[  393.912336]  lock_acquire+0x2a1/0x630 kernel/locking/lockdep.c:3753
[  393.912359]  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
[  393.912359]  _raw_spin_lock+0x33/0x50 kernel/locking/spinlock.c:151
[  393.912362]  spin_lock include/linux/spinlock.h:299 [inline]
[  393.912362]  snd_timer_interrupt.part.12+0xaa0/0x1480 sound/core/timer.c:800
[  393.912401]  snd_timer_interrupt+0x88/0xb0 sound/core/timer.c:719
[  393.912403]  snd_hrtimer_callback+0x1f0/0x3c0 sound/core/hrtimer.c:64
[  393.912404]  __run_hrtimer kernel/time/hrtimer.c:1210 [inline]
[  393.912404]  __hrtimer_run_queues+0x349/0xe50 kernel/time/hrtimer.c:1274
[  393.912422]  hrtimer_interrupt+0x1c2/0x5e0 kernel/time/hrtimer.c:1308
[  393.912424]  local_apic_timer_interrupt+0x6f/0xe0
arch/x86/kernel/apic/apic.c:937
[  393.912425]  smp_apic_timer_interrupt+0x71/0xa0
arch/x86/kernel/apic/apic.c:961
[  393.912427]  apic_timer_interrupt+0x93/0xa0 arch/x86/entry/entry_64.S:487
[  393.912429] RIP: 0010:arch_local_irq_restore
arch/x86/include/asm/paravirt.h:778 [inline]
[  393.912429] RIP: 0010:__raw_spin_unlock_irqrestore
include/linux/spinlock_api_smp.h:160 [inline]
[  393.912429] RIP: 0010:_raw_spin_unlock_irqrestore+0x144/0x200
kernel/locking/spinlock.c:191
[  393.912431] RSP: 0018:ffff880066da7568 EFLAGS: 00000286 ORIG_RAX:
ffffffffffffff10
[  393.912436] RAX: 1ffffffff09d8eb9 RBX: 1ffff1000cdb4ead RCX: 0000000000000006
[  393.912438] RDX: 1ffff1000cdb4ed1 RSI: ffff88006353cbe0 RDI: 0000000000000286
[  393.912440] RBP: ffff880066da7728 R08: ffff88007fff709c R09: 0000000000000000
[  393.912443] R10: 0000000000000006 R11: 0000000000000000 R12: dffffc0000000000
[  393.912445] R13: 0000000000000286 R14: ffff8800681416b0 R15: 0000000000000000
[  393.912446]  </IRQ>
[  393.912467]  spin_unlock_irqrestore include/linux/spinlock.h:354 [inline]
[  393.912467]  snd_timer_start1+0x1e3/0x950 sound/core/timer.c:480
[  393.912479]  snd_timer_start+0x5d/0xa0 sound/core/timer.c:589
[  393.912481]  snd_timer_user_start.isra.7+0xde/0x130 sound/core/timer.c:1823
[  393.912482]  __snd_timer_user_ioctl sound/core/timer.c:1910 [inline]
[  393.912482]  snd_timer_user_ioctl+0x79d/0x34a0 sound/core/timer.c:1931
[  393.912509]  vfs_ioctl fs/ioctl.c:43 [inline]
[  393.912509]  do_vfs_ioctl+0x1bf/0x1790 fs/ioctl.c:683
[  393.912524]  SYSC_ioctl fs/ioctl.c:698 [inline]
[  393.912524]  SyS_ioctl+0x8f/0xc0 fs/ioctl.c:689
[  393.912525]  entry_SYSCALL_64_fastpath+0x1f/0xc2
[  393.912527] RIP: 0033:0x434d89
[  393.912528] RSP: 002b:00007ffd0ad83a48 EFLAGS: 00000217 ORIG_RAX:
0000000000000010
[  393.912532] RAX: ffffffffffffffda RBX: 0000000000401ae0 RCX: 0000000000434d89
[  393.912534] RDX: 0000000000000000 RSI: 00000000000054a0 RDI: 0000000000000003
[  393.912536] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  393.912538] R10: 0000000000000000 R11: 0000000000000217 R12: 00000000004002b0
[  393.912540] R13: 0000000000401ae0 R14: 0000000000401b70 R15: 0000000000000000
[  393.912542] Code: f2 c7 40 28 f2 f2 f2 f2 c7 40 2c 04 f2 f2 f2 c7
40 30 f2 f2 f2 f2 c7 40 34 00 f2 f2 f2 c7 40 38 f2 f2 f2 f2 c7 40 3c
00 f2 f2 f2 <c7> 40 40 f2 f2 f2 f2 c7 40 44 00 f2 f2 f2 c7 40 48 f2 f2
f2 f2


On commit e5d56efc97f8240d0b5d66c03949382b6d7e5570
