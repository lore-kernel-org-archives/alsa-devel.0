From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/2] ASoC: fsl: remove redundant Kconfig
	dependency on SND_SOC_POWERPC_DMA
Date: Fri, 30 Mar 2012 12:31:32 +0800
Message-ID: <1333081892-8808-2-git-send-email-shawn.guo@linaro.org>
References: <1333081892-8808-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 09C9F10458E
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Mar 2012 06:31:40 +0200 (CEST)
Received: by mail-iy0-f179.google.com with SMTP id h37so441725iak.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2012 21:31:41 -0700 (PDT)
In-Reply-To: <1333081892-8808-1-git-send-email-shawn.guo@linaro.org>
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

Kconfig option SND_SOC_POWERPC_DMA is under menuconfig SND_POWERPC_SOC.
Since SND_POWERPC_SOC already depends on FSL_SOC, there is no need for
SND_SOC_POWERPC_DMA to do the same.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/fsl/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index d23d612..0094789 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -18,7 +18,6 @@ config SND_MPC52xx_DMA
 
 config SND_SOC_POWERPC_DMA
 	tristate
-	depends on FSL_SOC
 
 config SND_SOC_MPC8610_HPCD
 	tristate "ALSA SoC support for the Freescale MPC8610 HPCD board"
-- 
1.7.5.4
