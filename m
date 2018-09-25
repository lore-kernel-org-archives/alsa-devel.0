From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] ASoC: soc-utils: Rename dummy_dma_ops to snd_dummy_ops
Date: Tue, 25 Sep 2018 11:36:55 +0300
Message-ID: <CAHp75VeEaB7VwO9S6y3o55XL_D27b=GhEk1sZhF9Pvsj2XsFFg@mail.gmail.com>
References: <20180925004711.99422-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925004711.99422-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 25, 2018 at 3:48 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> The symbols 'dummy_dma_ops' is declared with different data types by
> sound/soc/soc-utils.c and arch/arm64/include/asm/dma-mapping.h. This
> leads to conflicts when soc-utils.c (indirectly) includes dma-mapping.h:
>
> sound/soc/soc-utils.c:282:33: error: conflicting types for 'dummy_dma_ops'
>   static const struct snd_pcm_ops dummy_dma_ops = {
>                                   ^
> ...
> arch/arm64/include/asm/dma-mapping.h:27:33: note: previous declaration of 'dummy_dma_ops' was here
>   extern const struct dma_map_ops dummy_dma_ops;
>                                   ^
>
> Rename the symbol in soc-utils.c to 'snd_dummy_ops' to avoid the conflict.

But it misses 'dma' part as I can see they are still DMA related.

snd_dummy_dma_ops ?

>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  sound/soc/soc-utils.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
> index e0c93496c0cd..ab44133bc0bf 100644
> --- a/sound/soc/soc-utils.c
> +++ b/sound/soc/soc-utils.c
> @@ -273,13 +273,13 @@ static int dummy_dma_open(struct snd_pcm_substream *substream)
>         return 0;
>  }
>
> -static const struct snd_pcm_ops dummy_dma_ops = {
> +static const struct snd_pcm_ops snd_dummy_ops = {
>         .open           = dummy_dma_open,
>         .ioctl          = snd_pcm_lib_ioctl,
>  };
>
>  static const struct snd_soc_component_driver dummy_platform = {
> -       .ops = &dummy_dma_ops,
> +       .ops = &snd_dummy_ops,
>  };
>
>  static const struct snd_soc_component_driver dummy_codec = {
> --
> 2.19.0.605.g01d371f741-goog
>


-- 
With Best Regards,
Andy Shevchenko
