From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 4/4] ASoC: qdsp6: q6asm-dai: fix max rates on q6asm dais
Date: Thu, 22 Aug 2019 10:56:53 +0100
Message-ID: <20190822095653.7200-5-srinivas.kandagatla@linaro.org>
References: <20190822095653.7200-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190822095653.7200-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, tiwai@suse.de
Cc: spapothi@codeaurora.org, bgoswami@codeaurora.org, plai@codeaurora.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Q6ASM dais support max rate up to 384KHz, update this.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 548eb4fa2da6..5eaeadec8492 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -80,9 +80,9 @@ static struct snd_pcm_hardware q6asm_dai_hardware_capture = {
 				SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),
 	.formats =              (SNDRV_PCM_FMTBIT_S16_LE |
 				SNDRV_PCM_FMTBIT_S24_LE),
-	.rates =                SNDRV_PCM_RATE_8000_48000,
+	.rates =                SNDRV_PCM_RATE_8000_384000,
 	.rate_min =             8000,
-	.rate_max =             48000,
+	.rate_max =             384000,
 	.channels_min =         1,
 	.channels_max =         4,
 	.buffer_bytes_max =     CAPTURE_MAX_NUM_PERIODS *
@@ -102,9 +102,9 @@ static struct snd_pcm_hardware q6asm_dai_hardware_playback = {
 				SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),
 	.formats =              (SNDRV_PCM_FMTBIT_S16_LE |
 				SNDRV_PCM_FMTBIT_S24_LE),
-	.rates =                SNDRV_PCM_RATE_8000_192000,
+	.rates =                SNDRV_PCM_RATE_8000_384000,
 	.rate_min =             8000,
-	.rate_max =             192000,
+	.rate_max =             384000,
 	.channels_min =         1,
 	.channels_max =         8,
 	.buffer_bytes_max =     (PLAYBACK_MAX_NUM_PERIODS *
@@ -119,25 +119,25 @@ static struct snd_pcm_hardware q6asm_dai_hardware_playback = {
 #define Q6ASM_FEDAI_DRIVER(num) { \
 		.playback = {						\
 			.stream_name = "MultiMedia"#num" Playback",	\
-			.rates = (SNDRV_PCM_RATE_8000_192000|		\
+			.rates = (SNDRV_PCM_RATE_8000_384000|		\
 					SNDRV_PCM_RATE_KNOT),		\
 			.formats = (SNDRV_PCM_FMTBIT_S16_LE |		\
 					SNDRV_PCM_FMTBIT_S24_LE),	\
 			.channels_min = 1,				\
 			.channels_max = 8,				\
 			.rate_min =     8000,				\
-			.rate_max =	192000,				\
+			.rate_max =	384000,				\
 		},							\
 		.capture = {						\
 			.stream_name = "MultiMedia"#num" Capture",	\
-			.rates = (SNDRV_PCM_RATE_8000_48000|		\
+			.rates = (SNDRV_PCM_RATE_8000_384000|		\
 					SNDRV_PCM_RATE_KNOT),		\
 			.formats = (SNDRV_PCM_FMTBIT_S16_LE |		\
 				    SNDRV_PCM_FMTBIT_S24_LE),		\
 			.channels_min = 1,				\
 			.channels_max = 4,				\
 			.rate_min =     8000,				\
-			.rate_max =	48000,				\
+			.rate_max =	384000,				\
 		},							\
 		.name = "MultiMedia"#num,				\
 		.id = MSM_FRONTEND_DAI_MULTIMEDIA##num,			\
@@ -146,7 +146,7 @@ static struct snd_pcm_hardware q6asm_dai_hardware_playback = {
 /* Conventional and unconventional sample rate supported */
 static unsigned int supported_sample_rates[] = {
 	8000, 11025, 12000, 16000, 22050, 24000, 32000, 44100, 48000,
-	88200, 96000, 176400, 192000
+	88200, 96000, 176400, 192000, 352800, 384000
 };
 
 static struct snd_pcm_hw_constraint_list constraints_sample_rates = {
-- 
2.21.0
