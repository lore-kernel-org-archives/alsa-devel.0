From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ALSA:AT91SAM9G20: Add support(DAI) for wolfson8731
Date: Wed, 17 Sep 2008 12:05:31 +0100
Message-ID: <20080917110530.GA7679@sirena.org.uk>
References: <48D0D30D.7070807@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B48824594
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Sep 2008 13:05:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48D0D30D.7070807@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: alsa-devel@alsa-project.org, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 17, 2008 at 11:51:09AM +0200, Sedji Gaouaou wrote:

> So here is a patch to add support for the wolfson 8731 on the at91sam9g20 evaluation board.
> Any comments will be welcomed!!

Thanks!  Overall in terms of code quality this patch looks very good -
see below for some comments but they're all very minor.

The only major issue I see with the patch is a documentation one: it's
not clear to me reading the code how the atmel_ssc DAI driver relates to
the existing at91_ssc driver.  It may be that this is something that's
obvious to someone familiar with the at91 hardware but just looking at
the code it's not clear to me what the difference is between the two and
when each should be used.  

Looking at the code they appear to be similar to the point where they
should be the same driver but it's entirely possible that I'm missing
something here.  I've CCed in Frank Mandarino who did the existing AT91
support.  If they should be separate drivers then some comments should
be added in the driver and the Kconfig help text explaning the
situation.

Please include a changelog entry and a Signed-off-by - see
Documentation/SubmittingPatches for details of how things should be
formatted.  It's also helpful to check your patches with
scripts/checkpatch.pl which will pick up things like that and also
coding style issues (there's a small number of them in your patch).

> --- a/sound/soc/at91/Kconfig
> +++ b/sound/soc/at91/Kconfig
> @@ -7,7 +7,15 @@ config SND_AT91_SOC
>  	  to select the audio interfaces to support below.
>  
>  config SND_AT91_SOC_SSC
> -	tristate
> +	tristate "at91 soc ssc"

If this is intended to be user visible (rather than selected by the
machine drivers) it'd be nice to provide some help text for it - it's
not terribly clear at the minute.

> +config SND_ATMEL_SOC_SSC
> +	tristate "ATMEL SoC ssc dai"
> +	depends on ATMEL_SSC
> +	help
> +	  Say Y or M if you want to add support for codecs the
> +	  ATMEL SSC interface(interface between at91sam9g20 and
> +	  WM8731 for instance).

Just a non-native English thing but how about:

	Say Y or M to enable support for codecs attached to the ATMEL
	SSC interface.  You will also need to select the individual
	machine drivers to support below.

> +snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o
> +

Very minor but please don't add these extra blank lines.

> diff --git a/sound/soc/at91/atmel_ssc_dai.c b/sound/soc/at91/atmel_ssc_dai.c
> new file mode 100644
> index 0000000..a3888c0
> --- /dev/null
> +++ b/sound/soc/at91/atmel_ssc_dai.c
> @@ -0,0 +1,715 @@
> +/*
> + * atmel_ssc_dai.c  --  ALSA SoC ATMEL SSC Audio Layer Platform driver
> + *
> + * Copyright (C) 2005 SAN People
> + * Copyright (C) 2008 Atmel
> + *
> + * Author: Sedji Gaouaou <sedji.gaouaou@atmel.com>
> + *         ATMEL CORP.
> + *
> + * Based on at91-ssc.c by
> + * Frank Mandarino <fmandarino@endrelia.com>
> + * Based on pxa2xx Platform drivers by
> + * Liam Girdwood <liam.girdwood@wolfsonmicro.com>

> +#if 0
> +#define	DBG(x...)	printk(KERN_DEBUG "atmel_ssc_dai:" x)
> +#else
> +#define	DBG(x...)
> +#endif

Please use the standard pr_dbg() (or, if possible, dev_dbg()) for this.
Quite a lot of the existing drivers do this but they're gradually being
converted away and it'd be good to avoid adding any more.

> +/*
> + * Record SSC clock dividers for use in hw_params().
> + */
> +static int atmel_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
> +	int div_id, int div)
> +{
> +	struct atmel_ssc_info *ssc_p = &ssc_info[cpu_dai->id];
> +
> +	switch (div_id) {
> +	case AT91SSC_CMR_DIV:
> +		/*
> +		 * The same master clock divider is used for both
> +		 * transmit and receive, so if a value has already
> +		 * been set, it must match this value.
> +		 */
> +		if (ssc_p->cmr_div == 0)
> +			ssc_p->cmr_div = div;
> +		else
> +			if (div != ssc_p->cmr_div)
> +				return -EBUSY;
> +		break;

What happens if the user wants to change the master clock divider at
runtime - for example, when changing sample rates?

> +		start_event = channels == 1
> +				? 4
> +				: 7;

This would be much clearer if it were expanded into multiple statements.

> +#ifdef CONFIG_PM
> +#define atmel_ssc_suspend	NULL
> +#define atmel_ssc_resume	NULL
> +#else
> +#define atmel_ssc_suspend	NULL
> +#define atmel_ssc_resume	NULL
> +#endif

These may as well be removed - if someone implements suspend/resume
support they can add them then then.

> +#if 0
> +#define	DBG(x...)	printk(KERN_INFO "at91sam9g20ek_wm8731: " x)
> +#else
> +#define	DBG(x...)
> +#endif

Again, please replace with the standard pr_dbg() macro.

> +static struct wm8731_setup_data at91sam9g20ek_wm8731_setup = {
> +	.i2c_address = 0x1b,
> +};

Is the codec on I2C bus zero?  If not then the i2c_bus field should also
be initialised here.  This was added as part of the recent patches
converting the codec drivers to the new I2C registration interface - see
the topic/asoc branch of Takashi's tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

for the latest code queued for merge in 2.6.28.

> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 1db04a2..1595b04 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -12,7 +12,7 @@ config SND_SOC_WM8510
>  	tristate
>  
>  config SND_SOC_WM8731
> -	tristate
> +	tristate "WM8731"

This shouldn't be a user-visible config option - codec drivers are only
useful in conjunction with a machine driver describing how they are
connected to the system so there's no need to expose the configuration
to users (there is an all codecs config option which can be used for
test builds).
