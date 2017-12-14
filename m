From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] ASOC: wm8960: Add multiple MCLK
	frequency support
Date: Thu, 14 Dec 2017 11:56:48 +0000
Message-ID: <20171214115648.qidtgzihdoikxvhe@localhost.localdomain>
References: <1513168650-102028-1-git-send-email-chen.liu.opensource@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 55C7326707A
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 13:06:36 +0100 (CET)
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
> 
> Issue:
>  MCLK=24MHZ,SYSCLOCK=12.288MHZ.
>  When the 'wm8960_set_pll' function is called,the driver will
>  prompted "WM8960 PLL: unsupported N = 4" error message.
>  However,the value of PLLN should be 8 based on the table45(
>  PLL Frequency Examples) of the wm8960 chip manuanl.
> 
> Reason:
>  The intergrated PLL can be used to generate SYSCLK for the wm8960.
>  The pll_factors function in the wm8960.c file is mainly responsible
>  for setting the divider factor of the PLL divider with reference to
>  MCLK clock frequency to obtain the required SYSCLK clock frequency.
>  The configure diagram for this function can be seen below.
> 
>  MCLK-->[f/2]-->[R=f2/f1]-->[f/4]-->[f/N](1)-->SYSCLOCK
> 
>  The configuration of the PLL divider in above diagram is applicable to
>  MCLK clock frequency is less than or equal to 14.4MHZ.
>  examples:
>  (1)MCLK=12MHz, required clock = 12.288MHz.
>  R should be chosen to ensure 5 < PLLN < 13. There is a fixed divide by
>  4 in the PLL and a selectable divide by N after the PLL which should
>  be set to divide by 1 to meet this requirement.
>  Enabling the divide by 1 sets the required f2 = 4 x 1 x 12.288MHz =
>  49.152MHz.
> 
>  	R = 49.152 / (12 / 2) = 8.192
>  	PLLN = int R = 8
> 
>  (2)MCLK=24MHz, required clock = 12.288MHz.
>  Enabling the divide by 1 sets the required f2 = 4 x 1 x 12.288MHZ =
>  49.152MHZ.
> 
>  	R = 49.152 / (24 / 2) = 4.096
>  	PLLN = int R = 4
> 
>  And if the [f/N] reg is set to 2,then the required f2 = 4x2x12.288MHZ
>  = 98.304MHZ.
> 
>  	R = 98.304 / (24 / 2) = 8.192
>  	PLLN = int R = 8
> 
>  Because the [f/N] reg is fixed divide by 1,that's why driver prompted
>  error message.
> 
> Solution:
>  The purpose of this patch is when the conditions(5 < PLLN < 13) is
>  false, set the register[f/N] to be 2, and the recalculate the divide
>  factor of the PLL divider.
> 
>  MCLK-->[f/2]-->[R=f2/f1]-->[f/4]-->[f/N](2)-->SYSCLOCK
> 
> Signed-off-by: Chen.Liu <chen.liu.opensource@gmail.com>
> ---

+ Daniel Baluta, as he has done quite a bit of work on the
clocking in this driver and I would like to at least hear this
doesn't cause issues in his systems.

> Changes in v2:
> - The calculation of the Ndiv is encapsulated in a loop.
> - Use 'unsupported' instead of 'unsupport'.
> ---
>  sound/soc/codecs/wm8960.c | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
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
> +

Looking at this a bit more I do have some reservations. Firstly
this divider can be set through wm8960_set_dai_clkdiv, and
secondly it is also set at the bottom of
wm8960_configure_clocking. Adding a third path that also controls
this bit is starting to seem very complex. Do you have any
thoughts on how this interacts with the other two paths? And
should it perhaps take this field into account but not be
controlling it directly?

Thanks,
Charles

>  	pr_debug("WM8960 PLL: N=%x K=%x pre_div=%d\n",
>  		 pll_div->n, pll_div->k, pll_div->pre_div);
>  
> @@ -1091,7 +1105,7 @@ static int wm8960_set_pll(struct snd_soc_codec *codec,
>  	int ret;
>  
>  	if (freq_in && freq_out) {
> -		ret = pll_factors(freq_in, freq_out, &pll_div);
> +		ret = pll_factors(codec, freq_in, freq_out, &pll_div);
>  		if (ret != 0)
>  			return ret;
>  	}
> -- 
> 1.8.3.1
