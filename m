From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: added error checks in dma driver" to the asoc tree
Date: Mon, 04 Dec 2017 18:49:19 +0000
Message-ID: <E1eLvnr-0000RQ-Ua@debutante>
References: <1512400584-28170-1-git-send-email-Vijendar.Mukunda@amd.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1512400584-28170-1-git-send-email-Vijendar.Mukunda@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mukunda@sirena.org.uk
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Mark Brown <broonie@kernel.org>broonie@kernel.org, alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgVijendar Mukunda <Vijendar.Mukunda@amd.com>, Alexander.Deucher@amd.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: added error checks in dma driver

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7afa535eb107d587b22ffbbbaaeb4a0b87b94496 Mon Sep 17 00:00:00 2001
From: "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
Date: Mon, 4 Dec 2017 20:46:24 +0530
Subject: [PATCH] ASoC: amd: added error checks in dma driver

added additional error checks in acp dma driver
v2: printed error codes for acp init & acp deinit
failure cases.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index b5e41df6bb3a..c33a512283a4 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -850,6 +850,9 @@ static snd_pcm_uframes_t acp_dma_pointer(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
 
+	if (!rtd)
+		return -EINVAL;
+
 	buffersize = frames_to_bytes(runtime, runtime->buffer_size);
 	bytescount = acp_get_byte_count(rtd->acp_mmio, substream->stream);
 
@@ -875,6 +878,8 @@ static int acp_dma_prepare(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct audio_substream_data *rtd = runtime->private_data;
 
+	if (!rtd)
+		return -EINVAL;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		config_acp_dma_channel(rtd->acp_mmio, SYSRAM_TO_ACP_CH_NUM,
 					PLAYBACK_START_DMA_DESCR_CH12,
@@ -1091,7 +1096,11 @@ static int acp_audio_probe(struct platform_device *pdev)
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
@@ -1108,9 +1117,12 @@ static int acp_audio_probe(struct platform_device *pdev)
 
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
 
@@ -1120,9 +1132,14 @@ static int acp_audio_remove(struct platform_device *pdev)
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
@@ -1154,18 +1171,26 @@ static int acp_pcm_resume(struct device *dev)
 
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
2.15.0
