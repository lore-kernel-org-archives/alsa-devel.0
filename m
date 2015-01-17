From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [RESEND PATCH 0/6] Add support for the WM8280 and WM8281 codecs
Date: Sat, 17 Jan 2015 15:21:21 +0000
Message-ID: <1421508087-22311-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: broonie@kernel.org, cw00.choi@samsung.com, linus.walleij@linaro.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, rf@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This set of patches adds support for the WM8280 and WM8281
codecs to the Wolfson Arizona drivers.

I made one small correction to the first patch to removed a
potentially uninitialised variable, but otherwise just a
resend of Richard's work. I would suggest we put the whole
series through the MFD tree I believe we have all the required
Acks and I don't believe there arn't any other patches making
their way through at the moment that this should conflict with.

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

