From: Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 03/20] ASoC: eukrea-tlv320: Switch to SPDX identifier
Date: Fri,  5 Apr 2019 14:49:53 +0300
Message-ID: <20190405115010.28838-4-andradanciu1997@gmail.com>
References: <20190405115010.28838-1-andradanciu1997@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
 sound/soc/fsl/eukrea-tlv320.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/eukrea-tlv320.c b/sound/soc/fsl/eukrea-tlv320.c
index 30a3d68b5c03..d648268cb454 100644
--- a/sound/soc/fsl/eukrea-tlv320.c
+++ b/sound/soc/fsl/eukrea-tlv320.c
@@ -1,19 +1,13 @@
-/*
- * eukrea-tlv320.c  --  SoC audio for eukrea_cpuimxXX in I2S mode
- *
- * Copyright 2010 Eric Bénard, Eukréa Electromatique <eric@eukrea.com>
- *
- * based on sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
- * which is Copyright 2009 Simtec Electronics
- * and on sound/soc/imx/phycore-ac97.c which is
- * Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// eukrea-tlv320.c  --  SoC audio for eukrea_cpuimxXX in I2S mode
+//
+// Copyright 2010 Eric Bénard, Eukréa Electromatique <eric@eukrea.com>
+//
+// based on sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
+// which is Copyright 2009 Simtec Electronics
+// and on sound/soc/imx/phycore-ac97.c which is
+// Copyright 2009 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
 
 #include <linux/errno.h>
 #include <linux/module.h>
-- 
2.11.0
