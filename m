From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 2/4] ASoC: fsl_asrc: Switch to SPDX identifier
Date: Tue, 24 Jul 2018 09:48:31 -0300
Message-ID: <1532436513-19283-2-git-send-email-fabio.estevam@nxp.com>
References: <1532436513-19283-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FF1D26733D
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 14:47:38 +0200 (CEST)
In-Reply-To: <1532436513-19283-1-git-send-email-fabio.estevam@nxp.com>
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
 sound/soc/fsl/fsl_asrc.c     | 18 +++++++-----------
 sound/soc/fsl/fsl_asrc.h     |  5 +----
 sound/soc/fsl/fsl_asrc_dma.c | 18 +++++++-----------
 3 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index adfb813..528e8b1 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -1,14 +1,10 @@
-/*
- * Freescale ASRC ALSA SoC Digital Audio Interface (DAI) driver
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
+// Freescale ASRC ALSA SoC Digital Audio Interface (DAI) driver
+//
+// Copyright (C) 2014 Freescale Semiconductor, Inc.
+//
+// Author: Nicolin Chen <nicoleotsuka@gmail.com>
 
 #include <linux/clk.h>
 #include <linux/delay.h>
diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
index d558dd5..c600751 100644
--- a/sound/soc/fsl/fsl_asrc.h
+++ b/sound/soc/fsl/fsl_asrc.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fsl_asrc.h - Freescale ASRC ALSA SoC header file
  *
  * Copyright (C) 2014 Freescale Semiconductor, Inc.
  *
  * Author: Nicolin Chen <nicoleotsuka@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #ifndef _FSL_ASRC_H
diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index 565e16d8..1033ac6 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -1,14 +1,10 @@
-/*
- * Freescale ASRC ALSA SoC Platform (DMA) driver
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
+// Freescale ASRC ALSA SoC Platform (DMA) driver
+//
+// Copyright (C) 2014 Freescale Semiconductor, Inc.
+//
+// Author: Nicolin Chen <nicoleotsuka@gmail.com>
 
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
-- 
2.7.4
