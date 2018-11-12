From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 10/11] ASoC: amd: add acp3x system resume pm op
Date: Mon, 12 Nov 2018 11:05:01 +0530
Message-ID: <1542000903-19020-11-git-send-email-Vijendar.Mukunda@amd.com>
References: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: vijendar.mukunda@amd.com, Alexander.Deucher@amd.com, Vishnuvardhanrao.Ravulapati@amd.com, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

When system wide suspend happens, ACP will be powered off.
When system resumes, all the runtime configuration data for
ACP needs to be programmed again.
Added 'resume'pm call back to ACP pm ops.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Tested-by: Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 46 +++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 710c5c5..2e61cef 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -690,6 +690,51 @@ static int acp3x_audio_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int acp3x_resume(struct device *dev)
+{
+	int status;
+	u32 val;
+	struct i2s_dev_data *adata = dev_get_drvdata(dev);
+
+	status = acp3x_init(adata->acp3x_base);
+	if (status)
+		return -ENODEV;
+
+	if (adata->play_stream && adata->play_stream->runtime) {
+		struct i2s_stream_instance *rtd =
+			adata->play_stream->runtime->private_data;
+		config_acp3x_dma(rtd, SNDRV_PCM_STREAM_PLAYBACK);
+		rv_writel((rtd->xfer_resolution  << 3),
+			  rtd->acp3x_base + mmACP_BTTDM_ITER);
+		if (adata->tdm_mode == true) {
+			rv_writel(adata->tdm_fmt, adata->acp3x_base +
+				  mmACP_BTTDM_TXFRMT);
+			val = rv_readl(adata->acp3x_base + mmACP_BTTDM_ITER);
+			rv_writel((val | 0x2), adata->acp3x_base +
+				  mmACP_BTTDM_ITER);
+		}
+	}
+
+	if (adata->capture_stream && adata->capture_stream->runtime) {
+		struct i2s_stream_instance *rtd =
+			adata->capture_stream->runtime->private_data;
+		config_acp3x_dma(rtd, SNDRV_PCM_STREAM_CAPTURE);
+		rv_writel((rtd->xfer_resolution  << 3),
+			  rtd->acp3x_base + mmACP_BTTDM_IRER);
+		if (adata->tdm_mode == true) {
+			rv_writel(adata->tdm_fmt, adata->acp3x_base +
+				  mmACP_BTTDM_RXFRMT);
+			val = rv_readl(adata->acp3x_base + mmACP_BTTDM_IRER);
+			rv_writel((val | 0x2), adata->acp3x_base +
+				  mmACP_BTTDM_IRER);
+		}
+	}
+
+	rv_writel(1, adata->acp3x_base + mmACP_EXTERNAL_INTR_ENB);
+	return 0;
+}
+
+
 static int acp3x_pcm_runtime_suspend(struct device *dev)
 {
 	int status;
@@ -721,6 +766,7 @@ static int acp3x_pcm_runtime_resume(struct device *dev)
 static const struct dev_pm_ops acp3x_pm_ops = {
 	.runtime_suspend = acp3x_pcm_runtime_suspend,
 	.runtime_resume = acp3x_pcm_runtime_resume,
+	.resume = acp3x_resume,
 };
 
 static struct platform_driver acp3x_dma_driver = {
-- 
2.7.4
