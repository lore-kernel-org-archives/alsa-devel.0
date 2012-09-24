From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] dmaengine: Fix compillation issues in device_prep_dma_cyclic()
Date: Mon, 24 Sep 2012 10:58:03 +0300
Message-ID: <1348473485-5081-1-git-send-email-peter.ujfalusi@ti.com>
References: <20120924133923.130c4db72aa8105cb5647d7a@canb.auug.org.au>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120924133923.130c4db72aa8105cb5647d7a@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: alsa-devel@alsa-project.org

Hello,

The reason for the breakage is the patch 1 got lost somewhere in the process.
I also greped the whole tree for device_prep_dma_cyclic() and the second patch
is the result of that.

PS: I did build tested the series on ARM (OMAP), x86_32, x86_64 but not for ppc
for sure.

Regards,
Peter
---
Peter Ujfalusi (2):
  dmaengine: Add flags parameter to dmaengine_prep_dma_cyclic()
  ARM: SAMSUNG: dma-ops: Fix dmaengine_prep_dma_cyclic() parameter list

 arch/arm/plat-samsung/dma-ops.c | 3 ++-
 include/linux/dmaengine.h       | 3 ++-
 sound/soc/soc-dmaengine-pcm.c   | 6 +++++-
 3 files changed, 9 insertions(+), 3 deletions(-)

-- 
1.7.12
