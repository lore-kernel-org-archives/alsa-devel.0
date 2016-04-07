From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/6] ASoC: Davinci: McBSP: add device tree
 support for McBSP
Date: Thu, 7 Apr 2016 15:42:38 +0300
Message-ID: <570655BE.7030109@ti.com>
References: <1459948893-4206-1-git-send-email-petr@barix.com>
 <1459948893-4206-3-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id BD3AA2662CB
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 14:42:45 +0200 (CEST)
In-Reply-To: <1459948893-4206-3-git-send-email-petr@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>, nsekhar@ti.com, khilman@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, galak@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On 04/06/16 16:21, Petr Kulhavy wrote:
> This adds DT support for the TI DA8xx/OMAP-L1x/AM17xx/AM18xx McBSP driver.
> =

> Signed-off-by: Petr Kulhavy <petr@barix.com>
> ---
>  sound/soc/davinci/Kconfig       |   6 ++-
>  sound/soc/davinci/davinci-i2s.c | 106 ++++++++++++++++++++++++++++++++++=
------
>  2 files changed, 96 insertions(+), 16 deletions(-)
> =

> diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
> index 50ca291cc225..6b732d8e5896 100644
> --- a/sound/soc/davinci/Kconfig
> +++ b/sound/soc/davinci/Kconfig
> @@ -16,7 +16,11 @@ config SND_EDMA_SOC
>  	  - DRA7xx family
>  =

>  config SND_DAVINCI_SOC_I2S
> -	tristate
> +	tristate "DaVinci Multichannel Buffered Serial Port (McBSP) support"
> +	depends on SND_EDMA_SOC
> +	help
> +	  Say Y or M here if you want to have support for McBSP IP found in
> +	  Texas Instruments DaVinci DA850 SoCs.
>  =

>  config SND_DAVINCI_SOC_MCASP
>  	tristate "Multichannel Audio Serial Port (McASP) support"
> diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-=
i2s.c
> index ec98548a5fc9..2ebfe86dd584 100644
> --- a/sound/soc/davinci/davinci-i2s.c
> +++ b/sound/soc/davinci/davinci-i2s.c
> @@ -4,9 +4,15 @@
>   * Author:      Vladimir Barinov, <vbarinov@embeddedalley.com>
>   * Copyright:   (C) 2007 MontaVista Software, Inc., <source@mvista.com>
>   *
> + * DT support	(c) 2016 Petr Kulhavy, Barix AG <petr@barix.com>
> + *		based on davinci-mcasp.c DT support
> + *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
> + *
> + * TODO:
> + * on DA850 implement HW FIFOs instead of DMA into DXR and DRR registers

The BFIFO looks identical to AFIFO for McASP...

>   */
>  =

>  #include <linux/init.h>
> @@ -648,15 +654,82 @@ static const struct snd_soc_component_driver davinc=
i_i2s_component =3D {
>  	.name		=3D "davinci-i2s",
>  };
>  =

> +static struct snd_platform_data*
> +davinci_i2s_set_pdata_from_of(struct platform_device *pdev)
> +{
> +	struct snd_platform_data *pdata =3D NULL;
> +	struct device_node *np;
> +	struct of_phandle_args dma_spec;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_OF) || !pdev->dev.of_node)
> +		return dev_get_platdata(&pdev->dev);
> +
> +	pdata =3D devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	np =3D pdev->dev.of_node;
> +
> +	ret =3D of_property_match_string(np, "dma-names", "tx");
> +	if (ret >=3D 0) {
> +		ret =3D of_parse_phandle_with_args(np, "dmas", "#dma-cells", ret,
> +						 &dma_spec);
> +		if (ret >=3D 0)
> +			pdata->tx_dma_channel =3D dma_spec.args[0];
> +	}
> +
> +	ret =3D of_property_match_string(np, "dma-names", "rx");
> +	if (ret >=3D 0) {
> +		ret =3D of_parse_phandle_with_args(np, "dmas", "#dma-cells", ret,
> +						 &dma_spec);
> +		if (ret >=3D 0)
> +			pdata->rx_dma_channel =3D dma_spec.args[0];
> +	}

Why would you do this? If we booted with DT the only thing needed by the
edma-pcm (dmaengine) is the name of the DMA channel...

> +
> +	/* optional parameters */
> +
> +	pdata->enable_channel_combine =3D
> +		of_property_read_bool(np, "channel-combine");

This can only be done when the McBSP is used in DSP_x mode since this will
make the McBSP to transmit the stereo audio as mono on the bus.

After a quick look at the relevant parts in the driver, I think most of the
things are pretty much broken or at least they are not totally correct. McB=
SP
do support real I2S (SRGR:FWID), and the phase setup is wrong in the code. =
IMO.
I don't have HW to test the daVinci-MCBSP or the ASP so I can not comment on
how well things are working.

> +
> +	/*
> +	 * pdata->clk_input_pin is deliberately not exported to DT
> +	 * and the default value of the clk_input_pin is MCBSP_CLKR.
> +	 * The value MCBSP_CLKS makes no sense as it turns the CPU
> +	 * to a bit clock master in the SND_SOC_DAIFMT_CBM_CFS mode
> +	 * where it should be bit clock slave!
> +	 */

