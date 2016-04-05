From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: [PATCH 0/3 v3] Add I2S/ADV7511 audio support for ARC AXS10x boards
Date: Tue,  5 Apr 2016 18:07:59 +0100
Message-ID: <cover.1459875048.git.joabreu@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, CARLOS.PALMINHA@synopsys.com, Alexey.Brodkin@synopsys.com, Vineet.Gupta1@synopsys.com, architt@codeaurora.org, airlied@linux.ie, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, Jose Abreu <Jose.Abreu@synopsys.com>
List-Id: alsa-devel@alsa-project.org

ARC AXS10x platforms consist of a mainboard with several peripherals.
One of those peripherals is an HDMI output port controlled by the ADV7511
transmitter.

This patch set adds audio for the ADV7511 transmitter and I2S audio for
the AXS10x platform.

Changes v2 -> v3:
* Removed pll_config functions (as suggested by Alexey Brodkin)
* Removed HDMI start at adv7511_core (as suggested by Archit Taneja)
* Use NOP functions for adv7511_audio (as suggested by Archit Taneja)
* Added adv7511_audio_exit() function (as suggested by Archit Taneja)
* Moved adv7511 to its own folder (as suggested by Archit Taneja)
* Separated file rename of adv7511_core (as suggested by Emil Velikov)
* Compile adv7511 as module if ALSA SoC is compiled as module
* Load adv7511 audio only if declared in device tree (as suggested by Laurent Pinchart)
* Dropped custom platform driver, using now ALSA DMA engine
* Dropped IRQ handler for I2S

Changes v1 -> v2:
* DT bindings moved to separate patch (as suggested by Alexey Brodkin)
* Removed defconfigs entries (as suggested by Alexey Brodkin)

Jose Abreu (3):
  drm/i2c/adv7511: Rename and move to separate folder
  drm/i2c/adv7511: Add audio support
  ASoC: dwc: Unmask I2S interrupts only for enabled channels

 .../bindings/display/bridge/adi,adv7511.txt        |   3 +
 drivers/gpu/drm/i2c/Kconfig                        |   6 +-
 drivers/gpu/drm/i2c/Makefile                       |   2 +-
 drivers/gpu/drm/i2c/adv7511/Kconfig                |  18 ++
 drivers/gpu/drm/i2c/adv7511/Makefile               |   3 +
 drivers/gpu/drm/i2c/{ => adv7511}/adv7511.h        |  53 ++++
 drivers/gpu/drm/i2c/adv7511/adv7511_audio.c        | 310 +++++++++++++++++++++
 .../drm/i2c/{adv7511.c => adv7511/adv7511_core.c}  |  43 +--
 include/sound/soc-dai.h                            |   1 +
 sound/soc/dwc/designware_i2s.c                     |   5 +-
 10 files changed, 406 insertions(+), 38 deletions(-)
 create mode 100644 drivers/gpu/drm/i2c/adv7511/Kconfig
 create mode 100644 drivers/gpu/drm/i2c/adv7511/Makefile
 rename drivers/gpu/drm/i2c/{ => adv7511}/adv7511.h (90%)
 create mode 100644 drivers/gpu/drm/i2c/adv7511/adv7511_audio.c
 rename drivers/gpu/drm/i2c/{adv7511.c => adv7511/adv7511_core.c} (97%)

-- 
1.9.1
