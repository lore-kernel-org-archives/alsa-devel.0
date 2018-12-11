From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/4] ASoC: meson: add axg spdif input support
Date: Tue, 11 Dec 2018 14:47:09 +0100
Message-ID: <20181211134713.4908-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This patchset adds the initial support the spdif input found on the
axg SoC family.

The capture itself works well but the rate detection could be enhanced in
the future.

Like several other drivers of this type, no check is done to verify if the
rate of the input stream is consistent with the rate requested in
hw_params()

The automatic rate detection mechanism of this device and the related IRQ
proved difficult to work with, as documented in the driver. Several
approaches to work around this minor issue have been tried but none
provided a complete and reliable solution so far. Hopefully more eyes on
this will help figure this out.

Since I authored all Amlogic ASoC drivers (and the related bugs) merged
so far, I have added myself as maintainer of them in the last patch of this
series.

Jerome Brunet (4):
  ASoC: meson: axg-toddr: add support for spdifin backend
  ASoC: meson: add axg spdif input DT binding documentation
  ASoC: meson: add axg spdif input
  MAINTAINERS: Add Amlogic sound drivers entry

 .../bindings/sound/amlogic,axg-spdifin.txt    |  22 +
 MAINTAINERS                                   |   7 +
 sound/soc/meson/Kconfig                       |   9 +-
 sound/soc/meson/Makefile                      |   2 +
 sound/soc/meson/axg-fifo.h                    |   3 +-
 sound/soc/meson/axg-spdifin.c                 | 521 ++++++++++++++++++
 sound/soc/meson/axg-toddr.c                   |  15 +-
 7 files changed, 567 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
 create mode 100644 sound/soc/meson/axg-spdifin.c

-- 
2.19.2
