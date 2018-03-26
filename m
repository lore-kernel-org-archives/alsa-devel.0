From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 3/8] ASoC: amd: dma descriptor changes for BT
	I2S Instance
Date: Mon, 26 Mar 2018 18:42:58 +0530
Message-ID: <1522069983-11381-4-git-send-email-Vijendar.Mukunda@amd.com>
References: <1522069983-11381-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0064.outbound.protection.outlook.com [104.47.33.64])
 by alsa0.perex.cz (Postfix) with ESMTP id B73C026718B
 for <alsa-devel@alsa-project.org>; Mon, 26 Mar 2018 15:12:25 +0200 (CEST)
In-Reply-To: <1522069983-11381-1-git-send-email-Vijendar.Mukunda@amd.com>
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
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, lgirdwood@gmail.com, Akshu.Agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

As Stoney has SRAM memory limitation ,to support
playback & capture on both the I2S controller instances
audio buffer size is reduced to 8k.

For playback on I2S SP instance sram bank 1 will be used.
For capture on I2S SP instance sram bank 2 will be used.
For playback on I2S BT instance sram bank 3 will be used.
For capture on I2S BT instance sram bank 4 will be used.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 106 ++++++++++++++++++++++++++++++++++----------
 sound/soc/amd/acp.h         |  41 +++++++++++++++--
 2 files changed, 120 insertions(+), 27 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index a61c4e0..6da54ab 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -37,7 +37,7 @@
 #define MAX_BUFFER (PLAYBACK_MAX_PERIOD_SIZE * PLAYBACK_MAX_NUM_PERIODS)
 #define MIN_BUFFER MAX_BUFFER
 
-#define ST_PLAYBACK_MAX_PERIOD_SIZE 8192
+#define ST_PLAYBACK_MAX_PERIOD_SIZE 4096
 #define ST_CAPTURE_MAX_PERIOD_SIZE  ST_PLAYBACK_MAX_PERIOD_SIZE
 #define ST_MAX_BUFFER (ST_PLAYBACK_MAX_PERIOD_SIZE * PLAYBACK_MAX_NUM_PERIODS)
 #define ST_MIN_BUFFER ST_MAX_BUFFER
@@ -320,42 +320,99 @@ static void config_acp_dma(void __iomem *acp_mmio,
 	u16 ch1, ch2, destination, dma_dscr_idx;
 
 	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK) {
-		pte_offset = ACP_PLAYBACK_PTE_OFFSET;
-		ch1 = SYSRAM_TO_ACP_CH_NUM;
-		ch2 = ACP_TO_I2S_DMA_CH_NUM;
-		sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
-		destination = TO_ACP_I2S_1;
-
-	} else {
-		pte_offset = ACP_CAPTURE_PTE_OFFSET;
-		ch1 = SYSRAM_TO_ACP_CH_NUM;
-		ch2 = ACP_TO_I2S_DMA_CH_NUM;
-		switch (asic_type) {
-		case CHIP_STONEY:
+		switch (audio_config->i2s_play_instance) {
+		case I2S_BT_INSTANCE:
+			pte_offset = ACP_ST_I2S_BT_PLAYBACK_PTE_OFFSET;
+			ch1 = SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM;
+			ch2 = ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM;
 			sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
+			destination = TO_BLUETOOTH;
 			break;
+		case I2S_SP_INSTANCE:
 		default:
-			sram_bank = ACP_SHARED_RAM_BANK_5_ADDRESS;
+			switch (asic_type) {
+			case CHIP_STONEY:
+				pte_offset = ACP_ST_I2S_SP_PLAYBACK_PTE_OFFSET;
+				break;
+			default:
+				pte_offset = ACP_PLAYBACK_PTE_OFFSET;
+			}
+			ch1 = SYSRAM_TO_ACP_CH_NUM;
+			ch2 = ACP_TO_I2S_DMA_CH_NUM;
+			sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
+			destination = TO_ACP_I2S_1;
+		}
+	} else {
+		switch (audio_config->i2s_capture_instance) {
+		case I2S_BT_INSTANCE:
+			pte_offset = ACP_ST_I2S_BT_CAPTURE_PTE_OFFSET;
+			ch1 = ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM;
+			ch2 = I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM;
+			sram_bank = ACP_SHARED_RAM_BANK_4_ADDRESS;
+			destination = FROM_BLUETOOTH;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			pte_offset = ACP_CAPTURE_PTE_OFFSET;
+			ch1 = SYSRAM_TO_ACP_CH_NUM;
+			ch2 = ACP_TO_I2S_DMA_CH_NUM;
+			switch (asic_type) {
+			case CHIP_STONEY:
+				sram_bank = ACP_SHARED_RAM_BANK_2_ADDRESS;
+				break;
+			default:
+				sram_bank = ACP_SHARED_RAM_BANK_5_ADDRESS;
+			}
+			destination = FROM_ACP_I2S_1;
 		}
-		destination = FROM_ACP_I2S_1;
 	}
 
 	acp_pte_config(acp_mmio, audio_config->pg, audio_config->num_of_pages,
 			pte_offset);
-	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
-	else
-		dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH14;
+	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK) {
+		switch (audio_config->i2s_play_instance) {
+		case I2S_BT_INSTANCE:
+			dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH8;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
+		}
+	} else {
+		switch (audio_config->i2s_capture_instance) {
+		case I2S_BT_INSTANCE:
+			dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH10;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH14;
+		}
+	}
 
 	/* Configure System memory <-> ACP SRAM DMA descriptors */
 	set_acp_sysmem_dma_descriptors(acp_mmio, audio_config->size,
 				       audio_config->direction, pte_offset,
 					ch1, sram_bank, dma_dscr_idx, asic_type);
 
