From: Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/2 v5] Add I2S/ADV7511 audio support for ARC AXS10x boards
Date: Tue, 12 Apr 2016 13:56:26 +0100
Message-ID: <cover.1460384521.git.joabreu@synopsys.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

This is v5 of these patches. In this version I dropped the ADV7511 audio patch
because, quoting Lars-Peter Clausen:
"The reason why this driver is still out of tree, is because there has been no
conclusion yet on how to go forward with the whole HDMI integration. So this
is not going to get merged until that issue has been addressed."

So, until that issue is addressed I will not send any ADV7511 audio related
patches but if for some reason anyone wants to merge it I can send the
pathes again. V4, which includes the ADV7511 audio patches is available at:
	http://mailman.alsa-project.org/pipermail/alsa-devel/2016-April/106650.html

Looking forward to your comments!

Best regards,
Jose Miguel Abreu

-----

ARC AXS10x platforms consist of a mainboard with several peripherals.
One of those peripherals is an HDMI output port controlled by the ADV7511
transmitter.

This patch set adds I2S audio for the AXS10x platform.

Changes v4 -> v5
* Resolve undefined references when compiling as module
* Dropped adv7511 audio patches
* Use DMA properties in I2S to check which mode to use: PIO or DMA (as suggested by Lars-Peter Clausen)

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

Jose Abreu (2):
  ASoC: dwc: Add custom PCM driver
  ASoC: dwc: Update DOCUMENTATION for I2S Driver

 .../devicetree/bindings/sound/designware-i2s.txt   |   9 +-
 sound/soc/dwc/Kconfig                              |   9 +
 sound/soc/dwc/Makefile                             |   1 +
 sound/soc/dwc/designware.h                         |  71 +++++++
 sound/soc/dwc/designware_i2s.c                     |  94 ++++++---
 sound/soc/dwc/designware_pcm.c                     | 230 +++++++++++++++++++++
 6 files changed, 385 insertions(+), 29 deletions(-)
 create mode 100644 sound/soc/dwc/designware.h
 create mode 100644 sound/soc/dwc/designware_pcm.c

-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
