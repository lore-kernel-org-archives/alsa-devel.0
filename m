From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 05/11] ASoC: amd: Interrupt handler changes for
	ACP3x DMA driver
Date: Mon, 12 Nov 2018 11:04:56 +0530
Message-ID: <1542000903-19020-6-git-send-email-Vijendar.Mukunda@amd.com>
References: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720045.outbound.protection.outlook.com [40.107.72.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B94C2677E4
 for <alsa-devel@alsa-project.org>; Mon, 12 Nov 2018 06:32:25 +0100 (CET)
In-Reply-To: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER
 MANAGEM..." <alsa-devel@alsa-project.org>, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Vishnuvardhanrao.Ravulapati@amd.com, Mark Brown <broonie@kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alexander.Deucher@amd.com
List-Id: alsa-devel@alsa-project.org

Whenever audio data equal to the I2S FIFO watermark level are
produced/consumed, interrupt is generated.
Acknowledge the interrupt.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Tested-by: Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 46 +++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 3e806f7..94f915a 100644
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
2.7.4
