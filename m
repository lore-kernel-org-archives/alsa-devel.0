From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH] ASoC: sdm845: Set DAI format for dmic codec
Date: Tue, 15 Jan 2019 16:41:59 +0800
Message-ID: <20190115084159.135113-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, dgreid@chromium.org, tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

Set codec DAI format for dmic codec in startup.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/qcom/sdm845.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 6f66a58e23ca..882f52ed8231 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -248,12 +248,14 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 		break;
 
 	case SECONDARY_MI2S_TX:
+		codec_dai_fmt |= SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_I2S;
 		if (++(data->sec_mi2s_clk_count) == 1) {
 			snd_soc_dai_set_sysclk(cpu_dai,
 				Q6AFE_LPASS_CLK_ID_SEC_MI2S_IBIT,
 				MI2S_BCLK_RATE,	SNDRV_PCM_STREAM_CAPTURE);
 		}
 		snd_soc_dai_set_fmt(cpu_dai, fmt);
+		snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
 		break;
 
 	case QUATERNARY_TDM_RX_0:
-- 
2.20.1.97.g81188d93c3-goog
