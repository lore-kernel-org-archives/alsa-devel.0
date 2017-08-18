From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: constify snd_soc_dai_ops structures" to the asoc tree
Date: Fri, 18 Aug 2017 13:25:45 +0100
Message-ID: <E1digLR-0002pv-Ae@finisterre>
References: <1503057971-16033-3-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503057971-16033-3-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, bardliao@realtek.com, oder_chiou@realtek.com, timur@tabi.org, lgirdwood@gmail.combroonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: constify snd_soc_dai_ops structures

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

>From 728c4a87f31d30669a103dac1851a15f4e2af03c Mon Sep 17 00:00:00 2001
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Fri, 18 Aug 2017 17:35:59 +0530
Subject: [PATCH] ASoC: codecs: constify snd_soc_dai_ops structures

snd_soc_dai_ops are not supposed to change at runtime. All functions
working with snd_soc_dai_ops provided by <sound/soc-dai.h> work with
const snd_soc_dai_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l42.c             | 2 +-
 sound/soc/codecs/es8316.c              | 2 +-
 sound/soc/codecs/hdac_hdmi.c           | 2 +-
 sound/soc/codecs/inno_rk3036.c         | 2 +-
 sound/soc/codecs/max9867.c             | 2 +-
 sound/soc/codecs/max98926.c            | 2 +-
 sound/soc/codecs/msm8916-wcd-analog.c  | 2 +-
 sound/soc/codecs/msm8916-wcd-digital.c | 2 +-
 sound/soc/codecs/rt5616.c              | 2 +-
 sound/soc/codecs/rt5663.c              | 2 +-
 sound/soc/codecs/tas5720.c             | 2 +-
 sound/soc/codecs/zx_aud96p22.c         | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 55e4520cdcaf..9e860dfa0163 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -911,7 +911,7 @@ static int cs42l42_digital_mute(struct snd_soc_dai *dai, int mute)
 			SNDRV_PCM_FMTBIT_S32_LE)
 
 
