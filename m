From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: Constify snd_soc_dai_ops variables
Date: Wed, 15 Jul 2015 15:38:14 +0800
Message-ID: <1436945894.10834.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
 [209.85.220.49])
 by alsa0.perex.cz (Postfix) with ESMTP id B49EE265A78
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 09:38:22 +0200 (CEST)
Received: by pachj5 with SMTP id hj5so19625122pac.3
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 00:38:21 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Bard Liao <bardliao@realtek.com>, Dan Murphy <dmurphy@ti.com>
List-Id: alsa-devel@alsa-project.org

The snd_soc_dai_ops variables are not modified after initialization in
these drivers, so make them const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs42l52.c       |  2 +-
 sound/soc/codecs/cs42l56.c       |  2 +-
 sound/soc/codecs/isabelle.c      |  8 ++++----
 sound/soc/codecs/lm49453.c       | 10 +++++-----
 sound/soc/codecs/max98090.c      |  2 +-
 sound/soc/codecs/max98357a.c     |  2 +-
 sound/soc/codecs/mc13783.c       |  6 +++---
 sound/soc/codecs/rt5645.c        |  2 +-
 sound/soc/codecs/rt5670.c        |  2 +-
 sound/soc/codecs/rt5677.c        |  2 +-
 sound/soc/codecs/si476x.c        |  2 +-
 sound/soc/codecs/tas2552.c       |  2 +-
 sound/soc/codecs/tlv320aic31xx.c |  2 +-
 13 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 4de52c9..c8f4af2 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -919,7 +919,7 @@ static int cs42l52_set_bias_level(struct snd_soc_codec *codec,
 			SNDRV_PCM_FMTBIT_S20_3LE | SNDRV_PCM_FMTBIT_U20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_U24_LE)
 
