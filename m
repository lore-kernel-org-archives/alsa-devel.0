From: Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 1/2] ASoC: sdm845: Update slot_width for Quaternary TDM port
Date: Fri, 16 Nov 2018 13:11:57 +0530
Message-ID: <1542354118-23360-2-git-send-email-rohitkr@codeaurora.org>
References: <1542354118-23360-1-git-send-email-rohitkr@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542354118-23360-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org
Cc: Rohit kumar <rohitkr@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Change slot_width for quaternary TDM port to 16 and
update bclk rate for TDM and MI2S interfaces
accordingly.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/sdm845.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 8d0cdff..84e6ee7 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -13,7 +13,8 @@
 
 #define DEFAULT_SAMPLE_RATE_48K		48000
 #define DEFAULT_MCLK_RATE		24576000
-#define DEFAULT_BCLK_RATE		12288000
+#define TDM_BCLK_RATE		6144000
+#define MI2S_BCLK_RATE		1536000
 
 struct sdm845_snd_data {
 	struct snd_soc_card *card;
@@ -33,7 +34,7 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
-		slot_width = 32;
+		slot_width = 16;
 		break;
 	default:
 		dev_err(rtd->dev, "%s: invalid param format 0x%x\n",
@@ -115,7 +116,7 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 				DEFAULT_MCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
 			snd_soc_dai_set_sysclk(cpu_dai,
 				Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT,
-				DEFAULT_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
+				MI2S_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
 		}
 		snd_soc_dai_set_fmt(cpu_dai, fmt);
 		break;
@@ -125,7 +126,7 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 		if (++(data->quat_tdm_clk_count) == 1) {
 			snd_soc_dai_set_sysclk(cpu_dai,
 				Q6AFE_LPASS_CLK_ID_QUAD_TDM_IBIT,
-				DEFAULT_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
+				TDM_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
 		}
 		break;
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
