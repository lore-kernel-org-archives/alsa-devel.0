From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: use-after-free in snd_timer_interrupt
Date: Wed, 13 Jan 2016 20:30:01 +0100
Message-ID: <CACT4Y+bqxg_C7JmnUSRm_9jiZ9R9XqbBV0igDdUW1ZhtqvktJw@mail.gmail.com>
References: <CACT4Y+ZrVvE3dgcYHRdHDG0X316VgC-=pr2U-233vVn_QbHZHw@mail.gmail.com>
 <s5hwprdv2sp.wl-tiwai@suse.de>
 <CACT4Y+ZFsNxsVyq_n6kh=HN1dStj_hL=B9eUu4heAHes=ixf3g@mail.gmail.com>
 <s5hio2xmh9z.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id A34F1260447
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2016 20:30:21 +0100 (CET)
Received: by mail-wm0-f42.google.com with SMTP id f206so309507430wmf.0
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2016 11:30:21 -0800 (PST)
In-Reply-To: <s5hio2xmh9z.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Kostya Serebryany <kcc@google.com>, Eric Dumazet <edumazet@google.com>, Mark Brown <broonie@kernel.org>, Alexander Potapenko <glider@google.com>, syzkaller <syzkaller@googlegroups.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 13, 2016 at 8:05 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Wed, 13 Jan 2016 19:34:36 +0100,
> Dmitry Vyukov wrote:
>>
>> On Wed, Jan 13, 2016 at 5:53 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > This and your other relevant reports seem pointing the race of timer
>> > ioctls.  Although snd_timer_close() itself calls snd_timer_stop(),
>> > there is no other protection against the concurrent execution.
>> >
>> > If my guess is correct, a simplistic fix like below should work.  It
>> > basically serializes the timer ioctl by using a new mutex (and
>> > replacing the old tread_sem mutex).  They are no longtime blocking
>> > calls, so this shouldn't be a big problem.  But certainly there can be
>> > a less intrusive way to paper over this if this really matters.
>> >
>> > In this case for timer.c, I'd leave the final decision rather to
>> > Jaroslav.  Jaroslav, what do you think?
>>
>>
>> After applying this patch I still see the following WARNINGS:
>>
>> ------------[ cut here ]------------
>> WARNING: CPU: 2 PID: 30398 at lib/list_debug.c:53 __list_del_entry+0x10b/0x1e0()
>> list_del corruption, ffff880032d933b0->next is LIST_POISON1 (dead000000000100)
>> Modules linked in:
>> CPU: 2 PID: 30398 Comm: syz-executor Not tainted 4.4.0+ #241
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
>>  00000000ffffffff ffff8800627778d8 ffffffff82926eed ffff880062777948
>>  ffff880061c2af80 ffffffff8660b640 ffff880062777918 ffffffff81350c89
>>  ffffffff8298e77b ffffed000c4eef25 ffffffff8660b640 0000000000000035
>> Call Trace:
>>  [<     inline     >] __dump_stack lib/dump_stack.c:15
>>  [<ffffffff82926eed>] dump_stack+0x6f/0xa2 lib/dump_stack.c:50
>>  [<ffffffff81350c89>] warn_slowpath_common+0xd9/0x140 kernel/panic.c:483
>>  [<ffffffff81350d99>] warn_slowpath_fmt+0xa9/0xd0 kernel/panic.c:495
>>  [<ffffffff8298e77b>] __list_del_entry+0x10b/0x1e0 lib/list_debug.c:51
>>  [<     inline     >] list_del_init include/linux/list.h:145
>>  [<ffffffff84ebd199>] _snd_timer_stop+0x119/0x450 sound/core/timer.c:501
>
> This is
>
>         list_del_init(&timeri->active_list);
>
> right?  Possibly the following oneliner covers it?

Yes, that is this line.
Yes, these two patches fix use-after-frees and GPFs.

Tested-by: Dmitry Vyukov <dvyukov@google.com>

The only one that still happens is "sound: spinlock lockup in
sound/core/timer.c".


> thanks,
>
> Takashi
>
> ---
> diff --git a/sound/core/timer.c b/sound/core/timer.c
> index b03a9e489286..3810ee8f1205 100644
> --- a/sound/core/timer.c
> +++ b/sound/core/timer.c
> @@ -694,7 +694,7 @@ void snd_timer_interrupt(struct snd_timer * timer, unsigned long ticks_left)
>                 } else {
>                         ti->flags &= ~SNDRV_TIMER_IFLG_RUNNING;
>                         if (--timer->running)
> -                               list_del(&ti->active_list);
> +                               list_del_init(&ti->active_list);
>                 }
>                 if ((timer->hw.flags & SNDRV_TIMER_HW_TASKLET) ||
>                     (ti->flags & SNDRV_TIMER_IFLG_FAST))
