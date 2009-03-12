From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH 3/3][RFC] ASoC: pxa-ssp: Don't
	use	SSCR0_SerClkDiv and SSCR0_SCR
Date: Thu, 12 Mar 2009 01:46:39 +0100
Message-ID: <20090312004639.GB7462@buzzloop.caiaq.de>
References: <1236795420-12175-1-git-send-email-philipp.zabel@gmail.com>
	<1236795420-12175-3-git-send-email-philipp.zabel@gmail.com>
	<20090311184416.GA29865@buzzloop.caiaq.de>
	<74d0deb30903111410v5a601709jf779c0d2e64e7de7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 406B61038A2
	for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2009 01:46:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74d0deb30903111410v5a601709jf779c0d2e64e7de7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 11, 2009 at 10:10:27PM +0100, pHilipp Zabel wrote:
> > Then we need something like ssp_get_scr() as well to cover my special
> > case which uses SSCR0_SCR and SSCR0_SerClkDiv() again as you proposed ;)
> 
> Aren't I clever... How about something like this:

Jep, look good to me.

(Just for the reference - this one needs to be applied on top of my last
 'network vs psp mode' patch, otherwise the second hunk won't apply).

Thanks,
Daniel


> ---
>  sound/soc/pxa/pxa-ssp.c |   30 ++++++++++++++++++++++++++----
>  1 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
> index 3cde686..245063b 100644
> --- a/sound/soc/pxa/pxa-ssp.c
> +++ b/sound/soc/pxa/pxa-ssp.c
> @@ -284,9 +284,30 @@ static int pxa_ssp_resume(struct snd_soc_dai *cpu_dai)
>  static void ssp_set_scr(struct ssp_dev *dev, u32 div)
>  {
>  	struct ssp_device *ssp = dev->ssp;
> -	u32 sscr0 = ssp_read_reg(dev->ssp, SSCR0) & ~SSCR0_SCR;
> +	u32 sscr0 = ssp_read_reg(ssp, SSCR0);
> +
> +	if (cpu_is_pxa25x() && ssp->type == PXA25x_SSP) {
> +		sscr0 &= ~0x0000ff00;
> +		sscr0 |= ((div - 2)/2) << 8;
> +	} else {
> +		sscr0 &= ~0x000fff00;
> +		sscr0 |= (div - 1) << 8;
> +	}
> +	ssp_write_reg(ssp, SSCR0, sscr0);
> +}
> 
> -	ssp_write_reg(ssp, SSCR0, (sscr0 | SSCR0_SerClkDiv(div)));
> +/**
> + * ssp_get_clkdiv - get SSP clock divider
> + */
> +static u32 ssp_get_scr(struct ssp_dev *dev)
> +{
> +	struct ssp_device *ssp = dev->ssp;
> +	u32 sscr0 = ssp_read_reg(ssp, SSCR0);
> +
> +	if (cpu_is_pxa25x() && ssp->type == PXA25x_SSP)
> +		return ((sscr0 >> 8) & 0xff) * 2 + 2;
> +	else
> +		return ((sscr0 >> 8) & 0xfff) + 1;
>  }
> 
>  /*
> @@ -668,8 +689,7 @@ static int pxa_ssp_hw_params(struct
> snd_pcm_substream *substream,
>  	case SND_SOC_DAIFMT_I2S:
>  	       sspsp = ssp_read_reg(ssp, SSPSP);
> 
> -		if (((sscr0 & SSCR0_SCR) == SSCR0_SerClkDiv(4)) &&
> -		     (width == 16)) {
> +		if (ssp_get_scr(ssp) == 4) && (width == 16)) {
>  			/* This is a special case where the bitclk is 64fs
>  			* and we're not dealing with 2*32 bits of audio
>  			* samples.
> -- 
> 1.6.2
