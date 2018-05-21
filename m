From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: sram bank update changes" to the asoc tree
Date: Mon, 21 May 2018 16:48:41 +0100
Message-ID: <E1fKn3B-0007Ks-SK@debutante>
References: <1525207810-1305-5-git-send-email-Vijendar.Mukunda@amd.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525207810-1305-5-git-send-email-Vijendar.Mukunda@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mukunda@sirena.org.uk
Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Mark Brown <broonie@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Takashi Iwai <tiwai@suse.com>, Jason Clinton <jclinton@chromium.org>Mark Brown <broonie@kernel.org>Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: sram bank update changes

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

>From 18e8a40dd387856e7f7a067dcfecbe644afe6944 Mon Sep 17 00:00:00 2001
From: "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
Date: Tue, 8 May 2018 10:17:48 +0530
Subject: [PATCH] ASoC: amd: sram bank update changes

Added sram bank variable to audio_substream_data structure.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 20 +++++---------------
 sound/soc/amd/acp.h         | 20 ++++++++++++++------
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index a3a7470a54db..39cd54f1b493 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -320,29 +320,16 @@ static void config_acp_dma(void __iomem *acp_mmio,
 			   struct audio_substream_data *rtd,
 			   u32 asic_type)
 {
-	u32 sram_bank;
-
-	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
-		sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
-	else {
-		switch (asic_type) {
-		case CHIP_STONEY:
-			sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
-			break;
-		default:
-			sram_bank = ACP_SHARED_RAM_BANK_5_ADDRESS;
-		}
-	}
 	acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
 		       rtd->pte_offset);
 	/* Configure System memory <-> ACP SRAM DMA descriptors */
 	set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
 				       rtd->direction, rtd->pte_offset,
-				       rtd->ch1, sram_bank,
+				       rtd->ch1, rtd->sram_bank,
 				       rtd->dma_dscr_idx_1, asic_type);
 	/* Configure ACP SRAM <-> I2S DMA descriptors */
 	set_acp_to_i2s_dma_descriptors(acp_mmio, rtd->size,
-				       rtd->direction, sram_bank,
+				       rtd->direction, rtd->sram_bank,
 				       rtd->destination, rtd->ch2,
 				       rtd->dma_dscr_idx_2, asic_type);
 }
@@ -795,6 +782,7 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		}
 		rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
 		rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
+		rtd->sram_bank = ACP_SRAM_BANK_1_ADDRESS;
 		rtd->destination = TO_ACP_I2S_1;
 		rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
 		rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
@@ -805,9 +793,11 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		switch (adata->asic_type) {
 		case CHIP_STONEY:
 			rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
+			rtd->sram_bank = ACP_SRAM_BANK_2_ADDRESS;
 			break;
 		default:
 			rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
+			rtd->sram_bank = ACP_SRAM_BANK_5_ADDRESS;
 		}
 		rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
 		rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 2f48d1d25243..62695ede997d 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -19,12 +19,19 @@
 
 #define ACP_PHYSICAL_BASE			0x14000
 
-/* Playback SRAM address (as a destination in dma descriptor) */
-#define ACP_SHARED_RAM_BANK_1_ADDRESS		0x4002000
-
-/* Capture SRAM address (as a source in dma descriptor) */
-#define ACP_SHARED_RAM_BANK_5_ADDRESS		0x400A000
-#define ACP_SHARED_RAM_BANK_3_ADDRESS		0x4006000
+/*
+ * In case of I2S SP controller instance, Stoney uses SRAM bank 1 for
+ * playback and SRAM Bank 2 for capture where as in case of BT I2S
+ * Instance, Stoney uses SRAM Bank 3 for playback & SRAM Bank 4 will
+ * be used for capture. Carrizo uses I2S SP controller instance. SRAM Banks
+ * 1, 2, 3, 4 will be used for playback & SRAM Banks 5, 6, 7, 8 will be used
+ * for capture scenario.
+ */
+#define ACP_SRAM_BANK_1_ADDRESS		0x4002000
+#define ACP_SRAM_BANK_2_ADDRESS		0x4004000
+#define ACP_SRAM_BANK_3_ADDRESS		0x4006000
+#define ACP_SRAM_BANK_4_ADDRESS		0x4008000
+#define ACP_SRAM_BANK_5_ADDRESS		0x400A000
 
 #define ACP_DMA_RESET_TIME			10000
 #define ACP_CLOCK_EN_TIME_OUT_VALUE		0x000000FF
@@ -95,6 +102,7 @@ struct audio_substream_data {
 	u16 dma_dscr_idx_1;
 	u16 dma_dscr_idx_2;
 	u32 pte_offset;
+	u32 sram_bank;
 	u32 byte_cnt_high_reg_offset;
 	u32 byte_cnt_low_reg_offset;
 	uint64_t size;
-- 
2.17.0
