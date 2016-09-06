From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: divide by 0 in snd_hrtimer_callback (or hang)
Date: Tue, 6 Sep 2016 16:08:00 +0200
Message-ID: <CACT4Y+ZMmxEbqH2b0Q7v983ciTNCAYhu9SaTOXZHNHXrpBxtFQ@mail.gmail.com>
References: <CACT4Y+Yw_05S47dEYLWbwMCJvfB4cb9Mdb3q1qOYLyKfJMK1bA@mail.gmail.com>
 <s5h8tv5xjw7.wl-tiwai@suse.de> <CACT4Y+aUHvS8RG+bADfZg4NPXjNRr5mNqGWJDaCThK7PKuewjw@mail.gmail.com>
 <s5hk2epw3cv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hk2epw3cv.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vegard Nossum <vegard.nossum@gmail.com>, Vegard Nossum <vegard.nossum@oracle.com>, Jaroslav Kysela <perex@perex.cz>, Kangjie Lu <kangjielu@gmail.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, syzkaller <syzkaller@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 6, 2016 at 3:43 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 06 Sep 2016 15:09:25 +0200,
> Dmitry Vyukov wrote:
>>
>> On Tue, Sep 6, 2016 at 3:00 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > On Sat, 03 Sep 2016 14:35:15 +0200,
>> > Dmitry Vyukov wrote:
>> >>
>> >> Hello,
>> >>
>> >> The following program causes either division error or hangs kernel:
>> >>
>> >> https://gist.githubusercontent.com/dvyukov/b1f33be3bfcc15d629e10db483bee1e4/raw/1574b407e0456bf8277bee423e7731641f5f2c14/gistfile1.txt
>> >>
>> >>
>> >> divide error: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN
>> >> Dumping ftrace buffer:
>> >>    (ftrace buffer empty)
>> >> Modules linked in:
>> >> CPU: 1 PID: 27320 Comm: syz-executor Not tainted 4.8.0-rc3-next-20160825+ #8
>> >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
>> >> task: ffff88003c9b2280 task.stack: ffff880027280000
>> >> RIP: 0010:[<ffffffff858e1a6c>]  [<     inline     >] ktime_divns
>> >> include/linux/ktime.h:195
>> >> RIP: 0010:[<ffffffff858e1a6c>]  [<ffffffff858e1a6c>]
>> >> snd_hrtimer_callback+0x1bc/0x3c0 sound/core/hrtimer.c:62
>> >> RSP: 0018:ffff88003ed07dd8  EFLAGS: 00010006
>> >> RAX: 0000000000004801 RBX: ffff88003d3a0a88 RCX: 0000000000000000
>> >> RDX: 0000000000000000 RSI: ffff88003d3a0aa0 RDI: ffffffff886b69a8
>> >> RBP: ffff88003ed07e30 R08: 0000010e85417665 R09: ffff88007fff7048
>> >> R10: ffff88007fff7058 R11: ffff88007fff7050 R12: ffff88003d00f840
>> >> R13: ffff88003d00f8f4 R14: ffff88003d00f970 R15: ffff88003d3a0a80
>> >> FS:  0000000000000000(0000) GS:ffff88003ed00000(0000) knlGS:0000000000000000
>> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> >> CR2: 00007f4152126db8 CR3: 000000006b896000 CR4: 00000000000006e0
>> >> DR0: 000000000000001e DR1: 000000000000001e DR2: 0000000000000000
>> >> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
>> >> Stack:
>> >>  0000000000000000 ffff88003d3a0aa0 ffff88003d00f8f8 0000000000004801
>> >>  ffff88003d3a0ae0 0000000000000000 ffff88003d3a0a88 0000000000000001
>> >>  ffff88003ed1b400 dffffc0000000000 0000000000000001 ffff88003ed07f28
>> >> Call Trace:
>> >>  <IRQ>
>> >>  [<     inline     >] __run_hrtimer kernel/time/hrtimer.c:1238
>> >>  [<ffffffff81504335>] __hrtimer_run_queues+0x325/0xe70
>> >> kernel/time/hrtimer.c:1302
>> >>  [<ffffffff81506ceb>] hrtimer_interrupt+0x18b/0x420 kernel/time/hrtimer.c:1336
>> >>  [<ffffffff8126d8df>] local_apic_timer_interrupt+0x6f/0xe0
>> >> arch/x86/kernel/apic/apic.c:933
>> >>  [<ffffffff86e13056>] smp_apic_timer_interrupt+0x76/0xa0
>> >> arch/x86/kernel/apic/apic.c:957
>> >>  [<ffffffff86e1210c>] apic_timer_interrupt+0x8c/0xa0
>> >> arch/x86/entry/entry_64.S:487
>> >>  <EOI>
>> >>  [<     inline     >] rcu_lock_release include/linux/rcupdate.h:494
>> >>  [<     inline     >] rcu_read_unlock include/linux/rcupdate.h:927
>> >>  [<ffffffff81839f55>] unlock_page_memcg+0x95/0x130 mm/memcontrol.c:1680
>> >>  [<     inline     >] page_remove_file_rmap mm/rmap.c:1343
>> >>  [<ffffffff817b742c>] page_remove_rmap+0x1cc/0x8e0 mm/rmap.c:1394
>> >>  [<     inline     >] zap_pte_range mm/memory.c:1170
>> >>  [<     inline     >] zap_pmd_range mm/memory.c:1257
>> >>  [<     inline     >] zap_pud_range mm/memory.c:1278
>> >>  [<ffffffff81789119>] unmap_page_range+0xf89/0x1ba0 mm/memory.c:1299
>> >>  [<ffffffff81789e31>] unmap_single_vma+0x101/0x260 mm/memory.c:1344
>> >>  [<ffffffff8178a741>] unmap_vmas+0xf1/0x1b0
>> >>  [<ffffffff817a5aab>] exit_mmap+0x22b/0x420 mm/mmap.c:2787
>> >>  [<     inline     >] __mmput kernel/fork.c:770
>> >>  [<ffffffff8137c576>] mmput+0xd6/0x3c0 kernel/fork.c:790
>> >>  [<     inline     >] exit_mm kernel/exit.c:512
>> >>  [<ffffffff813940e8>] do_exit+0x738/0x2e70 kernel/exit.c:815
>> >>  [<ffffffff81396998>] do_group_exit+0x108/0x330 kernel/exit.c:958
>> >>  [<ffffffff813ba4aa>] get_signal+0x62a/0x15d0 kernel/signal.c:2307
>> >>  [<ffffffff81202333>] do_signal+0x83/0x1f60 arch/x86/kernel/signal.c:805
>> >>  [<ffffffff81006345>] exit_to_usermode_loop+0x1a5/0x210
>> >> arch/x86/entry/common.c:163
>> >>  [<     inline     >] prepare_exit_to_usermode arch/x86/entry/common.c:198
>> >>  [<     inline     >] syscall_return_slowpath arch/x86/entry/common.c:267
>> >>  [<ffffffff81008be0>] do_syscall_64+0x4c0/0x640 arch/x86/entry/common.c:293
>> >>  [<ffffffff86e107c3>] entry_SYSCALL64_slow_path+0x25/0x25
>> >> Code: cb a2 ce fb 8b 0d f5 21 70 05 48 0f af 4d d0 48 85 c9 0f 88 6a
>> >> 01 00 00 48 89 4d a8 e8 ae a2 ce fb 48 8b 45 c0 48 8b 4d a8 48 99 <48>
>> >> f7 f9 48 01 45 d0 e8 98 a2 ce fb 4c 89 fa 48 b8 00 00 00 00
>> >> RIP  [<     inline     >] ktime_divns include/linux/ktime.h:195
>> >> RIP  [<ffffffff858e1a6c>] snd_hrtimer_callback+0x1bc/0x3c0
>> >> sound/core/hrtimer.c:62
>> >>  RSP <ffff88003ed07dd8>
>> >> ---[ end trace e1a6d1e5a6136d50 ]---
>> >>
>> >>
>> >> or:
>> >>
>> >> INFO: rcu_sched detected stalls on CPUs/tasks:
>> >> 0-...: (1 GPs behind) idle=203/140000000000001/0 softirq=923090/923091 fqs=6490
>> >> (detected by 1, t=26002 jiffies, g=508022, c=508021, q=20)
>> >> Task dump for CPU 0:
>> >> a.out           R  running task    28848 31756   4047 0x0000000a
>> >>  0000000000000000 0000000000000282 0000000000000000 ffff880066a9b430
>> >>  ffff880066a9b430 ffff8800667cfae0 0000000000000282 0000000000000000
>> >>  0000000000000000 0000000000000000 000003a0184674dd dffffc0000000000
>> >> Call Trace:
>> >>  [<     inline     >] spin_unlock_irqrestore ./include/linux/spinlock.h:362
>> >>  [<ffffffff858db3dd>] snd_timer_start1+0xdd/0x740 sound/core/timer.c:477
>> >>  [<ffffffff858dbb25>] snd_timer_continue+0x45/0x80 sound/core/timer.c:606
>> >>  [<     inline     >] snd_timer_user_continue sound/core/timer.c:1835
>> >>  [<     inline     >] __snd_timer_user_ioctl sound/core/timer.c:1902
>> >>  [<ffffffff858df299>] snd_timer_user_ioctl+0xe99/0x2470 sound/core/timer.c:1917
>> >>  [<     inline     >] vfs_ioctl fs/ioctl.c:43
>> >>  [<ffffffff818a1dfc>] do_vfs_ioctl+0x18c/0x1080 fs/ioctl.c:675
>> >>  [<     inline     >] SYSC_ioctl fs/ioctl.c:690
>> >>  [<ffffffff818a2d7f>] SyS_ioctl+0x8f/0xc0 fs/ioctl.c:681
>> >>  [<ffffffff86e10700>] entry_SYSCALL_64_fastpath+0x23/0xc1
>> >> arch/x86/entry/entry_64.S:208
>> >>
>> >>
>> >>
>> >> I am on 0f98f121e1670eaa2a2fbb675e07d6ba7f0e146f of linux-next with
>> >> the following diff in sound/core/timer.c (one is a fix for another
>> >> division by 0):
>> >>
>> >> diff --git a/sound/core/timer.c b/sound/core/timer.c
>> >> index 9a6157e..3e55c6d 100644
>> >> --- a/sound/core/timer.c
>> >> +++ b/sound/core/timer.c
>> >> @@ -813,6 +813,7 @@ int snd_timer_new(struct snd_card *card, char *id,
>> >> struct snd_timer_id *tid,
>> >>         timer->tmr_subdevice = tid->subdevice;
>> >>         if (id)
>> >>                 strlcpy(timer->id, id, sizeof(timer->id));
>> >> +       timer->sticks = 1;
>> >>         INIT_LIST_HEAD(&timer->device_list);
>> >>         INIT_LIST_HEAD(&timer->open_list_head);
>> >>         INIT_LIST_HEAD(&timer->active_list_head);
>> >> @@ -1958,6 +1959,7 @@ static ssize_t snd_timer_user_read(struct file
>> >> *file, char __user *buffer,
>> >>                 tu->qused--;
>> >>                 spin_unlock_irq(&tu->qlock);
>> >>
>> >> +               mutex_lock(&tu->ioctl_lock);
>> >>                 if (tu->tread) {
>> >>                         if (copy_to_user(buffer, &tu->tqueue[qhead],
>> >>                                          sizeof(struct snd_timer_tread)))
>> >> @@ -1967,6 +1969,7 @@ static ssize_t snd_timer_user_read(struct file
>> >> *file, char __user *buffer,
>> >>                                          sizeof(struct snd_timer_read)))
>> >>                                 err = -EFAULT;
>> >>                 }
>> >> +               mutex_unlock(&tu->ioctl_lock);
>> >>
>> >>                 spin_lock_irq(&tu->qlock);
>> >>                 if (err < 0)
>> >>
>> >
>> > I couldn't trigger the bug any longer after merging for-linus branch
>> > of sound.git tree:
>> >   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>> >
>> > But I thought it got fixed by sticks=1 in the above.  Maybe it's a
>> > combination, as it contains yet another timer fix by Vegard.
>>
>>
>> You mean that my local changes are a combination of two patches? But I
>> would not expect that addition of mutex_lock/unlock can affect
>> division by 0.
>> Or you mean that there some other fix by Vegard? What is it?
>
> There is another fix
>   8ddc05638ee42b18ba4fe99b5fb647fa3ad20456
>     ALSA: timer: fix NULL pointer dereference on memory allocation failure
> But it's likely irrelevant.
>
> I retested now, and could see the latter stack trace, the rcu tall,
> while running the program, although it doesn't lead to a complete
> freeze and the system is restored once after the program quits.

Are you sure it get back to normal?
RCU stall is printed when a CPU does not respond to timer interrupts
for 20s. Try to do 'echo -n l > /proc/sysrq-trigger'.


> Do you really see the zero-division error with sticks=1 fix?  That's
> unexpected.
>
>
> Takashi
