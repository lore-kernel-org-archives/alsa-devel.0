From: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Subject: [PATCH 0/7] Add STM32 DFSDM support
Date: Mon, 23 Jan 2017 17:32:18 +0100
Message-ID: <1485189145-29576-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch-set handles the Digital Filter for Sigma Delta modulators IP on STM32 platforms.
DFSDM IP allows PDM microphone capture and sigma delta ADC conversion.

Those two features are mixed into the registers of the same hardware block which lead to introduce a multifunction 
driver on the top of them to be able to share the registers.

for This, MFD exports an API based on  get/configure/start/stop/release mechanisms.

Two kind of resources are handled by the MFD driver.
- The filters: 
	- 4 instances available for L4 and H7
        - composed with a SInC filter and an integrator 
- The transceivers or channels
	- 8 instances available for L4 and H7
        - can be connected to
        	serial transceivers (SPI or Manchester mode)
                internal parallel transceivers (from memory or internal ADC)
        -  associated  monitoring: analog watchdog, short circuit detector, extreme detector  
           (monitoring support will be part of a specific patch-set)) 

Principle OF the DFSDM IP is to connect one or several channels to a filter to process Sigma delta ADC or PDM microphone data.

Two types of child devices can de declared:
IIO for the management of Sigma Delta ADC conversion.
ASoC for PDM microphone audio capture.

For details on IP and use case examples please refer to this document:
http://www.st.com/content/ccc/resource/training/technical/product_training/96/b6/2b/ea/72/3f/4e/d5/STM32L4_System_DFSDM.pdf/files/STM32L4_System_DFSDM.pdf/jcr:content/translations/en.STM32L4_System_DFSDM.pdf

Remark:
    For audio part a patch is proposed to update core part to add copy support in soc_dmaengine_pcm.
    Rational is that output data register in DFSDM contains audio sample on 24 MSB + channel ID on the 8 LSB.
    Proposal is to allow to register a copy ops in soc_dmaengine_pcm to be able to perform post-processing.
    Back up if not accepted can be to create a pcm_engine in stm32 driver.
 
Not part of this patch-set, but should come as add-on patches:
- IIO management of Analog watchdog, short-circuit detection and clock absence detector, with associated IRQs management.
- IIO trigger and buffer management.  

Arnaud Pouliquen (6):
  MFD: add bindings for STM32 DFSDM driver
  MFD: add STM32 DFSDM support
  IIO: add bindings for STM32 DFSDM ADC driver
  IIO: add STM32 DFSDM ADC support
  ASoC: add bindings for STM32 DFSDM driver
  ASoC: add STM32 DFSDM support

olivier moysan (1):
  ASoC: dmaengine_pcm: add copy support

 .../bindings/iio/adc/st,stm32-dfsdm-adc.txt        |   60 ++
 .../devicetree/bindings/mfd/stm32-dfsdm.txt        |   68 ++
 .../devicetree/bindings/sound/st,sm32-adfsdm.txt   |   84 ++
 drivers/iio/adc/Kconfig                            |    9 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/stm32-dfsdm-adc.c                  |  676 +++++++++++++
 drivers/mfd/Kconfig                                |   11 +
 drivers/mfd/Makefile                               |    2 +
 drivers/mfd/stm32-dfsdm-reg.h                      |  220 +++++
 drivers/mfd/stm32-dfsdm.c                          | 1044 ++++++++++++++++++++
 include/linux/mfd/stm32-dfsdm.h                    |  324 ++++++
 include/sound/dmaengine_pcm.h                      |    3 +
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/soc-generic-dmaengine-pcm.c              |   37 +-
 sound/soc/stm/Kconfig                              |   10 +
 sound/soc/stm/Makefile                             |    2 +
 sound/soc/stm/stm32_adfsdm.c                       |  686 +++++++++++++
 18 files changed, 3237 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.txt 
 create mode 100644 Documentation/devicetree/bindings/mfd/stm32-dfsdm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/st,sm32-adfsdm.txt
 create mode 100644 drivers/iio/adc/stm32-dfsdm-adc.c
 create mode 100644 drivers/mfd/stm32-dfsdm-reg.h
 create mode 100644 drivers/mfd/stm32-dfsdm.c
 create mode 100644 include/linux/mfd/stm32-dfsdm.h
 create mode 100644 sound/soc/stm/Kconfig
 create mode 100644 sound/soc/stm/Makefile
 create mode 100644 sound/soc/stm/stm32_adfsdm.c

-- 
1.9.1
