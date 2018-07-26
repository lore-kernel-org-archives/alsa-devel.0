From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/3] ASoC: meson-axg: fifo and card fixup
Date: Thu, 26 Jul 2018 14:45:41 +0200
Message-ID: <20180726124544.14740-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The purpose of this patchset is to solve the problems which have
been raised since the initial axg sound support has been accepted.

Jerome Brunet (3):
  ASoC: meson: use IRQ_RETVAL in the fifo irq handler
  ASoC: meson: update axg sound card bindings
  ASoC: meson: align axg card driver with DT bindings documentation

 .../bindings/sound/amlogic,axg-sound-card.txt | 68 +++++++++----------
 sound/soc/meson/axg-card.c                    | 12 ++--
 sound/soc/meson/axg-fifo.c                    |  2 +-
 3 files changed, 41 insertions(+), 41 deletions(-)

-- 
2.17.1
