From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 2/4] ASoC: fsl_sai: Switch to SPDX identifier
Date: Tue,  1 May 2018 09:20:41 -0300
Message-ID: <1525177243-31009-2-git-send-email-festevam@gmail.com>
References: <1525177243-31009-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f195.google.com (mail-qt0-f195.google.com
 [209.85.216.195])
 by alsa0.perex.cz (Postfix) with ESMTP id D268826768E
 for <alsa-devel@alsa-project.org>; Tue,  1 May 2018 14:21:09 +0200 (CEST)
Received: by mail-qt0-f195.google.com with SMTP id q13-v6so13552062qtp.4
 for <alsa-devel@alsa-project.org>; Tue, 01 May 2018 05:21:09 -0700 (PDT)
In-Reply-To: <1525177243-31009-1-git-send-email-festevam@gmail.com>
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- None

 sound/soc/fsl/fsl_sai.c | 16 +++++-----------
 sound/soc/fsl/fsl_sai.h |  5 +----
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 18e5ce8..4163f2c 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -1,14 +1,8 @@
-/*
- * Freescale ALSA SoC Digital Audio Interface (SAI) driver.
- *
- * Copyright 2012-2015 Freescale Semiconductor, Inc.
- *
- * This program is free software, you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation, either version 2 of the License, or(at your
- * option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Freescale ALSA SoC Digital Audio Interface (SAI) driver.
+//
+// Copyright 2012-2015 Freescale Semiconductor, Inc.
 
 #include <linux/clk.h>
 #include <linux/delay.h>
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index d9ed7be..24cb156 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -1,9 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright 2012-2013 Freescale Semiconductor, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __FSL_SAI_H
-- 
2.7.4
