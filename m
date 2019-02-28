From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH 3/5] ASoC: stm32: sai: fix race condition in irq handler
Date: Thu, 28 Feb 2019 14:19:23 +0100
Message-ID: <1551359965-25228-4-git-send-email-olivier.moysan@st.com>
References: <1551359965-25228-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551359965-25228-1-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

When snd_pcm_stop_xrun() is called in interrupt routine,
substream context may have already been released.
Add protection on substream context.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
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
2.7.4
