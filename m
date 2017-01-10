From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: mpc5200_psc_ac97: Remove unused DAI ID
	defines
Date: Tue, 10 Jan 2017 19:41:39 +0100
Message-ID: <1484073699-23989-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A6A626740A
 for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2017 19:41:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The DAI ID defines are back from the time when DAIs were referenced by a
numerical ID. These days a string is used instead and the defines are
unused. The last user of these defines was removed in commit f0fba2ad1b6b
("ASoC: multi-component - ASoC Multi-Component Support"). So remove the
defines as well.

This also means the mpc5200_psc_ac97.h file no longer has any content and
can be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/fsl/efika-audio-fabric.c |  1 -
 sound/soc/fsl/mpc5200_psc_ac97.c   |  1 -
 sound/soc/fsl/mpc5200_psc_ac97.h   | 13 -------------
 3 files changed, 15 deletions(-)
 delete mode 100644 sound/soc/fsl/mpc5200_psc_ac97.h

diff --git a/sound/soc/fsl/efika-audio-fabric.c b/sound/soc/fsl/efika-audio-fabric.c
index f200d1c..667f421 100644
--- a/sound/soc/fsl/efika-audio-fabric.c
+++ b/sound/soc/fsl/efika-audio-fabric.c
@@ -26,7 +26,6 @@
 #include <sound/soc.h>
 
 #include "mpc5200_dma.h"
-#include "mpc5200_psc_ac97.h"
 
 #define DRV_NAME "efika-audio-fabric"
 
diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index 243700c..07ee355 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -25,7 +25,6 @@
 #include <asm/mpc52xx_psc.h>
 
 #include "mpc5200_dma.h"
-#include "mpc5200_psc_ac97.h"
 
 #define DRV_NAME "mpc5200-psc-ac97"
 
diff --git a/sound/soc/fsl/mpc5200_psc_ac97.h b/sound/soc/fsl/mpc5200_psc_ac97.h
deleted file mode 100644
index e881e78..0000000
--- a/sound/soc/fsl/mpc5200_psc_ac97.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * Freescale MPC5200 PSC in AC97 mode
- * ALSA SoC Digital Audio Interface (DAI) driver
- *
- */
-
-#ifndef __SOUND_SOC_FSL_MPC52xx_PSC_AC97_H__
-#define __SOUND_SOC_FSL_MPC52xx_PSC_AC97_H__
-
-#define MPC5200_AC97_NORMAL 0
-#define MPC5200_AC97_SPDIF 1
-
-#endif /* __SOUND_SOC_FSL_MPC52xx_PSC_AC97_H__ */
-- 
2.1.4
