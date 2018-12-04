From: Yu Zhao <yuzhao@google.com>
Subject: [PATCH 1/2] ASoC: use DMA addr rather than CPU pa for acp_audio_dma
Date: Tue,  4 Dec 2018 15:42:52 -0700
Message-ID: <20181204224253.216075-1-yuzhao@google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, aroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Alex Deucher <alexander.deucher@amd.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>
List-Id: alsa-devel@alsa-project.org

We shouldn't assume CPU physical address we get from page_to_phys()
is same as DMA address we get from dma_alloc_coherent(). On x86_64,
we won't run into any problem with the assumption when dma_ops is
nommu_dma_ops. However, DMA address is IOVA when IOMMU is enabled.
And it's most likely different from CPU physical address when AMD
IOMMU is not in passthrough mode.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 sound/soc/amd/acp-pcm-dma.c | 15 +++++----------
 sound/soc/amd/acp.h         |  2 +-
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index cdebab2f8ce5..fd3db4c37882 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -303,11 +303,10 @@ static void set_acp_to_i2s_dma_descriptors(void __iomem *acp_mmio, u32 size,
 }
 
 /* Create page table entries in ACP SRAM for the allocated memory */
-static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
+static void acp_pte_config(void __iomem *acp_mmio, dma_addr_t addr,
 			   u16 num_of_pages, u32 pte_offset)
 {
 	u16 page_idx;
-	u64 addr;
 	u32 low;
 	u32 high;
 	u32 offset;
@@ -317,7 +316,6 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
 		/* Load the low address of page int ACP SRAM through SRBM */
 		acp_reg_write((offset + (page_idx * 8)),
 			      acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
-		addr = page_to_phys(pg);
 
 		low = lower_32_bits(addr);
 		high = upper_32_bits(addr);
@@ -333,7 +331,7 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
 		acp_reg_write(high, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
 
 		/* Move to next physically contiguos page */
-		pg++;
+		addr += PAGE_SIZE;
 	}
 }
 
@@ -343,7 +341,7 @@ static void config_acp_dma(void __iomem *acp_mmio,
 {
 	u16 ch_acp_sysmem, ch_acp_i2s;
 
-	acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
+	acp_pte_config(acp_mmio, rtd->dma_addr, rtd->num_of_pages,
 		       rtd->pte_offset);
 
 	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -850,7 +848,6 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	int status;
 	uint64_t size;
 	u32 val = 0;
-	struct page *pg;
 	struct snd_pcm_runtime *runtime;
 	struct audio_substream_data *rtd;
 	struct snd_soc_pcm_runtime *prtd = substream->private_data;
@@ -986,16 +983,14 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		return status;
 
 	memset(substream->runtime->dma_area, 0, params_buffer_bytes(params));
-	pg = virt_to_page(substream->dma_buffer.area);
 
-	if (pg) {
+	if (substream->dma_buffer.area) {
 		acp_set_sram_bank_state(rtd->acp_mmio, 0, true);
 		/* Save for runtime private data */
-		rtd->pg = pg;
+		rtd->dma_addr = substream->dma_buffer.addr;
 		rtd->order = get_order(size);
 
 		/* Fill the page table entries in ACP SRAM */
-		rtd->pg = pg;
 		rtd->size = size;
 		rtd->num_of_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 		rtd->direction = substream->stream;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index dbbb1a85638d..e5ab6c6040a6 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -123,7 +123,7 @@ enum acp_dma_priority_level {
 };
 
 struct audio_substream_data {
-	struct page *pg;
+	dma_addr_t dma_addr;
 	unsigned int order;
 	u16 num_of_pages;
 	u16 i2s_instance;
-- 
2.20.0.rc1.387.gf8505762e3-goog
