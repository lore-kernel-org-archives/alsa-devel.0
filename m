From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH] ASoC: amd: 16bit resolution support for i2s sp
	instance
Date: Fri, 9 Mar 2018 21:13:02 +0530
Message-ID: <1520610182-13122-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0087.outbound.protection.outlook.com [104.47.41.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 160B0266E78
 for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2018 16:40:37 +0100 (CET)
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

Moved 16bit resolution condition check for stoney platform
to acp_hw_params.Depending upon substream required register
value need to be programmed rather than enabling 16bit resolution
support all time in acp init.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 16 +++++++++-------
 sound/soc/amd/acp.h         |  2 ++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 9d7ab01..540088d 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -579,13 +579,6 @@ static int acp_init(void __iomem *acp_mmio, u32 asic_type)
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
 
@@ -774,6 +767,7 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 {
 	int status;
 	uint64_t size;
+	u32 val = 0;
 	struct page *pg;
 	struct snd_pcm_runtime *runtime;
 	struct audio_substream_data *rtd;
@@ -787,6 +781,14 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 	if (WARN_ON(!rtd))
 		return -EINVAL;
 
+	if (adata->asic_type == CHIP_STONEY) {
+		val = acp_reg_read(adata->acp_mmio, mmACP_I2S_16BIT_RESOLUTION_EN);
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			val |= ACP_I2S_SP_16BIT_RESOLUTION_EN;
+		else
+			val |= ACP_I2S_MIC_16BIT_RESOLUTION_EN;
+		acp_reg_write(val, adata->acp_mmio, mmACP_I2S_16BIT_RESOLUTION_EN);
+	}
 	size = params_buffer_bytes(params);
 	status = snd_pcm_lib_malloc_pages(substream, size);
 	if (status < 0)
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index 27803b2..ba01510 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -70,6 +70,8 @@
 #define CAPTURE_END_DMA_DESCR_CH15 7
 
 #define mmACP_I2S_16BIT_RESOLUTION_EN       0x5209
+#define ACP_I2S_MIC_16BIT_RESOLUTION_EN 0x01
+#define ACP_I2S_SP_16BIT_RESOLUTION_EN	0x02
 enum acp_dma_priority_level {
 	/* 0x0 Specifies the DMA channel is given normal priority */
 	ACP_DMA_PRIORITY_LEVEL_NORMAL = 0x0,
-- 
2.7.4
