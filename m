From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8958: Fix enum ctl accesses in a wrong type" to the asoc tree
Date: Tue, 01 Mar 2016 12:21:43 +0900
Message-ID: <E1aaasZ-00082X-A5@finisterre>
References: <1456765278-5435-4-git-send-email-tiwai@suse.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1456765278-5435-4-git-send-email-tiwai@suse.de>
Sender: stable-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8958: Fix enum ctl accesses in a wrong type

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

>From d0784829ae3b0beeb69b476f017d5c8a2eb95198 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 29 Feb 2016 18:01:12 +0100
Subject: [PATCH] ASoC: wm8958: Fix enum ctl accesses in a wrong type

"MBC Mode", "VSS Mode", "VSS HPF Mode" and "Enhanced EQ Mode" ctls in
wm8958 codec driver are enum, while the current driver accesses
wrongly via value.integer.value[].  They have to be via
value.enumerated.item[] instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/wm8958-dsp2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index c799cca5abeb..6b864c0fc2b6 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -459,7 +459,7 @@ static int wm8958_put_mbc_enum(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994 *control = wm8994->wm8994;
-	int value = ucontrol->value.integer.value[0];
+	int value = ucontrol->value.enumerated.item[0];
 	int reg;
 
 	/* Don't allow on the fly reconfiguration */
@@ -549,7 +549,7 @@ static int wm8958_put_vss_enum(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994 *control = wm8994->wm8994;
-	int value = ucontrol->value.integer.value[0];
+	int value = ucontrol->value.enumerated.item[0];
 	int reg;
 
 	/* Don't allow on the fly reconfiguration */
@@ -582,7 +582,7 @@ static int wm8958_put_vss_hpf_enum(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994 *control = wm8994->wm8994;
-	int value = ucontrol->value.integer.value[0];
+	int value = ucontrol->value.enumerated.item[0];
 	int reg;
 
 	/* Don't allow on the fly reconfiguration */
@@ -749,7 +749,7 @@ static int wm8958_put_enh_eq_enum(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 	struct wm8994 *control = wm8994->wm8994;
-	int value = ucontrol->value.integer.value[0];
+	int value = ucontrol->value.enumerated.item[0];
 	int reg;
 
 	/* Don't allow on the fly reconfiguration */
-- 
2.7.0
