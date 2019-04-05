From: Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 17/20] ASoC: p1022_rdk: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:50:07 +0300
Message-ID: <20190405115010.28838-18-andradanciu1997@gmail.com>
References: <20190405115010.28838-1-andradanciu1997@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405115010.28838-1-andradanciu1997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
List-Id: alsa-devel@alsa-project.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
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
2.11.0
