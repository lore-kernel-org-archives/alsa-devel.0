From: Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 10/20] ASoC: imx-ssi: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:50:00 +0300
Message-ID: <20190405115010.28838-11-andradanciu1997@gmail.com>
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
 sound/soc/fsl/imx-ssi.c | 57 ++++++++++++++++++++++---------------------------
 sound/soc/fsl/imx-ssi.h |  6 +-----
 2 files changed, 26 insertions(+), 37 deletions(-)

diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 06790615e04e..9038b61317be 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -1,35 +1,28 @@
-/*
- * imx-ssi.c  --  ALSA Soc Audio Layer
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
- *
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
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// imx-ssi.c  --  ALSA Soc Audio Layer
+//
+// Copyright 2009 Sascha Hauer <s.hauer@pengutronix.de>
+//
+// This code is based on code copyrighted by Freescale,
+// Liam Girdwood, Javier Martin and probably others.
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
 
 #include <linux/clk.h>
 #include <linux/delay.h>
diff --git a/sound/soc/fsl/imx-ssi.h b/sound/soc/fsl/imx-ssi.h
index be6562365b6a..19cd0937e740 100644
--- a/sound/soc/fsl/imx-ssi.h
+++ b/sound/soc/fsl/imx-ssi.h
@@ -1,8 +1,4 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+/* SPDX-License-Identifier: GPL-2.0 */
 
 #ifndef _IMX_SSI_H
 #define _IMX_SSI_H
-- 
2.11.0
