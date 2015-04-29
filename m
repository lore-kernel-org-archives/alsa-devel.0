From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v2 0/8] Add support for Wolfson WM8998 and WM1814 codecs
Date: Wed, 29 Apr 2015 15:37:01 +0100
Message-ID: <1430318229-28518-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, cw00.choi@samsung.com
Cc: myungjoo.ham@samsung.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This set of patches adds support for the Wolfson Microelectronics
WM8998 and WM1814 codecs.

Richard Fitzgerald (8):
  mfd: arizona: Split INx_MODE into two fields
  ASoC: arizona: add defines for single-input gain control
  mfd: arizona: Add support for WM8998 and WM1814
  gpio: arizona: add support for WM8998 and WM1814
  regulator: arizona: add support for WM8998 and WM1814
  extcon: arizona: Add support for WM8998 and WM1814
  ASoC: wm8998: Initial WM8998 codec driver
  Documentation: Add WM8998/WM1814 device tree bindings

 Documentation/devicetree/bindings/mfd/arizona.txt |   13 +-
 drivers/extcon/extcon-arizona.c                   |   33 +-
 drivers/gpio/gpio-arizona.c                       |    2 +
 drivers/mfd/Kconfig                               |    6 +
 drivers/mfd/Makefile                              |    3 +
 drivers/mfd/arizona-core.c                        |  105 ++-
 drivers/mfd/arizona-i2c.c                         |    8 +
 drivers/mfd/arizona-irq.c                         |    9 +
 drivers/mfd/arizona.h                             |    5 +
 drivers/mfd/wm8998-tables.c                       | 1592 +++++++++++++++++++++
 drivers/regulator/arizona-ldo1.c                  |    2 +
 include/linux/mfd/arizona/core.h                  |    3 +
 include/linux/mfd/arizona/pdata.h                 |    7 +-
 include/linux/mfd/arizona/registers.h             |  247 +++-
 sound/soc/codecs/Kconfig                          |    6 +
 sound/soc/codecs/Makefile                         |    2 +
 sound/soc/codecs/arizona.c                        |    7 +
 sound/soc/codecs/arizona.h                        |    7 +-
 sound/soc/codecs/wm8998.c                         | 1394 ++++++++++++++++++
 sound/soc/codecs/wm8998.h                         |   23 +
 20 files changed, 3442 insertions(+), 32 deletions(-)
 create mode 100644 drivers/mfd/wm8998-tables.c
 create mode 100644 sound/soc/codecs/wm8998.c
 create mode 100644 sound/soc/codecs/wm8998.h

-- 
1.7.2.5