-	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH13;
-	else
-		dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH15;
+	if (audio_config->direction == SNDRV_PCM_STREAM_PLAYBACK) {
+		switch (audio_config->i2s_play_instance) {
+		case I2S_BT_INSTANCE:
+			dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH9;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH13;
+		}
+	} else {
+		switch (audio_config->i2s_capture_instance) {
+		case I2S_BT_INSTANCE:
+			dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH11;
+			break;
+		case I2S_SP_INSTANCE:
+		default:
+			dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH15;
+		}
+	}
 	/* Configure ACP SRAM <-> I2S DMA descriptors */
 	set_acp_to_i2s_dma_descriptors(acp_mmio, audio_config->size,
 					audio_config->direction, sram_bank,
@@ -385,6 +442,9 @@ static void acp_dma_start(void __iomem *acp_mmio,
 	case ACP_TO_I2S_DMA_CH_NUM:
 	case ACP_TO_SYSRAM_CH_NUM:
 	case I2S_TO_ACP_DMA_CH_NUM:
+	case ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM:
+	case ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM:
+	case I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM:
 		dma_ctrl |= ACP_DMA_CNTL_0__DMAChIOCEn_MASK;
 		break;
 	default:
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index c86bef4..b697dcb 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -11,17 +11,29 @@
 #define ACP_PLAYBACK_PTE_OFFSET			10
 #define ACP_CAPTURE_PTE_OFFSET			0
 
+/* Playback and Capture Offset for Stoney */
+#define ACP_ST_I2S_SP_PLAYBACK_PTE_OFFSET	0x04
+#define ACP_ST_I2S_SP_CAPTURE_PTE_OFFSET	0x00
+#define ACP_ST_I2S_BT_PLAYBACK_PTE_OFFSET	0x08
+#define ACP_ST_I2S_BT_CAPTURE_PTE_OFFSET	0x0c
+
 #define ACP_GARLIC_CNTL_DEFAULT			0x00000FB4
 #define ACP_ONION_CNTL_DEFAULT			0x00000FB4
 
 #define ACP_PHYSICAL_BASE			0x14000
 
-/* Playback SRAM address (as a destination in dma descriptor) */
+/* In case of  I2S SP controller instance, Stoney uses SRAM bank 1 for
+ * playback and SRAM Bank 2 for capture where as in case of BT I2S
+ * Instance ,Stoney uses SRAM Bank 3 for playback & SRAM Bank 4 will
+ * be used for capture.Carrizo uses I2S SP controller instance.SRAM Banks
+ * 1,2,3,4 will be used for playback & SRAM Banks 5,6,7,8 will be used
+ * for capture scenario.
+ */
 #define ACP_SHARED_RAM_BANK_1_ADDRESS		0x4002000
-
-/* Capture SRAM address (as a source in dma descriptor) */
-#define ACP_SHARED_RAM_BANK_5_ADDRESS		0x400A000
+#define ACP_SHARED_RAM_BANK_2_ADDRESS		0x4004000
 #define ACP_SHARED_RAM_BANK_3_ADDRESS		0x4006000
+#define ACP_SHARED_RAM_BANK_4_ADDRESS		0x4008000
+#define ACP_SHARED_RAM_BANK_5_ADDRESS		0x400A000
 
 #define ACP_DMA_RESET_TIME			10000
 #define ACP_CLOCK_EN_TIME_OUT_VALUE		0x000000FF
@@ -36,8 +48,10 @@
 
 #define TO_ACP_I2S_1   0x2
 #define TO_ACP_I2S_2   0x4
+#define TO_BLUETOOTH   0x3
 #define FROM_ACP_I2S_1 0xa
 #define FROM_ACP_I2S_2 0xb
+#define FROM_BLUETOOTH 0xb
 
 #define ACP_TILE_ON_MASK                0x03
 #define ACP_TILE_OFF_MASK               0x02
@@ -58,6 +72,14 @@
 #define ACP_TO_SYSRAM_CH_NUM 14
 #define I2S_TO_ACP_DMA_CH_NUM 15
 
+/* Playback DMA Channels for I2S BT instance */
+#define SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM  8
+#define ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM 9
+
+/* Capture DMA Channels for I2S BT Instance */
+#define ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM 10
+#define I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM 11
+
 #define NUM_DSCRS_PER_CHANNEL 2
 
 #define PLAYBACK_START_DMA_DESCR_CH12 0
@@ -70,6 +92,17 @@
 #define CAPTURE_START_DMA_DESCR_CH15 6
 #define CAPTURE_END_DMA_DESCR_CH15 7
 
+/* I2S BT Instance DMA Descriptors */
+#define PLAYBACK_START_DMA_DESCR_CH8 8
+#define PLAYBACK_END_DMA_DESCR_CH8 9
+#define PLAYBACK_START_DMA_DESCR_CH9 10
+#define PLAYBACK_END_DMA_DESCR_CH9 11
+
+#define CAPTURE_START_DMA_DESCR_CH10 12
+#define CAPTURE_END_DMA_DESCR_CH10 13
+#define CAPTURE_START_DMA_DESCR_CH11 14
+#define CAPTURE_END_DMA_DESCR_CH11 15
+
 #define mmACP_I2S_16BIT_RESOLUTION_EN       0x5209
 #define ACP_I2S_MIC_16BIT_RESOLUTION_EN 0x01
 #define ACP_I2S_SP_16BIT_RESOLUTION_EN	0x02
-- 
2.7.4
