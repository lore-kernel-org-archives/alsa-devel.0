From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v6 0/2] Add Freescale ASRC driver
Date: Tue, 29 Jul 2014 18:08:51 +0800
Message-ID: <cover.1406628283.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, timur@tabi.org, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, shawn.guo@linaro.org, b02247@freescale.com, b42378@freescale.com, tklauser@distanz.ch, varkabhadram@gmail.com
List-Id: alsa-devel@alsa-project.org

This series of patches add Freescale ASRC module driver support along
with the extra request in imx-sdma structure required by SDMA Device
to Device script.

The previous version has been in the maillist for nearly six months
without any comment and reply. So I decide to drop the SDMA part's
change since this series focus on ASRC support (Later, we can send
SDMA part separately.) so that ASRC driver may get upstream first.

Changelog
v6: (Follows Mark Rutland's comments)
 * PATCH-2: Revised the big endian part in the binding document.
v5: (All follow Varka's suggestions)
 * PATCH-2: Added missing '\n' to pair_err() calls.
 * PATCH-2: Return the final regmap_write() for fsl_asrc_init().
 * PATCH-2: Dropped fsl_asrc_devtype and use simple ids behind fsl_asrc_pm.
 * PATCH-2: Use of_device_is_compatible() to differ compatible directly.
 * PATCH-2: Fixed indentation for devm_regmap_init_mmio_clk() call.
v4: (All follow Varka's suggestions)
 * PATCH-2: Added '\n' to dev_dbg() inside fsl_asrc_isr().
 * PATCH-2: Added indentations to DT binding document.
 * PATCH-2: Redefined fsl_asrc_set_watermarks() as void type.
 * PATCH-2: Put fsl_asrc_isr() and fsl_asrc_ids before probe()
v3:
 * PATCH-1: Added an Acked-by from Shawn Guo
 * PATCH-2: Dropped THIS_MODULE as Tobias suggests
 * PATCH-2: Use dma_coerce_mask_and_coherent() in fsl_asrc_dma_pcm_new()
 * PATCH-2: Added substream check in fsl_asrc_dma_pcm_new()
v2:
 * PATCH-1: Dropped the change to SDMA driver.
 * PATCH-2: Dropped useless member in private data structures.
 * PATCH-2: Refined some comments in fsl_asrc_dma.c driver.
 * PATCH-2: Refined commit comments.

Nicolin Chen (2):
  ARM: imx: Add the secondary request into the structure for imx-sdma
  ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and platform drivers

 .../devicetree/bindings/sound/fsl,asrc.txt         |  60 ++
 include/linux/platform_data/dma-imx.h              |   1 +
 sound/soc/fsl/Kconfig                              |   9 +
 sound/soc/fsl/Makefile                             |   2 +
 sound/soc/fsl/fsl_asrc.c                           | 992 +++++++++++++++++++++
 sound/soc/fsl/fsl_asrc.h                           | 461 ++++++++++
 sound/soc/fsl/fsl_asrc_dma.c                       | 386 ++++++++
 7 files changed, 1911 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,asrc.txt
 create mode 100644 sound/soc/fsl/fsl_asrc.c
 create mode 100644 sound/soc/fsl/fsl_asrc.h
 create mode 100644 sound/soc/fsl/fsl_asrc_dma.c

-- 
1.8.4
