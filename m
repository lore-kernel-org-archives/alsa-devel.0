From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH] ASoC: wm8741: Allow master
	clock	switching
Date: Fri, 5 Jun 2015 16:22:19 +0100
Message-ID: <20150605152219.GA32730@opensource.wolfsonmicro.com>
References: <1433505944-3961-1-git-send-email-ce3a@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9D441266877
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 17:22:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1433505944-3961-1-git-send-email-ce3a@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <ce3a@gmx.de>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, broonie@kernel.org, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 05, 2015 at 02:05:44PM +0200, Sergej Sawazki wrote:
> The set of supported sample rates depends on the master clock supplied
> to the codec. Allow the machine driver to set the required master clock
> in hw_params().
> 
> Signed-off-by: Sergej Sawazki <ce3a@gmx.de>
> ---
> 
> This patch has been tested on a board with two master clocks, 22.5792MHz
> (for 44.1kHz, 88.2kHz, ...) and 24.576MHz (for 48kHz, 96kHz, ...).
> 
>  sound/soc/codecs/wm8741.c | 63 +++++++++++++----------------------------------
>  1 file changed, 17 insertions(+), 46 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
> index 09ff01f..47c5577 100644
> --- a/sound/soc/codecs/wm8741.c
> +++ b/sound/soc/codecs/wm8741.c
> @@ -125,18 +125,6 @@ static const struct snd_soc_dapm_route wm8741_dapm_routes[] = {
>  	{ "VOUTRN", NULL, "DACR" },
>  };
>  
> -static struct {
> -	int value;
> -	int ratio;
> -} lrclk_ratios[WM8741_NUM_RATES] = {
> -	{ 1, 128 },
> -	{ 2, 192 },
> -	{ 3, 256 },
> -	{ 4, 384 },
> -	{ 5, 512 },
> -	{ 6, 768 },
> -};
> -
>  static const unsigned int rates_11289[] = {
>  	44100, 88200,
>  };
> @@ -209,29 +197,6 @@ static const struct snd_pcm_hw_constraint_list constraints_36864 = {
>  	.list	= rates_36864,
>  };
>  
> -
> -static int wm8741_startup(struct snd_pcm_substream *substream,
> -			  struct snd_soc_dai *dai)
> -{
> -	struct snd_soc_codec *codec = dai->codec;
> -	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
> -
> -	/* The set of sample rates that can be supported depends on the
> -	 * MCLK supplied to the CODEC - enforce this.
> -	 */
> -	if (!wm8741->sysclk) {
> -		dev_err(codec->dev,
> -			"No MCLK configured, call set_sysclk() on init\n");
> -		return -EINVAL;
> -	}
> -
> -	snd_pcm_hw_constraint_list(substream->runtime, 0,
> -				   SNDRV_PCM_HW_PARAM_RATE,
> -				   wm8741->sysclk_constraints);
> -
> -	return 0;
> -}

I think rather than removing the constraints entirely here,
perhaps just don't set any constraints if there is no SYSCLK yet.
That way we get the benefits of the constraints for single clock
systems (such as user-space being able to arrange appropriate
software resampling) but those like yours can configure the clock
later.

> -
>  static int wm8741_hw_params(struct snd_pcm_substream *substream,
>  			    struct snd_pcm_hw_params *params,
>  			    struct snd_soc_dai *dai)
> @@ -241,17 +206,24 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
>  	u16 iface = snd_soc_read(codec, WM8741_FORMAT_CONTROL) & 0x1FC;
>  	int i;
>  
> -	/* Find a supported LRCLK ratio */
> -	for (i = 0; i < ARRAY_SIZE(lrclk_ratios); i++) {
> -		if (wm8741->sysclk / params_rate(params) ==
> -		    lrclk_ratios[i].ratio)
> +	/* The set of sample rates that can be supported depends on the
> +	 * MCLK supplied to the CODEC - enforce this.
> +	 */
> +	if (!wm8741->sysclk) {
> +		dev_err(codec->dev,
> +			"No MCLK configured, call set_sysclk() on hw_params\n");
> +		return -EINVAL;
> +	}

Then you can keep this error check here and fail if we reach
hw_params and still don't have a SYSCLK. You will probably need
to provide a way to clear the SYSCLK though set_dai_sysclk as
well.

Thanks,
Charles

> +
> +	/* Find a supported LRCLK rate */
> +	for (i = 0; i < wm8741->sysclk_constraints->count; i++) {
> +		if (wm8741->sysclk_constraints->list[i] == params_rate(params))
>  			break;
>  	}
>  
> -	/* Should never happen, should be handled by constraints */
> -	if (i == ARRAY_SIZE(lrclk_ratios)) {
> -		dev_err(codec->dev, "MCLK/fs ratio %d unsupported\n",
> -			wm8741->sysclk / params_rate(params));
> +	if (i == wm8741->sysclk_constraints->count) {
> +		dev_err(codec->dev, "LRCLK %d unsupported with MCLK %d\n",
> +			params_rate(params), wm8741->sysclk);
>  		return -EINVAL;
>  	}
>  
> @@ -274,8 +246,8 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
>  		return -EINVAL;
>  	}
>  
> -	dev_dbg(codec->dev, "wm8741_hw_params:    bit size param = %d",
> -		params_width(params));
> +	dev_dbg(codec->dev, "wm8741_hw_params:    bit size param = %d, rate param = %d",
> +		params_width(params), params_rate(params));
>  
>  	snd_soc_write(codec, WM8741_FORMAT_CONTROL, iface);
>  	return 0;
> @@ -403,7 +375,6 @@ static int wm8741_set_dai_fmt(struct snd_soc_dai *codec_dai,
>  			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
>  
>  static const struct snd_soc_dai_ops wm8741_dai_ops = {
> -	.startup	= wm8741_startup,
>  	.hw_params	= wm8741_hw_params,
>  	.set_sysclk	= wm8741_set_dai_sysclk,
>  	.set_fmt	= wm8741_set_dai_fmt,
> -- 
> 1.9.1
> 
