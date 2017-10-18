From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: DMA driver changes for Stoney
	Platform" to the asoc tree
Date: Wed, 18 Oct 2017 01:09:02 +0100
Message-ID: <E1e4buw-00040O-5Y@debutante>
References: <1501270294-31153-7-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 17D692673C1
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 02:11:52 +0200 (CEST)
In-Reply-To: <1501270294-31153-7-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, amd-gfx@lists.freedesktop.org, rajeevkumar.linux@gmail.com, broonie@kernel.org, dri-devel@lists.freedesktop.org, Vijendar.Mukunda@amd.com, Alex Deucher <alexander.deucher@amd.com>, airlied@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: DMA driver changes for Stoney Platform

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

>From e89cff5ed047d8108d1f0b093e5313647aecb2db Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Wed, 13 Sep 2017 13:57:53 -0400
Subject: [PATCH] ASoC: AMD: DMA driver changes for Stoney Platform

Added DMA driver changes for Stoney platform.
Below are the key differences between Stoney and CZ

In Stoney, Memory Gating is disabled.SRAM Banks won't
be turned off.No Of SRAM Banks reduced to 6.
DAGB Garlic Interface used and 16 bit resolution is supported.
SRAM bank 1 & SRAM bank 2 will be used for playback scenario.
SRAM Bank 3 & SRAM Bank 4 will be used for Capture scenario.

Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 87 +++++++++++++++++++++++++++++++++------------
 sound/soc/amd/acp.h         |  2 ++
 2 files changed, 67 insertions(+), 22 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index f00b6b92e076..f16e0b8e2ed7 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -137,8 +137,8 @@ static void config_dma_descriptor_in_sram(void __iomem *acp_mmio,
  * system memory <-> ACP SRAM
  */
 static void set_acp_sysmem_dma_descriptors(void __iomem *acp_mmio,
-					   u32 size, int direction,
-					   u32 pte_offset)
+					u32 size, int direction,
+					u32 pte_offset, u32 asic_type)
 {
 	u16 i;
 	u16 dma_dscr_idx = PLAYBACK_START_DMA_DESCR_CH12;
@@ -152,20 +152,42 @@ static void set_acp_sysmem_dma_descriptors(void __iomem *acp_mmio,
 					(size / 2) - (i * (size/2));
 			dmadscr[i].src = ACP_INTERNAL_APERTURE_WINDOW_0_ADDRESS
 				+ (pte_offset * SZ_4K) + (i * (size/2));
-			dmadscr[i].xfer_val |=
-			(ACP_DMA_ATTRIBUTES_DAGB_ONION_TO_SHAREDMEM << 16) |
-			(size / 2);
+			switch (asic_type) {
+			case CHIP_STONEY:
+				dmadscr[i].xfer_val |=
+				(ACP_DMA_ATTRIBUTES_DAGB_GARLIC_TO_SHAREDMEM  << 16) |
+				(size / 2);
+				break;
+			default:
+				dmadscr[i].xfer_val |=
+				(ACP_DMA_ATTRIBUTES_DAGB_ONION_TO_SHAREDMEM  << 16) |
+				(size / 2);
+			}
 		} else {
 			dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH14 + i;
-			dmadscr[i].src = ACP_SHARED_RAM_BANK_5_ADDRESS +
-					(i * (size/2));
-			dmadscr[i].dest = ACP_INTERNAL_APERTURE_WINDOW_0_ADDRESS
-						+ (pte_offset * SZ_4K) +
-						(i * (size/2));
-			dmadscr[i].xfer_val |=
-			BIT(22) |
-			(ACP_DMA_ATTRIBUTES_SHAREDMEM_TO_DAGB_ONION << 16) |
-			(size / 2);
+			switch (asic_type) {
+			case CHIP_STONEY:
+				dmadscr[i].src = ACP_SHARED_RAM_BANK_3_ADDRESS +
+				(i * (size/2));
+				dmadscr[i].dest =
+				ACP_INTERNAL_APERTURE_WINDOW_0_ADDRESS +
+				(pte_offset * SZ_4K) + (i * (size/2));
+				dmadscr[i].xfer_val |=
+				BIT(22) |
+				(ACP_DMA_ATTRIBUTES_SHARED_MEM_TO_DAGB_GARLIC << 16) |
+				(size / 2);
+				break;
+			default:
+				dmadscr[i].src = ACP_SHARED_RAM_BANK_5_ADDRESS +
+				(i * (size/2));
+				dmadscr[i].dest =
+				ACP_INTERNAL_APERTURE_WINDOW_0_ADDRESS +
+				(pte_offset * SZ_4K) + (i * (size/2));
+				dmadscr[i].xfer_val |=
+				BIT(22) |
+				(ACP_DMA_ATTRIBUTES_SHAREDMEM_TO_DAGB_ONION << 16) |
+				(size / 2);
+			}
 		}
 		config_dma_descriptor_in_sram(acp_mmio, dma_dscr_idx,
 						&dmadscr[i]);
@@ -186,7 +208,8 @@ static void set_acp_sysmem_dma_descriptors(void __iomem *acp_mmio,
  * ACP SRAM <-> I2S
  */
 static void set_acp_to_i2s_dma_descriptors(void __iomem *acp_mmio,
-					   u32 size, int direction)
+					u32 size, int direction,
+					u32 asic_type)
 {
 
 	u16 i;
@@ -207,8 +230,17 @@ static void set_acp_to_i2s_dma_descriptors(void __iomem *acp_mmio,
 			dma_dscr_idx = CAPTURE_START_DMA_DESCR_CH15 + i;
 			/* dmadscr[i].src is unused by hardware. */
 			dmadscr[i].src = 0;
-			dmadscr[i].dest = ACP_SHARED_RAM_BANK_5_ADDRESS +
+			switch (asic_type) {
+			case CHIP_STONEY:
+				dmadscr[i].dest =
+					 ACP_SHARED_RAM_BANK_3_ADDRESS +
 					(i * (size / 2));
+				break;
+			default:
+				dmadscr[i].dest =
+					 ACP_SHARED_RAM_BANK_5_ADDRESS +
+					(i * (size / 2));
+			}
 			dmadscr[i].xfer_val |= BIT(22) |
 					(FROM_ACP_I2S_1 << 16) | (size / 2);
 		}
@@ -264,7 +296,8 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
 }
 
 static void config_acp_dma(void __iomem *acp_mmio,
-			   struct audio_substream_data *audio_config)
+			struct audio_substream_data *audio_config,
+			u32 asic_type)
 {
 	u32 pte_offset;
 
@@ -278,11 +311,11 @@ static void config_acp_dma(void __iomem *acp_mmio,
 
 	/* Configure System memory <-> ACP SRAM DMA descriptors */
 	set_acp_sysmem_dma_descriptors(acp_mmio, audio_config->size,
-				       audio_config->direction, pte_offset);
+				audio_config->direction, pte_offset, asic_type);
 
 	/* Configure ACP SRAM <-> I2S DMA descriptors */
 	set_acp_to_i2s_dma_descriptors(acp_mmio, audio_config->size,
-					audio_config->direction);
+				audio_config->direction, asic_type);
 }
 
 /* Start a given DMA channel transfer */
