From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/5] ALSA: hda - Rewrite the mute-LED control
	with vmaster hook for ALC269
Date: Mon, 12 Mar 2012 15:28:49 +0100
Message-ID: <1331562530-16044-5-git-send-email-tiwai@suse.de>
References: <1331562530-16044-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F5C4104263
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 15:30:00 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 68218920F7
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 15:30:00 +0100 (CET)
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

We've had ugly static handling of the mute-LED with a powersave hook
for ALC269 HP laptops just like done in patch_sigmatel.c.  This is now
rewritten with the new vmaster hook and a fixup code.

For that, the new fixup action, ALC_FIXUP_ACT_BUILD, is introduced.
It's called after build_controls is called.  The reason of this new
action is that vmaster hook must be added at this stage (not in init
or probe).

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |   82 ++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 38 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1de0c16..9015472 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -198,6 +198,7 @@ struct alc_spec {
 
 	/* for virtual master */
 	hda_nid_t vmaster_nid;
+	struct snd_kcontrol *vmaster_sw_kctl;
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	struct hda_loopback_check loopback;
 	int num_loopbacks;
@@ -1441,6 +1442,7 @@ enum {
 	ALC_FIXUP_ACT_PRE_PROBE,
 	ALC_FIXUP_ACT_PROBE,
 	ALC_FIXUP_ACT_INIT,
+	ALC_FIXUP_ACT_BUILD,
 };
 
 static void alc_apply_fixup(struct hda_codec *codec, int action)
@@ -1955,9 +1957,10 @@ static int __alc_build_controls(struct hda_codec *codec)
 	}
 	if (!spec->no_analog &&
 	    !snd_hda_find_mixer_ctl(codec, "Master Playback Switch")) {
-		err = snd_hda_add_vmaster(codec, "Master Playback Switch",
-					  NULL, alc_slave_pfxs,
-					  "Playback Switch");
+		err = __snd_hda_add_vmaster(codec, "Master Playback Switch",
+					    NULL, alc_slave_pfxs,
+					    "Playback Switch",
+					    true, &spec->vmaster_sw_kctl);
 		if (err < 0)
 			return err;
 	}
@@ -2042,7 +2045,11 @@ static int alc_build_controls(struct hda_codec *codec)
 	int err = __alc_build_controls(codec);
 	if (err < 0)
 		return err;
-	return snd_hda_jack_add_kctls(codec, &spec->autocfg);
+	err = snd_hda_jack_add_kctls(codec, &spec->autocfg);
+	if (err < 0)
+		return err;
+	alc_apply_fixup(codec, ALC_FIXUP_ACT_BUILD);
+	return 0;
 }
 
 
@@ -5721,35 +5728,6 @@ static const struct hda_pcm_stream alc269_44k_pcm_analog_capture = {
 	/* NID is set in alc_build_pcms */
 };
 
-#ifdef CONFIG_SND_HDA_POWER_SAVE
-static int alc269_mic2_for_mute_led(struct hda_codec *codec)
-{
-	switch (codec->subsystem_id) {
-	case 0x103c1586:
-		return 1;
-	}
-	return 0;
-}
-
-static int alc269_mic2_mute_check_ps(struct hda_codec *codec, hda_nid_t nid)
-{
-	/* update mute-LED according to the speaker mute state */
-	if (nid == 0x01 || nid == 0x14) {
-		int pinval;
-		if (snd_hda_codec_amp_read(codec, 0x14, 0, HDA_OUTPUT, 0) &
-		    HDA_AMP_MUTE)
-			pinval = 0x24;
-		else
-			pinval = 0x20;
-		/* mic2 vref pin is used for mute LED control */
-		snd_hda_codec_update_cache(codec, 0x19, 0,
-					   AC_VERB_SET_PIN_WIDGET_CONTROL,
-					   pinval);
-	}
-	return alc_check_power_status(codec, nid);
-}
-#endif /* CONFIG_SND_HDA_POWER_SAVE */
-
 /* different alc269-variants */
 enum {
 	ALC269_TYPE_ALC269VA,
@@ -5900,6 +5878,33 @@ static void alc269_fixup_quanta_mute(struct hda_codec *codec,
 	spec->automute_hook = alc269_quanta_automute;
 }
 
+/* update mute-LED according to the speaker mute state via mic2 VREF pin */
+static void alc269_fixup_mic2_mute_hook(void *private_data, int enabled)
+{
+	struct hda_codec *codec = private_data;
+	unsigned int pinval = enabled ? 0x20 : 0x24;
+	snd_hda_codec_update_cache(codec, 0x19, 0,
+				   AC_VERB_SET_PIN_WIDGET_CONTROL,
+				   pinval);
+}
+
+static void alc269_fixup_mic2_mute(struct hda_codec *codec,
+				   const struct alc_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+	switch (action) {
+	case ALC_FIXUP_ACT_BUILD:
+		if (!spec->vmaster_sw_kctl)
+			return;
+		snd_ctl_add_vmaster_hook(spec->vmaster_sw_kctl,
+					 alc269_fixup_mic2_mute_hook, codec);
+		/* fallthru */
+	case ALC_FIXUP_ACT_INIT:
+		snd_ctl_sync_vmaster_hook(spec->vmaster_sw_kctl);
+		break;
+	}
+}
+
 enum {
 	ALC269_FIXUP_SONY_VAIO,
 	ALC275_FIXUP_SONY_VAIO_GPIO2,
@@ -5917,6 +5922,7 @@ enum {
 	ALC269_FIXUP_DMIC,
 	ALC269VB_FIXUP_AMIC,
 	ALC269VB_FIXUP_DMIC,
+	ALC269_FIXUP_MIC2_MUTE_LED,
 };
 
 static const struct alc_fixup alc269_fixups[] = {
@@ -6037,9 +6043,14 @@ static const struct alc_fixup alc269_fixups[] = {
 			{ }
 		},
 	},
+	[ALC269_FIXUP_MIC2_MUTE_LED] = {
+		.type = ALC_FIXUP_FUNC,
+		.v.func = alc269_fixup_mic2_mute,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
+	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_MIC2_MUTE_LED),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
@@ -6231,11 +6242,6 @@ static int patch_alc269(struct hda_codec *codec)
 #endif
 	spec->shutup = alc269_shutup;
 
-#ifdef CONFIG_SND_HDA_POWER_SAVE
-	if (alc269_mic2_for_mute_led(codec))
-		codec->patch_ops.check_power_status = alc269_mic2_mute_check_ps;
-#endif
-
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
 
 	return 0;
-- 
1.7.9.2
