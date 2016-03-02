From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: uninterruptible hang in snd_seq_oss_writeq_sync
Date: Wed, 2 Mar 2016 10:26:30 +0100
Message-ID: <CACT4Y+ZZVwi3WGvhK7iVDx7Zft+YJKEL2KeQM5G0CujxeNiDPQ@mail.gmail.com>
References: <CACT4Y+Y4kD-aBGj37rf-xBw9bH3GMU6P+MYg4W1e-s-paVD2pg@mail.gmail.com>
 <s5ha8miuuj9.wl-tiwai@suse.de> <CACT4Y+Z_j3=vx61_+iveEoVFWFs6TiVT9SeAeiVQVs6mWsrECg@mail.gmail.com>
 <CACT4Y+a1tnWaifUF5Nbg7EFABAhPTrbdN=-XG+UQ5VFMyYwF2Q@mail.gmail.com>
 <s5h1t7uuse9.wl-tiwai@suse.de> <CACT4Y+YCHwA1o-L=ZqwsEAFCnwAF856C=xokXJ_xXFqoP0vOeg@mail.gmail.com>
 <s5hoaayt7p0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hoaayt7p0.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 1, 2016 at 6:43 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 01 Mar 2016 16:45:22 +0100,
> Dmitry Vyukov wrote:
>>
>> On Tue, Mar 1, 2016 at 4:31 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > On Tue, 01 Mar 2016 16:04:43 +0100,
>> > Dmitry Vyukov wrote:
>> >>
>> >> On Tue, Mar 1, 2016 at 4:01 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> >> > On Tue, Mar 1, 2016 at 3:44 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> >> >> On Tue, 01 Mar 2016 13:33:27 +0100,
>> >> >> Dmitry Vyukov wrote:
>> >> >>>
>> >> >>> Hello,
>> >> >>>
>> >> >>> The following program creates an unkillable process:
>> >> >> .....
>> >> >>> The hang stack is:
>> >> >>>
>> >> >>> [<ffffffff85309f77>] snd_seq_oss_writeq_sync+0x327/0x790
>> >> >>> sound/core/seq/oss/seq_oss_writeq.c:121
>> >> >>
>> >> >> This is
>> >> >>         wait_event_interruptible_timeout(q->sync_sleep, ! q->sync_event_put, HZ);
>> >> >>
>> >> >> and this should return zero
>> >> >>         if (signal_pending(current))
>> >> >>                 /* interrupted - return 0 to finish sync */
>> >> >>                 q->sync_event_put = 0;
>> >> >>         if (! q->sync_event_put || q->sync_time >= time)
>> >> >>                 return 0;
>> >> >>         return 1;
>> >> >>
>> >> >>> [<ffffffff852fa353>] snd_seq_oss_drain_write+0x113/0x160
>> >> >>
>> >> >> ... and this loop should break:
>> >> >>                 while (snd_seq_oss_writeq_sync(dp->writeq))
>> >> >>                         ;
>> >> >>
>> >> >> So, I see no obvious error in the code, so far.
>> >> >>
>> >> >> I'm running your test program now with 8 parallel runs, but I couldn't
>> >> >> reproduce it.  Any other specifics?
>> >>
>> >>
>> >> Hummm.. for me this process hangs every time, even if I just run it
>> >> once from console.
>> >> I've now retested in on clean commit
>> >> fc77dbd34c5c99bce46d40a2491937c3bcbd10af (without KASAN/KCOV and with
>> >> release gcc) and also got the same hang.
>> >> I can only think of a different config. I've attached mine, please try with it.
>> >>
>> >> Are signals delivered if we are already in process of dying?
>> >> When I kill -9 this process it does not react, so presumably wait is
>> >> not unblocked...
>> >
>> > Good point.
>> >
>> > But above all, it doesn't make much sense to loop this sync call.
>> > When wait_event*() returns, it should go out.  So, the patch like
>> > below should be good enough and fix your issue, too.
>>
>>
>>
>> The patch fixes the hang for me. There is a second delay at exit, but
>> otherwise the process exits fine.
>>
>> Tested-by: Dmitry Vyukov <dvyukov@google.com>
>>
>> Thanks for quick fix!
>
> OK, I got the same result finally on my VM, too.  I had to disable
> INPUT_PCSPKR that conflicts with SND_PCSP.
>
> I reconsidered about this problem again, and concluded that the
> currently implemented drain behavior is simply superfluous.  So, the
> fix is just to remove all these relevant calls.  The patch is attached
> below.  Try this one instead of the previous one.

