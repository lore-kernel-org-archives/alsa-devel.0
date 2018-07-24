From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_utils: Switch to SPDX identifier"
	to the asoc tree
Date: Tue, 24 Jul 2018 17:02:16 +0100 (BST)
Message-ID: <20180724160216.DFB3B1123A86@debutante.sirena.org.uk>
References: <1532436513-19283-3-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E70126772E
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 18:02:17 +0200 (CEST)
In-Reply-To: <1532436513-19283-3-git-send-email-fabio.estevam@nxp.com>
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

   ASoC: fsl_utils: Switch to SPDX identifier

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

>From ad47191a72ca0a95327e8bb16155e5e216f1d97d Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Tue, 24 Jul 2018 09:48:32 -0300
Subject: [PATCH] ASoC: fsl_utils: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_utils.c | 18 +++++++-----------
 sound/soc/fsl/fsl_utils.h |  7 ++-----
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/fsl_utils.c b/sound/soc/fsl/fsl_utils.c
index 7592b0406370..7f0fa4b52223 100644
--- a/sound/soc/fsl/fsl_utils.c
+++ b/sound/soc/fsl/fsl_utils.c
@@ -1,14 +1,10 @@
-/**
- * Freescale ALSA SoC Machine driver utility
- *
- * Author: Timur Tabi <timur@freescale.com>
- *
- * Copyright 2010 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale ALSA SoC Machine driver utility
+//
+// Author: Timur Tabi <timur@freescale.com>
+//
+// Copyright 2010 Freescale Semiconductor, Inc.
 
 #include <linux/module.h>
 #include <linux/of_address.h>
diff --git a/sound/soc/fsl/fsl_utils.h b/sound/soc/fsl/fsl_utils.h
index 1687b66ef18e..c5dc2a14b492 100644
--- a/sound/soc/fsl/fsl_utils.h
+++ b/sound/soc/fsl/fsl_utils.h
@@ -1,13 +1,10 @@
-/**
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Freescale ALSA SoC Machine driver utility
  *
  * Author: Timur Tabi <timur@freescale.com>
  *
  * Copyright 2010 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #ifndef _FSL_UTILS_H
-- 
2.18.0
