From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 8/9] ASoC: amd: 16bit resolution support for bt
	i2s instance
Date: Fri, 16 Feb 2018 13:03:53 +0530
Message-ID: <1518766434-7911-9-git-send-email-Vijendar.Mukunda@amd.com>
References: <1518766434-7911-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0043.outbound.protection.outlook.com [104.47.37.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 54362267D5E
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 08:32:37 +0100 (CET)
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

Added 16bit resolution support for BT I2S controller instance.
Moved 16bit resolution condition check to acp_hw_params.
During stream initalization ,depending upon substream only required
register value need to be programmed rather than enabling 16bit
resolution support all time in acp init.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 31 ++++++++++++++++++++++++-------
 sound/soc/amd/acp.h         |  3 +++
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index a16e2bb..e8310ce 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -639,13 +639,6 @@ static int acp_init(void __iomem *acp_mmio, u32 asic_type)
 		for (bank = 1; bank < 48; bank++)
 			acp_set_sram_bank_state(acp_mmio, bank, false);
 	}
-
-	/* Stoney supports 16bit resolution */
-	if (asic_type == CHIP_STONEY) {
-		val = acp_reg_read(acp_mmio, mmACP_I2S_16BIT_RESOLUTION_EN);
-		val |= 0x03;
-		acp_reg_write(val, acp_mmio, mmACP_I2S_16BIT_RESOLUTION_EN);
-	}
 	return 0;
 }
 
@@ -901,6 +894,7 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 {
 	int status;
 	uint64_t size;
+	u32 val = 0;
 	struct page *pg;
 	struct snd_pcm_runtime *runtime;
 	struct audio_substream_data *rtd;
@@ -914,6 +908,29 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	if (WARN_ON(!rtd))
 		return -EINVAL;
 
+	if (adata->asic_type == CHIP_STONEY) {
+		acp_reg_read(adata->acp_mmio, mmACP_I2S_16BIT_RESOLUTION_EN);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			switch (rtd->i2s_play_instance) {
+			case I2S_BT_INSTANCE:
+				val |= ACP_I2S_BT_16BIT_RESOLUTION_EN;
+				break;
+			case I2S_SP_INSTANCE:
+			default:
+				val |= ACP_I2S_SP_16BIT_RESOLUTION_EN;
+			}
+		} else {
+			switch (rtd->i2s_capture_instance) {
+			case I2S_BT_INSTANCE:
+				val |= ACP_I2S_BT_16BIT_RESOLUTION_EN;
+				break;
+			case I2S_SP_INSTANCE:
+			default:
+				val |= ACP_I2S_MIC_16BIT_RESOLUTION_EN;
+			}
+		}
+		acp_reg_write(val, adata->acp_mmio, mmACP_I2S_16BIT_RESOLUTION_EN);
+	}
 	size = params_buffer_bytes(params);
 	status = snd_pcm_lib_malloc_pages(substream, size);
 	if (status < 0)
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 0292433..cd83a03 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -103,6 +103,9 @@
 #define CAPTURE_END_DMA_DESCR_CH11 15
 
 #define mmACP_I2S_16BIT_RESOLUTION_EN       0x5209
+#define ACP_I2S_MIC_16BIT_RESOLUTION_EN 0x01
+#define ACP_I2S_SP_16BIT_RESOLUTION_EN	0x02
+#define ACP_I2S_BT_16BIT_RESOLUTION_EN	0x04
 #define I2S_SP_INSTANCE 1
 #define I2S_BT_INSTANCE 3
 enum acp_dma_priority_level {
-- 
2.7.4
