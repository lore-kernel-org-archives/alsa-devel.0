From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 01/18] ASoC: omap-pcm: Support for binding
 the platform driver to dai devices
Date: Wed, 16 Apr 2014 12:30:36 +0300
Message-ID: <534E4DBC.3080208@ti.com>
References: <1397640211-15447-1-git-send-email-peter.ujfalusi@ti.com>
 <1397640211-15447-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id A431F26500B
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 11:30:40 +0200 (CEST)
In-Reply-To: <1397640211-15447-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, notasas@gmail.com
List-Id: alsa-devel@alsa-project.org

On 04/16/2014 12:23 PM, Peter Ujfalusi wrote:
> With the new calls it is going to be possible to bind the platform driver
> to a dai device which makes it easier for us in a long run to handle DT
> boots, and opens the possibility to move machine driver to generic simple
> card.
> =

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  sound/soc/omap/omap-pcm.c | 12 ++++++++++++
>  sound/soc/omap/omap-pcm.h | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>  create mode 100644 sound/soc/omap/omap-pcm.h
> =

> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index 07b8b7bc9d20..5c4bc9ae974b 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -232,6 +232,18 @@ static struct snd_soc_platform_driver omap_soc_platf=
orm =3D {
>  	.pcm_free	=3D omap_pcm_free_dma_buffers,
>  };
>  =

> +int omap_pcm_platform_register(struct device *dev)
> +{
> +	return snd_soc_register_platform(dev, &omap_soc_platform);

Aargh, I meant to use the devm_snd_soc_register_platform() so the unregister
is not going to be needed and the subsequent patches are expecting that this
is devm_*
Will resend soon.

> +}
> +EXPORT_SYMBOL_GPL(omap_pcm_platform_register);
> +
> +void omap_pcm_platform_unregister(struct device *dev)
> +{
> +	snd_soc_unregister_platform(dev);
> +}
> +EXPORT_SYMBOL_GPL(omap_pcm_platform_unregister);
> +
>  static int omap_pcm_probe(struct platform_device *pdev)
>  {
>  	return snd_soc_register_platform(&pdev->dev,
> diff --git a/sound/soc/omap/omap-pcm.h b/sound/soc/omap/omap-pcm.h
> new file mode 100644
> index 000000000000..148509eb4b63
> --- /dev/null
> +++ b/sound/soc/omap/omap-pcm.h
> @@ -0,0 +1,35 @@
> +/*
> + * omap-pcm.h - OMAP PCM driver
> + *
> + * Copyright (C) 2014 Texas Instruments, Inc.
> + *
> + * Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + */
> +
> +#ifndef __OMAP_PCM_H__
> +#define __OMAP_PCM_H__
> +
> +#if IS_ENABLED(CONFIG_SND_OMAP_SOC)
> +int omap_pcm_platform_register(struct device *dev);
> +void omap_pcm_platform_unregister(struct device *dev);
> +#else
> +static inline int omap_pcm_platform_register(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static inline void omap_pcm_platform_unregister(struct device *dev)
> +{
> +}
> +#endif /* CONFIG_SND_OMAP_SOC */
> +
> +#endif /* __OMAP_PCM_H__ */
> =



-- =

P=E9ter