Replaced the previous fix with this one.


> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: seq: oss: Don't drain at closing a client
>
> The OSS sequencer client tries to drain the pending events at
> releasing.  Unfortunately, as spotted by syzkaller fuzzer, this may
> lead to an unkillable process state when the event has been queued at
> the far future.  Since the process being released can't be signaled
> any longer, it remains and waits for the echo-back event in that far
> future.
>
> Back to history, the draining feature was implemented at the time we
> misinterpreted POSIX definition for blocking file operation.
> Actually, such a behavior is superfluous at release, and we should
> just release the device as is instead of keeping it up forever.
>
> This patch just removes the draining call that may block the release
> for too long time unexpectedly.
>
> BugLink: http://lkml.kernel.org/r/CACT4Y+Y4kD-aBGj37rf-xBw9bH3GMU6P+MYg4W1e-s-paVD2pg@mail.gmail.com
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/seq/oss/seq_oss.c        |  2 --
>  sound/core/seq/oss/seq_oss_device.h |  1 -
>  sound/core/seq/oss/seq_oss_init.c   | 16 ----------------
>  3 files changed, 19 deletions(-)
>
> diff --git a/sound/core/seq/oss/seq_oss.c b/sound/core/seq/oss/seq_oss.c
> index 8db156b207f1..8cdf489df80e 100644
> --- a/sound/core/seq/oss/seq_oss.c
> +++ b/sound/core/seq/oss/seq_oss.c
> @@ -149,8 +149,6 @@ odev_release(struct inode *inode, struct file *file)
>         if ((dp = file->private_data) == NULL)
>                 return 0;
>
> -       snd_seq_oss_drain_write(dp);
> -
>         mutex_lock(&register_mutex);
>         snd_seq_oss_release(dp);
>         mutex_unlock(&register_mutex);
> diff --git a/sound/core/seq/oss/seq_oss_device.h b/sound/core/seq/oss/seq_oss_device.h
> index b43924325249..d7b4d016b547 100644
> --- a/sound/core/seq/oss/seq_oss_device.h
> +++ b/sound/core/seq/oss/seq_oss_device.h
> @@ -127,7 +127,6 @@ int snd_seq_oss_write(struct seq_oss_devinfo *dp, const char __user *buf, int co
>  unsigned int snd_seq_oss_poll(struct seq_oss_devinfo *dp, struct file *file, poll_table * wait);
>
>  void snd_seq_oss_reset(struct seq_oss_devinfo *dp);
> -void snd_seq_oss_drain_write(struct seq_oss_devinfo *dp);
>
>  /* */
>  void snd_seq_oss_process_queue(struct seq_oss_devinfo *dp, abstime_t time);
> diff --git a/sound/core/seq/oss/seq_oss_init.c b/sound/core/seq/oss/seq_oss_init.c
> index 6779e82b46dd..92c96a95a903 100644
> --- a/sound/core/seq/oss/seq_oss_init.c
> +++ b/sound/core/seq/oss/seq_oss_init.c
> @@ -436,22 +436,6 @@ snd_seq_oss_release(struct seq_oss_devinfo *dp)
>
>
>  /*
> - * Wait until the queue is empty (if we don't have nonblock)
> - */
> -void
> -snd_seq_oss_drain_write(struct seq_oss_devinfo *dp)
> -{
> -       if (! dp->timer->running)
> -               return;
> -       if (is_write_mode(dp->file_mode) && !is_nonblock_mode(dp->file_mode) &&
> -           dp->writeq) {
> -               while (snd_seq_oss_writeq_sync(dp->writeq))
> -                       ;
> -       }
> -}
> -
> -
> -/*
>   * reset sequencer devices
>   */
>  void
> --
> 2.7.2
>
