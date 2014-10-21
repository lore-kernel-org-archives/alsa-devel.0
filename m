From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 18/43] ALSA: ac97: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 12:10:54 +0200
Message-ID: <1413886279-18704-19-git-send-email-tiwai@suse.de>
References: <1413886279-18704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 119B126664F
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 12:11:25 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 10CC3AD9E
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 10:11:24 +0000 (UTC)
In-Reply-To: <1413886279-18704-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

... and reduce the open codes.  Also add missing const to text arrays.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ac97/ac97_codec.c |  10 +--
 sound/pci/ac97/ac97_patch.c | 176 +++++++++++++-------------------------------
 2 files changed, 53 insertions(+), 133 deletions(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 14ad54b7928c..5ee2f17c287c 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -463,14 +463,8 @@ static int snd_ac97_info_enum_double(struct snd_kcontrol *kcontrol,
 {
 	struct ac97_enum *e = (struct ac97_enum *)kcontrol->private_value;
 	
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = e->shift_l == e->shift_r ? 1 : 2;
-	uinfo->value.enumerated.items = e->mask;
-	
-	if (uinfo->value.enumerated.item > e->mask - 1)
-		uinfo->value.enumerated.item = e->mask - 1;
-	strcpy(uinfo->value.enumerated.name, e->texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, e->shift_l == e->shift_r ? 1 : 2,
+				 e->mask, e->texts);
 }
 
 static int snd_ac97_get_enum_double(struct snd_kcontrol *kcontrol,
diff --git a/sound/pci/ac97/ac97_patch.c b/sound/pci/ac97/ac97_patch.c
index 991762215417..50f420d69a8a 100644
--- a/sound/pci/ac97/ac97_patch.c
+++ b/sound/pci/ac97/ac97_patch.c
@@ -81,22 +81,11 @@ static int ac97_update_bits_page(struct snd_ac97 *ac97, unsigned short reg, unsi
 /*
  * shared line-in/mic controls
  */
-static int ac97_enum_text_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo,
-			       const char **texts, unsigned int nums)
-{
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = nums;
-	if (uinfo->value.enumerated.item > nums - 1)
-		uinfo->value.enumerated.item = nums - 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
-}
-
 static int ac97_surround_jack_mode_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static const char *texts[] = { "Shared", "Independent" };
-	return ac97_enum_text_info(kcontrol, uinfo, texts, 2);
+	static const char * const texts[] = { "Shared", "Independent" };
+
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
 }
 
 static int ac97_surround_jack_mode_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -123,9 +112,9 @@ static int ac97_surround_jack_mode_put(struct snd_kcontrol *kcontrol, struct snd
 
 static int ac97_channel_mode_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static const char *texts[] = { "2ch", "4ch", "6ch", "8ch" };
-	return ac97_enum_text_info(kcontrol, uinfo, texts,
-		kcontrol->private_value);
+	static const char * const texts[] = { "2ch", "4ch", "6ch", "8ch" };
+
+	return snd_ctl_enum_info(uinfo, 1, kcontrol->private_value, texts);
 }
 
 static int ac97_channel_mode_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -240,17 +229,11 @@ static inline int alc850_is_aux_back_surround(struct snd_ac97 *ac97)
 static int snd_ac97_ymf7x3_info_speaker(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[3] = {
+	static const char * const texts[3] = {
 		"Standard", "Small", "Smaller"
 	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	if (uinfo->value.enumerated.item > 2)
-		uinfo->value.enumerated.item = 2;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 3, texts);
 }
 
 static int snd_ac97_ymf7x3_get_speaker(struct snd_kcontrol *kcontrol,
@@ -293,15 +276,9 @@ static const struct snd_kcontrol_new snd_ac97_ymf7x3_controls_speaker =
 static int snd_ac97_ymf7x3_spdif_source_info(struct snd_kcontrol *kcontrol,
 					     struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[2] = { "AC-Link", "A/D Converter" };
+	static const char * const texts[2] = { "AC-Link", "A/D Converter" };
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item > 1)
-		uinfo->value.enumerated.item = 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
 }
 
 static int snd_ac97_ymf7x3_spdif_source_get(struct snd_kcontrol *kcontrol,
@@ -401,15 +378,9 @@ static int patch_yamaha_ymf743(struct snd_ac97 *ac97)
    There is also a bit to mute S/PDIF output in a vendor-specific register. */
 static int snd_ac97_ymf753_spdif_output_pin_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[3] = { "Disabled", "Pin 43", "Pin 48" };
+	static const char * const texts[3] = { "Disabled", "Pin 43", "Pin 48" };
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	if (uinfo->value.enumerated.item > 2)
-		uinfo->value.enumerated.item = 2;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 3, texts);
 }
 
 static int snd_ac97_ymf753_spdif_output_pin_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -1103,16 +1074,11 @@ static int patch_sigmatel_stac9756(struct snd_ac97 * ac97)
 
 static int snd_ac97_stac9758_output_jack_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[5] = { "Input/Disabled", "Front Output",
+	static const char * const texts[5] = {
+		"Input/Disabled", "Front Output",
 		"Rear Output", "Center/LFE Output", "Mixer Output" };
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 5;
-	if (uinfo->value.enumerated.item > 4)
-		uinfo->value.enumerated.item = 4;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 5, texts);
 }
 
 static int snd_ac97_stac9758_output_jack_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -1147,16 +1113,11 @@ static int snd_ac97_stac9758_output_jack_put(struct snd_kcontrol *kcontrol, stru
 
 static int snd_ac97_stac9758_input_jack_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[7] = { "Mic2 Jack", "Mic1 Jack", "Line In Jack",
+	static const char * const texts[7] = {
+		"Mic2 Jack", "Mic1 Jack", "Line In Jack",
 		"Front Jack", "Rear Jack", "Center/LFE Jack", "Mute" };
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 7;
-	if (uinfo->value.enumerated.item > 6)
-		uinfo->value.enumerated.item = 6;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 7, texts);
 }
 
 static int snd_ac97_stac9758_input_jack_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -1181,15 +1142,11 @@ static int snd_ac97_stac9758_input_jack_put(struct snd_kcontrol *kcontrol, struc
 
 static int snd_ac97_stac9758_phonesel_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[3] = { "None", "Front Jack", "Rear Jack" };
+	static const char * const texts[3] = {
+		"None", "Front Jack", "Rear Jack"
+	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	if (uinfo->value.enumerated.item > 2)
-		uinfo->value.enumerated.item = 2;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 3, texts);
 }
 
 static int snd_ac97_stac9758_phonesel_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -1804,15 +1761,9 @@ static int patch_ad1886(struct snd_ac97 * ac97)
 
 static int snd_ac97_ad198x_spdif_source_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[2] = { "AC-Link", "A/D Converter" };
+	static const char * const texts[2] = { "AC-Link", "A/D Converter" };
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item > 1)
-		uinfo->value.enumerated.item = 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
 }
 
 static int snd_ac97_ad198x_spdif_source_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -1994,15 +1945,9 @@ static int snd_ac97_ad1888_lohpsel_put(struct snd_kcontrol *kcontrol, struct snd
 
 static int snd_ac97_ad1888_downmix_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[3] = {"Off", "6 -> 4", "6 -> 2"};
+	static const char * const texts[3] = {"Off", "6 -> 4", "6 -> 2"};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	if (uinfo->value.enumerated.item > 2)
-		uinfo->value.enumerated.item = 2;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 3, texts);
 }
 
 static int snd_ac97_ad1888_downmix_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -2153,16 +2098,11 @@ static int patch_ad1980(struct snd_ac97 * ac97)
 static int snd_ac97_ad1985_vrefout_info(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[4] = {"High-Z", "3.7 V", "2.25 V", "0 V"};
+	static const char * const texts[4] = {
+		"High-Z", "3.7 V", "2.25 V", "0 V"
+	};
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 4;
-	if (uinfo->value.enumerated.item > 3)
-		uinfo->value.enumerated.item = 3;
-	strcpy(uinfo->value.enumerated.name,
-	       texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 4, texts);
 }
 
 static int snd_ac97_ad1985_vrefout_get(struct snd_kcontrol *kcontrol,
@@ -2756,20 +2696,18 @@ static const struct snd_kcontrol_new snd_ac97_controls_alc655[] = {
 
 static int alc655_iec958_route_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts_655[3] = { "PCM", "Analog In", "IEC958 In" };
-	static char *texts_658[4] = { "PCM", "Analog1 In", "Analog2 In", "IEC958 In" };
+	static const char * const texts_655[3] = {
+		"PCM", "Analog In", "IEC958 In"
+	};
+	static const char * const texts_658[4] = {
+		"PCM", "Analog1 In", "Analog2 In", "IEC958 In"
+	};
 	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = ac97->spec.dev_flags ? 4 : 3;
-	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
-		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
-	strcpy(uinfo->value.enumerated.name,
-	       ac97->spec.dev_flags ?
-	       texts_658[uinfo->value.enumerated.item] :
-	       texts_655[uinfo->value.enumerated.item]);
-	return 0;
+	if (ac97->spec.dev_flags)
+		return snd_ctl_enum_info(uinfo, 1, 4, texts_658);
+	else
+		return snd_ctl_enum_info(uinfo, 1, 3, texts_655);
 }
 
 static int alc655_iec958_route_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -3055,15 +2993,9 @@ static int patch_cm9738(struct snd_ac97 * ac97)
 
 static int snd_ac97_cmedia_spdif_playback_source_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = { "Analog", "Digital" };
+	static const char * const texts[] = { "Analog", "Digital" };
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 2;
-	if (uinfo->value.enumerated.item > 1)
-		uinfo->value.enumerated.item = 1;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 2, texts);
 }
 
 static int snd_ac97_cmedia_spdif_playback_source_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -3235,15 +3167,9 @@ static const struct snd_kcontrol_new snd_ac97_cm9761_controls[] = {
 
 static int cm9761_spdif_out_source_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
 {
-	static char *texts[] = { "AC-Link", "ADC", "SPDIF-In" };
+	static const char * const texts[] = { "AC-Link", "ADC", "SPDIF-In" };
 
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
-	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	if (uinfo->value.enumerated.item > 2)
-		uinfo->value.enumerated.item = 2;
-	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
-	return 0;
+	return snd_ctl_enum_info(uinfo, 1, 3, texts);
 }
 
 static int cm9761_spdif_out_source_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
@@ -3552,11 +3478,12 @@ static int snd_ac97_vt1617a_smart51_info(struct snd_kcontrol *kcontrol,
 	 * is SM51EN *AND* it's Bit14, not Bit15 so the table is very
 	 * counter-intuitive */ 
 
-	static const char* texts[] = { "LineIn Mic1", "LineIn Mic1 Mic3",
+	static const char * const texts[] = {"LineIn Mic1", "LineIn Mic1 Mic3",
 				       "Surr LFE/C Mic3", "LineIn LFE/C Mic3",
 				       "LineIn Mic2", "LineIn Mic2 Mic1",
 				       "Surr LFE Mic1", "Surr LFE Mic1 Mic2"};
-	return ac97_enum_text_info(kcontrol, uinfo, texts, 8);
+
+	return snd_ctl_enum_info(uinfo, 1, 8, texts);
 }
 
 static int snd_ac97_vt1617a_smart51_get(struct snd_kcontrol *kcontrol,
@@ -3720,9 +3647,8 @@ static struct vt1618_uaj_item vt1618_uaj[3] = {
 static int snd_ac97_vt1618_UAJ_info(struct snd_kcontrol *kcontrol,
 				    struct snd_ctl_elem_info *uinfo)
 {
-	return ac97_enum_text_info(kcontrol, uinfo,
-				   vt1618_uaj[kcontrol->private_value].items,
-				   4);
+	return snd_ctl_enum_info(uinfo, 1, 4,
+				 vt1618_uaj[kcontrol->private_value].items);
 }
 
 /* All of the vt1618 Universal Audio Jack twiddlers are on
@@ -3767,9 +3693,9 @@ static int snd_ac97_vt1618_UAJ_put(struct snd_kcontrol *kcontrol,
 static int snd_ac97_vt1618_aux_info(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_info *uinfo)
 {
-	static const char *txt_aux[] = {"Aux In", "Back Surr Out"};
+	static const char * const txt_aux[] = {"Aux In", "Back Surr Out"};
 
-	return ac97_enum_text_info(kcontrol, uinfo, txt_aux, 2);
+	return snd_ctl_enum_info(uinfo, 1, 2, txt_aux);
 }
 
 static int snd_ac97_vt1618_aux_get(struct snd_kcontrol *kcontrol,
-- 
2.1.2
