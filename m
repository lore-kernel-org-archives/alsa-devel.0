From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: use-after-free in snd_timer_interrupt
Date: Sun, 3 Apr 2016 08:06:09 +0200
Message-ID: <CACT4Y+b2jCpng=_J44WUhtOqUCWoCakNu_kHOU4MBHt59+4a7g@mail.gmail.com>
References: <CACT4Y+a5Mv+7ucYvQZ4-Di0d42GNX_OR+9NBg8n1-Luc+ti9tg@mail.gmail.com>
 <s5hbn5s2ctd.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f47.google.com (mail-lf0-f47.google.com
 [209.85.215.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 5764326074D
 for <alsa-devel@alsa-project.org>; Sun,  3 Apr 2016 08:06:30 +0200 (CEST)
Received: by mail-lf0-f47.google.com with SMTP id c62so125262003lfc.1
 for <alsa-devel@alsa-project.org>; Sat, 02 Apr 2016 23:06:30 -0700 (PDT)
In-Reply-To: <s5hbn5s2ctd.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Alexander Potapenko <glider@google.com>, Sasha Levin <sasha.levin@oracle.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 2, 2016 at 6:30 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Sat, 02 Apr 2016 11:08:40 +0200,
> Dmitry Vyukov wrote:
>>
>> Hello,
>>
>> I am hitting the following use-after-free while running syzkaller
>> fuzzer on commit 8e0f93cda48ed054e1216bab5c60017e1a5fc1e8
>>
>> ==================================================================
>> BUG: KASAN: use-after-free in __list_del_entry+0x1d3/0x1e0 at addr
>> ffff88002ebf6e20
>> Read of size 8 by task syz-executor/7684
>> =============================================================================
>> BUG kmalloc-256 (Not tainted): kasan: bad access detected
>> -----------------------------------------------------------------------------
>>
>> INFO: Allocated in snd_timer_instance_new+0x52/0x3a0 age=5 cpu=0 pid=7693
>> [<      none      >] ___slab_alloc+0x578/0x5d0 mm/slub.c:2464
>> [<      none      >] __slab_alloc+0x66/0xc0 mm/slub.c:2493
>> [<     inline     >] slab_alloc_node mm/slub.c:2556
>> [<     inline     >] slab_alloc mm/slub.c:2598
>> [<      none      >] kmem_cache_alloc_trace+0x242/0x3b0 mm/slub.c:2615
>> [<     inline     >] kmalloc include/linux/slab.h:463
>> [<     inline     >] kzalloc include/linux/slab.h:607
>> [<      none      >] snd_timer_instance_new+0x52/0x3a0 sound/core/timer.c:106
>> [<      none      >] snd_timer_open+0x522/0xd20 sound/core/timer.c:289
>> [<     inline     >] snd_timer_user_tselect sound/core/timer.c:1612
>> [<     inline     >] __snd_timer_user_ioctl sound/core/timer.c:1888
>> [<      none      >] snd_timer_user_ioctl+0x8f4/0x2490 sound/core/timer.c:1918
>> [<     inline     >] vfs_ioctl fs/ioctl.c:43
>> [<      none      >] do_vfs_ioctl+0x18c/0xfb0 fs/ioctl.c:674
>> [<     inline     >] SYSC_ioctl fs/ioctl.c:689
>> [<      none      >] SyS_ioctl+0x8f/0xc0 fs/ioctl.c:680
>> [<      none      >] entry_SYSCALL_64_fastpath+0x16/0x7a
>> arch/x86/entry/entry_64.S:185
>>
>> INFO: Freed in snd_timer_close+0x3ee/0x750 age=9 cpu=0 pid=7693
>> [<      none      >] __slab_free+0x1fc/0x320 mm/slub.c:2674
>> [<     inline     >] slab_free mm/slub.c:2829
>> [<      none      >] kfree+0x2f5/0x370 mm/slub.c:3660
>> [<      none      >] snd_timer_close+0x3ee/0x750 sound/core/timer.c:375
>> [<     inline     >] snd_timer_user_tselect sound/core/timer.c:1602
>> [<     inline     >] __snd_timer_user_ioctl sound/core/timer.c:1888
>> [<      none      >] snd_timer_user_ioctl+0x7cd/0x2490 sound/core/timer.c:1918
>> [<     inline     >] vfs_ioctl fs/ioctl.c:43
>> [<      none      >] do_vfs_ioctl+0x18c/0xfb0 fs/ioctl.c:674
>> [<     inline     >] SYSC_ioctl fs/ioctl.c:689
>> [<      none      >] SyS_ioctl+0x8f/0xc0 fs/ioctl.c:680
>> [<      none      >] entry_SYSCALL_64_fastpath+0x16/0x7a
>> arch/x86/entry/entry_64.S:185
>>
>> INFO: Slab 0xffffea0000bafd00 objects=22 used=11 fp=0xffff88002ebf6d80
>> flags=0x1fffc0000004080
>> INFO: Object 0xffff88002ebf6d80 @offset=11648 fp=0xffff88002ebf5110
>> CPU: 3 PID: 7684 Comm: syz-executor Tainted: G    B           4.5.0-rc7+ #337
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
>>  ffffffff87b7d480 ffff88006d707bb0 ffffffff82c2125f ffffffff00bafd00
>>  fffffbfff0f6fa90 ffff88003e807000 ffff88002ebf6d80 ffff88002ebf4000
>>  ffffea0000bafd00 ffff88002ebf6e18 ffff88006d707be0 ffffffff8176dcc4
>>
>> Call Trace:
>>  [<ffffffff81777e4e>] __asan_report_load8_noabort+0x3e/0x40
>> mm/kasan/report.c:295
>>  [<ffffffff82c88f63>] __list_del_entry+0x1d3/0x1e0 lib/list_debug.c:48
>>  [<     inline     >] list_del_init include/linux/list.h:145
>>  [<ffffffff852942f9>] snd_timer_interrupt+0x5b9/0xc80 sound/core/timer.c:791
>>  [<ffffffff8529acc9>] snd_hrtimer_callback+0x169/0x230 sound/core/hrtimer.c:54
>>  [<     inline     >] __run_hrtimer kernel/time/hrtimer.c:1248
>>  [<ffffffff814c3911>] __hrtimer_run_queues+0x331/0xe90
>> kernel/time/hrtimer.c:1312
>>  [<ffffffff814c62e2>] hrtimer_interrupt+0x182/0x430 kernel/time/hrtimer.c:1346
>>  [<ffffffff81255ec2>] local_apic_timer_interrupt+0x72/0xe0
>> arch/x86/kernel/apic/apic.c:907
>>  [<ffffffff812593e9>] smp_apic_timer_interrupt+0x79/0xa0
>> arch/x86/kernel/apic/apic.c:931
>>  [<ffffffff866d256c>] apic_timer_interrupt+0x8c/0xa0
>> arch/x86/entry/entry_64.S:520
>>  [<     inline     >] spin_unlock_irqrestore include/linux/spinlock.h:362
>>  [<ffffffff8177369e>] __slab_free+0x1ae/0x320 mm/slub.c:2681
>>  [<     inline     >] slab_free mm/slub.c:2829
>>  [<ffffffff81773ed8>] kmem_cache_free+0x318/0x440 mm/slub.c:2838
>>  [<ffffffff81704cb8>] ptlock_free+0x38/0x50 mm/memory.c:3912
>>  [<     inline     >] pgtable_pmd_page_dtor include/linux/mm.h:1702
>>  [<ffffffff812951ca>] ___pmd_free_tlb+0xaa/0x110 arch/x86/mm/pgtable.c:74
>>  [<     inline     >] __pmd_free_tlb ./arch/x86/include/asm/pgalloc.h:106
>>  [<     inline     >] free_pmd_range mm/memory.c:432
>>  [<     inline     >] free_pud_range mm/memory.c:450
>>  [<ffffffff816f4dc3>] free_pgd_range+0x973/0xbe0 mm/memory.c:526
>>  [<ffffffff816f52f5>] free_pgtables+0x2c5/0x3b0 mm/memory.c:558
>>  [<ffffffff817137c3>] exit_mmap+0x233/0x410 mm/mmap.c:2868
>>  [<ffffffff813543f5>] mmput+0x95/0x230 kernel/fork.c:706
>>  [<     inline     >] exit_mm kernel/exit.c:436
>>  [<ffffffff81366eb2>] do_exit+0x7b2/0x2d00 kernel/exit.c:735
>>  [<ffffffff81369578>] do_group_exit+0x108/0x330 kernel/exit.c:878
>>  [<ffffffff8138cf14>] get_signal+0x634/0x15e0 kernel/signal.c:2307
>>  [<ffffffff811a7db3>] do_signal+0x83/0x1c90 arch/x86/kernel/signal.c:712
>>  [<ffffffff81006685>] exit_to_usermode_loop+0x1a5/0x210
>> arch/x86/entry/common.c:247
>>  [<     inline     >] prepare_exit_to_usermode arch/x86/entry/common.c:282
>>  [<ffffffff8100866a>] syscall_return_slowpath+0x2ba/0x340
>> arch/x86/entry/common.c:344
>>  [<ffffffff866d18e2>] int_ret_from_sys_call+0x25/0x9f
>> arch/x86/entry/entry_64.S:281
>>
>> ==================================================================
>> kasan: GPF could be caused by NULL-ptr deref or user memory
>> accessgeneral protection fault: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN
>> Modules linked in:
>> CPU: 3 PID: 7684 Comm: syz-executor Tainted: G    B           4.5.0-rc7+ #337
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
>> task: ffff880061062f80 ti: ffff88005ee10000 task.ti: ffff88005ee10000
>> RIP: 0010:[<ffffffff82c88e16>]  [<ffffffff82c88e16>] __list_del_entry+0x86/0x1e0
>> RSP: 0018:ffff88006d707cd0  EFLAGS: 00010046
>> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff88002ebf6e18
>> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
>> RBP: ffff88006d707cf0 R08: ffffffff89cbcf00 R09: 0000000000000000
>> R10: ffffed000dae0f8c R11: 0000000000000000 R12: ffff88005ee0d120
>> R13: ffff8800670a2298 R14: ffff88005ee0d110 R15: ffff88002ebf6e18
>> FS:  0000000000000000(0000) GS:ffff88006d700000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
>> CR2: 00000000006e0000 CR3: 0000000007ae9000 CR4: 00000000000006e0
>> Stack:
>>  ffff88006d707cf0 ffff88002ebf6e18 dffffc0000000000 ffff88005ee0d120
>>  ffff88006d707db0 ffffffff852942f9 ffff8800670a2368 0000000000000082
>>  dffffc0000000000 ffff8800670a234c ffffffff87b7d480 ffffed000ce1446d
>> Call Trace:
>>  <IRQ>
>>  [<     inline     >] list_del_init include/linux/list.h:145
>>  [<ffffffff852942f9>] snd_timer_interrupt+0x5b9/0xc80 sound/core/timer.c:791
>>  [<ffffffff8529acc9>] snd_hrtimer_callback+0x169/0x230 sound/core/hrtimer.c:54
>>  [<     inline     >] __run_hrtimer kernel/time/hrtimer.c:1248
>>  [<ffffffff814c3911>] __hrtimer_run_queues+0x331/0xe90
>> kernel/time/hrtimer.c:1312
>>  [<ffffffff814c62e2>] hrtimer_interrupt+0x182/0x430 kernel/time/hrtimer.c:1346
>>  [<ffffffff81255ec2>] local_apic_timer_interrupt+0x72/0xe0
>> arch/x86/kernel/apic/apic.c:907
>>  [<ffffffff812593e9>] smp_apic_timer_interrupt+0x79/0xa0
>> arch/x86/kernel/apic/apic.c:931
>>  [<ffffffff866d256c>] apic_timer_interrupt+0x8c/0xa0
>> arch/x86/entry/entry_64.S:520
>>  <EOI>
>>  [<     inline     >] spin_unlock_irqrestore include/linux/spinlock.h:362
>>  [<ffffffff8177369e>] __slab_free+0x1ae/0x320 mm/slub.c:2681
>>  [<     inline     >] slab_free mm/slub.c:2829
>>  [<ffffffff81773ed8>] kmem_cache_free+0x318/0x440 mm/slub.c:2838
>>  [<ffffffff81704cb8>] ptlock_free+0x38/0x50 mm/memory.c:3912
>>  [<     inline     >] pgtable_pmd_page_dtor include/linux/mm.h:1702
>>  [<ffffffff812951ca>] ___pmd_free_tlb+0xaa/0x110 arch/x86/mm/pgtable.c:74
>>  [<     inline     >] __pmd_free_tlb ./arch/x86/include/asm/pgalloc.h:106
>>  [<     inline     >] free_pmd_range mm/memory.c:432
>>  [<     inline     >] free_pud_range mm/memory.c:450
>>  [<ffffffff816f4dc3>] free_pgd_range+0x973/0xbe0 mm/memory.c:526
>>  [<ffffffff816f52f5>] free_pgtables+0x2c5/0x3b0 mm/memory.c:558
>>  [<ffffffff817137c3>] exit_mmap+0x233/0x410 mm/mmap.c:2868
>>  [<ffffffff813543f5>] mmput+0x95/0x230 kernel/fork.c:706
>>  [<     inline     >] exit_mm kernel/exit.c:436
>>  [<ffffffff81366eb2>] do_exit+0x7b2/0x2d00 kernel/exit.c:735
>>  [<ffffffff81369578>] do_group_exit+0x108/0x330 kernel/exit.c:878
>>  [<ffffffff8138cf14>] get_signal+0x634/0x15e0 kernel/signal.c:2307
>>  [<ffffffff811a7db3>] do_signal+0x83/0x1c90 arch/x86/kernel/signal.c:712
>>  [<ffffffff81006685>] exit_to_usermode_loop+0x1a5/0x210
>> arch/x86/entry/common.c:247
>>  [<     inline     >] prepare_exit_to_usermode arch/x86/entry/common.c:282
>>  [<ffffffff8100866a>] syscall_return_slowpath+0x2ba/0x340
>> arch/x86/entry/common.c:344
>>  [<ffffffff866d18e2>] int_ret_from_sys_call+0x25/0x9f
>> arch/x86/entry/entry_64.S:281
>> Code: c0 0f 84 91 00 00 00 48 b8 00 02 00 00 00 00 ad de 48 39 c3 0f
>> 84 9f 00 00 00 48 89 da 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80>
>> 3c 02 00 0f 85 f6 00 00 00 4c 8b 23 4c 39 e1 0f 85 95 00 00
>> RIP  [<ffffffff82c88e16>] __list_del_entry+0x86/0x1e0 lib/list_debug.c:57
>>  RSP <ffff88006d707cd0>
>> ---[ end trace fd16e1eaa1720656 ]---
>> Kernel panic - not syncing: Fatal exception in interrupt
>> Shutting down cpus with NMI
>> Kernel Offset: disabled
>> ---[ end Kernel panic - not syncing: Fatal exception in interrupt
>>
>>
>> It is not easily reproducible. I've hit several times while running
>> fuzzer for a week. Here is one of the logs for the record:
>> https://gist.githubusercontent.com/dvyukov/c84798ee55721563ecb537c4d51dc9f5/raw/f00b865a85877656f13b41917f7321730f140d35/gistfile1.txt
>
> There are a few more fixes in sound/core/timer.c since 4.5, and they
> possibly already cover this.
>
> Please let me know if this is still seen on the upcoming 4.6-rc2.

Hi Takashi,

I've updated fuzzer to 05cf8077e54b20dddb756eaa26f3aeb5c38dd3cf (Apr
1) yesterday. Let's see if it still happens.

Out of curiosity, how was the bug found?
