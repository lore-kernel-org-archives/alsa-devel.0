From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/2] ASoC: fsl: remove redundant Kconfig option
	SND_SOC_FSL_SSI
Date: Fri, 30 Mar 2012 12:31:31 +0800
Message-ID: <1333081892-8808-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 461E910B93D
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Mar 2012 06:31:37 +0200 (CEST)
Received: by iakh37 with SMTP id h37so441725iak.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2012 21:31:36 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

While commit 606d620 (ASoC: imx: merge sound/soc/imx into sound/soc/fsl)
adds SND_SOC_FSL_SSI outside "menuconfig SND_POWERPC_SOC" to make it
visible for both PowerPC and ARM/IMX, it forgot removing the one inside
"menuconfig SND_POWERPC_SOC".

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/Kconfig |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index aa14fc9..d23d612 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -16,10 +16,6 @@ if SND_POWERPC_SOC
 config SND_MPC52xx_DMA
 	tristate
 
-config SND_SOC_FSL_SSI
-	tristate
-	depends on FSL_SOC
-
 config SND_SOC_POWERPC_DMA
 	tristate
 	depends on FSL_SOC
-- 
1.7.5.4
