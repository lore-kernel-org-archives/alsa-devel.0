From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v3 00/17] Add support for Cirrus Logic CS47L35/L85/L90/L91 codecs
Date: Fri, 2 Jun 2017 16:02:53 +0100
Message-ID: <1496415790-19164-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The Cirrus Logic CS47L35, CS47L85, CS47L90/91 codecs are complex audio SoC
devices. In addition to the core audio capability they have onboard GPIO,
regulators, DSPs and interrupt controller and a large register map space
accessed over SPI or I2C. This family of codecs is based around common IP
blocks and they are managed by a set of common drivers referred to as "Madera".

Summary of main changes since V1:
- Removed child DT nodes and of_compatibles to make the DT flat
- Fixed review comments on irqchip driver
- Used new field names for IRQ1_STATUS_33 register
- Moved the gpio driver bindings into the main MFD binding doc
- Some code improvements to the pinctrl driver

Richard Fitzgerald (17):
  mfd: madera: Add register definitions for Cirrus Logic Madera codecs
  mfd: madera: Add DT bindings for Cirrus Logic Madera codecs
  mfd: madera: Add common support for Cirrus Logic Madera codecs
  mfd: madera: Register map tables for Cirrus Logic CS47L35
  mfd: madera: Register map tables for Cirrus Logic CS47L85
  mfd: madera: Register map tables for Cirrus Logic CS47L90/91
  regulator: arizona-micsupp: Add support for Cirrus Logic Madera codecs
  regulator: arizona-ldo1: Add support for Cirrus Logic Madera codecs
  irqchip: Add driver for Cirrus Logic Madera codecs
  pinctrl: madera: Add DT bindings for Cirrus Logic Madera codecs
  pinctrl: madera: Add driver for Cirrus Logic Madera codecs
  gpio: madera: Support Cirrus Logic Madera class codecs
  ASoC: madera: Add DT bindings for Cirrus Logic Madera codecs
  ASoC: madera: Add common support for Cirrus Logic Madera codecs
  ASoC: cs47l35: Add codec driver for Cirrus Logic CS47L35
  ASoC: cs47l85: Add codec driver for Cirrus Logic CS47L85
  ASoC: cs47l90: Add codec driver for Cirrus Logic CS47L90

 Documentation/devicetree/bindings/mfd/madera.txt   |  102 +
 .../bindings/pinctrl/cirrus,madera-pinctrl.txt     |   99 +
 .../bindings/regulator/arizona-regulator.txt       |    3 +-
 Documentation/devicetree/bindings/sound/madera.txt |   67 +
 MAINTAINERS                                        |   23 +
 drivers/gpio/Kconfig                               |    6 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-madera.c                         |  196 +
 drivers/irqchip/Kconfig                            |    3 +
 drivers/irqchip/Makefile                           |    1 +
 drivers/irqchip/irq-madera.c                       |  301 +
 drivers/mfd/Kconfig                                |   46 +
 drivers/mfd/Makefile                               |   13 +
 drivers/mfd/cs47l35-tables.c                       | 1688 ++++
 drivers/mfd/cs47l85-tables.c                       | 3169 +++++++
 drivers/mfd/cs47l90-tables.c                       | 2830 +++++++
 drivers/mfd/madera-core.c                          |  632 ++
 drivers/mfd/madera-i2c.c                           |  131 +
 drivers/mfd/madera-spi.c                           |  132 +
 drivers/mfd/madera.h                               |   52 +
 drivers/pinctrl/Kconfig                            |    1 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/cirrus/Kconfig                     |   15 +
 drivers/pinctrl/cirrus/Makefile                    |   11 +
 drivers/pinctrl/cirrus/pinctrl-cs47l35.c           |   46 +
 drivers/pinctrl/cirrus/pinctrl-cs47l85.c           |   60 +
 drivers/pinctrl/cirrus/pinctrl-cs47l90.c           |   58 +
 drivers/pinctrl/cirrus/pinctrl-madera.c            | 1074 +++
 drivers/pinctrl/cirrus/pinctrl-madera.h            |   40 +
 drivers/regulator/Kconfig                          |   15 +-
 drivers/regulator/arizona-ldo1.c                   |   82 +-
 drivers/regulator/arizona-micsupp.c                |   71 +-
 include/dt-bindings/sound/madera.h                 |   27 +
 include/linux/irqchip/irq-madera-pdata.h           |   23 +
 include/linux/irqchip/irq-madera.h                 |   96 +
 include/linux/mfd/madera/core.h                    |  180 +
 include/linux/mfd/madera/pdata.h                   |   61 +
 include/linux/mfd/madera/registers.h               | 8832 ++++++++++++++++++++
 include/sound/madera-pdata.h                       |   61 +
 sound/soc/codecs/Kconfig                           |   23 +
 sound/soc/codecs/Makefile                          |    8 +
 sound/soc/codecs/cs47l35.c                         | 1747 ++++
 sound/soc/codecs/cs47l85.c                         | 2706 ++++++
 sound/soc/codecs/cs47l90.c                         | 2645 ++++++
 sound/soc/codecs/madera.c                          | 4430 ++++++++++
 sound/soc/codecs/madera.h                          |  470 ++
 46 files changed, 32268 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/madera.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/sound/madera.txt
 create mode 100644 drivers/gpio/gpio-madera.c
 create mode 100644 drivers/irqchip/irq-madera.c
 create mode 100644 drivers/mfd/cs47l35-tables.c
 create mode 100644 drivers/mfd/cs47l85-tables.c
 create mode 100644 drivers/mfd/cs47l90-tables.c
 create mode 100644 drivers/mfd/madera-core.c
 create mode 100644 drivers/mfd/madera-i2c.c
 create mode 100644 drivers/mfd/madera-spi.c
 create mode 100644 drivers/mfd/madera.h
 create mode 100644 drivers/pinctrl/cirrus/Kconfig
 create mode 100644 drivers/pinctrl/cirrus/Makefile
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-cs47l35.c
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-cs47l85.c
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-cs47l90.c
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-madera.c
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-madera.h
 create mode 100644 include/dt-bindings/sound/madera.h
 create mode 100644 include/linux/irqchip/irq-madera-pdata.h
 create mode 100644 include/linux/irqchip/irq-madera.h
 create mode 100644 include/linux/mfd/madera/core.h
 create mode 100644 include/linux/mfd/madera/pdata.h
 create mode 100644 include/linux/mfd/madera/registers.h
 create mode 100644 include/sound/madera-pdata.h
 create mode 100644 sound/soc/codecs/cs47l35.c
 create mode 100644 sound/soc/codecs/cs47l85.c
 create mode 100644 sound/soc/codecs/cs47l90.c
 create mode 100644 sound/soc/codecs/madera.c
 create mode 100644 sound/soc/codecs/madera.h

-- 
1.9.1

