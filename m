From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH RFC 12/15] ASoC: qcom: add generic bit masks for RDMA and WRDMA
Date: Mon,  1 Feb 2016 17:29:32 +0000
Message-ID: <1454347772-10960-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds generic masks for accessing bits in rdma/wrdma
registers. Doing this would simplify the driver and adding capture
support would be much simpler. Also there is no point in having same
bit masks for bits in both rdma and wrdma registers.

This patch also deletes the RDMA specific bit masks and makes the code
use the generic bit masks.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-lpaif-reg.h | 85 ++++++++++++++++++++++++----------------
 sound/soc/qcom/lpass-platform.c  | 54 +++++++++++++------------
 2 files changed, 81 insertions(+), 58 deletions(-)

diff --git a/sound/soc/qcom/lpass-lpaif-reg.h b/sound/soc/qcom/lpass-lpaif-reg.h
index 2008f9f..2114b3e 100644
--- a/sound/soc/qcom/lpass-lpaif-reg.h
+++ b/sound/soc/qcom/lpass-lpaif-reg.h
@@ -112,39 +112,6 @@
 #define	LPAIF_RDMAPER_REG(v, chan)	LPAIF_RDMA_REG_ADDR(v, 0x10, (chan))
 #define	LPAIF_RDMAPERCNT_REG(v, chan)	LPAIF_RDMA_REG_ADDR(v, 0x14, (chan))
 
-#define LPAIF_RDMACTL_BURSTEN_MASK	0x800
-#define LPAIF_RDMACTL_BURSTEN_SHIFT	11
-#define LPAIF_RDMACTL_BURSTEN_SINGLE	(0 << LPAIF_RDMACTL_BURSTEN_SHIFT)
-#define LPAIF_RDMACTL_BURSTEN_INCR4	(1 << LPAIF_RDMACTL_BURSTEN_SHIFT)
-
-#define LPAIF_RDMACTL_WPSCNT_MASK	0x700
-#define LPAIF_RDMACTL_WPSCNT_SHIFT	8
-#define LPAIF_RDMACTL_WPSCNT_ONE	(0 << LPAIF_RDMACTL_WPSCNT_SHIFT)
-#define LPAIF_RDMACTL_WPSCNT_TWO	(1 << LPAIF_RDMACTL_WPSCNT_SHIFT)
-#define LPAIF_RDMACTL_WPSCNT_THREE	(2 << LPAIF_RDMACTL_WPSCNT_SHIFT)
-#define LPAIF_RDMACTL_WPSCNT_FOUR	(3 << LPAIF_RDMACTL_WPSCNT_SHIFT)
-#define LPAIF_RDMACTL_WPSCNT_SIX	(5 << LPAIF_RDMACTL_WPSCNT_SHIFT)
-#define LPAIF_RDMACTL_WPSCNT_EIGHT	(7 << LPAIF_RDMACTL_WPSCNT_SHIFT)
-
-#define LPAIF_RDMACTL_AUDINTF_MASK	0x0F0
-#define LPAIF_RDMACTL_AUDINTF_SHIFT	4
-
-#define LPAIF_RDMACTL_FIFOWM_MASK	0x00E
-#define LPAIF_RDMACTL_FIFOWM_SHIFT	1
-#define LPAIF_RDMACTL_FIFOWM_1		(0 << LPAIF_RDMACTL_FIFOWM_SHIFT)
-#define LPAIF_RDMACTL_FIFOWM_2		(1 << LPAIF_RDMACTL_FIFOWM_SHIFT)
-#define LPAIF_RDMACTL_FIFOWM_3		(2 << LPAIF_RDMACTL_FIFOWM_SHIFT)
-#define LPAIF_RDMACTL_FIFOWM_4		(3 << LPAIF_RDMACTL_FIFOWM_SHIFT)
-#define LPAIF_RDMACTL_FIFOWM_5		(4 << LPAIF_RDMACTL_FIFOWM_SHIFT)
-#define LPAIF_RDMACTL_FIFOWM_6		(5 << LPAIF_RDMACTL_FIFOWM_SHIFT)
-#define LPAIF_RDMACTL_FIFOWM_7		(6 << LPAIF_RDMACTL_FIFOWM_SHIFT)
-#define LPAIF_RDMACTL_FIFOWM_8		(7 << LPAIF_RDMACTL_FIFOWM_SHIFT)
-
-#define LPAIF_RDMACTL_ENABLE_MASK	0x1
-#define LPAIF_RDMACTL_ENABLE_SHIFT	0
-#define LPAIF_RDMACTL_ENABLE_OFF	(0 << LPAIF_RDMACTL_ENABLE_SHIFT)
-#define LPAIF_RDMACTL_ENABLE_ON		(1 << LPAIF_RDMACTL_ENABLE_SHIFT)
-
 #define LPAIF_WRDMA_REG_ADDR(v, addr, chan) \
 	(v->wrdma_reg_base + (addr) + \
 	 v->wrdma_reg_stride * (chan - v->wrdma_channel_start))
