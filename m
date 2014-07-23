From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 3/3] ASoC: fsl_sai: Improve enable flow in fsl_sai_trigger()
Date: Wed, 23 Jul 2014 19:23:40 +0800
Message-ID: <b567391b537690c473414304078d9090ee94954f.1406113865.git.nicoleotsuka@gmail.com>
References: <cover.1406113865.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1406113865.git.nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org, Li.Xiubo@freescale.com, b42378@freescale.com, b02247@freescale.com
List-Id: alsa-devel@alsa-project.org

From: Nicolin Chen <Guangyu.Chen@freescale.com>

The previous enable flow:
1, Enable TE&RE (SAI starts to consume tx FIFO and feed rx FIFO)
2, Mask IRQ of Tx/Rx to enable its interrupt.
3, Enable DMA request of Tx/Rx.

As this flow would enable DMA request later than TERE, the Tx FIFO
would be easily emptied into underrun while Rx FIFO would be easily
stuffed into overrun due to the delayed DMA transfering.

This issue happened merely occational before the patch 'ASoC: fsl_sai:
Reset FIFOs after disabling TE/RE' because there were useless data
remaining in the FIFO for the gap. However, it manifested after FIFO
reset's implemented.

After this patch, the new flow:
1, Enable DMA request of Tx/Rx.
2, Enable TE&RE (SAI starts to consume tx FIFO and feed rx FIFO)
3, Mask IRQ of Tx/Rx to enable its interrupt.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index a79a9b0..364410b 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -346,6 +346,9 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
+				   FSL_SAI_CSR_FRDE, FSL_SAI_CSR_FRDE);
+
 		regmap_update_bits(sai->regmap, FSL_SAI_RCSR,
 				   FSL_SAI_CSR_TERE, FSL_SAI_CSR_TERE);
 		regmap_update_bits(sai->regmap, FSL_SAI_TCSR,
@@ -353,8 +356,6 @@ static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
 				   FSL_SAI_CSR_xIE_MASK, FSL_SAI_FLAGS);
-		regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx),
-				   FSL_SAI_CSR_FRDE, FSL_SAI_CSR_FRDE);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-- 
1.8.4
