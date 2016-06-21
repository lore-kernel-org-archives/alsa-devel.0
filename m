From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: use-after-free in hrtimer_cancel
Date: Tue, 21 Jun 2016 20:26:48 +0200
Message-ID: <CACT4Y+ZHL_P+E31k1e4Gb7Mp0vYoKtr4iytHRjU=WGHHoD=kmA@mail.gmail.com>
References: <CACT4Y+Z-iJ6QyzyaJZk_oWmBKCjYecSynfsW3OdH5_bfarH=DQ@mail.gmail.com>
 <CACT4Y+b1YEr5suLfUQVd_U+AU1fJ38DmGWbrLxaNay42-nAxYQ@mail.gmail.com> <s5hoa7emmpy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hoa7emmpy.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, Sasha Levin <sasha.levin@oracle.com>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 6, 2016 at 4:11 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Sat, 04 Jun 2016 20:27:50 +0200,
> Dmitry Vyukov wrote:
>>
>> On Sat, Jun 4, 2016 at 8:00 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> > Hello,
>> >
>> > The following program triggers use-after-free:
>>
>> Forget to mention that you need to run it in a tight parallel loop. It
>> takes around 5 minutes to reproduce for me.
>
> Hmm, this again is a bug that is difficult to trigger...  At least, I
> couldn't reproduce locally.  How many processes are you running with
> stress program?
>
> It seems that there is nothing more than opening /dev/audio and does
> some mmap in the job.  Is there any other relevant thing there?
>
> Also, this assumes that the first sound card is Dummy driver, right?
> Check /proc/asound/cards.
>
> If it's about snd-dummy driver, one blind shot would be a patch like
> below.  But even if it would fix, it doesn't explain why it's
> triggered in that way...
>
>
> thanks,
>
> Takashi
>
> ---
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


Yes, this seems to fix it. I've stressed it for an hour with several
reproducers. If I am not mistaken, it also makes test cases run 15%
faster.
Please mail a patch.
