From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: use-after-free in hrtimer_cancel
Date: Fri, 24 Jun 2016 15:33:35 +0200
Message-ID: <CACT4Y+afOATGcrCF_AM8VGMdG9Mw8_Sz2W+rtvONLUt0y-bDuQ@mail.gmail.com>
References: <CACT4Y+Z-iJ6QyzyaJZk_oWmBKCjYecSynfsW3OdH5_bfarH=DQ@mail.gmail.com>
 <CACT4Y+b1YEr5suLfUQVd_U+AU1fJ38DmGWbrLxaNay42-nAxYQ@mail.gmail.com>
 <s5hoa7emmpy.wl-tiwai@suse.de> <CACT4Y+ZHL_P+E31k1e4Gb7Mp0vYoKtr4iytHRjU=WGHHoD=kmA@mail.gmail.com>
 <s5hr3bmsoez.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hr3bmsoez.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Sasha Levin <sasha.levin@oracle.com>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 24, 2016 at 3:32 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 21 Jun 2016 20:26:48 +0200,
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
>> >
>> > It seems that there is nothing more than opening /dev/audio and does
>> > some mmap in the job.  Is there any other relevant thing there?
>> >
>> > Also, this assumes that the first sound card is Dummy driver, right?
>> > Check /proc/asound/cards.
>> >
>> > If it's about snd-dummy driver, one blind shot would be a patch like
>> > below.  But even if it would fix, it doesn't explain why it's
>> > triggered in that way...
>> >
>> >
>> > thanks,
>> >
>> > Takashi
>> >
>> > ---
>> > diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
>> > index c0f8f613f1f1..172dacd925f5 100644
>> > --- a/sound/drivers/dummy.c
>> > +++ b/sound/drivers/dummy.c
>> > @@ -420,6 +420,7 @@ static int dummy_hrtimer_stop(struct snd_pcm_substream *substream)
>> >
>> >  static inline void dummy_hrtimer_sync(struct dummy_hrtimer_pcm *dpcm)
>> >  {
>> > +       hrtimer_cancel(&dpcm->timer);
>> >         tasklet_kill(&dpcm->tasklet);
>> >  }
>>
>>
>> Yes, this seems to fix it. I've stressed it for an hour with several
>> reproducers. If I am not mistaken, it also makes test cases run 15%
>> faster.
>
> Interesting.  Possibly because it now syncs properly before other
> restart of stream or such...
>
>> Please mail a patch.
>
> OK, below is the formal patch.
> Let me know if I can give your tested-by tag.

Sure.

Tested-by: Dmitry Vyukov <dvyukov@google.com>

> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: dummy: Fix a use-after-free at closing
>
> syzkaller fuzzer spotted a potential use-after-free case in snd-dummy
> driver when hrtimer is used as backend:
>> ==================================================================
>> BUG: KASAN: use-after-free in rb_erase+0x1b17/0x2010 at addr ffff88005e5b6f68
>>  Read of size 8 by task syz-executor/8984
>> =============================================================================
>> BUG kmalloc-192 (Not tainted): kasan: bad access detected
>> -----------------------------------------------------------------------------
>>
>> Disabling lock debugging due to kernel taint
>> INFO: Allocated in 0xbbbbbbbbbbbbbbbb age=18446705582212484632
>> ....
>> [<      none      >] dummy_hrtimer_create+0x49/0x1a0 sound/drivers/dummy.c:464
>> ....
>> INFO: Freed in 0xfffd8e09 age=18446705496313138713 cpu=2164287125 pid=-1
>> [<      none      >] dummy_hrtimer_free+0x68/0x80 sound/drivers/dummy.c:481
>> ....
>> Call Trace:
>>  [<ffffffff8179e59e>] __asan_report_load8_noabort+0x3e/0x40 mm/kasan/report.c:333
>>  [<     inline     >] rb_set_parent include/linux/rbtree_augmented.h:111
>>  [<     inline     >] __rb_erase_augmented include/linux/rbtree_augmented.h:218
>>  [<ffffffff82ca5787>] rb_erase+0x1b17/0x2010 lib/rbtree.c:427
>>  [<ffffffff82cb02e8>] timerqueue_del+0x78/0x170 lib/timerqueue.c:86
>>  [<ffffffff814d0c80>] __remove_hrtimer+0x90/0x220 kernel/time/hrtimer.c:903
>>  [<     inline     >] remove_hrtimer kernel/time/hrtimer.c:945
>>  [<ffffffff814d23da>] hrtimer_try_to_cancel+0x22a/0x570 kernel/time/hrtimer.c:1046
>>  [<ffffffff814d2742>] hrtimer_cancel+0x22/0x40 kernel/time/hrtimer.c:1066
>>  [<ffffffff85420531>] dummy_hrtimer_stop+0x91/0xb0 sound/drivers/dummy.c:417
>>  [<ffffffff854228bf>] dummy_pcm_trigger+0x17f/0x1e0 sound/drivers/dummy.c:507
>>  [<ffffffff85392170>] snd_pcm_do_stop+0x160/0x1b0 sound/core/pcm_native.c:1106
>>  [<ffffffff85391b26>] snd_pcm_action_single+0x76/0x120 sound/core/pcm_native.c:956
>>  [<ffffffff85391e01>] snd_pcm_action+0x231/0x290 sound/core/pcm_native.c:974
>>  [<     inline     >] snd_pcm_stop sound/core/pcm_native.c:1139
>>  [<ffffffff8539754d>] snd_pcm_drop+0x12d/0x1d0 sound/core/pcm_native.c:1784
>>  [<ffffffff8539d3be>] snd_pcm_common_ioctl1+0xfae/0x2150 sound/core/pcm_native.c:2805
>>  [<ffffffff8539ee91>] snd_pcm_capture_ioctl1+0x2a1/0x5e0 sound/core/pcm_native.c:2976
>>  [<ffffffff8539f2ec>] snd_pcm_kernel_ioctl+0x11c/0x160 sound/core/pcm_native.c:3020
>>  [<ffffffff853d9a44>] snd_pcm_oss_sync+0x3a4/0xa30 sound/core/oss/pcm_oss.c:1693
>>  [<ffffffff853da27d>] snd_pcm_oss_release+0x1ad/0x280 sound/core/oss/pcm_oss.c:2483
>>  .....
>
> A workaround is to call hrtimer_cancel() in dummy_hrtimer_sync() which
> is called certainly before other blocking ops.
>
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/drivers/dummy.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
> index c0f8f613f1f1..172dacd925f5 100644
> --- a/sound/drivers/dummy.c
> +++ b/sound/drivers/dummy.c
> @@ -420,6 +420,7 @@ static int dummy_hrtimer_stop(struct snd_pcm_substream *substream)
>
>  static inline void dummy_hrtimer_sync(struct dummy_hrtimer_pcm *dpcm)
>  {
> +       hrtimer_cancel(&dpcm->timer);
>         tasklet_kill(&dpcm->tasklet);
>  }
>
> --
> 2.9.0
>
