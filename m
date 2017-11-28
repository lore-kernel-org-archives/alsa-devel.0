From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH] ASoC: amd: added error checks in dma driver
Date: Tue, 28 Nov 2017 10:13:44 +0530
Message-ID: <1511844224-32404-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, lgirdwood@gmail.com, perex@perex.cz, Alexander.Deucher@amd.com, linux-kernel@vger.kernel.org, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
List-Id: alsa-devel@alsa-project.org

added additional error checks in acp dma driver

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index fb09578..71ab5b5 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -848,6 +848,9 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
 
+	if (!rtd)
+		return -EINVAL;
+
 	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
 	bytescount = acp_get_byte_count(rtd->acp_mmio, substream->stream);
 
@@ -873,6 +876,8 @@ static int acp_dma_prepare(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
 
+	if (!rtd)
+		return -EINVAL;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		config_acp_dma_channel(rtd->acp_mmio, SYSRAM_TO_ACP_CH_NUM,
 					PLAYBACK_START_DMA_DESCR_CH12,
@@ -1082,7 +1087,11 @@ static int acp_audio_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, audio_drv_data);
 
 	/* Initialize the ACP */
-	acp_init(audio_drv_data->acp_mmio, audio_drv_data->asic_type);
+	status = acp_init(audio_drv_data->acp_mmio, audio_drv_data->asic_type);
+	if (status) {
+		dev_err(&pdev->dev, "ACP Init failed\n");
+		return status;
+	}
 
 	status = snd_soc_register_platform(&pdev->dev, &acp_asoc_platform);
 	if (status != 0) {
@@ -1099,9 +1108,14 @@ static int acp_audio_probe(struct platform_device *pdev)
 
 static int acp_audio_remove(struct platform_device *pdev)
 {
+	int status;
 	struct audio_drv_data *adata = dev_get_drvdata(&pdev->dev);
 
-	acp_deinit(adata->acp_mmio);
+	status = acp_deinit(adata->acp_mmio);
+	if (status) {
+		dev_err(&pdev->dev, "ACP Deinit failed\n");
+		return status;
+	}
 	snd_soc_unregister_platform(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
@@ -1111,9 +1125,14 @@ static int acp_audio_remove(struct platform_device *pdev)
 static int acp_pcm_resume(struct device *dev)
 {
 	u16 bank;
+	int status;
 	struct audio_drv_data *adata = dev_get_drvdata(dev);
 
-	acp_init(adata->acp_mmio, adata->asic_type);
+	status = acp_init(adata->acp_mmio, adata->asic_type);
+	if (status) {
+		dev_err(dev, "ACP Init failed\n");
+		return status;
+	}
 
 	if (adata->play_stream && adata->play_stream->runtime) {
 		/* For Stoney, Memory gating is disabled,i.e SRAM Banks
@@ -1145,18 +1164,28 @@ static int acp_pcm_resume(struct device *dev)
 
 static int acp_pcm_runtime_suspend(struct device *dev)
 {
+	int status;
 	struct audio_drv_data *adata = dev_get_drvdata(dev);
 
-	acp_deinit(adata->acp_mmio);
+	status = acp_deinit(adata->acp_mmio);
+	if (status) {
+		dev_err(dev, "ACP Deinit failed\n");
+		return status;
+	}
 	acp_reg_write(0, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 	return 0;
 }
 
 static int acp_pcm_runtime_resume(struct device *dev)
 {
+	int status;
 	struct audio_drv_data *adata = dev_get_drvdata(dev);
 
-	acp_init(adata->acp_mmio, adata->asic_type);
+	status = acp_init(adata->acp_mmio, adata->asic_type);
+	if (status) {
+		dev_err(dev, "ACP Init failed\n");
+		return status;
+	}
 	acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 	return 0;
 }
-- 
2.7.4
