From: Olivier Moysan <olivier.moysan@st.com>
Subject: [INTERNAL][PATCH 3/7] ASoC: stm32: sai: Fix DMA burst
	size
Date: Thu, 19 Oct 2017 15:03:19 +0200
Message-ID: <1508418203-16840-4-git-send-email-olivier.moysan@st.com>
References: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C4FFC266E90
 for <alsa-devel@alsa-project.org>; Thu, 19 Oct 2017 15:03:32 +0200 (CEST)
In-Reply-To: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com
Cc: arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Set best burst size tradeoff for 8, 16, 32 bits transfers.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_sai_sub.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index fdc1891..2af397d 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -445,12 +445,16 @@ static int stm32_sai_set_config(struct snd_soc_dai *cpu_dai,
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
 	cr1_mask = SAI_XCR1_DS_MASK;
@@ -479,10 +483,6 @@ static int stm32_sai_set_config(struct snd_soc_dai *cpu_dai,
 		return ret;
 	}
 
-	/* DMA config */
-	sai->dma_params.maxburst = STM_SAI_FIFO_SIZE * fth / sizeof(u32);
-	snd_soc_dai_set_dma_data(cpu_dai, substream, (void *)&sai->dma_params);
-
 	return 0;
 }
 
@@ -726,7 +726,12 @@ static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	int cr1 = 0, cr1_mask;
 
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
1.9.1
