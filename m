From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 05/14] ASoC: qcom: remove hardcoded dma channel
Date: Thu, 30 Apr 2015 18:17:09 +0100
Message-ID: <1430414229-11084-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch removes hardcoded dma channel value in lpass driver, Now the
dma channel allocation happens in the SOC specific layer. This will
allow different LPASS integrations to use the lpass driver in more
generic way.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-ipq806x.c  | 12 ++++++
 sound/soc/qcom/lpass-platform.c | 93 ++++++++++++++++++++++++++++-------------
 sound/soc/qcom/lpass.h          |  2 +
 3 files changed, 77 insertions(+), 30 deletions(-)

diff --git a/sound/soc/qcom/lpass-ipq806x.c b/sound/soc/qcom/lpass-ipq806x.c
index 0466483..11a7053 100644
--- a/sound/soc/qcom/lpass-ipq806x.c
+++ b/sound/soc/qcom/lpass-ipq806x.c
@@ -49,6 +49,16 @@ static struct snd_soc_dai_driver lpass_cpu_dai_driver = {
 	.ops    = &lpass_cpu_dai_ops,
 };
 
+int ipq806x_lpass_alloc_dma_channel(struct lpass_data *drvdata)
+{
+	return LPAIF_RDMA_CHAN_MI2S;
+}
+
+int ipq806x_lpass_free_dma_channel(struct lpass_data *drvdata, int chan)
+{
+	return 0;
+}
+
 struct lpass_variant ipq806x_data = {
 	.i2sctrl_reg_base	= 0x0010,
 	.i2sctrl_reg_stride	= 0x04,
@@ -61,6 +71,8 @@ struct lpass_variant ipq806x_data = {
 	.rdma_channels		= 4,
 	.dai_driver		= &lpass_cpu_dai_driver,
 	.num_dai		= 1,
+	.alloc_dma_channel	= ipq806x_lpass_alloc_dma_channel,
+	.free_dma_channel	= ipq806x_lpass_free_dma_channel,
 };
 
 static const struct of_device_id ipq806x_lpass_cpu_device_id[] = {
diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index a38e7ec..fc08891 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -24,6 +24,11 @@
 #include "lpass-lpaif-reg.h"
 #include "lpass.h"
 
+struct lpass_pcm_data {
+	int rdma_ch;
+	int i2s_port;
+};
+
 #define LPASS_PLATFORM_BUFFER_SIZE	(16 * 1024)
 #define LPASS_PLATFORM_PERIODS		2
 
@@ -78,6 +83,7 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct lpass_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(soc_runtime);
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
 	struct lpass_variant *v = drvdata->variant;
@@ -85,7 +91,7 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 	unsigned int channels = params_channels(params);
 	unsigned int regval;
 	int bitwidth;
-	int ret;
+	int ret, rdma_port = pcm_data->i2s_port;
 
 	bitwidth = snd_pcm_format_width(format);
 	if (bitwidth < 0) {
@@ -95,7 +101,7 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	regval = LPAIF_RDMACTL_BURSTEN_INCR4 |
-			LPAIF_RDMACTL_AUDINTF_MI2S |
+			LPAIF_RDMACTL_AUDINTF(rdma_port) |
 			LPAIF_RDMACTL_FIFOWM_8;
 
 	switch (bitwidth) {
@@ -151,7 +157,7 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_RDMACTL_REG(v, LPAIF_RDMA_CHAN_MI2S), regval);
+			LPAIF_RDMACTL_REG(v, pcm_data->rdma_ch), regval);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
 				__func__, ret);
@@ -164,13 +170,14 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 static int lpass_platform_pcmops_hw_free(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct lpass_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(soc_runtime);
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
 	struct lpass_variant *v = drvdata->variant;
 	int ret;
 
 	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_RDMACTL_REG(v, LPAIF_RDMA_CHAN_MI2S), 0);
+			LPAIF_RDMACTL_REG(v, pcm_data->rdma_ch), 0);
 	if (ret)
 		dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
 				__func__, ret);
