From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/5] ALSA: hda - Activate Capture Source
	selection only when auto_mic=0
Date: Fri, 30 Nov 2012 09:16:03 +0100
Message-ID: <1354263363-25398-6-git-send-email-tiwai@suse.de>
References: <1354202489-12769-1-git-send-email-tiwai@suse.de>
 <1354263363-25398-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F068265B7D
 for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2012 09:16:22 +0100 (CET)
In-Reply-To: <1354263363-25398-1-git-send-email-tiwai@suse.de>
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
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

When the auto-mic mode is enabled, changing the input source
externally conflicts with the automatic selection mechanism.
Make the control inactive when auto mic is set.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b3612a4..3236645 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -347,6 +347,11 @@ static void update_shared_mic_hp(struct hda_codec *codec, bool set_as_mic)
 	call_update_outputs(codec);
 }
 
+static struct snd_ctl_elem_id capture_source_id = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Capture Source"
+};
+
 /* select the given imux item; either unmute exclusively or select the route */
 static int alc_mux_select(struct hda_codec *codec, unsigned int adc_idx,
 			  unsigned int idx, bool force, bool notify)
@@ -406,12 +411,8 @@ static int alc_mux_select(struct hda_codec *codec, unsigned int adc_idx,
 	alc_inv_dmic_sync(codec, true);
 
 	if (notify) {
-		struct snd_ctl_elem_id id;
-		memset(&id, 0, sizeof(id));
-		id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-		strcpy(id.name, "Capture Source");
 		snd_ctl_notify(codec->bus->card, SNDRV_CTL_EVENT_MASK_VALUE,
-			       &id);
+			       &capture_source_id);
 	}
 
 	return 1;
@@ -703,9 +704,13 @@ static void alc880_unsol_event(struct hda_codec *codec, unsigned int res)
 /* call init functions of standard auto-mute helpers */
 static void alc_inithook(struct hda_codec *codec)
 {
+	struct alc_spec *spec = codec->spec;
 	alc_hp_automute(codec, NULL);
 	alc_line_automute(codec, NULL);
 	alc_mic_automute(codec, NULL);
+	if (spec->auto_mic_valid_imux)
+		snd_ctl_activate_id(codec->bus->card, &capture_source_id,
+				    !spec->auto_mic);
 }
 
 /* additional initialization for ALC888 variants */
@@ -964,6 +969,7 @@ static int alc_automic_mode_put(struct snd_kcontrol *kcontrol,
 		return 0;
 	spec->auto_mic = val;
 	alc_mic_automute(codec, NULL);
+	snd_ctl_activate_id(codec->bus->card, &capture_source_id, !val);
 	return 1;
 }
 
-- 
1.8.0.1
