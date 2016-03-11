From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci: Kconfig: Update the edma-pcm
	section's dependency and help
Date: Fri, 11 Mar 2016 16:04:20 +0200
Message-ID: <1457705060-7504-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 632182606AB
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2016 15:07:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Instead of depending on individual SoCs make the edma-pcm depend on the eDMA
dmaengine driver (TI_EDMA).
Update the help text and add DRA7xx family since they have eDMA integrated
as well along with sDMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index e0f6581494bf..a834558fd01e 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -5,7 +5,7 @@ config SND_DAVINCI_SOC
 
 config SND_EDMA_SOC
 	tristate "SoC Audio for Texas Instruments chips using eDMA"
-	depends on SOC_AM33XX || SOC_AM43XX || ARCH_DAVINCI
+	depends on TI_EDMA
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 	  Say Y or M here if you want audio support for TI SoC which uses eDMA.
@@ -13,6 +13,7 @@ config SND_EDMA_SOC
 	  - daVinci devices
 	  - AM335x
 	  - AM437x/AM438x
+	  - DRA7xx family
 
 config SND_DAVINCI_SOC_I2S
 	tristate
-- 
2.7.2
