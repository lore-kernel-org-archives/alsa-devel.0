From: Padmavathi Venna <padma.v@samsung.com>
Subject: [PATCH 0/4] Add generic DMA DT binding support
Date: Fri, 18 Jan 2013 17:03:40 +0530
Message-ID: <1358508824-20352-1-git-send-email-padma.v@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: padma.v@samsung.com, padma.kvr@gmail.com, linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org
Cc: sbkim73@samsung.com, broonie@opensource.wolfsonmicro.com, vinod.koul@intel.com, grant.likely@secretlab.ca, swarren@nvidia.com, boojin.kim@samsung.com, kgene.kim@samsung.com, jassisinghbrar@gmail.com, thomas.abraham@linaro.org
List-Id: alsa-devel@alsa-project.org

This patch set adds support for generic dma device tree bindings for
Samsung platforms and is dependent on the following patches from
Vinod Koul next branch
1)of: Add generic device tree DMA helpers
2)dmaengine: add helper function to request a slave DMA channel

This patch set is made based Kukjin Kim for-next branch

Padmavathi Venna (4):
  DMA: PL330: Add xlate function
  DMA: PL330: Register the DMA controller with the generic DMA helpers
  ARM: dts: Add #dma-cells for generic dma binding support
  DMA: PL330: Modify pl330 filter based on new generic dma dt bindings.

 .../devicetree/bindings/dma/arm-pl330.txt          |    9 +++-
 arch/arm/boot/dts/exynos5250.dtsi                  |    4 ++
 drivers/dma/pl330.c                                |   48 ++++++++++++++++----
 3 files changed, 49 insertions(+), 12 deletions(-)

-- 
1.7.4.4
