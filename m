From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/4] ASoC: meson-axg: add pdm input support
Date: Wed, 29 Aug 2018 17:00:47 +0200
Message-ID: <20180829150051.18190-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The purpose of this patchset is to add the support for PDM input
backend found on the AXG SoC family.

The first 2 patches, for the dmic, are not specific to this amlogic
driver but it is useful to have them since the PDM input will use this
dmic codec.

Jerome Brunet (4):
  ASoC: dmic: add Kconfig prompt for the generic dmic codec.
  ASoC: dmic: add DT module alias
  ASoC: meson: add axg pdm input DT binding documentation
  ASoC: meson: add axg pdm input

 .../bindings/sound/amlogic,axg-pdm.txt        |  24 +
 sound/soc/codecs/Kconfig                      |   6 +-
 sound/soc/codecs/dmic.c                       |   1 +
 sound/soc/meson/Kconfig                       |   9 +
 sound/soc/meson/Makefile                      |   2 +
 sound/soc/meson/axg-pdm.c                     | 654 ++++++++++++++++++
 6 files changed, 695 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
 create mode 100644 sound/soc/meson/axg-pdm.c

-- 
2.17.1
