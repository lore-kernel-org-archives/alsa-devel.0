From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 2/4] ASoC: wm8904: use common FLL code
Date: Thu, 29 Aug 2019 12:57:27 +0000
Message-ID: <20190829125340.GH10308@ediswmail.ad.cirrus.com>
References: <cover.1566734630.git.mirq-linux@rere.qmqm.pl>
 <1136f2dcc822821afda9f9533f40637647929bdf.1566734630.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1136f2dcc822821afda9f9533f40637647929bdf.1566734630.git.mirq-linux@rere.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 25, 2019 at 02:17:35PM +0200, Michał Mirosław wrote:
> Rework FLL handling to use common code introduced earlier.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---

Apologies for the slight delay in getting around to looking at
this one, been quite busy and its a lot to go through.

>  sound/soc/atmel/atmel_wm8904.c |  11 +-
>  sound/soc/codecs/Kconfig       |   1 +
>  sound/soc/codecs/wm8904.c      | 476 ++++++++++-----------------------
>  sound/soc/codecs/wm8904.h      |   5 -
>  4 files changed, 140 insertions(+), 353 deletions(-)
> 
> diff --git a/sound/soc/atmel/atmel_wm8904.c b/sound/soc/atmel/atmel_wm8904.c
> index 776b27d3686e..b77ea2495efe 100644
> --- a/sound/soc/atmel/atmel_wm8904.c
> +++ b/sound/soc/atmel/atmel_wm8904.c
> @@ -30,20 +30,11 @@ static int atmel_asoc_wm8904_hw_params(struct snd_pcm_substream *substream,
>  	struct snd_soc_dai *codec_dai = rtd->codec_dai;
>  	int ret;
>  
> -	ret = snd_soc_dai_set_pll(codec_dai, WM8904_FLL_MCLK, WM8904_FLL_MCLK,
> -		32768, params_rate(params) * 256);
> -	if (ret < 0) {
> -		pr_err("%s - failed to set wm8904 codec PLL.", __func__);
> -		return ret;
> -	}
> -

As per my last comment it would be better to move the existing
functionality of the driver over to the new library, then make
actual functional changes in a separate patch. Clearly we have
changed how the driver works here, since we no longer need to set
the FLL.

This both makes review easier and proves that the new library
approach can support the existing functionality of the driver.

> +static int wm8904_prepare_sysclk(struct wm8904_priv *priv)
> +{
> +	int err;
> +
> +	switch (priv->sysclk_src) {
> +	case WM8904_CLK_MCLK:
> +		err = clk_set_rate(priv->mclk, priv->mclk_rate);
> +		if (!err)
> +			err = clk_prepare_enable(priv->mclk);
> +		break;
> +
> +	case WM8904_CLK_FLL:
> +		err = wm_fll_enable(&priv->fll);
> +		break;
> +

Given the FLL can be sourced from the MCLK pin why is the mclk
clock never enabled in the FLL case?

> @@ -356,11 +429,18 @@ static int wm8904_configure_clocking(struct snd_soc_component *component)
>  		wm8904->sysclk_rate = rate;
>  	}
>  
> -	snd_soc_component_update_bits(component, WM8904_CLOCK_RATES_0, WM8904_MCLK_DIV,
> -			    clock0);
> -
> +	snd_soc_component_update_bits(component, WM8904_CLOCK_RATES_0,
> +				      WM8904_MCLK_DIV, clock0);

Appreciate this is probably a good formatting change but
with a large hard to review patch its better to keep unrelated
changes out of it to easy review.

> @@ -1382,8 +1445,8 @@ static int wm8904_hw_params(struct snd_pcm_substream *substream,
>  		}
>  	}
>  	wm8904->bclk = (wm8904->sysclk_rate * 10) / bclk_divs[best].div;
> -	dev_dbg(component->dev, "Selected BCLK_DIV of %d for %dHz BCLK\n",
> -		bclk_divs[best].div, wm8904->bclk);
> +	dev_dbg(component->dev, "Selected BCLK_DIV of %d.%d for %dHz BCLK\n",
> +		bclk_divs[best].div / 10, bclk_divs[best].div % 10,  wm8904->bclk);

This is a nice tidy up as well but would also be nice to not have
it in this patch.

> @@ -1937,7 +1715,6 @@ static const struct snd_soc_dai_ops wm8904_dai_ops = {
>  	.set_sysclk = wm8904_set_sysclk,
>  	.set_fmt = wm8904_set_fmt,
>  	.set_tdm_slot = wm8904_set_tdm_slot,
> -	.set_pll = wm8904_set_fll,

I am not keen on the way we are removing the ability to set the
FLL source, there may be out of tree users using this and to my
knowledge it is features that work at the moment so removing it
seems like a step backwards.

> +static const struct wm_fll_desc wm8904_fll_desc = {
> +	.ctl_offset = WM8904_FLL_CONTROL_1,
> +	.int_offset = WM8904_INTERRUPT_STATUS,
> +	.int_mask = WM8904_FLL_LOCK_EINT_MASK,
> +	.nco_reg0 = WM8904_FLL_NCO_TEST_0,
> +	.nco_reg1 = WM8904_FLL_NCO_TEST_1,
> +	.clk_ref_map = { FLL_REF_MCLK, FLL_REF_BCLK, FLL_REF_FSCLK, /* reserved */ 0 },

Minor nit, but would probably look nice to split this across a
couple of lines and would keep us under the 80 char line limit.

.clk_ref_map = {
....
},

> @@ -2165,6 +1951,19 @@ static int wm8904_i2c_probe(struct i2c_client *i2c,
>  	/* Can leave the device powered off until we need it */
> +	wm8904_disable_sysclk(wm8904);

How come this is now enabled during probe?

I trimmed down the CC list, for the next version I would suggest
using a similar list, this one was a little over sized.

Thanks,
Charles
