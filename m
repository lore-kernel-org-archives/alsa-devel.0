From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Wed, 27 May 2009 11:47:11 +0100
Message-ID: <20090527104711.GA1970@sirena.org.uk>
References: <4A1BEBE3.8010306@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2816A246F8
	for <alsa-devel@alsa-project.org>;
	Wed, 27 May 2009 12:47:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A1BEBE3.8010306@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 26, 2009 at 03:17:23PM +0200, Janusz Krzysztofik wrote:

> single message. So I have switched to linux-2.6.30-rc5 and now I can  
> safely access the device, however it does not work as expected. aplay  
> and arecord wait forever, cat to/from /dev/dsp breaks with hardware  

Do they really wait for ever or do they eventually time out?  The
default for both programs is to give up after 10 seconds if there's no
DMA happening.

> First of all, I'd like to make sure if my problem is related to my code  
> only. As I am new in these areas, I would like to ask you if the omap  
> asoc framework is stable enough to relay on. If yes, could you please  

It seems to have quite a few users.

I can't spot anything obviously wrong in generic ASoC terms with your
code, though I'm not at all familiar with the McBSP hardware so can't
offer any specific suggestions there.  A few comments below.

> +#include <sound/ac97_codec.h>
> +#include <sound/initval.h>
> +#include <sound/soc.h>
> +
> +#include "cx20442.h"

Shouldn't need ac97_codec.h if it's not an AC97 CODEC.

> +static int cx20442_soc_probe(struct platform_device *pdev)
> +{
> +	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
> +	struct snd_soc_codec *codec;
> +	int ret = 0;
> +
> +	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
> +	if (codec == NULL)
> +		return -ENOMEM;
> +	mutex_init(&codec->mutex);
> +	codec->name = "CX20442";
> +	codec->owner = THIS_MODULE;
> +	codec->dai = &cx20442_dai;
> +	codec->num_dai = 1;

It'd be nice to switch this over to registering the CODEC as a platform
device rather than using the old style ASoC probing - see something line
WM8731 for a relatively simple example.

> +
> +MODULE_DESCRIPTION("ASoC cx20442 driver");
> +MODULE_AUTHOR("Cliff Cai ");

You possibly want to update this one :)

Basically, the CODEC driver looks fine from an ASoC point of view.

> +/*
> + * File:         sound/soc/codec/cx20442.h
> + * Based on:     sound/soc/codec/ad73311.h
> + * Author:       Cliff Cai <cliff.cai@analog.com>
> + *
> + * Created:      Thur Sep 25, 2008
> + * Description:  definitions for cx20442 registers
> + *
> + *
> + * Modified:
> + *               Copyright 2006 Analog Devices Inc.
> + *
> + * Bugs:         Enter bugs at http://blackfin.uclinux.org/

These comments have cut'n'paste issues too, and the register definitions
should all be removed.

> +static int ams_delta_startup(struct snd_pcm_substream *substream)
> +{
> +	ams_delta_latch2_write(AMS_DELTA_LATCH2_MODEM_CODEC, 0);
> +	return clk_enable(cx20442_mclk);
> +}
> +
> +static void ams_delta_shutdown(struct snd_pcm_substream *substream)
> +{
> +	clk_disable(cx20442_mclk);

Possibly not an issue with this device but you might want to move the
MCLK handling to your machine set_bias_level() function.  That will
mean that your MCLK will be left running for a while after audio stops,
ensuring that the DAC has had time to clock out the final sample.
Without that sometimes you can end up causing an audible artefact when
starting the next playback.
