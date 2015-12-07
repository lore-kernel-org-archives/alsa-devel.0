From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dwc: reconfigure dwc in 'resume' from
	'suspend'" to the asoc tree
Date: Mon, 07 Dec 2015 19:54:04 +0000
Message-ID: <E1a61rI-0003Ul-WA@debutante>
References: <1449272440-8735-6-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F728265455
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 20:54:16 +0100 (CET)
In-Reply-To: <1449272440-8735-6-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dwc: reconfigure dwc in 'resume' from 'suspend'

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 0032e9dbc5d8add10345ccda48e3803bb7cfd650 Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
Date: Fri, 4 Dec 2015 18:40:33 -0500
Subject: [PATCH] ASoC: dwc: reconfigure dwc in 'resume' from 'suspend'

DWC IP can be powered off during system suspend in some platforms.
After system is resumed, dwc needs to be programmed again to continue
audio use case.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/dwc/designware_i2s.c | 70 ++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 27 deletions(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 940c88136a34..825a1f480aab 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -98,6 +98,8 @@ struct dw_i2s_dev {
 	unsigned int i2s_reg_comp1;
 	unsigned int i2s_reg_comp2;
 	struct device *dev;
+	u32 ccr;
+	u32 xfer_resolution;
 
 	/* data related to DMA transfers b/w i2s and DMAC */
 	union dw_i2s_snd_dma_data play_dma_data;
@@ -217,31 +219,58 @@ static int dw_i2s_startup(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static void dw_i2s_config(struct dw_i2s_dev *dev, int stream)
+{
+	u32 ch_reg, irq;
+	struct i2s_clk_config_data *config = &dev->config;
+
+
+	i2s_disable_channels(dev, stream);
+
+	for (ch_reg = 0; ch_reg < (config->chan_nr / 2); ch_reg++) {
+		if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			i2s_write_reg(dev->i2s_base, TCR(ch_reg),
+				      dev->xfer_resolution);
+			i2s_write_reg(dev->i2s_base, TFCR(ch_reg), 0x02);
+			irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
+			i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x30);
+			i2s_write_reg(dev->i2s_base, TER(ch_reg), 1);
+		} else {
+			i2s_write_reg(dev->i2s_base, RCR(ch_reg),
+				      dev->xfer_resolution);
+			i2s_write_reg(dev->i2s_base, RFCR(ch_reg), 0x07);
+			irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
+			i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x03);
+			i2s_write_reg(dev->i2s_base, RER(ch_reg), 1);
+		}
+
+	}
+}
+
 static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
 	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(dai);
 	struct i2s_clk_config_data *config = &dev->config;
-	u32 ccr, xfer_resolution, ch_reg, irq;
 	int ret;
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		config->data_width = 16;
-		ccr = 0x00;
-		xfer_resolution = 0x02;
+		dev->ccr = 0x00;
+		dev->xfer_resolution = 0x02;
 		break;
 
 	case SNDRV_PCM_FORMAT_S24_LE:
 		config->data_width = 24;
-		ccr = 0x08;
-		xfer_resolution = 0x04;
+		dev->ccr = 0x08;
+		dev->xfer_resolution = 0x04;
 		break;
 
 	case SNDRV_PCM_FORMAT_S32_LE:
 		config->data_width = 32;
-		ccr = 0x10;
-		xfer_resolution = 0x05;
+		dev->ccr = 0x10;
+		dev->xfer_resolution = 0x05;
 		break;
 
 	default:
@@ -262,27 +291,9 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	i2s_disable_channels(dev, substream->stream);
+	dw_i2s_config(dev, substream->stream);
 
-	for (ch_reg = 0; ch_reg < (config->chan_nr / 2); ch_reg++) {
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-			i2s_write_reg(dev->i2s_base, TCR(ch_reg),
-				      xfer_resolution);
-			i2s_write_reg(dev->i2s_base, TFCR(ch_reg), 0x02);
-			irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
-			i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x30);
-			i2s_write_reg(dev->i2s_base, TER(ch_reg), 1);
-		} else {
-			i2s_write_reg(dev->i2s_base, RCR(ch_reg),
-				      xfer_resolution);
-			i2s_write_reg(dev->i2s_base, RFCR(ch_reg), 0x07);
-			irq = i2s_read_reg(dev->i2s_base, IMR(ch_reg));
-			i2s_write_reg(dev->i2s_base, IMR(ch_reg), irq & ~0x03);
-			i2s_write_reg(dev->i2s_base, RER(ch_reg), 1);
-		}
-	}
-
-	i2s_write_reg(dev->i2s_base, CCR, ccr);
+	i2s_write_reg(dev->i2s_base, CCR, dev->ccr);
 
 	config->sample_rate = params_rate(params);
 
@@ -431,6 +442,11 @@ static int dw_i2s_resume(struct snd_soc_dai *dai)
 
 	if (dev->capability & DW_I2S_MASTER)
 		clk_enable(dev->clk);
+
+	if (dai->playback_active)
+		dw_i2s_config(dev, SNDRV_PCM_STREAM_PLAYBACK);
+	if (dai->capture_active)
+		dw_i2s_config(dev, SNDRV_PCM_STREAM_CAPTURE);
 	return 0;
 }
 
-- 
2.6.2
