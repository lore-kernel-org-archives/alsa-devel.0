From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH] ASoC: amd: modifications in dma stop sequence
Date: Fri, 9 Mar 2018 20:51:32 +0530
Message-ID: <1520608892-12731-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0071.outbound.protection.outlook.com [104.47.40.71])
 by alsa0.perex.cz (Postfix) with ESMTP id D460C266E78
 for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2018 16:19:26 +0100 (CET)
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

As per design, non-circular dma also need to be
stopped explicitly for both playback and capture
scenarios.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-pcm-dma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 91c4775..9d7ab01 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -954,11 +954,15 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 		 */
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 			ret = acp_dma_stop(rtd->acp_mmio,
+						SYSRAM_TO_ACP_CH_NUM);
+			ret = acp_dma_stop(rtd->acp_mmio,
 					ACP_TO_I2S_DMA_CH_NUM);
 			rtd->i2ssp_renderbytescount = 0;
 		} else {
 			ret = acp_dma_stop(rtd->acp_mmio,
 					I2S_TO_ACP_DMA_CH_NUM);
+			ret = acp_dma_stop(rtd->acp_mmio,
+						ACP_TO_SYSRAM_CH_NUM);
 			rtd->i2ssp_capturebytescount = 0;
 		}
 		break;
-- 
2.7.4
