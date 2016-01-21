From: Jacob Siverskog <jacob@teenage.engineering>
Subject: [PATCH v3 0/3] ASoC: pcm179x: Add I2C support, declare support for continuous rates
Date: Thu, 21 Jan 2016 16:26:55 +0100
Message-ID: <1453390018-16854-1-git-send-email-jacob@teenage.engineering>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Michael Trimarchi <michael@amarulasolutions.com>, Johan Hovold <johan@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jacob Siverskog <jacob@teenage.engineering>
List-Id: alsa-devel@alsa-project.org

This series add support for I2C and declares support for continuous
sample rates.

Please note that this has only been tested using I2C and PCM1791A. I'd
be grateful if someone can test it with other devices in the PCM179X
family and/or SPI.

These patches are against linux-next.

[V3]: Allocation of private data moved to common code.

[V2]: Fix build issues found by kbuild test robot by adding static
keyword and proper symbol exports.

Jacob Siverskog (3):
  ASoC: pcm179x: Split into core and SPI parts
  ASoC: pcm179x: Add I2C interface driver
  ASoC: pcm179x: Support continuous rates

 .../devicetree/bindings/sound/pcm179x.txt          | 11 +++-
 sound/soc/codecs/Kconfig                           | 20 ++++++-
 sound/soc/codecs/Makefile                          |  4 ++
 sound/soc/codecs/pcm179x-i2c.c                     | 64 ++++++++++++++++++++++
 sound/soc/codecs/pcm179x-spi.c                     | 63 +++++++++++++++++++++
 sound/soc/codecs/pcm179x.c                         | 61 +++++++--------------
 sound/soc/codecs/pcm179x.h                         |  9 +--
 7 files changed, 184 insertions(+), 48 deletions(-)
 create mode 100644 sound/soc/codecs/pcm179x-i2c.c
 create mode 100644 sound/soc/codecs/pcm179x-spi.c

-- 
2.7.0
