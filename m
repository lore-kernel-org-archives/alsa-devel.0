From: Dmitry Vyukov <dvyukov@google.com>
Subject: sound: deadlock involving snd_hrtimer_callback
Date: Sat, 23 Apr 2016 15:40:21 +0200
Message-ID: <CACT4Y+YsEOFvJVk_AafL+OvOC9_njym7xr-KLQKK3pKRyo8oKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 82E602608CF
 for <alsa-devel@alsa-project.org>; Sat, 23 Apr 2016 15:40:41 +0200 (CEST)
Received: by mail-wm0-f53.google.com with SMTP id u206so63998761wme.1
 for <alsa-devel@alsa-project.org>; Sat, 23 Apr 2016 06:40:41 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Cc: Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Alexander Potapenko <glider@google.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I've incorporated your hrtimer fixes (but also updated to
ddce192106e4f984123884f8e878f66ace94b573) and now I am seeing lots of
the following deadlock messages:


[ INFO: possible circular locking dependency detected ]
4.6.0-rc4+ #351 Not tainted
-------------------------------------------------------
swapper/0/0 is trying to acquire lock:
 (&(&timer->lock)->rlock){-.-...}, at: [<ffffffff8537a749>]
snd_timer_interrupt+0xa9/0xd30 sound/core/timer.c:701

but task is already holding lock:
 (&(&stime->lock)->rlock){-.....}, at: [<ffffffff85383d3f>]
snd_hrtimer_callback+0x4f/0x2b0 sound/core/hrtimer.c:54

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&(&stime->lock)->rlock){-.....}:
       [<ffffffff81477693>] lock_acquire+0x1e3/0x460
kernel/locking/lockdep.c:3677
       [<     inline     >] __raw_spin_lock_irqsave
include/linux/spinlock_api_smp.h:112
       [<ffffffff867c005f>] _raw_spin_lock_irqsave+0x9f/0xd0
kernel/locking/spinlock.c:159
       [<ffffffff85383baa>] snd_hrtimer_start+0x4a/0xf0 sound/core/hrtimer.c:112
       [<ffffffff85379c74>] snd_timer_start1+0x2b4/0x5a0 sound/core/timer.c:457
       [<ffffffff8537d33d>] snd_timer_start+0x5d/0xa0 sound/core/timer.c:571
       [<     inline     >] seq_timer_start sound/core/seq/seq_timer.c:393
       [<ffffffff853fc260>] snd_seq_timer_start+0x1a0/0x2b0
sound/core/seq/seq_timer.c:405
       [<     inline     >] snd_seq_queue_process_event
sound/core/seq/seq_queue.c:687
       [<ffffffff853f6f14>] snd_seq_control_queue+0x304/0x8b0
sound/core/seq/seq_queue.c:748
       [<ffffffff853fcbb5>] event_input_timer+0x25/0x30
sound/core/seq/seq_system.c:118
       [<ffffffff853ef7d4>]
snd_seq_deliver_single_event.constprop.11+0x3f4/0x740
sound/core/seq/seq_clientmgr.c:636
       [<ffffffff853efc38>] snd_seq_deliver_event+0x118/0x800
sound/core/seq/seq_clientmgr.c:833
       [<ffffffff853f1026>] snd_seq_kernel_client_dispatch+0x126/0x170
sound/core/seq/seq_clientmgr.c:2418
       [<ffffffff85405c2b>] send_timer_event.isra.0+0x10b/0x150
sound/core/seq/oss/seq_oss_timer.c:153
       [<ffffffff8540615a>] snd_seq_oss_timer_start+0x1ca/0x310
sound/core/seq/oss/seq_oss_timer.c:174
       [<     inline     >] old_event sound/core/seq/oss/seq_oss_event.c:125
       [<ffffffff854095ff>] snd_seq_oss_process_event+0xa1f/0x2ce0
sound/core/seq/oss/seq_oss_event.c:100
       [<     inline     >] insert_queue sound/core/seq/oss/seq_oss_rw.c:179
       [<ffffffff8540c201>] snd_seq_oss_write+0x321/0x810
sound/core/seq/oss/seq_oss_rw.c:148
       [<ffffffff85403f99>] odev_write+0x59/0xa0
sound/core/seq/oss/seq_oss.c:177
       [<ffffffff817f3fc3>] __vfs_write+0x113/0x4b0 fs/read_write.c:529
       [<ffffffff817f5a97>] vfs_write+0x167/0x4a0 fs/read_write.c:578
       [<     inline     >] SYSC_write fs/read_write.c:625
       [<ffffffff817f98d1>] SyS_write+0x111/0x220 fs/read_write.c:617
       [<ffffffff867c0440>] entry_SYSCALL_64_fastpath+0x23/0xc1
arch/x86/entry/entry_64.S:207

