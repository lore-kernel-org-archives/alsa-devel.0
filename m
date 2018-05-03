From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_ssi: Switch to SPDX identifier" to
	the asoc tree
Date: Thu,  3 May 2018 02:32:25 +0100 (BST)
Message-ID: <20180503013225.9386A44007A@finisterre.ee.mobilebroadband>
References: <1525177243-31009-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B8D222675FC
 for <alsa-devel@alsa-project.org>; Thu,  3 May 2018 03:32:29 +0200 (CEST)
In-Reply-To: <1525177243-31009-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, broonie@kernel.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_ssi: Switch to SPDX identifier

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

>From 0eb6048f7a978f446367550974f3d1cb4b47262c Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Tue, 1 May 2018 09:20:40 -0300
Subject: [PATCH] ASoC: fsl_ssi: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c     | 57 +++++++++++++++++--------------------
 sound/soc/fsl/fsl_ssi.h     |  6 ++--
 sound/soc/fsl/fsl_ssi_dbg.c | 18 +++++-------
 3 files changed, 35 insertions(+), 46 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 1544166631e3..0a648229e643 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1,34 +1,29 @@
-/*
- * Freescale SSI ALSA SoC Digital Audio Interface (DAI) driver
- *
- * Author: Timur Tabi <timur@freescale.com>
- *
- * Copyright 2007-2010 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- *
- *
- * Some notes why imx-pcm-fiq is used instead of DMA on some boards:
- *
- * The i.MX SSI core has some nasty limitations in AC97 mode. While most
- * sane processor vendors have a FIFO per AC97 slot, the i.MX has only
- * one FIFO which combines all valid receive slots. We cannot even select
- * which slots we want to receive. The WM9712 with which this driver
- * was developed with always sends GPIO status data in slot 12 which
- * we receive in our (PCM-) data stream. The only chance we have is to
- * manually skip this data in the FIQ handler. With sampling rates different
- * from 48000Hz not every frame has valid receive data, so the ratio
- * between pcm data and GPIO status data changes. Our FIQ handler is not
- * able to handle this, hence this driver only works with 48000Hz sampling
- * rate.
- * Reading and writing AC97 registers is another challenge. The core
- * provides us status bits when the read register is updated with *another*
- * value. When we read the same register two times (and the register still
- * contains the same value) these status bits are not set. We work
- * around this by not polling these bits but only wait a fixed delay.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale SSI ALSA SoC Digital Audio Interface (DAI) driver
+//
+// Author: Timur Tabi <timur@freescale.com>
+//
+// Copyright 2007-2010 Freescale Semiconductor, Inc.
+//
+// Some notes why imx-pcm-fiq is used instead of DMA on some boards:
+//
+// The i.MX SSI core has some nasty limitations in AC97 mode. While most
+// sane processor vendors have a FIFO per AC97 slot, the i.MX has only
+// one FIFO which combines all valid receive slots. We cannot even select
+// which slots we want to receive. The WM9712 with which this driver
+// was developed with always sends GPIO status data in slot 12 which
+// we receive in our (PCM-) data stream. The only chance we have is to
+// manually skip this data in the FIQ handler. With sampling rates different
+// from 48000Hz not every frame has valid receive data, so the ratio
+// between pcm data and GPIO status data changes. Our FIQ handler is not
+// able to handle this, hence this driver only works with 48000Hz sampling
+// rate.
+// Reading and writing AC97 registers is another challenge. The core
+// provides us status bits when the read register is updated with *another*
+// value. When we read the same register two times (and the register still
+// contains the same value) these status bits are not set. We work
+// around this by not polling these bits but only wait a fixed delay.
 
 #include <linux/init.h>
 #include <linux/io.h>
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index 18f8dd5209d5..0bdda608d414 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -1,12 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fsl_ssi.h - ALSA SSI interface for the Freescale MPC8610 and i.MX SoC
  *
  * Author: Timur Tabi <timur@freescale.com>
  *
- * Copyright 2007-2008 Freescale Semiconductor, Inc.  This file is licensed
- * under the terms of the GNU General Public License version 2.  This
- * program is licensed "as is" without any warranty of any kind, whether
- * express or implied.
+ * Copyright 2007-2008 Freescale Semiconductor, Inc.
  */
 
 #ifndef _MPC8610_I2S_H
diff --git a/sound/soc/fsl/fsl_ssi_dbg.c b/sound/soc/fsl/fsl_ssi_dbg.c
index 7aac63e2c561..1bacfa24ba7f 100644
--- a/sound/soc/fsl/fsl_ssi_dbg.c
+++ b/sound/soc/fsl/fsl_ssi_dbg.c
@@ -1,14 +1,10 @@
-/*
- * Freescale SSI ALSA SoC Digital Audio Interface (DAI) debugging functions
- *
- * Copyright 2014 Markus Pargmann <mpa@pengutronix.de>, Pengutronix
- *
- * Splitted from fsl_ssi.c
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale SSI ALSA SoC Digital Audio Interface (DAI) debugging functions
+//
+// Copyright 2014 Markus Pargmann <mpa@pengutronix.de>, Pengutronix
+//
+// Split from fsl_ssi.c
 
 #include <linux/debugfs.h>
 #include <linux/device.h>
-- 
2.17.0