@@ -182,13 +189,14 @@ static int lpass_platform_pcmops_prepare(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct lpass_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(soc_runtime);
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
 	struct lpass_variant *v = drvdata->variant;
-	int ret;
+	int ret, ch = pcm_data->rdma_ch;
 
 	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_RDMABASE_REG(v, LPAIF_RDMA_CHAN_MI2S),
+			LPAIF_RDMABASE_REG(v, ch),
 			runtime->dma_addr);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error writing to rdmabase reg: %d\n",
@@ -197,7 +205,7 @@ static int lpass_platform_pcmops_prepare(struct snd_pcm_substream *substream)
 	}
 
 	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_RDMABUFF_REG(v, LPAIF_RDMA_CHAN_MI2S),
+			LPAIF_RDMABUFF_REG(v, ch),
 			(snd_pcm_lib_buffer_bytes(substream) >> 2) - 1);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error writing to rdmabuff reg: %d\n",
@@ -206,7 +214,7 @@ static int lpass_platform_pcmops_prepare(struct snd_pcm_substream *substream)
 	}
 
 	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_RDMAPER_REG(v, LPAIF_RDMA_CHAN_MI2S),
+			LPAIF_RDMAPER_REG(v, ch),
 			(snd_pcm_lib_period_bytes(substream) >> 2) - 1);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error writing to rdmaper reg: %d\n",
@@ -215,7 +223,7 @@ static int lpass_platform_pcmops_prepare(struct snd_pcm_substream *substream)
 	}
 
 	ret = regmap_update_bits(drvdata->lpaif_map,
-			LPAIF_RDMACTL_REG(v, LPAIF_RDMA_CHAN_MI2S),
+			LPAIF_RDMACTL_REG(v, ch),
 			LPAIF_RDMACTL_ENABLE_MASK, LPAIF_RDMACTL_ENABLE_ON);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
@@ -230,10 +238,11 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 		int cmd)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct lpass_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(soc_runtime);
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
 	struct lpass_variant *v = drvdata->variant;
-	int ret;
+	int ret, ch = pcm_data->rdma_ch;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -242,7 +251,7 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 		/* clear status before enabling interrupts */
 		ret = regmap_write(drvdata->lpaif_map,
 				LPAIF_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST),
