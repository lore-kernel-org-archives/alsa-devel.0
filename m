From: Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH] ASoC: imx-pcm-dma: Switch to SPDX identifier
Date: Thu,  4 Apr 2019 14:52:52 +0300
Message-ID: <20190404115252.29230-1-andradanciu1997@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Andra Danciu <andradanciu1997@gmail.com>
List-Id: alsa-devel@alsa-project.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 sound/soc/fsl/imx-pcm-dma.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index 314814ddd2b0..6c495761f33c 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -1,16 +1,12 @@
-/*
- * imx-pcm-dma-mx2.c  --  ALSA Soc Audio Layer
- *
- * Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
- *
- * This code is based on code copyrighted by Freescale,
- * Liam Girdwood, Javier Martin and probably others.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// imx-pcm-dma-mx2.c  --  ALSA Soc Audio Layer
+//
+// Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
+//
+// This code is based on code copyrighted by Freescale,
+// Liam Girdwood, Javier Martin and probably others.
+
 #include <linux/platform_device.h>
 #include <linux/dmaengine.h>
 #include <linux/types.h>
-- 
2.11.0
