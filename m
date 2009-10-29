From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add support for CLKOUT to wm8731
	codec	driver
Date: Thu, 29 Oct 2009 16:05:35 +0000
Message-ID: <20091029160534.GE15559@sirena.org.uk>
References: <1256829202-2508-1-git-send-email-bgat@billgatliff.com>
	<1256829202-2508-2-git-send-email-bgat@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DAD99103816
	for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2009 17:05:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1256829202-2508-2-git-send-email-bgat@billgatliff.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 29, 2009 at 10:13:22AM -0500, Bill Gatliff wrote:
> 
> Signed-off-by: Bill Gatliff <bgat@billgatliff.com>

Something seems to have got mixed up with the submission here - the
changelog and patch appear to have been detached from each other and
there are quite a few other issues below.  I suspect finger trouble
somewhere along the line.  Please also remember to CC maintainers on
patches to help avoid them getting lost in the mailing list.

> +#define PREFIX "wm8731: "
> +

Use dev_printk() functions, don't introduce things like this.

>   * There is no point in caching the reset register
>   */
>  static const u16 wm8731_reg[WM8731_CACHEREGNUM] = {
> -    0x0097, 0x0097, 0x0079, 0x0079,
> -    0x000a, 0x0008, 0x009f, 0x000a,
> -    0x0000, 0x0000
> +	0x0097, 0x0097, 0x0079, 0x0079,
> +	0x000a, 0x0008, 0x009f, 0x000a,
> +	0x0000, 0x0000

Almost all of the patch actually appears to consist of a large number of
unrelated formatting and stylistic changes like this which aren't
mentioned in your changelog and making it hard for me to review.  Please
rework this as a series of patches, each making a single change.

>  static const struct snd_soc_dapm_route intercon[] = {
> @@ -265,8 +271,6 @@ static int wm8731_hw_params(struct snd_pcm_substream *substream,
>  	u16 srate = (coeff_div[i].sr << 2) |
>  		(coeff_div[i].bosr << 1) | coeff_div[i].usb;
>  
> -	wm8731_write(codec, WM8731_SRATE, srate);
> -
>  	/* bit size */
>  	switch (params_format(params)) {
>  	case SNDRV_PCM_FORMAT_S16_LE:

This is a separate functional change - it needs to be in a patch by
itself.

> +	if (dir == SND_SOC_CLOCK_OUT) {
> +		dev_dbg(codec->dev, PREFIX "%s turning on CLKOUT\n", __func__);
> +		reg = wm8731_read_reg_cache(codec, WM8731_PWR);
> +		reg &= ~(1 << WM8731_PWR_CLKOUTPD);
> +		wm8731_write(codec, WM8731_PWR, reg);
> +	}
> +	else {

} else { please - I'm surprised checkpatch dosn't warn.

> +		dev_dbg(codec->dev, PREFIX "%s turning off CLKOUT\n", __func__);
> +		reg = wm8731_read_reg_cache(codec, WM8731_PWR);
> +		reg |= (1 << WM8731_PWR_CLKOUTPD);
> +		wm8731_write(codec, WM8731_PWR, reg);
> +	}

It'd be better define a new clock for the CLKOUT pin rather than munging
it in with the master clock.  MCLK is always an input on the WM8731, the
CLKOUT output is a separate pin and so including it in MCLK is likely to
make things confusing and could well introduce errors.

> -#warning "TODO: figure out how to turn on/off CLKOUT properly"
> -		wm8731_write(codec, WM8731_PWR, 0);
> -		break;
>  	case SND_SOC_BIAS_PREPARE:
> -#if 1
> -#warning "TODO: figure out how to turn on/off CLKOUT properly"
> -	  /* probably has to do with SND_SOC_CLOCK_OUT
> -	     and whether we're master or slave ... */
> -		wm8731_write(codec, WM8731_PWR, 0);
> -#endif
> -		break;

This patch isn't against mainline...

> +		/* turn off CLKOUT in STANDBY */
> +		if (level == SND_SOC_BIAS_STANDBY)
> +			reg |= (1 << WM8731_PWR_CLKOUTPD);
> +
> +		wm8731_write(codec, WM8731_PWR, reg);

If you're putting CLKOUT control in the hands of machine drivers give
them complete control over it, mixing management between the machine
drivers and the CODEC driver is likely to cause confusion.

> -#define WM8731_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
> -		SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |\
> -		SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
> -		SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
> -		SNDRV_PCM_RATE_96000)
> +#define WM8731_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |	\
> +		      SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |	\
> +		      SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |	\
> +		      SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |	\
> +		      SNDRV_PCM_RATE_96000)

SDNDRV_PCM_RATE_8000_96000.
