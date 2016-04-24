From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: deadlock involving snd_hrtimer_callback
Date: Sun, 24 Apr 2016 17:22:19 +0200
Message-ID: <CACT4Y+ZNKC-k1U6w6yft35h7Piz=ynf9zQgiC7qCp=jCL8xnOQ@mail.gmail.com>
References: <CACT4Y+YsEOFvJVk_AafL+OvOC9_njym7xr-KLQKK3pKRyo8oKQ@mail.gmail.com>
 <s5hpotgqbs5.wl-tiwai@suse.de> <CACT4Y+Y4m5=KGRQLa8qwT5DT52a99ODFk3auPEW+cUheY6OJ4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACT4Y+Y4m5=KGRQLa8qwT5DT52a99ODFk3auPEW+cUheY6OJ4w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>, Sasha Levin <sasha.levin@oracle.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 24, 2016 at 5:16 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Sat, Apr 23, 2016 at 11:02 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> On Sat, 23 Apr 2016 15:40:21 +0200,
>> Dmitry Vyukov wrote:
>>>
>>> Hi Takashi,
>>>
>>> I've incorporated your hrtimer fixes (but also updated to
>>> ddce192106e4f984123884f8e878f66ace94b573) and now I am seeing lots of
>>> the following deadlock messages:
>>>
>>>
>>> [ INFO: possible circular locking dependency detected ]
>>> 4.6.0-rc4+ #351 Not tainted
>>> -------------------------------------------------------
>>> swapper/0/0 is trying to acquire lock:
>>>  (&(&timer->lock)->rlock){-.-...}, at: [<ffffffff8537a749>]
>>> snd_timer_interrupt+0xa9/0xd30 sound/core/timer.c:701
>>>
>>> but task is already holding lock:
>>>  (&(&stime->lock)->rlock){-.....}, at: [<ffffffff85383d3f>]
>>> snd_hrtimer_callback+0x4f/0x2b0 sound/core/hrtimer.c:54
>>>
>>> which lock already depends on the new lock.
>>
>> Oh crap, my second patch is buggy, it leads to ABBA lock, indeed.
>> The first patch is still OK, as it just adds a new behavior mode.
>>
>> Could you replace the second patch with the below one?
>
>
> I've replaced the second path with this one. The deadlocks has gone,
> but I've hit these two hangs that look related:
>
> https://gist.githubusercontent.com/dvyukov/805718ea249c49d17ae759d1b0160684/raw/20891f7e87fe9af3967565559d465d296469244b/gistfile1.txt
> https://gist.githubusercontent.com/dvyukov/7f397ea4aeb9e35596e0c8053cf35a11/raw/3fc22f24f7bab5941e47bab604f96487b5f1944d/gistfile1.txt

Another one:

[  509.169244] BUG: spinlock lockup suspected on CPU#2, syz-executor/23652
[  509.169244]  lock: 0xffff880065662038, .magic: dead4ead, .owner:
syz-executor/23642, .owner_cpu: 0
[  509.169244] CPU: 2 PID: 23652 Comm: syz-executor Not tainted 4.6.0-rc4+ #352
[  509.169244] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Bochs 01/01/2011
[  509.169244]  ffffffff87eb25c0 ffff88006d407c58 ffffffff82c8fe0f
ffffffff5f369e98
[  509.169244]  fffffbfff0fd64b8 ffff880065662038 ffff88005f369840
ffff88005e806040
[  509.169244]  ffff880065662040 000000009a9d0630 ffff88006d407c90
ffffffff8147f75d
[  509.169244] Call Trace:
[  509.169244]  <IRQ>  [<ffffffff82c8fe0f>] dump_stack+0x12e/0x18f
[  509.169244]  [<ffffffff8147f75d>] spin_dump+0x14d/0x280
[  509.169244]  [<ffffffff8537ad39>] ? snd_timer_interrupt+0xa9/0xd30
[  509.169244]  [<ffffffff8147fa7d>] do_raw_spin_lock+0x15d/0x2b0
[  509.169244]  [<ffffffff867c04e7>] _raw_spin_lock_irqsave+0xa7/0xd0
[  509.169244]  [<ffffffff8537ad39>] ? snd_timer_interrupt+0xa9/0xd30
[  509.169244]  [<ffffffff8537ad39>] snd_timer_interrupt+0xa9/0xd30
[  509.169244]  [<ffffffff8127c405>] ? kvm_clock_get_cycles+0x25/0x30
[  509.169244]  [<ffffffff814e53ba>] ? ktime_get+0x32a/0x550
[  509.169244]  [<ffffffff853842e7>] ? snd_hrtimer_callback+0xb7/0x180
[  509.169244]  [<ffffffff814cff2c>] ? hrtimer_forward+0x1cc/0x3e0
[  509.169244]  [<ffffffff85384338>] snd_hrtimer_callback+0x108/0x180
[  509.169244]  [<ffffffff814d1241>] __hrtimer_run_queues+0x331/0xe90
[  509.169244]  [<ffffffff85384230>] ? snd_hrtimer_close+0xa0/0xa0
[  509.169244]  [<ffffffff814d0f10>] ? enqueue_hrtimer+0x3d0/0x3d0
[  509.169244]  [<ffffffff814d3c12>] hrtimer_interrupt+0x182/0x430
[  509.169244]  [<ffffffff8125aa62>] local_apic_timer_interrupt+0x72/0xe0
[  509.169244]  [<ffffffff867c31d9>] smp_apic_timer_interrupt+0x79/0xa0
[  509.169244]  [<ffffffff867c152c>] apic_timer_interrupt+0x8c/0xa0
[  509.169244]  <EOI>  [<ffffffff8171902e>] ? unmap_page_range+0x8be/0x19f0
