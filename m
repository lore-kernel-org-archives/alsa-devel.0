From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 045/112] ALSA: hda/realtek - Remove redundant
	argument from alc_mux_select()
Date: Tue,  8 Jan 2013 12:38:38 +0100
Message-ID: <1357645185-7645-46-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B1BA2651C3
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id DA3BAA5255
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:22 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

The argument "force" is always false in the recent code.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2aaecdc..2240ab6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -360,7 +360,7 @@ static void update_shared_mic_hp(struct hda_codec *codec, bool set_as_mic)
 
 /* select the given imux item; either unmute exclusively or select the route */
 static int alc_mux_select(struct hda_codec *codec, unsigned int adc_idx,
-			  unsigned int idx, bool force)
+			  unsigned int idx)
 {
 	struct alc_spec *spec = codec->spec;
 	const struct hda_input_mux *imux;
@@ -372,7 +372,7 @@ static int alc_mux_select(struct hda_codec *codec, unsigned int adc_idx,
 
 	if (idx >= imux->num_items)
 		idx = imux->num_items - 1;
-	if (spec->cur_mux[adc_idx] == idx && !force)
+	if (spec->cur_mux[adc_idx] == idx)
 		return 0;
 
 	path = get_nid_path(codec, spec->imux_pins[spec->cur_mux[adc_idx]],
@@ -407,7 +407,7 @@ static int alc_mux_enum_put(struct snd_kcontrol *kcontrol,
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	unsigned int adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
 	return alc_mux_select(codec, adc_idx,
-			      ucontrol->value.enumerated.item[0], false);
+			      ucontrol->value.enumerated.item[0]);
 }
 
 /*
@@ -624,11 +624,11 @@ static void alc_mic_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
 
 	for (i = spec->am_num_entries - 1; i > 0; i--) {
 		if (snd_hda_jack_detect(codec, spec->am_entry[i].pin)) {
-			alc_mux_select(codec, 0, spec->am_entry[i].idx, false);
+			alc_mux_select(codec, 0, spec->am_entry[i].idx);
 			return;
 		}
 	}
-	alc_mux_select(codec, 0, spec->am_entry[0].idx, false);
+	alc_mux_select(codec, 0, spec->am_entry[0].idx);
 }
 
 /* update the master volume per volume-knob's unsol event */
-- 
1.8.0.1
