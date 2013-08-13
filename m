From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Allow auto_mute_via_amp on
	bind mute controls
Date: Tue, 13 Aug 2013 09:12:19 +0200
Message-ID: <1376377940-28450-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B7F452650D7
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 09:10:56 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4804FA51FF
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 09:10:56 +0200 (CEST)
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

The auto-mute using the amp currently works only for a single amp on a
pin.  Make it working also with HDA_CTL_BIND_MUTE type, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index f6c0344..6ed2209 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -816,6 +816,8 @@ static void resume_path_from_idx(struct hda_codec *codec, int path_idx)
 
 static int hda_gen_mixer_mute_put(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_value *ucontrol);
+static int hda_gen_bind_mute_put(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol);
 
 enum {
 	HDA_CTL_WIDGET_VOL,
@@ -833,7 +835,13 @@ static const struct snd_kcontrol_new control_templates[] = {
 		.put = hda_gen_mixer_mute_put, /* replaced */
 		.private_value = HDA_COMPOSE_AMP_VAL(0, 3, 0, 0),
 	},
-	HDA_BIND_MUTE(NULL, 0, 0, 0),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.info = snd_hda_mixer_amp_switch_info,
+		.get = snd_hda_mixer_bind_switch_get,
+		.put = hda_gen_bind_mute_put, /* replaced */
+		.private_value = HDA_COMPOSE_AMP_VAL(0, 3, 0, 0),
+	},
 };
 
 /* add dynamic controls from template */
@@ -940,8 +948,8 @@ static int add_stereo_sw(struct hda_codec *codec, const char *pfx,
 }
 
 /* playback mute control with the software mute bit check */
-static int hda_gen_mixer_mute_put(struct snd_kcontrol *kcontrol,
-				  struct snd_ctl_elem_value *ucontrol)
+static void sync_auto_mute_bits(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct hda_gen_spec *spec = codec->spec;
@@ -952,10 +960,22 @@ static int hda_gen_mixer_mute_put(struct snd_kcontrol *kcontrol,
 		ucontrol->value.integer.value[0] &= enabled;
 		ucontrol->value.integer.value[1] &= enabled;
 	}
+}
 
+static int hda_gen_mixer_mute_put(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	sync_auto_mute_bits(kcontrol, ucontrol);
 	return snd_hda_mixer_amp_switch_put(kcontrol, ucontrol);
 }
 
+static int hda_gen_bind_mute_put(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	sync_auto_mute_bits(kcontrol, ucontrol);
+	return snd_hda_mixer_bind_switch_put(kcontrol, ucontrol);
+}
+
 /* any ctl assigned to the path with the given index? */
 static bool path_has_mixer(struct hda_codec *codec, int path_idx, int ctl_type)
 {
-- 
1.8.3.1
