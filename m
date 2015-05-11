From: Zidan Wang <zidan.wang@freescale.com>
Subject: [PATCH 2/3] ASoC: fsl_sai: Add tdm slots operation for
	SAI master mode
Date: Mon, 11 May 2015 18:24:42 +0800
Message-ID: <1431339894-4248-2-git-send-email-zidan.wang@freescale.com>
References: <cover.1431337606.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0130.outbound.protection.outlook.com [207.46.100.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 50DC92614A4
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 12:23:22 +0200 (CEST)
In-Reply-To: <cover.1431337606.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: nicoleotsuka@gmail.com
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Zidan Wang <zidan.wang@freescale.com>, Xiubo.Lee@gmail.com, tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Add tdm slot operation for SAI master mode. When using SAI as master
mode, we should use set_tdm_slot() helper function to set tdm slots
in machine driver, or it will using default value of slots and slot
width.

SAI will generate BCLK depends on sample rate, slots and slot width.
And there may be unused BCLK cycles before each LRCLK transition.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
---
 sound/soc/fsl/fsl_sai.c | 28 ++++++++++++++++++++++------
 sound/soc/fsl/fsl_sai.h |  3 +++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 1ccc10d1..88f5861 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -115,6 +115,17 @@ out:
 		return IRQ_HANDLED;
 }
 
+static int fsl_sai_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
+				u32 rx_mask, int slots, int slot_width)
+{
+	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
+
+	sai->slots = slots;
+	sai->slot_width = slot_width;
+
+	return 0;
+}
+
 static int fsl_sai_set_dai_sysclk_tr(struct snd_soc_dai *cpu_dai,
 		int clk_id, unsigned int freq, int fsl_dir)
 {
@@ -372,11 +383,13 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	unsigned int channels = params_channels(params);
 	u32 word_width = snd_pcm_format_width(params_format(params));
 	u32 val_cr4 = 0, val_cr5 = 0;
+	u32 slot_width = word_width;
 	int ret;
 
 	if (!sai->is_slave_mode) {
+		slot_width = sai->slot_width;
 		ret = fsl_sai_set_bclk(cpu_dai, tx,
-			2 * word_width * params_rate(params));
+				sai->slots * slot_width * params_rate(params));
 		if (ret)
 			return ret;
 
@@ -388,21 +401,20 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 
 			sai->mclk_streams |= BIT(substream->stream);
 		}
-
 	}
 
 	if (!sai->is_dsp_mode)
-		val_cr4 |= FSL_SAI_CR4_SYWD(word_width);
+		val_cr4 |= FSL_SAI_CR4_SYWD(slot_width);
 
-	val_cr5 |= FSL_SAI_CR5_WNW(word_width);
-	val_cr5 |= FSL_SAI_CR5_W0W(word_width);
+	val_cr5 |= FSL_SAI_CR5_WNW(slot_width);
+	val_cr5 |= FSL_SAI_CR5_W0W(slot_width);
 
 	if (sai->is_lsb_first)
 		val_cr5 |= FSL_SAI_CR5_FBT(0);
 	else
 		val_cr5 |= FSL_SAI_CR5_FBT(word_width - 1);
 
-	val_cr4 |= FSL_SAI_CR4_FRSZ(channels);
+	val_cr4 |= FSL_SAI_CR4_FRSZ(sai->slots);
 
 	regmap_update_bits(sai->regmap, FSL_SAI_xCR4(tx),
 			   FSL_SAI_CR4_SYWD_MASK | FSL_SAI_CR4_FRSZ_MASK,
@@ -536,6 +548,7 @@ static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
 static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
 	.set_sysclk	= fsl_sai_set_dai_sysclk,
 	.set_fmt	= fsl_sai_set_dai_fmt,
+	.set_tdm_slot	= fsl_sai_set_dai_tdm_slot,
 	.hw_params	= fsl_sai_hw_params,
 	.hw_free	= fsl_sai_hw_free,
 	.trigger	= fsl_sai_trigger,
@@ -721,6 +734,9 @@ static int fsl_sai_probe(struct platform_device *pdev)
 		}
 	}
 
+	sai->slots = 2;
+	sai->slot_width = 32;
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 0662809..1ec09d6 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -142,6 +142,9 @@ struct fsl_sai {
 
 	unsigned int mclk_id[2];
 	unsigned int mclk_streams;
+	unsigned int slots;
+	unsigned int slot_width;
+
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 };
-- 
1.9.1
