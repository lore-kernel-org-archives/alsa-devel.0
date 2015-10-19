From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v2 0/3] Add support for Cirrus Logic CS47L24 and WM1831 codecs
Date: Mon, 19 Oct 2015 15:13:44 +0100
Message-ID: <1445264027-7357-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, linus.walleij@linaro.org, broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

mfd patch based on Lee Jones's for-next
gpio patch based on Linus Walleij's for-next
ASoC patch based on Mark Brown's for-next

Lee/Mark - can one of you take all three patches (with maintainer acks) so
that the patch set is kept together?

Richard Fitzgerald (3):
  mfd: arizona: Support Cirrus Logic CS47L24 and WM1831
  gpio: arizona: Support Cirrus Logic CS47L24 and WM1831
  ASoC: cs47l24: Add driver for Cirrus Logic CS47L24 and WM1831 codecs

 Documentation/devicetree/bindings/mfd/arizona.txt |    4 +-
 drivers/gpio/gpio-arizona.c                       |    4 +
 drivers/mfd/Kconfig                               |   19 +-
 drivers/mfd/Makefile                              |    3 +
 drivers/mfd/arizona-core.c                        |   74 +-
 drivers/mfd/arizona-irq.c                         |   40 +-
 drivers/mfd/arizona-spi.c                         |    7 +
 drivers/mfd/arizona.h                             |    4 +
 drivers/mfd/cs47l24-tables.c                      | 1629 +++++++++++++++++++++
 include/linux/mfd/arizona/core.h                  |    3 +
 sound/soc/codecs/Kconfig                          |    8 +
 sound/soc/codecs/Makefile                         |    2 +
 sound/soc/codecs/cs47l24.c                        | 1148 +++++++++++++++
 sound/soc/codecs/cs47l24.h                        |   23 +
 14 files changed, 2942 insertions(+), 26 deletions(-)
 create mode 100644 drivers/mfd/cs47l24-tables.c
 create mode 100644 sound/soc/codecs/cs47l24.c
 create mode 100644 sound/soc/codecs/cs47l24.h

-- 
1.9.1
