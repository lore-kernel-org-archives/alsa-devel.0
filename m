From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: use-after-free in snd_timer_interrupt
Date: Mon, 18 Jan 2016 11:53:00 +0100
Message-ID: <CACT4Y+Zg4DkCJEORWAfY1ZasCs8GFkbBxTQFNZdHx+4XG_zRWg@mail.gmail.com>
References: <CACT4Y+ZrVvE3dgcYHRdHDG0X316VgC-=pr2U-233vVn_QbHZHw@mail.gmail.com>
 <s5hwprdv2sp.wl-tiwai@suse.de> <CACT4Y+ZFsNxsVyq_n6kh=HN1dStj_hL=B9eUu4heAHes=ixf3g@mail.gmail.com>
 <s5hio2xmh9z.wl-tiwai@suse.de> <CACT4Y+bqxg_C7JmnUSRm_9jiZ9R9XqbBV0igDdUW1ZhtqvktJw@mail.gmail.com>
 <CACT4Y+anWgMKQmNByifCs+-jizRQL9twxvRQzW3XzNJ8+a6fDw@mail.gmail.com>
 <s5hegdlmdd6.wl-tiwai@suse.de> <CACT4Y+Y62DTncEAb_S6JykY7Ps7SHo2QyCopMObBxJt2fB_NKA@mail.gmail.com>
 <s5h60yxmc99.wl-tiwai@suse.de> <s5ha8o8uoqb.wl-tiwai@suse.de>
 <CACT4Y+a-=mrGALS+yf4GwGmJGLWXVJ0mbucPAkZ7WSGFaSR0Kw@mail.gmail.com>
 <s5hwprbt8ei.wl-tiwai@suse.de> <CACT4Y+ZfAc1JZQHHbA-k_ZVN3vm9djojvmL+e=D8WO2J8FR0=A@mail.gmail.com>
 <s5hk2nbt0gp.wl-tiwai@suse.de> <CACT4Y+aOEHHEVp1YLLMr2PD_iyESMP64T-EQX18=EfvRtgOLOQ@mail.gmail.com>
 <CACT4Y+YPVUCTenSZjLfMf08NHJm1u3--Qm6a32oTdCmxUGkC0Q@mail.gmail.com>
 <s5hk2natzwn.wl-tiwai@suse.de> <CACT4Y+Yq+yPRGw=+rzcWgKgUkK3qwRw2+miiPQ3amSO3cJ1DGw@mail.gmail.com>
 <s5hfuxytu55.wl-tiwai@suse.de> <s5hd1t2tt4q.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hd1t2tt4q.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 15, 2016 at 10:44 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 15 Jan 2016 22:22:46 +0100,
> Takashi Iwai wrote:
>>
>> On Fri, 15 Jan 2016 20:47:05 +0100,
>> Dmitry Vyukov wrote:
>> >
>> > On Fri, Jan 15, 2016 at 8:18 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > > On Fri, 15 Jan 2016 20:13:11 +0100,
>> > > Dmitry Vyukov wrote:
>> > >>
>> > >> On Fri, Jan 15, 2016 at 3:38 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> > >> > On Fri, Jan 15, 2016 at 2:51 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > >> >> On Fri, 15 Jan 2016 12:03:17 +0100,
>> > >> >> Dmitry Vyukov wrote:
>> > >> >>>
>> > >> >>> On Fri, Jan 15, 2016 at 12:00 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > >> >>> > On Fri, 15 Jan 2016 09:06:10 +0100,
>> > >> >>> > Dmitry Vyukov wrote:
>> > >> >>> >>
>> > >> >>> >> On Thu, Jan 14, 2016 at 5:09 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > >> >>> >> > On Wed, 13 Jan 2016 21:54:10 +0100,
>> > >> >>> >> > Takashi Iwai wrote:
>> > >> >>> >> >>
>> > >> >>> >> >> OK, then this might be a possible race at the current snd_timer_stop()
>> > >> >>> >> >> implementation.  There is no sync action there, so the ISR might be
>> > >> >>> >> >> still alive after snd_timer_close() call.  Or might be another race.
>> > >> >>> >> >> This pattern looks a bit different, as it's involved with hrtimer.
>> > >> >>> >> >>
>> > >> >>> >> >> I'll take a look at it tomorrow.
>> > >> >>> >> >
>> > >> >>> >> > I've audited the code today, but the open window doesn't look like
>> > >> >>> >> > what I expected.  I found only some possible cases with slave timer
>> > >> >>> >> > instances.
>> > >> >>> >> >
>> > >> >>> >> > In anyway, below is a test fix patch.  Since I couldn't reproduce the
>> > >> >>> >> > issue on my local machines, it's hard to say whether this covers the
>> > >> >>> >> > holes you fell.  Let's see...
>> > >> >>> >>
>> > >> >>> >>
>> > >> >>> >> Hi Takashi,
>> > >> >>> >>
>> > >> >>> >> I would be interested to understand why other people can't reproduce
>> > >> >>> >> issues that I hit pretty reliably.
>> > >> >>> >> I suspect that it can be due to .config. Please try with the following
>> > >> >>> >> config values.
>> > >> >>> >
>> > >> >>> > I guess rather other config, e.g. the kernel debug options.
>> > >> >>> > I suppose you enabled KASAN and DEBUG_LIST.  What else?
>> > >> >>>
>> > >> >>> I've attached my config (you will need to disable CONFIG_KCOV, it is
>> > >> >>> not upstreamed).
>> > >> >>
>> > >> >> Hm, that has lots of other drivers built-in...
>> > >> >>
>> > >> >>> >> I also start qemu with "-soundhw all" arg.
>> > >> >>> >
>> > >> >>> > OK, so you're testing with VM?  This makes easier to recheck.
>> > >> >>>
>> > >> >>> Yes, I start qemu as:
>> > >> >>>
>> > >> >>> qemu-system-x86_64 -hda wheezy.img -net
>> > >> >>> user,host=10.0.2.10,hostfwd=tcp::10022-:22 -net nic -nographic -kernel
>> > >> >>> arch/x86/boot/bzImage -append "console=ttyS0 root=/dev/sda debug
>> > >> >>> earlyprintk=serial slub_debug=UZ" -enable-kvm -m 2G -numa
>> > >> >>> node,nodeid=0,cpus=0-1 -numa node,nodeid=1,cpus=2-3 -smp
>> > >> >>> sockets=2,cores=2,threads=1 -usb -usbdevice mouse -usbdevice tablet
>> > >> >>> -soundhw all
>> > >> >>
>> > >> >> And which test did trigger use-after-free, even with all previous
>> > >> >> patches?
>> > >> >
>> > >> > I will try to extract a new reproducer now.
>> > >>
>> > >> Ok, I does not seem to see any crashes except the timer hangs below.
>> > >> Let's consider all other bugs as fixed. I will report anything new
>> > >> that I see separately.
>> > >
>> > > OK, good to hear.
>> > >
>> > >> > Meanwhile, can you try to reproduce this one:
>> > >> > https://groups.google.com/forum/#!msg/syzkaller/bbtG9_h1ONU/CPLblMC6FAAJ
>> > >> > ? I run the program in a tight parallel loop.
>> > >
>> > > I could reproduce this after your suggestion with parallel runs.
>> > >
>> > > This seems specific to hrtimer.  Possibly it's not about the snd-timer
>> > > core itself.  Could you check whether this doesn't happen when
>> > > CONFIG_SND_HRTIMER isn't set?
>> >
>> >
>> > Does not happen without CONFIG_SND_HRTIMER.
>> > Do you mean that this is hrtimer bug?
>>
>> I guess rather it's a bug in snd-hrtimer driver.
>> Will check it later.
>
> The patch below *might* fix the issue.  There was a deadlock problem
> and the current code has a weird workaround for it.  I suspect it
> being the cause.
>
> If this works, I'll happily apply it before submitting the next pull
> request for 4.5.  If not, I'll take a closer look at it in the next
> week :)


