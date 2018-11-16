From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 2/2] ASoC: sdm845: Add support for Secondary MI2S interface
Date: Fri, 16 Nov 2018 13:11:58 +0530
Message-ID: <1542354118-23360-3-git-send-email-rohitkr@codeaurora.org>
References: <1542354118-23360-1-git-send-email-rohitkr@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542354118-23360-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org
Cc: Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Add support to configure bit clock for secondary MI2S
TX interface.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/sdm845.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 84e6ee7..58593db 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -19,6 +19,7 @@
 struct sdm845_snd_data {
 	struct snd_soc_card *card;
 	uint32_t pri_mi2s_clk_count;
+	uint32_t sec_mi2s_clk_count;
 	uint32_t quat_tdm_clk_count;
 };
 
@@ -121,6 +122,15 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 		snd_soc_dai_set_fmt(cpu_dai, fmt);
 		break;
 
+	case SECONDARY_MI2S_TX:
+		if (++(data->sec_mi2s_clk_count) == 1) {
+			snd_soc_dai_set_sysclk(cpu_dai,
+				Q6AFE_LPASS_CLK_ID_SEC_MI2S_IBIT,
+				MI2S_BCLK_RATE,	SNDRV_PCM_STREAM_CAPTURE);
+		}
+		snd_soc_dai_set_fmt(cpu_dai, fmt);
+		break;
+
 	case QUATERNARY_TDM_RX_0:
 	case QUATERNARY_TDM_TX_0:
 		if (++(data->quat_tdm_clk_count) == 1) {
@@ -157,6 +167,14 @@ static void  sdm845_snd_shutdown(struct snd_pcm_substream *substream)
 		};
 		break;
 
+	case SECONDARY_MI2S_TX:
+		if (--(data->sec_mi2s_clk_count) == 0) {
+			snd_soc_dai_set_sysclk(cpu_dai,
+				Q6AFE_LPASS_CLK_ID_SEC_MI2S_IBIT,
+				0, SNDRV_PCM_STREAM_CAPTURE);
+		}
+		break;
+
 	case QUATERNARY_TDM_RX_0:
 	case QUATERNARY_TDM_TX_0:
 		if (--(data->quat_tdm_clk_count) == 0) {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
