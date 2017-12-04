From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH] ASoC: amd: added error checks in dma driver
Date: Mon, 4 Dec 2017 20:46:24 +0530
Message-ID: <1512400584-28170-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0067.outbound.protection.outlook.com [104.47.42.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 17776266BBC
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 16:15:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alexander.Deucher@amd.com
List-Id: alsa-devel@alsa-project.org

added additional error checks in acp dma driver
v2: printed error codes for acp init & acp deinit
failure cases.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index fb09578..29be517 100644
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
+		dev_err(&pdev->dev, "ACP Init failed status:%d\n", status);
+		return status;
+	}
 
 	status = snd_soc_register_platform(&pdev->dev, &acp_asoc_platform);
 	if (status != 0) {
@@ -1099,9 +1108,12 @@ static int acp_audio_probe(struct platform_device *pdev)
 
 static int acp_audio_remove(struct platform_device *pdev)
 {
+	int status;
 	struct audio_drv_data *adata = dev_get_drvdata(&pdev->dev);
 
-	acp_deinit(adata->acp_mmio);
+	status = acp_deinit(adata->acp_mmio);
+	if (status)
+		dev_err(&pdev->dev, "ACP Deinit failed status:%d\n", status);
 	snd_soc_unregister_platform(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
@@ -1111,9 +1123,14 @@ static int acp_audio_remove(struct platform_device *pdev)
 static int acp_pcm_resume(struct device *dev)
 {
 	u16 bank;
+	int status;
 	struct audio_drv_data *adata = dev_get_drvdata(dev);
 
-	acp_init(adata->acp_mmio, adata->asic_type);
+	status = acp_init(adata->acp_mmio, adata->asic_type);
+	if (status) {
+		dev_err(dev, "ACP Init failed status:%d\n", status);
+		return status;
+	}
 
 	if (adata->play_stream && adata->play_stream->runtime) {
 		/* For Stoney, Memory gating is disabled,i.e SRAM Banks
@@ -1145,18 +1162,26 @@ static int acp_pcm_resume(struct device *dev)
 
 static int acp_pcm_runtime_suspend(struct device *dev)
 {
+	int status;
 	struct audio_drv_data *adata = dev_get_drvdata(dev);
 
-	acp_deinit(adata->acp_mmio);
+	status = acp_deinit(adata->acp_mmio);
+	if (status)
+		dev_err(dev, "ACP Deinit failed status:%d\n", status);
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
+		dev_err(dev, "ACP Init failed status:%d\n", status);
+		return status;
+	}
 	acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 	return 0;
 }
-- 
2.7.4
