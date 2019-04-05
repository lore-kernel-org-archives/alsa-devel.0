From: Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 05/20] ASoC: imx-audmux: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:49:55 +0300
Message-ID: <20190405115010.28838-6-andradanciu1997@gmail.com>
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
 sound/soc/fsl/imx-audmux.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index 99e07b01a2ce..04e59e66711d 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -1,21 +1,11 @@
-/*
- * Copyright 2012 Freescale Semiconductor, Inc.
- * Copyright 2012 Linaro Ltd.
- * Copyright 2009 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
- *
- * Initial development of this code was funded by
- * Phytec Messtechnik GmbH, http://www.phytec.de
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright 2012 Freescale Semiconductor, Inc.
+// Copyright 2012 Linaro Ltd.
+// Copyright 2009 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
+//
+// Initial development of this code was funded by
+// Phytec Messtechnik GmbH, http://www.phytec.de
 
 #include <linux/clk.h>
 #include <linux/debugfs.h>
-- 
2.11.0