No, unfortunately the hang still happens with the patch:


INFO: rcu_sched detected stalls on CPUs/tasks:
(detected by 3, t=26002 jiffies, g=7699, c=7698, q=270)
All QSes seen, last rcu_sched kthread activity 26002
(4294752045-4294726043), jiffies_till_next_fqs=3, root ->qsmask 0x0
a.out           R  running task    30184 10406   6864 0x0000000a
 ffff8800636ef610 ffff88006d707ca8 ffffffff813e7989 00000000fffc519b
 00000000fffc519b ffff88006d720fc0 00000000fffcb72d dffffc0000000000
 0000000000000000 ffff88006d707d80 ffffffff814b33aa 0000000000000000
Call Trace:
 <IRQ>  [<ffffffff813e7989>] sched_show_task+0x269/0x3b0
kernel/sched/core.c:5036
 [<     inline     >] print_other_cpu_stall kernel/rcu/tree.c:1318
 [<     inline     >] check_cpu_stall kernel/rcu/tree.c:1424
 [<     inline     >] __rcu_pending kernel/rcu/tree.c:3906
 [<     inline     >] rcu_pending kernel/rcu/tree.c:3970
 [<ffffffff814b33aa>] rcu_check_callbacks+0x1dfa/0x1e10 kernel/rcu/tree.c:2795
 [<ffffffff814c2b0a>] update_process_times+0x3a/0x70 kernel/time/timer.c:1420
 [<ffffffff814ec04f>] tick_sched_handle.isra.20+0xaf/0xe0
kernel/time/tick-sched.c:151
 [<ffffffff814ec775>] tick_sched_timer+0x75/0x100 kernel/time/tick-sched.c:1086
 [<     inline     >] __run_hrtimer kernel/time/hrtimer.c:1229
 [<ffffffff814c48d3>] __hrtimer_run_queues+0x363/0xc10
kernel/time/hrtimer.c:1293
 [<ffffffff814c68d2>] hrtimer_interrupt+0x182/0x430 kernel/time/hrtimer.c:1327
 [<ffffffff8124f062>] local_apic_timer_interrupt+0x72/0xe0
arch/x86/kernel/apic/apic.c:907
 [<ffffffff81252589>] smp_apic_timer_interrupt+0x79/0xa0
arch/x86/kernel/apic/apic.c:931
 [<ffffffff86326e6c>] apic_timer_interrupt+0x8c/0xa0
arch/x86/entry/entry_64.S:520
 [<ffffffff814fab0c>] smp_call_function_many+0x59c/0x720 kernel/smp.c:435
 [<ffffffff812931e6>] native_flush_tlb_others+0xd6/0x370 arch/x86/mm/tlb.c:154
 [<     inline     >] flush_tlb_others ./arch/x86/include/asm/paravirt.h:329
 [<ffffffff8129394f>] flush_tlb_mm_range+0x10f/0x560 arch/x86/mm/tlb.c:235
 [<ffffffff816df2d2>] tlb_flush_mmu_tlbonly+0x1e2/0x3f0 mm/memory.c:243
 [<     inline     >] tlb_flush_mmu mm/memory.c:264
 [<ffffffff816e2afb>] tlb_finish_mmu+0x1b/0xa0 mm/memory.c:276
 [<ffffffff816f8631>] unmap_region+0x261/0x350 mm/mmap.c:2408
 [<ffffffff816ff5cb>] do_munmap+0x70b/0xf30 mm/mmap.c:2602
 [<ffffffff81702fa2>] mmap_region+0x152/0x1010 mm/mmap.c:1558
 [<ffffffff817045b4>] do_mmap+0x754/0x990 mm/mmap.c:1396
 [<     inline     >] do_mmap_pgoff include/linux/mm.h:1982
 [<ffffffff816b46bf>] vm_mmap_pgoff+0x15f/0x1b0 mm/util.c:328
 [<     inline     >] SYSC_mmap_pgoff mm/mmap.c:1446
 [<ffffffff816fd868>] SyS_mmap_pgoff+0x208/0x580 mm/mmap.c:1404
 [<     inline     >] SYSC_mmap arch/x86/kernel/sys_x86_64.c:95
 [<ffffffff811b0a86>] SyS_mmap+0x16/0x20 arch/x86/kernel/sys_x86_64.c:86
 [<ffffffff86326076>] entry_SYSCALL_64_fastpath+0x16/0x7a
arch/x86/entry/entry_64.S:185
rcu_sched kthread starved for 26002 jiffies! g7699 c7698 f0x2
RCU_GP_WAIT_FQS(3) ->state=0x100
rcu_sched       W ffff88003dfb7a98 29272     8      2 0x00000000
 ffff88003dfb7a98 ffff88003ec16d40 ffff88003df81fe0 00ffed0007bf6f6f
 ffff88003ec20af0 ffff88003ec20ac8 ffff88003ec20158 ffff88003df817c8
 ffff88003ec20140 ffffffff875adc40 ffff88003df817c0 ffff88003dfb0000
Call Trace:
 [<ffffffff86317517>] schedule+0x97/0x1c0 kernel/sched/core.c:3311
 [<ffffffff863235db>] schedule_timeout+0x36b/0x920 kernel/time/timer.c:1531
 [<ffffffff814af882>] rcu_gp_kthread+0xad2/0x1b60 kernel/rcu/tree.c:2125
 [<ffffffff813b423f>] kthread+0x23f/0x2d0 drivers/block/aoe/aoecmd.c:1303
 [<ffffffff8632642f>] ret_from_fork+0x3f/0x70 arch/x86/entry/entry_64.S:468
