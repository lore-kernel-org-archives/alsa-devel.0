From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH v2 4/6] ARM: DaVinci: ASoC: Add dummy	codec
	support
Date: Thu, 16 Apr 2009 13:46:51 +0100
Message-ID: <20090416124651.GO16318@sirena.org.uk>
References: <1239921894-26973-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 238A524342
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 14:46:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1239921894-26973-1-git-send-email-naresh@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Naresh Medisetty <naresh@ti.com>
Cc: alsa-devel@alsa-project.org, Steve Chen <schen@mvista.com>, davinci-linux-open-source@linux.davincidsp.com, Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 16, 2009 at 06:44:54PM -0400, Naresh Medisetty wrote:

>  	select SND_SOC_TLV320AIC23 if I2C
>  	select SND_SOC_TLV320AIC26 if SPI_MASTER
>  	select SND_SOC_TLV320AIC3X if I2C
> +	select SND_SOC_SPDIF
>  	select SND_SOC_TWL4030 if TWL4030_CORE
>  	select SND_SOC_UDA134X
>  	select SND_SOC_UDA1380 if I2C

This should be alphabetically sorted....

> @@ -93,6 +94,8 @@ config SND_SOC_SSM2602
>  
>  config SND_SOC_TLV320AIC23
>  	tristate
> +config SND_SOC_SPDIF
> +        tristate

...as should this.  The same issue applies in the Makefile.  You're also
missing a blank line and your indentation seems wrong.

> --- /dev/null
> +++ b/sound/soc/codecs/spdif_transciever.c
> @@ -0,0 +1,69 @@
> +/*
> + * ALSA SoC DaVinci DIT driver
> + *
> + *  TI DaVinci audio controller can operate in DIT (SPDI/F) where
> + *  no codec is needed.  This file provides stub codec that can be used
> + *  in these configurations.

These comments need refreshing.

> +static struct platform_driver davinci_dit_driver = {
> +	.probe		= davinci_dit_probe,
> +	.remove		= davinci_dit_remove,
> +	.driver		= {
> +		.name	= "davinci-dit",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +

Better to s/davinci/spdif/ for the driver name everywhere - it'd look
odd to be registering a DaVinci specific thing on another platform.

> @@ -26,6 +26,7 @@ config  SND_DM6467_SOC_EVM
>          depends on SND_DAVINCI_SOC && MACH_DAVINCI_DM6467_EVM
>          select SND_DAVINCI_SOC_I2S_MCASP
>          select SND_SOC_TLV320AIC3X
> +        select SND_SOC_SPDIF
>          help
>            Say Y if you want to add support for SoC audio on TI
>            DaVinci DM6467 EVM platform.

This should be part of a separate patch which adds the code to hook up
the DAI.