@@ -156,4 +123,56 @@
 #define	LPAIF_WRDMAPER_REG(v, chan)	LPAIF_WRDMA_REG_ADDR(v, 0x10, (chan))
 #define	LPAIF_WRDMAPERCNT_REG(v, chan)	LPAIF_WRDMA_REG_ADDR(v, 0x14, (chan))
 
+#define __LPAIF_DMA_REG(v, chan, dir, reg)  \
+	(dir ==  SNDRV_PCM_STREAM_PLAYBACK) ? \
+		LPAIF_RDMA##reg##_REG(v, chan) : \
+		LPAIF_WRDMA##reg##_REG(v, chan)
+
+#define LPAIF_DMACTL_REG(v, chan, dir) __LPAIF_DMA_REG(v, chan, dir, CTL)
+#define LPAIF_DMABASE_REG(v, chan, dir) __LPAIF_DMA_REG(v, chan, dir, BASE)
+#define	LPAIF_DMABUFF_REG(v, chan, dir) __LPAIF_DMA_REG(v, chan, dir, BUFF)
+#define LPAIF_DMACURR_REG(v, chan, dir) __LPAIF_DMA_REG(v, chan, dir, CURR)
+#define	LPAIF_DMAPER_REG(v, chan, dir) __LPAIF_DMA_REG(v, chan, dir, PER)
+#define	LPAIF_DMAPERCNT_REG(v, chan, dir) __LPAIF_DMA_REG(v, chan, dir, PERCNT)
+
+
+#define LPAIF_DMACTL_AUDINTF(id)	(id << LPAIF_DMACTL_AUDINTF_SHIFT)
+
+#define LPAIF_DMACTL_BURSTEN_MASK	0x800
+#define LPAIF_DMACTL_BURSTEN_SHIFT	11
+#define LPAIF_DMACTL_BURSTEN_SINGLE	(0 << LPAIF_DMACTL_BURSTEN_SHIFT)
+#define LPAIF_DMACTL_BURSTEN_INCR4	(1 << LPAIF_DMACTL_BURSTEN_SHIFT)
+
+#define LPAIF_DMACTL_WPSCNT_MASK	0x700
+#define LPAIF_DMACTL_WPSCNT_SHIFT	8
+#define LPAIF_DMACTL_WPSCNT_ONE	(0 << LPAIF_DMACTL_WPSCNT_SHIFT)
+#define LPAIF_DMACTL_WPSCNT_TWO	(1 << LPAIF_DMACTL_WPSCNT_SHIFT)
+#define LPAIF_DMACTL_WPSCNT_THREE	(2 << LPAIF_DMACTL_WPSCNT_SHIFT)
+#define LPAIF_DMACTL_WPSCNT_FOUR	(3 << LPAIF_DMACTL_WPSCNT_SHIFT)
+#define LPAIF_DMACTL_WPSCNT_SIX	(5 << LPAIF_DMACTL_WPSCNT_SHIFT)
+#define LPAIF_DMACTL_WPSCNT_EIGHT	(7 << LPAIF_DMACTL_WPSCNT_SHIFT)
+
+#define LPAIF_DMACTL_AUDINTF_MASK	0x0F0
+#define LPAIF_DMACTL_AUDINTF_SHIFT	4
+
+#define LPAIF_DMACTL_FIFOWM_MASK	0x00E
+#define LPAIF_DMACTL_FIFOWM_SHIFT	1
+#define LPAIF_DMACTL_FIFOWM_1		(0 << LPAIF_DMACTL_FIFOWM_SHIFT)
+#define LPAIF_DMACTL_FIFOWM_2		(1 << LPAIF_DMACTL_FIFOWM_SHIFT)
+#define LPAIF_DMACTL_FIFOWM_3		(2 << LPAIF_DMACTL_FIFOWM_SHIFT)
+#define LPAIF_DMACTL_FIFOWM_4		(3 << LPAIF_DMACTL_FIFOWM_SHIFT)
+#define LPAIF_DMACTL_FIFOWM_5		(4 << LPAIF_DMACTL_FIFOWM_SHIFT)
+#define LPAIF_DMACTL_FIFOWM_6		(5 << LPAIF_DMACTL_FIFOWM_SHIFT)
+#define LPAIF_DMACTL_FIFOWM_7		(6 << LPAIF_DMACTL_FIFOWM_SHIFT)
+#define LPAIF_DMACTL_FIFOWM_8		(7 << LPAIF_DMACTL_FIFOWM_SHIFT)
+
+#define LPAIF_DMACTL_ENABLE_MASK	0x1
+#define LPAIF_DMACTL_ENABLE_SHIFT	0
+#define LPAIF_DMACTL_ENABLE_OFF	(0 << LPAIF_DMACTL_ENABLE_SHIFT)
+#define LPAIF_DMACTL_ENABLE_ON		(1 << LPAIF_DMACTL_ENABLE_SHIFT)
+
+#define LPAIF_DMACTL_DYNCLK_MASK	BIT(12)
+#define LPAIF_DMACTL_DYNCLK_SHIFT	12
+#define LPAIF_DMACTL_DYNCLK_OFF	(0 << LPAIF_DMACTL_DYNCLK_SHIFT)
+#define LPAIF_DMACTL_DYNCLK_ON		(1 << LPAIF_DMACTL_DYNCLK_SHIFT)
 #endif /* __LPASS_LPAIF_REG_H__ */
diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index bfc9de6..e611d78 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -90,6 +90,7 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 	snd_pcm_format_t format = params_format(params);
 	unsigned int channels = params_channels(params);
 	unsigned int regval;
+	int dir = substream->stream;
 	int bitwidth;
 	int ret, rdma_port = pcm_data->i2s_port + v->dmactl_audif_start;
 
@@ -100,25 +101,25 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 		return bitwidth;
 	}
 
-	regval = LPAIF_RDMACTL_BURSTEN_INCR4 |
-			LPAIF_RDMACTL_AUDINTF(rdma_port) |
-			LPAIF_RDMACTL_FIFOWM_8;
+	regval = LPAIF_DMACTL_BURSTEN_INCR4 |
+			LPAIF_DMACTL_AUDINTF(rdma_port) |
+			LPAIF_DMACTL_FIFOWM_8;
 
 	switch (bitwidth) {
 	case 16:
 		switch (channels) {
 		case 1:
 		case 2:
-			regval |= LPAIF_RDMACTL_WPSCNT_ONE;
+			regval |= LPAIF_DMACTL_WPSCNT_ONE;
 			break;
 		case 4:
-			regval |= LPAIF_RDMACTL_WPSCNT_TWO;
+			regval |= LPAIF_DMACTL_WPSCNT_TWO;
 			break;
 		case 6:
-			regval |= LPAIF_RDMACTL_WPSCNT_THREE;
+			regval |= LPAIF_DMACTL_WPSCNT_THREE;
 			break;
 		case 8:
-			regval |= LPAIF_RDMACTL_WPSCNT_FOUR;
+			regval |= LPAIF_DMACTL_WPSCNT_FOUR;
 			break;
 		default:
 			dev_err(soc_runtime->dev, "%s() invalid PCM config given: bw=%d, ch=%u\n",
@@ -130,19 +131,19 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 	case 32:
 		switch (channels) {
 		case 1:
-			regval |= LPAIF_RDMACTL_WPSCNT_ONE;
+			regval |= LPAIF_DMACTL_WPSCNT_ONE;
 			break;
 		case 2:
-			regval |= LPAIF_RDMACTL_WPSCNT_TWO;
+			regval |= LPAIF_DMACTL_WPSCNT_TWO;
 			break;
 		case 4:
-			regval |= LPAIF_RDMACTL_WPSCNT_FOUR;
+			regval |= LPAIF_DMACTL_WPSCNT_FOUR;
 			break;
 		case 6:
-			regval |= LPAIF_RDMACTL_WPSCNT_SIX;
+			regval |= LPAIF_DMACTL_WPSCNT_SIX;
 			break;
 		case 8:
-			regval |= LPAIF_RDMACTL_WPSCNT_EIGHT;
+			regval |= LPAIF_DMACTL_WPSCNT_EIGHT;
 			break;
 		default:
 			dev_err(soc_runtime->dev, "%s() invalid PCM config given: bw=%d, ch=%u\n",
@@ -157,7 +158,7 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_RDMACTL_REG(v, pcm_data->rdma_ch), regval);
+			LPAIF_DMACTL_REG(v, pcm_data->rdma_ch, dir), regval);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
 				__func__, ret);
@@ -194,6 +195,7 @@ static int lpass_platform_pcmops_prepare(struct snd_pcm_substream *substream)
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
 	struct lpass_variant *v = drvdata->variant;
 	int ret, ch = pcm_data->rdma_ch;
+	int dir = substream->stream;
 
 	ret = regmap_write(drvdata->lpaif_map,
 			LPAIF_RDMABASE_REG(v, ch),
@@ -205,7 +207,7 @@ static int lpass_platform_pcmops_prepare(struct snd_pcm_substream *substream)
 	}
 
 	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_RDMABUFF_REG(v, ch),
+			LPAIF_DMABUFF_REG(v, ch, dir),
 			(snd_pcm_lib_buffer_bytes(substream) >> 2) - 1);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error writing to rdmabuff reg: %d\n",
@@ -214,7 +216,7 @@ static int lpass_platform_pcmops_prepare(struct snd_pcm_substream *substream)
 	}
 
 	ret = regmap_write(drvdata->lpaif_map,
-			LPAIF_RDMAPER_REG(v, ch),
+			LPAIF_DMAPER_REG(v, ch, dir),
 			(snd_pcm_lib_period_bytes(substream) >> 2) - 1);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error writing to rdmaper reg: %d\n",
