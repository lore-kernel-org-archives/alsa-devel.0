From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: use-after-free in snd_timer_interrupt
Date: Wed, 20 Apr 2016 09:56:04 +0200
Message-ID: <CACT4Y+Z5gh01up0jeFw7B239CGGb=a-KcjQqOvMdTYoOjL14Pg@mail.gmail.com>
References: <CACT4Y+a5Mv+7ucYvQZ4-Di0d42GNX_OR+9NBg8n1-Luc+ti9tg@mail.gmail.com>
 <s5hbn5s2ctd.wl-tiwai@suse.de> <CACT4Y+b2jCpng=_J44WUhtOqUCWoCakNu_kHOU4MBHt59+4a7g@mail.gmail.com>
 <s5h1t6n2oca.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h1t6n2oca.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 3, 2016 at 8:33 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> >> It is not easily reproducible. I've hit several times while running
>> >> fuzzer for a week. Here is one of the logs for the record:
>> >> https://gist.githubusercontent.com/dvyukov/c84798ee55721563ecb537c4d51dc9f5/raw/f00b865a85877656f13b41917f7321730f140d35/gistfile1.txt
>> >
>> > There are a few more fixes in sound/core/timer.c since 4.5, and they
>> > possibly already cover this.
>> >
>> > Please let me know if this is still seen on the upcoming 4.6-rc2.
>>
>> Hi Takashi,
>>
>> I've updated fuzzer to 05cf8077e54b20dddb756eaa26f3aeb5c38dd3cf (Apr
>> 1) yesterday. Let's see if it still happens.
>>
>> Out of curiosity, how was the bug found?
>
> Well, I'm not entirely sure whether they really cover.  It's just a
> hope, as these are patches to close some possible races :)
>
> 9984d1b5835ca29fc7025186a891ee7398d21cc7
>     ALSA: timer: Protect the whole snd_timer_close() with open race
> f65e0d299807d8a11812845c972493c3f9a18e10
>     ALSA: timer: Call notifier in the same spinlock
> 4a07083ed613644c96c34a7dd2853dc5d7c70902
>     ALSA: timer: Use mod_timer() for rearming the system timer


Hi Takashi,

I've hit it again on 806fdcce017dc98c4dbf8ed001750a0d7d2bb0af (Apr
14), all 3 commits are already in my tree.

[  343.222218] ------------[ cut here ]------------
[  343.222218] WARNING: CPU: 3 PID: 7040 at kernel/time/hrtimer.c:837
hrtimer_forward+0x26a/0x3e0
[  343.222218] Modules linked in:
[  343.222218] CPU: 3 PID: 7040 Comm: syz-executor Not tainted 4.6.0-rc3+ #349
[  343.222218] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS Bochs 01/01/2011
[  343.229525]  ffffffff87eb25c0 ffff88006d507ce0 ffffffff82c8fabf
ffffffff86abac00
[  343.229525]  fffffbfff0fd64b8 0000000000000000 0000000000000000
ffffffff86abac00
[  343.229525]  ffffffff814cfe1a 0000000000000009 ffff88006d507d28
ffffffff8136639f
[  343.229525] Call Trace:
[  343.229525]  <IRQ>  [<ffffffff82c8fabf>] dump_stack+0x12e/0x18f
[  343.229525]  [<ffffffff814cfe1a>] ? hrtimer_forward+0x26a/0x3e0
[  343.229525]  [<ffffffff8136639f>] __warn+0x19f/0x1e0
[  343.229525]  [<ffffffff813665ac>] warn_slowpath_null+0x2c/0x40
[  343.229525]  [<ffffffff814cfe1a>] hrtimer_forward+0x26a/0x3e0
[  343.229525]  [<ffffffff85382ceb>] snd_hrtimer_callback+0x11b/0x230
[  343.229525]  [<ffffffff814d1091>] __hrtimer_run_queues+0x331/0xe90
[  343.229525]  [<ffffffff85382bd0>] ? snd_hrtimer_close+0xa0/0xa0
[  343.229525]  [<ffffffff814d0d60>] ? enqueue_hrtimer+0x3d0/0x3d0
[  343.229525]  [<ffffffff814d3a62>] hrtimer_interrupt+0x182/0x430
[  343.229525]  [<ffffffff8125aa52>] local_apic_timer_interrupt+0x72/0xe0
[  343.229525]  [<ffffffff867bec99>] smp_apic_timer_interrupt+0x79/0xa0
[  343.229525]  [<ffffffff867bcfec>] apic_timer_interrupt+0x8c/0xa0
[  343.229525]  <EOI>  [<ffffffff813e2e00>] ? ___might_sleep+0x3a0/0x3a0
[  343.229525]  [<ffffffff81710fbf>] ? __might_fault+0xaf/0x1d0
[  343.229525]  [<ffffffff814d4f4d>] SyS_nanosleep+0x6d/0x100
[  343.229525]  [<ffffffff814d4ee0>] ? hrtimer_nanosleep+0x730/0x730
[  343.229525]  [<ffffffff81007b53>] ? syscall_trace_enter_phase2+0x143/0x740
[  343.229525]  [<ffffffff81008758>] ? do_syscall_64+0x48/0x640
[  343.229525]  [<ffffffff8100821b>] ? syscall_trace_enter+0xcb/0xf0
[  343.229525]  [<ffffffff814d4ee0>] ? hrtimer_nanosleep+0x730/0x730
[  343.229525]  [<ffffffff810088ef>] do_syscall_64+0x1df/0x640
[  343.229525]  [<ffffffff8100501b>] ? trace_hardirqs_on_thunk+0x1b/0x1d
[  343.229525]  [<ffffffff867bc443>] entry_SYSCALL64_slow_path+0x25/0x25
[  343.229525] ---[ end trace f4fa4ed5ea230466 ]---


For the record, here is syzkaller log:
https://gist.githubusercontent.com/dvyukov/4c31022a284421020029c877561a99ed/raw/649ebe7c882d9b4611a311f279055b272bd5443b/gistfile1.txt
