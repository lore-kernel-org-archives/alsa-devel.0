From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8985: rework and fix the clock
	calculation
Date: Thu, 12 May 2016 13:15:58 +0100
Message-ID: <20160512121558.GJ1646@localhost.localdomain>
References: <1463035734-24477-1-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B0D1266E9E
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2016 14:15:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1463035734-24477-1-git-send-email-petr@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, May 12, 2016 at 08:48:54AM +0200, Petr Kulhavy wrote:
> The clock calculation has several issues:
> 1) if PLL is used in master mode the BCLK output runs at double the speed
> 2) de-facto only 44.1kHz and 48kHz sampling rates are supported, other
>    rates like 8kHz, 12kHz, 24kHz fail to find the proper BCLK divider

These certainly seem like things that need fixed :-)

> 3) the wm8985->sysclk variable has a misleading name and is used wrongly
>    in the clock calculation in wm8985_hw_params() which is the root cause
>    for (1)
> 4) wm8985->bclk is used only in wm8985_hw_params() and therefore no
>    need to store it in the wm8985_priv structure
> 
> Therefore the clock calculation is rewritten in more clean and proper way:
> - move wm8985_priv->bclk as a local variable into mw8985_hw_params()
> - new variable wm8985_priv->pllout holds the actual frequency that is input
>   to the MCLKDIV post-divider
> - move wm8985_priv->sysclk as a local variable into mw8985_hw_params()
> - sysclk is now always calculated as 256 * fs
> - the MCLKDIV is looked up as pllout/sysclk
> - fs_ratios[] is replaced by simpler mclk_divs[] lookup table
> 
> With this patch all rates: 8, 11.025, 12, 16, 22.05, 24, 32, 44.1 and 48kHz
> work properly and generate the correct BCLK.
> 
> Signed-off-by: Petr Kulhavy <petr@barix.com>
> ---
>  sound/soc/codecs/wm8985.c | 59 ++++++++++++++++++++++++-----------------------
>  1 file changed, 30 insertions(+), 29 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8985.c b/sound/soc/codecs/wm8985.c
> index 18f2babe1090..628127aa3c96 100644
> --- a/sound/soc/codecs/wm8985.c
> +++ b/sound/soc/codecs/wm8985.c
> @@ -181,22 +181,11 @@ static const int volume_update_regs[] = {
>  struct wm8985_priv {
>  	struct regmap *regmap;
>  	struct regulator_bulk_data supplies[WM8985_NUM_SUPPLIES];
> -	unsigned int sysclk;
> -	unsigned int bclk;
> +	unsigned int pllout;	/* input rate to the MCLKDIV divider */
>  };
>  
> -static const struct {
> -	int div;
> -	int ratio;
> -} fs_ratios[] = {
> -	{ 10, 128 },
> -	{ 15, 192 },
> -	{ 20, 256 },
> -	{ 30, 384 },
> -	{ 40, 512 },
> -	{ 60, 768 },
> -	{ 80, 1024 },
> -	{ 120, 1536 }
> +static const int mclk_divs[] = {
> +	10, 15, 20, 30, 40, 60, 80, 120
>  };
>  
>  static const int srates[] = { 48000, 32000, 24000, 16000, 12000, 8000 };
> @@ -693,15 +682,18 @@ static int wm8985_hw_params(struct snd_pcm_substream *substream,
>  	struct snd_soc_codec *codec;
>  	struct wm8985_priv *wm8985;
>  	u16 blen, srate_idx;
> -	unsigned int tmp;
>  	int srate_best;
> +	unsigned int bclk;	/* bit clock matching the current params */
> +	unsigned int sysclk;	/* the actual sysclk after post division */
>  
>  	codec = dai->codec;
>  	wm8985 = snd_soc_codec_get_drvdata(codec);
>  
> -	wm8985->bclk = snd_soc_params_to_bclk(params);
> -	if ((int)wm8985->bclk < 0)
> -		return wm8985->bclk;
> +	/* always use 256 * fs in order to get best filter quality */
> +	sysclk = 256 * params_rate(params);

Seems quite bold to assume we always want to use 256*fs, I am not
super familiar with the part itself but are there good reasons to
do that? What if someone wanted to use say a direct MCLK and a
lower multiple?

The intent presumably here is that set_sysclk is where we set the
target SYSCLK and set_pll should set the PLL output then here we
probably should work out the correct MCLKDIV to get those.

> +	bclk = snd_soc_params_to_bclk(params);
> +	if ((int)bclk < 0)
> +		return bclk;
>  
>  	switch (params_format(params)) {
>  	case SNDRV_PCM_FORMAT_S16_LE:
> @@ -742,29 +734,28 @@ static int wm8985_hw_params(struct snd_pcm_substream *substream,
>  	snd_soc_update_bits(codec, WM8985_ADDITIONAL_CONTROL,
>  			    WM8985_SR_MASK, srate_idx << WM8985_SR_SHIFT);
>  
> -	dev_dbg(dai->dev, "Target BCLK = %uHz\n", wm8985->bclk);
> -	dev_dbg(dai->dev, "SYSCLK = %uHz\n", wm8985->sysclk);
> +	dev_dbg(dai->dev, "Target BCLK = %uHz\n", bclk);
> +	dev_dbg(dai->dev, "SYSCLK = %uHz\n", sysclk);
>  
> -	for (i = 0; i < ARRAY_SIZE(fs_ratios); ++i) {
> -		if (wm8985->sysclk / params_rate(params)
> -				== fs_ratios[i].ratio)
> +	/* select the appropriate mclk divider */
> +	for (i = 0; i < ARRAY_SIZE(mclk_divs); ++i) {
> +		if (wm8985->pllout / mclk_divs[i] * 10
> +				== sysclk)
>  			break;
>  	}
>  
> -	if (i == ARRAY_SIZE(fs_ratios)) {
> +	if (i == ARRAY_SIZE(mclk_divs)) {
>  		dev_err(dai->dev, "Unable to configure MCLK ratio %u/%u\n",
> -			wm8985->sysclk, params_rate(params));
> +			wm8985->pllout, sysclk);
>  		return -EINVAL;
>  	}
>  
> -	dev_dbg(dai->dev, "MCLK ratio = %dfs\n", fs_ratios[i].ratio);
>  	snd_soc_update_bits(codec, WM8985_CLOCK_GEN_CONTROL,
>  			    WM8985_MCLKDIV_MASK, i << WM8985_MCLKDIV_SHIFT);
>  
>  	/* select the appropriate bclk divider */
> -	tmp = (wm8985->sysclk / fs_ratios[i].div) * 10;
>  	for (i = 0; i < ARRAY_SIZE(bclk_divs); ++i) {
> -		if (wm8985->bclk == tmp / bclk_divs[i])
> +		if (bclk == sysclk / bclk_divs[i])
>  			break;
>  	}
>  
> @@ -786,6 +777,10 @@ struct pll_div {
>  };
>  
>  #define FIXED_PLL_SIZE ((1ULL << 24) * 10)
> +/*
> + * source = MCLK input of the chip
> + * target = the f2 coming out of the PLL before /4 divider
> + */
>  static int pll_factors(struct pll_div *pll_div, unsigned int target,
>  		       unsigned int source)
>  {
> @@ -872,17 +867,23 @@ static int wm8985_set_sysclk(struct snd_soc_dai *dai,
>  				    WM8985_CLKSEL_MASK, 0);
>  		snd_soc_update_bits(codec, WM8985_POWER_MANAGEMENT_1,
>  				    WM8985_PLLEN_MASK, 0);
> +		wm8985->pllout = freq;
>  		break;
>  	case WM8985_CLKSRC_PLL:
>  		snd_soc_update_bits(codec, WM8985_CLOCK_GEN_CONTROL,
>  				    WM8985_CLKSEL_MASK, WM8985_CLKSEL);
> +		/*
> +		 * in order to run the PLL within the recommended 90MHz
> +		 * operating range the wm8985_set_pll() configures the PLL
> +		 * to output double the required frequency
> +		 */
> +		wm8985->pllout = 2 * freq;

Were does this *2 come from? Is this the PLLPRESCALE?

>  		break;
>  	default:
>  		dev_err(dai->dev, "Unknown clock source %d\n", clk_id);
>  		return -EINVAL;
>  	}
>  
> -	wm8985->sysclk = freq;
>  	return 0;
>  }
>  
> -- 
> 1.9.1

Thanks,
Charles
