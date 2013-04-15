From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 00/17] ASoC: Towards a generic dmaengine PCM
	driver
Date: Mon, 15 Apr 2013 19:19:47 +0200
Message-ID: <1366046404-8759-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-031.synserver.de (smtp-out-037.synserver.de
 [212.40.185.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A3F02651ED
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 19:21:06 +0200 (CEST)
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Hi,

This series adds a (almost) generic dmaengine PCM driver for ASoC. The tegra,
spear, omap, imx, mxs, ep93xx and ux500 platforms are converted to use the
generic driver instead of their own custom implementation. The driver builds on
top of the dmaengine PCM library and adds the missing bits. The driver was
primarily built for handling devicetree based platforms, but the series also
adds support for compat platforms which don't use devicetree yet or have to
support non-devicetree instantiation for backwards compatibility. Since non of
the converted platforms have devicetree support yet (at least not using the
generic DMA bindings) this series doesn't enable devicetree support for them
either.  But enabling support for them is very easy and can be done by removing
the SND_DMAENGINE_PCM_NO_DT flag for these platforms.

For platforms using devicetree the DMA channels are requested early on before
the ASoC platform driver is registered. This allows us, at least in theory, to
use probe deferral if the DMA driver hasn't been probed yet. Unfortunately
of_dma_request_slave_channel either returns a valid channel or NULL, so we can't
distinguish between the case where there is no DMA channel assigned and the case
where the DMA driver hasn't been probed yet. I plan to submit a patch which lets
of_dma_request_slave_channel return a ERR_PTR, but for now the generic PCM
dmaengine driver assumes that the DMA driver will always be probed before it.
For the compat case the DMA channel gets requested from within the PCM driver's
pcm_new callback. This requires some minor changes to some of the DAI drivers
moving the initialization of the DAI DMA data pointer from the DAI startup
callback to the DAI probe callback.

Unfortunately the driver is not fully generic yet and we still need some
platform specific data to make it work, but the plan is to eventually make the
driver fully generic in the future. The platform specific bits currently are:
 * The snd_pcm_hardware struct which contains device specific parameters like
   the maximum period size and maximum number of periods as well as whether the
   driver supports pause and resume. The idea is to get rid of the per platform
   snd_pcm_hardware struct by extending the dmaengine API to a point where we
   can query all necessary information from the dmaengine driver to fill in the
   snd_pcm_hardware struct at runtime.
 * The size of the pre-allocated audio buffer. All platforms seem use different
   sizes and since some of them might be sensitive to changes to the buffer
   size this series keeps the original size for now. But we should probably try
   to decide on a sane default for this and maybe allow ASoC board drivers to
   overwrite it somehow.
 * A callback to fill in the dma_slave_config. Currently this is either NULL
   (for platforms which don't need to configure the DMA channel at runtime) or
   uses the generic snd_dmaengine_pcm_prepare_slave_config(), which uses
   snd_hwparams_to_dma_slave_config() and snd_dmaengine_pcm_set_config_from_dai_data().
   The later requires the platform to use the generic DMA DAI data struct
   though, hopefully we'll be able to convert all platforms to use this generic
   struct, and once that's done we can always use
   snd_dmaengine_pcm_prepare_slave_config() unconditionally.
 * For platforms not using devicetree platforms a callback to request the dma
   channel. This can either be a completely custom function which returns the
   channel or a filter function which will be passed to dma_request_channel. 
   The route forward here probably is to let the DAI driver provide the filter
   function or implement a table based DMA channel lookup like we have for other
   subsystems (like clk or regulator) where the board file provides a mapping
   based on the device name.

Platforms which use the dmaengine pcm library but are not converted to the
generic driver yet are atmel and mmp. mmp use a custom genalloc based memory
allocator, we may add support for this to the generic driver at a later point.
The atmel PCM driver is very interlocked with atmel SSC DAI driver, it'll
probably require some serious refactoring before it can use the generic
dmaengine PCM driver.

The driver uses snd_pcm_lib_preallocate_pages to preallocate the memory buffer.
snd_pcm_lib_preallocate_pages internally uses dma_alloc_coherent, while most of
the platforms converted in this series use dma_alloc_writecombine. Laxman
Dewangan submitted a patch[1] a couple of months ago to add support for
dma_alloc_writecombine to snd_pcm_lib_preallocate_pages, I always thought the
patch had been merged, but it looks like I was mistaken. So if there are
concerns about performance regression due to using coherent instead of
writecombine mappings we'll have to postpone converting these platforms until
Laxman's patch has been merged.

The compat path of this series hasn't been runtime tested yet and neither have
the platforms which are converted in this series. I probably broke one or two of
them by accident, so please test the patches.

Thanks,
- Lars

[1] https://lkml.org/lkml/2012/7/2/94

Lars-Peter Clausen (17):
  ASoC: dmaengine-pcm: Make requesting the DMA channel at PCM open
    optional
  ASoC: Add snd_soc_{add,remove}_platform
  ASoC: Add a generic dmaengine_pcm driver
  ASoC: dmaengine_pcm: Add support for compat platforms
  ASoC: tegra: Use generic dmaengine PCM
  ASoC: spear: Setup dma data in DAI probe
  ASoC: spear: Use generic dmaengine PCM
  ASoC: dmaengine-pcm: Add support for platforms which can't report
    residue
  ASoC: mxs: Setup dma data in DAI probe
  ASoC: mxs: Use generic dmaengine PCM
  ASoC: imx: Setup dma data in DAI probe
  ASoC: imx: Use generic dmaengine PCM
  ASoC: omap: Setup dma data in DAI probe
  ASoC: omap: Use generic dmaengine PCM
  ASoC: ep93xx: Setup dma data in DAI probe
  ASoC: ep93xx: Use generic dmaengine PCM
  ASoC: ux500: Use generic dmaengine PCM

 include/sound/dmaengine_pcm.h         |  65 +++++++-
 include/sound/soc.h                   |   4 +
 sound/soc/Kconfig                     |   4 +
 sound/soc/Makefile                    |   4 +
 sound/soc/atmel/atmel-pcm-dma.c       |   6 +-
 sound/soc/cirrus/Kconfig              |   2 +-
 sound/soc/cirrus/ep93xx-ac97.c        |  14 +-
 sound/soc/cirrus/ep93xx-i2s.c         |  14 +-
 sound/soc/cirrus/ep93xx-pcm.c         | 137 ++--------------
 sound/soc/fsl/Kconfig                 |   2 +-
 sound/soc/fsl/fsl_ssi.c               |  19 ++-
 sound/soc/fsl/imx-pcm-dma.c           |  76 ++-------
 sound/soc/fsl/imx-pcm.c               |   6 +-
 sound/soc/fsl/imx-pcm.h               |   5 +
 sound/soc/fsl/imx-ssi.c               |  22 +--
 sound/soc/mxs/Kconfig                 |   2 +-
 sound/soc/mxs/mxs-pcm.c               | 135 ++--------------
 sound/soc/mxs/mxs-saif.c              |   3 +-
 sound/soc/omap/Kconfig                |   2 +-
 sound/soc/omap/omap-dmic.c            |   4 +-
 sound/soc/omap/omap-hdmi.c            |  12 +-
 sound/soc/omap/omap-mcbsp.c           |   6 +-
 sound/soc/omap/omap-mcpdm.c           |   7 +-
 sound/soc/omap/omap-pcm.c             | 186 ++--------------------
 sound/soc/pxa/mmp-pcm.c               |   5 +-
 sound/soc/soc-core.c                  |  85 +++++++---
 sound/soc/soc-dmaengine-pcm.c         |  82 +++++++---
 sound/soc/soc-generic-dmaengine-pcm.c | 284 ++++++++++++++++++++++++++++++++++
 sound/soc/spear/spdif_in.c            |  12 +-
 sound/soc/spear/spdif_out.c           |   7 +-
 sound/soc/spear/spear_pcm.c           | 151 ++----------------
 sound/soc/tegra/Kconfig               |   2 +-
 sound/soc/tegra/tegra_pcm.c           | 171 ++------------------
 sound/soc/ux500/Kconfig               |   2 +-
 sound/soc/ux500/ux500_pcm.c           | 159 ++-----------------
 35 files changed, 651 insertions(+), 1046 deletions(-)
 create mode 100644 sound/soc/soc-generic-dmaengine-pcm.c

-- 
1.8.0
