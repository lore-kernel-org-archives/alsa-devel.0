From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] sound: pci: hda: patch_analog.c: Remove some
	unused functions
Date: Sun, 21 Dec 2014 13:35:12 +0100
Message-ID: <1419165312-28886-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 368B126059D
 for <alsa-devel@alsa-project.org>; Sun, 21 Dec 2014 13:32:26 +0100 (CET)
Received: by mail-wg0-f42.google.com with SMTP id k14so4796338wgh.29
 for <alsa-devel@alsa-project.org>; Sun, 21 Dec 2014 04:32:25 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
List-Id: alsa-devel@alsa-project.org

Removes some functions that are not used anywhere:
ad198x_ch_mode_get() ad198x_ch_mode_info() ad198x_ch_mode_info()

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 sound/pci/hda/patch_analog.c |   33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 06275f8..0e76dcc 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -697,39 +697,6 @@ static int patch_ad1981(struct hda_codec *codec)
  *      E/F quad mic array
  */
 
-#ifdef ENABLE_AD_STATIC_QUIRKS
-static int ad198x_ch_mode_info(struct snd_kcontrol *kcontrol,
-			       struct snd_ctl_elem_info *uinfo)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct ad198x_spec *spec = codec->spec;
-	return snd_hda_ch_mode_info(codec, uinfo, spec->channel_mode,
-				    spec->num_channel_mode);
-}
-
-static int ad198x_ch_mode_get(struct snd_kcontrol *kcontrol,
-			      struct snd_ctl_elem_value *ucontrol)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct ad198x_spec *spec = codec->spec;
-	return snd_hda_ch_mode_get(codec, ucontrol, spec->channel_mode,
-				   spec->num_channel_mode, spec->multiout.max_channels);
-}
-
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
-#endif /* ENABLE_AD_STATIC_QUIRKS */
-
 static int ad1988_auto_smux_enum_info(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_info *uinfo)
 {
-- 
1.7.10.4
