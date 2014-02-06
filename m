From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v2 0/8] da9055: Driver initialisation fixes,
	add DT support
Date: Thu, 6 Feb 2014 18:03:04 +0000
Message-ID: <cover.1391705989.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.162])
 by alsa0.perex.cz (Postfix) with ESMTP id 77A1E26500C
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2014 19:03:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Alessandro Zummo <a.zummo@towertech.it>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

This patch series provides the following updates for DA9055 drivers:

 - Fixes an issue with da9055 driver initialisation (conflicting device ids) of
   PMIC (MFD) and CODEC drivers which means they cannot be used together on
   the same I2C bus.
 - Add initial DT support for DA9055 related drivers, including binding
   documentation.
 - Remove use of regmap_irq_get_virq() in driver probes which was conflicting
   with use of platform_get_irq_byname(). platform_get_irq_byname() already
   returns the VIRQ number due to MFD core translation so using
   regmap_irq_get_virq() on that returned value results in an incorrect IRQ
   being requested. The driver probes then fail because of this.

[Changes since v1]:

 - Regulator:
    * fixed coding style issue (lack of braces for if,else statement)
    * removal of 'ifdef' around DT related headers
    * Use of 'of_regulator_match()' for retrieving regulator related info
      from DT nodes.

 - General:
    * Instead of removing platform_get_irq_byname() usage and device resources
      to fix IRQ conflict in driver probes, now removed 'regmap_irq_get_virq()'
      as advised. This has been tested on target for both DT and non-DT setups
      and works as expected.

Adam Thomson (8):
  ASoC: da9055: Fix device registration of PMIC and CODEC devices
  ASoC: da9055: Add DT support for CODEC
  mfd: da9055: Add DT support for PMIC
  regulator: da9055: Add DT support
  onkey: da9055: Remove use of regmap_irq_get_virq()
  hwmon: da9055: Remove use of regmap_irq_get_virq()
  rtc: da9055: Remove use of regmap_irq_get_virq()
  regulator: da9055: Remove use of regmap_irq_get_virq()

 Documentation/devicetree/bindings/mfd/da9055.txt   |   73 ++++++++++++++++++++
 Documentation/devicetree/bindings/sound/da9055.txt |   22 ++++++
 drivers/hwmon/da9055-hwmon.c                       |    4 -
 drivers/input/misc/da9055_onkey.c                  |    1 -
 drivers/mfd/da9055-i2c.c                           |   20 +++++-
 drivers/regulator/da9055-regulator.c               |   73 ++++++++++++++++++--
 drivers/rtc/rtc-da9055.c                           |    4 +-
 sound/soc/codecs/da9055.c                          |   19 +++++-
 8 files changed, 201 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/da9055.txt
 create mode 100644 Documentation/devicetree/bindings/sound/da9055.txt
