From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/5] ASoC: meson: add hdmitx glue support
Date: Wed, 15 May 2019 15:18:53 +0200
Message-ID: <20190515131858.32130-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On the Amlogic SoC, there is a glue between the SoC audio outputs and the
input of the embedded Synopsys HDMI controller.

On the g12a, this glue is mostly a couple of muxes to select the i2s and
spdif inputs of the hdmi controller. Each of these inputs may have
different hw_params and fmt which makes our life a little bit more
interesting, especially when switching between to active inputs.

This glue is modeled as codec driver and uses codec-to-codec links to
connect to the Synopsys controller. This allows to use the regular
hdmi-codec driver (used by dw-hdmi i2s).

To avoid glitches while switching input, the trick is to temporarily
force a disconnection of the mux output, which shutdowns the output dai
link. This also ensure that the stream parameters and fmt are updated
when the output is connected back.

Jerome Brunet (5):
  ASoC: meson: axg-card: set link name based on link node name
  ASoC: dapm: allow muxes to force a disconnect
  ASoC: meson: add tohdmitx DT bindings
  ASoC: meson: axg-card: add basic codec-to-codec link support
  ASoC: meson: add g12a tohdmitx control

 .../bindings/sound/amlogic,g12a-tohdmitx.txt  |  55 +++
 .../dt-bindings/sound/meson-g12a-tohdmitx.h   |  13 +
 sound/soc/meson/Kconfig                       |   8 +
 sound/soc/meson/Makefile                      |   2 +
 sound/soc/meson/axg-card.c                    |  31 +-
 sound/soc/meson/g12a-tohdmitx.c               | 413 ++++++++++++++++++
 sound/soc/soc-dapm.c                          |   2 +-
 7 files changed, 518 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,g12a-tohdmitx.txt
 create mode 100644 include/dt-bindings/sound/meson-g12a-tohdmitx.h
 create mode 100644 sound/soc/meson/g12a-tohdmitx.c

-- 
2.20.1
