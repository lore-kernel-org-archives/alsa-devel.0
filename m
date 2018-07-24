From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 1/4] ASoC: fsl-asoc-card: Switch to SPDX
	identifier
Date: Tue, 24 Jul 2018 09:48:30 -0300
Message-ID: <1532436513-19283-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F19F2676CC
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 14:47:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, timur@kernel.org
List-Id: alsa-devel@alsa-project.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 4a6750a..07808c6 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -1,14 +1,10 @@
-/*
- * Freescale Generic ASoC Sound Card driver with ASRC
- *
- * Copyright (C) 2014 Freescale Semiconductor, Inc.
- *
- * Author: Nicolin Chen <nicoleotsuka@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale Generic ASoC Sound Card driver with ASRC
+//
+// Copyright (C) 2014 Freescale Semiconductor, Inc.
+//
+// Author: Nicolin Chen <nicoleotsuka@gmail.com>
 
 #include <linux/clk.h>
 #include <linux/i2c.h>
-- 
2.7.4
