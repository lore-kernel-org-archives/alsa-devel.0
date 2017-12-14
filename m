From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] ASOC: wm8960: Add multiple MCLK
	frequency support
Date: Thu, 14 Dec 2017 16:19:54 +0000
Message-ID: <20171214161954.wfik3ygadwii3zhm@localhost.localdomain>
References: <1513168650-102028-1-git-send-email-chen.liu.opensource@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F25726732A
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 17:20:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1513168650-102028-1-git-send-email-chen.liu.opensource@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Chen.Liu" <chen.liu.opensource@gmail.com>
Cc: shengjiu.wang@freescale.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, daniel.baluta@nxp.com
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 13, 2017 at 08:37:30PM +0800, Chen.Liu wrote:
> From: "Chen.Liu" <chen.liu.opensource@gmail.com>
> diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
> index 997c446..83dd746 100644
> --- a/sound/soc/codecs/wm8960.c
> +++ b/sound/soc/codecs/wm8960.c
> @@ -1036,28 +1036,38 @@ static bool is_pll_freq_available(unsigned int source, unsigned int target)
>   * to allow rounding later */
>  #define FIXED_PLL_SIZE ((1 << 24) * 10)
>  
> -static int pll_factors(unsigned int source, unsigned int target,
> +static int pll_factors(struct snd_soc_codec *codec,
> +		unsigned int source, unsigned int target,
>  		       struct _pll_div *pll_div)
>  {
>  	unsigned long long Kpart;
>  	unsigned int K, Ndiv, Nmod;
> +	int unsupported = 0;
>  
>  	pr_debug("WM8960 PLL: setting %dHz->%dHz\n", source, target);
>  
>  	/* Scale up target to PLL operating frequency */
>  	target *= 4;
>  
> -	Ndiv = target / source;
> -	if (Ndiv < 6) {
> -		source >>= 1;
> -		pll_div->pre_div = 1;
> +	while (1) {
>  		Ndiv = target / source;
> -	} else
> -		pll_div->pre_div = 0;
> +		if (Ndiv < 6) {
> +			source >>= 1;
> +			pll_div->pre_div = 1;
> +			Ndiv = target / source;
> +		} else
> +			pll_div->pre_div = 0;
> +
> +		if ((Ndiv < 6) || (Ndiv > 12)) {
> +			if (unsupported == 1) {
> +				pr_err("WM8960 PLL: Unsupported N=%d\n", Ndiv);
> +				return -EINVAL;
> +			}
> +		} else
> +			break;
>  
> -	if ((Ndiv < 6) || (Ndiv > 12)) {
> -		pr_err("WM8960 PLL: Unsupported N=%d\n", Ndiv);
> -		return -EINVAL;
> +		target *= 2;
> +		unsupported += 1;
>  	}
>  
>  	pll_div->n = Ndiv;
> @@ -1077,6 +1087,10 @@ static int pll_factors(unsigned int source, unsigned int target,
>  
>  	pll_div->k = K;
>  
> +	if (unsupported)
> +		snd_soc_update_bits(codec, WM8960_CLOCK1, 0x6,
> +				WM8960_SYSCLK_DIV_2);

OK so looking over this some more with Mark's comments in mind
the thing that troubles me is this. Currently there are two ways
you can configure the clocking manually or automatically.

The manual way using the set_dai_pll, set_dai_clkdiv and
set_dai_sysclk calls.

Automatically by calling set_dai_sysclk and set_dai_pll with
WM8960_SYSCLK_AUTO and the driver will work it out for you. This
option already supports setting the SYSCLK_DIV.

I guess my first question would be can you get the result you
desire by just using the automatic option?

If not, it seems like what we are trying to do here is move the
set_dai_clkdiv for SYSCLK_DIV to be automatic in both cases. The
problem is that I suspect this handling interfers somewhat with the
handling of these bits that is done in wm8960_configure_clocking
through wm8960_configure_pll when we are doing things
automatically. In which case I think you need to look at how to
align these two clocking methods.

Thanks,
Charles
