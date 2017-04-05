From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 00/16] Add support for Cirrus Logic
	CS47L35/L85/L90/L91 codecs
Date: Wed, 5 Apr 2017 11:07:48 +0100
Message-ID: <1491386884-30689-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 13E8E2668F6
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 12:08:07 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linus.walleij@linaro.org, gnurou@gmail.com, robh+dt@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, lee.jones@linaro.org, broonie@kernel.org
Cc: linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The Cirrus Logic CS47L35, CS47L85, CS47L90/91 codecs are complex audio SoC
devices. In addition to the core audio capability they have onboard GPIO,
regulators, DSPs and interrupt controller and a large register map space
accessed over SPI or I2C. This family of codecs is based around common IP
blocks and they are managed by a set of common drivers referred to as "Madera".

Mayuresh Kulkarni (1):
  ASoC: wm_adsp: add support for DSP region lock

Richard Fitzgerald (15):
  mfd: madera: Add register definitions for Cirrus Logic Madera codecs
  mfd: madera: Add common support for Cirrus Logic Madera codecs
  mfd: madera: Register map tables for Cirrus Logic CS47L35
  mfd: madera: Register map tables for Cirrus Logic CS47L85
  mfd: madera: Register map tables for Cirrus Logic CS47L90/91
  regulator: madera-ldo1: LDO1 driver for Cirrus Logic Madera codecs
  regulator: madera-micsupp: Mic supply for Cirrus Logic Madera codecs
  irqchip: Add driver for Cirrus Logic Madera codecs
  pinctrl: madera: Add driver for Cirrus Logic Madera codecs
  gpio: madera: Support Cirrus Logic Madera class codecs
  ASoC: wm_adsp: Add support for ADSP2V2
  ASoC: madera: Add common support for Cirrus Logic Madera codecs
  ASoC: cs47l35: Add codec driver for Cirrus Logic CS47L35
  ASoC: cs47l85: Add codec driver for Cirrus Logic CS47L85
  ASoC: cs47l90: Add codec driver for Cirrus Logic CS47L90

 .../devicetree/bindings/gpio/gpio-madera.txt       |   24 +
 .../interrupt-controller/cirrus,madera.txt         |   31 +
 Documentation/devicetree/bindings/mfd/madera.txt   |   79 +
 .../bindings/pinctrl/cirrus,madera-pinctrl.txt     |  103 +
 .../devicetree/bindings/regulator/madera-ldo1.txt  |   29 +
 .../bindings/regulator/madera-micsupp.txt          |   27 +
 Documentation/devicetree/bindings/sound/madera.txt |   63 +
 MAINTAINERS                                        |   28 +
 drivers/gpio/Kconfig                               |    6 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-madera.c                         |  173 +
 drivers/irqchip/Kconfig                            |    5 +
 drivers/irqchip/Makefile                           |    1 +
 drivers/irqchip/irq-madera.c                       |  349 +
 drivers/mfd/Kconfig                                |   41 +
 drivers/mfd/Makefile                               |   13 +
 drivers/mfd/cs47l35-tables.c                       | 1688 ++++
 drivers/mfd/cs47l85-tables.c                       | 3169 +++++++
 drivers/mfd/cs47l90-tables.c                       | 2830 +++++++
 drivers/mfd/madera-core.c                          |  689 ++
 drivers/mfd/madera-i2c.c                           |  130 +
 drivers/mfd/madera-spi.c                           |  131 +
 drivers/mfd/madera.h                               |   52 +
 drivers/pinctrl/Kconfig                            |   22 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/pinctrl-madera.c                   | 1092 +++
 drivers/regulator/Kconfig                          |   16 +
 drivers/regulator/Makefile                         |    2 +
 drivers/regulator/madera-ldo1.c                    |  198 +
 drivers/regulator/madera-micsupp.c                 |  260 +
 include/dt-bindings/sound/madera.h                 |   18 +
 include/linux/irqchip/irq-madera-pdata.h           |   19 +
 include/linux/irqchip/irq-madera.h                 |   96 +
 include/linux/mfd/madera/core.h                    |  175 +
 include/linux/mfd/madera/pdata.h                   |   88 +
 include/linux/mfd/madera/registers.h               | 8832 ++++++++++++++++++++
 include/linux/regulator/madera-ldo1.h              |   24 +
 include/linux/regulator/madera-micsupp.h           |   21 +
 include/sound/madera-pdata.h                       |   70 +
 sound/soc/codecs/Kconfig                           |   23 +
 sound/soc/codecs/Makefile                          |    8 +
 sound/soc/codecs/cs47l35.c                         | 1747 ++++
 sound/soc/codecs/cs47l85.c                         | 2706 ++++++
 sound/soc/codecs/cs47l90.c                         | 2645 ++++++
 sound/soc/codecs/madera.c                          | 4430 ++++++++++
 sound/soc/codecs/madera.h                          |  470 ++
 sound/soc/codecs/wm_adsp.c                         |  324 +-
 sound/soc/codecs/wm_adsp.h                         |   24 +
 48 files changed, 32930 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-madera.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/cirrus,madera.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/madera.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/madera-ldo1.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/madera-micsupp.txt
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
 create mode 100644 drivers/pinctrl/pinctrl-madera.c
 create mode 100644 drivers/regulator/madera-ldo1.c
 create mode 100644 drivers/regulator/madera-micsupp.c
 create mode 100644 include/dt-bindings/sound/madera.h
 create mode 100644 include/linux/irqchip/irq-madera-pdata.h
 create mode 100644 include/linux/irqchip/irq-madera.h
 create mode 100644 include/linux/mfd/madera/core.h
 create mode 100644 include/linux/mfd/madera/pdata.h
 create mode 100644 include/linux/mfd/madera/registers.h
 create mode 100644 include/linux/regulator/madera-ldo1.h
 create mode 100644 include/linux/regulator/madera-micsupp.h
 create mode 100644 include/sound/madera-pdata.h
 create mode 100644 sound/soc/codecs/cs47l35.c
 create mode 100644 sound/soc/codecs/cs47l85.c
 create mode 100644 sound/soc/codecs/cs47l90.c
 create mode 100644 sound/soc/codecs/madera.c
 create mode 100644 sound/soc/codecs/madera.h

-- 
1.9.1
