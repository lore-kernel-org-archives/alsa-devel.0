From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_esai: Switch to SPDX identifier" to
	the asoc tree
Date: Thu,  3 May 2018 02:32:07 +0100 (BST)
Message-ID: <20180503013207.F393244007A@finisterre.ee.mobilebroadband>
References: <1525132518-27663-3-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D0C9E266C1C
 for <alsa-devel@alsa-project.org>; Thu,  3 May 2018 03:32:11 +0200 (CEST)
In-Reply-To: <1525132518-27663-3-git-send-email-festevam@gmail.com>
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

   ASoC: fsl_esai: Switch to SPDX identifier

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

>From 3b5af9f116e5226c15037f4c0a712ef3318a155e Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Tue, 1 May 2018 09:20:42 -0300
Subject: [PATCH] ASoC: fsl_esai: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_esai.c | 14 +++++---------
 sound/soc/fsl/fsl_esai.h |  5 +----
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index d79e99ef31ad..8f43110373b8 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -1,12 +1,8 @@
-/*
- * Freescale ESAI ALSA SoC Digital Audio Interface (DAI) driver
- *
- * Copyright (C) 2014 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale ESAI ALSA SoC Digital Audio Interface (DAI) driver
+//
+// Copyright (C) 2014 Freescale Semiconductor, Inc.
 
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
diff --git a/sound/soc/fsl/fsl_esai.h b/sound/soc/fsl/fsl_esai.h
index 5e793bbb6b02..f873588d9045 100644
--- a/sound/soc/fsl/fsl_esai.h
+++ b/sound/soc/fsl/fsl_esai.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fsl_esai.h - ALSA ESAI interface for the Freescale i.MX SoC
  *
  * Copyright (C) 2014 Freescale Semiconductor, Inc.
  *
  * Author: Nicolin Chen <Guangyu.Chen@freescale.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #ifndef _FSL_ESAI_DAI_H
-- 
2.17.0
