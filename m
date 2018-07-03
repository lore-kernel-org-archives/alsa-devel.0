From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 0/3] ASoC: es7134: driver updates
Date: Tue,  3 Jul 2018 17:05:57 +0200
Message-ID: <20180703150600.17697-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patchset fixes issues of v1 [0] around power supply requirement
and add es7154 support.

AVDD is renamed to PVDD to better match the component datasheet.
v1 assumed optional power supplies, which was a wrong thing do.
Now VDD, is required on all chip variant and PVDD is required on the
es7154.

[0]: https://lkml.kernel.org/r/20180629150924.18197-1-jbrunet@baylibre.com

Jerome Brunet (3):
  ASoC: es7134: update DT binding with new compatible and supplies
  ASoC: es7134: correct required power supplies
  ASoC: es7134: add support for the es7154

 .../devicetree/bindings/sound/everest,es7134.txt   |   7 +-
 sound/soc/codecs/es7134.c                          | 104 ++++++++++++++++++++-
 2 files changed, 106 insertions(+), 5 deletions(-)

-- 
2.14.4
