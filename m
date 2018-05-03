From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_spdif: Switch to SPDX identifier"
	to the asoc tree
Date: Thu,  3 May 2018 02:31:43 +0100 (BST)
Message-ID: <20180503013143.455F944007A@finisterre.ee.mobilebroadband>
References: <1525132518-27663-4-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A1E5266C1C
 for <alsa-devel@alsa-project.org>; Thu,  3 May 2018 03:31:48 +0200 (CEST)
In-Reply-To: <1525132518-27663-4-git-send-email-festevam@gmail.com>
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

   ASoC: fsl_spdif: Switch to SPDX identifier

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

>From 165a30e4315e14c0e30e54b6e3c977198b98195d Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Tue, 1 May 2018 09:20:43 -0300
Subject: [PATCH] ASoC: fsl_spdif: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_spdif.c | 24 ++++++++++--------------
 sound/soc/fsl/fsl_spdif.h |  5 +----
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 4f7469c1864c..9b59d87b61bf 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1,17 +1,13 @@
-/*
- * Freescale S/PDIF ALSA SoC Digital Audio Interface (DAI) driver
- *
- * Copyright (C) 2013 Freescale Semiconductor, Inc.
- *
- * Based on stmp3xxx_spdif_dai.c
- * Vladimir Barinov <vbarinov@embeddedalley.com>
- * Copyright 2008 SigmaTel, Inc
- * Copyright 2008 Embedded Alley Solutions, Inc
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program  is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale S/PDIF ALSA SoC Digital Audio Interface (DAI) driver
+//
+// Copyright (C) 2013 Freescale Semiconductor, Inc.
+//
+// Based on stmp3xxx_spdif_dai.c
+// Vladimir Barinov <vbarinov@embeddedalley.com>
+// Copyright 2008 SigmaTel, Inc
+// Copyright 2008 Embedded Alley Solutions, Inc
 
 #include <linux/bitrev.h>
 #include <linux/clk.h>
diff --git a/sound/soc/fsl/fsl_spdif.h b/sound/soc/fsl/fsl_spdif.h
index 00bd3514c610..7666dabaccfd 100644
--- a/sound/soc/fsl/fsl_spdif.h
+++ b/sound/soc/fsl/fsl_spdif.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fsl_spdif.h - ALSA S/PDIF interface for the Freescale i.MX SoC
  *
@@ -8,10 +9,6 @@
  * Based on fsl_ssi.h
  * Author: Timur Tabi <timur@freescale.com>
  * Copyright 2007-2008 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program  is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #ifndef _FSL_SPDIF_DAI_H
-- 
2.17.0
