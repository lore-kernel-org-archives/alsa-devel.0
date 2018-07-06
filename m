From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: nau8824: use 64-bit arithmetic instead
 of 32-bit
Date: Thu, 5 Jul 2018 19:09:05 -0700
Message-ID: <CA+7tXiiPTSiJ==Q72Ynit-_fTLdVoy1v9PyJTchid5TjdYpkLQ@mail.gmail.com>
References: <20180705130617.GA31233@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180705130617.GA31233@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 5, 2018 at 6:06 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Add suffix ULL to constant 256 in order to give the compiler complete
> information about the proper arithmetic to use.
>
> Notice that such constant is used in a context that expects an
> expression of type u64 (64 bits, unsigned) and the following
> expression is currently being evaluated using 32-bit arithmetic:
>
> 256 * fs * 2 * mclk_src_scaling[i].param
>
> Addresses-Coverity-ID: 1432039 ("Unintentional integer overflow")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  sound/soc/codecs/nau8824.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
> index 6bd1445..468d514 100644
> --- a/sound/soc/codecs/nau8824.c
> +++ b/sound/soc/codecs/nau8824.c
> @@ -1274,7 +1274,7 @@ static int nau8824_calc_fll_param(unsigned int fll_in,
>         fvco_max = 0;
>         fvco_sel = ARRAY_SIZE(mclk_src_scaling);
>         for (i = 0; i < ARRAY_SIZE(mclk_src_scaling); i++) {
> -               fvco = 256 * fs * 2 * mclk_src_scaling[i].param;
> +               fvco = 256ULL * fs * 2 * mclk_src_scaling[i].param;

This would be better written as fvco = (256 * 2 *
mclk_src_scaling[i].param) * (u64)fs;

There no reason the entire expression must use 64 bit multiplies,
since the left side
above is know to fit in 32-bits.

The code could be more efficient if mclk_src_scaling had been sorted
by scaling ratio
instead of register value.  In fact, most of the math in this loop
could be precomputed by the
compiler if one instead though of min and max fs range for a given scaler.
