From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH V2 04/10] ASoC: amd: pte offset related dma
	driver changes
Date: Wed, 2 May 2018 02:19:58 +0530
Message-ID: <1525207810-1305-4-git-send-email-Vijendar.Mukunda@amd.com>
References: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0060.outbound.protection.outlook.com [104.47.37.60])
 by alsa0.perex.cz (Postfix) with ESMTP id 665B9266F0F
 for <alsa-devel@alsa-project.org>; Tue,  1 May 2018 22:49:05 +0200 (CEST)
In-Reply-To: <1525207810-1305-1-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Takashi Iwai <tiwai@suse.com>, Jason Clinton <jclinton@chromium.org>, Mark Brown <broonie@kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

Added pte offset variable in audio_substream_data structure.
Added Stoney related PTE offset macros in acp header file.
Modified hw_params callback to assign the pte offset value
based on asic_type.
PTE Offset macros used to calculate no of PTE entries
need to be programmed when memory allocated for audio buffer.
Depending upon allocated audio buffer size, PTE offset values
will change.
Compared to CZ, Stoney has SRAM memory limitation i.e 48k
It is required to define separate PTE Offset macros for
Stoney.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
v1->v2: Modified commit message
 sound/soc/amd/acp-pcm-dma.c | 26 +++++++++++++++++++-------
 sound/soc/amd/acp.h         |  5 +++++
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 862c1cf..39597fb 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -320,13 +320,11 @@ static void config_acp_dma(void __iomem *acp_mmio,
 			   struct audio_substream_data *rtd,
 			   u32 asic_type)
 {
-	u32 pte_offset, sram_bank;
+	u32 sram_bank;
 
-	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
-		pte_offset = ACP_PLAYBACK_PTE_OFFSET;
+	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
 		sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
-	} else {
-		pte_offset = ACP_CAPTURE_PTE_OFFSET;
+	else {
 		switch (asic_type) {
 		case CHIP_STONEY:
 			sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
@@ -336,10 +334,10 @@ static void config_acp_dma(void __iomem *acp_mmio,
 		}
 	}
 	acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
-		       pte_offset);
+		       rtd->pte_offset);
 	/* Configure System memory <-> ACP SRAM DMA descriptors */
 	set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
-				       rtd->direction, pte_offset,
+				       rtd->direction, rtd->pte_offset,
 				       rtd->ch1, sram_bank,
 				       rtd->dma_dscr_idx_1, asic_type);
 	/* Configure ACP SRAM <-> I2S DMA descriptors */
@@ -788,6 +786,13 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		switch (adata->asic_type) {
+		case CHIP_STONEY:
+			rtd->pte_offset = ACP_ST_PLAYBACK_PTE_OFFSET;
+			break;
+		default:
+			rtd->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
+		}
 		rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
 		rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
 		rtd->destination = TO_ACP_I2S_1;
@@ -797,6 +802,13 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 				mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
 		rtd->byte_cnt_low_reg_offset = mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
 	} else {
+		switch (adata->asic_type) {
+		case CHIP_STONEY:
+			rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
+			break;
+		default:
+			rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
+		}
 		rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
 		rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
 		rtd->destination = FROM_ACP_I2S_1;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 82470bc..2f48d1d 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -10,6 +10,10 @@
 #define ACP_PLAYBACK_PTE_OFFSET			10
 #define ACP_CAPTURE_PTE_OFFSET			0
 
+/* Playback and Capture Offset for Stoney */
+#define ACP_ST_PLAYBACK_PTE_OFFSET	0x04
+#define ACP_ST_CAPTURE_PTE_OFFSET	0x00
+
 #define ACP_GARLIC_CNTL_DEFAULT			0x00000FB4
 #define ACP_ONION_CNTL_DEFAULT			0x00000FB4
 
@@ -90,6 +94,7 @@ struct audio_substream_data {
 	u16 destination;
 	u16 dma_dscr_idx_1;
 	u16 dma_dscr_idx_2;
+	u32 pte_offset;
 	u32 byte_cnt_high_reg_offset;
 	u32 byte_cnt_low_reg_offset;
 	uint64_t size;
-- 
2.7.4
