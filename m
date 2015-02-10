From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [RESEND PATCH 0/6] Add support for the WM8280 and WM8281
Date: Tue, 10 Feb 2015 11:18:24 +0000
Message-ID: <1423567110-4414-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-gpio@vger.kernel.org, linux.walleij@linaro.org, linux-kernel@vger.kernel.org, cw00.choi@samsung.com, broonie@kernel.org, rf@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This set of patches adds support for the WM8280 and WM8281
codecs to the Wolfson Arizona drivers.

Just another resend on this series, if it would expedite
the process I would be happy if we could just merge the MFD
patches then I can push the other patches through their
respective trees once that hits mainline, but at the moment
all the patches are gated by a build dependency on the MFD
patches.

Thanks,
Charles

Richard Fitzgerald (6):
  mfd: arizona: Add support for WM8280/WM8281
  Documentation: devicetree: arizona: Add bindings for WM8280
  regulator: arizona-micsupp: Add support for WM8280/WM8281
  gpio: arizona: Add support for WM8280/WM8281
  extcon: arizona: Add support for WM8280/WM8281
  ASoC: arizona: Add support for WM8280/WM8281

 Documentation/devicetree/bindings/mfd/arizona.txt |   15 +++++++++++----
 drivers/extcon/extcon-arizona.c                   |    1 +
 drivers/gpio/gpio-arizona.c                       |    1 +
 drivers/mfd/Kconfig                               |    5 +++--
 drivers/mfd/arizona-core.c                        |   15 +++++++++++++--
 drivers/mfd/arizona-i2c.c                         |    2 ++
 drivers/mfd/arizona-irq.c                         |    1 +
 drivers/mfd/arizona-spi.c                         |    2 ++
 drivers/regulator/arizona-micsupp.c               |    1 +
 include/linux/mfd/arizona/core.h                  |    1 +
 sound/soc/codecs/arizona.c                        |    2 ++
 11 files changed, 38 insertions(+), 8 deletions(-)

-- 
1.7.2.5
