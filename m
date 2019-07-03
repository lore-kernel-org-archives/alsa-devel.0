From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/2] ASoC: meson: axg-tdm-formatter: add g12a reset
Date: Wed,  3 Jul 2019 14:07:47 +0200
Message-ID: <20190703120749.32341-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This patchset add the possibility to provide a reset to the tdm formatter.
Such reset is available on the g12a SoC family and helps solve a random
channel output shift when using more than one output lane.

Jerome Brunet (2):
  ASoC: meson: axg-tdm-formatter: add reset to the bindings
    documentation
  ASoC: meson: axg-tdm-formatter: add reset

 .../sound/amlogic,axg-tdm-formatters.txt      |  6 +++-
 sound/soc/meson/axg-tdm-formatter.c           | 29 +++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.21.0
