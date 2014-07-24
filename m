From: Nicolin Chen <Guangyu.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [RFC][PATCH 0/2] Add ASRC Peripheral to Peripheral driver
Date: Thu, 24 Jul 2014 16:25:46 +0800
Message-ID: <20140724082545.GA27595@MrMyself>
References: <cover.1402653667.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cover.1402653667.git.nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, timur-N01EOCouUvQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b38343-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b02247-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 13, 2014 at 06:07:03PM +0800, Nicolin Chen wrote:
> This series of patches have a direct dependency between them. So we might
> need to push them into one branch. And sorry for this :(
> 
> Patch-1 adds device to device support in SDMA driver along with a secondary
> request in struct imx_dma_data which's requred in the Patch-2 ASRC driver.

I just sent a new version V2. So please disregard this version.

Thanks all,
Nicolin

> 
> Nicolin Chen (2):
>   dma: imx-sdma: Add device to device support
>   ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and platform drivers
> 
>  .../devicetree/bindings/sound/fsl,asrc.txt         |   62 ++
>  drivers/dma/imx-sdma.c                             |   40 +-
>  include/linux/platform_data/dma-imx.h              |    1 +
>  sound/soc/fsl/Kconfig                              |    9 +
>  sound/soc/fsl/Makefile                             |    2 +
>  sound/soc/fsl/fsl_asrc.c                           | 1031 ++++++++++++++++++++
>  sound/soc/fsl/fsl_asrc.h                           |  431 ++++++++
>  sound/soc/fsl/fsl_asrc_dma.c                       |  385 ++++++++
>  8 files changed, 1956 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,asrc.txt
>  create mode 100644 sound/soc/fsl/fsl_asrc.c
>  create mode 100644 sound/soc/fsl/fsl_asrc.h
>  create mode 100644 sound/soc/fsl/fsl_asrc_dma.c
> 
> -- 
> 1.8.4
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
