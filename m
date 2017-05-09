From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/2] ALSA, dmaengine: dw: Remove AVR32 bits in drivers
Date: Tue,  9 May 2017 19:18:35 +0300
Message-ID: <20170509161837.48301-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, linux-kernel@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

AVR32 is gone. Remove bits in sound/atmel and drivers/dma/dw folders
related to it.

Sound part hasn't been tested anyhow.

Changes since v1:
 - fix kbuild bot complainings
 - append Nicolas' Ack
 - don't forget to send to all TWIMC

Andy Shevchenko (2):
  ALSA: atmel: Remove AVR32 bits from the driver
  dmaengine: dw: Remove AVR32 bits from the driver

 drivers/dma/dw/Kconfig |   7 +-
 drivers/dma/dw/core.c  | 332 +--------------------------
 drivers/dma/dw/regs.h  |  50 +---
 include/linux/dma/dw.h |  21 --
 sound/atmel/Kconfig    |  13 +-
 sound/atmel/Makefile   |   2 -
 sound/atmel/abdac.c    | 610 -------------------------------------------------
 sound/atmel/ac97c.c    | 447 ++++++------------------------------
 8 files changed, 88 insertions(+), 1394 deletions(-)
 delete mode 100644 sound/atmel/abdac.c

-- 
2.11.0
