From: Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH v5 0/4] Add dual-fifo mode support of i.MX ssi
Date: Fri, 8 Nov 2013 19:32:50 +0800
Message-ID: <cover.1383910029.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, timur-N01EOCouUvQ@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org
List-Id: alsa-devel@alsa-project.org

 * ! This series of patches has a direct dependency between them. When
 * ! applying them, we need to apply to one single branch. Otherwise,
 * ! it would break currect branches.

Changelog
v5:
 * PATCH-3: Add period size constraint when using dual fifo mode
 *
 * Nothing changes for the other three patches
v4:
 * PATCH-3: Drop useless register configuration.
 *
 * Nothing changes for the other three patches
v3:
 * PATCH-1: Add comments to indicate the end of v1 and v2 array.
 * PATCH-3: Use better way to keep watermark as even number.
 *
 * Nothing changes for PATCH-2 and PATCH-4
v2:
 * Instead of adding rogue scripts to current SDMA driver based on firmware
 * V1, we define the new SDMA firmware as version 2 and bisect the PATCH-1
 * to two patches: The first is to add version check code to the SDMA driver;
 * And the second is to add SSI dual FIFO DMATYPE.
 *
 * Nothing changes for the last two patches.
v1:
 * SSI can reduce hardware overrun/underrun possibility when using dual
 * fifo mode. To support this mode, we need to first update sdma sciprt
 * list, and then enable dual fifo BIT in SSI driver, and last update DT
 * bindings of i.MX series.

Nicolin Chen (4):
  dma: imx-sdma: Add sdma firmware version 2 support
  dma: imx-sdma: Add new dma type for ssi dual fifo script
  ASoC: fsl_ssi: Add dual fifo mode support
  ARM: dts: imx: use dual-fifo sdma script for ssi

 .../devicetree/bindings/dma/fsl-imx-sdma.txt       |  1 +
 arch/arm/boot/dts/imx51.dtsi                       |  4 ++--
 arch/arm/boot/dts/imx53.dtsi                       |  4 ++--
 arch/arm/boot/dts/imx6qdl.dtsi                     | 12 +++++-----
 arch/arm/boot/dts/imx6sl.dtsi                      | 12 +++++-----
 drivers/dma/imx-sdma.c                             | 19 ++++++++++++++-
 include/linux/platform_data/dma-imx-sdma.h         |  5 ++++
 include/linux/platform_data/dma-imx.h              |  1 +
 sound/soc/fsl/fsl_ssi.c                            | 27 +++++++++++++++++++++-
 9 files changed, 67 insertions(+), 18 deletions(-)

-- 
1.8.4


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
