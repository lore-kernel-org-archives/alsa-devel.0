From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 0/3] Driver for Cirrus Logic CS47L24 codec
Date: Tue, 11 Nov 2014 16:52:27 +0000
Message-ID: <20141111165227.GA24344@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-gpio-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This set of patches add support for the Cirrus Logic CS47L24
codec.

The patches depend on two open patches from Charles Keepax which
must be applied first:
  [PATCH] mfd: wm5110: Add missing registers for AIF2 channels 3-6
  [PATCH] mfd: arizona: Document HP_CTRL_1L and HP_CTRL_1R registers


Richard Fitzgerald (3):
  mfd: arizona: Add support for CS47L24
  gpio: arizona: Add support for CS47L24
  ASoC: arizona: Add initial CS47L24 codec driver

 drivers/gpio/gpio-arizona.c      |    5 +
 drivers/mfd/Kconfig              |    6 +
 drivers/mfd/Makefile             |    3 +
 drivers/mfd/arizona-core.c       |   91 ++-
 drivers/mfd/arizona-irq.c        |   42 +-
 drivers/mfd/arizona-spi.c        |    9 +
 drivers/mfd/arizona.h            |    5 +
 drivers/mfd/cs47l24-tables.c     | 1632 ++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/arizona/core.h |    4 +
 sound/soc/codecs/Kconfig         |    8 +
 sound/soc/codecs/Makefile        |    2 +
 sound/soc/codecs/arizona.c       |    5 +
 sound/soc/codecs/cs47l24.c       | 1133 ++++++++++++++++++++++++++
 sound/soc/codecs/cs47l24.h       |   23 +
 14 files changed, 2941 insertions(+), 27 deletions(-)
 create mode 100644 drivers/mfd/cs47l24-tables.c
 create mode 100644 sound/soc/codecs/cs47l24.c
 create mode 100644 sound/soc/codecs/cs47l24.h

-- 
1.7.2.5


