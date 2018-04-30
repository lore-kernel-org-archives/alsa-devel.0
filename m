From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/4] ASoC: fsl_ssi: Switch to SPDX identifier
Date: Mon, 30 Apr 2018 20:55:15 -0300
Message-ID: <1525132518-27663-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
 [209.85.216.196])
 by alsa0.perex.cz (Postfix) with ESMTP id AA7A5267630
 for <alsa-devel@alsa-project.org>; Tue,  1 May 2018 01:55:17 +0200 (CEST)
Received: by mail-qt0-f196.google.com with SMTP id m5-v6so13030506qti.1
 for <alsa-devel@alsa-project.org>; Mon, 30 Apr 2018 16:55:17 -0700 (PDT)
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
 sound/soc/fsl/fsl_ssi.c     | 57 +++++++++++++++++++++------------------------
 sound/soc/fsl/fsl_ssi.h     |  6 +----
 sound/soc/fsl/fsl_ssi_dbg.c | 18 ++++++--------
 3 files changed, 34 insertions(+), 47 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 1544166..0a64822 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1,34 +1,29 @@
-/*
- * Freescale SSI ALSA SoC Digital Audio Interface (DAI) driver
- *
- * Author: Timur Tabi <timur@freescale.com>
- *
- * Copyright 2007-2010 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- *
- *
- * Some notes why imx-pcm-fiq is used instead of DMA on some boards:
- *
- * The i.MX SSI core has some nasty limitations in AC97 mode. While most
- * sane processor vendors have a FIFO per AC97 slot, the i.MX has only
- * one FIFO which combines all valid receive slots. We cannot even select
- * which slots we want to receive. The WM9712 with which this driver
- * was developed with always sends GPIO status data in slot 12 which
- * we receive in our (PCM-) data stream. The only chance we have is to
- * manually skip this data in the FIQ handler. With sampling rates different
- * from 48000Hz not every frame has valid receive data, so the ratio
- * between pcm data and GPIO status data changes. Our FIQ handler is not
- * able to handle this, hence this driver only works with 48000Hz sampling
- * rate.
- * Reading and writing AC97 registers is another challenge. The core
- * provides us status bits when the read register is updated with *another*
- * value. When we read the same register two times (and the register still
- * contains the same value) these status bits are not set. We work
- * around this by not polling these bits but only wait a fixed delay.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale SSI ALSA SoC Digital Audio Interface (DAI) driver
+//
+// Author: Timur Tabi <timur@freescale.com>
+//
+// Copyright 2007-2010 Freescale Semiconductor, Inc.
+//
+// Some notes why imx-pcm-fiq is used instead of DMA on some boards:
+//
+// The i.MX SSI core has some nasty limitations in AC97 mode. While most
+// sane processor vendors have a FIFO per AC97 slot, the i.MX has only
+// one FIFO which combines all valid receive slots. We cannot even select
+// which slots we want to receive. The WM9712 with which this driver
+// was developed with always sends GPIO status data in slot 12 which
+// we receive in our (PCM-) data stream. The only chance we have is to
+// manually skip this data in the FIQ handler. With sampling rates different
+// from 48000Hz not every frame has valid receive data, so the ratio
+// between pcm data and GPIO status data changes. Our FIQ handler is not
+// able to handle this, hence this driver only works with 48000Hz sampling
+// rate.
+// Reading and writing AC97 registers is another challenge. The core
+// provides us status bits when the read register is updated with *another*
+// value. When we read the same register two times (and the register still
+// contains the same value) these status bits are not set. We work
+// around this by not polling these bits but only wait a fixed delay.
 
 #include <linux/init.h>
 #include <linux/io.h>
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
index 18f8dd5..146981f 100644
--- a/sound/soc/fsl/fsl_ssi.h
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -1,12 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * fsl_ssi.h - ALSA SSI interface for the Freescale MPC8610 and i.MX SoC
  *
  * Author: Timur Tabi <timur@freescale.com>
- *
- * Copyright 2007-2008 Freescale Semiconductor, Inc.  This file is licensed
- * under the terms of the GNU General Public License version 2.  This
- * program is licensed "as is" without any warranty of any kind, whether
- * express or implied.
  */
 
 #ifndef _MPC8610_I2S_H
diff --git a/sound/soc/fsl/fsl_ssi_dbg.c b/sound/soc/fsl/fsl_ssi_dbg.c
index 7aac63e..ddf2f64 100644
--- a/sound/soc/fsl/fsl_ssi_dbg.c
+++ b/sound/soc/fsl/fsl_ssi_dbg.c
@@ -1,14 +1,10 @@
-/*
- * Freescale SSI ALSA SoC Digital Audio Interface (DAI) debugging functions
- *
- * Copyright 2014 Markus Pargmann <mpa@pengutronix.de>, Pengutronix
- *
- * Splitted from fsl_ssi.c
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Freescale SSI ALSA SoC Digital Audio Interface (DAI) debugging functions
+//
+// Copyright 2014 Markus Pargmann <mpa@pengutronix.de>, Pengutronix
+//
+// Split from fsl_ssi.c
 
 #include <linux/debugfs.h>
 #include <linux/device.h>
-- 
2.7.4
