From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: Use current HW pointer for
	pointer callback" to the asoc tree
Date: Tue, 08 Dec 2015 19:11:30 +0000
Message-ID: <E1a6Nfe-00045w-Gx@debutante>
References: <1449129208-63615-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E5052606E9
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 20:11:39 +0100 (CET)
In-Reply-To: <1449129208-63615-1-git-send-email-koro.chen@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Koro Chen <koro.chen@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: Use current HW pointer for pointer callback

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

>From 8d6f88ce961cf62137696627448cfd6038f07f41 Mon Sep 17 00:00:00 2001
From: Koro Chen <koro.chen@mediatek.com>
Date: Thu, 3 Dec 2015 15:53:28 +0800
Subject: [PATCH] ASoC: mediatek: Use current HW pointer for pointer callback

Previously we recorded "last interrupt position" and used it in
pointer callback. This is not correct implementation, and it causes
underruns when user space monitors buffer level to decide when to
send next data chunk in low latency application.

Remove position recording in IRQ handler and also hw_ptr in
struct mtk_afe_memif used to record that, and let pointer callback
reports current HW pointer instead.

Signed-off-by: Koro Chen <koro.chen@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mtk-afe-common.h |  1 -
 sound/soc/mediatek/mtk-afe-pcm.c    | 22 +++++++++++-----------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/sound/soc/mediatek/mtk-afe-common.h b/sound/soc/mediatek/mtk-afe-common.h
index cc4393cb1130..9b1af1a70874 100644
--- a/sound/soc/mediatek/mtk-afe-common.h
+++ b/sound/soc/mediatek/mtk-afe-common.h
@@ -92,7 +92,6 @@ struct mtk_afe_memif_data {
 struct mtk_afe_memif {
 	unsigned int phys_buf_addr;
 	int buffer_size;
-	unsigned int hw_ptr;		/* Previous IRQ's HW ptr */
 	struct snd_pcm_substream *substream;
 	const struct mtk_afe_memif_data *data;
 	const struct mtk_afe_irq_data *irqdata;
diff --git a/sound/soc/mediatek/mtk-afe-pcm.c b/sound/soc/mediatek/mtk-afe-pcm.c
index 7f7134397f73..5399a0eead3e 100644
--- a/sound/soc/mediatek/mtk-afe-pcm.c
+++ b/sound/soc/mediatek/mtk-afe-pcm.c
@@ -175,8 +175,17 @@ static snd_pcm_uframes_t mtk_afe_pcm_pointer
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct mtk_afe *afe = snd_soc_platform_get_drvdata(rtd->platform);
 	struct mtk_afe_memif *memif = &afe->memif[rtd->cpu_dai->id];
+	unsigned int hw_ptr;
+	int ret;
+
+	ret = regmap_read(afe->regmap, memif->data->reg_ofs_cur, &hw_ptr);
+	if (ret || hw_ptr == 0) {
+		dev_err(afe->dev, "%s hw_ptr err\n", __func__);
+		hw_ptr = memif->phys_buf_addr;
+	}
 
-	return bytes_to_frames(substream->runtime, memif->hw_ptr);
+	return bytes_to_frames(substream->runtime,
+			       hw_ptr - memif->phys_buf_addr);
 }
 
 static const struct snd_pcm_ops mtk_afe_pcm_ops = {
@@ -602,7 +611,6 @@ static int mtk_afe_dais_hw_params(struct snd_pcm_substream *substream,
 
 	memif->phys_buf_addr = substream->runtime->dma_addr;
 	memif->buffer_size = substream->runtime->dma_bytes;
-	memif->hw_ptr = 0;
 
 	/* start */
 	regmap_write(afe->regmap,
@@ -737,7 +745,6 @@ static int mtk_afe_dais_trigger(struct snd_pcm_substream *substream, int cmd,
 		/* and clear pending IRQ */
 		regmap_write(afe->regmap, AFE_IRQ_CLR,
 			     1 << memif->data->irq_clr_shift);
-		memif->hw_ptr = 0;
 		return 0;
 	default:
 		return -EINVAL;
@@ -1081,7 +1088,7 @@ static const struct regmap_config mtk_afe_regmap_config = {
 static irqreturn_t mtk_afe_irq_handler(int irq, void *dev_id)
 {
 	struct mtk_afe *afe = dev_id;
-	unsigned int reg_value, hw_ptr;
+	unsigned int reg_value;
 	int i, ret;
 
 	ret = regmap_read(afe->regmap, AFE_IRQ_STATUS, &reg_value);
@@ -1097,13 +1104,6 @@ static irqreturn_t mtk_afe_irq_handler(int irq, void *dev_id)
 		if (!(reg_value & (1 << memif->data->irq_clr_shift)))
 			continue;
 
-		ret = regmap_read(afe->regmap, memif->data->reg_ofs_cur,
-				  &hw_ptr);
-		if (ret || hw_ptr == 0) {
-			dev_err(afe->dev, "%s hw_ptr err\n", __func__);
-			hw_ptr = memif->phys_buf_addr;
-		}
-		memif->hw_ptr = hw_ptr - memif->phys_buf_addr;
 		snd_pcm_period_elapsed(memif->substream);
 	}
 
-- 
2.6.2
