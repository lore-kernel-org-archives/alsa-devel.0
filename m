From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 00/10] ASoC: imx sound: Add DT support
Date: Sun, 10 Mar 2013 19:33:01 +0100
Message-ID: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Timur Tabi <timur-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi,

This series adds DT support for imx-ssi and phycore-ac97. It also
contains some fixes for imx-ssi and phycore-ac97.

Patch 8 introduces a seperated function 'of_snd_dmaengine_pcm_open'
to create a DMA PCM substream using the generic DMA DT bindings.

Regards,
Markus


Sascha Hauer (3):
 imx-ssi: Fix AC97 rates
 imx-ssi: Fix occasional AC97 reset failure
 mx-ssi: flush fifos

Markus Pargmann (7):
 ASoC: Kconfig: imx-ssi needs imx-fiq and imx-dma
 ASoC: pcm030 audio fabric: remove __init from probe
 ARM: soc-audio phycore-ac97: fix driver init order
 ASoC: phycore-ac97: Add DT support
 ASoC: dmaengine_pcm: Add open function for DT DMA
 ASoC: imx-pcm-dma: Add support for DMA init by device
 ASoC: imx-ssi: Add imx27 and pca100 DT support

 b/Documentation/devicetree/bindings/sound/fsl-imx-ssi |   34 ++++
 b/arch/arm/mach-imx/mach-pca100.c                     |    7 
 b/include/sound/dmaengine_pcm.h                       |    2 
 b/sound/soc/fsl/Kconfig                               |    2 
 b/sound/soc/fsl/imx-pcm-dma.c                         |   31 ++-
 b/sound/soc/fsl/imx-pcm.h                             |    6 
 b/sound/soc/fsl/imx-ssi.c                             |    2 
 b/sound/soc/fsl/pcm030-audio-fabric.c                 |    2 
 b/sound/soc/fsl/phycore-ac97.c                        |   33 ++--
 b/sound/soc/soc-dmaengine-pcm.c                       |   89 ++++++++--
 sound/soc/fsl/imx-ssi.c                               |   95 ++++++++++-
 sound/soc/fsl/phycore-ac97.c                          |  148 +++++++++++++++---
 12 files changed, 371 insertions(+), 80 deletions(-)
