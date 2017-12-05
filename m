From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] ALSA: pcm: prevent UAF in snd_pcm_info
Date: Tue, 5 Dec 2017 09:19:32 -0800
Message-ID: <CAKwvOdmoDtJSsv-t-O4KuJoKCvGcmecBQX4bjh4G1mXP0iDTiA@mail.gmail.com>
References: <20171205171657.74392-1-ndesaulniers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20171205171657.74392-1-ndesaulniers@google.com>
Sender: stable-owner@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Robb Glasser <rglasser@google.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Markus Elfring <elfring@users.sourceforge.net>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Arvind Yadav <arvind.yadav.cs@gmail.com>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

+ stable

On Tue, Dec 5, 2017 at 9:16 AM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
> From: Robb Glasser <rglasser@google.com>
>
> When the device descriptor is closed, the `substream->runtime` pointer
> is freed. But another thread may be in the ioctl handler, case
> SNDRV_CTL_IOCTL_PCM_INFO. This case calls snd_pcm_info_user() which
> calls snd_pcm_info() which accesses the now freed `substream->runtime`.
>
> Signed-off-by: Robb Glasser <rglasser@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  sound/core/pcm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/core/pcm.c b/sound/core/pcm.c
> index 9070f277f8db..09ee8c6b9f75 100644
> --- a/sound/core/pcm.c
> +++ b/sound/core/pcm.c
> @@ -153,7 +153,9 @@ static int snd_pcm_control_ioctl(struct snd_card *card,
>                                 err = -ENXIO;
>                                 goto _error;
>                         }
> +                       mutex_lock(&pcm->open_mutex);
>                         err = snd_pcm_info_user(substream, info);
> +                       mutex_unlock(&pcm->open_mutex);
>                 _error:
>                         mutex_unlock(&register_mutex);
>                         return err;
> --
> 2.15.0.531.g2ccb3012c9-goog
>



-- 
Thanks,
~Nick Desaulniers
