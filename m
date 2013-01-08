From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 067/112] ALSA: hda - Add
	spec->vmaster_mute_enum flag to generic parser
Date: Tue,  8 Jan 2013 12:39:00 +0100
Message-ID: <1357645185-7645-68-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 46065265201
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 60F44A52FB
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
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

Add a flag to indicate whether the vmaster mute hook enum is exposed
or not.  Conexant codecs may want not to expose the control depending
on the model.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c   | 3 ++-
 sound/pci/hda/hda_generic.h   | 1 +
 sound/pci/hda/patch_realtek.c | 8 ++++++--
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 6fb454e..a5c4bc0 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2966,7 +2966,8 @@ int snd_hda_gen_build_controls(struct hda_codec *codec)
 		if (err < 0)
 			return err;
 		if (spec->vmaster_mute.hook)
-			snd_hda_add_vmaster_hook(codec, &spec->vmaster_mute, true);
+			snd_hda_add_vmaster_hook(codec, &spec->vmaster_mute,
+						 spec->vmaster_mute_enum);
 	}
 
 	free_kctls(spec); /* no longer needed */
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index b598899..a406cd4 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -151,6 +151,7 @@ struct hda_gen_spec {
 	unsigned int multi_cap_vol:1; /* allow multiple capture xxx volumes */
 	unsigned int inv_dmic_split:1; /* inverted dmic w/a for conexant */
 	unsigned int own_eapd_ctl:1; /* set EAPD by own function */
+	unsigned int vmaster_mute_enum:1; /* add vmaster mute mode enum */
 
 	/* for virtual master */
 	hda_nid_t vmaster_nid;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0b32729..1c343f2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2672,8 +2672,10 @@ static void alc269_fixup_mic1_mute(struct hda_codec *codec,
 				   const struct alc_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
-	if (action == ALC_FIXUP_ACT_PROBE)
+	if (action == ALC_FIXUP_ACT_PROBE) {
 		spec->gen.vmaster_mute.hook = alc269_fixup_mic1_mute_hook;
+		spec->gen.vmaster_mute_enum = 1;
+	}
 }
 
 /* update mute-LED according to the speaker mute state via mic2 VREF pin */
@@ -2688,8 +2690,10 @@ static void alc269_fixup_mic2_mute(struct hda_codec *codec,
 				   const struct alc_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
-	if (action == ALC_FIXUP_ACT_PROBE)
+	if (action == ALC_FIXUP_ACT_PROBE) {
 		spec->gen.vmaster_mute.hook = alc269_fixup_mic2_mute_hook;
+		spec->gen.vmaster_mute_enum = 1;
+	}
 }
 
 static void alc271_hp_gate_mic_jack(struct hda_codec *codec,
-- 
1.8.0.1
