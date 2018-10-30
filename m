From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: [PATCH v2] ASoC: AMD: Fix race condition between
	register access
Date: Tue, 30 Oct 2018 16:26:52 +0000
Message-ID: <1540916701-22028-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0056.outbound.protection.outlook.com [104.47.32.56])
 by alsa0.perex.cz (Postfix) with ESMTP id AF07E26770D
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2018 17:26:56 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>, Mark Brown <broonie@kernel.org>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Agrawal,
 Akshu" <Akshu.Agrawal@amd.com>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

During simultaneous running of playback and capture, we
got hit by incorrect value write on common register. This was due
to race condition between 2 streams.
Fixing this by locking the common register access.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v2: Added 2 helper functions, removed locking in ch enable/disable as they
are separate registers.
 sound/soc/amd/acp-pcm-dma.c | 63 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 0ac4b5b..5be9c2d 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -121,6 +121,9 @@
 	.periods_max = CAPTURE_MAX_NUM_PERIODS,
 };
 
+/* Lock to protect access to registers */
+static DEFINE_SPINLOCK(lock);
+
 static u32 acp_reg_read(void __iomem *acp_mmio, u32 reg)
 {
 	return readl(acp_mmio + (reg * 4));
@@ -131,6 +134,33 @@ static void acp_reg_write(u32 val, void __iomem *acp_mmio, u32 reg)
 	writel(val, acp_mmio + (reg * 4));
 }
 
+static void acp_reg_write_srbm_targ(void __iomem *acp_mmio,
+				    u32 addr, u32 data)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&lock, flags);
+	acp_reg_write(addr, acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
+	acp_reg_write(data, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
+	spin_unlock_irqrestore(&lock, flags);
+}
+
+static void acp_reg_read_mod_write(void __iomem *acp_mmio, u32 addr,
+				   u32 mask, bool set)
+{
+	u32 val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&lock, flags);
+	val = acp_reg_read(acp_mmio, addr);
+	if (set)
+		val |= mask;
+	else
+		val &= ~mask;
+	acp_reg_write(val, acp_mmio, addr);
+	spin_unlock_irqrestore(&lock, flags);
+}
+
 /*
  * Configure a given dma channel parameters - enable/disable,
  * number of descriptors, priority
@@ -172,15 +202,12 @@ static void config_dma_descriptor_in_sram(void __iomem *acp_mmio,
 	sram_offset = (descr_idx * sizeof(acp_dma_dscr_transfer_t));
 
 	/* program the source base address. */
-	acp_reg_write(sram_offset, acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
-	acp_reg_write(descr_info->src,	acp_mmio, mmACP_SRBM_Targ_Idx_Data);
+	acp_reg_write_srbm_targ(acp_mmio, sram_offset, descr_info->src);
 	/* program the destination base address. */
-	acp_reg_write(sram_offset + 4,	acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
-	acp_reg_write(descr_info->dest, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
-
+	acp_reg_write_srbm_targ(acp_mmio, sram_offset + 4, descr_info->dest);
 	/* program the number of bytes to be transferred for this descriptor. */
-	acp_reg_write(sram_offset + 8,	acp_mmio, mmACP_SRBM_Targ_Idx_Addr);
-	acp_reg_write(descr_info->xfer_val, acp_mmio, mmACP_SRBM_Targ_Idx_Data);
+	acp_reg_write_srbm_targ(acp_mmio, sram_offset + 8,
+				descr_info->xfer_val);
 }
 
 static void pre_config_reset(void __iomem *acp_mmio, u16 ch_num)
@@ -309,8 +336,12 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
 	u32 low;
 	u32 high;
 	u32 offset;
+	unsigned long flags;
 
 	offset	= ACP_DAGB_GRP_SRBM_SRAM_BASE_OFFSET + (pte_offset * 8);
+
+	spin_lock_irqsave(&lock, flags);
+
 	for (page_idx = 0; page_idx < (num_of_pages); page_idx++) {
 		/* Load the low address of page int ACP SRAM through SRBM */
 		acp_reg_write((offset + (page_idx * 8)),
@@ -333,6 +364,8 @@ static void acp_pte_config(void __iomem *acp_mmio, struct page *pg,
 		/* Move to next physically contiguos page */
 		pg++;
 	}
+
+	spin_unlock_irqrestore(&lock, flags);
 }
 
 static void config_acp_dma(void __iomem *acp_mmio,
@@ -870,29 +903,29 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 	if (adata->asic_type == CHIP_STONEY) {
-		val = acp_reg_read(adata->acp_mmio,
-				   mmACP_I2S_16BIT_RESOLUTION_EN);
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			switch (rtd->i2s_instance) {
 			case I2S_BT_INSTANCE:
-				val |= ACP_I2S_BT_16BIT_RESOLUTION_EN;
+				val = ACP_I2S_BT_16BIT_RESOLUTION_EN;
 				break;
 			case I2S_SP_INSTANCE:
 			default:
-				val |= ACP_I2S_SP_16BIT_RESOLUTION_EN;
+				val = ACP_I2S_SP_16BIT_RESOLUTION_EN;
 			}
 		} else {
 			switch (rtd->i2s_instance) {
 			case I2S_BT_INSTANCE:
-				val |= ACP_I2S_BT_16BIT_RESOLUTION_EN;
+				val = ACP_I2S_BT_16BIT_RESOLUTION_EN;
 				break;
 			case I2S_SP_INSTANCE:
 			default:
-				val |= ACP_I2S_MIC_16BIT_RESOLUTION_EN;
+				val = ACP_I2S_MIC_16BIT_RESOLUTION_EN;
 			}
 		}
-		acp_reg_write(val, adata->acp_mmio,
-			      mmACP_I2S_16BIT_RESOLUTION_EN);
+		acp_reg_read_mod_write(adata->acp_mmio,
+				       mmACP_I2S_16BIT_RESOLUTION_EN,
+				       val,
+				       true);
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-- 
1.9.1
