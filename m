From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v3 0/5]  Add support for Cirrus Logic CS47L24 and WM1831 codecs
Date: Tue, 3 Nov 2015 15:08:31 +0000
Message-ID: <1446563316-28878-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: lee.jones@linaro.org, linus.walleij@linaro.org, broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

----
Changes since v2
MFD:
  - Make binding doc a separate patch, add updates to supply bindings
  - Fix review comments

ASoC::
  - Fix sort order in KConfig and Makefile

MAINTAINERS:
  - Add patch to update MAINTAINERS
----

mfd patch based on Lee Jones's for-next
gpio patch based on Linus Walleij's for-next
ASoC patch based on Mark Brown's for-next

Lee/Mark - can one of you take all three patches (with maintainer acks) so
that the patch set is kept together?

Richard Fitzgerald (5):
  mfd: arizona: Support Cirrus Logic CS47L24 and WM1831
  mfd: arizona: Update DT bindings to add CS47L24 and WM1831
  gpio: arizona: Support Cirrus Logic CS47L24 and WM1831
  ASoC: cs47l24: Add driver for Cirrus Logic CS47L24 and WM1831 codecs
  MAINTAINERS: Update Wolfson Micro section to include CS47L24 source

 Documentation/devicetree/bindings/mfd/arizona.txt |    9 +-
 MAINTAINERS                                       |    2 +
 drivers/gpio/gpio-arizona.c                       |    4 +
 drivers/mfd/Kconfig                               |   18 +-
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
 15 files changed, 2948 insertions(+), 26 deletions(-)
 create mode 100644 drivers/mfd/cs47l24-tables.c
 create mode 100644 sound/soc/codecs/cs47l24.c
 create mode 100644 sound/soc/codecs/cs47l24.h

-- 
1.9.1