-> #0 (&(&timer->lock)->rlock){-.-...}:
       [<     inline     >] check_prev_add kernel/locking/lockdep.c:1823
       [<     inline     >] check_prevs_add kernel/locking/lockdep.c:1933
       [<     inline     >] validate_chain kernel/locking/lockdep.c:2238
       [<ffffffff81474035>] __lock_acquire+0x3625/0x4d00
kernel/locking/lockdep.c:3298
       [<ffffffff81477693>] lock_acquire+0x1e3/0x460
kernel/locking/lockdep.c:3677
       [<     inline     >] __raw_spin_lock_irqsave
include/linux/spinlock_api_smp.h:112
       [<ffffffff867c005f>] _raw_spin_lock_irqsave+0x9f/0xd0
kernel/locking/spinlock.c:159
       [<ffffffff8537a749>] snd_timer_interrupt+0xa9/0xd30
sound/core/timer.c:701
       [<ffffffff85383e75>] snd_hrtimer_callback+0x185/0x2b0
sound/core/hrtimer.c:59
       [<     inline     >] __run_hrtimer kernel/time/hrtimer.c:1242
       [<ffffffff814d1071>] __hrtimer_run_queues+0x331/0xe90
kernel/time/hrtimer.c:1306
       [<ffffffff814d3a42>] hrtimer_interrupt+0x182/0x430
kernel/time/hrtimer.c:1340
       [<ffffffff8125aa52>] local_apic_timer_interrupt+0x72/0xe0
arch/x86/kernel/apic/apic.c:907
       [<ffffffff867c2d59>] smp_apic_timer_interrupt+0x79/0xa0
arch/x86/kernel/apic/apic.c:931
       [<ffffffff867c10ac>] apic_timer_interrupt+0x8c/0xa0
arch/x86/entry/entry_64.S:454
       [<     inline     >] arch_safe_halt ./arch/x86/include/asm/paravirt.h:118
       [<ffffffff8120f402>] default_idle+0x52/0x370
arch/x86/kernel/process.c:307
       [<ffffffff81210bba>] arch_cpu_idle+0xa/0x10 arch/x86/kernel/process.c:298
       [<ffffffff81454c28>] default_idle_call+0x48/0xa0 kernel/sched/idle.c:93
       [<     inline     >] cpuidle_idle_call kernel/sched/idle.c:151
       [<     inline     >] cpu_idle_loop kernel/sched/idle.c:242
       [<ffffffff8145520f>] cpu_startup_entry+0x58f/0x7b0
kernel/sched/idle.c:291
       [<ffffffff8679ac6d>] rest_init+0x18d/0x1a0 init/main.c:408
       [<ffffffff88ce7759>] start_kernel+0x63a/0x660 init/main.c:661
       [<ffffffff88ce6364>] x86_64_start_reservations+0x38/0x3a
arch/x86/kernel/head64.c:195
       [<ffffffff88ce64be>] x86_64_start_kernel+0x158/0x167
arch/x86/kernel/head64.c:176

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&(&stime->lock)->rlock);
                               lock(&(&timer->lock)->rlock);
                               lock(&(&stime->lock)->rlock);
  lock(&(&timer->lock)->rlock);

 *** DEADLOCK ***

1 lock held by swapper/0/0:
 #0:  (&(&stime->lock)->rlock){-.....}, at: [<ffffffff85383d3f>]
snd_hrtimer_callback+0x4f/0x2b0 sound/core/hrtimer.c:54

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.6.0-rc4+ #351
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
 ffffffff87eb25c0 ffff88003ec07a50 ffffffff82c8f92f ffffffff00000000
 fffffbfff0fd64b8 ffffffff8997bad0 ffffffff8997bad0 ffffffff8998aa70
 ffffffff87e27510 ffffffff87e26d00 ffff88003ec07aa0 ffffffff8146cf58
Call Trace:
 <IRQ>  [<     inline     >] __dump_stack lib/dump_stack.c:15
 <IRQ>  [<ffffffff82c8f92f>] dump_stack+0x12e/0x18f lib/dump_stack.c:51
 [<ffffffff8146cf58>] print_circular_bug+0x288/0x340
kernel/locking/lockdep.c:1196
 [<     inline     >] check_prev_add kernel/locking/lockdep.c:1823
 [<     inline     >] check_prevs_add kernel/locking/lockdep.c:1933
 [<     inline     >] validate_chain kernel/locking/lockdep.c:2238
 [<ffffffff81474035>] __lock_acquire+0x3625/0x4d00 kernel/locking/lockdep.c:3298
 [<ffffffff81477693>] lock_acquire+0x1e3/0x460 kernel/locking/lockdep.c:3677
 [<     inline     >] __raw_spin_lock_irqsave
include/linux/spinlock_api_smp.h:112
 [<ffffffff867c005f>] _raw_spin_lock_irqsave+0x9f/0xd0
