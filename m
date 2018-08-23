From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] ASoC: max98373: Added 10ms delay after amp software reset
Date: Wed, 22 Aug 2018 17:31:04 -0700
Message-ID: <CAKdAkRT-71tL7U1t_WMenh5kquppsZpiL=0bEyL4RLjj622zqw@mail.gmail.com>
References: <20180823001519.20056-1-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180823001519.20056-1-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ryans.lee@maximintegrated.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, lkml <linux-kernel@vger.kernel.org>, ryan.lee.maxim@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 22, 2018 at 5:21 PM Ryan Lee <ryans.lee@maximintegrated.com> wrote:
>
> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
> ---
>  Changes : Applied 10ms delay after amp software reset.
>            10ms guard time is required for stability.
>  sound/soc/codecs/max98373.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
> index 2764fae..6aaff03 100644
> --- a/sound/soc/codecs/max98373.c
> +++ b/sound/soc/codecs/max98373.c
> @@ -730,6 +730,7 @@ static int max98373_probe(struct snd_soc_component *component)
>         /* Software Reset */
>         regmap_write(max98373->regmap,
>                 MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
> +       mdelay(10);

Is it really necessary for the CPU to spin for 10msec here?
usleep_range() would be better solution.

>
>         /* IV default slot configuration */
>         regmap_write(max98373->regmap,
> @@ -818,6 +819,7 @@ static int max98373_resume(struct device *dev)
>
>         regmap_write(max98373->regmap,
>                 MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
> +       mdelay(10);
>         regcache_cache_only(max98373->regmap, false);
>         regcache_sync(max98373->regmap);
>         return 0;
> --
> 2.7.4
>

Thanks.

-- 
Dmitry