-static struct snd_soc_dai_ops cs42l52_ops = {
+static const struct snd_soc_dai_ops cs42l52_ops = {
 	.hw_params	= cs42l52_pcm_hw_params,
 	.digital_mute	= cs42l52_digital_mute,
 	.set_fmt	= cs42l52_set_fmt,
diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index 1e11ba4..22bc2f3 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -989,7 +989,7 @@ static int cs42l56_set_bias_level(struct snd_soc_codec *codec,
 			SNDRV_PCM_FMTBIT_S32_LE)
 
 
-static struct snd_soc_dai_ops cs42l56_ops = {
+static const struct snd_soc_dai_ops cs42l56_ops = {
 	.hw_params	= cs42l56_pcm_hw_params,
 	.digital_mute	= cs42l56_digital_mute,
 	.set_fmt	= cs42l56_set_dai_fmt,
diff --git a/sound/soc/codecs/isabelle.c b/sound/soc/codecs/isabelle.c
index ac7dfe7..4013864 100644
--- a/sound/soc/codecs/isabelle.c
+++ b/sound/soc/codecs/isabelle.c
@@ -1016,25 +1016,25 @@ static int isabelle_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 #define ISABELLE_FORMATS (SNDRV_PCM_FMTBIT_S20_3LE |\
 			SNDRV_PCM_FMTBIT_S32_LE)
 
-static struct snd_soc_dai_ops isabelle_hs_dai_ops = {
+static const struct snd_soc_dai_ops isabelle_hs_dai_ops = {
 	.hw_params	= isabelle_hw_params,
 	.set_fmt	= isabelle_set_dai_fmt,
 	.digital_mute	= isabelle_hs_mute,
 };
 
-static struct snd_soc_dai_ops isabelle_hf_dai_ops = {
+static const struct snd_soc_dai_ops isabelle_hf_dai_ops = {
 	.hw_params	= isabelle_hw_params,
 	.set_fmt	= isabelle_set_dai_fmt,
 	.digital_mute	= isabelle_hf_mute,
 };
 
-static struct snd_soc_dai_ops isabelle_line_dai_ops = {
+static const struct snd_soc_dai_ops isabelle_line_dai_ops = {
 	.hw_params	= isabelle_hw_params,
 	.set_fmt	= isabelle_set_dai_fmt,
 	.digital_mute	= isabelle_line_mute,
 };
 
-static struct snd_soc_dai_ops isabelle_ul_dai_ops = {
+static const struct snd_soc_dai_ops isabelle_ul_dai_ops = {
 	.hw_params	= isabelle_hw_params,
 	.set_fmt	= isabelle_set_dai_fmt,
 };
diff --git a/sound/soc/codecs/lm49453.c b/sound/soc/codecs/lm49453.c
index ef432aa..4e76992 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -1287,35 +1287,35 @@ static int lm49453_set_bias_level(struct snd_soc_codec *codec,
 #define LM49453_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 			 SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
-static struct snd_soc_dai_ops lm49453_headset_dai_ops = {
+static const struct snd_soc_dai_ops lm49453_headset_dai_ops = {
 	.hw_params	= lm49453_hw_params,
 	.set_sysclk	= lm49453_set_dai_sysclk,
 	.set_fmt	= lm49453_set_dai_fmt,
 	.digital_mute	= lm49453_hp_mute,
 };
 
-static struct snd_soc_dai_ops lm49453_speaker_dai_ops = {
+static const struct snd_soc_dai_ops lm49453_speaker_dai_ops = {
 	.hw_params	= lm49453_hw_params,
 	.set_sysclk	= lm49453_set_dai_sysclk,
 	.set_fmt	= lm49453_set_dai_fmt,
 	.digital_mute	= lm49453_ls_mute,
 };
 
-static struct snd_soc_dai_ops lm49453_haptic_dai_ops = {
+static const struct snd_soc_dai_ops lm49453_haptic_dai_ops = {
 	.hw_params	= lm49453_hw_params,
 	.set_sysclk	= lm49453_set_dai_sysclk,
 	.set_fmt	= lm49453_set_dai_fmt,
 	.digital_mute	= lm49453_ha_mute,
 };
 
-static struct snd_soc_dai_ops lm49453_ep_dai_ops = {
+static const struct snd_soc_dai_ops lm49453_ep_dai_ops = {
 	.hw_params	= lm49453_hw_params,
 	.set_sysclk	= lm49453_set_dai_sysclk,
 	.set_fmt	= lm49453_set_dai_fmt,
 	.digital_mute	= lm49453_ep_mute,
 };
 
-static struct snd_soc_dai_ops lm49453_lineout_dai_ops = {
+static const struct snd_soc_dai_ops lm49453_lineout_dai_ops = {
 	.hw_params	= lm49453_hw_params,
 	.set_sysclk	= lm49453_set_dai_sysclk,
 	.set_fmt	= lm49453_set_dai_fmt,
diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 1697340..a2cdf52 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2386,7 +2386,7 @@ EXPORT_SYMBOL_GPL(max98090_mic_detect);
 #define MAX98090_RATES SNDRV_PCM_RATE_8000_96000
 #define MAX98090_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
 
-static struct snd_soc_dai_ops max98090_dai_ops = {
+static const struct snd_soc_dai_ops max98090_dai_ops = {
 	.set_sysclk = max98090_dai_set_sysclk,
 	.set_fmt = max98090_dai_set_fmt,
 	.set_tdm_slot = max98090_set_tdm_slot,
diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index e88119a..f5e3dce 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -79,7 +79,7 @@ static struct snd_soc_codec_driver max98357a_codec_driver = {
 	.num_dapm_routes	= ARRAY_SIZE(max98357a_dapm_routes),
 };
 
-static struct snd_soc_dai_ops max98357a_dai_ops = {
+static const struct snd_soc_dai_ops max98357a_dai_ops = {
 	.trigger	= max98357a_daiops_trigger,
 };
 
diff --git a/sound/soc/codecs/mc13783.c b/sound/soc/codecs/mc13783.c
index 3d44fc5..3e770cb 100644
--- a/sound/soc/codecs/mc13783.c
+++ b/sound/soc/codecs/mc13783.c
@@ -650,14 +650,14 @@ static int mc13783_remove(struct snd_soc_codec *codec)
 #define MC13783_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 	SNDRV_PCM_FMTBIT_S24_LE)
 
-static struct snd_soc_dai_ops mc13783_ops_dac = {
+static const struct snd_soc_dai_ops mc13783_ops_dac = {
 	.hw_params	= mc13783_pcm_hw_params_dac,
 	.set_fmt	= mc13783_set_fmt_async,
 	.set_sysclk	= mc13783_set_sysclk_dac,
 	.set_tdm_slot	= mc13783_set_tdm_slot_dac,
 };
 
-static struct snd_soc_dai_ops mc13783_ops_codec = {
+static const struct snd_soc_dai_ops mc13783_ops_codec = {
 	.hw_params	= mc13783_pcm_hw_params_codec,
 	.set_fmt	= mc13783_set_fmt_async,
 	.set_sysclk	= mc13783_set_sysclk_codec,
@@ -698,7 +698,7 @@ static struct snd_soc_dai_driver mc13783_dai_async[] = {
 	},
 };
 
-static struct snd_soc_dai_ops mc13783_ops_sync = {
+static const struct snd_soc_dai_ops mc13783_ops_sync = {
 	.hw_params	= mc13783_pcm_hw_params_sync,
 	.set_fmt	= mc13783_set_fmt_sync,
 	.set_sysclk	= mc13783_set_sysclk_sync,
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9dfa431..9b1ad6b 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3106,7 +3106,7 @@ static int rt5645_resume(struct snd_soc_codec *codec)
 #define RT5645_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-static struct snd_soc_dai_ops rt5645_aif_dai_ops = {
+static const struct snd_soc_dai_ops rt5645_aif_dai_ops = {
 	.hw_params = rt5645_hw_params,
 	.set_fmt = rt5645_set_dai_fmt,
 	.set_sysclk = rt5645_set_dai_sysclk,
diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index a791d7e..132d012 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2720,7 +2720,7 @@ static int rt5670_resume(struct snd_soc_codec *codec)
 #define RT5670_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-static struct snd_soc_dai_ops rt5670_aif_dai_ops = {
+static const struct snd_soc_dai_ops rt5670_aif_dai_ops = {
 	.hw_params = rt5670_hw_params,
 	.set_fmt = rt5670_set_dai_fmt,
 	.set_sysclk = rt5670_set_dai_sysclk,
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 13b871f..151db60 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4861,7 +4861,7 @@ static int rt5677_write(void *context, unsigned int reg, unsigned int val)
 #define RT5677_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-static struct snd_soc_dai_ops rt5677_aif_dai_ops = {
+static const struct snd_soc_dai_ops rt5677_aif_dai_ops = {
 	.hw_params = rt5677_hw_params,
 	.set_fmt = rt5677_set_dai_fmt,
 	.set_sysclk = rt5677_set_dai_sysclk,
diff --git a/sound/soc/codecs/si476x.c b/sound/soc/codecs/si476x.c
index 3e72964..a8402d0 100644
--- a/sound/soc/codecs/si476x.c
+++ b/sound/soc/codecs/si476x.c
@@ -208,7 +208,7 @@ out:
 	return err;
 }
 
-static struct snd_soc_dai_ops si476x_dai_ops = {
+static const struct snd_soc_dai_ops si476x_dai_ops = {
 	.hw_params	= si476x_codec_hw_params,
 	.set_fmt	= si476x_codec_set_dai_fmt,
 };
diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 71cfae0..f2ae302 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -520,7 +520,7 @@ static const struct dev_pm_ops tas2552_pm = {
 			   NULL)
 };
 
-static struct snd_soc_dai_ops tas2552_speaker_dai_ops = {
+static const struct snd_soc_dai_ops tas2552_speaker_dai_ops = {
 	.hw_params	= tas2552_hw_params,
 	.prepare	= tas2552_prepare,
 	.set_sysclk	= tas2552_set_dai_sysclk,
diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index c4c960f..df01fec 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1121,7 +1121,7 @@ static struct snd_soc_codec_driver soc_codec_driver_aic31xx = {
 	.num_dapm_routes	= ARRAY_SIZE(aic31xx_audio_map),
 };
 
-static struct snd_soc_dai_ops aic31xx_dai_ops = {
+static const struct snd_soc_dai_ops aic31xx_dai_ops = {
 	.hw_params	= aic31xx_hw_params,
 	.set_sysclk	= aic31xx_set_dai_sysclk,
 	.set_fmt	= aic31xx_set_dai_fmt,
-- 
2.1.0
