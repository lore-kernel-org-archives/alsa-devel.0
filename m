From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v2 00/11] ASoC: fsl-ssi: ac97-slave support
Date: Sun, 7 Apr 2013 22:08:43 +0200
Message-ID: <20130407200843.GA8350@pengutronix.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <5161CB73.4000302@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 6CB2C265160
 for <alsa-devel@alsa-project.org>; Sun,  7 Apr 2013 22:08:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5161CB73.4000302@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Sun, Apr 07, 2013 at 09:39:31PM +0200, Lars-Peter Clausen wrote:
> On 04/07/2013 09:25 PM, Markus Pargmann wrote:
> > Hi,
> > 
> > This series adds DT support for phycore-ac97 using the fsl-ssi driver. In
> > version 2 I discarded most of the imx-ssi work and integrated the ac97-slave
> > support in fsl-ssi, including support for imx-pcm-fiq as alternative to dma.
> > There are some other changes to get phycore-ac97 working. The first two patches
> > have notes about the detailed changes since version 1. The rest of the patches
> > is new and necessary for the ac97-slave support.
> > 
> > Regards,
> > 
> > Markus
> > 
> 
> Hi,
> 
> The DMA PCM related changes won't apply anymore due to the recent dmaengine
> PCM cleanups. I've also been working on a more generic dmaengine PCM driver
> which has DT support and can be used by imx. The work in progress patches
> can be found here:
> https://github.com/lclausen-adi/linux-2.6/commits/asoc-dmaengine-cleanups
> 
> - Lars

Okay, I will rebase it for v3 onto your committed cleanups and will have
a look on your latest patches.

Regards,

Markus

> 
> > 
> > Markus Pargmann (11):
> >   ASoC: phycore-ac97: Add DT support
> >   ASoC: imx-pcm-dma: Add support for DMA init by
> >   ASoC: imx-pcm-fiq: Introduce pcm-fiq-params
> >   ASoC: fsl-ssi: Add SACNT definitions
> >   ASoC: fsl-ssi: Add support for imx-pcm-fiq
> >   ASoC: fsl-ssi: Setup generic imx dma params
> >   ARM: imx: Export ac97 reset functions
> >   ASoC: fsl-ssi: imx ac97 support
> >   ASoC: fsl: Kconfig: Use fsl-ssi for phycore-ac97
> >   ASoC: fsl: Move fsl-ssi binding doc to sound/
> >   ASoC: fsl: Update fsl-ssi binding doc
> > 
> >  Documentation/devicetree/bindings/powerpc/fsl/ssi.txt             |   73 -
> >  Documentation/devicetree/bindings/sound/fsl,ssi.txt               |   13 
> >  b/Documentation/devicetree/bindings/sound/fsl,ssi.txt             |   73 +
> >  b/Documentation/devicetree/bindings/sound/phytec,phycore-ac97.txt |   12 
> >  b/arch/arm/mach-imx/mach-pca100.c                                 |    7 
> >  b/arch/arm/mach-imx/mach-pcm043.c                                 |    7 
> >  b/sound/soc/fsl/Kconfig                                           |    2 
> >  b/sound/soc/fsl/fsl_ssi.c                                         |   70 +
> >  b/sound/soc/fsl/fsl_ssi.h                                         |    8 
> >  b/sound/soc/fsl/imx-pcm-dma.c                                     |   31 
> >  b/sound/soc/fsl/imx-pcm-fiq.c                                     |   14 
> >  b/sound/soc/fsl/imx-pcm.h                                         |    6 
> >  b/sound/soc/fsl/imx-ssi.c                                         |    7 
> >  b/sound/soc/fsl/imx-ssi.h                                         |    1 
> >  b/sound/soc/fsl/phycore-ac97.c                                    |  185 ++++
> >  sound/soc/fsl/fsl_ssi.c                                           |  379 +++++++---
> >  sound/soc/fsl/imx-pcm.h                                           |    9 
> >  17 files changed, 664 insertions(+), 233 deletions(-)
> > 
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
