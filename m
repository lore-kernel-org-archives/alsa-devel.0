From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: Interrupt handler changes for ACP3x DMA driver" to the asoc tree
Date: Tue, 13 Nov 2018 19:46:06 +0000 (GMT)
Message-ID: <20181113194606.AC5F4440078@finisterre.ee.mobilebroadband>
References: <1542000903-19020-6-git-send-email-Vijendar.Mukunda@amd.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542000903-19020-6-git-send-email-Vijendar.Mukunda@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>, Vijendar Mukunda <vijendar.mukunda@amd.com>, Mark Brown <broonie@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER, MANAGEM..." <alsa-devel@alsa-project.org>Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>Vishnuvardhanrao.Ravulapati@amd.comMark Brown <broonie@kernel.org>, Alexander.Deucher@amd.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: Interrupt handler changes for ACP3x DMA driver

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

>From 32feac95f646aebaafdaf12a610898b6e5db54ae Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Mon, 12 Nov 2018 11:04:56 +0530
Subject: [PATCH] ASoC: amd: Interrupt handler changes for ACP3x DMA driver

Whenever audio data equal to the I2S FIFO watermark level are
produced/consumed, interrupt is generated.
Acknowledge the interrupt.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Tested-by: Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 46 +++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 3e806f74c6f7..94f915afd1b3 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -27,6 +27,7 @@
 #define DRV_NAME "acp3x-i2s-audio"
 
 struct i2s_dev_data {
+	unsigned int i2s_irq;
 	void __iomem *acp3x_base;
 	struct snd_pcm_substream *play_stream;
 	struct snd_pcm_substream *capture_stream;
@@ -132,6 +133,38 @@ static int acp3x_deinit(void __iomem *acp3x_base)
 	return 0;
 }
 
+static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
+{
+	u16 play_flag, cap_flag;
+	u32 val;
+	struct i2s_dev_data *rv_i2s_data = dev_id;
+
+	if (!rv_i2s_data)
+		return IRQ_NONE;
+
+	play_flag = 0;
+	cap_flag = 0;
+	val = rv_readl(rv_i2s_data->acp3x_base + mmACP_EXTERNAL_INTR_STAT);
+	if ((val & BIT(BT_TX_THRESHOLD)) && rv_i2s_data->play_stream) {
+		rv_writel(BIT(BT_TX_THRESHOLD), rv_i2s_data->acp3x_base +
+			  mmACP_EXTERNAL_INTR_STAT);
+		snd_pcm_period_elapsed(rv_i2s_data->play_stream);
+		play_flag = 1;
+	}
+
+	if ((val & BIT(BT_RX_THRESHOLD)) && rv_i2s_data->capture_stream) {
+		rv_writel(BIT(BT_RX_THRESHOLD), rv_i2s_data->acp3x_base +
+			  mmACP_EXTERNAL_INTR_STAT);
+		snd_pcm_period_elapsed(rv_i2s_data->capture_stream);
+		cap_flag = 1;
+	}
+
+	if (play_flag | cap_flag)
+		return IRQ_HANDLED;
+	else
+		return IRQ_NONE;
+}
+
 static struct snd_pcm_ops acp3x_dma_ops = {
 	.open = NULL,
 	.close = NULL,
@@ -205,6 +238,13 @@ static int acp3x_audio_probe(struct platform_device *pdev)
 	adata->acp3x_base = devm_ioremap(&pdev->dev, res->start,
 					 resource_size(res));
 
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "IORESOURCE_IRQ FAILED\n");
+		return -ENODEV;
+	}
+
+	adata->i2s_irq = res->start;
 	adata->play_stream = NULL;
 	adata->capture_stream = NULL;
 
@@ -220,6 +260,12 @@ static int acp3x_audio_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Fail to register acp i2s dai\n");
 		goto dev_err;
 	}
+	status = devm_request_irq(&pdev->dev, adata->i2s_irq, i2s_irq_handler,
+				  irqflags, "ACP3x_I2S_IRQ", adata);
+	if (status) {
+		dev_err(&pdev->dev, "ACP3x I2S IRQ request failed\n");
+		goto dev_err;
+	}
 
 	return 0;
 dev_err:
-- 
2.19.1