-static struct snd_soc_dai_ops cs42l42_ops = {
+static const struct snd_soc_dai_ops cs42l42_ops = {
 	.hw_params	= cs42l42_pcm_hw_params,
 	.set_fmt	= cs42l42_set_dai_fmt,
 	.set_sysclk	= cs42l42_set_sysclk,
diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index ecc02449c569..f5cf48c9c3b0 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -502,7 +502,7 @@ static int es8316_mute(struct snd_soc_dai *dai, int mute)
 #define ES8316_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE)
 
-static struct snd_soc_dai_ops es8316_ops = {
+static const struct snd_soc_dai_ops es8316_ops = {
 	.startup = es8316_pcm_startup,
 	.hw_params = es8316_pcm_hw_params,
 	.set_fmt = es8316_set_dai_fmt,
diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index bc2e74ff3b2d..e6de50acefd4 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -1360,7 +1360,7 @@ static void hdac_hdmi_skl_enable_dp12(struct hdac_device *hdac)
 
 }
 
-static struct snd_soc_dai_ops hdmi_dai_ops = {
+static const struct snd_soc_dai_ops hdmi_dai_ops = {
 	.startup = hdac_hdmi_pcm_open,
 	.shutdown = hdac_hdmi_pcm_close,
 	.hw_params = hdac_hdmi_set_hw_params,
diff --git a/sound/soc/codecs/inno_rk3036.c b/sound/soc/codecs/inno_rk3036.c
index b918ba5c8ce5..edf42d252fa1 100644
--- a/sound/soc/codecs/inno_rk3036.c
+++ b/sound/soc/codecs/inno_rk3036.c
@@ -310,7 +310,7 @@ static int rk3036_codec_dai_hw_params(struct snd_pcm_substream *substream,
 			   SNDRV_PCM_FMTBIT_S24_LE  | \
 			   SNDRV_PCM_FMTBIT_S32_LE)
 
-static struct snd_soc_dai_ops rk3036_codec_dai_ops = {
+static const struct snd_soc_dai_ops rk3036_codec_dai_ops = {
 	.set_fmt	= rk3036_codec_dai_set_fmt,
 	.hw_params	= rk3036_codec_dai_hw_params,
 };
diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 2a40a69a7513..3e421e9d14a5 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -350,7 +350,7 @@ static int max9867_dai_set_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
-static struct snd_soc_dai_ops max9867_dai_ops = {
+static const struct snd_soc_dai_ops max9867_dai_ops = {
 	.set_fmt = max9867_dai_set_fmt,
 	.set_sysclk	= max9867_set_dai_sysclk,
 	.prepare	= max9867_prepare,
diff --git a/sound/soc/codecs/max98926.c b/sound/soc/codecs/max98926.c
index 1eff7e0b092e..f16145d8ee6b 100644
--- a/sound/soc/codecs/max98926.c
+++ b/sound/soc/codecs/max98926.c
@@ -459,7 +459,7 @@ static int max98926_dai_hw_params(struct snd_pcm_substream *substream,
 #define MAX98926_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
 		SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
-static struct snd_soc_dai_ops max98926_dai_ops = {
+static const struct snd_soc_dai_ops max98926_dai_ops = {
 	.set_fmt = max98926_dai_set_fmt,
 	.hw_params = max98926_dai_hw_params,
 };
diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index a78802920c3c..aec1e1626993 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -753,7 +753,7 @@ static void pm8916_wcd_analog_shutdown(struct snd_pcm_substream *substream,
 			    RST_CTL_DIG_SW_RST_N_MASK, 0);
 }
 
-static struct snd_soc_dai_ops pm8916_wcd_analog_dai_ops = {
+static const struct snd_soc_dai_ops pm8916_wcd_analog_dai_ops = {
 	.startup = pm8916_wcd_analog_startup,
 	.shutdown = pm8916_wcd_analog_shutdown,
 };
diff --git a/sound/soc/codecs/msm8916-wcd-digital.c b/sound/soc/codecs/msm8916-wcd-digital.c
index f690442af8c9..7e3794fb8c2c 100644
--- a/sound/soc/codecs/msm8916-wcd-digital.c
+++ b/sound/soc/codecs/msm8916-wcd-digital.c
@@ -788,7 +788,7 @@ static void msm8916_wcd_digital_shutdown(struct snd_pcm_substream *substream,
 			    LPASS_CDC_CLK_PDM_CTL_PDM_CLK_SEL_MASK, 0);
 }
 
-static struct snd_soc_dai_ops msm8916_wcd_digital_dai_ops = {
+static const struct snd_soc_dai_ops msm8916_wcd_digital_dai_ops = {
 	.startup = msm8916_wcd_digital_startup,
 	.shutdown = msm8916_wcd_digital_shutdown,
 	.hw_params = msm8916_wcd_digital_hw_params,
diff --git a/sound/soc/codecs/rt5616.c b/sound/soc/codecs/rt5616.c
index 7d6e0823f98f..33bdfe7c394a 100644
--- a/sound/soc/codecs/rt5616.c
+++ b/sound/soc/codecs/rt5616.c
@@ -1265,7 +1265,7 @@ static int rt5616_resume(struct snd_soc_codec *codec)
 #define RT5616_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-static struct snd_soc_dai_ops rt5616_aif_dai_ops = {
+static const struct snd_soc_dai_ops rt5616_aif_dai_ops = {
 	.hw_params = rt5616_hw_params,
 	.set_fmt = rt5616_set_dai_fmt,
 	.set_sysclk = rt5616_set_dai_sysclk,
diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index a33202affeb1..af642c0fa280 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -2860,7 +2860,7 @@ static int rt5663_resume(struct snd_soc_codec *codec)
 #define RT5663_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-static struct snd_soc_dai_ops rt5663_aif_dai_ops = {
+static const struct snd_soc_dai_ops rt5663_aif_dai_ops = {
 	.hw_params = rt5663_hw_params,
 	.set_fmt = rt5663_set_dai_fmt,
 	.set_sysclk = rt5663_set_dai_sysclk,
diff --git a/sound/soc/codecs/tas5720.c b/sound/soc/codecs/tas5720.c
index c65b917598d2..01e9ed242378 100644
--- a/sound/soc/codecs/tas5720.c
+++ b/sound/soc/codecs/tas5720.c
@@ -507,7 +507,7 @@ static struct snd_soc_codec_driver soc_codec_dev_tas5720 = {
 #define TAS5720_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S18_3LE |\
 			 SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE)
 
-static struct snd_soc_dai_ops tas5720_speaker_dai_ops = {
+static const struct snd_soc_dai_ops tas5720_speaker_dai_ops = {
 	.hw_params	= tas5720_hw_params,
 	.set_fmt	= tas5720_set_dai_fmt,
 	.set_tdm_slot	= tas5720_set_dai_tdm_slot,
diff --git a/sound/soc/codecs/zx_aud96p22.c b/sound/soc/codecs/zx_aud96p22.c
index 032fb7cf6cbd..855011e9e4d1 100644
--- a/sound/soc/codecs/zx_aud96p22.c
+++ b/sound/soc/codecs/zx_aud96p22.c
@@ -312,7 +312,7 @@ static int aud96p22_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
-static struct snd_soc_dai_ops aud96p22_dai_ops = {
+static const struct snd_soc_dai_ops aud96p22_dai_ops = {
 	.set_fmt = aud96p22_set_fmt,
 };
 
-- 
2.13.2