Interesting. As a whole the clock selection part is mostly broken in the dr=
iver...
It would be better to add davinci_i2s_set_sysclk() to deal with the system
clock configuration.

> +
> +	return pdata;
> +}
> +
>  static int davinci_i2s_probe(struct platform_device *pdev)
>  {
> +	struct snd_platform_data *pdata;
>  	struct davinci_mcbsp_dev *dev;
>  	struct resource *mem, *res;
>  	void __iomem *io_base;
>  	int *dma;
>  	int ret;
>  =

> -	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	pdata =3D davinci_i2s_set_pdata_from_of(pdev);
> +	if (IS_ERR(pdata)) {
> +		dev_err(&pdev->dev, "Error populating platform data, err %ld\n",
> +			PTR_ERR(pdata));
> +		return PTR_ERR(pdata);
> +	}
> +
> +	mem =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
> +	if (!mem) {
> +		dev_warn(&pdev->dev,
> +			 "\"mpu\" mem resource not found, using index 0\n");
> +		mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		if (!mem) {
> +			dev_err(&pdev->dev, "no mem resource?\n");
> +			return -ENODEV;
> +		}
> +	}
> +
>  	io_base =3D devm_ioremap_resource(&pdev->dev, mem);
>  	if (IS_ERR(io_base))
>  		return PTR_ERR(io_base);
> @@ -680,25 +753,21 @@ static int davinci_i2s_probe(struct platform_device=
 *pdev)
>  	    (dma_addr_t)(mem->start + DAVINCI_MCBSP_DRR_REG);
>  =

>  	/* first TX, then RX */
> -	res =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
> -	if (!res) {
> -		dev_err(&pdev->dev, "no DMA resource\n");
> -		ret =3D -ENXIO;
> -		goto err_release_clk;
> -	}
>  	dma =3D &dev->dma_request[SNDRV_PCM_STREAM_PLAYBACK];
> -	*dma =3D res->start;
>  	dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].filter_data =3D dma;
> +	res =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
> +	if (res)
> +		*dma =3D res->start;
> +	else
> +		*dma =3D pdata->tx_dma_channel;

Please follow the way davinci-mcasp does it right now:
	dma_data =3D &mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
	...
	dma =3D &mcasp->dma_request[SNDRV_PCM_STREAM_PLAYBACK];
	res =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
	if (res)
		*dma =3D res->start;
	else
		*dma =3D pdata->tx_dma_channel;

	/* dmaengine filter data for DT and non-DT boot */
	if (pdev->dev.of_node)
		dma_data->filter_data =3D "tx";
	else
		dma_data->filter_data =3D dma;

while we are here, I think the tx/rx_dma_channel is something we should just
get rid of. It is not used as far as I can tell.
Something like this would do I think:
	dma_data =3D &mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
	...
	res =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
	if (res) {
		dma =3D &mcasp->dma_request[SNDRV_PCM_STREAM_PLAYBACK];
		*dma =3D res->start;
		dma_data->filter_data =3D dma;
	} else if (pdev->dev.of_node) {
		dma_data->filter_data =3D "tx";
	} else {
		dev_err(&pdev->dev, "Missing DMA tx resource\n");
		return -ENODEV;
	}

>  =

> -	res =3D platform_get_resource(pdev, IORESOURCE_DMA, 1);
> -	if (!res) {
> -		dev_err(&pdev->dev, "no DMA resource\n");
> -		ret =3D -ENXIO;
> -		goto err_release_clk;
> -	}
>  	dma =3D &dev->dma_request[SNDRV_PCM_STREAM_CAPTURE];
> -	*dma =3D res->start;
>  	dev->dma_data[SNDRV_PCM_STREAM_CAPTURE].filter_data =3D dma;
> +	res =3D platform_get_resource(pdev, IORESOURCE_DMA, 1);
> +	if (res)
> +		*dma =3D res->start;
> +	else
> +		*dma =3D pdata->rx_dma_channel;

same comment as for the TX dma part.

>  =

>  	dev->dev =3D &pdev->dev;
>  	dev_set_drvdata(&pdev->dev, dev);
> @@ -737,11 +806,18 @@ static int davinci_i2s_remove(struct platform_devic=
e *pdev)
>  	return 0;
>  }
>  =

> +static const struct of_device_id davinci_mcbsp_match[] =3D {
> +	{ .compatible =3D "ti,da850-mcbsp-audio" },

I would drop the "-audio" for the binding...

> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, davinci_mcbsp_match);
> +
>  static struct platform_driver davinci_mcbsp_driver =3D {
>  	.probe		=3D davinci_i2s_probe,
>  	.remove		=3D davinci_i2s_remove,
>  	.driver		=3D {
>  		.name	=3D "davinci-mcbsp",
> +		.of_match_table =3D of_match_ptr(davinci_mcbsp_match),

The driver calls itself davinci-i2s.c and the prefixes internally used are
davinci_i2s_*.
The driver name is "davinci-mcbsp".
And it is basically a driver for daVinci ASP (the McBSP additions are not
configured at all).

I still think we should keep the davinci_i2s_* when adding new code, or ren=
ame
the whole driver and it's prefixes to something more sensible?


>  	},
>  };
>  =

> =



-- =

P=E9ter
