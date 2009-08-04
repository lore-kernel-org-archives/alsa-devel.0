From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: add DAI platform ssi driver for
 MXC
Date: Tue, 4 Aug 2009 20:43:43 +0100
Message-ID: <20090804194343.GC4342@sirena.org.uk>
References: <eedb5540908040817tc85e5e3j172fb18bcd8e6da0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 34B84243B4
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 21:43:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <eedb5540908040817tc85e5e3j172fb18bcd8e6da0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 04, 2009 at 05:17:58PM +0200, javier Martin wrote:
> This adds support for DAI platform for the SSI present in MXC platforms.
> 
> It currently does not support i.MX3, the only thing necessary to do
> this is to export DMA data for i.MX3 interface which I haven't done
> because I don't have a i.MX3 based board available.
> 
> It has been tested on i.MX27 board.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>

Overall this also looks pretty good, most of the issues here are either
minor or due to the fact that you're developing against 2.6.30.

The main issue here is that modern DAI drivers should be done so that
the DAI is probed as a device in its own right via the normal device
model stuff (so there should be an imx-ssi.0 device for SSI1 and so on).
These should do all the resource acquisition stuff like grabbing clocks
and interrupts in their probe() then call snd_soc_register_dai() for the
DAI.  This allows better integration with the device model and makes it
much easier to deal with new CPU variants - you can just define a new
device in the arch code and the device will get instantiated
automatically.

>  sound/soc/imx/mxc-ssi.c |  868 +++++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/imx/mxc-ssi.h |  238 +++++++++++++

Every other implementation of this driver I've seen names the files
imx-ssi - probably best to stick to that to avoid confusion for people
carrying about those patches.

> +static struct clk *ssi_clk0, *ssi_clk1;

It'd be nicer to do this by having private data for the SSI DAIs and
using that to keep the clock and other data.  This will help when moving
forward to the later i.MX CPUs with more DAIs.

> +	}
> +}
> +EXPORT_SYMBOL(get_ssi_clk);

This export shouldn't be needed - it should be possible to do everything
from within the DAI.  This is one benefit of converting to using a
proper platform device for the SSI.

> +/*
> + * SSI Network Mode or TDM slots configuration.
> + * Should only be called when port is inactive (i.e. SSIEN = 0).
> + */
> +static int imx_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
> +	unsigned int mask, int slots)

There's some pending patches to refactor the TDM slot configuration.
If you're not actively using this in your driver I'm inclined to remove
this for now to save having to update it for API changes.  Is that going
to cause you problems/

> +#ifdef CONFIG_PM
> +static int imx_ssi_suspend(struct platform_device *dev,
> +	struct snd_soc_dai *dai)
> +{
> +	return 0;
> +}
> +
> +static int imx_ssi_resume(struct platform_device *pdev,
> +	struct snd_soc_dai *dai)
> +{
> +	return 0;
> +}
> +
> +#else
> +#define imx_ssi_suspend	NULL
> +#define imx_ssi_resume	NULL
> +#endif

May as well just drop these.

> +#define IMX_SSI_RATES \
> +	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | \
> +	SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | \
> +	SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
> +	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | \
> +	SNDRV_PCM_RATE_96000)

There's a SNDRV_PCM_RATE_8000_96000 (or at least _48000) which
simplifies this a lot :)

> +#define SACADD 0x3c
> +#define SACDAT 0x40

All these register names should really be namespaced.
