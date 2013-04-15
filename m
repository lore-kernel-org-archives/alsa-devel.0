From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/17] ASoC: imx: Use generic dmaengine PCM
Date: Mon, 15 Apr 2013 19:19:59 +0200
Message-ID: <1366046404-8759-13-git-send-email-lars@metafoo.de>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-031.synserver.de (smtp-out-037.synserver.de
 [212.40.185.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 0456C265259
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 19:21:27 +0200 (CEST)
In-Reply-To: <1366046404-8759-1-git-send-email-lars@metafoo.de>
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
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Use the generic dmaengine PCM driver instead of a custom implementation.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/fsl/Kconfig       |  2 +-
 sound/soc/fsl/imx-pcm-dma.c | 76 +++++++++------------------------------------
 sound/soc/fsl/imx-pcm.c     |  6 +++-
 sound/soc/fsl/imx-pcm.h     |  5 +++
 4 files changed, 26 insertions(+), 63 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 3b98159..3843a18 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -118,7 +118,7 @@ config SND_SOC_IMX_PCM_FIQ
 
 config SND_SOC_IMX_PCM_DMA
 	bool
-	select SND_SOC_DMAENGINE_PCM
+	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select SND_SOC_IMX_PCM
 
 config SND_SOC_IMX_AUDMUX
diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index c664782..c246fb5 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -11,22 +11,12 @@
  *  Free Software Foundation;  either version 2 of the  License, or (at your
  *  option) any later version.
  */
-#include <linux/clk.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/dma-mapping.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/slab.h>
 #include <linux/dmaengine.h>
 #include <linux/types.h>
 
 #include <sound/core.h>
-#include <sound/initval.h>
 #include <sound/pcm.h>
-#include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include <sound/dmaengine_pcm.h>
 
@@ -44,32 +34,7 @@ static bool filter(struct dma_chan *chan, void *param)
 	return true;
 }
 
-static int snd_imx_pcm_hw_params(struct snd_pcm_substream *substream,
-				struct snd_pcm_hw_params *params)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct dma_chan *chan = snd_dmaengine_pcm_get_chan(substream);
-	struct dma_slave_config slave_config;
-	int ret;
-
-	ret = snd_hwparams_to_dma_slave_config(substream, params, &slave_config);
-	if (ret)
-		return ret;
-
-	snd_dmaengine_pcm_set_config_from_dai_data(substream,
-			snd_soc_dai_get_dma_data(rtd->cpu_dai, substream),
-			&slave_config);
-
-	ret = dmaengine_slave_config(chan, &slave_config);
-	if (ret)
-		return ret;
-
-	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
-
-	return 0;
-}
-
-static struct snd_pcm_hardware snd_imx_hardware = {
+static const struct snd_pcm_hardware imx_pcm_hardware = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_MMAP |
@@ -88,33 +53,22 @@ static struct snd_pcm_hardware snd_imx_hardware = {
 	.fifo_size = 0,
 };
 
-static int snd_imx_open(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-
-	snd_soc_set_runtime_hwparams(substream, &snd_imx_hardware);
-
-	return snd_dmaengine_pcm_open(substream, filter,
-		snd_soc_dai_get_dma_data(rtd->cpu_dai, substream));
-}
-
-static struct snd_pcm_ops imx_pcm_ops = {
-	.open		= snd_imx_open,
-	.close		= snd_dmaengine_pcm_close_release_chan,
-	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= snd_imx_pcm_hw_params,
-	.trigger	= snd_dmaengine_pcm_trigger,
-	.pointer	= snd_dmaengine_pcm_pointer_no_residue,
-	.mmap		= snd_imx_pcm_mmap,
-};
-
-static struct snd_soc_platform_driver imx_soc_platform_mx2 = {
-	.ops		= &imx_pcm_ops,
-	.pcm_new	= imx_pcm_new,
-	.pcm_free	= imx_pcm_free,
+static const struct snd_dmaengine_pcm_config imx_dmaengine_pcm_config = {
+	.pcm_hardware = &imx_pcm_hardware,
+	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
+	.compat_filter_fn = filter,
+	.prealloc_buffer_size = IMX_SSI_DMABUF_SIZE,
 };
 
 int imx_pcm_dma_init(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&pdev->dev, &imx_soc_platform_mx2);
+	return snd_dmaengine_pcm_register(&pdev->dev, &imx_dmaengine_pcm_config,
+		SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
+		SND_DMAENGINE_PCM_FLAG_NO_DT |
+		SND_DMAENGINE_PCM_FLAG_COMPAT);
+}
+
+void imx_pcm_dma_exit(struct platform_device *pdev)
+{
+	snd_dmaengine_pcm_unregister(&pdev->dev);
 }
diff --git a/sound/soc/fsl/imx-pcm.c b/sound/soc/fsl/imx-pcm.c
index 0d0625b..c498964 100644
--- a/sound/soc/fsl/imx-pcm.c
+++ b/sound/soc/fsl/imx-pcm.c
@@ -114,7 +114,11 @@ static int imx_pcm_probe(struct platform_device *pdev)
 
 static int imx_pcm_remove(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&pdev->dev);
+	if (strcmp(pdev->id_entry->name, "imx-fiq-pcm-audio") == 0)
+		snd_soc_unregister_platform(&pdev->dev);
+	else
+		imx_pcm_dma_exit(pdev);
+
 	return 0;
 }
 
diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
index be9cc64..b7fa0d7 100644
--- a/sound/soc/fsl/imx-pcm.h
+++ b/sound/soc/fsl/imx-pcm.h
@@ -39,11 +39,16 @@ void imx_pcm_free(struct snd_pcm *pcm);
 
 #ifdef CONFIG_SND_SOC_IMX_PCM_DMA
 int imx_pcm_dma_init(struct platform_device *pdev);
+void imx_pcm_dma_exit(struct platform_device *pdev);
 #else
 static inline int imx_pcm_dma_init(struct platform_device *pdev)
 {
 	return -ENODEV;
 }
+
+static inline void imx_pcm_dma_exit(struct platform_device *pdev)
+{
+}
 #endif
 
 #ifdef CONFIG_SND_SOC_IMX_PCM_FIQ
-- 
1.8.0
