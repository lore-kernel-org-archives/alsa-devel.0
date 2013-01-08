From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 035/112] ALSA: hda/realtek - Handle vmaster
	hook in the parser side
Date: Tue,  8 Jan 2013 12:38:28 +0100
Message-ID: <1357645185-7645-36-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E7DA2651B4
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id AC3C5A5230
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

... so that the fixup just needs to set the hook function in
FIXUP_ACT_PROBE.  This will make easier to port for other codecs,
too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f5696ab..579a35e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1687,6 +1687,8 @@ static int __alc_build_controls(struct hda_codec *codec)
 					    true, &spec->vmaster_mute.sw_kctl);
 		if (err < 0)
 			return err;
+		if (spec->vmaster_mute.hook)
+			snd_hda_add_vmaster_hook(codec, &spec->vmaster_mute, true);
 	}
 
 	alc_free_kctls(codec); /* no longer needed */
@@ -1745,6 +1747,9 @@ static int alc_init(struct hda_codec *codec)
 	snd_hda_gen_apply_verbs(codec);
 	alc_auto_init_std(codec);
 
+	if (spec->vmaster_mute.sw_kctl && spec->vmaster_mute.hook)
+		snd_hda_sync_vmaster_hook(&spec->vmaster_mute);
+
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_INIT);
 
 	hda_call_check_power_status(codec, 0x01);
@@ -6019,15 +6024,8 @@ static void alc269_fixup_mic1_mute(struct hda_codec *codec,
 				   const struct alc_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
-	switch (action) {
-	case ALC_FIXUP_ACT_BUILD:
+	if (action == ALC_FIXUP_ACT_PROBE)
 		spec->vmaster_mute.hook = alc269_fixup_mic1_mute_hook;
-		snd_hda_add_vmaster_hook(codec, &spec->vmaster_mute, true);
-		/* fallthru */
-	case ALC_FIXUP_ACT_INIT:
-		snd_hda_sync_vmaster_hook(&spec->vmaster_mute);
-		break;
-	}
 }
 
 /* update mute-LED according to the speaker mute state via mic2 VREF pin */
@@ -6042,15 +6040,8 @@ static void alc269_fixup_mic2_mute(struct hda_codec *codec,
 				   const struct alc_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
-	switch (action) {
-	case ALC_FIXUP_ACT_BUILD:
+	if (action == ALC_FIXUP_ACT_PROBE)
 		spec->vmaster_mute.hook = alc269_fixup_mic2_mute_hook;
-		snd_hda_add_vmaster_hook(codec, &spec->vmaster_mute, true);
-		/* fallthru */
-	case ALC_FIXUP_ACT_INIT:
-		snd_hda_sync_vmaster_hook(&spec->vmaster_mute);
-		break;
-	}
 }
 
 static void alc271_hp_gate_mic_jack(struct hda_codec *codec,
-- 
1.8.0.1
