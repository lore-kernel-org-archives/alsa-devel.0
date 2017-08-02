From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: msm8916-wcd-digital: add support to set_sysclk" to the asoc tree
Date: Wed, 02 Aug 2017 18:29:56 +0100
Message-ID: <E1dcxT2-0003ky-Ax@debutante>
References: <20170725234822.18763-2-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170725234822.18763-2-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: msm8916-wcd-digital: add support to set_sysclk

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 820f7541f952afa8db08ccd420f29a2c6c148709 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 2 Aug 2017 15:17:46 +0200
Subject: [PATCH] ASoC: codecs: msm8916-wcd-digital: add support to set_sysclk

This patch adds support to set_sysclk() which can let the sound
card driver to set default mclk rate. In this case MCLK for
internal audio codec is expected to be at 9.6MHz by default.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-digital.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index f690442af8c9..825cc7d70bb3 100644
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
2.13.2
