From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/5] ASoC: es7134: driver updates
Date: Fri, 29 Jun 2018 17:09:19 +0200
Message-ID: <20180629150924.18197-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patchset provides several updates for the es7134 driver
It removes unsupported sample rates, add runtime check of the mclk-fs
ratio as documented in the datasheet and adds the component power
supplies.

Finally support for the es7154 is added.

Jerome Brunet (5):
  ASoC: es7134: remove 64kHz rate from the supported rates
  ASoC: es7134: check if mclk rate is valid
  ASoC: es7134: update DT binding with new compatible and supplies
  ASoC: es7134: Add VDD and AVDD power supplies
  ASoC: es7134: add support for the es7154

 .../devicetree/bindings/sound/everest,es7134.txt   |   8 +-
 sound/soc/codecs/es7134.c                          | 176 ++++++++++++++++++++-
 2 files changed, 179 insertions(+), 5 deletions(-)

-- 
2.14.4
