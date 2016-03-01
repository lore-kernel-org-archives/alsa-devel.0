From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Fix ctl value accesses in a wrong type" to the asoc tree
Date: Tue, 01 Mar 2016 12:25:17 +0900
Message-ID: <E1aaaw1-0008C2-17@finisterre>
References: <1456762848-2837-1-git-send-email-tiwai@suse.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1456762848-2837-1-git-send-email-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Fix ctl value accesses in a wrong type

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

>From 741338f99f16dc24d2d01ac777b0798ae9d10a90 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 29 Feb 2016 17:20:48 +0100
Subject: [PATCH] ASoC: dapm: Fix ctl value accesses in a wrong type

snd_soc_dapm_dai_link_get() and _put() access the associated ctl
values as value.integer.value[].  However, this is an enum ctl, and it
has to be accessed via value.enumerated.item[].  The former is long
while the latter is unsigned int, so they don't align.

Fixes: c66150824b8a ('ASoC: dapm: add code to configure dai link parameters')
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5a2812fa8946..335c7de2b046 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3573,7 +3573,7 @@ static int snd_soc_dapm_dai_link_get(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_dapm_widget *w = snd_kcontrol_chip(kcontrol);
 
-	ucontrol->value.integer.value[0] = w->params_select;
+	ucontrol->value.enumerated.item[0] = w->params_select;
 
 	return 0;
 }
@@ -3587,13 +3587,13 @@ static int snd_soc_dapm_dai_link_put(struct snd_kcontrol *kcontrol,
 	if (w->power)
 		return -EBUSY;
 
-	if (ucontrol->value.integer.value[0] == w->params_select)
+	if (ucontrol->value.enumerated.item[0] == w->params_select)
 		return 0;
 
-	if (ucontrol->value.integer.value[0] >= w->num_params)
+	if (ucontrol->value.enumerated.item[0] >= w->num_params)
 		return -EINVAL;
 
-	w->params_select = ucontrol->value.integer.value[0];
+	w->params_select = ucontrol->value.enumerated.item[0];
 
 	return 0;
 }
-- 
2.7.0
