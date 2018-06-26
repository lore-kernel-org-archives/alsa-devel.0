From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/2] ASoC: add tas5707 support
Date: Tue, 26 Jun 2018 19:40:54 +0200
Message-ID: <20180626174056.6400-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patchset extends the tas571x driver to support the tas5707
audio power amplifier.

Jerome Brunet (2):
  ASoC: tas571x: add tas5707 compatible
  ASoC: tas517x: add tas5707 support

 .../devicetree/bindings/sound/tas571x.txt          |   1 +
 sound/soc/codecs/Kconfig                           |   5 +-
 sound/soc/codecs/tas571x.c                         | 110 +++++++++++++++++++++
 sound/soc/codecs/tas571x.h                         |  16 +++
 4 files changed, 131 insertions(+), 1 deletion(-)

-- 
2.14.4
