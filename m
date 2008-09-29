From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/5] [RFC] ALSA ASOC Support for 5912 osk
Date: Mon, 29 Sep 2008 12:04:22 +0100
Message-ID: <20080929110419.GC27647@sirena.org.uk>
References: <dfeb90390809290248h5638e275n458e80743954c0cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E604C243E3
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Sep 2008 13:04:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <dfeb90390809290248h5638e275n458e80743954c0cf@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun KS <arunks@mistralsolutions.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@nokia.com>, felipe.balbi@nokia.com
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 29, 2008 at 03:18:32PM +0530, Arun KS wrote:
> Adding ASOC machine driver for osk

This also looks good - a couple of very minor points below:

BTW, it's "ASoC" not "ASOC".

> + * osk.c  --  SoC audio for 5912 OSK

I don't know anything in particular about these boards but perhaps it
would be a good idea to include the part number in the name in case
someone decides it's a good idea to make an OSK for another OMAP
variant?  Google suggests that the board is referred to as the OSK
generally so probably not but I thought I'd better ask - though you do
use 5192OSK as well.

> +	/* Set the codec system clock for DAC and ADC */
> +	err = snd_soc_dai_set_sysclk(codec_dai, 0, 12000000, SND_SOC_CLOCK_IN);

Here you hardcode the clock to 12MHz...

> +#define CODEC_CLOCK 	12000000

...but here you have a #define for it.  It'd be better to put the define
at the top of the file and use it in the hw_params() function as well.
