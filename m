From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v1 05/14] ASoC: qcom: ipq806x: add error in dma allocation.
Date: Wed, 10 Feb 2016 10:18:53 +0000
Message-ID: <1455099533-532-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1455099418-311-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455099418-311-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

ipq806x is only ever tested for playback so return error in dma allocation
if the stream direction is capture.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-ipq806x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-ipq806x.c b/sound/soc/qcom/lpass-ipq806x.c
index 119048c..29a3529 100644
--- a/sound/soc/qcom/lpass-ipq806x.c
+++ b/sound/soc/qcom/lpass-ipq806x.c
@@ -65,7 +65,10 @@ static struct snd_soc_dai_driver ipq806x_lpass_cpu_dai_driver = {
 
 static int ipq806x_lpass_alloc_dma_channel(struct lpass_data *drvdata, int dir)
 {
-	return IPQ806X_LPAIF_RDMA_CHAN_MI2S;
+	if (dir == SNDRV_PCM_STREAM_PLAYBACK)
+		return IPQ806X_LPAIF_RDMA_CHAN_MI2S;
+	else	/* Capture currently not implemented */
+		return -EINVAL;
 }
 
 static int ipq806x_lpass_free_dma_channel(struct lpass_data *drvdata, int chan)
-- 
1.9.1
