From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: adau1701: Use
	gpio_set_value_cansleep()
Date: Mon, 12 Aug 2013 10:33:08 +0200
Message-ID: <52089DC4.5070605@metafoo.de>
References: <1376230558-16248-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 24DFE260307
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2013 10:32:57 +0200 (CEST)
In-Reply-To: <1376230558-16248-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>, device-drivers-devel@blackfin.uclinux.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 08/11/2013 04:15 PM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
>
> The GPIO manipulation done by this driver is never in atomic context so
> we can use gpio_set_value_cansleep() and support GPIOs that can't be set
> from atomic context.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>   sound/soc/codecs/adau1701.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
> index 2c10252..ebff112 100644
> --- a/sound/soc/codecs/adau1701.c
> +++ b/sound/soc/codecs/adau1701.c
> @@ -247,21 +247,21 @@ static int adau1701_reset(struct snd_soc_codec *codec, unsigned int clkdiv)
>   	    gpio_is_valid(adau1701->gpio_pll_mode[1])) {
>   		switch (clkdiv) {
>   		case 64:
> -			gpio_set_value(adau1701->gpio_pll_mode[0], 0);
> -			gpio_set_value(adau1701->gpio_pll_mode[1], 0);
> +			gpio_set_value_cansleep(adau1701->gpio_pll_mode[0], 0);
> +			gpio_set_value_cansleep(adau1701->gpio_pll_mode[1], 0);
>   			break;
>   		case 256:
> -			gpio_set_value(adau1701->gpio_pll_mode[0], 0);
> -			gpio_set_value(adau1701->gpio_pll_mode[1], 1);
> +			gpio_set_value_cansleep(adau1701->gpio_pll_mode[0], 0);
> +			gpio_set_value_cansleep(adau1701->gpio_pll_mode[1], 1);
>   			break;
>   		case 384:
> -			gpio_set_value(adau1701->gpio_pll_mode[0], 1);
> -			gpio_set_value(adau1701->gpio_pll_mode[1], 0);
> +			gpio_set_value_cansleep(adau1701->gpio_pll_mode[0], 1);
> +			gpio_set_value_cansleep(adau1701->gpio_pll_mode[1], 0);
>   			break;
>   		case 0:	/* fallback */
>   		case 512:
> -			gpio_set_value(adau1701->gpio_pll_mode[0], 1);
> -			gpio_set_value(adau1701->gpio_pll_mode[1], 1);
> +			gpio_set_value_cansleep(adau1701->gpio_pll_mode[0], 1);
> +			gpio_set_value_cansleep(adau1701->gpio_pll_mode[1], 1);
>   			break;
>   		}
>   	}
> @@ -269,10 +269,10 @@ static int adau1701_reset(struct snd_soc_codec *codec, unsigned int clkdiv)
>   	adau1701->pll_clkdiv = clkdiv;
>
>   	if (gpio_is_valid(adau1701->gpio_nreset)) {
> -		gpio_set_value(adau1701->gpio_nreset, 0);
> +		gpio_set_value_cansleep(adau1701->gpio_nreset, 0);
>   		/* minimum reset time is 20ns */
>   		udelay(1);
> -		gpio_set_value(adau1701->gpio_nreset, 1);
> +		gpio_set_value_cansleep(adau1701->gpio_nreset, 1);
>   		/* power-up time may be as long as 85ms */
>   		mdelay(85);
>   	}
>
