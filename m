From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 0/2] ASoC: add es7241 support
Date: Sat, 30 Jun 2018 19:22:39 +0200
Message-ID: <20180630172241.10806-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Add support for the es7241 which is a simple 2 channels analog to
digital converter.

Changes since v1: [0]
 * Add missing break as reported by smatch [1]
   My device is hardwired in slave mode, which probably why this slipped
   through unnoticed.

[0]: https://lkml.kernel.org/r/20180629152444.21525-1-jbrunet@baylibre.com
[1]: https://lkml.kernel.org/r/20180630082829.qwnhkk4f76n32omm@mwanda

Jerome Brunet (2):
  ASoC: es7241: add dt-bindings documentation for the es7241 adc
  ASoC: es7241: add es7241 codec support

 .../devicetree/bindings/sound/everest,es7241.txt   |  23 ++
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/es7241.c                          | 308 +++++++++++++++++++++
 4 files changed, 337 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es7241.txt
 create mode 100644 sound/soc/codecs/es7241.c

-- 
2.14.4
