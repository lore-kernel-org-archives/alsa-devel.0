From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: INFO: rcu detected stall in memcpy
Date: Sun, 7 Jan 2018 12:30:53 +0100
Message-ID: <CACT4Y+a3jcLadSNqMDCZLOJMzcDDw6bYeUWftr+-HTwEc=xhxw@mail.gmail.com>
References: <001a113f711a23fe310561f21d1a@google.com>
 <CACT4Y+Z1oSMf8t4fWZ8_Na+TU=S59z-PTYeK71qO=Awy+nAmqw@mail.gmail.com>
 <s5hmv1tbx2v.wl-tiwai@suse.de>
 <CACT4Y+Zqm=kYx5weFtDROs1u8vNqW8oy-Dt05tsq1xZ=KLUFUw@mail.gmail.com>
 <s5hh8s1bte4.wl-tiwai@suse.de> <s5hwp0xa75m.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f54.google.com (mail-pl0-f54.google.com
 [209.85.160.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B421266B67
 for <alsa-devel@alsa-project.org>; Sun,  7 Jan 2018 12:31:16 +0100 (CET)
Received: by mail-pl0-f54.google.com with SMTP id n13so5942965plp.11
 for <alsa-devel@alsa-project.org>; Sun, 07 Jan 2018 03:31:16 -0800 (PST)
In-Reply-To: <s5hwp0xa75m.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, syzbot <syzbot+387f48da65cb522abfe8@syzkaller.appspotmail.com>, =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>, syzkaller-bugs@googlegroups.com, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 4, 2018 at 6:03 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 04 Jan 2018 15:17:23 +0100,
> Takashi Iwai wrote:
>>
>> On Thu, 04 Jan 2018 15:01:06 +0100,
>> Dmitry Vyukov wrote:
>> >
>> > On Thu, Jan 4, 2018 at 1:57 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > > On Thu, 04 Jan 2018 13:08:45 +0100,
>> > > Dmitry Vyukov wrote:
>> > >>
>> > >> On Thu, Jan 4, 2018 at 1:03 PM, syzbot
>> > >> <syzbot+387f48da65cb522abfe8@syzkaller.appspotmail.com> wrote:
>> > >> > Hello,
>> > >> >
>> > >> > syzkaller hit the following crash on
>> > >> > 30a7acd573899fd8b8ac39236eff6468b195ac7d
>> > >> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/master
>> > >> > compiler: gcc (GCC) 7.1.1 20170620
>> > >> > .config is attached
>> > >> > Raw console output is attached.
>> > >> > Unfortunately, I don't have any reproducer for this bug yet.
>> > >> >
>> > >> >
>> > >> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> > >> > Reported-by: syzbot+387f48da65cb522abfe8@syzkaller.appspotmail.com
>> > >> > It will help syzbot understand when the bug is fixed. See footer for
>> > >> > details.
>> > >> > If you forward the report, please keep this part and the footer.
>> > >>
>> > >> This looks ALSA-related. +ALSA maintainers.
>> > >
>> > > Not sure exactly what triggers it.  It's the simple memcpy(), and I
>> > > don't know where RCU is involved in that code path.
>> > >
>> > > BTW, other two suspicious RCU usage reports are actually stopped at
>> > > the second WARN_ON() after the RCU message, and the second WARN_ON()
>> > > is independent from RCU; it's the known spurious WARN_ON() and was
>> > > already removed in the sound git tree.
>> >
>> >
>> > Hi Takashi,
>> >
>> > Another similar one just popped up:
>> >
>> > https://groups.google.com/forum/#!topic/syzkaller-bugs/X3d6-PIrJM0
>> >
>> > This looks like mulaw_decode enters an infinite loop, or at least
>> > doing very large amount of computations without a resched, e.g.
>> > (uint64_t)-1 number of iterations of something along these lines.
>>
>> OK, that makes sense.
>>
>> My rough guess is that it's the misconfigured aloop device by
>> concurrent setup.  The aloop device allows to restrict the parameters
>> of the other side of the connection, and something bad may happen
>> there if both sides are updated concurrently.
>>
>> We've seen segfault by memset() at loopback_preapre() in
>> sound/drivers/aloop.c by syzbot+3902b5220e8ca27889ca, too, which
>> indicates also the wrongly setup parameters that overflows the
>> allocated buffer.
>
> Below two patches may possibly plug the holes, but I'm not entirely
> sure whether that's the exact culprit.  Could you put them into syzbot
> to watch whether they have any influence?

Hi Takashi,

I've gave an answer to this here:
https://groups.google.com/d/msg/syzkaller-bugs/7ucgCkAJKSk/skZjgavRAQAJ

> In anyway, they are obvious bugs to be fixed, so I'm going to queue to
> my tree.

The options are:
1. You can ask syzbot to test the patch separately. This requires a
reproducer, but there is this bug which has a reproducer and seems to
have the same root cause:
https://groups.google.com/d/msg/syzkaller-bugs/KrPUlf-nm5g/Vk0xEq-HAAAJ
2. You can reproduce it with the reproducer from here:
https://groups.google.com/d/msg/syzkaller-bugs/KrPUlf-nm5g/Vk0xEq-HAAAJ
and then test the patch as extensively as needed.
3. If you have some confidence that the patch fixes the problem, then
mark the commit with the tag:
Reported-by: syzbot+387f48da65cb522abfe8@syzkaller.appspotmail.com
then syzbot will notify if this still happens after the commit reaches
tested trees.
