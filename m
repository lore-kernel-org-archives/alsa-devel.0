From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 08/11] ASoC: amd: add acp3x tdm mode support
Date: Mon, 12 Nov 2018 11:04:59 +0530
Message-ID: <1542000903-19020-9-git-send-email-Vijendar.Mukunda@amd.com>
References: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: vijendar.mukunda@amd.com, Alexander.Deucher@amd.com, Vishnuvardhanrao.Ravulapati@amd.com, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Sanju R Mehta <sanju.mehta@amd.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

ACP3x I2S (CPU DAI) can act in normal I2S and TDM modes.
Added support for TDM mode.
Desired mode can be selected from ASoC machine driver.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
Tested-by: Ravulapati Vishnu vardhan Rao <Vishnuvardhanrao.Ravulapati@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 62 +++++++++++++++++++++++++++++++++++++
 sound/soc/amd/raven/acp3x.h         |  7 +++++
 2 files changed, 69 insertions(+)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index ed2c163..15a5f3b 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -27,7 +27,9 @@
 #define DRV_NAME "acp3x-i2s-audio"
 
 struct i2s_dev_data {
+	bool tdm_mode;
 	unsigned int i2s_irq;
+	u32 tdm_fmt;
 	void __iomem *acp3x_base;
 	struct snd_pcm_substream *play_stream;
 	struct snd_pcm_substream *capture_stream;
@@ -423,6 +425,64 @@ static struct snd_pcm_ops acp3x_dma_ops = {
 	.mmap = acp3x_dma_mmap,
 };
 
+
+static int acp3x_dai_i2s_set_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
+{
+
+	struct i2s_dev_data *adata = snd_soc_dai_get_drvdata(cpu_dai);
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		adata->tdm_mode = false;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		adata->tdm_mode = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int acp3x_dai_set_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
+				  u32 rx_mask, int slots, int slot_width)
+{
+	u32 val = 0;
+	u16 slot_len;
+
+	struct i2s_dev_data *adata = snd_soc_dai_get_drvdata(cpu_dai);
+
+	switch (slot_width) {
+	case SLOT_WIDTH_8:
+		slot_len = 8;
+		break;
+	case SLOT_WIDTH_16:
+		slot_len = 16;
+		break;
+	case SLOT_WIDTH_24:
+		slot_len = 24;
+		break;
+	case SLOT_WIDTH_32:
+		slot_len = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	val = rv_readl(adata->acp3x_base + mmACP_BTTDM_ITER);
+	rv_writel((val | 0x2), adata->acp3x_base + mmACP_BTTDM_ITER);
+	val = rv_readl(adata->acp3x_base + mmACP_BTTDM_IRER);
+	rv_writel((val | 0x2), adata->acp3x_base + mmACP_BTTDM_IRER);
+
+	val = (FRM_LEN | (slots << 15) | (slot_len << 18));
+	rv_writel(val, adata->acp3x_base + mmACP_BTTDM_TXFRMT);
+	rv_writel(val, adata->acp3x_base + mmACP_BTTDM_RXFRMT);
+
+	adata->tdm_fmt = val;
+	return 0;
+}
+
 static int acp3x_dai_i2s_hwparams(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *params,
 				  struct snd_soc_dai *dai)
@@ -510,6 +570,8 @@ static int acp3x_dai_i2s_trigger(struct snd_pcm_substream *substream,
 struct snd_soc_dai_ops acp3x_dai_i2s_ops = {
 	.hw_params = acp3x_dai_i2s_hwparams,
 	.trigger   = acp3x_dai_i2s_trigger,
+	.set_fmt = acp3x_dai_i2s_set_fmt,
+	.set_tdm_slot = acp3x_dai_set_tdm_slot,
 };
 
 static struct snd_soc_dai_driver acp3x_i2s_dai_driver = {
diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index 9f33e34..95fef85 100644
--- a/sound/soc/amd/raven/acp3x.h
+++ b/sound/soc/amd/raven/acp3x.h
@@ -32,6 +32,13 @@
 #define MIN_BUFFER MAX_BUFFER
 #define FIFO_SIZE 0x100
 #define DMA_SIZE 0x40
+#define FRM_LEN 0x100
+
+#define SLOT_WIDTH_8 0x08
+#define SLOT_WIDTH_16 0x10
+#define SLOT_WIDTH_24 0x18
+#define SLOT_WIDTH_32 0x20
+
 
 static inline u32 rv_readl(void __iomem *base_addr)
 {
-- 
2.7.4
