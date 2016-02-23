From: Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/4 RESEND] Add I2S/ADV7511 audio support for ARC AXS10x boards
Date: Tue, 23 Feb 2016 13:51:10 +0000
Message-ID: <cover.1456234503.git.joabreu@synopsys.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: airlied-cv59FeDIM0c@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

ARC AXS10x platforms consist of a mainboard with several peripherals.
One of those peripherals is an HDMI output port controlled by ADV7511 transmitter.

This patch set adds audio for the ADV7511 transmitter and I2S audio for the
AXS10x platform.

Jose Abreu (4):
  [adv7511] Add audio support
  [adv7511] Update defconfigs so that audio is enabled
  [dwc] Add I2S HDMI audio support using custom platform driver
  [dwc] Update defconfigs so that I2S is enabled

 arch/arc/boot/dts/axs10x_mb.dtsi      |   20 +-
 arch/arc/configs/axs101_defconfig     |    4 +
 arch/arc/configs/axs103_defconfig     |    6 +
 arch/arc/configs/axs103_smp_defconfig |    6 +
 drivers/gpu/drm/i2c/Kconfig           |    8 +
 drivers/gpu/drm/i2c/Makefile          |    2 +
 drivers/gpu/drm/i2c/adv7511.c         | 1024 ---------------------------------
 drivers/gpu/drm/i2c/adv7511.h         |   41 ++
 drivers/gpu/drm/i2c/adv7511_audio.c   |  310 ++++++++++
 drivers/gpu/drm/i2c/adv7511_core.c    | 1005 ++++++++++++++++++++++++++++++++
 include/sound/soc-dai.h               |    1 +
 sound/soc/dwc/Kconfig                 |    1 +
 sound/soc/dwc/Makefile                |    4 +-
 sound/soc/dwc/designware_i2s.c        |  139 ++++-
 sound/soc/dwc/designware_pcm.c        |  264 +++++++++
 sound/soc/dwc/designware_pcm.h        |   21 +
 16 files changed, 1813 insertions(+), 1043 deletions(-)
 delete mode 100644 drivers/gpu/drm/i2c/adv7511.c
 create mode 100644 drivers/gpu/drm/i2c/adv7511_audio.c
 create mode 100644 drivers/gpu/drm/i2c/adv7511_core.c
 create mode 100644 sound/soc/dwc/designware_pcm.c
 create mode 100644 sound/soc/dwc/designware_pcm.h

-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
