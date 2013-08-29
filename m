From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl: Drop SND_SOC_FSL_UTILS from
	SND_SOC_IMX_SPDIF
Date: Thu, 29 Aug 2013 17:31:41 -0300
Message-ID: <1377808301-10344-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qe0-f48.google.com (mail-qe0-f48.google.com
 [209.85.128.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 564DB265591
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 22:31:50 +0200 (CEST)
Received: by mail-qe0-f48.google.com with SMTP id t9so83516qeq.35
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 13:31:49 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, b42378@freescale.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

SND_SOC_FSL_UTILS is only used by PowerPC machines, so let's drop it in the
i.mx case.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index a708380..704e246 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -197,7 +197,6 @@ config SND_SOC_IMX_SPDIF
 	tristate "SoC Audio support for i.MX boards with S/PDIF"
 	select SND_SOC_IMX_PCM_DMA
 	select SND_SOC_FSL_SPDIF
-	select SND_SOC_FSL_UTILS
 	select SND_SOC_SPDIF
 	help
 	  SoC Audio support for i.MX boards with S/PDIF
-- 
1.8.1.2
