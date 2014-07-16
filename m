From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/3] ASoC: davinci-mcasp: Use dmaengine based
	platform driver for AM335x/447x
Date: Wed, 16 Jul 2014 15:12:04 +0300
Message-ID: <1405512724-23628-4-git-send-email-peter.ujfalusi@ti.com>
References: <1405512724-23628-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id A17B826513F
 for <alsa-devel@alsa-project.org>; Wed, 16 Jul 2014 14:12:14 +0200 (CEST)
In-Reply-To: <1405512724-23628-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Use the edma-pcm with AM335x and AM437x SoCs.
Keep using the davinci-pcm for daVinci devices, they can be switched to use
the dmaengine based driver later when they are verified to work correctly.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/Kconfig         | 18 ++++++++++++++----
 sound/soc/davinci/Makefile        |  2 ++
 sound/soc/davinci/davinci-mcasp.c | 11 +++++++++--
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/sound/soc/davinci/Kconfig b/sound/soc/davinci/Kconfig
index fdbb16fffd30..b310dd3489ac 100644
--- a/sound/soc/davinci/Kconfig
+++ b/sound/soc/davinci/Kconfig
@@ -1,12 +1,22 @@
 config SND_DAVINCI_SOC
-	tristate "SoC Audio for TI DAVINCI or AM33XX/AM43XX chips"
-	depends on ARCH_DAVINCI || SOC_AM33XX || SOC_AM43XX
+	tristate "SoC Audio for TI DAVINCI"
+	depends on ARCH_DAVINCI
+
+config SND_EDMA_SOC
+	tristate "SoC Audio for Texas Instruments chips using eDMA (AM33XX/43XX)"
+	depends on SOC_AM33XX || SOC_AM43XX
+	select SND_SOC_GENERIC_DMAENGINE_PCM
+	help
+	  Say Y or M here if you want audio support for TI SoC which uses eDMA.
+	  The following line of SoCs are supported by this platform driver:
+	  - AM335x
+	  - AM437x/AM438x
 
 config SND_DAVINCI_SOC_I2S
 	tristate
 
 config SND_DAVINCI_SOC_MCASP
-	depends on SND_DAVINCI_SOC || SND_OMAP_SOC
+	depends on SND_DAVINCI_SOC || SND_OMAP_SOC || SND_EDMA_SOC
 	tristate
 
 config SND_DAVINCI_SOC_VCIF
@@ -19,7 +29,7 @@ config SND_DAVINCI_SOC_GENERIC_EVM
 
 config SND_AM33XX_SOC_EVM
 	tristate "SoC Audio for the AM33XX chip based boards"
-	depends on SND_DAVINCI_SOC && SOC_AM33XX && I2C
+	depends on SND_EDMA_SOC && SOC_AM33XX && I2C
 	select SND_DAVINCI_SOC_GENERIC_EVM
 	help
 	  Say Y or M if you want to add support for SoC audio on AM33XX
diff --git a/sound/soc/davinci/Makefile b/sound/soc/davinci/Makefile
index 744d4d9a0184..09bf2ba92d38 100644
--- a/sound/soc/davinci/Makefile
+++ b/sound/soc/davinci/Makefile
@@ -1,10 +1,12 @@
 # DAVINCI Platform Support
 snd-soc-davinci-objs := davinci-pcm.o
+snd-soc-edma-objs := edma-pcm.o
 snd-soc-davinci-i2s-objs := davinci-i2s.o
 snd-soc-davinci-mcasp-objs:= davinci-mcasp.o
 snd-soc-davinci-vcif-objs:= davinci-vcif.o
 
 obj-$(CONFIG_SND_DAVINCI_SOC) += snd-soc-davinci.o
+obj-$(CONFIG_SND_EDMA_SOC) += snd-soc-edma.o
 obj-$(CONFIG_SND_DAVINCI_SOC_I2S) += snd-soc-davinci-i2s.o
 obj-$(CONFIG_SND_DAVINCI_SOC_MCASP) += snd-soc-davinci-mcasp.o
 obj-$(CONFIG_SND_DAVINCI_SOC_VCIF) += snd-soc-davinci-vcif.o
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index f7dc538679b1..02421d4275f5 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -37,6 +37,7 @@
 #include <sound/omap-pcm.h>
 
 #include "davinci-pcm.h"
+#include "edma-pcm.h"
 #include "davinci-mcasp.h"
 
 #define MCASP_MAX_AFIFO_DEPTH	64
@@ -831,7 +832,7 @@ static int davinci_mcasp_dai_probe(struct snd_soc_dai *dai)
 {
 	struct davinci_mcasp *mcasp = snd_soc_dai_get_drvdata(dai);
 
-	if (mcasp->version == MCASP_VERSION_4) {
+	if (mcasp->version >= MCASP_VERSION_3) {
 		/* Using dmaengine PCM */
 		dai->playback_dma_data =
 				&mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
@@ -1281,10 +1282,16 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	 IS_MODULE(CONFIG_SND_DAVINCI_SOC))
 	case MCASP_VERSION_1:
 	case MCASP_VERSION_2:
-	case MCASP_VERSION_3:
 		ret = davinci_soc_platform_register(&pdev->dev);
 		break;
 #endif
+#if IS_BUILTIN(CONFIG_SND_EDMA_SOC) || \
+	(IS_MODULE(CONFIG_SND_DAVINCI_SOC_MCASP) && \
+	 IS_MODULE(CONFIG_SND_EDMA_SOC))
+	case MCASP_VERSION_3:
+		ret = edma_pcm_platform_register(&pdev->dev);
+		break;
+#endif
 #if IS_BUILTIN(CONFIG_SND_OMAP_SOC) || \
 	(IS_MODULE(CONFIG_SND_DAVINCI_SOC_MCASP) && \
 	 IS_MODULE(CONFIG_SND_OMAP_SOC))
-- 
2.0.0
