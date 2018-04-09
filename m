From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: WARNING in snd_pcm_hw_params
Date: Mon, 9 Apr 2018 17:25:15 +0200
Message-ID: <CACT4Y+Zx4SU_Pe28DroSVYMhPMUxE1uKTe9721WKdh-wqF3CNw@mail.gmail.com>
References: <001a113fe6c005d8ac056922c4c3@google.com>
 <s5hbmesflxu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f52.google.com (mail-pg0-f52.google.com [74.125.83.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 23525266C99
 for <alsa-devel@alsa-project.org>; Mon,  9 Apr 2018 17:25:37 +0200 (CEST)
Received: by mail-pg0-f52.google.com with SMTP id j3so381473pgf.2
 for <alsa-devel@alsa-project.org>; Mon, 09 Apr 2018 08:25:37 -0700 (PDT)
In-Reply-To: <s5hbmesflxu.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, syzkaller-bugs@googlegroups.com, LKML <linux-kernel@vger.kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, syzbot <syzbot+803e0047ac3a3096bb4f@syzkaller.appspotmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 9, 2018 at 5:18 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Fri, 06 Apr 2018 02:02:02 +0200,
> syzbot wrote:
>>
>> WARNING: CPU: 0 PID: 4468 at sound/core/pcm_native.c:620
>> snd_pcm_hw_params_choose sound/core/pcm_native.c:620 [inline]
>
> This is a WARN_ON() to catch the inconsistent hw_params call.
> This shouldn't happen in theory, but the reality looks weirder.
>
> The necessary "fix" is just to get rid of snd_BUG_ON(), but still
> wonder which condition it hits.  If it's an empty parameter, the
> previous snd_pcm_hw_refine() should have caught and returned the error
> beforehand...

Hi Takashi,

The reproducer for this is trivially simple:

https://syzkaller.appspot.com/x/repro.syz?id=4913841943085056

(and I guess perf_event_open is red herring).

But the really important part there is probably this: Fault:true
FaultCall:2 FaultNth:18
And you can see where it actually happened in the raw console log:

Raw console output: https://syzkaller.appspot.com/x/log.txt?id=6314122077536256

Does it explain things?

> In anyway this can't be a real crash, let's remove the warning to stop
> the chorus of syzbot birds.
>
>
> thanks,
>
> Takashi
>
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: pcm: Remove WARN_ON() at snd_pcm_hw_params() error
>
> snd_pcm_hw_params() may hit WARN_ON() when an inconsistent parameter
> set is passed.  Although this should have been caught by the former
> snd_pcm_hw_refine() and returned the error, syzkaller succeeded to
> pass through and hit the WARN_ON(), which in turn made it panic
> unnecessarily.
>
> For reducing this kind of noise, let's drop snd_BUG_ON() check.
>
> Reported-by: syzbot+803e0047ac3a3096bb4f@syzkaller.appspotmail.com
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/core/pcm_native.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index b84554893fab..35ffccea94c3 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -617,7 +617,7 @@ static int snd_pcm_hw_params_choose(struct snd_pcm_substream *pcm,
>                         changed = snd_pcm_hw_param_first(pcm, params, *v, NULL);
>                 else
>                         changed = snd_pcm_hw_param_last(pcm, params, *v, NULL);
> -               if (snd_BUG_ON(changed < 0))
> +               if (changed < 0)
>                         return changed;
>                 if (changed == 0)
>                         continue;
> --
> 2.16.3
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/s5hbmesflxu.wl-tiwai%40suse.de.
> For more options, visit https://groups.google.com/d/optout.