@@ -502,6 +535,12 @@ static int acp_init(void __iomem *acp_mmio, u32 asic_type)
 			acp_set_sram_bank_state(acp_mmio, bank, false);
 	}
 
+	/* Stoney supports 16bit resolution */
+	if (asic_type == CHIP_STONEY) {
+		val = acp_reg_read(acp_mmio, mmACP_I2S_16BIT_RESOLUTION_EN);
+		val |= 0x03;
+		acp_reg_write(val, acp_mmio, mmACP_I2S_16BIT_RESOLUTION_EN);
+	}
 	return 0;
 }
 
@@ -680,6 +719,8 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	struct page *pg;
 	struct snd_pcm_runtime *runtime;
 	struct audio_substream_data *rtd;
+	struct snd_soc_pcm_runtime *prtd = substream->private_data;
+	struct audio_drv_data *adata = dev_get_drvdata(prtd->platform->dev);
 
 	runtime = substream->runtime;
 	rtd = runtime->private_data;
@@ -707,7 +748,7 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		rtd->num_of_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 		rtd->direction = substream->stream;
 
-		config_acp_dma(rtd->acp_mmio, rtd);
+		config_acp_dma(rtd->acp_mmio, rtd, adata->asic_type);
 		status = 0;
 	} else {
 		status = -ENOMEM;
@@ -1011,7 +1052,8 @@ static int acp_pcm_resume(struct device *dev)
 						true);
 		}
 		config_acp_dma(adata->acp_mmio,
-				adata->play_stream->runtime->private_data);
+			adata->play_stream->runtime->private_data,
+			adata->asic_type);
 	}
 	if (adata->capture_stream && adata->capture_stream->runtime) {
 		if (adata->asic_type != CHIP_STONEY) {
@@ -1020,7 +1062,8 @@ static int acp_pcm_resume(struct device *dev)
 						true);
 		}
 		config_acp_dma(adata->acp_mmio,
-				adata->capture_stream->runtime->private_data);
+			adata->capture_stream->runtime->private_data,
+			adata->asic_type);
 	}
 	acp_reg_write(1, adata->acp_mmio, mmACP_EXTERNAL_INTR_ENB);
 	return 0;
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 28cf9140f49c..a330a99bfff8 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -19,6 +19,7 @@
 
 /* Capture SRAM address (as a source in dma descriptor) */
 #define ACP_SHARED_RAM_BANK_5_ADDRESS		0x400A000
+#define ACP_SHARED_RAM_BANK_3_ADDRESS		0x4006000
 
 #define ACP_DMA_RESET_TIME			10000
 #define ACP_CLOCK_EN_TIME_OUT_VALUE		0x000000FF
@@ -67,6 +68,7 @@
 #define CAPTURE_START_DMA_DESCR_CH15 6
 #define CAPTURE_END_DMA_DESCR_CH15 7
 
+#define mmACP_I2S_16BIT_RESOLUTION_EN       0x5209
 enum acp_dma_priority_level {
 	/* 0x0 Specifies the DMA channel is given normal priority */
 	ACP_DMA_PRIORITY_LEVEL_NORMAL = 0x0,
-- 
2.14.1
