From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Correct DSP pointer for preloader control" to the asoc tree
Date: Wed,  8 Aug 2018 12:07:55 +0100 (BST)
Message-ID: <20180808110755.C5AD61124340@debutante.sirena.org.uk>
References: <20180807173042.22501-1-ckeepax@opensource.cirrus.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180807173042.22501-1-ckeepax@opensource.cirrus.com>
Sender: stable-owner@vger.kernel.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.orgbroonie@kernel.org, ajit.pandey@cirrus.com, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Correct DSP pointer for preloader control

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From b1470d4ce77c2d60661c7d5325d4fb8063e15ff8 Mon Sep 17 00:00:00 2001
From: Ajit Pandey <ajit.pandey@cirrus.com>
Date: Tue, 7 Aug 2018 18:30:42 +0100
Subject: [PATCH] ASoC: wm_adsp: Correct DSP pointer for preloader control

The offset of the DSP core needs to be taken into account for the DSP
preloader control get and put. Currently the dsp->preloaded variable
will only ever be read/updated on the first DSP, whilst this doesn't
affect the operation of the control the readback will be incorrect.

Signed-off-by: Ajit Pandey <ajit.pandey@cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/wm_adsp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 4e7f8525449e..08dc82770273 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2643,7 +2643,10 @@ int wm_adsp2_preloader_get(struct snd_kcontrol *kcontrol,
 			   struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
-	struct wm_adsp *dsp = snd_soc_component_get_drvdata(component);
+	struct wm_adsp *dsps = snd_soc_component_get_drvdata(component);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct wm_adsp *dsp = &dsps[mc->shift - 1];
 
 	ucontrol->value.integer.value[0] = dsp->preloaded;
 
@@ -2655,10 +2658,11 @@ int wm_adsp2_preloader_put(struct snd_kcontrol *kcontrol,
 			   struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
-	struct wm_adsp *dsp = snd_soc_component_get_drvdata(component);
+	struct wm_adsp *dsps = snd_soc_component_get_drvdata(component);
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
+	struct wm_adsp *dsp = &dsps[mc->shift - 1];
 	char preload[32];
 
 	snprintf(preload, ARRAY_SIZE(preload), "DSP%u Preload", mc->shift);
-- 
2.18.0