-				LPAIF_IRQ_ALL(LPAIF_RDMA_CHAN_MI2S));
+				LPAIF_IRQ_ALL(ch));
 		if (ret) {
 			dev_err(soc_runtime->dev, "%s() error writing to irqclear reg: %d\n",
 					__func__, ret);
@@ -251,8 +260,8 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 
 		ret = regmap_update_bits(drvdata->lpaif_map,
 				LPAIF_IRQEN_REG(v, LPAIF_IRQ_PORT_HOST),
-				LPAIF_IRQ_ALL(LPAIF_RDMA_CHAN_MI2S),
-				LPAIF_IRQ_ALL(LPAIF_RDMA_CHAN_MI2S));
+				LPAIF_IRQ_ALL(ch),
+				LPAIF_IRQ_ALL(ch));
 		if (ret) {
 			dev_err(soc_runtime->dev, "%s() error writing to irqen reg: %d\n",
 					__func__, ret);
@@ -260,7 +269,7 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 		}
 
 		ret = regmap_update_bits(drvdata->lpaif_map,
-				LPAIF_RDMACTL_REG(v, LPAIF_RDMA_CHAN_MI2S),
+				LPAIF_RDMACTL_REG(v, ch),
 				LPAIF_RDMACTL_ENABLE_MASK,
 				LPAIF_RDMACTL_ENABLE_ON);
 		if (ret) {
@@ -273,7 +282,7 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		ret = regmap_update_bits(drvdata->lpaif_map,
-				LPAIF_RDMACTL_REG(v, LPAIF_RDMA_CHAN_MI2S),
+				LPAIF_RDMACTL_REG(v, ch),
 				LPAIF_RDMACTL_ENABLE_MASK,
 				LPAIF_RDMACTL_ENABLE_OFF);
 		if (ret) {
@@ -284,7 +293,7 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 
 		ret = regmap_update_bits(drvdata->lpaif_map,
 				LPAIF_IRQEN_REG(v, LPAIF_IRQ_PORT_HOST),
-				LPAIF_IRQ_ALL(LPAIF_RDMA_CHAN_MI2S), 0);
+				LPAIF_IRQ_ALL(ch), 0);
 		if (ret) {
 			dev_err(soc_runtime->dev, "%s() error writing to irqen reg: %d\n",
 					__func__, ret);
@@ -300,15 +309,15 @@ static snd_pcm_uframes_t lpass_platform_pcmops_pointer(
 		struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct lpass_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(soc_runtime);
 	struct lpass_data *drvdata =
 			snd_soc_platform_get_drvdata(soc_runtime->platform);
 	struct lpass_variant *v = drvdata->variant;
 	unsigned int base_addr, curr_addr;
-	int ret;
+	int ret, ch = pcm_data->rdma_ch;
 
 	ret = regmap_read(drvdata->lpaif_map,
-			 LPAIF_RDMABASE_REG(v, LPAIF_RDMA_CHAN_MI2S),
-			 &base_addr);
+			LPAIF_RDMABASE_REG(v, ch), &base_addr);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error reading from rdmabase reg: %d\n",
 				__func__, ret);
@@ -316,8 +325,7 @@ static snd_pcm_uframes_t lpass_platform_pcmops_pointer(
 	}
 
 	ret = regmap_read(drvdata->lpaif_map,
-			 LPAIF_RDMACURR_REG(v, LPAIF_RDMA_CHAN_MI2S),
-			 &curr_addr);
+			LPAIF_RDMACURR_REG(v, ch), &curr_addr);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error reading from rdmacurr reg: %d\n",
 				__func__, ret);
@@ -355,9 +363,10 @@ static irqreturn_t lpass_platform_lpaif_irq(int irq, void *data)
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
 	struct lpass_variant *v = drvdata->variant;
+	struct lpass_pcm_data *pcm_data = snd_soc_pcm_get_drvdata(soc_runtime);
 	unsigned int interrupts;
 	irqreturn_t ret = IRQ_NONE;
-	int rv;
+	int rv, chan = pcm_data->rdma_ch;
 
 	rv = regmap_read(drvdata->lpaif_map,
 			LPAIF_IRQSTAT_REG(v, LPAIF_IRQ_PORT_HOST), &interrupts);
@@ -366,12 +375,13 @@ static irqreturn_t lpass_platform_lpaif_irq(int irq, void *data)
 				__func__, rv);
 		return IRQ_NONE;
 	}
-	interrupts &= LPAIF_IRQ_ALL(LPAIF_RDMA_CHAN_MI2S);
 
-	if (interrupts & LPAIF_IRQ_PER(LPAIF_RDMA_CHAN_MI2S)) {
+	interrupts &= LPAIF_IRQ_ALL(chan);
+
+	if (interrupts & LPAIF_IRQ_PER(chan)) {
 		rv = regmap_write(drvdata->lpaif_map,
 				LPAIF_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST),
-				LPAIF_IRQ_PER(LPAIF_RDMA_CHAN_MI2S));
+				LPAIF_IRQ_PER(chan));
 		if (rv) {
 			dev_err(soc_runtime->dev, "%s() error writing to irqclear reg: %d\n",
 					__func__, rv);
@@ -381,10 +391,10 @@ static irqreturn_t lpass_platform_lpaif_irq(int irq, void *data)
 		ret = IRQ_HANDLED;
 	}
 
