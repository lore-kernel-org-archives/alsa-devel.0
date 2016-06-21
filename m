From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: use-after-free in hrtimer_cancel
Date: Tue, 21 Jun 2016 19:41:28 +0200
Message-ID: <CACT4Y+baYcM256_rdnqa0pow_-VgMxavMJtcdLU2HgjiKwFuyA@mail.gmail.com>
References: <CACT4Y+Z-iJ6QyzyaJZk_oWmBKCjYecSynfsW3OdH5_bfarH=DQ@mail.gmail.com>
 <CACT4Y+b1YEr5suLfUQVd_U+AU1fJ38DmGWbrLxaNay42-nAxYQ@mail.gmail.com>
 <s5hoa7emmpy.wl-tiwai@suse.de> <CACT4Y+ZQn21O6YMphSQs9kM9KREST_MWXOyAbxNiLP7BREJqfg@mail.gmail.com>
 <s5h1t4ae0gq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h1t4ae0gq.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Sasha Levin <sasha.levin@oracle.com>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 6, 2016 at 6:39 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 06 Jun 2016 18:29:25 +0200,
> Dmitry Vyukov wrote:
>>
>> On Mon, Jun 6, 2016 at 4:11 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > On Sat, 04 Jun 2016 20:27:50 +0200,
>> > Dmitry Vyukov wrote:
>> >>
>> >> On Sat, Jun 4, 2016 at 8:00 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> >> > Hello,
>> >> >
>> >> > The following program triggers use-after-free:
>> >>
>> >> Forget to mention that you need to run it in a tight parallel loop. It
>> >> takes around 5 minutes to reproduce for me.
>> >
>> > Hmm, this again is a bug that is difficult to trigger...  At least, I
>> > couldn't reproduce locally.  How many processes are you running with
>> > stress program?
>>
>> I use a VM with 4 cores and use 20 parallel test processes.
>>
>> > It seems that there is nothing more than opening /dev/audio and does
>> > some mmap in the job.  Is there any other relevant thing there?
>>
>>
>> I think poll with timeout is related. It is poll who sets hrtimer, right?
>
> If it's about snd-dummy driver, hrtimer is created at open, and
> started/stopped at PCM trigger, and removed at close.
>
> Is there any good way to decode which syscalls are executed in the
> test code?

What do you mean?
Here are the syscalls in the program:

    r[2] = syscall(SYS_open, "/dev/audio", 0xa40ul, 0, 0, 0);
    // r[2] is in the descriptor passed to SYS_poll
    r[15] = syscall(SYS_poll, 0x2001dde8ul, 0x4ul, 0x8ul, 0, 0, 0);
    r[18] = syscall(SYS_readv, r[2], 0x20dc13c0ul, 0x1ul, 0, 0, 0);
    r[19] = syscall(SYS_read, r[2], 0x20dbefe0ul, 0x20ul, 0, 0, 0);
