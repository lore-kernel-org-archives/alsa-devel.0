From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 01/11] ASoC: amd: rename audio_substream_data variable
Date: Thu, 26 Apr 2018 16:45:47 +0530
Message-ID: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Jason Clinton <jclinton@chromium.org>, Guenter Roeck <linux@roeck-us.net>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

In order to make audio_substream_data structure variable
consistent throughout the code, changed the name from
audio_config to rtd wherever applicable.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 5ffe2ef..9c026c4 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -317,13 +317,13 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
 }
 
 static void config_acp_dma(void __iomem *acp_mmio,
-			   struct audio_substream_data *audio_config,
+			   struct audio_substream_data *rtd,
 			   u32 asic_type)
 {
 	u32 pte_offset, sram_bank;
 	u16 ch1, ch2, destination, dma_dscr_idx;
 
-	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK) {
+	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
 		pte_offset = ACP_PLAYBACK_PTE_OFFSET;
 		ch1 = SYSRAM_TO_ACP_CH_NUM;
 		ch2 = ACP_TO_I2S_DMA_CH_NUM;
@@ -344,25 +344,25 @@ static void config_acp_dma(void __iomem *acp_mmio,
 		destination = FROM_ACP_I2S_1;
 	}
 
-	acp_pte_config(acp_mmio, audio_config->pg, audio_config->num_of_pages,
+	acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
 		       pte_offset);
-	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
+	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
 		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
 	else
 		dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH14;
 
 	/* Configure System memory <-> ACP SRAM DMA descriptors */
-	set_acp_sysmem_dma_descriptors(acp_mmio, audio_config->size,
-				       audio_config->direction, pte_offset, ch1,
+	set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
+				       rtd->direction, pte_offset, ch1,
 				       sram_bank, dma_dscr_idx, asic_type);
 
-	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
+	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
 		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH13;
 	else
 		dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH15;
 	/* Configure ACP SRAM <-> I2S DMA descriptors */
-	set_acp_to_i2s_dma_descriptors(acp_mmio, audio_config->size,
-				       audio_config->direction, sram_bank,
+	set_acp_to_i2s_dma_descriptors(acp_mmio, rtd->size,
+				       rtd->direction, sram_bank,
 				       destination, ch2, dma_dscr_idx,
 				       asic_type);
 }
-- 
2.7.4
