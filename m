From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: uninterruptible hang in snd_seq_oss_writeq_sync
Date: Tue, 1 Mar 2016 16:45:22 +0100
Message-ID: <CACT4Y+YCHwA1o-L=ZqwsEAFCnwAF856C=xokXJ_xXFqoP0vOeg@mail.gmail.com>
References: <CACT4Y+Y4kD-aBGj37rf-xBw9bH3GMU6P+MYg4W1e-s-paVD2pg@mail.gmail.com>
 <s5ha8miuuj9.wl-tiwai@suse.de> <CACT4Y+Z_j3=vx61_+iveEoVFWFs6TiVT9SeAeiVQVs6mWsrECg@mail.gmail.com>
 <CACT4Y+a1tnWaifUF5Nbg7EFABAhPTrbdN=-XG+UQ5VFMyYwF2Q@mail.gmail.com> <s5h1t7uuse9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h1t7uuse9.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 1, 2016 at 4:31 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 01 Mar 2016 16:04:43 +0100,
> Dmitry Vyukov wrote:
>>
>> On Tue, Mar 1, 2016 at 4:01 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> > On Tue, Mar 1, 2016 at 3:44 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> >> On Tue, 01 Mar 2016 13:33:27 +0100,
>> >> Dmitry Vyukov wrote:
>> >>>
>> >>> Hello,
>> >>>
>> >>> The following program creates an unkillable process:
>> >> .....
>> >>> The hang stack is:
>> >>>
>> >>> [<ffffffff85309f77>] snd_seq_oss_writeq_sync+0x327/0x790
>> >>> sound/core/seq/oss/seq_oss_writeq.c:121
>> >>
>> >> This is
>> >>         wait_event_interruptible_timeout(q->sync_sleep, ! q->sync_event_put, HZ);
>> >>
>> >> and this should return zero
>> >>         if (signal_pending(current))
>> >>                 /* interrupted - return 0 to finish sync */
>> >>                 q->sync_event_put = 0;
>> >>         if (! q->sync_event_put || q->sync_time >= time)
>> >>                 return 0;
>> >>         return 1;
>> >>
>> >>> [<ffffffff852fa353>] snd_seq_oss_drain_write+0x113/0x160
>> >>
>> >> ... and this loop should break:
>> >>                 while (snd_seq_oss_writeq_sync(dp->writeq))
>> >>                         ;
>> >>
>> >> So, I see no obvious error in the code, so far.
>> >>
>> >> I'm running your test program now with 8 parallel runs, but I couldn't
>> >> reproduce it.  Any other specifics?
>>
>>
>> Hummm.. for me this process hangs every time, even if I just run it
>> once from console.
>> I've now retested in on clean commit
>> fc77dbd34c5c99bce46d40a2491937c3bcbd10af (without KASAN/KCOV and with
>> release gcc) and also got the same hang.
>> I can only think of a different config. I've attached mine, please try with it.
>>
>> Are signals delivered if we are already in process of dying?
>> When I kill -9 this process it does not react, so presumably wait is
>> not unblocked...
>
> Good point.
>
> But above all, it doesn't make much sense to loop this sync call.
> When wait_event*() returns, it should go out.  So, the patch like
> below should be good enough and fix your issue, too.



The patch fixes the hang for me. There is a second delay at exit, but
otherwise the process exits fine.

Tested-by: Dmitry Vyukov <dvyukov@google.com>

Thanks for quick fix!

> ---
> diff --git a/sound/core/seq/oss/seq_oss_writeq.c b/sound/core/seq/oss/seq_oss_writeq.c
> index 1f6788a18444..4014a5469d1a 100644
> --- a/sound/core/seq/oss/seq_oss_writeq.c
> +++ b/sound/core/seq/oss/seq_oss_writeq.c
> @@ -119,12 +119,7 @@ snd_seq_oss_writeq_sync(struct seq_oss_writeq *q)
>         }
>
>         wait_event_interruptible_timeout(q->sync_sleep, ! q->sync_event_put, HZ);
> -       if (signal_pending(current))
> -               /* interrupted - return 0 to finish sync */
> -               q->sync_event_put = 0;
> -       if (! q->sync_event_put || q->sync_time >= time)
> -               return 0;
> -       return 1;
> +       return 0;
>  }
>
>  /*
