From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] ASoC: Remove unused header
Date: Thu, 10 Jun 2010 17:54:13 -0600
Message-ID: <20100610235348.29652.91350.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Herb Peyerl <hpeyerl@beer.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The header contains an extern that isn't used by anything.  Remove.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Jon Smirl <jonsmirl@gmail.com>
Cc: Herb Peyerl <hpeyerl@beer.org>
---
 sound/soc/fsl/mpc5200_psc_i2s.c |    1 -
 sound/soc/fsl/mpc5200_psc_i2s.h |   12 ------------
 2 files changed, 0 insertions(+), 13 deletions(-)
 delete mode 100644 sound/soc/fsl/mpc5200_psc_i2s.h

diff --git a/sound/soc/fsl/mpc5200_psc_i2s.c b/sound/soc/fsl/mpc5200_psc_i2s.c
index 4f455bd..676841c 100644
--- a/sound/soc/fsl/mpc5200_psc_i2s.c
+++ b/sound/soc/fsl/mpc5200_psc_i2s.c
@@ -16,7 +16,6 @@
 
 #include <asm/mpc52xx_psc.h>
 
-#include "mpc5200_psc_i2s.h"
 #include "mpc5200_dma.h"
 
 /**
diff --git a/sound/soc/fsl/mpc5200_psc_i2s.h b/sound/soc/fsl/mpc5200_psc_i2s.h
deleted file mode 100644
index ce55e07..0000000
--- a/sound/soc/fsl/mpc5200_psc_i2s.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * Freescale MPC5200 PSC in I2S mode
- * ALSA SoC Digital Audio Interface (DAI) driver
- *
- */
-
-#ifndef __SOUND_SOC_FSL_MPC52xx_PSC_I2S_H__
-#define __SOUND_SOC_FSL_MPC52xx_PSC_I2S_H__
-
-extern struct snd_soc_dai psc_i2s_dai[];
-
-#endif /* __SOUND_SOC_FSL_MPC52xx_PSC_I2S_H__ */
