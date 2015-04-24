From: Kevin Cernekee <cernekee@chromium.org>
Subject: [PATCH V2 0/4] tas571x amplifier driver
Date: Fri, 24 Apr 2015 15:36:44 -0700
Message-ID: <1429915008-22015-1-git-send-email-cernekee@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: lars@metafoo.de, dgreid@chromium.org, abrestic@chromium.org, olofj@chromium.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

V1->V2:

 - Incorporate changes from review feedback

 - Change GPIOs to active low

 - Create a tas571x_chip struct to capture the growing list of differences
   between 5711 and 5717/5719

 - Add register defaults for each chip

 - Extend regcache_sync_region() to allow it to sync with hardware registers
   that don't contain their power-on-reset values


Kevin Cernekee (4):
  regmap: cache: Add "was_reset" argument to regcache_sync_region()
  ASoC: tas571x: Add DT binding document
  ASoC: tas571x: New driver for TI TAS571x power amplifiers
  MAINTAINERS: Add entry for tas571x ASoC codec driver

 .../devicetree/bindings/sound/tas571x.txt          |  41 ++
 MAINTAINERS                                        |   6 +
 drivers/base/regmap/internal.h                     |   5 +-
 drivers/base/regmap/regcache-lzo.c                 |   2 +-
 drivers/base/regmap/regcache-rbtree.c              |   5 +-
 drivers/base/regmap/regcache.c                     |  75 +--
 drivers/media/radio/radio-si476x.c                 |  18 +-
 drivers/mfd/wm8994-core.c                          |   5 +-
 include/linux/regmap.h                             |   4 +-
 include/sound/hda_regmap.h                         |   3 +-
 sound/soc/codecs/Kconfig                           |   5 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tas571x.c                         | 521 +++++++++++++++++++++
 sound/soc/codecs/tas571x.h                         |  33 ++
 sound/soc/codecs/wm8962.c                          |   3 +-
 15 files changed, 680 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tas571x.txt
 create mode 100644 sound/soc/codecs/tas571x.c
 create mode 100644 sound/soc/codecs/tas571x.h

-- 
2.2.0.rc0.207.ga3a616c
