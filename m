From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/6] ASoC: Blackfin: new machine driver for
	ADAU1361 codecs
Date: Sat, 7 Aug 2010 22:08:55 +0100
Message-ID: <AC17F0B0-A138-46D6-B0A7-2752D291BA03@opensource.wolfsonmicro.com>
References: <1281212905-12957-1-git-send-email-vapier@gentoo.org>
	<1281212905-12957-2-git-send-email-vapier@gentoo.org>
	(sfid-20100807_212828_848007_3F2FECD5)
Mime-Version: 1.0 (iPad Mail 7B405)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 902DD103805
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Aug 2010 23:08:35 +0200 (CEST)
In-Reply-To: <1281212905-12957-2-git-send-email-vapier@gentoo.org>
	(sfid-20100807_212828_848007_3F2FECD5)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On 7 Aug 2010, at 21:28, Mike Frysinger <vapier@gentoo.org> wrote:

> +config SND_BF5XX_SOC_ADAU1361
> +	tristate "SoC ADAU1361 Audio support"
> +	depends on SND_BF5XX_I2S
> +	select SND_BF5XX_SOC_I2S
> +	select SND_SOC_ADAU1361
> +	select I2C
> +	help
> +	  Say Y if you want to add support for ADAU1361 SoC audio.
> +

Identical comments to the last machine driver you posted here.

It'd be really helpful if you could do a bit more pre-review on the stuff you're posting, especially where you've got a bunch of drivers that follow similar patterns and are going to generate exactly the same feedback. Posting a large batch of patches at once isn't a problem but if you're sending additional patches later on it'd be helpful to take into account the feedback that has already been given on prior serieses.

> +	switch (params_rate(params)) {
> +	case 11025:
> +	case 22050:
> +	case 44100:
> +	case 88200:
> +		pll_out = ADAU1361_PLL_FREQ_441;
> +		break;
> +	case 8000:
> +	case 12000:
> +	case 16000:
> +	case 24000:
> +	case 32000:
> +	case 48000:
> +	case 64000:
> +	case 96000:
> +		pll_out = ADAU1361_PLL_FREQ_48;
> +		break;
> +	default:
> +		pll_out = ADAU1361_PLL_FREQ_441;
> +		break;
> +	}

It seems silly for the machine drivers to all have to manually do this lookup - it appears to be entirely and inflexibly related to the sample rate in use. May as well just specify the input clock to the device.

> +	/* set codec DAI configuration */
> +	ret = codec_dai->ops->set_fmt(codec_dai,
> +		SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> +		SND_SOC_DAIFMT_CBM_CFM);
> +	if (ret < 0)
> +		return ret;

There are accessor functions for this stuff. I've stopped reviewing the code at this point.
