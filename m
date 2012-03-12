From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/5] ALSA: hda - Add EAPD control to Conexnat
	auto-parser
Date: Mon, 12 Mar 2012 15:28:50 +0100
Message-ID: <1331562530-16044-6-git-send-email-tiwai@suse.de>
References: <1331562530-16044-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D02310426F
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 15:30:02 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id CDFCB934B2
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 15:30:01 +0100 (CET)
In-Reply-To: <1331562530-16044-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Added the vmaster hook for controlling EAPD dynamically to Conexant
auto-parser.  When the Master is muted, EAPDs are turned off as well.
This will fix the missing mute-LED control on some machines in
addition to the more power-saving in the auto-parser mode.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c |   36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 5a56fda..f1c9aed 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -70,6 +70,8 @@ struct conexant_spec {
 	const struct snd_kcontrol_new *mixers[5];
 	int num_mixers;
 	hda_nid_t vmaster_nid;
+	struct snd_kcontrol *vmaster_sw_kctl;
+	void (*vmaster_hook)(struct snd_kcontrol *, int);
 
 	const struct hda_verb *init_verbs[5];	/* initialization verbs
 						 * don't forget NULL
@@ -513,9 +515,10 @@ static int conexant_build_controls(struct hda_codec *codec)
 	}
 	if (spec->vmaster_nid &&
 	    !snd_hda_find_mixer_ctl(codec, "Master Playback Switch")) {
-		err = snd_hda_add_vmaster(codec, "Master Playback Switch",
-					  NULL, slave_pfxs,
-					  "Playback Switch");
+		err = __snd_hda_add_vmaster(codec, "Master Playback Switch",
+					    NULL, slave_pfxs,
+					    "Playback Switch", true,
+					    &spec->vmaster_sw_kctl);
 		if (err < 0)
 			return err;
 	}
@@ -3975,6 +3978,19 @@ static void clear_unsol_on_unused_pins(struct hda_codec *codec)
 	}
 }
 
+/* turn on/off EAPD according to Master switch */
+static void cx_auto_vmaster_hook(void *private_data, int enabled)
+{
+	struct hda_codec *codec = private_data;
+	struct conexant_spec *spec = codec->spec;
+
+	if (enabled && spec->pin_eapd_ctrls) {
+		cx_auto_update_speakers(codec);
+		return;
+	}
+	cx_auto_turn_eapd(codec, spec->num_eapds, spec->eapds, enabled);
+}
+
 static void cx_auto_init_output(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
@@ -4079,11 +4095,13 @@ static void cx_auto_init_digital(struct hda_codec *codec)
 
 static int cx_auto_init(struct hda_codec *codec)
 {
+	struct conexant_spec *spec = codec->spec;
 	/*snd_hda_sequence_write(codec, cx_auto_init_verbs);*/
 	cx_auto_init_output(codec);
 	cx_auto_init_input(codec);
 	cx_auto_init_digital(codec);
 	snd_hda_jack_report_sync(codec);
+	snd_ctl_sync_vmaster_hook(spec->vmaster_sw_kctl);
 	return 0;
 }
 
@@ -4329,6 +4347,11 @@ static int cx_auto_build_controls(struct hda_codec *codec)
 	err = snd_hda_jack_add_kctls(codec, &spec->autocfg);
 	if (err < 0)
 		return err;
+	if (spec->vmaster_hook && spec->vmaster_sw_kctl) {
+		snd_ctl_add_vmaster_hook(spec->vmaster_sw_kctl,
+					 spec->vmaster_hook, codec);
+		snd_ctl_sync_vmaster_hook(spec->vmaster_sw_kctl);
+	}
 	return 0;
 }
 
@@ -4353,7 +4376,6 @@ static int cx_auto_search_adcs(struct hda_codec *codec)
 	return 0;
 }
 
-
 static const struct hda_codec_ops cx_auto_patch_ops = {
 	.build_controls = cx_auto_build_controls,
 	.build_pcms = conexant_build_pcms,
@@ -4455,6 +4477,12 @@ static int patch_conexant_auto(struct hda_codec *codec)
 
 	apply_pin_fixup(codec, cxt_fixups, cxt_pincfg_tbl);
 
+	/* add EAPD vmaster hook to all HP machines */
+	/* NOTE: this should be applied via fixup once when the generic
+	 *       fixup code is merged to hda_codec.c
+	 */
+	spec->vmaster_hook = cx_auto_vmaster_hook;
+
 	err = cx_auto_search_adcs(codec);
 	if (err < 0)
 		return err;
-- 
1.7.9.2
