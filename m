From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: use-after-free in snd_timer_interrupt
Date: Fri, 15 Jan 2016 20:13:11 +0100
Message-ID: <CACT4Y+YPVUCTenSZjLfMf08NHJm1u3--Qm6a32oTdCmxUGkC0Q@mail.gmail.com>
References: <CACT4Y+ZrVvE3dgcYHRdHDG0X316VgC-=pr2U-233vVn_QbHZHw@mail.gmail.com>
 <s5hwprdv2sp.wl-tiwai@suse.de> <CACT4Y+ZFsNxsVyq_n6kh=HN1dStj_hL=B9eUu4heAHes=ixf3g@mail.gmail.com>
 <s5hio2xmh9z.wl-tiwai@suse.de> <CACT4Y+bqxg_C7JmnUSRm_9jiZ9R9XqbBV0igDdUW1ZhtqvktJw@mail.gmail.com>
 <CACT4Y+anWgMKQmNByifCs+-jizRQL9twxvRQzW3XzNJ8+a6fDw@mail.gmail.com>
 <s5hegdlmdd6.wl-tiwai@suse.de> <CACT4Y+Y62DTncEAb_S6JykY7Ps7SHo2QyCopMObBxJt2fB_NKA@mail.gmail.com>
 <s5h60yxmc99.wl-tiwai@suse.de> <s5ha8o8uoqb.wl-tiwai@suse.de>
 <CACT4Y+a-=mrGALS+yf4GwGmJGLWXVJ0mbucPAkZ7WSGFaSR0Kw@mail.gmail.com>
 <s5hwprbt8ei.wl-tiwai@suse.de> <CACT4Y+ZfAc1JZQHHbA-k_ZVN3vm9djojvmL+e=D8WO2J8FR0=A@mail.gmail.com>
 <s5hk2nbt0gp.wl-tiwai@suse.de> <CACT4Y+aOEHHEVp1YLLMr2PD_iyESMP64T-EQX18=EfvRtgOLOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACT4Y+aOEHHEVp1YLLMr2PD_iyESMP64T-EQX18=EfvRtgOLOQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 15, 2016 at 3:38 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Fri, Jan 15, 2016 at 2:51 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> On Fri, 15 Jan 2016 12:03:17 +0100,
>> Dmitry Vyukov wrote:
>>>
>>> On Fri, Jan 15, 2016 at 12:00 PM, Takashi Iwai <tiwai@suse.de> wrote:
>>> > On Fri, 15 Jan 2016 09:06:10 +0100,
>>> > Dmitry Vyukov wrote:
>>> >>
>>> >> On Thu, Jan 14, 2016 at 5:09 PM, Takashi Iwai <tiwai@suse.de> wrote:
>>> >> > On Wed, 13 Jan 2016 21:54:10 +0100,
>>> >> > Takashi Iwai wrote:
>>> >> >>
>>> >> >> OK, then this might be a possible race at the current snd_timer_stop()
>>> >> >> implementation.  There is no sync action there, so the ISR might be
>>> >> >> still alive after snd_timer_close() call.  Or might be another race.
>>> >> >> This pattern looks a bit different, as it's involved with hrtimer.
>>> >> >>
>>> >> >> I'll take a look at it tomorrow.
>>> >> >
>>> >> > I've audited the code today, but the open window doesn't look like
>>> >> > what I expected.  I found only some possible cases with slave timer
>>> >> > instances.
>>> >> >
>>> >> > In anyway, below is a test fix patch.  Since I couldn't reproduce the
>>> >> > issue on my local machines, it's hard to say whether this covers the
>>> >> > holes you fell.  Let's see...
>>> >>
>>> >>
>>> >> Hi Takashi,
>>> >>
>>> >> I would be interested to understand why other people can't reproduce
>>> >> issues that I hit pretty reliably.
>>> >> I suspect that it can be due to .config. Please try with the following
>>> >> config values.
>>> >
>>> > I guess rather other config, e.g. the kernel debug options.
>>> > I suppose you enabled KASAN and DEBUG_LIST.  What else?
>>>
>>> I've attached my config (you will need to disable CONFIG_KCOV, it is
>>> not upstreamed).
>>
>> Hm, that has lots of other drivers built-in...
>>
>>> >> I also start qemu with "-soundhw all" arg.
>>> >
>>> > OK, so you're testing with VM?  This makes easier to recheck.
>>>
>>> Yes, I start qemu as:
>>>
>>> qemu-system-x86_64 -hda wheezy.img -net
>>> user,host=10.0.2.10,hostfwd=tcp::10022-:22 -net nic -nographic -kernel
>>> arch/x86/boot/bzImage -append "console=ttyS0 root=/dev/sda debug
>>> earlyprintk=serial slub_debug=UZ" -enable-kvm -m 2G -numa
>>> node,nodeid=0,cpus=0-1 -numa node,nodeid=1,cpus=2-3 -smp
>>> sockets=2,cores=2,threads=1 -usb -usbdevice mouse -usbdevice tablet
>>> -soundhw all
>>
>> And which test did trigger use-after-free, even with all previous
>> patches?
>
> I will try to extract a new reproducer now.

Ok, I does not seem to see any crashes except the timer hangs below.
Let's consider all other bugs as fixed. I will report anything new
that I see separately.


> Meanwhile, can you try to reproduce this one:
> https://groups.google.com/forum/#!msg/syzkaller/bbtG9_h1ONU/CPLblMC6FAAJ
> ? I run the program in a tight parallel loop.