kernel/locking/spinlock.c:159
 [<ffffffff8537a749>] snd_timer_interrupt+0xa9/0xd30 sound/core/timer.c:701
 [<ffffffff85383e75>] snd_hrtimer_callback+0x185/0x2b0 sound/core/hrtimer.c:59
 [<     inline     >] __run_hrtimer kernel/time/hrtimer.c:1242
 [<ffffffff814d1071>] __hrtimer_run_queues+0x331/0xe90
kernel/time/hrtimer.c:1306
 [<ffffffff814d3a42>] hrtimer_interrupt+0x182/0x430 kernel/time/hrtimer.c:1340
 [<ffffffff8125aa52>] local_apic_timer_interrupt+0x72/0xe0
arch/x86/kernel/apic/apic.c:907
 [<ffffffff867c2d59>] smp_apic_timer_interrupt+0x79/0xa0
arch/x86/kernel/apic/apic.c:931
 [<ffffffff867c10ac>] apic_timer_interrupt+0x8c/0xa0
arch/x86/entry/entry_64.S:454
 [<     inline     >] arch_safe_halt ./arch/x86/include/asm/paravirt.h:118
 [<ffffffff8120f402>] default_idle+0x52/0x370 arch/x86/kernel/process.c:307
 [<ffffffff81210bba>] arch_cpu_idle+0xa/0x10 arch/x86/kernel/process.c:298
 [<ffffffff81454c28>] default_idle_call+0x48/0xa0 kernel/sched/idle.c:93
 [<     inline     >] cpuidle_idle_call kernel/sched/idle.c:151
 [<     inline     >] cpu_idle_loop kernel/sched/idle.c:242
 [<ffffffff8145520f>] cpu_startup_entry+0x58f/0x7b0 kernel/sched/idle.c:291
 [<ffffffff8679ac6d>] rest_init+0x18d/0x1a0 init/main.c:408
 [<ffffffff88ce7759>] start_kernel+0x63a/0x660 init/main.c:661
 [<ffffffff88ce6364>] x86_64_start_reservations+0x38/0x3a
arch/x86/kernel/head64.c:195
 [<ffffffff88ce64be>] x86_64_start_kernel+0x158/0x167
arch/x86/kernel/head64.c:176


They are also followed by rcu stalls and actual spinlock lockups:

BUG: spinlock lockup suspected on CPU#3, syz-fuzzer/7040
 lock: 0xffff880032ae2bd8, .magic: dead4ead, .owner:
syz-executor/11206, .owner_cpu: 0
CPU: 3 PID: 7040 Comm: syz-fuzzer Not tainted 4.6.0-rc4+ #351
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
 ffffffff87eb25c0 ffff88006d507c40 ffffffff82c8f92f ffffffff2c963698
 fffffbfff0fd64b8 ffff880032ae2bd8 ffff88002c963040 ffff880061238040
 ffff880032ae2be0 000000009a9d0630 ffff88006d507c78 ffffffff8147f58d
Call Trace:
 <IRQ>  [<     inline     >] __dump_stack lib/dump_stack.c:15
 <IRQ>  [<ffffffff82c8f92f>] dump_stack+0x12e/0x18f lib/dump_stack.c:51
 [<ffffffff8147f58d>] spin_dump+0x14d/0x280 kernel/locking/spinlock_debug.c:67
 [<     inline     >] __spin_lock_debug kernel/locking/spinlock_debug.c:117
 [<ffffffff8147f8ad>] do_raw_spin_lock+0x15d/0x2b0
kernel/locking/spinlock_debug.c:137
 [<     inline     >] __raw_spin_lock_irqsave
include/linux/spinlock_api_smp.h:119
 [<ffffffff867c0067>] _raw_spin_lock_irqsave+0xa7/0xd0
kernel/locking/spinlock.c:159
 [<ffffffff8537a749>] snd_timer_interrupt+0xa9/0xd30 sound/core/timer.c:701
 [<ffffffff85383e75>] snd_hrtimer_callback+0x185/0x2b0 sound/core/hrtimer.c:59
 [<     inline     >] __run_hrtimer kernel/time/hrtimer.c:1242
 [<ffffffff814d1071>] __hrtimer_run_queues+0x331/0xe90
kernel/time/hrtimer.c:1306
 [<ffffffff814d3a42>] hrtimer_interrupt+0x182/0x430 kernel/time/hrtimer.c:1340
 [<ffffffff8125aa52>] local_apic_timer_interrupt+0x72/0xe0
arch/x86/kernel/apic/apic.c:907
 [<ffffffff867c2d59>] smp_apic_timer_interrupt+0x79/0xa0
arch/x86/kernel/apic/apic.c:931
 [<ffffffff867c10ac>] apic_timer_interrupt+0x8c/0xa0
arch/x86/entry/entry_64.S:454
 <EOI>
