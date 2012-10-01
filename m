From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.7
Date: Mon, 1 Oct 2012 11:26:13 +0100
Message-ID: <20121001102613.GF4360@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ED8C12615F0
 for <alsa-devel@alsa-project.org>; Mon,  1 Oct 2012 12:31:44 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit ddfb43f3881edb47aa0083651ad31983cdc42c33:

  Merge tag 'v3.6-rc6' into for-3.7 (2012-09-22 11:26:27 -0400)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.7

for you to fetch changes up to 9911f7f7562a25381eff93fdc660a4a3b4c0f6e0:

  ASoC: codecs: Add DA9055 codec driver (2012-09-28 14:21:54 +0100)

----------------------------------------------------------------
ASoC: Additional updates for v3.7

A couple more updates for 3.7, enhancements to the ux500 and wm2000
drivers, a new driver for DA9055 and the support for regulator bypass
mode.  With the exception of the DA9055 this has all had a chance to
soak in -next (the driver was added on Friday so should be in -next
today).

----------------------------------------------------------------
Ashish Chavan (1):
      ASoC: codecs: Add DA9055 codec driver

Charles Keepax (1):
      ASoC: wm5110: Adding missing volume update bits

Daniel Mack (1):
      ALSA: ASoC: add DT bindings for CS4271

Fabio Estevam (2):
      ASoC: cs4270: Remove mono support
      ASoC: eukrea-tlv320: Convert it to platform driver

Lee Jones (7):
      ASoC: Ux500: Move MSP pinctrl setup into the MSP driver
      ASoC: Ux500: Enable MOP500 driver for Device Tree
      ASoC: Ux500: Enable ux500 MSP driver for Device Tree
      ASoC: codecs: Enable AB8500 CODEC for Device Tree
      ASoC: Ux500: Minor coding layout changes
      Documentation: Define the MOP500 Audio Machine Driver Device Tree bindings
      Documentation: Define the MSP Driver Device Tree bindings

Mark Brown (22):
      regulator: core: Support bypass mode
      regulator: core: Provide regmap get/set bypass operations
      regulator: arizona-ldo: Support get/set bypass
      regulator: arizona-micsupp: Support get/set bypass
      regulator: wm831x-ldo: Add bypass support
      extcon: arizona: Use bypass mode for MICVDD
      ASoC: wm2000: Convert to devm_regmap_init_i2c()
      ASoC: wm2000: Add regulator support
      Merge remote-tracking branch 'asoc/topic/ux500' into for-3.7
      Merge tag 'bypass' of git://git.kernel.org/.../broonie/regulator into for-3.7
      ASoC: dapm: Allow regulators to bypass as well as disable when idle
      ASoC: wm5102: Enable bypass mode for MICVDD
      ASoC: wm5110: Enable bypass mode for MICVDD
      ASoC: wm0010: Allow slow GPIO for reset
      ASoC: wm0010: Don't check if reset GPIO is defined when removing
      ASoC: wm0010: Initialise chip state before we register the interrupt
      ASoC: arizona: Add more DSP options for mixer input muxes
      ASoC: arizona: Add more clock rates
      ASoC: wm5110: Rename EPOUT to HPOUT3
      ASoC: wm5110: Add AEC loopback support
      ASoC: wm5110: Add OUT3R support
      ASoC: wm_hubs: Ensure volume updates are handled during class W startup

 Documentation/ABI/testing/sysfs-class-regulator    |   21 +
 Documentation/devicetree/bindings/sound/cs4271.txt |   36 +
 .../devicetree/bindings/sound/ux500-mop500.txt     |   39 +
 .../devicetree/bindings/sound/ux500-msp.txt        |   43 +
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c       |    1 +
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c     |    1 +
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c     |    1 +
 arch/arm/mach-imx/eukrea_mbimxsd51-baseboard.c     |    1 +
 arch/arm/mach-ux500/board-mop500-msp.c             |   79 +-
 arch/arm/mach-ux500/include/mach/msp.h             |    2 -
 drivers/extcon/extcon-arizona.c                    |    5 +
 drivers/regulator/arizona-ldo1.c                   |    4 +
 drivers/regulator/arizona-micsupp.c                |    5 +
 drivers/regulator/core.c                           |  126 ++
 drivers/regulator/wm831x-ldo.c                     |    8 +
 include/linux/mfd/abx500/ab8500-codec.h            |    6 +-
 include/linux/regulator/consumer.h                 |    8 +
 include/linux/regulator/driver.h                   |   14 +
 include/linux/regulator/machine.h                  |    2 +
 include/sound/da9055.h                             |   33 +
 include/sound/soc-dapm.h                           |    3 +
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/ab8500-codec.c                    |   81 ++
 sound/soc/codecs/arizona.c                         |   42 +
 sound/soc/codecs/arizona.h                         |    2 +-
 sound/soc/codecs/cs4270.c                          |    4 +-
 sound/soc/codecs/cs4271.c                          |   24 +-
 sound/soc/codecs/da9055.c                          | 1510 ++++++++++++++++++++
 sound/soc/codecs/wm0010.c                          |   18 +-
 sound/soc/codecs/wm2000.c                          |   60 +-
 sound/soc/codecs/wm5102.c                          |    2 +-
 sound/soc/codecs/wm5110.c                          |   79 +-
 sound/soc/codecs/wm_hubs.c                         |    5 +
 sound/soc/fsl/eukrea-tlv320.c                      |   37 +-
 sound/soc/soc-dapm.c                               |   23 +-
 sound/soc/ux500/mop500.c                           |   47 +-
 sound/soc/ux500/ux500_msp_dai.c                    |    6 +
 sound/soc/ux500/ux500_msp_i2s.c                    |   89 +-
 sound/soc/ux500/ux500_msp_i2s.h                    |    8 +-
 40 files changed, 2307 insertions(+), 174 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cs4271.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ux500-mop500.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ux500-msp.txt
 create mode 100644 include/sound/da9055.h
 create mode 100644 sound/soc/codecs/da9055.c
