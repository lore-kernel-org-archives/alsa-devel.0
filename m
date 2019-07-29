From: Ravulapati Vishnu vardhan rao
        <Vishnuvardhanrao.Ravulapati@amd.com>
Subject: [PATCH 1/3] ASoC: amd: use DMA addr rather than CPU pa for audio buffer
Date: Mon, 29 Jul 2019 17:38:29 +0530
Message-ID: <1564402115-5043-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Alexander.Deucher@amd.com, Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>, Vijendar Mukunda <vijendar.mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, YueHaibing <yuehaibing@huawei.com>, Colin Ian King <colin.king@canonical.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

We shouldn't assume CPU physical address we get from page_to_phys()
is same as DMA address we get from dma_alloc_coherent(). On x86_64,
we won't run into any problem with the assumption when dma_ops is
nommu_dma_ops. However, DMA address is IOVA when IOMMU is enabled.
And it's most likely different from CPU physical address when AMD
IOMMU is not in passthrough mode.

Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
Tested-by: RAVULAPATI VISHNU VARDHAN RAO <Vishnuvardhanrao.Ravulapati@amd.com>
---
 sound/soc/amd/raven/acp3x-pcm-dma.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index a4ade6b..49c4872 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -31,7 +31,7 @@ struct i2s_stream_instance {
 	u16 num_pages;
 	u16 channels;
 	u32 xfer_resolution;
-	struct page *pg;
+	dma_addr_t dma_addr;
 	u64 bytescount;
 	void __iomem *acp3x_base;
 };
@@ -211,11 +211,13 @@ static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
 static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
 {
 	u16 page_idx;
-	u64 addr;
+	dma_addr_t addr;
 	u32 low, high, val, acp_fifo_addr;
-	struct page *pg = rtd->pg;
 
-	/* 8 scratch registers used to map one 64 bit address */
+	addr = rtd->dma_addr;
+	/* 8 scratch registers used to map one 64 bit address.
+	 * For 2 pages (8192 * 2 bytes), it will be 16 registers.
+	 */
 	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
 		val = 0;
 	else
@@ -229,7 +231,6 @@ static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
 
 	for (page_idx = 0; page_idx < rtd->num_pages; page_idx++) {
 		/* Load the low address of page int ACP SRAM through SRBM */
-		addr = page_to_phys(pg);
 		low = lower_32_bits(addr);
 		high = upper_32_bits(addr);
 
@@ -239,7 +240,7 @@ static void config_acp3x_dma(struct i2s_stream_instance *rtd, int direction)
 				+ 4);
 		/* Move to next physically contiguos page */
 		val += 8;
-		pg++;
+		addr += PAGE_SIZE;
 	}
 
 	if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -340,10 +341,8 @@ static int acp3x_dma_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_pcm_hw_params *params)
 {
 	int status;
-	u64 size;
-	struct page *pg;
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct i2s_stream_instance *rtd = runtime->private_data;
+	uint64_t size;
+	struct i2s_stream_instance *rtd = substream->runtime->private_data;
 
 	if (!rtd)
 		return -EINVAL;
@@ -355,8 +354,8 @@ static int acp3x_dma_hw_params(struct snd_pcm_substream *substream,
 
 	memset(substream->runtime->dma_area, 0, params_buffer_bytes(params));
 	pg = virt_to_page(substream->dma_buffer.area);
-	if (pg) {
-		rtd->pg = pg;
+	if (substream->dma_buffer.area) {
+		rtd->dma_addr = substream->dma_buffer.addr;
 		rtd->num_pages = (PAGE_ALIGN(size) >> PAGE_SHIFT);
 		config_acp3x_dma(rtd, substream->stream);
 		status = 0;
-- 
2.7.4
