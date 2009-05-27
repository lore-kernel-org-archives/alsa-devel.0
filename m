From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Wed, 27 May 2009 16:52:46 +0200
Message-ID: <4A1D53BE.6040805@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl>
	<20090527104711.GA1970@sirena.org.uk>
Reply-To: postmaster@icnet.pl
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from d1.icnet.pl (d1.icnet.pl [212.160.220.21])
	by alsa0.perex.cz (Postfix) with ESMTP id A9B82244A0
	for <alsa-devel@alsa-project.org>;
	Wed, 27 May 2009 16:52:48 +0200 (CEST)
In-Reply-To: <20090527104711.GA1970@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Wed, May 27, 2009 at 12:47, Mark Brown wrote:
> On Tue, May 26, 2009 at 03:17:23PM +0200, Janusz Krzysztofik wrote:
>> ... aplay  
>> and arecord wait forever, cat to/from /dev/dsp breaks with hardware  
> Do they really wait for ever or do they eventually time out?  The
> default for both programs is to give up after 10 seconds if there's no
> DMA happening.

That was more than 10 seconds for sure.

> ... A few comments below.
> 
>> +#include <sound/ac97_codec.h>
>> +#include <sound/initval.h>
>> +#include <sound/soc.h>
>> +
>> +#include "cx20442.h"
> 
> Shouldn't need ac97_codec.h if it's not an AC97 CODEC.

Yes, I am going to clean up the code if it ever starts working.

>> +static int cx20442_soc_probe(struct platform_device *pdev)
>> +{
>> +	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
>> +	struct snd_soc_codec *codec;
>> +	int ret = 0;
>> +
>> +	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
>> +	if (codec == NULL)
>> +		return -ENOMEM;
>> +	mutex_init(&codec->mutex);
>> +	codec->name = "CX20442";
>> +	codec->owner = THIS_MODULE;
>> +	codec->dai = &cx20442_dai;
>> +	codec->num_dai = 1;
> 
> It'd be nice to switch this over to registering the CODEC as a platform
> device rather than using the old style ASoC probing - see something line
> WM8731 for a relatively simple example.

OK, I'll follow it.

>> +MODULE_DESCRIPTION("ASoC cx20442 driver");
>> +MODULE_AUTHOR("Cliff Cai ");
> 
> You possibly want to update this one :)

Sure.

> Basically, the CODEC driver looks fine from an ASoC point of view.

Fine.

>> +/*
>> + * File:         sound/soc/codec/cx20442.h
>> + * Based on:     sound/soc/codec/ad73311.h
>> + * Author:       Cliff Cai <cliff.cai@analog.com>
>> + *
>> + * Created:      Thur Sep 25, 2008
>> + * Description:  definitions for cx20442 registers
>> + *
>> + *
>> + * Modified:
>> + *               Copyright 2006 Analog Devices Inc.
>> + *
>> + * Bugs:         Enter bugs at http://blackfin.uclinux.org/
> 
> These comments have cut'n'paste issues too, and the register definitions
> should all be removed.

Yes, only extern struct declarations required here, I think.

>> +static int ams_delta_startup(struct snd_pcm_substream *substream)
>> +{
>> +	ams_delta_latch2_write(AMS_DELTA_LATCH2_MODEM_CODEC, 0);
>> +	return clk_enable(cx20442_mclk);
>> +}
>> +
>> +static void ams_delta_shutdown(struct snd_pcm_substream *substream)
>> +{
>> +	clk_disable(cx20442_mclk);
> 
> Possibly not an issue with this device but you might want to move the
> MCLK handling to your machine set_bias_level() function.  That will
> mean that your MCLK will be left running for a while after audio stops,
> ensuring that the DAC has had time to clock out the final sample.
> Without that sometimes you can end up causing an audible artefact when
> starting the next playback.

OK, I'll look at this, but first I have to learn what MCLK really is ;)

Thanks,
Janusz
