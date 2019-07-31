From: Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 0/2] ASoC: Add uda1334 codec driver
Date: Wed, 31 Jul 2019 14:19:28 +0300
Message-ID: <20190731111930.20230-1-andradanciu1997@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, ckeepax@opensource.cirrus.com, rf@opensource.wolfsonmicro.com, srinivas.kandagatla@linaro.org, piotrs@opensource.cirrus.com, paul@crapouillou.net, kmarinushkin@birdec.tech, anders.roxell@linaro.org, jbrunet@baylibre.com, m.felsch@pengutronix.de, vkoul@kernel.org, nh6z@nh6z.net, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, daniel.baluta@nxp.com
List-Id: alsa-devel@alsa-project.org

The first patch contains uda1334 documentation.
The second patch contains the codec driver.

Andra Danciu (2):
  dt-bindings: sound: Add bindings for UDA1334 codec
  ASoC: codecs: Add uda1334 codec driver

 .../devicetree/bindings/sound/uda1334.txt          |  17 ++
 sound/soc/codecs/Kconfig                           |   9 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/uda1334.c                         | 295 +++++++++++++++++++++
 4 files changed, 323 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/uda1334.txt
 create mode 100644 sound/soc/codecs/uda1334.c

-- 
2.11.0
