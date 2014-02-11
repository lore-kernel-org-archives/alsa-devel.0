From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH 1/2] ASoC: fsl: make sure the regmap-mmio is
	actually enabled
Date: Tue, 11 Feb 2014 10:47:04 +0800
Message-ID: <1392086825-15737-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 by alsa0.perex.cz (Postfix) with ESMTP id 595EF2610C5
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2014 04:51:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, Guangyu.Chen@freescale.com, shawn.guo@linaro.org
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, Mark Brown <broonie@linaro.org>, tiwai@suse.de, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Since the Freescale SAI, ESAI and SPDIF are using the regmap-mmio,
there needs a select of REGMAP_MMIO in the Kconfig to ensure that
regmap-mmio is actually enabled.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
Cc: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: Mark Brown <broonie@linaro.org>
---
 sound/soc/fsl/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 07f8f14..d0914c0 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -1,5 +1,6 @@
 config SND_SOC_FSL_SAI
 	tristate
+	select REGMAP_MMIO
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 
 config SND_SOC_FSL_SSI
@@ -7,9 +8,11 @@ config SND_SOC_FSL_SSI
 
 config SND_SOC_FSL_SPDIF
 	tristate
+	select REGMAP_MMIO
 
 config SND_SOC_FSL_ESAI
 	tristate
+	select REGMAP_MMIO
 
 config SND_SOC_FSL_UTILS
 	tristate
@@ -204,7 +207,6 @@ config SND_SOC_IMX_SPDIF
 	tristate "SoC Audio support for i.MX boards with S/PDIF"
 	select SND_SOC_IMX_PCM_DMA
 	select SND_SOC_FSL_SPDIF
-	select REGMAP_MMIO
 	help
 	  SoC Audio support for i.MX boards with S/PDIF
 	  Say Y if you want to add support for SoC audio on an i.MX board with
-- 
1.8.4
