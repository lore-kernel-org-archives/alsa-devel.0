From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 3/4] ASoC: fsl_utils: Switch to SPDX identifier
Date: Tue, 24 Jul 2018 09:48:32 -0300
Message-ID: <1532436513-19283-3-git-send-email-fabio.estevam@nxp.com>
References: <1532436513-19283-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by alsa0.perex.cz (Postfix) with ESMTP id BB22826763A
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 14:47:39 +0200 (CEST)
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
 sound/soc/fsl/fsl_utils.c | 18 +++++++-----------
 sound/soc/fsl/fsl_utils.h |  7 ++-----
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/fsl_utils.c b/sound/soc/fsl/fsl_utils.c
index 7592b04..7f0fa4b 100644
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
index 1687b66..c5dc2a14 100644
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
2.7.4
