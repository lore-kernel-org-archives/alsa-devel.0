From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v6 00/17] Add support for Cirrus Logic
	CS47L35/L85/L90/L91 codecs
Date: Thu, 23 Nov 2017 17:12:59 +0000
Message-ID: <20171123171316.10868-1-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id CD4E2267332
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 18:13:24 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The Cirrus Logic CS47L35, CS47L85, CS47L90/91 codecs are complex audio SoC
devices. In addition to the core audio capability they have onboard GPIO,
regulators, DSPs and interrupt controller and a large register map space
accessed over SPI or I2C. This family of codecs is based around common IP
blocks and they are managed by a set of common drivers referred to as "Madera".

Patches still waiting for review/ack:
#8 regulator
#9 irqchip
#14-17 ASoC


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
 drivers/irqchip/irq-madera.c                       |  301 ++
 drivers/mfd/Kconfig                                |   48 +
 drivers/mfd/Makefile                               |   13 +
 drivers/mfd/cs47l35-tables.c                       | 1610 +++++++
 drivers/mfd/cs47l85-tables.c                       | 3010 +++++++++++++
 drivers/mfd/cs47l90-tables.c                       | 2675 ++++++++++++
 drivers/mfd/madera-core.c                          |  599 +++
 drivers/mfd/madera-i2c.c                           |  140 +
 drivers/mfd/madera-spi.c                           |  139 +
 drivers/mfd/madera.h                               |   44 +
 drivers/pinctrl/Kconfig                            |    1 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/cirrus/Kconfig                     |   15 +
 drivers/pinctrl/cirrus/Makefile                    |   11 +
 drivers/pinctrl/cirrus/pinctrl-cs47l35.c           |   46 +
 drivers/pinctrl/cirrus/pinctrl-cs47l85.c           |   60 +
 drivers/pinctrl/cirrus/pinctrl-cs47l90.c           |   58 +
 drivers/pinctrl/cirrus/pinctrl-madera.c            | 1074 +++++
 drivers/pinctrl/cirrus/pinctrl-madera.h            |   40 +
 drivers/regulator/Kconfig                          |   15 +-
 drivers/regulator/arizona-ldo1.c                   |   82 +-
 drivers/regulator/arizona-micsupp.c                |   71 +-
 include/dt-bindings/sound/madera.h                 |   27 +
 include/linux/irqchip/irq-madera-pdata.h           |   23 +
 include/linux/irqchip/irq-madera.h                 |   98 +
 include/linux/mfd/madera/core.h                    |  196 +
 include/linux/mfd/madera/pdata.h                   |   61 +
 include/linux/mfd/madera/registers.h               | 3987 ++++++++++++++++++
 include/sound/madera-pdata.h                       |   61 +
 sound/soc/codecs/Kconfig                           |   23 +
 sound/soc/codecs/Makefile                          |    8 +
 sound/soc/codecs/cs47l35.c                         | 1748 ++++++++
 sound/soc/codecs/cs47l85.c                         | 2722 ++++++++++++
 sound/soc/codecs/cs47l90.c                         | 2661 ++++++++++++
 sound/soc/codecs/madera.c                          | 4439 ++++++++++++++++++++
 sound/soc/codecs/madera.h                          |  470 +++
 46 files changed, 27068 insertions(+), 10 deletions(-)
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
2.11.0
