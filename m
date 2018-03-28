From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] pcm_native: Remove VLA usage
Date: Wed, 28 Mar 2018 15:14:17 -0700
Message-ID: <CAGXu5jKNQSUNK2ZA9E_3=rUYjgdZ786XBowgMLM+H8=r_O9NLw@mail.gmail.com>
References: <1522275079-2229-1-git-send-email-kyle@spiers.me>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522275079-2229-1-git-send-email-kyle@spiers.me>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyle Spiers <kyle@spiers.me>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, moderated for non-subscribers <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 28, 2018 at 3:11 PM, Kyle Spiers <kyle@spiers.me> wrote:
> As part of the effort to remove VLAs from the kernel[1], this changes
> the allocation of the rstamps array from being on the stack to being
> kcalloc()ed. This also allows for the removal of the explicit zeroing
> loop.
>
> [1] https://lkml.org/lkml/2018/3/7/621
>
> Signed-off-by: Kyle Spiers <kyle@spiers.me>
> ---
>  sound/core/pcm_native.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index 77ba50d..57240b8 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -323,7 +323,7 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
>         struct snd_pcm_hw_constraints *constrs =
>                                         &substream->runtime->hw_constraints;
>         unsigned int k;
> -       unsigned int rstamps[constrs->rules_num];
> +       unsigned int *rstamps;
>         unsigned int vstamps[SNDRV_PCM_HW_PARAM_LAST_INTERVAL + 1];
>         unsigned int stamp;
>         struct snd_pcm_hw_rule *r;
> @@ -339,8 +339,8 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
>          * Each member of 'rstamps' array represents the sequence number of
>          * recent application of corresponding rule.
>          */
> -       for (k = 0; k < constrs->rules_num; k++)
> -               rstamps[k] = 0;
> +
> +       rstamps = kcalloc(constrs->rules_num, sizeof(*rstamps), GFP_KERNEL);
>
>         /*
>          * Each member of 'vstamps' array represents the sequence number of
> @@ -399,6 +399,7 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
>
>                 changed = r->func(params, r);
>                 if (changed < 0)
> +                       kfree(rstamps);
>                         return changed;

Whoops, this needs { } s:

if (changed < 0) {
    kfree(rstamps);
    return changed;
}

Otherwise, looks good! Once that's fixed:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>
>                 /*
> @@ -430,6 +431,7 @@ static int constrain_params_by_rules(struct snd_pcm_substream *substream,
>         if (again)
>                 goto retry;
>
> +       kfree(rstamps);
>         return 0;
>  }
>
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
