From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 7/9] ASoC: amd: modifications in dma stop
	sequence
Date: Fri, 16 Feb 2018 13:03:52 +0530
Message-ID: <1518766434-7911-8-git-send-email-Vijendar.Mukunda@amd.com>
References: <1518766434-7911-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0059.outbound.protection.outlook.com [104.47.38.59])
 by alsa0.perex.cz (Postfix) with ESMTP id EB904267D9C
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 08:32:31 +0100 (CET)
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

As per design, non-circular dma also need to be
stopped explicitly for both playback and capture
scenarios.

Added condition checks to stop non-circular dma for
both the I2S controller instances.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 0e2dc05..a16e2bb 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -1178,11 +1178,15 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 			switch (rtd->i2s_play_instance) {
 			case I2S_BT_INSTANCE:
 				ret = acp_dma_stop(rtd->acp_mmio,
+						SYSRAM_TO_ACP_BT_INSTANCE_CH_NUM);
+				ret = acp_dma_stop(rtd->acp_mmio,
 						ACP_TO_I2S_DMA_BT_INSTANCE_CH_NUM);
 				rtd->i2sbt_renderbytescount = 0;
 				break;
 			case I2S_SP_INSTANCE:
 			default:
+				ret = acp_dma_stop(rtd->acp_mmio,
+						SYSRAM_TO_ACP_CH_NUM);
 				ret =  acp_dma_stop(rtd->acp_mmio,
 						ACP_TO_I2S_DMA_CH_NUM);
 				rtd->i2ssp_renderbytescount = 0;
@@ -1192,12 +1196,16 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 			case I2S_BT_INSTANCE:
 				ret = acp_dma_stop(rtd->acp_mmio,
 						I2S_TO_ACP_DMA_BT_INSTANCE_CH_NUM);
+				ret = acp_dma_stop(rtd->acp_mmio,
+						ACP_TO_SYSRAM_BT_INSTANCE_CH_NUM);
 				rtd->i2sbt_capturebytescount = 0;
 				break;
 			case I2S_SP_INSTANCE:
 			default:
 				ret = acp_dma_stop(rtd->acp_mmio,
 						I2S_TO_ACP_DMA_CH_NUM);
+				ret = acp_dma_stop(rtd->acp_mmio,
+						ACP_TO_SYSRAM_CH_NUM);
 				rtd->i2ssp_capturebytescount = 0;
 			}
 		}
-- 
2.7.4
