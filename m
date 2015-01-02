From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] sound: pci: hda: patch_analog:  Remove some unused functions
Date: Fri,  2 Jan 2015 18:58:28 +0100
Message-ID: <1420221508-32319-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Removes some functions that are not used anywhere:
ad198x_ch_mode_put() ad198x_ch_mode_info()

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 sound/pci/hda/patch_analog.c |   21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 06275f8..ed0b71c 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -698,15 +698,6 @@ static int patch_ad1981(struct hda_codec *codec)
  */
 
 #ifdef ENABLE_AD_STATIC_QUIRKS
-static int ad198x_ch_mode_info(struct snd_kcontrol *kcontrol,
-			       struct snd_ctl_elem_info *uinfo)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct ad198x_spec *spec = codec->spec;
-	return snd_hda_ch_mode_info(codec, uinfo, spec->channel_mode,
-				    spec->num_channel_mode);
-}
-
 static int ad198x_ch_mode_get(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
@@ -716,18 +707,6 @@ static int ad198x_ch_mode_get(struct snd_kcontrol *kcontrol,
 				   spec->num_channel_mode, spec->multiout.max_channels);
 }
 
-static int ad198x_ch_mode_put(struct snd_kcontrol *kcontrol,
-			      struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct ad198x_spec *spec = codec->spec;
-	int err = snd_hda_ch_mode_put(codec, ucontrol, spec->channel_mode,
-				      spec->num_channel_mode,
-				      &spec->multiout.max_channels);
-	if (err >= 0 && spec->need_dac_fix)
-		spec->multiout.num_dacs = spec->multiout.max_channels / 2;
-	return err;
-}
 #endif /* ENABLE_AD_STATIC_QUIRKS */
 
 static int ad1988_auto_smux_enum_info(struct snd_kcontrol *kcontrol,
-- 
1.7.10.4
