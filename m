From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] sound: pci: hda: patch_analog.c:  Remove unused function
Date: Sat, 20 Dec 2014 23:31:19 +0100
Message-ID: <1419114679-11752-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Remove the function ad198x_ch_mode_get() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 sound/pci/hda/patch_analog.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 06275f8..9d5257b 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -707,15 +707,6 @@ static int ad198x_ch_mode_info(struct snd_kcontrol *kcontrol,
 				    spec->num_channel_mode);
 }
 
-static int ad198x_ch_mode_get(struct snd_kcontrol *kcontrol,
-			      struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct ad198x_spec *spec = codec->spec;
-	return snd_hda_ch_mode_get(codec, ucontrol, spec->channel_mode,
-				   spec->num_channel_mode, spec->multiout.max_channels);
-}
-
 static int ad198x_ch_mode_put(struct snd_kcontrol *kcontrol,
 			      struct snd_ctl_elem_value *ucontrol)
 {
-- 
1.7.10.4
