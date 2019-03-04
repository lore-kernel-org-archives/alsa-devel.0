From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: sai: fix race condition in irq handler" to the asoc tree
Date: Mon,  4 Mar 2019 00:05:59 +0000 (GMT)
Message-ID: <20190304000559.B9E0A440082@finisterre.ee.mobilebroadband>
References: <1551359965-25228-4-git-send-email-olivier.moysan@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551359965-25228-4-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: sai: fix race condition in irq handler

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

>From 26f98e82dd49b7c3cc5ef0edd882aa732a62b672 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Thu, 28 Feb 2019 14:19:23 +0100
Subject: [PATCH] ASoC: stm32: sai: fix race condition in irq handler

When snd_pcm_stop_xrun() is called in interrupt routine,
substream context may have already been released.
Add protection on substream context.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index e418f446e03b..cad415e03b5e 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -102,6 +102,7 @@
  * @spdif_frm_cnt: S/PDIF playback frame counter
  * @iec958: iec958 data
  * @ctrl_lock: control lock
+ * @irq_lock: prevent race condition with IRQ
  */
 struct stm32_sai_sub_data {
 	struct platform_device *pdev;
@@ -133,6 +134,7 @@ struct stm32_sai_sub_data {
 	unsigned int spdif_frm_cnt;
 	struct snd_aes_iec958 iec958;
 	struct mutex ctrl_lock; /* protect resources accessed by controls */
+	spinlock_t irq_lock; /* used to prevent race condition with IRQ */
 };
 
 enum stm32_sai_fifo_th {
@@ -474,8 +476,10 @@ static irqreturn_t stm32_sai_isr(int irq, void *devid)
 		status = SNDRV_PCM_STATE_XRUN;
 	}
 
-	if (status != SNDRV_PCM_STATE_RUNNING)
+	spin_lock(&sai->irq_lock);
+	if (status != SNDRV_PCM_STATE_RUNNING && sai->substream)
 		snd_pcm_stop_xrun(sai->substream);
+	spin_unlock(&sai->irq_lock);
 
 	return IRQ_HANDLED;
 }
@@ -679,8 +683,11 @@ static int stm32_sai_startup(struct snd_pcm_substream *substream,
 {
 	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
 	int imr, cr2, ret;
+	unsigned long flags;
 
+	spin_lock_irqsave(&sai->irq_lock, flags);
 	sai->substream = substream;
+	spin_unlock_irqrestore(&sai->irq_lock, flags);
 
 	if (STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
 		snd_pcm_hw_constraint_mask64(substream->runtime,
@@ -1059,6 +1066,7 @@ static void stm32_sai_shutdown(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_sai_sub_data *sai = snd_soc_dai_get_drvdata(cpu_dai);
+	unsigned long flags;
 
 	regmap_update_bits(sai->regmap, STM_SAI_IMR_REGX, SAI_XIMR_MASK, 0);
 
@@ -1069,7 +1077,9 @@ static void stm32_sai_shutdown(struct snd_pcm_substream *substream,
 
 	clk_rate_exclusive_put(sai->sai_mclk);
 
+	spin_lock_irqsave(&sai->irq_lock, flags);
 	sai->substream = NULL;
+	spin_unlock_irqrestore(&sai->irq_lock, flags);
 }
 
 static int stm32_sai_pcm_new(struct snd_soc_pcm_runtime *rtd,
@@ -1433,6 +1443,7 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 
 	sai->pdev = pdev;
 	mutex_init(&sai->ctrl_lock);
+	spin_lock_init(&sai->irq_lock);
 	platform_set_drvdata(pdev, sai);
 
 	sai->pdata = dev_get_drvdata(pdev->dev.parent);
-- 
2.20.1
