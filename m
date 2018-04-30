From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 4/4] ASoC: fsl_spdif: Switch to SPDX identifier
Date: Mon, 30 Apr 2018 20:55:18 -0300
Message-ID: <1525132518-27663-4-git-send-email-festevam@gmail.com>
References: <1525132518-27663-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f193.google.com (mail-qt0-f193.google.com
 [209.85.216.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5927C267673
 for <alsa-devel@alsa-project.org>; Tue,  1 May 2018 01:55:24 +0200 (CEST)
Received: by mail-qt0-f193.google.com with SMTP id f1-v6so13032854qtj.6
 for <alsa-devel@alsa-project.org>; Mon, 30 Apr 2018 16:55:24 -0700 (PDT)
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
 sound/soc/fsl/fsl_spdif.c | 24 ++++++++++--------------
 sound/soc/fsl/fsl_spdif.h |  5 +----
 2 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 4f7469c..9b59d87 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1,17 +1,13 @@
-/*
- * Freescale S/PDIF ALSA SoC Digital Audio Interface (DAI) driver
- *
- * Copyright (C) 2013 Freescale Semiconductor, Inc.
- *
- * Based on stmp3xxx_spdif_dai.c
- * Vladimir Barinov <vbarinov@embeddedalley.com>
- * Copyright 2008 SigmaTel, Inc
- * Copyright 2008 Embedded Alley Solutions, Inc
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program  is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale S/PDIF ALSA SoC Digital Audio Interface (DAI) driver
+//
+// Copyright (C) 2013 Freescale Semiconductor, Inc.
+//
+// Based on stmp3xxx_spdif_dai.c
+// Vladimir Barinov <vbarinov@embeddedalley.com>
+// Copyright 2008 SigmaTel, Inc
+// Copyright 2008 Embedded Alley Solutions, Inc
 
 #include <linux/bitrev.h>
 #include <linux/clk.h>
diff --git a/sound/soc/fsl/fsl_spdif.h b/sound/soc/fsl/fsl_spdif.h
index 00bd351..7666dab 100644
--- a/sound/soc/fsl/fsl_spdif.h
+++ b/sound/soc/fsl/fsl_spdif.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fsl_spdif.h - ALSA S/PDIF interface for the Freescale i.MX SoC
  *
@@ -8,10 +9,6 @@
  * Based on fsl_ssi.h
  * Author: Timur Tabi <timur@freescale.com>
  * Copyright 2007-2008 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program  is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #ifndef _FSL_SPDIF_DAI_H
-- 
2.7.4
