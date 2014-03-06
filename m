From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 0/2] add support for SPI control mode to tlv320aic23
Date: Thu,  6 Mar 2014 14:04:40 +0400
Message-ID: <1394100282-27404-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Max Filippov <jcmvbkbc@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this series splits I2C-specific part of tlv320aic23 codec driver into a
separate file and adds SPI control mode support. It also updates Kconfigs
of existing tlv320aic23 users so that I2C variant is selected.

Changes v1->v2:
- split i2c interface into separate file;
- implement spi interface in a separate file;
- update Kconfigs of existing users.

Max Filippov (2):
  ASoC: tlv320aic23: add support for SPI control mode
  ASoC: update Kconfig of AIC23 users to select I2C variant

 sound/soc/atmel/Kconfig            |  2 +-
 sound/soc/cirrus/Kconfig           |  2 +-
 sound/soc/codecs/Kconfig           | 11 ++++++-
 sound/soc/codecs/Makefile          |  4 +++
 sound/soc/codecs/tlv320aic23-i2c.c | 59 ++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320aic23-spi.c | 57 ++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/tlv320aic23.c     | 55 +++++++----------------------------
 sound/soc/codecs/tlv320aic23.h     |  6 ++++
 sound/soc/fsl/Kconfig              |  2 +-
 sound/soc/omap/Kconfig             |  4 +--
 sound/soc/samsung/Kconfig          |  2 +-
 sound/soc/tegra/Kconfig            |  2 +-
 12 files changed, 154 insertions(+), 52 deletions(-)
 create mode 100644 sound/soc/codecs/tlv320aic23-i2c.c
 create mode 100644 sound/soc/codecs/tlv320aic23-spi.c

-- 
1.8.1.4
