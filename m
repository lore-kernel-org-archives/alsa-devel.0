From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: modifications in dma stop
	sequence" to the asoc tree
Date: Fri, 09 Mar 2018 18:03:40 +0000
Message-ID: <E1euMMm-00020U-Ll@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id ABDF4267616
 for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2018 19:03:43 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: modifications in dma stop sequence

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

>From 17aa9521d0c2856808c54ca1144d5c708e748928 Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Fri, 9 Mar 2018 20:51:32 +0530
Subject: [PATCH] ASoC: amd: modifications in dma stop sequence

As per design, non-circular dma also need to be
stopped explicitly for both playback and capture
scenarios.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-pcm-dma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
index 935c8fd42a7a..a1c6534455e6 100644
--- a/sound/soc/amd/acp-pcm-dma.c
+++ b/sound/soc/amd/acp-pcm-dma.c
@@ -949,12 +949,16 @@ static int acp_dma_trigger(struct snd_pcm_substream *substream, int cmd)
 		 * completes : SYSRAM_TO_ACP_CH_NUM / ACP_TO_SYSRAM_CH_NUM
 		 */
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			ret = acp_dma_stop(rtd->acp_mmio,
+						SYSRAM_TO_ACP_CH_NUM);
 			ret = acp_dma_stop(rtd->acp_mmio,
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
2.16.2
