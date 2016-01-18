From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: sound: use-after-free in snd_timer_interrupt
Date: Mon, 18 Jan 2016 14:30:13 +0100
Message-ID: <CACT4Y+bVVxUeqZnwAbLwT3dCGcpRMG9B8WZMv3jk3SHjwMWW2w@mail.gmail.com>
References: <CACT4Y+ZrVvE3dgcYHRdHDG0X316VgC-=pr2U-233vVn_QbHZHw@mail.gmail.com>
 <s5hwprdv2sp.wl-tiwai@suse.de> <CACT4Y+ZFsNxsVyq_n6kh=HN1dStj_hL=B9eUu4heAHes=ixf3g@mail.gmail.com>
 <s5hio2xmh9z.wl-tiwai@suse.de> <CACT4Y+bqxg_C7JmnUSRm_9jiZ9R9XqbBV0igDdUW1ZhtqvktJw@mail.gmail.com>
 <CACT4Y+anWgMKQmNByifCs+-jizRQL9twxvRQzW3XzNJ8+a6fDw@mail.gmail.com>
 <s5hegdlmdd6.wl-tiwai@suse.de> <CACT4Y+Y62DTncEAb_S6JykY7Ps7SHo2QyCopMObBxJt2fB_NKA@mail.gmail.com>
 <s5h60yxmc99.wl-tiwai@suse.de> <s5ha8o8uoqb.wl-tiwai@suse.de>
 <CACT4Y+a-=mrGALS+yf4GwGmJGLWXVJ0mbucPAkZ7WSGFaSR0Kw@mail.gmail.com>
 <s5hwprbt8ei.wl-tiwai@suse.de> <CACT4Y+ZfAc1JZQHHbA-k_ZVN3vm9djojvmL+e=D8WO2J8FR0=A@mail.gmail.com>
 <s5hk2nbt0gp.wl-tiwai@suse.de> <CACT4Y+aOEHHEVp1YLLMr2PD_iyESMP64T-EQX18=EfvRtgOLOQ@mail.gmail.com>
 <CACT4Y+YPVUCTenSZjLfMf08NHJm1u3--Qm6a32oTdCmxUGkC0Q@mail.gmail.com>
 <s5hk2natzwn.wl-tiwai@suse.de> <CACT4Y+Yq+yPRGw=+rzcWgKgUkK3qwRw2+miiPQ3amSO3cJ1DGw@mail.gmail.com>
 <s5hfuxytu55.wl-tiwai@suse.de> <s5hd1t2tt4q.wl-tiwai@suse.de>
 <CACT4Y+Zg4DkCJEORWAfY1ZasCs8GFkbBxTQFNZdHx+4XG_zRWg@mail.gmail.com> <s5h4mebujel.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h4mebujel.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, LKML <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Alexander Potapenko <glider@google.com>, Kostya Serebryany <kcc@google.com>, syzkaller <syzkaller@googlegroups.com>, Sasha Levin <sasha.levin@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 18, 2016 at 2:06 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> No, unfortunately the hang still happens with the patch:
>
> Thanks for testing.  I think I understood the problem.  We faced a
> similar issue and moved hrtimer_cancel() in the past.  But this wasn't
> enough, as the start function may be called also in interrupt, too.
>
> How about the one below instead?


Yes, this fixes the hang. Thanks!

Tested-by: Dmitry Vyukov <dvyukov@google.com>


> Takashi
>
> ---
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hrtimer: Fix stall by hrtimer_cancel()
>
> hrtimer_cancel() waits for the completion from the callback, thus it
> must not be called inside the callback itself.  This was already a
> problem, and the early commit [fcfdebe70759: ALSA: hrtimer - Fix
> lock-up] tried to address it.
>
> However, the previous fix is still insufficient: it may still cause a
> lockup when the ALSA timer instance reprograms itself at its
> callback.  Then it invokes the start function even in
> snd_timer_interrupt() that is called in hrtimer callback itself,
> results in a CPU stall.  It's not a hypothetical problem, as actually
> triggered by syzkaller fuzzer.
>
> This patch tries to fix the issue again.  Now we call
> hrtimer_try_to_cancel() at both start and stop functions so that it
> won't fall into a deadlock, yet giving some chance to cancel the queue
> if the functions have been called outside the callback.  The proper
> hrtimer_cancel() is called in anyway at closing, so this should be
> enough.
>
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/hrtimer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sound/core/hrtimer.c b/sound/core/hrtimer.c
> index f845ecf7e172..656d9a9032dc 100644
> --- a/sound/core/hrtimer.c
> +++ b/sound/core/hrtimer.c
> @@ -90,7 +90,7 @@ static int snd_hrtimer_start(struct snd_timer *t)
>         struct snd_hrtimer *stime = t->private_data;
>
>         atomic_set(&stime->running, 0);
> -       hrtimer_cancel(&stime->hrt);
> +       hrtimer_try_to_cancel(&stime->hrt);
>         hrtimer_start(&stime->hrt, ns_to_ktime(t->sticks * resolution),
>                       HRTIMER_MODE_REL);
>         atomic_set(&stime->running, 1);
> @@ -101,6 +101,7 @@ static int snd_hrtimer_stop(struct snd_timer *t)
>  {
>         struct snd_hrtimer *stime = t->private_data;
>         atomic_set(&stime->running, 0);
> +       hrtimer_try_to_cancel(&stime->hrt);
>         return 0;
>  }
>
> --
> 2.7.0
>
