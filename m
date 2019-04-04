From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/6] ASoC: meson: add g12a SoC family support
Date: Thu,  4 Apr 2019 13:17:27 +0200
Message-ID: <20190404111733.28705-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Maxime Jourdan <mjourdan@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The Amlogic g12a SoC family audio subsystem derives from the one found
in the axg SoC family.

To add support for the g12a in the existing elements, this patchset deals
with following differences compared to the axg family:
 * fifos must set an initial start address within the buffer.
   The fifo pointer shall be reset to this address on startup.
 * frddrs may now play on up to 3 output interfaces simultaneously.
 * tdmout formatters need a different signal skew offset.

Jerome Brunet (6):
  ASoC: meson: add g12a compatibles
  ASoC: meson: axg-fifo: add g12a support
  ASoC: meson: axg-toddr: add g12a support
  ASoC: meson: axg-frddr: add g12a support
  ASoC: meson: axg-tdm-formatter: rework quirks settings
  ASoC: meson: axg-tdmout: add g12a support

 .../bindings/sound/amlogic,axg-fifo.txt       |   4 +-
 .../bindings/sound/amlogic,axg-pdm.txt        |   3 +-
 .../bindings/sound/amlogic,axg-spdifin.txt    |   3 +-
 .../bindings/sound/amlogic,axg-spdifout.txt   |   3 +-
 .../sound/amlogic,axg-tdm-formatters.txt      |   4 +-
 sound/soc/meson/axg-fifo.c                    |  34 ++++-
 sound/soc/meson/axg-fifo.h                    |   2 +
 sound/soc/meson/axg-frddr.c                   | 143 +++++++++++++++++-
 sound/soc/meson/axg-tdm-formatter.c           |   6 +-
 sound/soc/meson/axg-tdm-formatter.h           |  11 +-
 sound/soc/meson/axg-tdmin.c                   |  16 +-
 sound/soc/meson/axg-tdmout.c                  |  29 +++-
 sound/soc/meson/axg-toddr.c                   |  53 +++++++
 13 files changed, 286 insertions(+), 25 deletions(-)

-- 
2.20.1
