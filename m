From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_asrc: Switch to SPDX identifier" to
	the asoc tree
Date: Tue, 24 Jul 2018 17:02:26 +0100 (BST)
Message-ID: <20180724160226.8F2AB1123A86@debutante.sirena.org.uk>
References: <1532436513-19283-2-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 495D02676CF
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 18:02:27 +0200 (CEST)
In-Reply-To: <1532436513-19283-2-git-send-email-fabio.estevam@nxp.com>
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
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, broonie@kernel.org, timur@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_asrc: Switch to SPDX identifier

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

>From 2ba28053686334075c8c8bff6c4f6e3fc9ac51ae Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Tue, 24 Jul 2018 09:48:31 -0300
Subject: [PATCH] ASoC: fsl_asrc: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_asrc.c     | 18 +++++++-----------
 sound/soc/fsl/fsl_asrc.h     |  5 +----
 sound/soc/fsl/fsl_asrc_dma.c | 18 +++++++-----------
 3 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index adfb8135d739..528e8b108422 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -1,14 +1,10 @@
-/*
- * Freescale ASRC ALSA SoC Digital Audio Interface (DAI) driver
- *
- * Copyright (C) 2014 Freescale Semiconductor, Inc.
- *
- * Author: Nicolin Chen <nicoleotsuka@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale ASRC ALSA SoC Digital Audio Interface (DAI) driver
+//
+// Copyright (C) 2014 Freescale Semiconductor, Inc.
+//
+// Author: Nicolin Chen <nicoleotsuka@gmail.com>
 
 #include <linux/clk.h>
 #include <linux/delay.h>
diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
index d558dd5499a5..c60075112570 100644
--- a/sound/soc/fsl/fsl_asrc.h
+++ b/sound/soc/fsl/fsl_asrc.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fsl_asrc.h - Freescale ASRC ALSA SoC header file
  *
  * Copyright (C) 2014 Freescale Semiconductor, Inc.
  *
  * Author: Nicolin Chen <nicoleotsuka@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #ifndef _FSL_ASRC_H
diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index 565e16d8fe85..1033ac6631b0 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -1,14 +1,10 @@
-/*
- * Freescale ASRC ALSA SoC Platform (DMA) driver
- *
- * Copyright (C) 2014 Freescale Semiconductor, Inc.
- *
- * Author: Nicolin Chen <nicoleotsuka@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale ASRC ALSA SoC Platform (DMA) driver
+//
+// Copyright (C) 2014 Freescale Semiconductor, Inc.
+//
+// Author: Nicolin Chen <nicoleotsuka@gmail.com>
 
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
-- 
2.18.0