BUG: spinlock lockup suspected on CPU#0, a.out/10400
 lock: 0xffff880065e348e0, .magic: dead4ead, .owner: a.out/10401, .owner_cpu: 2
CPU: 0 PID: 10400 Comm: a.out Not tainted 4.4.0+ #257
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
 00000000ffffffff ffff88003ec07c60 ffffffff8298aced ffff880065e348e0
 ffff8800356917c0 ffff8800634cc740 ffff88003ec07c98 ffffffff814643fd
 ffffffff84f30457 ffffffff00000000 ffff880065e348e0 ffff880065e348f0
Call Trace:
 <IRQ>  [<     inline     >] __dump_stack lib/dump_stack.c:15
 <IRQ>  [<ffffffff8298aced>] dump_stack+0x6f/0xa2 lib/dump_stack.c:50
 [<ffffffff814643fd>] spin_dump+0x14d/0x280 kernel/locking/spinlock_debug.c:67
 [<     inline     >] __spin_lock_debug kernel/locking/spinlock_debug.c:117
 [<ffffffff8146471d>] do_raw_spin_lock+0x15d/0x2b0
kernel/locking/spinlock_debug.c:137
 [<     inline     >] __raw_spin_lock include/linux/spinlock_api_smp.h:145
 [<ffffffff86324f9b>] _raw_spin_lock+0x3b/0x50 kernel/locking/spinlock.c:151
 [<     inline     >] spin_lock include/linux/spinlock.h:302
 [<ffffffff84f30457>] snd_timer_interrupt+0x677/0xc40 sound/core/timer.c:749
 [<ffffffff84f38d59>] snd_hrtimer_callback+0x169/0x230 sound/core/hrtimer.c:55
 [<     inline     >] __run_hrtimer kernel/time/hrtimer.c:1229
 [<ffffffff814c48d3>] __hrtimer_run_queues+0x363/0xc10
kernel/time/hrtimer.c:1293
 [<ffffffff814c68d2>] hrtimer_interrupt+0x182/0x430 kernel/time/hrtimer.c:1327
 [<ffffffff8124f062>] local_apic_timer_interrupt+0x72/0xe0
arch/x86/kernel/apic/apic.c:907
 [<ffffffff81252589>] smp_apic_timer_interrupt+0x79/0xa0
arch/x86/kernel/apic/apic.c:931
 [<ffffffff86326e6c>] apic_timer_interrupt+0x8c/0xa0
arch/x86/entry/entry_64.S:520
 [<     inline     >] spin_unlock_irqrestore include/linux/spinlock.h:362
 [<ffffffff84f32cbf>] snd_timer_start+0x12f/0x1d0 sound/core/timer.c:481
 [<     inline     >] snd_timer_user_start sound/core/timer.c:1732
 [<     inline     >] __snd_timer_user_ioctl sound/core/timer.c:1816
 [<ffffffff84f363d1>] snd_timer_user_ioctl+0x761/0x25c0 sound/core/timer.c:1837
 [<     inline     >] vfs_ioctl fs/ioctl.c:43
 [<ffffffff817ebfac>] do_vfs_ioctl+0x18c/0xfb0 fs/ioctl.c:674
 [<     inline     >] SYSC_ioctl fs/ioctl.c:689
 [<ffffffff817ece5f>] SyS_ioctl+0x8f/0xc0 fs/ioctl.c:680
 [<ffffffff86326076>] entry_SYSCALL_64_fastpath+0x16/0x7a
arch/x86/entry/entry_64.S:185
Sending NMI to all CPUs:
NMI backtrace for cpu 0
CPU: 0 PID: 10400 Comm: a.out Not tainted 4.4.0+ #257
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
task: ffff8800634cc740 ti: ffff880062ad8000 task.ti: ffff880062ad8000
RIP: 0010:[<ffffffff81262cc6>]  [<ffffffff81262cc6>]
flat_send_IPI_mask+0x156/0x290
RSP: 0018:ffff88003ec07be0  EFLAGS: 00000046
RAX: 0000000000000000 RBX: 0000000000000c00 RCX: 0000000000000000
RDX: 0000000000000c00 RSI: 0000000000000000 RDI: ffffffffff5fc300
RBP: ffff88003ec07c08 R08: 0000000000000001 R09: 0000000000000000
R10: fffffbfff10ffef2 R11: 1ffffffff1293eb5 R12: 0000000000000086
R13: 000000000f000000 R14: ffffffff87631d60 R15: 0000000000000002
FS:  00007fd28b9a2700(0000) GS:ffff88003ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007efdbab09e78 CR3: 0000000062f3f000 CR4: 00000000000006f0
Stack:
 ffffffff87631d60 ffffffff882bc380 0000000000000040 fffffbfff1057278
 ffff88006d71a4e0 ffff88003ec07c28 ffffffff8125874e ffffffff866bf480
 dffffc0000000000 ffff88003ec07c88 ffffffff829961da ffff88003ec07c60
Call Trace:
 <IRQ>  d [<ffffffff8125874e>] nmi_raise_cpu_backtrace+0x5e/0x80
arch/x86/kernel/apic/hw_nmi.c:33
 [<ffffffff829961da>] nmi_trigger_all_cpu_backtrace+0x49a/0x530
lib/nmi_backtrace.c:85
 [<ffffffff812587a4>] arch_trigger_all_cpu_backtrace+0x14/0x20
arch/x86/kernel/apic/hw_nmi.c:38
 [<     inline     >] trigger_all_cpu_backtrace include/linux/nmi.h:41
 [<     inline     >] __spin_lock_debug kernel/locking/spinlock_debug.c:119
 [<ffffffff81464727>] do_raw_spin_lock+0x167/0x2b0
kernel/locking/spinlock_debug.c:137
 [<     inline     >] __raw_spin_lock include/linux/spinlock_api_smp.h:145
 [<ffffffff86324f9b>] _raw_spin_lock+0x3b/0x50 kernel/locking/spinlock.c:151
 [<     inline     >] spin_lock include/linux/spinlock.h:302
 [<ffffffff84f30457>] snd_timer_interrupt+0x677/0xc40 sound/core/timer.c:749
 [<ffffffff84f38d59>] snd_hrtimer_callback+0x169/0x230 sound/core/hrtimer.c:55
 [<     inline     >] __run_hrtimer kernel/time/hrtimer.c:1229
 [<ffffffff814c48d3>] __hrtimer_run_queues+0x363/0xc10
kernel/time/hrtimer.c:1293
 [<ffffffff814c68d2>] hrtimer_interrupt+0x182/0x430 kernel/time/hrtimer.c:1327
 [<ffffffff8124f062>] local_apic_timer_interrupt+0x72/0xe0
arch/x86/kernel/apic/apic.c:907
 [<ffffffff81252589>] smp_apic_timer_interrupt+0x79/0xa0