@@ -223,8 +225,8 @@ static int lpass_platform_pcmops_prepare(struct snd_pcm_substream *substream)
 	}
 
 	ret = regmap_update_bits(drvdata->lpaif_map,
-			LPAIF_RDMACTL_REG(v, ch),
-			LPAIF_RDMACTL_ENABLE_MASK, LPAIF_RDMACTL_ENABLE_ON);
+			LPAIF_DMACTL_REG(v, ch, dir),
+			LPAIF_DMACTL_ENABLE_MASK, LPAIF_DMACTL_ENABLE_ON);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
 				__func__, ret);
@@ -243,6 +245,7 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 		snd_soc_platform_get_drvdata(soc_runtime->platform);
 	struct lpass_variant *v = drvdata->variant;
 	int ret, ch = pcm_data->rdma_ch;
+	int dir = substream->stream;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -269,9 +272,9 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 		}
 
 		ret = regmap_update_bits(drvdata->lpaif_map,
-				LPAIF_RDMACTL_REG(v, ch),
-				LPAIF_RDMACTL_ENABLE_MASK,
-				LPAIF_RDMACTL_ENABLE_ON);
+				LPAIF_DMACTL_REG(v, ch, dir),
+				LPAIF_DMACTL_ENABLE_MASK,
+				LPAIF_DMACTL_ENABLE_ON);
 		if (ret) {
 			dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
 					__func__, ret);
@@ -282,9 +285,9 @@ static int lpass_platform_pcmops_trigger(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		ret = regmap_update_bits(drvdata->lpaif_map,
-				LPAIF_RDMACTL_REG(v, ch),
-				LPAIF_RDMACTL_ENABLE_MASK,
-				LPAIF_RDMACTL_ENABLE_OFF);
+				LPAIF_DMACTL_REG(v, ch, dir),
+				LPAIF_DMACTL_ENABLE_MASK,
+				LPAIF_DMACTL_ENABLE_OFF);
 		if (ret) {
 			dev_err(soc_runtime->dev, "%s() error writing to rdmactl reg: %d\n",
 					__func__, ret);
@@ -315,9 +318,10 @@ static snd_pcm_uframes_t lpass_platform_pcmops_pointer(
 	struct lpass_variant *v = drvdata->variant;
 	unsigned int base_addr, curr_addr;
 	int ret, ch = pcm_data->rdma_ch;
+	int dir = substream->stream;
 
 	ret = regmap_read(drvdata->lpaif_map,
-			LPAIF_RDMABASE_REG(v, ch), &base_addr);
+			LPAIF_DMABASE_REG(v, ch, dir), &base_addr);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error reading from rdmabase reg: %d\n",
 				__func__, ret);
@@ -325,7 +329,7 @@ static snd_pcm_uframes_t lpass_platform_pcmops_pointer(
 	}
 
 	ret = regmap_read(drvdata->lpaif_map,
-			LPAIF_RDMACURR_REG(v, ch), &curr_addr);
+			LPAIF_DMACURR_REG(v, ch, dir), &curr_addr);
 	if (ret) {
 		dev_err(soc_runtime->dev, "%s() error reading from rdmacurr reg: %d\n",
 				__func__, ret);
-- 
1.9.1
