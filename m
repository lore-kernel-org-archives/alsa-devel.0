From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_sai: Switch to SPDX identifier" to
	the asoc tree
Date: Thu,  3 May 2018 02:32:19 +0100 (BST)
Message-ID: <20180503013219.B58CF44007A@finisterre.ee.mobilebroadband>
References: <1525132518-27663-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C457266C1C
 for <alsa-devel@alsa-project.org>; Thu,  3 May 2018 03:32:23 +0200 (CEST)
In-Reply-To: <1525132518-27663-2-git-send-email-festevam@gmail.com>
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

   ASoC: fsl_sai: Switch to SPDX identifier

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

>From dbbeaad4239ed5a5963f4a76e858bd6e39f6d566 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Tue, 1 May 2018 09:20:41 -0300
Subject: [PATCH] ASoC: fsl_sai: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 16 +++++-----------
 sound/soc/fsl/fsl_sai.h |  5 +----
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 18e5ce81527d..4163f2cfc06f 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1,14 +1,8 @@
-/*
- * Freescale ALSA SoC Digital Audio Interface (SAI) driver.
- *
- * Copyright 2012-2015 Freescale Semiconductor, Inc.
- *
- * This program is free software, you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation, either version 2 of the License, or(at your
- * option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Freescale ALSA SoC Digital Audio Interface (SAI) driver.
+//
+// Copyright 2012-2015 Freescale Semiconductor, Inc.
 
 #include <linux/clk.h>
 #include <linux/delay.h>
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index d9ed7be8cb34..24cb156bf995 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -1,9 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright 2012-2013 Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __FSL_SAI_H
-- 
2.17.0