-	if (interrupts & LPAIF_IRQ_XRUN(LPAIF_RDMA_CHAN_MI2S)) {
+	if (interrupts & LPAIF_IRQ_XRUN(chan)) {
 		rv = regmap_write(drvdata->lpaif_map,
 				LPAIF_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST),
-				LPAIF_IRQ_XRUN(LPAIF_RDMA_CHAN_MI2S));
+				LPAIF_IRQ_XRUN(chan));
 		if (rv) {
 			dev_err(soc_runtime->dev, "%s() error writing to irqclear reg: %d\n",
 					__func__, rv);
@@ -395,10 +405,10 @@ static irqreturn_t lpass_platform_lpaif_irq(int irq, void *data)
 		ret = IRQ_HANDLED;
 	}
 
-	if (interrupts & LPAIF_IRQ_ERR(LPAIF_RDMA_CHAN_MI2S)) {
+	if (interrupts & LPAIF_IRQ_ERR(chan)) {
 		rv = regmap_write(drvdata->lpaif_map,
 				LPAIF_IRQCLEAR_REG(v, LPAIF_IRQ_PORT_HOST),
-				LPAIF_IRQ_ERR(LPAIF_RDMA_CHAN_MI2S));
+				LPAIF_IRQ_ERR(chan));
 		if (rv) {
 			dev_err(soc_runtime->dev, "%s() error writing to irqclear reg: %d\n",
 					__func__, rv);
@@ -450,10 +460,26 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 	struct snd_pcm *pcm = soc_runtime->pcm;
 	struct snd_pcm_substream *substream =
 		pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
+	struct snd_soc_dai *cpu_dai = soc_runtime->cpu_dai;
 	struct lpass_data *drvdata =
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
 	struct lpass_variant *v = drvdata->variant;
 	int ret;
+	struct lpass_pcm_data *data;
+
+	data = devm_kzalloc(soc_runtime->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	if (v->alloc_dma_channel)
+		data->rdma_ch = v->alloc_dma_channel(drvdata);
+
+	if (IS_ERR_VALUE(data->rdma_ch))
+		return data->rdma_ch;
+
+	data->i2s_port = cpu_dai->driver->id;
+
+	snd_soc_pcm_set_drvdata(soc_runtime, data);
 
 	soc_runtime->dev->coherent_dma_mask = DMA_BIT_MASK(32);
 	soc_runtime->dev->dma_mask = &soc_runtime->dev->coherent_dma_mask;
@@ -480,7 +506,7 @@ static int lpass_platform_pcm_new(struct snd_soc_pcm_runtime *soc_runtime)
 		return ret;
 	}
 	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_RDMACTL_REG(v, LPAIF_RDMA_CHAN_MI2S), 0);
+			LPAIF_RDMACTL_REG(v, data->rdma_ch), 0);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
 				__func__, ret);
@@ -499,6 +525,13 @@ static void lpass_platform_pcm_free(struct snd_pcm *pcm)
 	struct snd_pcm_substream *substream =
 		pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].substream;
 	struct snd_soc_pcm_runtime *soc_runtime = substream->private_data;
+	struct lpass_data *drvdata =
+		snd_soc_platform_get_drvdata(soc_runtime->platform);
+	struct lpass_pcm_data *data = snd_soc_pcm_get_drvdata(soc_runtime);
+	struct lpass_variant *v = drvdata->variant;
+
+	if (v->free_dma_channel)
+		v->free_dma_channel(drvdata, data->rdma_ch);
 
 	lpass_platform_free_buffer(substream, soc_runtime);
 }
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 5bd2a90..80f4b1c 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -63,6 +63,8 @@ struct lpass_variant {
 	/* SOC specific intialization like clocks */
 	int (*init)(struct platform_device *pdev);
 	int (*exit)(struct platform_device *pdev);
+	int (*alloc_dma_channel)(struct lpass_data *data);
+	int (*free_dma_channel)(struct lpass_data *data, int ch);
 
 	/* SOC specific dais */
 	struct snd_soc_dai_driver *dai_driver;
-- 
1.9.1
