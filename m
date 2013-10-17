From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
Date: Thu, 17 Oct 2013 11:42:08 +0200
Message-ID: <20131017114208.595a4224@ipc1.ka-ro>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
	<1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: r65073@freescale.com, timur@tabi.org, lgirdwood@gmail.com, broonie@kernel.org, r64188@freescale.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, linux@arm.linux.org.uk, perex@perex.cz, tiwai@suse.de, grant.likely@linaro.org, fabio.estevam@freescale.com, oskar@scara.com, shawn.guo@linaro.org, b42378@freescale.com, b18965@freescale.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Hi,

Xiubo Li <Li.Xiubo@freescale.com> wrote:
[...]
> diff --git a/sound/soc/fsl/fsl-pcm-dma.c b/sound/soc/fsl/fsl-pcm-dma.=
c
> new file mode 100644
> index 0000000..c4d925e
> --- /dev/null
> +++ b/sound/soc/fsl/fsl-pcm-dma.c
> @@ -0,0 +1,51 @@
[...]
> +
> +static int fsl_sai_probe(struct platform_device *pdev)
> +{
> +	struct of_phandle_args	dma_args;
> +	int index;
> +	struct resource *res;
> +	struct fsl_sai *sai;
> +	int ret =3D 0;
> +	struct device_node *np =3D pdev->dev.of_node;
> +
> +	sai =3D devm_kzalloc(&pdev->dev, sizeof(*sai), GFP_KERNEL);
> +	if (!sai)
> +		return -ENOMEM;
> +
> +	sai->fbt =3D FSL_SAI_FBT_MSB;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	sai->base =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(sai->base)) {
> +		ret =3D PTR_ERR(sai->base);
> +		return ret;
>
could be:
		return PTR_ERR(sai->base);

[...]
> +static const struct of_device_id fsl_sai_ids[] =3D {
> +	{ .compatible =3D "fsl,vf610-sai", },
> +	{ /*sentinel*/ },
>
The comma after the last entry in a struct initializer is there to make
patches that append another entry cleaner. Since this entry is and
always must be the last entry, the comma is useless here.

> diff --git a/sound/soc/fsl/fsl-sai.h b/sound/soc/fsl/fsl-sai.h
> new file mode 100644
> index 0000000..ab76a8e
> --- /dev/null
> +++ b/sound/soc/fsl/fsl-sai.h
> @@ -0,0 +1,127 @@
> +/*
> + * Copyright 2012-2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef __FSL_SAI_H
> +#define __FSL_SAI_H
> +
> +#include <sound/dmaengine_pcm.h>
> +
> +#define FSL_SAI_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
> +			 SNDRV_PCM_FMTBIT_S20_3LE |\
> +			 SNDRV_PCM_FMTBIT_S24_LE)
> +
> +#define FSL_SAI_DMABUF_SIZE	(32 * 1024)
> +#define TCD_NUMBER		4
> +#define EDMA_PRIO_HIGH          6
> +
strange indentation with mixed spaces and tabs.

> +/* SAI Transmit and Recieve Configuration 2 Register */
> +#define SAI_TCR2		0x08
> +#define SAI_RCR2		0x88
> +#define SAI_CR2_SYNC		BIT(30)
> +#define SAI_CR2_MSEL_MASK	(0xff << 26)
> +#define SAI_CR2_MSEL_BUS	0
> +#define SAI_CR2_MSEL_MCLK1	BIT(26)
> +#define SAI_CR2_MSEL_MCLK2	BIT(27)
> +#define SAI_CR2_MSEL_MCLK3	(BIT(26)|BIT(27))
>
spaces around '|'?


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
