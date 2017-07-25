From: srinivas.kandagatla@linaro.org
Subject: [PATCH v2 1/3] ASoC: codecs: msm8916-wcd-digital: add support to set_sysclk
Date: Wed, 26 Jul 2017 01:48:20 +0200
Message-ID: <20170725234822.18763-2-srinivas.kandagatla@linaro.org>
References: <20170725234822.18763-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170725234822.18763-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds support to set_sysclk() which can let the sound
card driver to set default mclk rate. In this case MCLK for
internal audio codec is expected to be at 9.6MHz by default.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index f690442..825cc7d 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -568,6 +568,15 @@ static int msm8916_wcd_digital_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
+static int msm8916_wcd_digital_codec_set_sysclk(struct snd_soc_codec *codec,
+						int clk_id, int source,
+						unsigned int freq, int dir)
+{
+	struct msm8916_wcd_digital_priv *p = dev_get_drvdata(codec->dev);
+
+	return clk_set_rate(p->mclk, freq);
+}
+
 static int msm8916_wcd_digital_hw_params(struct snd_pcm_substream *substream,
 					 struct snd_pcm_hw_params *params,
 					 struct snd_soc_dai *dai)
@@ -823,6 +832,7 @@ static struct snd_soc_dai_driver msm8916_wcd_digital_dai[] = {
 
 static struct snd_soc_codec_driver msm8916_wcd_digital = {
 	.probe = msm8916_wcd_digital_codec_probe,
+	.set_sysclk = msm8916_wcd_digital_codec_set_sysclk,
 	.component_driver = {
 		.controls = msm8916_wcd_digital_snd_controls,
 		.num_controls = ARRAY_SIZE(msm8916_wcd_digital_snd_controls),
-- 
2.9.3
