From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl-dma: Switch to SPDX identifier" to the asoc tree
Date: Mon,  8 Apr 2019 14:29:29 +0700 (+07)
Message-ID: <20190408072929.952A1441D3B@finisterre.ee.mobilebroadband>
References: <20190405115010.28838-5-andradanciu1997@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405115010.28838-5-andradanciu1997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andra Danciu <andradanciu1997@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, daniel.baluta@nxp.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl-dma: Switch to SPDX identifier

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e073564fe653eacbef6723a0a5210131b3998000 Mon Sep 17 00:00:00 2001
From: Andra Danciu <andradanciu1997@gmail.com>
Date: Fri, 5 Apr 2019 14:49:54 +0300
Subject: [PATCH] ASoC: fsl-dma: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_dma.c | 26 +++++++++++---------------
 sound/soc/fsl/fsl_dma.h |  5 +----
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
index 78871de35086..e22508301412 100644
--- a/sound/soc/fsl/fsl_dma.c
+++ b/sound/soc/fsl/fsl_dma.c
@@ -1,18 +1,14 @@
-/*
- * Freescale DMA ALSA SoC PCM driver
- *
- * Author: Timur Tabi <timur@freescale.com>
- *
- * Copyright 2007-2010 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- *
- * This driver implements ASoC support for the Elo DMA controller, which is
- * the DMA controller on Freescale 83xx, 85xx, and 86xx SOCs. In ALSA terms,
- * the PCM driver is what handles the DMA buffer.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale DMA ALSA SoC PCM driver
+//
+// Author: Timur Tabi <timur@freescale.com>
+//
+// Copyright 2007-2010 Freescale Semiconductor, Inc.
+//
+// This driver implements ASoC support for the Elo DMA controller, which is
+// the DMA controller on Freescale 83xx, 85xx, and 86xx SOCs. In ALSA terms,
+// the PCM driver is what handles the DMA buffer.
 
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/sound/soc/fsl/fsl_dma.h b/sound/soc/fsl/fsl_dma.h
index 78fee97e8036..f19ae765b656 100644
--- a/sound/soc/fsl/fsl_dma.h
+++ b/sound/soc/fsl/fsl_dma.h
@@ -1,9 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mpc8610-pcm.h - ALSA PCM interface for the Freescale MPC8610 SoC
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef _MPC8610_PCM_H
-- 
2.20.1
