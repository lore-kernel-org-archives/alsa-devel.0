From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH RFC 03/15] ASoC: qcom: rename rdmactl_audif_start to dmactrl_audif_start
Date: Mon,  1 Feb 2016 17:28:28 +0000
Message-ID: <1454347708-10446-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch renames rdmactl_audif_start to dmactrl_audif_start as this
is common for both rdma and wrdma. Without this patch the name would be
bit misleading to the readers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-platform.c | 2 +-
 sound/soc/qcom/lpass.h          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index a6dce1b..bfc9de6 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -91,7 +91,7 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 	unsigned int channels = params_channels(params);
 	unsigned int regval;
 	int bitwidth;
-	int ret, rdma_port = pcm_data->i2s_port + v->rdmactl_audif_start;
+	int ret, rdma_port = pcm_data->i2s_port + v->dmactl_audif_start;
 
 	bitwidth = snd_pcm_format_width(format);
 	if (bitwidth < 0) {
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index ab684a8..7c3367f 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -79,7 +79,7 @@ struct lpass_variant {
 	 * on SOCs like APQ8016 the channel control bits start
 	 * at different offset to ipq806x
 	 **/
-	u32	rdmactl_audif_start;
+	u32	dmactl_audif_start;
 	/* SOC specific intialization like clocks */
 	int (*init)(struct platform_device *pdev);
 	int (*exit)(struct platform_device *pdev);
-- 
1.9.1