arch/x86/kernel/apic/apic.c:931
 [<ffffffff86326e6c>] apic_timer_interrupt+0x8c/0xa0
arch/x86/entry/entry_64.S:520
 [<     inline     >] spin_unlock_irqrestore include/linux/spinlock.h:362
 [<ffffffff84f32cbf>] snd_timer_start+0x12f/0x1d0 sound/core/timer.c:481
 [<     inline     >] snd_timer_user_start sound/core/timer.c:1732
 [<     inline     >] __snd_timer_user_ioctl sound/core/timer.c:1816
 [<ffffffff84f363d1>] snd_timer_user_ioctl+0x761/0x25c0 sound/core/timer.c:1837
 [<     inline     >] vfs_ioctl fs/ioctl.c:43
 [<ffffffff817ebfac>] do_vfs_ioctl+0x18c/0xfb0 fs/ioctl.c:674
 [<     inline     >] SYSC_ioctl fs/ioctl.c:689
 [<ffffffff817ece5f>] SyS_ioctl+0x8f/0xc0 fs/ioctl.c:680
 [<ffffffff86326076>] entry_SYSCALL_64_fastpath+0x16/0x7a
arch/x86/entry/entry_64.S:185
Code: 00 c3 5f ff 80 e6 10 75 e1 41 c1 e5 18 44 89 2c 25 10 c3 5f ff
44 89 fa 09 da 80 cf 04 41 83 ff 02 0f 44 d3 89 14 25 00 c3 5f ff <41>
f7 c4 00 02 00 00 74 4a e8 fc 01 1f 00 48 c7 c7 68 58 63 87
NMI backtrace for cpu 1
BUG: spinlock lockup suspected on CPU#1, a.out/10267
 lock: 0xffff880065e348e0, .magic: dead4ead, .owner: a.out/10401, .owner_cpu: 2
CPU: 1 PID: 10267 Comm: a.out Not tainted 4.4.0+ #257
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
 00000000ffffffff ffff8800330dfb10 ffffffff8298aced ffff880065e348e0
 ffff8800356917c0 ffff880032b08000 ffff8800330dfb48 ffffffff814643fd
 ffffffff84f2ef29 ffff880000000000 ffff880065e348e0 ffff880065e348f0
Call Trace:
 [<     inline     >] __dump_stack lib/dump_stack.c:15
 [<ffffffff8298aced>] dump_stack+0x6f/0xa2 lib/dump_stack.c:50
 [<ffffffff814643fd>] spin_dump+0x14d/0x280 kernel/locking/spinlock_debug.c:67
 [<     inline     >] __spin_lock_debug kernel/locking/spinlock_debug.c:117
 [<ffffffff8146471d>] do_raw_spin_lock+0x15d/0x2b0
kernel/locking/spinlock_debug.c:137
 [<     inline     >] __raw_spin_lock_irqsave
include/linux/spinlock_api_smp.h:119
 [<ffffffff86325a37>] _raw_spin_lock_irqsave+0xa7/0xd0
kernel/locking/spinlock.c:159
 [<ffffffff84f2ef29>] _snd_timer_stop+0x99/0x5c0 sound/core/timer.c:505
 [<ffffffff84f2f472>] snd_timer_stop+0x22/0x140 sound/core/timer.c:539
 [<ffffffff84f2f5c3>] snd_timer_close+0x33/0x700 sound/core/timer.c:318
 [<ffffffff84f2fd27>] snd_timer_user_release+0x97/0x130 sound/core/timer.c:1282
 [<ffffffff817b36e6>] __fput+0x236/0x780 fs/file_table.c:208
 [<ffffffff817b3cb5>] ____fput+0x15/0x20 fs/file_table.c:244
 [<ffffffff813af2b0>] task_work_run+0x170/0x210 kernel/task_work.c:115
 [<     inline     >] exit_task_work include/linux/task_work.h:21
 [<ffffffff8135b275>] do_exit+0x8b5/0x2c60 kernel/exit.c:750
 [<ffffffff8135d798>] do_group_exit+0x108/0x330 kernel/exit.c:880
 [<     inline     >] SYSC_exit_group kernel/exit.c:891
 [<ffffffff8135d9dd>] SyS_exit_group+0x1d/0x20 kernel/exit.c:889
 [<ffffffff86326076>] entry_SYSCALL_64_fastpath+0x16/0x7a
arch/x86/entry/entry_64.S:185
CPU: 1 PID: 10267 Comm: a.out Not tainted 4.4.0+ #257
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
task: ffff880032b08000 ti: ffff8800330d8000 task.ti: ffff8800330d8000
RIP: 0010:[<ffffffff829b7e77>]  [<ffffffff829b7e77>] delay_tsc+0x27/0x70
RSP: 0018:ffff8800330dfb38  EFLAGS: 00000002
RAX: 000000009ff37355 RBX: ffff880065e348e0 RCX: 0000000000000029
RDX: 0000000000000053 RSI: 000000539ff37337 RDI: 0000000000000001
RBP: ffff8800330dfb38 R08: 0000000000000001 R09: 0000000000000001
R10: ffff880032b08000 R11: 0000000000000000 R12: ffff880065e348f0
R13: 000000009a9d2d40 R14: ffff880065e348e8 R15: 000000009a8b4de6
FS:  0000000000000000(0000) GS:ffff88003ed00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 00000000075a3000 CR4: 00000000000006e0
Stack:
 ffff8800330dfb48 ffffffff829b7dba ffff8800330dfb80 ffffffff81464709
 ffff880065e348e0 0000000000000286 ffff8800339656d0 ffff880065e347b0
 ffff880065e348e0 ffff8800330dfba8 ffffffff86325a37 ffffffff84f2ef29
Call Trace:
 [<ffffffff829b7dba>] __delay+0xa/0x10 arch/x86/lib/delay.c:153
 [<     inline     >] __spin_lock_debug kernel/locking/spinlock_debug.c:114
 [<ffffffff81464709>] do_raw_spin_lock+0x149/0x2b0
kernel/locking/spinlock_debug.c:137
 [<     inline     >] __raw_spin_lock_irqsave
include/linux/spinlock_api_smp.h:119
 [<ffffffff86325a37>] _raw_spin_lock_irqsave+0xa7/0xd0
