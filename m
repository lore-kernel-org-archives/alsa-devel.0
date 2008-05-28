From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC Platform Driver for AT32AP7000 (AVR32)
Date: Wed, 28 May 2008 12:18:55 +0100
Message-ID: <20080528111854.GC12414@sirena.org.uk>
References: <200805271732.00086.geoffrey@pager.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F21C9245E9
	for <alsa-devel@alsa-project.org>;
	Wed, 28 May 2008 13:18:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200805271732.00086.geoffrey@pager.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Geoffrey Wossum <geoffrey@pager.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 27, 2008 at 05:32:00PM -0500, Geoffrey Wossum wrote:
> Add ASoC platform driver for AT32AP7000 (AVR32).
> This is basically a port of the at91 ASoC platform code to the

Thanks - I've added this to the ASoC git tree.

The driver looks good but there are quite a few issues that should be
fixed up before submission to mainline but these are coding style issues
rather than anything substantial - most of them can be picked up by
running the script scripts/checkpatch.pl in the kernel source against
your patch (it also has a --file argument which can be used to run it on
regular files rather than patches).

One thing that's missing is the build system updates in sound/soc to
hook this in.

> AVR32.  This is currently against the Linux 2.6.24.3.atmel.3 kernel,
> the latest kernel Atmel has released for the AVR32.

Will this driver work with a current mainline kernel or does it require
other things from the Atmel kernel?

> playpaq_wm8510.c isn't necessarily intended for inclusion into the mainline
> kernel or linux-2.6-asoc repository.  It's provided more as a 
> reference machine driver for an AT32AP7000 system.

It's generally useful to have reference machine drivers - apart from
anything else, it helps from the point of view of doing build tests even
if you don't have the hardware to actually run them.

> +#define ssc_readx(base, reg)            (__raw_readl((base) + (reg)))
> +#define ssc_writex(base, reg, value)    __raw_writel((value), (base) + (reg))

It might be a bit better to provide these as inline 

> +#include <sound/driver.h>

driver.h shouldn't be required with current ALSA versions, though I
can't remember if it's needed on the older kernel you're running with.

> +/*
> + * SSC register values that Atmel left out of <linux/atmel-ssc.h>.  These
> + * are expected to be used with SSC_BF
> + */
> +/* START bit field values */
> +#define SSC_START_CONTINUOUS    0
> +#define SSC_START_TX_RX         1
> +#define SSC_START_LOW_RF        2
> +#define SSC_START_HIGH_RF       3
> +#define SSC_START_FALLING_RF    4
> +#define SSC_START_RISING_RF     5
> +#define SSC_START_LEVEL_RF      6
> +#define SSC_START_EDGE_RF       7
> +#define SSS_START_COMPARE_0     8

I guess ideally these should be merged in there?  Shouldn't be a blocker
for merging this, though.

> +config SND_AT32_SOC_PLAYPAQ
> +        tristate "SoC Audio support for PlayPaq with WM8510"
> +        depends on SND_AT32_SOC
> +        select SND_AT32_SOC_SSC
> +        select SND_SOC_WM8510
> +        help
> +          Say Y or M here if you want to add support for SoC audio
> +          on the LRS PlayPaq.

Should this not also depend on having base support for the system?

> +config SND_AT32_SOC_PLAYPAQ_SLAVE
> +        bool "Run CODEC on PlayPaq in slave mode"
> +        depends on SND_AT32_SOC_PLAYPAQ
> +        default n
> +        help
> +          Say Y if you want to run with the AT32 SSC generating the BCLK
> +          and FRAME signals on the PlayPaq

Probably best to include a note here explaining why you don't want to
select this unless you want to test the AT32 clock generation or
something?

> +static int playpaq_wm8510_startup(
> +    struct snd_pcm_substream *substream)
> +{
> +    return 0;
> +}

You shouldn't need to provide empty functions for things like this.

> +    /* always connected endpoints */
> +    snd_soc_dapm_set_endpoint(codec, "Int Mic", 1);
> +    snd_soc_dapm_set_endpoint(codec, "Ext Spk", 1);

It's also a good idea to explicitly disconnect any unused connections on
the codec, although it's not in any way essential to do so.
