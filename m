From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/2] ASoC: add sound-name-prefix property
Date: Fri, 13 Jul 2018 14:50:41 +0200
Message-ID: <20180713125043.13242-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patchset add support in ASoC to pick up name prefix from the
component nodes when the component does not match the configuration
table provided to the card.

The need for this feature came from the platform I'm working on
(Amlogic A113). On this platform, the card is made of several instances
of each components. It relies heavily on prefixes to describe the
routing between these components.

The proposed solution benefits every other DT based sound cards, such as
the simple card family. It allows to express the routing easily even when
the card uses several instances of the same component, or different
components with the same sink/source names (Playback, Capture,
Output, etc ...)

Jerome Brunet (2):
  ASoC: add DT documentation for the sound-name-prefix property
  ASoC: allow soc-core to pick up name prefixes from component nodes

 .../devicetree/bindings/sound/name-prefix.txt      | 24 +++++++++++++++++++
 sound/soc/soc-core.c                               | 28 ++++++++++++++++++----
 2 files changed, 47 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/name-prefix.txt

-- 
2.14.4
