From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv3 5/9] Using the constraint based
	on	wm8971_set_dai_sysclk
Date: Tue, 2 Sep 2014 10:28:10 +0100
Message-ID: <20140902092810.GC12043@opensource.wolfsonmicro.com>
References: <1409628470-13059-1-git-send-email-xavier.hsu@linaro.org>
 <1409628470-13059-5-git-send-email-xavier.hsu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 91D3826523B
 for <alsa-devel@alsa-project.org>; Tue,  2 Sep 2014 11:35:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1409628470-13059-5-git-send-email-xavier.hsu@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xavier Hsu <xavier.hsu@linaro.org>
Cc: Andy Green <andy.green@linaro.org>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 02, 2014 at 11:27:46AM +0800, Xavier Hsu wrote:
> This patch improves WM8971.
> We use the constraint based on the function of
> wm8971_set_dai_sysclk().
> 
> Any comments about improving the patch are welcome.
> Thanks.

Comments like this are probably best put after the --- as they
don't need to appear in the change log.

> 
> Signed-off-by: Xavier Hsu <xavier.hsu@linaro.org>
> Signed-off-by: Andy Green <andy.green@linaro.org>
> ---
>  sound/soc/codecs/wm8971.c |   77 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 71 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8971.c b/sound/soc/codecs/wm8971.c
> index 64ed226..20cfdd3 100755
> --- a/sound/soc/codecs/wm8971.c
> +++ b/sound/soc/codecs/wm8971.c
> @@ -41,6 +41,7 @@ static struct workqueue_struct *wm8971_workq;
>  /* codec private data */
>  struct wm8971_priv {
>  	unsigned int sysclk;
> +	struct snd_pcm_hw_constraint_list *sysclk_constraints;
>  	int playback_fs;
>  	bool deemph;
>  };
> @@ -528,6 +529,53 @@ static int get_coeff(int mclk, int rate)
>  	return -EINVAL;
>  }
>  
> +/* The set of rates we can generate from the above for each SYSCLK */
> +static const unsigned int rates_12288[] = {
> +	8000, 12000, 16000, 24000, 32000, 48000, 96000
> +};
> +
> +static struct snd_pcm_hw_constraint_list constraints_12288 = {
> +	.count  = ARRAY_SIZE(rates_12288),
> +	.list   = rates_12288,
> +};
> +
> +static const unsigned int rates_112896[] = {
> +	8000, 11025, 22050, 44100, 88200
> +};
> +
> +static struct snd_pcm_hw_constraint_list constraints_112896 = {
> +	.count  = ARRAY_SIZE(rates_112896),
> +	.list   = rates_112896,
> +};
> +
> +static const unsigned int rates_18432[] = {
> +	8000, 12000, 16000, 24000, 32000, 48000, 96000
> +};
> +
> +static struct snd_pcm_hw_constraint_list constraints_18432 = {
> +	.count  = ARRAY_SIZE(rates_18432),
> +	.list   = rates_18432,
> +};

This one is identical to the 12288 array, why not combine them
and call them the 48k array?

> +
> +static const unsigned int rates_169344[] = {
> +	8000, 11025, 22050, 44100, 88200
> +};

This one is identical to the 112896 array, why not combine them
and call them the 44k1 array?

> +
> +static struct snd_pcm_hw_constraint_list constraints_169344 = {
> +	.count  = ARRAY_SIZE(rates_169344),
> +	.list   = rates_169344,
> +};
> +
> +static const unsigned int rates_12[] = {
> +	8000, 11025, 12000, 16000, 22050, 2400, 32000, 41100, 48000,

Typo 0 missing                            ^^^^

> +	48000, 88235, 96000,
> +};
> +
> +static struct snd_pcm_hw_constraint_list constraints_12 = {
> +	.count  = ARRAY_SIZE(rates_12),
> +	.list   = rates_12,
> +};
> +
>  static int wm8971_set_dai_sysclk(struct snd_soc_dai *codec_dai,
>  				 int clk_id, unsigned int freq, int dir)
>  {
> @@ -535,15 +583,32 @@ static int wm8971_set_dai_sysclk(struct snd_soc_dai *codec_dai,
>  	struct wm8971_priv *wm8971 = snd_soc_codec_get_drvdata(codec);
>  
>  	switch (freq) {
> -	case 11289600:
> -	case 12000000:
>  	case 12288000:
> -	case 16934400:
> +	case 24576000:
> +		wm8971->sysclk_constraints = &constraints_12288;
> +		break;
> +	case 11289600:
> +	case 22579200:
> +		wm8971->sysclk_constraints = &constraints_112896;
> +		break;
>  	case 18432000:
> -		wm8971->sysclk = freq;
> -		return 0;
> +		wm8971->sysclk_constraints = &constraints_18432;
> +		break;
> +	case 16934400:
> +	case 33868800:
> +		wm8971->sysclk_constraints = &constraints_169344;
> +		break;
> +	case 12000000:
> +	case 24000000:
> +		wm8971->sysclk_constraints = &constraints_12;
> +		break;
> +	default:
> +		return -EINVAL;
>  	}
> -	return -EINVAL;

You pick out the constraints here but you never actually set them
with snd_pcm_hw_constraint_list?

> +
> +	wm8971->sysclk = freq;
> +
> +	return 0;
>  }
>  
>  static int wm8971_set_dai_fmt(struct snd_soc_dai *codec_dai,
> -- 

Thanks,
Charles
