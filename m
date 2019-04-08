From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: eukrea-tlv320: Switch to SPDX identifier" to the asoc tree
Date: Mon,  8 Apr 2019 14:29:39 +0700 (+07)
Message-ID: <20190408072939.725D5441D3C@finisterre.ee.mobilebroadband>
References: <20190405115010.28838-4-andradanciu1997@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405115010.28838-4-andradanciu1997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andra Danciu <andradanciu1997@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, daniel.baluta@nxp.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: eukrea-tlv320: Switch to SPDX identifier

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

>From ecf4630f1b9857141e38ea798bc30b8fd7c11dfc Mon Sep 17 00:00:00 2001
From: Andra Danciu <andradanciu1997@gmail.com>
Date: Fri, 5 Apr 2019 14:49:53 +0300
Subject: [PATCH] ASoC: eukrea-tlv320: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/eukrea-tlv320.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 30a3d68b5c03..d648268cb454 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -1,19 +1,13 @@
-/*
- * eukrea-tlv320.c  --  SoC audio for eukrea_cpuimxXX in I2S mode
- *
- * Copyright 2010 Eric Bénard, Eukréa Electromatique <eric@eukrea.com>
- *
- * based on sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
- * which is Copyright 2009 Simtec Electronics
- * and on sound/soc/imx/phycore-ac97.c which is
- * Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// eukrea-tlv320.c  --  SoC audio for eukrea_cpuimxXX in I2S mode
+//
+// Copyright 2010 Eric Bénard, Eukréa Electromatique <eric@eukrea.com>
+//
+// based on sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
+// which is Copyright 2009 Simtec Electronics
+// and on sound/soc/imx/phycore-ac97.c which is
+// Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
 
 #include <linux/errno.h>
 #include <linux/module.h>
-- 
2.20.1
