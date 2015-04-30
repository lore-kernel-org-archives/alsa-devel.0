From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 09/14] ASoC: qcom: Add ability to handle interrupts per dma channel
Date: Thu, 30 Apr 2015 18:17:42 +0100
Message-ID: <1430414262-11252-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds ablity to lpass driver to handle interrupt per dma
channel. Without this patch its not possible to use multipl ports on the
lpass.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-platform.c | 89 +++++++++++++++++++++++++----------------
 sound/soc/qcom/lpass.h          |  4 ++
 2 files changed, 58 insertions(+), 35 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 8ab0ac1..c5907d5 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -356,27 +356,15 @@ static struct snd_pcm_ops lpass_platform_pcm_ops = {
 	.mmap		= lpass_platform_pcmops_mmap,
 };
 
-static irqreturn_t lpass_platform_lpaif_irq(int irq, void *data)
+static irqreturn_t lpass_dma_interrupt_handler(
+			struct snd_pcm_substream *substream,
+			struct lpass_data *drvdata,
+			int chan, u32 interrupts)
 {
-	struct snd_pcm_substream *substream = data;
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
-	struct lpass_data *drvdata =
-		snd_soc_platform_get_drvdata(soc_runtime->platform);
 	struct lpass_variant *v = drvdata->variant;
-	struct lpass_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(soc_runtime);
-	unsigned int interrupts;
 	irqreturn_t ret = IRQ_NONE;
-	int rv, chan = pcm_data->rdma_ch;
-
-	rv = regmap_read(drvdata->lpaif_map,
-			LPAIF_IRQSTAT_REG(v, LPAIF_IRQ_PORT_HOST), &interrupts);
-	if (rv) {
-		dev_err(soc_runtime->dev, "%s() error reading from irqstat reg: %d\n",
-				__func__, rv);
-		return IRQ_NONE;
-	}
-
-	interrupts &= LPAIF_IRQ_ALL(chan);
+	int rv;
 
 	if (interrupts & LPAIF_IRQ_PER(chan)) {
 		rv = regmap_write(drvdata->lpaif_map,
@@ -422,6 +410,30 @@ static irqreturn_t lpass_platform_lpaif_irq(int irq, void *data)
 	return ret;
 }
 
+static irqreturn_t lpass_platform_lpaif_irq(int irq, void *data)
+{
+	struct lpass_data *drvdata = data;
+	struct lpass_variant *v = drvdata->variant;
+	unsigned int irqs;
+	int rv, chan;
+
+	rv = regmap_read(drvdata->lpaif_map,
+			LPAIF_IRQSTAT_REG(v, LPAIF_IRQ_PORT_HOST), &irqs);
+	if (rv) {
+		pr_err("%s() error reading from irqstat reg: %d\n",
+				__func__, rv);
+		return IRQ_NONE;
+	}
+
+	/* Handle per channel interrupts */
+	for (chan = 0; chan < LPASS_MAX_DMA_CHANNELS; chan++)
+		if (irqs & LPAIF_IRQ_ALL(chan) && drvdata->substream[chan])
+			lpass_dma_interrupt_handler(drvdata->substream[chan],
+						    drvdata, chan, irqs);
+
+	return IRQ_HANDLED;
+}
+
 static int lpass_platform_alloc_buffer(struct snd_pcm_substream *substream,
 		struct snd_soc_pcm_runtime *soc_runtime)
 {
@@ -477,6 +489,7 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 	if (IS_ERR_VALUE(data->rdma_ch))
 		return data->rdma_ch;
 
+	drvdata->substream[data->rdma_ch] = substream;
 	data->i2s_port = cpu_dai->driver->id;
 
 	snd_soc_pcm_set_drvdata(soc_runtime, data);
@@ -488,29 +501,12 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 	if (ret)
 		return ret;
 
-	ret = devm_request_irq(soc_runtime->dev, drvdata->lpaif_irq,
-			lpass_platform_lpaif_irq, IRQF_TRIGGER_RISING,
-			"lpass-irq-lpaif", substream);
-	if (ret) {
-		dev_err(soc_runtime->dev, "%s() irq request failed: %d\n",
-				__func__, ret);
-		goto err_buf;
-	}
-
-	/* ensure audio hardware is disabled */
-	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_IRQEN_REG(v, LPAIF_IRQ_PORT_HOST), 0);
-	if (ret) {
-		dev_err(soc_runtime->dev, "%s() error writing to irqen reg: %d\n",
-				__func__, ret);
-		return ret;
-	}
 	ret = regmap_write(drvdata->lpaif_map,
 			LPAIF_RDMACTL_REG(v, data->rdma_ch), 0);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
 				__func__, ret);
-		return ret;
+		goto err_buf;
 	}
 
 	return 0;
@@ -530,6 +526,8 @@ static void lpass_platform_pcm_free(struct snd_pcm *pcm)
 	struct lpass_pcm_data *data = snd_soc_pcm_get_drvdata(soc_runtime);
 	struct lpass_variant *v = drvdata->variant;
 
+	drvdata->substream[data->rdma_ch] = NULL;
+
 	if (v->free_dma_channel)
 		v->free_dma_channel(drvdata, data->rdma_ch);
 
@@ -545,6 +543,8 @@ static struct snd_soc_platform_driver lpass_platform_driver = {
 int asoc_qcom_lpass_platform_register(struct platform_device *pdev)
 {
 	struct lpass_data *drvdata = platform_get_drvdata(pdev);
+	struct lpass_variant *v = drvdata->variant;
+	int ret;
 
 	drvdata->lpaif_irq = platform_get_irq_byname(pdev, "lpass-irq-lpaif");
 	if (drvdata->lpaif_irq < 0) {
@@ -553,6 +553,25 @@ int asoc_qcom_lpass_platform_register(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	ret = devm_request_irq(&pdev->dev, drvdata->lpaif_irq,
+			lpass_platform_lpaif_irq, IRQF_TRIGGER_RISING,
+			"lpass-irq-lpaif", drvdata);
+	if (ret) {
+		dev_err(&pdev->dev, "%s() irq request failed: %d\n",
+				__func__, ret);
+		return ret;
+	}
+
+	/* ensure audio hardware is disabled */
+	ret = regmap_write(drvdata->lpaif_map,
+			LPAIF_IRQEN_REG(v, LPAIF_IRQ_PORT_HOST), 0);
+	if (ret) {
+		dev_err(&pdev->dev, "%s() error writing to irqen reg: %d\n",
+				__func__, ret);
+		return ret;
+	}
+
+
 	return devm_snd_soc_register_platform(&pdev->dev,
 			&lpass_platform_driver);
 }
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index e07ed52..c3016fe 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -23,6 +23,7 @@
 
 #define LPASS_AHBIX_CLOCK_FREQUENCY		131072000
 #define LPASS_MAX_MI2S_PORTS				(4)
+#define LPASS_MAX_DMA_CHANNELS			(8)
 
 /* Both the CPU DAI and platform drivers will access this data */
 struct lpass_data {
@@ -47,6 +48,9 @@ struct lpass_data {
 
 	/* SOC specific variations in the LPASS IP integration */
 	struct lpass_variant *variant;
+
+	/* used it for handling interrupt per dma channel */
+	struct snd_pcm_substream *substream[LPASS_MAX_DMA_CHANNELS];
 };
 
 /* Vairant data per each SOC */
-- 
1.9.1
