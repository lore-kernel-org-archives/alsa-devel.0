From: Kevin Cernekee <cernekee@chromium.org>
Subject: [PATCH V4 0/5] tas571x amplifier driver
Date: Tue,  5 May 2015 15:14:12 -0700
Message-ID: <1430864057-3848-1-git-send-email-cernekee@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: lars@metafoo.de, dgreid@chromium.org, abrestic@chromium.org, olofj@chromium.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

V3->V4:

Eliminate unnecessary dev->of_node NULL check.

Move the "should I sync this register?" test into a common helper function.

Clear map->no_sync_defaults at the end of the regcache_sync functions.


Kevin Cernekee (5):
  regmap: Add a helper function for regcache sync test
  regmap: Use regcache_mark_dirty() to indicate power loss or reset
  ASoC: tas571x: Add DT binding document
  ASoC: tas571x: New driver for TI TAS571x power amplifiers
  MAINTAINERS: Add entry for tas571x ASoC codec driver

 .../devicetree/bindings/sound/tas571x.txt          |  41 ++
 MAINTAINERS                                        |   6 +
 drivers/base/regmap/internal.h                     |   3 +
 drivers/base/regmap/regcache.c                     |  45 +-
 sound/soc/codecs/Kconfig                           |   5 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tas571x.c                         | 515 +++++++++++++++++++++
 sound/soc/codecs/tas571x.h                         |  33 ++
 8 files changed, 635 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tas571x.txt
 create mode 100644 sound/soc/codecs/tas571x.c
 create mode 100644 sound/soc/codecs/tas571x.h

-- 
2.2.0.rc0.207.ga3a616c