kernel/locking/spinlock.c:159
 [<ffffffff84f2ef29>] _snd_timer_stop+0x99/0x5c0 sound/core/timer.c:505
 [<ffffffff84f2f472>] snd_timer_stop+0x22/0x140 sound/core/timer.c:539
 [<ffffffff84f2f5c3>] snd_timer_close+0x33/0x700 sound/core/timer.c:318
 [<ffffffff84f2fd27>] snd_timer_user_release+0x97/0x130 sound/core/timer.c:1282
 [<ffffffff817b36e6>] __fput+0x236/0x780 fs/file_table.c:208
 [<ffffffff817b3cb5>] ____fput+0x15/0x20 fs/file_table.c:244
 [<ffffffff813af2b0>] task_work_run+0x170/0x210 kernel/task_work.c:115
 [<     inline     >] exit_task_work include/linux/task_work.h:21
 [<ffffffff8135b275>] do_exit+0x8b5/0x2c60 kernel/exit.c:750
 [<ffffffff8135d798>] do_group_exit+0x108/0x330 kernel/exit.c:880
 [<     inline     >] SYSC_exit_group kernel/exit.c:891
 [<ffffffff8135d9dd>] SyS_exit_group+0x1d/0x20 kernel/exit.c:889
 [<ffffffff86326076>] entry_SYSCALL_64_fastpath+0x16/0x7a
arch/x86/entry/entry_64.S:185
Code: 00 00 00 00 55 65 ff 05 f8 cf 65 7d 48 89 e5 65 44 8b 05 bd b2
65 7d 0f ae e8 0f 31 48 c1 e2 20 48 89 d6 48 09 c6 0f ae e8 0f 31 <48>
c1 e2 20 48 09 d0 48 89 c1 48 29 f1 48 39 f9 73 27 65 ff 0d
NMI backtrace for cpu 2
CPU: 2 PID: 10401 Comm: a.out Not tainted 4.4.0+ #257
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
task: ffff8800356917c0 ti: ffff880033f48000 task.ti: ffff880033f48000
RIP: 0010:[<ffffffff81455fe8>]  [<ffffffff81455fe8>]
__lock_acquire+0x28a8/0x4700
RSP: 0018:ffff880033f4f6f0  EFLAGS: 00000046
RAX: 0000000000000086 RBX: ffffffff888ef368 RCX: ffff880035691fe8
RDX: 1ffffffff0ec6b0c RSI: ffff880035692038 RDI: ffffffff87635860
RBP: ffff880033f4f870 R08: ffffffff88ef3310 R09: 0000000000000001
R10: ffff8800356917c0 R11: 0000000000000000 R12: ffff880035692038
R13: ffffffff888ef360 R14: 000000125492c000 R15: ffffffff894e0ae0
FS:  00007efdbab0a700(0000) GS:ffff88006d600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 000000c820346c00 CR3: 00000000331e5000 CR4: 00000000000006e0
Stack:
 ffff8800356917c0 ffffffff888eeac8 000000000092a02d ffffffff888eeac0
 dffffc0000000000 ffffffff894e0ae0 ffff880035691fe0 ffff8800356917c0
 ffffffff88ef3310 ffffffff88f431a0 ffff880000000000 ffff880035692050
Call Trace:
 [<ffffffff8145a28c>] lock_acquire+0x1dc/0x430 kernel/locking/lockdep.c:3585
 [<     inline     >] __raw_spin_lock_irqsave
include/linux/spinlock_api_smp.h:112
 [<ffffffff86325a2f>] _raw_spin_lock_irqsave+0x9f/0xd0
kernel/locking/spinlock.c:159
 [<ffffffff814c3ae5>] lock_hrtimer_base.isra.19+0x75/0x130
kernel/time/hrtimer.c:147
 [<ffffffff814c4008>] hrtimer_try_to_cancel+0xb8/0x4a0
kernel/time/hrtimer.c:1042
 [<ffffffff814c4412>] hrtimer_cancel+0x22/0x40 kernel/time/hrtimer.c:1065
 [<ffffffff84f38ae0>] snd_hrtimer_start+0x140/0x1b0 sound/core/hrtimer.c:95
 [<ffffffff84f32615>] snd_timer_start1+0x215/0x2c0 sound/core/timer.c:434
 [<ffffffff84f32cb1>] snd_timer_start+0x121/0x1d0 sound/core/timer.c:480
 [<     inline     >] snd_timer_user_start sound/core/timer.c:1732
 [<     inline     >] __snd_timer_user_ioctl sound/core/timer.c:1816
 [<ffffffff84f363d1>] snd_timer_user_ioctl+0x761/0x25c0 sound/core/timer.c:1837
 [<     inline     >] vfs_ioctl fs/ioctl.c:43
 [<ffffffff817ebfac>] do_vfs_ioctl+0x18c/0xfb0 fs/ioctl.c:674
 [<     inline     >] SYSC_ioctl fs/ioctl.c:689
 [<ffffffff817ece5f>] SyS_ioctl+0x8f/0xc0 fs/ioctl.c:680
 [<ffffffff86326076>] entry_SYSCALL_64_fastpath+0x16/0x7a
arch/x86/entry/entry_64.S:185
Code: 4c 8b 54 24 68 e9 80 ea ff ff 4c 8b 54 24 40 4c 89 54 24 78 e8
ca 4f ff ff 4c 8b 54 24 78 4c 89 54 24 78 e8 4b 4d ff ff f6 c4 02 <4c>
8b 54 24 78 0f 85 97 04 00 00 65 ff 05 86 0c bc 7e e9 43 e5
NMI backtrace for cpu 3
CPU: 3 PID: 10406 Comm: a.out Not tainted 4.4.0+ #257
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
task: ffff880062924740 ti: ffff8800636e8000 task.ti: ffff8800636e8000
RIP: 0010:[<ffffffff8157508e>]  [<ffffffff8157508e>]
__sanitizer_cov_trace_pc+0xe/0x50
RSP: 0018:ffff8800636ef878  EFLAGS: 00000282
RAX: ffff880062924740 RBX: ffff8800636ef8f8 RCX: ffff880062924f68
RDX: 0000000000000000 RSI: ffff880062924f68 RDI: 0000000000000286
RBP: ffff8800636ef920 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 00000000ffffffff R14: 1ffff1000c6ddf13 R15: dffffc0000000000
FS:  00007fd28b1a1700(0000) GS:ffff88006d700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007fd28b1a0e78 CR3: 0000000062f3f000 CR4: 00000000000006e0
Stack:
 ffffffff814fa075 ffff8800636ef9e8 ffffffff81292a70 0000000000000040
 0000000041b58ab3 ffffffff8740aa52 ffffffff814f9e50 ffffffff882b8278
 0000000000000000 ffffffff81292a70 ffff8800636ef9e8 0000000000000003
