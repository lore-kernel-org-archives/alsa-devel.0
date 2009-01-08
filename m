From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Driver for TI/BB PCM3006 codec
Date: Thu, 8 Jan 2009 10:49:37 +0000
Message-ID: <20090108104937.GA17064@rakim.wolfsonmicro.main>
References: <8447d6730901080216i148effc5mf779db5acb164ca3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 223981037E3
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 11:49:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <8447d6730901080216i148effc5mf779db5acb164ca3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Davide Rizzo <elpa.rizzo@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 08, 2009 at 11:16:00AM +0100, Davide Rizzo wrote:
> This patch implements the driver for the TI (ex Burr-Brown) PCM3006 codec
> 
> Signed-off-by: Davide Rizzo <elpa-rizzo@gmail.com>

This looks good but needs a refresh against the current ASoC code -
there have been some API changes around codec registration for 2.6.29.
You should make this a platform driver, then register the codec and DAIs
with the ASoC core when that driver is probed.

Current code is in the topic/asoc branc of:

	git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

A few other comments below.

> +++ linux-2.6.28.elpa/sound/soc/codecs/Kconfig	2009-01-04
> 08:58:40.000000000 +0100
> @@ -60,6 +60,10 @@ config SND_SOC_CS4270_VD33_ERRATA
>  	bool
>  	depends on SND_SOC_CS4270
> 
> +config SND_SOC_PCM3006
> +	tristate
> +	depends on SND_SOC
> +

The depends isn't needed and this should also be added to
SND_SOC_ALL_CODECS.

> +/*
> + * pcm3006.c  --  ALSA Soc PCM3006 codec support
> + *

> + *  Revision history
> + *    25th Apr 2008   Initial version.

Please drop the changelog from the code - git will keep track of this.

> +static unsigned int pcm3006_read(struct snd_soc_codec *codec,
> +	unsigned int reg)
> +{
> +	return 0;
> +}
> +
> +static int pcm3006_write(struct snd_soc_codec *codec, unsigned int reg,
> +	unsigned int val)
> +{
> +	return 0;
> +}

Just remove these if the codec doesn't have any registers, they are only
needed if that is the case.

> 12:30:42.000000000 +0200
> @@ -0,0 +1,19 @@
> +/*
> + * linux/sound/codecs/i2s.h -- ALSA SoC Layer
> + *

Looks like bitrot here...
