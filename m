From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 17/17] ASoC: ux500: Use generic dmaengine PCM
Date: Mon, 15 Apr 2013 19:20:04 +0200
Message-ID: <1366046404-8759-18-git-send-email-lars@metafoo.de>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-031.synserver.de (smtp-out-037.synserver.de
 [212.40.185.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 59A4B265213
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 19:21:43 +0200 (CEST)
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

Use the generic dmaengine PCM driver instead of a custom implemention.  There is
a minor functional change, the ux500 PCM driver did not preallocate the audio
buffer, while the generic dmaengine PCM driver will do this.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/dmaengine_pcm.h |   2 +-
 sound/soc/ux500/Kconfig       |   2 +-
 sound/soc/ux500/ux500_pcm.c   | 159 +++++-------------------------------------
 3 files changed, 19 insertions(+), 144 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index e705286..b1d1150 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -87,7 +87,7 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
  */
 #define SND_DMAENGINE_PCM_FLAG_NO_DT BIT(1)
 /*
- * The platforms dmaengine driver does not support reporting the ammount of
+ * The platforms dmaengine driver does not support reporting the amount of
  * bytes that are still left to transfer.
  */
 #define SND_DMAENGINE_PCM_FLAG_NO_RESIDUE BIT(2)
diff --git a/sound/soc/ux500/Kconfig b/sound/soc/ux500/Kconfig
index 069330d..c73c590 100644
--- a/sound/soc/ux500/Kconfig
+++ b/sound/soc/ux500/Kconfig
@@ -16,7 +16,7 @@ config SND_SOC_UX500_PLAT_MSP_I2S
 config SND_SOC_UX500_PLAT_DMA
 	tristate "Platform - DB8500 (DMA)"
 	depends on SND_SOC_UX500
-	select SND_SOC_DMAENGINE_PCM
+	select SND_SOC_GENERIC_DMAENGINE_PCM
 	help
 		Say Y if you want to enable the Ux500 platform-driver.
 
diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index a7d4f04..b6e5ae2 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -40,7 +40,7 @@
 #define UX500_PLATFORM_PERIODS_MAX		48
 #define UX500_PLATFORM_BUFFER_BYTES_MAX		(2048 * PAGE_SIZE)
 
-static struct snd_pcm_hardware ux500_pcm_hw = {
+static const struct snd_pcm_hardware ux500_pcm_hw = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_MMAP |
 		SNDRV_PCM_INFO_RESUME |
@@ -61,43 +61,23 @@ static struct snd_pcm_hardware ux500_pcm_hw = {
 	.periods_max = UX500_PLATFORM_PERIODS_MAX,
 };
 
-static void ux500_pcm_dma_hw_free(struct device *dev,
-				struct snd_pcm_substream *substream)
+static struct dma_chan *ux500_pcm_request_chan(struct snd_soc_pcm_runtime *rtd,
+	struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_dma_buffer *buf = runtime->dma_buffer_p;
-
-	if (runtime->dma_area == NULL)
-		return;
-
-	if (buf != &substream->dma_buffer) {
-		dma_free_coherent(buf->dev.dev, buf->bytes, buf->area,
-				buf->addr);
-		kfree(runtime->dma_buffer_p);
-	}
-
-	snd_pcm_set_runtime_buffer(substream, NULL);
-}
-
-static int ux500_pcm_open(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *dai = rtd->cpu_dai;
 	struct device *dev = dai->dev;
-	int ret;
-	struct ux500_msp_dma_params *dma_params;
 	u16 per_data_width, mem_data_width;
 	struct stedma40_chan_cfg *dma_cfg;
+	struct ux500_msp_dma_params *dma_params;
 
 	dev_dbg(dev, "%s: MSP %d (%s): Enter.\n", __func__, dai->id,
 		snd_pcm_stream_str(substream));
 
-	dev_dbg(dev, "%s: Set runtime hwparams.\n", __func__);
-	snd_soc_set_runtime_hwparams(substream, &ux500_pcm_hw);
+	dma_params = snd_soc_dai_get_dma_data(dai, substream);
+	dma_cfg = dma_params->dma_cfg;
 
 	mem_data_width = STEDMA40_HALFWORD_WIDTH;
 
-	dma_params = snd_soc_dai_get_dma_data(dai, substream);
 	switch (dma_params->data_size) {
 	case 32:
 		per_data_width = STEDMA40_WORD_WIDTH;
@@ -110,13 +90,8 @@ static int ux500_pcm_open(struct snd_pcm_substream *substream)
 		break;
 	default:
 		per_data_width = STEDMA40_WORD_WIDTH;
-		dev_warn(rtd->platform->dev,
-			"%s: Unknown data-size (%d)! Assuming 32 bits.\n",
-			__func__, dma_params->data_size);
 	}
 
-	dma_cfg = dma_params->dma_cfg;
-
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		dma_cfg->src_info.data_width = mem_data_width;
 		dma_cfg->dst_info.data_width = per_data_width;
@@ -125,123 +100,24 @@ static int ux500_pcm_open(struct snd_pcm_substream *substream)
 		dma_cfg->dst_info.data_width = mem_data_width;
 	}
 
-	ret = snd_dmaengine_pcm_open_request_chan(substream, stedma40_filter,
-			dma_cfg);
-	if (ret) {
-		dev_dbg(dai->dev,
-			"%s: ERROR: snd_dmaengine_pcm_open failed (%d)!\n",
-			__func__, ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int ux500_pcm_hw_params(struct snd_pcm_substream *substream,
-			struct snd_pcm_hw_params *hw_params)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_dma_buffer *buf = runtime->dma_buffer_p;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	int ret = 0;
-	int size;
-
-	dev_dbg(rtd->platform->dev, "%s: Enter\n", __func__);
-
-	size = params_buffer_bytes(hw_params);
-
-	if (buf) {
-		if (buf->bytes >= size)
-			goto out;
-		ux500_pcm_dma_hw_free(NULL, substream);
-	}
-
-	if (substream->dma_buffer.area != NULL &&
-		substream->dma_buffer.bytes >= size) {
-		buf = &substream->dma_buffer;
-	} else {
-		buf = kmalloc(sizeof(struct snd_dma_buffer), GFP_KERNEL);
-		if (!buf)
-			goto nomem;
-
-		buf->dev.type = SNDRV_DMA_TYPE_DEV;
-		buf->dev.dev = NULL;
-		buf->area = dma_alloc_coherent(NULL, size, &buf->addr,
-					GFP_KERNEL);
-		buf->bytes = size;
-		buf->private_data = NULL;
-
-		if (!buf->area)
-			goto free;
-	}
-	snd_pcm_set_runtime_buffer(substream, buf);
-	ret = 1;
- out:
-	runtime->dma_bytes = size;
-	return ret;
-
- free:
-	kfree(buf);
- nomem:
-	return -ENOMEM;
-}
-
-static int ux500_pcm_hw_free(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-
-	dev_dbg(rtd->platform->dev, "%s: Enter\n", __func__);
-
-	ux500_pcm_dma_hw_free(NULL, substream);
-
-	return 0;
+	return snd_dmaengine_pcm_request_channel(stedma40_filter, dma_cfg);
 }
 
-static int ux500_pcm_mmap(struct snd_pcm_substream *substream,
-			struct vm_area_struct *vma)
-{
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-
-	dev_dbg(rtd->platform->dev, "%s: Enter.\n", __func__);
-
-	return dma_mmap_coherent(NULL, vma, runtime->dma_area,
-				runtime->dma_addr, runtime->dma_bytes);
-}
-
-static struct snd_pcm_ops ux500_pcm_ops = {
-	.open		= ux500_pcm_open,
-	.close		= snd_dmaengine_pcm_close_release_chan,
-	.ioctl		= snd_pcm_lib_ioctl,
-	.hw_params	= ux500_pcm_hw_params,
-	.hw_free	= ux500_pcm_hw_free,
-	.trigger	= snd_dmaengine_pcm_trigger,
-	.pointer	= snd_dmaengine_pcm_pointer_no_residue,
-	.mmap		= ux500_pcm_mmap
-};
-
-int ux500_pcm_new(struct snd_soc_pcm_runtime *rtd)
-{
-	struct snd_pcm *pcm = rtd->pcm;
-
-	dev_dbg(rtd->platform->dev, "%s: Enter (id = '%s').\n", __func__,
-		pcm->id);
-
-	pcm->info_flags = 0;
-
-	return 0;
-}
-
-static struct snd_soc_platform_driver ux500_pcm_soc_drv = {
-	.ops		= &ux500_pcm_ops,
-	.pcm_new        = ux500_pcm_new,
+static const struct snd_dmaengine_pcm_config ux500_dmaengine_pcm_config = {
+	.pcm_hardware = &ux500_pcm_hw,
+	.compat_request_channel = ux500_pcm_request_chan,
+	.prealloc_buffer_size = 128 * 1024,
 };
 
 int ux500_pcm_register_platform(struct platform_device *pdev)
 {
 	int ret;
 
-	ret = snd_soc_register_platform(&pdev->dev, &ux500_pcm_soc_drv);
+	ret = snd_dmaengine_pcm_register(&pdev->dev,
+			&ux500_dmaengine_pcm_config,
+			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
+			SND_DMAENGINE_PCM_FLAG_COMPAT |
+			SND_DMAENGINE_PCM_FLAG_NO_DT);
 	if (ret < 0) {
 		dev_err(&pdev->dev,
 			"%s: ERROR: Failed to register platform '%s' (%d)!\n",
@@ -255,8 +131,7 @@ EXPORT_SYMBOL_GPL(ux500_pcm_register_platform);
 
 int ux500_pcm_unregister_platform(struct platform_device *pdev)
 {
-	snd_soc_unregister_platform(&pdev->dev);
-
+	snd_dmaengine_pcm_unregister(&pdev->dev);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ux500_pcm_unregister_platform);
-- 
1.8.0
