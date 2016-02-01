From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH RFC 10/15] ASoC: qcom: apq8016: add wrdma support
Date: Mon,  1 Feb 2016 17:29:20 +0000
Message-ID: <1454347760-10856-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds wrdma support in lpass-apq8016 by providing the register
offsets and adding support in dma channel allocation callback.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-apq8016.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
index df44f09..3eef0c3 100644
--- a/sound/soc/qcom/lpass-apq8016.c
+++ b/sound/soc/qcom/lpass-apq8016.c
@@ -137,11 +137,23 @@ static int apq8016_lpass_alloc_dma_channel(struct lpass_data *drvdata,
 					   int direction)
 {
 	struct lpass_variant *v = drvdata->variant;
-	int chan = find_first_zero_bit(&drvdata->dma_ch_bit_map,
+	int chan = 0;
+
+	if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
+		chan = find_first_zero_bit(&drvdata->dma_ch_bit_map,
 					v->rdma_channels);
 
-	if (chan >= v->rdma_channels)
-		return -EBUSY;
+		if (chan >= v->rdma_channels)
+			return -EBUSY;
+	} else {
+		chan = find_next_zero_bit(&drvdata->dma_ch_bit_map,
+					v->wrdma_channel_start +
+					v->wrdma_channels,
+					v->wrdma_channel_start);
+
+		if (chan >=  v->wrdma_channel_start + v->wrdma_channels)
+			return -EBUSY;
+	}
 
 	set_bit(chan, &drvdata->dma_ch_bit_map);
 
@@ -213,7 +225,11 @@ static struct lpass_variant apq8016_data = {
 	.rdma_reg_base		= 0x8400,
 	.rdma_reg_stride	= 0x1000,
 	.rdma_channels		= 2,
-	.rdmactl_audif_start	= 1,
+	.dmactl_audif_start	= 1,
+	.wrdma_reg_base		= 0xB000,
+	.wrdma_reg_stride	= 0x1000,
+	.wrdma_channel_start	= 5,
+	.wrdma_channels		= 2,
 	.dai_driver		= apq8016_lpass_cpu_dai_driver,
 	.num_dai		= ARRAY_SIZE(apq8016_lpass_cpu_dai_driver),
 	.init			= apq8016_lpass_init,
-- 
1.9.1
