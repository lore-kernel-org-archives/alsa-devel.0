From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pcm030-audio-fabric: Switch to SPDX identifier" to the asoc tree
Date: Mon,  8 Apr 2019 14:25:07 +0700 (+07)
Message-ID: <20190408072507.C0354441D3B@finisterre.ee.mobilebroadband>
References: <20190405115010.28838-19-andradanciu1997@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405115010.28838-19-andradanciu1997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andra Danciu <andradanciu1997@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, daniel.baluta@nxp.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: pcm030-audio-fabric: Switch to SPDX identifier

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

>From 6e3398c67e682486b1f18672519a8e607d902172 Mon Sep 17 00:00:00 2001
From: Andra Danciu <andradanciu1997@gmail.com>
Date: Fri, 5 Apr 2019 14:50:08 +0300
Subject: [PATCH] ASoC: pcm030-audio-fabric: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/pcm030-audio-fabric.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index e339f36cea95..a7fe4ad25c52 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -1,14 +1,10 @@
-/*
- * Phytec pcm030 driver for the PSC of the Freescale MPC52xx
- * configured as AC97 interface
- *
- * Copyright 2008 Jon Smirl, Digispeaker
- * Author: Jon Smirl <jonsmirl@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Phytec pcm030 driver for the PSC of the Freescale MPC52xx
+// configured as AC97 interface
+//
+// Copyright 2008 Jon Smirl, Digispeaker
+// Author: Jon Smirl <jonsmirl@gmail.com>
 
 #include <linux/init.h>
 #include <linux/module.h>
-- 
2.20.1
