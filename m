From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Constify snd_soc_dai_ops variables" to
	the asoc tree
Date: Wed, 15 Jul 2015 12:55:42 +0100
Message-ID: <E1ZFLHq-0006de-3C@debutante>
References: <1436945894.10834.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 797AF265A82
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 13:55:50 +0200 (CEST)
In-Reply-To: <1436945894.10834.3.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Constify snd_soc_dai_ops variables

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

>From 64793047558781330a1d13b159a2bc9385bdf97f Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 15 Jul 2015 15:38:14 +0800
Subject: [PATCH] ASoC: Constify snd_soc_dai_ops variables

The snd_soc_dai_ops variables are not modified after initialization in
these drivers, so make them const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
index 4de52c9957ac..c8f4af230ac0 100644
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
index 1e11ba45a79f..22bc2f3460a5 100644
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
index ebd90283c960..00dca1fdfcff 100644
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
index 6600aa0a33dc..081d96d6df29 100644
--- a/sound/soc/codecs/lm49453.c
+++ b/sound/soc/codecs/lm49453.c
@@ -1291,35 +1291,35 @@ static int lm49453_set_bias_level(struct snd_soc_codec *codec,
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
index 78268f0514e9..b1b436f05ebe 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2383,7 +2383,7 @@ EXPORT_SYMBOL_GPL(max98090_mic_detect);
 #define MAX98090_RATES SNDRV_PCM_RATE_8000_96000
 #define MAX98090_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
 
-static struct snd_soc_dai_ops max98090_dai_ops = {
+static const struct snd_soc_dai_ops max98090_dai_ops = {
 	.set_sysclk = max98090_dai_set_sysclk,
 	.set_fmt = max98090_dai_set_fmt,
 	.set_tdm_slot = max98090_set_tdm_slot,
diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index 3a2fda08a893..c4a211d3646c 100644
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
index 3d44fc50e4d0..3e770cbe7f0f 100644
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
index 9ce311e088fc..7c59326dce3e 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3110,7 +3110,7 @@ static int rt5645_resume(struct snd_soc_codec *codec)
 #define RT5645_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-static struct snd_soc_dai_ops rt5645_aif_dai_ops = {
+static const struct snd_soc_dai_ops rt5645_aif_dai_ops = {
 	.hw_params = rt5645_hw_params,
 	.set_fmt = rt5645_set_dai_fmt,
 	.set_sysclk = rt5645_set_dai_sysclk,
diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index a9123d414178..d583510ac026 100644
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
index 31d969ac1192..4b584f90eb91 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4863,7 +4863,7 @@ static int rt5677_write(void *context, unsigned int reg, unsigned int val)
 #define RT5677_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-static struct snd_soc_dai_ops rt5677_aif_dai_ops = {
+static const struct snd_soc_dai_ops rt5677_aif_dai_ops = {
 	.hw_params = rt5677_hw_params,
 	.set_fmt = rt5677_set_dai_fmt,
 	.set_sysclk = rt5677_set_dai_sysclk,
diff --git a/sound/soc/codecs/si476x.c b/sound/soc/codecs/si476x.c
index 3e72964280c6..a8402d0af0ea 100644
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
index 4f25a7d0efa2..d1552c308f77 100644
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
index c4c960f592a1..df01feca449f 100644
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
2.1.4
