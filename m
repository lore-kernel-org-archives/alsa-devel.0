From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_sai: add tdm slots operation
	support" to the asoc tree
Date: Wed, 25 Nov 2015 12:11:09 +0000
Message-ID: <E1a1Yuj-0001ns-HT@debutante>
References: <c305d87967734ad68067cca39c9e61c35dacf3b7.1448350220.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 503C726058D
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 13:11:21 +0100 (CET)
In-Reply-To: <c305d87967734ad68067cca39c9e61c35dacf3b7.1448350220.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_sai: add tdm slots operation support

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

>From c1df29648f1e3ffb8bac38e27a22b50f5c019adf Mon Sep 17 00:00:00 2001
From: Zidan Wang <zidan.wang@freescale.com>
Date: Tue, 24 Nov 2015 15:31:54 +0800
Subject: [PATCH] ASoC: fsl_sai: add tdm slots operation support

Add tdm slots operation support. If tdm slots and slot width have
been configured in machine driver, we should use these values.
Otherwise, using relevant channels and word length to set slots
and slot width.

SAI will generate BCLK depends on sample rate, slots and slot width.
And there may be unused BCLK cycles before each LRCLK transition.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 31 +++++++++++++++++++++++++------
 sound/soc/fsl/fsl_sai.h |  3 +++
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 520dbadaa8b1..43ba5dc26775 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -126,6 +126,17 @@ out:
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
@@ -395,11 +406,19 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	unsigned int channels = params_channels(params);
 	u32 word_width = snd_pcm_format_width(params_format(params));
 	u32 val_cr4 = 0, val_cr5 = 0;
+	u32 slots = (channels == 1) ? 2 : channels;
+	u32 slot_width = word_width;
 	int ret;
 
+	if (sai->slots)
+		slots = sai->slots;
+
+	if (sai->slot_width)
+		slot_width = sai->slot_width;
+
 	if (!sai->is_slave_mode) {
 		ret = fsl_sai_set_bclk(cpu_dai, tx,
-			2 * word_width * params_rate(params));
+				slots * slot_width * params_rate(params));
 		if (ret)
 			return ret;
 
@@ -411,21 +430,20 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 
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
+	val_cr4 |= FSL_SAI_CR4_FRSZ(slots);
 
 	/*
 	 * For SAI master mode, when Tx(Rx) sync with Rx(Tx) clock, Rx(Tx) will
@@ -591,6 +609,7 @@ static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
 static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
 	.set_sysclk	= fsl_sai_set_dai_sysclk,
 	.set_fmt	= fsl_sai_set_dai_fmt,
+	.set_tdm_slot	= fsl_sai_set_dai_tdm_slot,
 	.hw_params	= fsl_sai_hw_params,
 	.hw_free	= fsl_sai_hw_free,
 	.trigger	= fsl_sai_trigger,
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index b95fbc3f68eb..d9ed7be8cb34 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -143,6 +143,9 @@ struct fsl_sai {
 
 	unsigned int mclk_id[2];
 	unsigned int mclk_streams;
+	unsigned int slots;
+	unsigned int slot_width;
+
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 };
-- 
2.6.2