Call Trace:
 [<ffffffff814fab0c>] smp_call_function_many+0x59c/0x720 kernel/smp.c:435
 [<ffffffff812931e6>] native_flush_tlb_others+0xd6/0x370 arch/x86/mm/tlb.c:154
 [<     inline     >] flush_tlb_others ./arch/x86/include/asm/paravirt.h:329
 [<ffffffff8129394f>] flush_tlb_mm_range+0x10f/0x560 arch/x86/mm/tlb.c:235
 [<ffffffff816df2d2>] tlb_flush_mmu_tlbonly+0x1e2/0x3f0 mm/memory.c:243
 [<     inline     >] tlb_flush_mmu mm/memory.c:264
 [<ffffffff816e2afb>] tlb_finish_mmu+0x1b/0xa0 mm/memory.c:276
 [<ffffffff816f8631>] unmap_region+0x261/0x350 mm/mmap.c:2408
 [<ffffffff816ff5cb>] do_munmap+0x70b/0xf30 mm/mmap.c:2602
 [<ffffffff81702fa2>] mmap_region+0x152/0x1010 mm/mmap.c:1558
 [<ffffffff817045b4>] do_mmap+0x754/0x990 mm/mmap.c:1396
 [<     inline     >] do_mmap_pgoff include/linux/mm.h:1982
 [<ffffffff816b46bf>] vm_mmap_pgoff+0x15f/0x1b0 mm/util.c:328
 [<     inline     >] SYSC_mmap_pgoff mm/mmap.c:1446
 [<ffffffff816fd868>] SyS_mmap_pgoff+0x208/0x580 mm/mmap.c:1404
 [<     inline     >] SYSC_mmap arch/x86/kernel/sys_x86_64.c:95
 [<ffffffff811b0a86>] SyS_mmap+0x16/0x20 arch/x86/kernel/sys_x86_64.c:86
 [<ffffffff86326076>] entry_SYSCALL_64_fastpath+0x16/0x7a
arch/x86/entry/entry_64.S:185
Code: a0 00 00 00 55 48 89 e5 48 8b 80 88 01 00 00 f0 ff 00 5d c3 66
0f 1f 84 00 00 00 00 00 65 48 8b 04 25 c0 4e 01 00 48 85 c0 74 1a <65>
8b 15 bb fd a9 7e 81 e2 00 ff 1f 00 75 0b 8b 90 68 12 00 00
INFO: rcu_sched detected stalls on CPUs/tasks:
(detected by 3, t=104007 jiffies, g=7699, c=7698, q=270)
All QSes seen, last rcu_sched kthread activity 104007
(4294830050-4294726043), jiffies_till_next_fqs=3, root ->qsmask 0x0
a.out           R  running task    30184 10406   6864 0x0000000a
 ffff8800636ef610 ffff88006d707ca8 ffffffff813e7989 00000000fffc519b
 00000000fffc519b ffff88006d720fc0 00000000fffde7e2 dffffc0000000000
 0000000000000000 ffff88006d707d80 ffffffff814b33aa 0000000000000000
Call Trace:
 <IRQ>  [<ffffffff813e7989>] sched_show_task+0x269/0x3b0
kernel/sched/core.c:5036
 [<     inline     >] print_other_cpu_stall kernel/rcu/tree.c:1318
 [<     inline     >] check_cpu_stall kernel/rcu/tree.c:1424
 [<     inline     >] __rcu_pending kernel/rcu/tree.c:3906
 [<     inline     >] rcu_pending kernel/rcu/tree.c:3970
 [<ffffffff814b33aa>] rcu_check_callbacks+0x1dfa/0x1e10 kernel/rcu/tree.c:2795
 [<ffffffff814c2b0a>] update_process_times+0x3a/0x70 kernel/time/timer.c:1420
 [<ffffffff814ec04f>] tick_sched_handle.isra.20+0xaf/0xe0
kernel/time/tick-sched.c:151
 [<ffffffff814ec775>] tick_sched_timer+0x75/0x100 kernel/time/tick-sched.c:1086
 [<     inline     >] __run_hrtimer kernel/time/hrtimer.c:1229
 [<ffffffff814c48d3>] __hrtimer_run_queues+0x363/0xc10
kernel/time/hrtimer.c:1293
 [<ffffffff814c68d2>] hrtimer_interrupt+0x182/0x430 kernel/time/hrtimer.c:1327
 [<ffffffff8124f062>] local_apic_timer_interrupt+0x72/0xe0
arch/x86/kernel/apic/apic.c:907
 [<ffffffff81252589>] smp_apic_timer_interrupt+0x79/0xa0
arch/x86/kernel/apic/apic.c:931
 [<ffffffff86326e6c>] apic_timer_interrupt+0x8c/0xa0
arch/x86/entry/entry_64.S:520
 [<ffffffff814fab0c>] smp_call_function_many+0x59c/0x720 kernel/smp.c:435
 [<ffffffff812931e6>] native_flush_tlb_others+0xd6/0x370 arch/x86/mm/tlb.c:154
 [<     inline     >] flush_tlb_others ./arch/x86/include/asm/paravirt.h:329
 [<ffffffff8129394f>] flush_tlb_mm_range+0x10f/0x560 arch/x86/mm/tlb.c:235
 [<ffffffff816df2d2>] tlb_flush_mmu_tlbonly+0x1e2/0x3f0 mm/memory.c:243
 [<     inline     >] tlb_flush_mmu mm/memory.c:264
 [<ffffffff816e2afb>] tlb_finish_mmu+0x1b/0xa0 mm/memory.c:276
 [<ffffffff816f8631>] unmap_region+0x261/0x350 mm/mmap.c:2408
 [<ffffffff816ff5cb>] do_munmap+0x70b/0xf30 mm/mmap.c:2602
 [<ffffffff81702fa2>] mmap_region+0x152/0x1010 mm/mmap.c:1558
 [<ffffffff817045b4>] do_mmap+0x754/0x990 mm/mmap.c:1396
 [<     inline     >] do_mmap_pgoff include/linux/mm.h:1982
 [<ffffffff816b46bf>] vm_mmap_pgoff+0x15f/0x1b0 mm/util.c:328
 [<     inline     >] SYSC_mmap_pgoff mm/mmap.c:1446
 [<ffffffff816fd868>] SyS_mmap_pgoff+0x208/0x580 mm/mmap.c:1404
 [<     inline     >] SYSC_mmap arch/x86/kernel/sys_x86_64.c:95
 [<ffffffff811b0a86>] SyS_mmap+0x16/0x20 arch/x86/kernel/sys_x86_64.c:86
 [<ffffffff86326076>] entry_SYSCALL_64_fastpath+0x16/0x7a
arch/x86/entry/entry_64.S:185
rcu_sched kthread starved for 104007 jiffies! g7699 c7698 f0x2
RCU_GP_WAIT_FQS(3) ->state=0x100
rcu_sched       W ffff88003dfb7a98 29272     8      2 0x00000000
 ffff88003dfb7a98 ffff88003ec16d40 ffff88003df81fe0 00ffed0007bf6f6f
 ffff88003ec20af0 ffff88003ec20ac8 ffff88003ec20158 ffff88003df817c8
 ffff88003ec20140 ffffffff875adc40 ffff88003df817c0 ffff88003dfb0000
