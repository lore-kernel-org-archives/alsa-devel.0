From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl: Drop SND_SOC_FSL_UTILS from i.mx
	machine code
Date: Sat, 17 Aug 2013 16:38:12 -0300
Message-ID: <1376768292-852-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f171.google.com (mail-gh0-f171.google.com
 [209.85.160.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 692822610CB
 for <alsa-devel@alsa-project.org>; Sat, 17 Aug 2013 21:38:23 +0200 (CEST)
Received: by mail-gh0-f171.google.com with SMTP id f15so577457ghb.16
 for <alsa-devel@alsa-project.org>; Sat, 17 Aug 2013 12:38:22 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

SND_SOC_FSL_UTILS is only used by PowerPC machines, so let's drop it in the
i.mx case.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index e15f771..3a4808d 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -175,7 +175,6 @@ config SND_SOC_IMX_WM8962
 	select SND_SOC_IMX_PCM_DMA
 	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_FSL_SSI
-	select SND_SOC_FSL_UTILS
 	help
 	  Say Y if you want to add support for SoC audio on an i.MX board with
 	  a wm8962 codec.
@@ -187,7 +186,6 @@ config SND_SOC_IMX_SGTL5000
 	select SND_SOC_IMX_PCM_DMA
 	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_FSL_SSI
-	select SND_SOC_FSL_UTILS
 	help
 	  Say Y if you want to add support for SoC audio on an i.MX board with
 	  a sgtl5000 codec.
-- 
1.8.1.2
