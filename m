From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 3/4] ASoC: qdsp6: q6afe-dai: Update max rate for slim and tdm dais
Date: Thu, 22 Aug 2019 10:56:52 +0100
Message-ID: <20190822095653.7200-4-srinivas.kandagatla@linaro.org>
References: <20190822095653.7200-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822095653.7200-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, tiwai@suse.de
Cc: spapothi@codeaurora.org, bgoswami@codeaurora.org, plai@codeaurora.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

QDSP supports up to 384000 rates on SLIM dais and 352800 rate on TDM dais.
Add this missing rates.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 92 +++++++++++---------------------
 1 file changed, 32 insertions(+), 60 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index c1a7624eaf17..ae2baefdb6e2 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -18,14 +18,14 @@
 			.stream_name = pre" TDM"#num" Playback",	\
 			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
 				SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000 |\
-				SNDRV_PCM_RATE_176400,			\
+				SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_352800,\
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |		\
 				   SNDRV_PCM_FMTBIT_S24_LE |		\
 				   SNDRV_PCM_FMTBIT_S32_LE,		\
 			.channels_min = 1,				\
 			.channels_max = 8,				\
 			.rate_min = 8000,				\
-			.rate_max = 176400,				\
+			.rate_max = 352800,				\
 		},							\
 		.name = #did,						\
 		.ops = &q6tdm_ops,					\
@@ -39,14 +39,14 @@
 			.stream_name = pre" TDM"#num" Capture",		\
 			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
 				SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000 |\
-				SNDRV_PCM_RATE_176400,			\
+				SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_352800,\
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |		\
 				   SNDRV_PCM_FMTBIT_S24_LE |		\
 				   SNDRV_PCM_FMTBIT_S32_LE,		\
 			.channels_min = 1,				\
 			.channels_max = 8,				\
 			.rate_min = 8000,				\
-			.rate_max = 176400,				\
+			.rate_max = 352800,				\
 		},							\
 		.name = #did,						\
 		.ops = &q6tdm_ops,					\
@@ -646,15 +646,13 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.remove = msm_dai_q6_dai_remove,
 		.playback = {
 			.stream_name = "Slimbus Playback",
-			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
-				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 8,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 	}, {
 		.name = "SLIMBUS_0_TX",
@@ -664,28 +662,24 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.remove = msm_dai_q6_dai_remove,
 		.capture = {
 			.stream_name = "Slimbus Capture",
-			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
-				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 8,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus1 Playback",
-			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
-				 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 2,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 		.name = "SLIMBUS_1_RX",
 		.ops = &q6slim_ops,
@@ -700,28 +694,24 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.remove = msm_dai_q6_dai_remove,
 		.capture = {
 			.stream_name = "Slimbus1 Capture",
-			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
-				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 8,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus2 Playback",
-			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
-				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 8,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 		.name = "SLIMBUS_2_RX",
 		.ops = &q6slim_ops,
@@ -737,28 +727,24 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.remove = msm_dai_q6_dai_remove,
 		.capture = {
 			.stream_name = "Slimbus2 Capture",
-			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
-				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 8,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus3 Playback",
-			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
-				 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 2,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 		.name = "SLIMBUS_3_RX",
 		.ops = &q6slim_ops,
@@ -774,28 +760,24 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.remove = msm_dai_q6_dai_remove,
 		.capture = {
 			.stream_name = "Slimbus3 Capture",
-			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
-				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 8,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus4 Playback",
-			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
-				 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 2,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 		.name = "SLIMBUS_4_RX",
 		.ops = &q6slim_ops,
@@ -811,28 +793,24 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.remove = msm_dai_q6_dai_remove,
 		.capture = {
 			.stream_name = "Slimbus4 Capture",
-			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
-				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 8,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus5 Playback",
-			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
-				 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 2,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 		.name = "SLIMBUS_5_RX",
 		.ops = &q6slim_ops,
@@ -848,28 +826,24 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.remove = msm_dai_q6_dai_remove,
 		.capture = {
 			.stream_name = "Slimbus5 Capture",
-			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
-				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 8,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 	}, {
 		.playback = {
 			.stream_name = "Slimbus6 Playback",
-			.rates = SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
-				 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 2,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 		.ops = &q6slim_ops,
 		.name = "SLIMBUS_6_RX",
@@ -885,15 +859,13 @@ static struct snd_soc_dai_driver q6afe_dais[] = {
 		.remove = msm_dai_q6_dai_remove,
 		.capture = {
 			.stream_name = "Slimbus6 Capture",
-			.rates = SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_8000 |
-				 SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000,
+			.rates = SNDRV_PCM_RATE_8000_384000,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE |
 				   SNDRV_PCM_FMTBIT_S24_LE,
 			.channels_min = 1,
 			.channels_max = 8,
 			.rate_min = 8000,
-			.rate_max = 192000,
+			.rate_max = 384000,
 		},
 	}, {
 		.playback = {
-- 
2.21.0