Call Trace:
 [<ffffffff86317517>] schedule+0x97/0x1c0 kernel/sched/core.c:3311
 [<ffffffff863235db>] schedule_timeout+0x36b/0x920 kernel/time/timer.c:1531
 [<ffffffff814af882>] rcu_gp_kthread+0xad2/0x1b60 kernel/rcu/tree.c:2125
 [<ffffffff813b423f>] kthread+0x23f/0x2d0 drivers/block/aoe/aoecmd.c:1303
 [<ffffffff8632642f>] ret_from_fork+0x3f/0x70 arch/x86/entry/entry_64.S:468
INFO: rcu_sched detected stalls on CPUs/tasks:
(detected by 3, t=182012 jiffies, g=7699, c=7698, q=270)
All QSes seen, last rcu_sched kthread activity 182012
(4294908055-4294726043), jiffies_till_next_fqs=3, root ->qsmask 0x0
a.out           R  running task    30184 10406   6864 0x0000000a
 ffff8800636ef610 ffff88006d707ca8 ffffffff813e7989 00000000fffc519b
 00000000fffc519b ffff88006d720fc0 00000000ffff1897 dffffc0000000000
 0000000000000000 ffff88006d707d80 ffffffff814b33aa 0000000000000000
Call Trace:
 <IRQ>  [<ffffffff813e7989>] sched_show_task+0x269/0x3b0
kernel/sched/core.c:5036
 [<     inline     >] print_other_cpu_stall kernel/rcu/tree.c:1318
 [<     inline     >] check_cpu_stall kernel/rcu/tree.c:1424
 [<     inline     >] __rcu_pending kernel/rcu/tree.c:3906
 [<     inline     >] rcu_pending kernel/rcu/tree.c:3970
 [<ffffffff814b33aa>] rcu_check_callbacks+0x1dfa/0x1e10 kernel/rcu/tree.c:2795
 [<ffffffff814c2b0a>] update_process_times+0x3a/0x70 kernel/time/timer.c:1420
 [<ffffffff814ec04f>] tick_sched_handle.isra.20+0xaf/0xe0
kernel/time/tick-sched.c:151
 [<ffffffff814ec775>] tick_sched_timer+0x75/0x100 kernel/time/tick-sched.c:1086
 [<     inline     >] __run_hrtimer kernel/time/hrtimer.c:1229
 [<ffffffff814c48d3>] __hrtimer_run_queues+0x363/0xc10
kernel/time/hrtimer.c:1293
 [<ffffffff814c68d2>] hrtimer_interrupt+0x182/0x430 kernel/time/hrtimer.c:1327
 [<ffffffff8124f062>] local_apic_timer_interrupt+0x72/0xe0
arch/x86/kernel/apic/apic.c:907
 [<ffffffff81252589>] smp_apic_timer_interrupt+0x79/0xa0
arch/x86/kernel/apic/apic.c:931
 [<ffffffff86326e6c>] apic_timer_interrupt+0x8c/0xa0
arch/x86/entry/entry_64.S:520
 [<ffffffff814fab0c>] smp_call_function_many+0x59c/0x720 kernel/smp.c:435
 [<ffffffff812931e6>] native_flush_tlb_others+0xd6/0x370 arch/x86/mm/tlb.c:154
 [<     inline     >] flush_tlb_others ./arch/x86/include/asm/paravirt.h:329
 [<ffffffff8129394f>] flush_tlb_mm_range+0x10f/0x560 arch/x86/mm/tlb.c:235
 [<ffffffff816df2d2>] tlb_flush_mmu_tlbonly+0x1e2/0x3f0 mm/memory.c:243
 [<     inline     >] tlb_flush_mmu mm/memory.c:264
 [<ffffffff816e2afb>] tlb_finish_mmu+0x1b/0xa0 mm/memory.c:276
 [<ffffffff816f8631>] unmap_region+0x261/0x350 mm/mmap.c:2408
 [<ffffffff816ff5cb>] do_munmap+0x70b/0xf30 mm/mmap.c:2602
 [<ffffffff81702fa2>] mmap_region+0x152/0x1010 mm/mmap.c:1558
 [<ffffffff817045b4>] do_mmap+0x754/0x990 mm/mmap.c:1396
 [<     inline     >] do_mmap_pgoff include/linux/mm.h:1982
 [<ffffffff816b46bf>] vm_mmap_pgoff+0x15f/0x1b0 mm/util.c:328
 [<     inline     >] SYSC_mmap_pgoff mm/mmap.c:1446
 [<ffffffff816fd868>] SyS_mmap_pgoff+0x208/0x580 mm/mmap.c:1404
 [<     inline     >] SYSC_mmap arch/x86/kernel/sys_x86_64.c:95
 [<ffffffff811b0a86>] SyS_mmap+0x16/0x20 arch/x86/kernel/sys_x86_64.c:86
 [<ffffffff86326076>] entry_SYSCALL_64_fastpath+0x16/0x7a
arch/x86/entry/entry_64.S:185
rcu_sched kthread starved for 182012 jiffies! g7699 c7698 f0x2
RCU_GP_WAIT_FQS(3) ->state=0x100
rcu_sched       W ffff88003dfb7a98 29272     8      2 0x00000000
 ffff88003dfb7a98 ffff88003ec16d40 ffff88003df81fe0 00ffed0007bf6f6f
 ffff88003ec20af0 ffff88003ec20ac8 ffff88003ec20158 ffff88003df817c8
 ffff88003ec20140 ffffffff875adc40 ffff88003df817c0 ffff88003dfb0000
Call Trace:
 [<ffffffff86317517>] schedule+0x97/0x1c0 kernel/sched/core.c:3311
 [<ffffffff863235db>] schedule_timeout+0x36b/0x920 kernel/time/timer.c:1531
 [<ffffffff814af882>] rcu_gp_kthread+0xad2/0x1b60 kernel/rcu/tree.c:2125
 [<ffffffff813b423f>] kthread+0x23f/0x2d0 drivers/block/aoe/aoecmd.c:1303
 [<ffffffff8632642f>] ret_from_fork+0x3f/0x70 arch/x86/entry/entry_64.S:468
INFO: rcu_sched detected stalls on CPUs/tasks:
(detected by 3, t=260017 jiffies, g=7699, c=7698, q=270)
All QSes seen, last rcu_sched kthread activity 260017
(4294986060-4294726043), jiffies_till_next_fqs=3, root ->qsmask 0x0
a.out           R  running task    30184 10406   6864 0x0000000a
 ffff8800636ef610 ffff88006d707ca8 ffffffff813e7989 00000000fffc519b
 00000000fffc519b ffff88006d720fc0 000000010000494c dffffc0000000000
 0000000000000000 ffff88006d707d80 ffffffff814b33aa 0000000000000000
