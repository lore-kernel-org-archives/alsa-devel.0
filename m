From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/6] Convert JZ4740 to dmaengine
Date: Thu, 23 May 2013 22:36:21 +0200
Message-ID: <1369341387-19147-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-103.synserver.de (smtp-out-103.synserver.de
 [212.40.185.103])
 by alsa0.perex.cz (Postfix) with ESMTP id 63C2A265066
 for <alsa-devel@alsa-project.org>; Thu, 23 May 2013 22:34:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ralf Baechle <ralf@linux-mips.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Maarten ter Huurne <maarten@treewalker.org>, linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

This series replaces the custom JZ4740 DMA API with a dmaengine driver. This is
done in 3 steps:
	1) Add a dmaengine driver which wraps the custom JZ4740 DMA API
	2) Update all users of the JZ4740 DMA API to use dmaengine instead
	3) Remove the custom API and move all direct hardware access to the
	   dmaengine driver.

The first two patches in the series also make sure that the clock of the DMA
core is enabled.

Since the patches in this series depend on each other I'd prefer if they could
all go through the DMA tree.

- Lars

Lars-Peter Clausen (4):
  dma: Add a jz4740 dmaengine driver
  MIPS: jz4740: Register jz4740 DMA device
  ASoC: jz4740: Use the generic dmaengine PCM driver
  MIPS: jz4740: Remove custom DMA API

Maarten ter Huurne (2):
  MIPS: jz4740: Correct clock gate bit for DMA controller
  MIPS: jz4740: Acquire and enable DMA controller clock

 arch/mips/include/asm/mach-jz4740/dma.h      |  56 ---
 arch/mips/include/asm/mach-jz4740/platform.h |   1 +
 arch/mips/jz4740/Makefile                    |   2 +-
 arch/mips/jz4740/board-qi_lb60.c             |   1 +
 arch/mips/jz4740/clock.c                     |   2 +-
 arch/mips/jz4740/dma.c                       | 287 -------------
 arch/mips/jz4740/platform.c                  |  21 +
 drivers/dma/Kconfig                          |   6 +
 drivers/dma/Makefile                         |   1 +
 drivers/dma/dma-jz4740.c                     | 616 +++++++++++++++++++++++++++
 sound/soc/jz4740/Kconfig                     |   1 +
 sound/soc/jz4740/jz4740-i2s.c                |  48 +--
 sound/soc/jz4740/jz4740-pcm.c                | 310 +-------------
 sound/soc/jz4740/jz4740-pcm.h                |  20 -
 14 files changed, 675 insertions(+), 697 deletions(-)
 delete mode 100644 arch/mips/jz4740/dma.c
 create mode 100644 drivers/dma/dma-jz4740.c
 delete mode 100644 sound/soc/jz4740/jz4740-pcm.h

-- 
1.8.2.1
