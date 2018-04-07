From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: INFO: rcu detected stall in snd_pcm_oss_write3 (2)
Date: Sat, 7 Apr 2018 13:58:46 +0200
Message-ID: <CACT4Y+YC7W2fTCaGAs081NQCzkA-nJxjMb7SZxouYkLDRFmUTA@mail.gmail.com>
References: <000000000000118a9a056928bbd9@google.com> <00000000000004c1de05693489a8@google.com>
 <s5hlgdzgx0k.wl-tiwai@suse.de> <CACT4Y+aTGHDimPZzeAi+QyJNio_NGTWfFM8xvndP9NceEPRwOQ@mail.gmail.com>
 <s5hin93gu2x.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hin93gu2x.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: syzbot <syzbot+150189c103427d31a053@syzkaller.appspotmail.com>, alsa-devel@alsa-project.org, Victor Chibotaru <tchibo@google.com>, syzkaller-bugs@googlegroups.com, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, LKML <linux-kernel@vger.kernel.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>
List-Id: alsa-devel@alsa-project.org

#syz dup: INFO: rcu detected stall in io_playback_transfer

On Sat, Apr 7, 2018 at 1:00 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Sat, 07 Apr 2018 12:19:33 +0200,
> Dmitry Vyukov wrote:
>>
>> On Sat, Apr 7, 2018 at 11:56 AM, Takashi Iwai <tiwai@suse.de> wrote:
>> > On Fri, 06 Apr 2018 23:14:01 +0200,
>> > syzbot wrote:
>> >>
>> >> syzbot has found reproducer for the following crash on upstream commit
>> >> 38c23685b273cfb4ccf31a199feccce3bdcb5d83 (Fri Apr 6 04:29:35 2018 +0000)
>> >> Merge tag 'armsoc-drivers' of
>> >> git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
>> >> syzbot dashboard link:
>> >> https://syzkaller.appspot.com/bug?extid=150189c103427d31a053
>> >>
>> >> So far this crash happened 15 times on upstream.
>> >> C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5405588854931456
>> >> syzkaller reproducer:
>> >> https://syzkaller.appspot.com/x/repro.syz?id=5561439796330496
>> >> Raw console output:
>> >> https://syzkaller.appspot.com/x/log.txt?id=5697900571000832
>> >> Kernel config:
>> >> https://syzkaller.appspot.com/x/.config?id=-5813481738265533882
>> >> compiler: gcc (GCC) 8.0.1 20180301 (experimental)
>> >
>> > Thanks to the reproducer, I could spot out now.
>> > Below is the patch (which was submitted as well).
>>
>> Great!
>>
>> There are 3 more recent stalls in sound, does this fix them as well?
>>
>> https://groups.google.com/forum/#!msg/syzkaller-bugs/MGfk8WH3O6k/ja2xKpdcCAAJ
>> https://groups.google.com/forum/#!msg/syzkaller-bugs/74HglwU94go/T89ohzlYCAAJ
>> https://groups.google.com/forum/#!msg/syzkaller-bugs/D2xWV7WTRDk/5y2kZyBICAAJ
>
> Yes, very likely.
>
>
> Takashi
