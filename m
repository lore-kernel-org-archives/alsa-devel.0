From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 02/14] ASoC: codecs: constify snd_soc_dai_ops
	structures
Date: Fri, 18 Aug 2017 17:35:59 +0530
Message-ID: <1503057971-16033-3-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503057971-16033-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 642642677A8
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 14:06:29 +0200 (CEST)
Received: by mail-pg0-f68.google.com with SMTP id y129so14796126pgy.3
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 05:06:29 -0700 (PDT)
In-Reply-To: <1503057971-16033-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com, oder_chiou@realtek.com, timur@tabi.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

snd_soc_dai_ops are not supposed to change at runtime. All functions
working with snd_soc_dai_ops provided by <sound/soc-dai.h> work with
const snd_soc_dai_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
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
index 55e4520..9e860df 100644
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
index ecc02449..f5cf48c 100644
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
index bc2e74f..e6de50a 100644
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
index b918ba5..edf42d2 100644
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
index 2a40a69..3e421e9 100644
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
index 1eff7e0..f16145d8 100644
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
index a788029..aec1e16 100644
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
index f690442..7e3794f 100644
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
index 7d6e082..33bdfe7 100644
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
index a33202a..af642c0 100644
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
index c65b917..01e9ed2 100644
--- a/sound/soc/codecs/tas5720.c
+++ b/sound/soc/codecs/tas5720.c
@@ -507,7 +507,7 @@ static const DECLARE_TLV_DB_RANGE(dac_analog_tlv,
 #define TAS5720_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S18_3LE |\
 			 SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_S24_LE)
 
-static struct snd_soc_dai_ops tas5720_speaker_dai_ops = {
+static const struct snd_soc_dai_ops tas5720_speaker_dai_ops = {
 	.hw_params	= tas5720_hw_params,
 	.set_fmt	= tas5720_set_dai_fmt,
 	.set_tdm_slot	= tas5720_set_dai_tdm_slot,
diff --git a/sound/soc/codecs/zx_aud96p22.c b/sound/soc/codecs/zx_aud96p22.c
index 032fb7c..855011e 100644
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
1.9.1
