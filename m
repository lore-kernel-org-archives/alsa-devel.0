From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 0/8] da9055: Driver initialisation fixes,
	add DT support
Date: Wed, 5 Feb 2014 17:48:28 +0000
Message-ID: <cover.1391614923.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DC66265007
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 18:48:34 +0100 (CET)
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
   PMIC (MFD) and CODEC drivers.
 - Add initial DT support for DA9055 related drivers, including binding
   documentation.
 - Remove conflicting use of platform_get_irq_byname() in driver probes.
 - Remove unnecessary resource structures for MFD cells as a result of removing
   use of platform_get_irq_byname().

Adam Thomson (8):
  ASoC: da9055: Fix device registration of PMIC and CODEC devices
  ASoC: da9055: Add DT support for CODEC
  mfd: da9055: Add DT support for PMIC
  regulator: da9055: Add DT support
  onkey: da9055: Remove use of platform_get_irq_byname()
  hwmon: da9055: Remove use of platform_get_irq_byname()
  rtc: da9055: Remove use of platform_get_irq_byname()
  mfd: da9055: Remove unused resource structures for mfd cells.

 Documentation/devicetree/bindings/mfd/da9055.txt   |   73 ++++++++++++++++++++
 Documentation/devicetree/bindings/sound/da9055.txt |   22 ++++++
 drivers/hwmon/da9055-hwmon.c                       |    7 +--
 drivers/input/misc/da9055_onkey.c                  |    9 +--
 drivers/mfd/da9055-core.c                          |   46 ------------
 drivers/mfd/da9055-i2c.c                           |   20 +++++-
 drivers/regulator/da9055-regulator.c               |   59 ++++++++++++++--
 drivers/rtc/rtc-da9055.c                           |    3 +-
 sound/soc/codecs/da9055.c                          |   19 +++++-
 9 files changed, 188 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/da9055.txt
 create mode 100644 Documentation/devicetree/bindings/sound/da9055.txt
