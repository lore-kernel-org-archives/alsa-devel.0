From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH RFC 09/15] ASoC: qcom: rename rdma_ch_bit_map to dma_ch_bit_map
Date: Mon,  1 Feb 2016 17:29:07 +0000
Message-ID: <1454347747-10758-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

rdma_ch_bit_map can be reused for wrdma channel allocations as wrdma
channel numbering start after rdma channel numbers.
With capture support referring rdma_ch_bit_map for wrdma channel allocation
is confusing, so renaming rdma_ch_bit_map to dma_ch_bit_map makes sense.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-apq8016.c | 6 +++---
 sound/soc/qcom/lpass.h         | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
index 2d43842..df44f09 100644
--- a/sound/soc/qcom/lpass-apq8016.c
+++ b/sound/soc/qcom/lpass-apq8016.c
@@ -137,20 +137,20 @@ static int apq8016_lpass_alloc_dma_channel(struct lpass_data *drvdata,
 					   int direction)
 {
 	struct lpass_variant *v = drvdata->variant;
-	int chan = find_first_zero_bit(&drvdata->rdma_ch_bit_map,
+	int chan = find_first_zero_bit(&drvdata->dma_ch_bit_map,
 					v->rdma_channels);
 
 	if (chan >= v->rdma_channels)
 		return -EBUSY;
 
-	set_bit(chan, &drvdata->rdma_ch_bit_map);
+	set_bit(chan, &drvdata->dma_ch_bit_map);
 
 	return chan;
 }
 
 static int apq8016_lpass_free_dma_channel(struct lpass_data *drvdata, int chan)
 {
-	clear_bit(chan, &drvdata->rdma_ch_bit_map);
+	clear_bit(chan, &drvdata->dma_ch_bit_map);
 
 	return 0;
 }
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 8475b60..30714ad 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -50,7 +50,7 @@ struct lpass_data {
 	struct lpass_variant *variant;
 
 	/* bit map to keep track of static channel allocations */
-	unsigned long rdma_ch_bit_map;
+	unsigned long dma_ch_bit_map;
 
 	/* used it for handling interrupt per dma channel */
 	struct snd_pcm_substream *substream[LPASS_MAX_DMA_CHANNELS];
-- 
1.9.1