Call Trace:
 <IRQ>  [<ffffffff813e7989>] sched_show_task+0x269/0x3b0
kernel/sched/core.c:5036
 [<     inline     >] print_other_cpu_stall kernel/rcu/tree.c:1318
 [<     inline     >] check_cpu_stall kernel/rcu/tree.c:1424
 [<     inline     >] __rcu_pending kernel/rcu/tree.c:3906
 [<     inline     >] rcu_pending kernel/rcu/tree.c:3970
 [<ffffffff814b33aa>] rcu_check_callbacks+0x1dfa/0x1e10 kernel/rcu/tree.c:2795
 [<ffffffff814c2b0a>] update_process_times+0x3a/0x70 kernel/time/timer.c:1420
 [<ffffffff814ec04f>] tick_sched_handle.isra.20+0xaf/0xe0
kernel/time/tick-sched.c:151
 [<ffffffff814ec775>] tick_sched_timer+0x75/0x100 kernel/time/tick-sched.c:1086
 [<     inline     >] __run_hrtimer kernel/time/hrtimer.c:1229
 [<ffffffff814c48d3>] __hrtimer_run_queues+0x363/0xc10
kernel/time/hrtimer.c:1293
 [<ffffffff814c68d2>] hrtimer_interrupt+0x182/0x430 kernel/time/hrtimer.c:1327
 [<ffffffff8124f062>] local_apic_timer_interrupt+0x72/0xe0
arch/x86/kernel/apic/apic.c:907
 [<ffffffff81252589>] smp_apic_timer_interrupt+0x79/0xa0
arch/x86/kernel/apic/apic.c:931
 [<ffffffff86326e6c>] apic_timer_interrupt+0x8c/0xa0
arch/x86/entry/entry_64.S:520
 [<ffffffff814fab0c>] smp_call_function_many+0x59c/0x720 kernel/smp.c:435
 [<ffffffff812931e6>] native_flush_tlb_others+0xd6/0x370 arch/x86/mm/tlb.c:154
 [<     inline     >] flush_tlb_others ./arch/x86/include/asm/paravirt.h:329
 [<ffffffff8129394f>] flush_tlb_mm_range+0x10f/0x560 arch/x86/mm/tlb.c:235
 [<ffffffff816df2d2>] tlb_flush_mmu_tlbonly+0x1e2/0x3f0 mm/memory.c:243
 [<     inline     >] tlb_flush_mmu mm/memory.c:264
 [<ffffffff816e2afb>] tlb_finish_mmu+0x1b/0xa0 mm/memory.c:276
 [<ffffffff816f8631>] unmap_region+0x261/0x350 mm/mmap.c:2408
 [<ffffffff816ff5cb>] do_munmap+0x70b/0xf30 mm/mmap.c:2602
 [<ffffffff81702fa2>] mmap_region+0x152/0x1010 mm/mmap.c:1558
 [<ffffffff817045b4>] do_mmap+0x754/0x990 mm/mmap.c:1396
 [<     inline     >] do_mmap_pgoff include/linux/mm.h:1982
 [<ffffffff816b46bf>] vm_mmap_pgoff+0x15f/0x1b0 mm/util.c:328
 [<     inline     >] SYSC_mmap_pgoff mm/mmap.c:1446
 [<ffffffff816fd868>] SyS_mmap_pgoff+0x208/0x580 mm/mmap.c:1404
 [<     inline     >] SYSC_mmap arch/x86/kernel/sys_x86_64.c:95
 [<ffffffff811b0a86>] SyS_mmap+0x16/0x20 arch/x86/kernel/sys_x86_64.c:86
 [<ffffffff86326076>] entry_SYSCALL_64_fastpath+0x16/0x7a
arch/x86/entry/entry_64.S:185
rcu_sched kthread starved for 260017 jiffies! g7699 c7698 f0x2
RCU_GP_WAIT_FQS(3) ->state=0x100
rcu_sched       W ffff88003dfb7a98 29272     8      2 0x00000000
 ffff88003dfb7a98 ffff88003ec16d40 ffff88003df81fe0 00ffed0007bf6f6f
 ffff88003ec20af0 ffff88003ec20ac8 ffff88003ec20158 ffff88003df817c8
 ffff88003ec20140 ffffffff875adc40 ffff88003df817c0 ffff88003dfb0000
Call Trace:
 [<ffffffff86317517>] schedule+0x97/0x1c0 kernel/sched/core.c:3311
 [<ffffffff863235db>] schedule_timeout+0x36b/0x920 kernel/time/timer.c:1531
 [<ffffffff814af882>] rcu_gp_kthread+0xad2/0x1b60 kernel/rcu/tree.c:2125
 [<ffffffff813b423f>] kthread+0x23f/0x2d0 drivers/block/aoe/aoecmd.c:1303
 [<ffffffff8632642f>] ret_from_fork+0x3f/0x70 arch/x86/entry/entry_64.S:468






> ---
> diff --git a/sound/core/hrtimer.c b/sound/core/hrtimer.c
> index f845ecf7e172..a8027350520d 100644
> --- a/sound/core/hrtimer.c
> +++ b/sound/core/hrtimer.c
> @@ -39,6 +39,7 @@ struct snd_hrtimer {
>         struct snd_timer *timer;
>         struct hrtimer hrt;
>         atomic_t running;
> +       bool cancel_pending;
>  };
>
>  static enum hrtimer_restart snd_hrtimer_callback(struct hrtimer *hrt)
> @@ -62,7 +63,7 @@ static int snd_hrtimer_open(struct snd_timer *t)
>  {
>         struct snd_hrtimer *stime;
>
> -       stime = kmalloc(sizeof(*stime), GFP_KERNEL);
> +       stime = kzalloc(sizeof(*stime), GFP_KERNEL);
>         if (!stime)
>                 return -ENOMEM;
>         hrtimer_init(&stime->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> @@ -90,7 +91,10 @@ static int snd_hrtimer_start(struct snd_timer *t)
>         struct snd_hrtimer *stime = t->private_data;
>
>         atomic_set(&stime->running, 0);
> -       hrtimer_cancel(&stime->hrt);
> +       if (stime->cancel_pending) {
> +               hrtimer_cancel(&stime->hrt);
> +               stime->cancel_pending = false;
> +       }
>         hrtimer_start(&stime->hrt, ns_to_ktime(t->sticks * resolution),
>                       HRTIMER_MODE_REL);
>         atomic_set(&stime->running, 1);
> @@ -101,6 +105,8 @@ static int snd_hrtimer_stop(struct snd_timer *t)
>  {
>         struct snd_hrtimer *stime = t->private_data;
>         atomic_set(&stime->running, 0);
> +       if (hrtimer_try_to_cancel(&stime->hrt) < 0)
> +               stime->cancel_pending = true;
>         return 0;
>  }
>
