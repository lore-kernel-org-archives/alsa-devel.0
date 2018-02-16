From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 2/9] ASoC: amd: Coding style changes for acp
	dma driver
Date: Fri, 16 Feb 2018 13:03:47 +0530
Message-ID: <1518766434-7911-3-git-send-email-Vijendar.Mukunda@amd.com>
References: <1518766434-7911-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0089.outbound.protection.outlook.com [104.47.33.89])
 by alsa0.perex.cz (Postfix) with ESMTP id CB27D267D6E
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 08:32:06 +0100 (CET)
In-Reply-To: <1518766434-7911-1-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, alsa-devel@alsa-project.org, perex@perex.cz
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, lgirdwood@gmail.com, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
List-Id: alsa-devel@alsa-project.org

Removed hardcoding in dma descriptor programming api's.
These changes are required to extend the logic to support
dma descriptor programming for multiple i2s controller
instances.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 124 ++++++++++++++++++++++----------------------
 1 file changed, 61 insertions(+), 63 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index fcc5b4f..91c4775 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -184,19 +184,18 @@ static void config_dma_descriptor_in_sram(void __iomem *acp_mmio,
  * system memory <-> ACP SRAM
  */
 static void set_acp_sysmem_dma_descriptors(void __iomem *acp_mmio,
-					u32 size, int direction,
-					u32 pte_offset, u32 asic_type)
+					u32 size, int direction, u32 pte_offset,
+					u16 ch, u32 sram_bank,
+					u16 dma_dscr_idx, u32 asic_type)
 {
 	u16 i;
-	u16 dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
 	acp_dma_dscr_transfer_t dmadscr[NUM_DSCRS_PER_CHANNEL];
 
 	for (i = 0; i < NUM_DSCRS_PER_CHANNEL; i++) {
 		dmadscr[i].xfer_val = 0;
 		if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
-			dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12 + i;
-			dmadscr[i].dest = ACP_SHARED_RAM_BANK_1_ADDRESS
-					+ (i * (size/2));
+			dma_dscr_idx = dma_dscr_idx + i;
+			dmadscr[i].dest = sram_bank + (i * (size/2));
 			dmadscr[i].src = ACP_INTERNAL_APERTURE_WINDOW_0_ADDRESS
 				+ (pte_offset * SZ_4K) + (i * (size/2));
 			switch (asic_type) {
@@ -211,25 +210,19 @@ static void set_acp_sysmem_dma_descriptors(void __iomem *acp_mmio,
 				(size / 2);
 			}
 		} else {
-			dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH14 + i;
+			dma_dscr_idx = dma_dscr_idx + i;
+			dmadscr[i].src = sram_bank + (i * (size/2));
+			dmadscr[i].dest =
+			ACP_INTERNAL_APERTURE_WINDOW_0_ADDRESS +
+			(pte_offset * SZ_4K) + (i * (size/2));
 			switch (asic_type) {
 			case CHIP_STONEY:
-				dmadscr[i].src = ACP_SHARED_RAM_BANK_3_ADDRESS +
-				(i * (size/2));
-				dmadscr[i].dest =
-				ACP_INTERNAL_APERTURE_WINDOW_0_ADDRESS +
-				(pte_offset * SZ_4K) + (i * (size/2));
 				dmadscr[i].xfer_val |=
 				BIT(22) |
 				(ACP_DMA_ATTRIBUTES_SHARED_MEM_TO_DAGB_GARLIC << 16) |
 				(size / 2);
 				break;
 			default:
-				dmadscr[i].src = ACP_SHARED_RAM_BANK_5_ADDRESS +
-				(i * (size/2));
-				dmadscr[i].dest =
-				ACP_INTERNAL_APERTURE_WINDOW_0_ADDRESS +
-				(pte_offset * SZ_4K) + (i * (size/2));
 				dmadscr[i].xfer_val |=
 				BIT(22) |
 				(ACP_DMA_ATTRIBUTES_SHAREDMEM_TO_DAGB_ONION << 16) |
@@ -239,72 +232,49 @@ static void set_acp_sysmem_dma_descriptors(void __iomem *acp_mmio,
 		config_dma_descriptor_in_sram(acp_mmio, dma_dscr_idx,
 						&dmadscr[i]);
 	}
-	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
-		config_acp_dma_channel(acp_mmio, SYSRAM_TO_ACP_CH_NUM,
-					PLAYBACK_START_DMA_DESCR_CH12,
-					NUM_DSCRS_PER_CHANNEL,
-					ACP_DMA_PRIORITY_LEVEL_NORMAL);
-	else
-		config_acp_dma_channel(acp_mmio, ACP_TO_SYSRAM_CH_NUM,
-					CAPTURE_START_DMA_DESCR_CH14,
-					NUM_DSCRS_PER_CHANNEL,
-					ACP_DMA_PRIORITY_LEVEL_NORMAL);
+	config_acp_dma_channel(acp_mmio, ch,
+				dma_dscr_idx - 1,
+				NUM_DSCRS_PER_CHANNEL,
+				ACP_DMA_PRIORITY_LEVEL_NORMAL);
 }
 
 /* Initialize the DMA descriptor information for transfer between
  * ACP SRAM <-> I2S
  */
-static void set_acp_to_i2s_dma_descriptors(void __iomem *acp_mmio,
-					u32 size, int direction,
-					u32 asic_type)
+static void set_acp_to_i2s_dma_descriptors(void __iomem *acp_mmio, u32 size,
+						int direction, u32 sram_bank,
+						u16 destination, u16 ch,
+						u16 dma_dscr_idx, u32 asic_type)
 {
 
 	u16 i;
-	u16 dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH13;
 	acp_dma_dscr_transfer_t dmadscr[NUM_DSCRS_PER_CHANNEL];
 
 	for (i = 0; i < NUM_DSCRS_PER_CHANNEL; i++) {
 		dmadscr[i].xfer_val = 0;
 		if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
-			dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH13 + i;
-			dmadscr[i].src = ACP_SHARED_RAM_BANK_1_ADDRESS +
-					 (i * (size/2));
+			dma_dscr_idx = dma_dscr_idx + i;
+			dmadscr[i].src = sram_bank  + (i * (size/2));
 			/* dmadscr[i].dest is unused by hardware. */
 			dmadscr[i].dest = 0;
-			dmadscr[i].xfer_val |= BIT(22) | (TO_ACP_I2S_1 << 16) |
+			dmadscr[i].xfer_val |= BIT(22) | (destination << 16) |
 						(size / 2);
 		} else {
-			dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH15 + i;
+			dma_dscr_idx = dma_dscr_idx + i;
 			/* dmadscr[i].src is unused by hardware. */
 			dmadscr[i].src = 0;
-			switch (asic_type) {
-			case CHIP_STONEY:
-				dmadscr[i].dest =
-					 ACP_SHARED_RAM_BANK_3_ADDRESS +
-					(i * (size / 2));
-				break;
-			default:
-				dmadscr[i].dest =
-					 ACP_SHARED_RAM_BANK_5_ADDRESS +
-					(i * (size / 2));
-			}
+			dmadscr[i].dest =
+				 sram_bank + (i * (size / 2));
 			dmadscr[i].xfer_val |= BIT(22) |
-					(FROM_ACP_I2S_1 << 16) | (size / 2);
+				(destination << 16) | (size / 2);
 		}
 		config_dma_descriptor_in_sram(acp_mmio, dma_dscr_idx,
 						&dmadscr[i]);
 	}
 	/* Configure the DMA channel with the above descriptore */
-	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
-		config_acp_dma_channel(acp_mmio, ACP_TO_I2S_DMA_CH_NUM,
-					PLAYBACK_START_DMA_DESCR_CH13,
-					NUM_DSCRS_PER_CHANNEL,
-					ACP_DMA_PRIORITY_LEVEL_NORMAL);
-	else
-		config_acp_dma_channel(acp_mmio, I2S_TO_ACP_DMA_CH_NUM,
-					CAPTURE_START_DMA_DESCR_CH15,
-					NUM_DSCRS_PER_CHANNEL,
-					ACP_DMA_PRIORITY_LEVEL_NORMAL);
+	config_acp_dma_channel(acp_mmio, ch, dma_dscr_idx - 1,
+				NUM_DSCRS_PER_CHANNEL,
+				ACP_DMA_PRIORITY_LEVEL_NORMAL);
 }
 
 /* Create page table entries in ACP SRAM for the allocated memory */
@@ -346,23 +316,51 @@ static void config_acp_dma(void __iomem *acp_mmio,
 			struct audio_substream_data *audio_config,
 			u32 asic_type)
 {
-	u32 pte_offset;
+	u32 pte_offset, sram_bank;
+	u16 ch1, ch2, destination, dma_dscr_idx;
 
-	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
+	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK) {
 		pte_offset = ACP_PLAYBACK_PTE_OFFSET;
-	else
+		ch1 = SYSRAM_TO_ACP_CH_NUM;
+		ch2 = ACP_TO_I2S_DMA_CH_NUM;
+		sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
+		destination = TO_ACP_I2S_1;
+
+	} else {
 		pte_offset = ACP_CAPTURE_PTE_OFFSET;
+		ch1 = SYSRAM_TO_ACP_CH_NUM;
+		ch2 = ACP_TO_I2S_DMA_CH_NUM;
+		switch (asic_type) {
+		case CHIP_STONEY:
+			sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
+			break;
+		default:
+			sram_bank = ACP_SHARED_RAM_BANK_5_ADDRESS;
+		}
+		destination = FROM_ACP_I2S_1;
+	}
 
 	acp_pte_config(acp_mmio, audio_config->pg, audio_config->num_of_pages,
 			pte_offset);
+	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
+		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
+	else
+		dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH14;
 
 	/* Configure System memory <-> ACP SRAM DMA descriptors */
 	set_acp_sysmem_dma_descriptors(acp_mmio, audio_config->size,
-				audio_config->direction, pte_offset, asic_type);
+				       audio_config->direction, pte_offset,
+					ch1, sram_bank, dma_dscr_idx, asic_type);
 
+	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
+		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH13;
+	else
+		dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH15;
 	/* Configure ACP SRAM <-> I2S DMA descriptors */
 	set_acp_to_i2s_dma_descriptors(acp_mmio, audio_config->size,
-				audio_config->direction, asic_type);
+					audio_config->direction, sram_bank,
+					destination, ch2, dma_dscr_idx,
+					asic_type);
 }
 
 /* Start a given DMA channel transfer */
-- 
2.7.4
