From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/4] ASoC: fsl_esai: Switch to SPDX identifier
Date: Mon, 30 Apr 2018 20:55:17 -0300
Message-ID: <1525132518-27663-3-git-send-email-festevam@gmail.com>
References: <1525132518-27663-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com
 [209.85.220.195])
 by alsa0.perex.cz (Postfix) with ESMTP id B75E7267669
 for <alsa-devel@alsa-project.org>; Tue,  1 May 2018 01:55:22 +0200 (CEST)
Received: by mail-qk0-f195.google.com with SMTP id z8so7920393qki.11
 for <alsa-devel@alsa-project.org>; Mon, 30 Apr 2018 16:55:22 -0700 (PDT)
In-Reply-To: <1525132518-27663-1-git-send-email-festevam@gmail.com>
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
 sound/soc/fsl/fsl_esai.c | 14 +++++---------
 sound/soc/fsl/fsl_esai.h |  5 +----
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index d79e99e..8f43110 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -1,12 +1,8 @@
-/*
- * Freescale ESAI ALSA SoC Digital Audio Interface (DAI) driver
- *
- * Copyright (C) 2014 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale ESAI ALSA SoC Digital Audio Interface (DAI) driver
+//
+// Copyright (C) 2014 Freescale Semiconductor, Inc.
 
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
diff --git a/sound/soc/fsl/fsl_esai.h b/sound/soc/fsl/fsl_esai.h
index 5e793bb..f873588 100644
--- a/sound/soc/fsl/fsl_esai.h
+++ b/sound/soc/fsl/fsl_esai.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fsl_esai.h - ALSA ESAI interface for the Freescale i.MX SoC
  *
  * Copyright (C) 2014 Freescale Semiconductor, Inc.
  *
  * Author: Nicolin Chen <Guangyu.Chen@freescale.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #ifndef _FSL_ESAI_DAI_H
-- 
2.7.4
