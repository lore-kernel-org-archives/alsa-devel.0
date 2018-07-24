From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: imx-sgtl5000: Switch to SPDX
	identifier" to the asoc tree
Date: Tue, 24 Jul 2018 17:02:08 +0100 (BST)
Message-ID: <20180724160208.DB1001123A86@debutante.sirena.org.uk>
References: <1532436513-19283-4-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C5CB26733D
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 18:02:09 +0200 (CEST)
In-Reply-To: <1532436513-19283-4-git-send-email-fabio.estevam@nxp.com>
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

   ASoC: imx-sgtl5000: Switch to SPDX identifier

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

>From 6b24e03ecf1ce188071d142115233b10ed8767b2 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Tue, 24 Jul 2018 09:48:33 -0300
Subject: [PATCH] ASoC: imx-sgtl5000: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/imx-sgtl5000.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index b99e0b5e00e9..c29200cf755a 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -1,14 +1,7 @@
-/*
- * Copyright 2012 Freescale Semiconductor, Inc.
- * Copyright 2012 Linaro Ltd.
- *
- * The code contained herein is licensed under the GNU General Public
- * License. You may obtain a copy of the GNU General Public License
- * Version 2 or later at the following locations:
- *
- * http://www.opensource.org/licenses/gpl-license.html
- * http://www.gnu.org/copyleft/gpl.html
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright 2012 Freescale Semiconductor, Inc.
+// Copyright 2012 Linaro Ltd.
 
 #include <linux/module.h>
 #include <linux/of.h>
-- 
2.18.0
