From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: sai: Fix DMA burst size" to the
	asoc tree
Date: Sat, 21 Oct 2017 11:32:07 +0100 (BST)
Message-ID: <20171021103207.8EF64440057@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 21CDE267787
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 12:32:13 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, olivier moysan <olivier.moysan@st.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: sai: Fix DMA burst size

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

>From a4529d2b885747bb9393d507cd28649052d733f3 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Thu, 19 Oct 2017 15:03:19 +0200
Subject: [PATCH] ASoC: stm32: sai: Fix DMA burst size

Set best burst size tradeoff for 8, 16, 32 bits transfers.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 5e66bf310351..dde8ddf9e777 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -446,12 +446,16 @@ static int stm32_sai_set_config(struct snd_soc_dai *cpu_dai,
 {
 	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
 	int cr1, cr1_mask, ret;
-	int fth = STM_SAI_FIFO_TH_HALF;
 
-	/* FIFO config */
+	/*
+	 * DMA bursts increment is set to 4 words.
+	 * SAI fifo threshold is set to half fifo, to keep enough space
+	 * for DMA incoming bursts.
+	 */
 	regmap_update_bits(sai->regmap, STM_SAI_CR2_REGX,
 			   SAI_XCR2_FFLUSH | SAI_XCR2_FTH_MASK,
-			   SAI_XCR2_FFLUSH | SAI_XCR2_FTH_SET(fth));
+			   SAI_XCR2_FFLUSH |
+			   SAI_XCR2_FTH_SET(STM_SAI_FIFO_TH_HALF));
 
 	/* Mode, data format and channel config */
 	cr1 = SAI_XCR1_PRTCFG_SET(SAI_FREE_PROTOCOL);
@@ -485,10 +489,6 @@ static int stm32_sai_set_config(struct snd_soc_dai *cpu_dai,
 		return ret;
 	}
 
-	/* DMA config */
-	sai->dma_params.maxburst = STM_SAI_FIFO_SIZE * fth / sizeof(u32);
-	snd_soc_dai_set_dma_data(cpu_dai, substream, (void *)&sai->dma_params);
-
 	return 0;
 }
 
@@ -731,7 +731,12 @@ static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	struct stm32_sai_sub_data *sai = dev_get_drvdata(cpu_dai->dev);
 
 	sai->dma_params.addr = (dma_addr_t)(sai->phys_addr + STM_SAI_DR_REGX);
-	sai->dma_params.maxburst = 1;
+	/*
+	 * DMA supports 4, 8 or 16 burst sizes. Burst size 4 is the best choice,
+	 * as it allows bytes, half-word and words transfers. (See DMA fifos
+	 * constraints).
+	 */
+	sai->dma_params.maxburst = 4;
 	/* Buswidth will be set by framework at runtime */
 	sai->dma_params.addr_width = DMA_SLAVE_BUSWIDTH_UNDEFINED;
 
-- 
2.14.1
