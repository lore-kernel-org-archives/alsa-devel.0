From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 7/8] ASoC: amd: 16bit resolution support for bt
	i2s instance
Date: Mon, 26 Mar 2018 18:43:02 +0530
Message-ID: <1522069983-11381-8-git-send-email-Vijendar.Mukunda@amd.com>
References: <1522069983-11381-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0087.outbound.protection.outlook.com [104.47.32.87])
 by alsa0.perex.cz (Postfix) with ESMTP id F0ECD26720A
 for <alsa-devel@alsa-project.org>; Mon, 26 Mar 2018 15:12:49 +0200 (CEST)
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

added 16bit resolution support for bt i2s instance for stoney.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 29 +++++++++++++++++++++++------
 sound/soc/amd/acp.h         |  1 +
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index c695e42..92b163a 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -916,12 +916,29 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 
 	if (adata->asic_type == CHIP_STONEY) {
-		val = acp_reg_read(adata->acp_mmio, mmACP_I2S_16BIT_RESOLUTION_EN);
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			val |= ACP_I2S_SP_16BIT_RESOLUTION_EN;
-		else
-			val |= ACP_I2S_MIC_16BIT_RESOLUTION_EN;
-		acp_reg_write(val, adata->acp_mmio, mmACP_I2S_16BIT_RESOLUTION_EN);
+		val = acp_reg_read(adata->acp_mmio,
+				mmACP_I2S_16BIT_RESOLUTION_EN);
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
+		acp_reg_write(val, adata->acp_mmio,
+			mmACP_I2S_16BIT_RESOLUTION_EN);
 	}
 	size = params_buffer_bytes(params);
 	status = snd_pcm_lib_malloc_pages(substream, size);
diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
index b697dcb..a91f0a9 100644
--- a/sound/soc/amd/acp.h
+++ b/sound/soc/amd/acp.h
@@ -106,6 +106,7 @@
 #define mmACP_I2S_16BIT_RESOLUTION_EN       0x5209
 #define ACP_I2S_MIC_16BIT_RESOLUTION_EN 0x01
 #define ACP_I2S_SP_16BIT_RESOLUTION_EN	0x02
+#define ACP_I2S_BT_16BIT_RESOLUTION_EN	0x04
 enum acp_dma_priority_level {
 	/* 0x0 Specifies the DMA channel is given normal priority */
 	ACP_DMA_PRIORITY_LEVEL_NORMAL = 0x0,
-- 
2.7.4
