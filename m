From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: p1022_rdk: Switch to SPDX identifier" to the asoc tree
Date: Mon,  8 Apr 2019 14:25:21 +0700 (+07)
Message-ID: <20190408072521.52262441D3C@finisterre.ee.mobilebroadband>
References: <20190405115010.28838-18-andradanciu1997@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405115010.28838-18-andradanciu1997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andra Danciu <andradanciu1997@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, daniel.baluta@nxp.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: p1022_rdk: Switch to SPDX identifier

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

>From 8acfeb65cbaa92ff2e4f3305c7a18a6edabd1d92 Mon Sep 17 00:00:00 2001
From: Andra Danciu <andradanciu1997@gmail.com>
Date: Fri, 5 Apr 2019 14:50:07 +0300
Subject: [PATCH] ASoC: p1022_rdk: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/p1022_rdk.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/sound/soc/fsl/p1022_rdk.c b/sound/soc/fsl/p1022_rdk.c
index 4afbdd610bfa..1c32c2d8c6b0 100644
--- a/sound/soc/fsl/p1022_rdk.c
+++ b/sound/soc/fsl/p1022_rdk.c
@@ -1,21 +1,17 @@
-/**
- * Freescale P1022RDK ALSA SoC Machine driver
- *
- * Author: Timur Tabi <timur@freescale.com>
- *
- * Copyright 2012 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- *
- * Note: in order for audio to work correctly, the output controls need
- * to be enabled, because they control the clock.  So for playback, for
- * example:
- *
- *      amixer sset 'Left Output Mixer PCM' on
- *      amixer sset 'Right Output Mixer PCM' on
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale P1022RDK ALSA SoC Machine driver
+//
+// Author: Timur Tabi <timur@freescale.com>
+//
+// Copyright 2012 Freescale Semiconductor, Inc.
+//
+// Note: in order for audio to work correctly, the output controls need
+// to be enabled, because they control the clock.  So for playback, for
+// example:
+//
+//      amixer sset 'Left Output Mixer PCM' on
+//      amixer sset 'Right Output Mixer PCM' on
 
 #include <linux/module.h>
 #include <linux/fsl/guts.h>
-- 
2.20.1
