From: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH v3 0/8] Add support for Wolfson WM8998 and WM1814 codecs
Date: Fri,  1 May 2015 16:15:11 +0100
Message-ID: <1430493319-23808-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
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
 sound/soc/codecs/wm8998.c                         | 1406 ++++++++++++++++++
 sound/soc/codecs/wm8998.h                         |   23 +
 20 files changed, 3454 insertions(+), 32 deletions(-)
 create mode 100644 drivers/mfd/wm8998-tables.c
 create mode 100644 sound/soc/codecs/wm8998.c
 create mode 100644 sound/soc/codecs/wm8998.h

-- 
1.7.2.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
