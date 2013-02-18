From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 4/5] ASoC: max98090: Remove unnecessary braces
Date: Mon, 18 Feb 2013 17:02:13 +0530
Message-ID: <1361187134-7525-4-git-send-email-sachin.kamat@linaro.org>
References: <1361187134-7525-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f52.google.com (mail-pb0-f52.google.com
 [209.85.160.52])
 by alsa0.perex.cz (Postfix) with ESMTP id B904A265080
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 12:42:18 +0100 (CET)
Received: by mail-pb0-f52.google.com with SMTP id ma3so1636964pbc.39
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 03:42:17 -0800 (PST)
In-Reply-To: <1361187134-7525-1-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, sachin.kamat@linaro.org, broonie@opensource.wolfsonmicro.com, jerry.wong@maximintegrated.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

Braces are not required for single line statements.
Silences the following checkpatch warnings:
WARNING: braces {} are not necessary for single statement blocks.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/codecs/max98090.c |   28 ++++++++++------------------
 1 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 1cf017f..4e8f88e 100755
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -805,12 +805,11 @@ static int max98090_micinput_event(struct snd_soc_dapm_widget *w,
 		val = (val & M98090_MIC_PA2EN_MASK) >> M98090_MIC_PA2EN_SHIFT;
 
 
-	if (val >= 1) {
-		if (w->reg == M98090_REG_MIC1_INPUT_LEVEL) {
+	if (val >= 1){
+		if (w->reg == M98090_REG_MIC1_INPUT_LEVEL)
 			max98090->pa1en = val - 1; /* Update for volatile */
-		} else {
+		else
 			max98090->pa2en = val - 1; /* Update for volatile */
-		}
 	}
 
 	switch (event) {
@@ -1701,9 +1700,8 @@ static int max98090_dai_set_fmt(struct snd_soc_dai *codec_dai,
 		 * seen for the case of TDM mode. The remaining cases have
 		 * normal logic.
 		 */
-		if (max98090->tdm_slots > 1) {
+		if (max98090->tdm_slots > 1)
 			regval ^= M98090_BCI_MASK;
-		}
 
 		snd_soc_write(codec,
 			M98090_REG_INTERFACE_FORMAT, regval);
@@ -1858,9 +1856,8 @@ static int max98090_dai_hw_params(struct snd_pcm_substream *substream,
 
 	/* Check for supported PCLK to LRCLK ratios */
 	for (j = 0; j < ARRAY_SIZE(comp_pclk_rates); j++) {
-		if (comp_pclk_rates[j] == max98090->sysclk) {
+		if (comp_pclk_rates[j] == max98090->sysclk)
 			break;
-		}
 	}
 
 	for (i = 0; i < ARRAY_SIZE(comp_lrclk_rates) - 1; i++) {
@@ -2057,17 +2054,14 @@ static irqreturn_t max98090_interrupt(int irq, void *data)
 	if (!active)
 		return IRQ_NONE;
 
-	if (active & M98090_CLD_MASK) {
+	if (active & M98090_CLD_MASK)
 		dev_err(codec->dev, "M98090_CLD_MASK\n");
-	}
 
-	if (active & M98090_SLD_MASK) {
+	if (active & M98090_SLD_MASK)
 		dev_dbg(codec->dev, "M98090_SLD_MASK\n");
-	}
 
-	if (active & M98090_ULK_MASK) {
+	if (active & M98090_ULK_MASK)
 		dev_err(codec->dev, "M98090_ULK_MASK\n");
-	}
 
 	if (active & M98090_JDET_MASK) {
 		dev_dbg(codec->dev, "M98090_JDET_MASK\n");
@@ -2078,13 +2072,11 @@ static irqreturn_t max98090_interrupt(int irq, void *data)
 			msecs_to_jiffies(100));
 	}
 
-	if (active & M98090_DRCACT_MASK) {
+	if (active & M98090_DRCACT_MASK)
 		dev_dbg(codec->dev, "M98090_DRCACT_MASK\n");
-	}
 
-	if (active & M98090_DRCCLP_MASK) {
+	if (active & M98090_DRCCLP_MASK)
 		dev_err(codec->dev, "M98090_DRCCLP_MASK\n");
-	}
 
 	return IRQ_HANDLED;
 }
-- 
1.7.4.1
