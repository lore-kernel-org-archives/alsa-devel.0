From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: [PATCH 0/5 v4] Add I2S/ADV7511 audio support for ARC
	AXS10x boards
Date: Thu,  7 Apr 2016 17:53:54 +0100
Message-ID: <cover.1460047238.git.joabreu@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.synopsys.com (smtprelay.synopsys.com [198.182.47.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CC32264ED5
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 18:54:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, architt@codeaurora.org, airlied@linux.ie, Vineet.Gupta1@synopsys.com, Alexey.Brodkin@synopsys.com, CARLOS.PALMINHA@synopsys.com, lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

ARC AXS10x platforms consist of a mainboard with several peripherals.
One of those peripherals is an HDMI output port controlled by the ADV7511
transmitter.

This patch set adds audio for the ADV7511 transmitter and I2S audio for
the AXS10x platform.

Changes v3 -> v4:
* Reintroduced custom PCM driver (see note below)
* Use DT boolean to switch between ALSA DMA engine PCM or custom PCM
* Use fifo depth to program I2S FCR
* Update I2S documentation

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


NOTE:
Although the mainline I2S driver uses ALSA DMA engine,
this controller can be built without DMA support so it
was necessary to add this custom platform driver so that
HDMI audio works in AXS boards.

Jose Abreu (5):
  drm/i2c/adv7511: Rename and move to separate folder
  drm/i2c/adv7511: Add audio support
  ASoC: dwc: Use fifo depth to program FCR
  ASoC: dwc: Add custom PCM driver
  ASoC: dwc: Update DOCUMENTATION for I2S Driver

 .../bindings/display/bridge/adi,adv7511.txt        |   3 +
 .../devicetree/bindings/sound/designware-i2s.txt   |   5 +
 drivers/gpu/drm/i2c/Kconfig                        |   6 +-
 drivers/gpu/drm/i2c/Makefile                       |   2 +-
 drivers/gpu/drm/i2c/adv7511/Kconfig                |  18 ++
 drivers/gpu/drm/i2c/adv7511/Makefile               |   3 +
 drivers/gpu/drm/i2c/{ => adv7511}/adv7511.h        |  53 ++++
 drivers/gpu/drm/i2c/adv7511/adv7511_audio.c        | 310 +++++++++++++++++++++
 .../drm/i2c/{adv7511.c => adv7511/adv7511_core.c}  |  43 +--
 include/sound/soc-dai.h                            |   1 +
 sound/soc/dwc/Kconfig                              |   9 +
 sound/soc/dwc/Makefile                             |   1 +
 sound/soc/dwc/designware.h                         |  70 +++++
 sound/soc/dwc/designware_i2s.c                     | 106 +++++--
 sound/soc/dwc/designware_pcm.c                     | 230 +++++++++++++++
 15 files changed, 796 insertions(+), 64 deletions(-)
 create mode 100644 drivers/gpu/drm/i2c/adv7511/Kconfig
 create mode 100644 drivers/gpu/drm/i2c/adv7511/Makefile
 rename drivers/gpu/drm/i2c/{ => adv7511}/adv7511.h (90%)
 create mode 100644 drivers/gpu/drm/i2c/adv7511/adv7511_audio.c
 rename drivers/gpu/drm/i2c/{adv7511.c => adv7511/adv7511_core.c} (97%)
 create mode 100644 sound/soc/dwc/designware.h
 create mode 100644 sound/soc/dwc/designware_pcm.c

-- 
1.9.1
