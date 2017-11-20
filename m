From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: BUG: unable to handle kernel paging request in snd_seq_oss_readq_puts
Date: Mon, 20 Nov 2017 17:31:45 +0100
Message-ID: <CACT4Y+ZbLcyZYCcKnFGKbTqT6B-a_9YqSN_g1ypQgepXkyN35w@mail.gmail.com>
References: <001a1140b6b825822a055cf02f93@google.com> <CACT4Y+a2eNABZqqcGe1idMX80pS+HrYgM74BiNz8LZjNXDPKXA@mail.gmail.com>
 <s5h4lqddbk9.wl-tiwai@suse.de> <CACT4Y+bMCWVZXM8NEzC=RhDigxm8ibwZdpmAOPKN1nDra0wBGQ@mail.gmail.com>
 <s5hbmjxxezo.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hbmjxxezo.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: syzbot <bot+31681772ec7a18dde8d3f8caf475f361a89b9514@syzkaller.appspotmail.com>, alsa-devel@alsa-project.org, syzkaller-bugs@googlegroups.com, Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 20, 2017 at 2:21 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 20 Nov 2017 13:47:28 +0100,
> Dmitry Vyukov wrote:
>>
>> On Wed, Nov 1, 2017 at 8:49 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > On Wed, 01 Nov 2017 19:39:46 +0100,
>> > Dmitry Vyukov wrote:
>> >>
>> >> On Wed, Nov 1, 2017 at 9:38 PM, syzbot
>> >> <bot+31681772ec7a18dde8d3f8caf475f361a89b9514@syzkaller.appspotmail.com>
>> >> wrote:
>> >> > Hello,
>> >> >
>> >> > syzkaller hit the following crash on
>> >> > fc2e8b1a47c14b22c33eb087fca0db58e1f4ed0e
>> >> > git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/master
>> >> > compiler: gcc (GCC) 7.1.1 20170620
>> >> > .config is attached
>> >> > Raw console output is attached.
>> >> > C reproducer is attached
>> >> > syzkaller reproducer is attached. See https://goo.gl/kgGztJ
>> >> > for information about syzkaller reproducers
>> >>
>> >> This also happened on more recent commits, including upstream
>> >> 9c323bff13f92832e03657cabdd70d731408d621 (Oct 20):
>> >
>> > Could you try the patch below with CONFIG_SND_DEBUG=y and see whether
>> > it catches any bad calls?  It's already in for-next branch for 4.15.
>>
>>
>> Hi Takashi,
>>
>> Unfortunately it's not possible to test custom patches in syzbot infrastructure.
>> We've experimented with applying a bunch of custom patches in the past
>> and it lead to unrecoverable mess. We were not able to communicate
>> precise state of code with reports, we were not able to provide
>> meaningful report with line numbers that matter (not possible to
>> understand what exactly line caused a bug), developers could
>> (rightfully) suspect that some bugs might be caused the unknown set of
>> private patches, random subset of patches won't apply and that set
>> changes over time and depends on order in which we apply patches, etc.
>> It's also not possible to dedicate a syzkaller instance with a bunch
>> of attached machines for this. First, it will require lots of
>> resources (your request is not unique). Then, whenever we test kernel
>> we get dozens of bugs. What should we do with these bugs? We don't
>> know which are related to your patch and which are not. We can't
>> report them upstream (see above). Basically you would need to go
>> through these dozens of bugs after testing and do something with each
>> of them, but I don't think you want to.
>>
>> But we are happy to test whatever is in upstream tree (this patch already is).
>
> The bug turned out to be a different issue as the suggested patch may
> fix, and I believe we already address it by the upstream commit
> 132d358b183ac6ad8b3fea32ad5e0663456d18d1
>     ALSA: seq: Fix OSS sysex delivery in OSS emulation
>
> I thought I submitted the fix line, but it might be to another syzbot
> report or I did wrong.

Yes, you submitted the fix line above.
syzbot already detected that the fix reached all of tested branches
for this bug.


>> Re CONFIG_SND_DEBUG=y, should we enable it permanently in syzbot configs?
>
> Yes, it's worth to have CONFIG_SND_DEBUG=y in fuzzer.
>
>> From our point of view, the more debug configs are enabled, the more
>> bugs we find, the better. There just must be somebody who will then
>> fix problems uncovered by the config (either bugs of config false
>> positives).
>
> In the case of CONFIG_SND_DEBUG, it gives more debug hints by adding
> WARN_ON(), but the code behavior is almost same.
>
>> If you will take a look on the config attached to the first mail, do
>> you see anything else to fix there re sound? Maybe turn off some
>> deprecated configs that nobody uses for a long time? Or enable some
>> new configs?
>
> CONFIG_SND_DYNAMIC_MINORS=y is recommended for modern systems, too.

I've enabled CONFIG_SND_DEBUG and CONFIG_SND_DYNAMIC_MINORS in syzbot configs.
