From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] ASOC: wm8960: Add multiple MCLK frequency
	support
Date: Tue, 12 Dec 2017 13:21:04 +0000
Message-ID: <20171212132104.vnocewljituntwin@localhost.localdomain>
References: <1513079936-163297-1-git-send-email-chen.liu.opensource@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id D548A266E6C
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 14:21:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1513079936-163297-1-git-send-email-chen.liu.opensource@gmail.com>
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
Cc: shengjiu.wang@freescale.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 12, 2017 at 07:58:56PM +0800, Chen.Liu wrote:
> From: "Chen.Liu" <chen.liu.opensource@gmail.com>

Please make sure to CC patches@opensource.cirrus.com on patches
to the Wolfson CODEC drivers.

> 
> Issue:
>  MCLK=24MHZ,SYSCLOCK=12.288MHZ.
>  When the 'wm8960_set_dai_pll' function is called,the driver will

wm8960_set_pll, not wm8960_set_dai_pll?

>  prompted "WM8960 PLL: unsupported N = 4" error message.
>  However,the value of PLLN should be 8 based on the table45(
>  PLL Frequency Examples) of the wm8960 chip manuanl.
> 
> Reason:
>  The intergrated PLL can be used to generate SYSCLK for the wm8960.
>  The pll_factors function in the wm8974.c file is mainly responsible

Assuming that should be wm8960.c?

> -static int pll_factors(unsigned int source, unsigned int target,
> +static int pll_factors(struct snd_soc_codec *codec,
> +		unsigned int source, unsigned int target,
>  		       struct _pll_div *pll_div)
>  {
>  	unsigned long long Kpart;
>  	unsigned int K, Ndiv, Nmod;
> +	int unsupport = 0;
> +	u16 reg;
>  
>  	pr_debug("WM8960 PLL: setting %dHz->%dHz\n", source, target);
>  
>  	/* Scale up target to PLL operating frequency */
>  	target *= 4;
>  
> +retry:
> +	if (unsupport) {
> +		target *= 2;
> +		unsupport += 1;
> +	}
>  	Ndiv = target / source;
>  	if (Ndiv < 6) {
>  		source >>= 1;
> @@ -1056,8 +1064,12 @@ static int pll_factors(unsigned int source, unsigned int target,
>  		pll_div->pre_div = 0;

Feels like it would be nice to wrap this Ndiv calculation in a
loop rather than adding the goto into the below if statement.

>  
>  	if ((Ndiv < 6) || (Ndiv > 12)) {
> -		pr_err("WM8960 PLL: Unsupported N=%d\n", Ndiv);
> -		return -EINVAL;
> +		if (unsupport == 2) {
> +			pr_err("WM8960 PLL: Unsupported N=%d\n", Ndiv);
> +			return -EINVAL;
> +		}
> +		unsupport = 1;
> +		goto retry;
>  	}
>  
>  	pll_div->n = Ndiv;
> @@ -1077,6 +1089,11 @@ static int pll_factors(unsigned int source, unsigned int target,
>  
>  	pll_div->k = K;
>  
> +	if (unsupport) {
> +		reg = snd_soc_read(codec, WM8960_CLOCK1) | WM8960_SYSCLK_DIV_2;
> +		snd_soc_write(codec, WM8960_CLOCK1, reg);

snd_soc_update_bits?

Also there is no code that seems to reset this bit should we
later ask for a configuration that no longer needs it.

Thanks,
Charles
