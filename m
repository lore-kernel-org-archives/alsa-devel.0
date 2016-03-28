From: Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/3 v2] Add I2S/ADV7511 audio support for ARC AXS10x boards
Date: Mon, 28 Mar 2016 15:36:08 +0100
Message-ID: <cover.1459174494.git.joabreu@synopsys.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: airlied-cv59FeDIM0c@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, ville.syrjala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, nariman-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, Maruthi.Bayyavarapu-5C7GfCeVMHo@public.gmane.org, buyitian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, yitian.bu-sf4bEIuTEZ8/jFmSBShxMA@public.gmane.org, Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

ARC AXS10x platforms consist of a mainboard with several peripherals.
One of those peripherals is an HDMI output port controlled by the ADV7511
transmitter.

This patch set adds audio for the ADV7511 transmitter and I2S audio for
the AXS10x platform.

Changes v1 -> v2:
* DT bindings moved to separate patch (as suggested by Alexey Brodkin)
* Removed defconfigs entries (as suggested by Alexey Brodkin)

Jose Abreu (3):
  drm/i2c/adv7511: Add audio support
  ASoC: dwc: Add I2S HDMI audio support
  arc: axs10x: Add support for Designware I2S on DT

 arch/arc/boot/dts/axs10x_mb.dtsi    |   49 +-
 drivers/gpu/drm/i2c/Kconfig         |   11 +
 drivers/gpu/drm/i2c/Makefile        |    2 +
 drivers/gpu/drm/i2c/adv7511.c       | 1024 -----------------------------------
 drivers/gpu/drm/i2c/adv7511.h       |   41 ++
 drivers/gpu/drm/i2c/adv7511_audio.c |  310 +++++++++++
 drivers/gpu/drm/i2c/adv7511_core.c  | 1005 ++++++++++++++++++++++++++++++++++
 include/sound/soc-dai.h             |    1 +
 sound/soc/dwc/Kconfig               |    1 +
 sound/soc/dwc/designware_i2s.c      |  385 ++++++++++++-
 10 files changed, 1788 insertions(+), 1041 deletions(-)
 delete mode 100644 drivers/gpu/drm/i2c/adv7511.c
 create mode 100644 drivers/gpu/drm/i2c/adv7511_audio.c
 create mode 100644 drivers/gpu/drm/i2c/adv7511_core.c

-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
