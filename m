From: David Lambert <dlambert@ti.com>
Subject: [PATCH v2 0/4] Adding OMAP DMIC driver to kernel
Date: Thu,  6 Jan 2011 08:00:35 -0600
Message-ID: <1294322439-16305-1-git-send-email-dlambert@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, David Lambert <dlambert@ti.com>
List-Id: alsa-devel@alsa-project.org

This is a patch series to add the OMAP Digital Microphone
driver for OMAP4.

It includes the driver, a generic DMIC codec, platform devices,
as well as HWMOD entries for OMAP44xx chipsets.

David Lambert (4):
  ASoC: DMIC: Adding the OMAP DMIC driver
  ASoC: DMIC codec: Adding a generic DMIC codec
  OMAP4: hwmod: add entries for DMIC driver
  OMAP4: DMIC: Add DMIC codec platform devices

 arch/arm/mach-omap2/board-4430sdp.c        |   11 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   91 +++++
 arch/arm/plat-omap/devices.c               |   35 ++
 arch/arm/plat-omap/include/plat/dmic.h     |   82 ++++
 sound/soc/codecs/Kconfig                   |    3 +
 sound/soc/codecs/Makefile                  |    2 +
 sound/soc/codecs/dmic.c                    |   81 ++++
 sound/soc/omap/Kconfig                     |    4 +
 sound/soc/omap/Makefile                    |    2 +
 sound/soc/omap/omap-dmic.c                 |  553 ++++++++++++++++++++++++++++
 10 files changed, 864 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/dmic.h
 create mode 100644 sound/soc/codecs/dmic.c
 create mode 100644 sound/soc/omap/omap-dmic.c

