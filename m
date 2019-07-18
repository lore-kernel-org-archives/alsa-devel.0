From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda/hdmi - Don't report spurious
	jack state changes
Date: Thu, 18 Jul 2019 11:43:20 +0200
Message-ID: <20190718094321.16442-2-tiwai@suse.de>
References: <20190718094321.16442-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F41FF802BC
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2019 11:43:24 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 9AFC2AD35
 for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2019 09:43:24 +0000 (UTC)
In-Reply-To: <20190718094321.16442-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The HDMI jack handling reports the state change always via
snd_jack_report() whenever hdmi_present_sense() is called, even if the
state itself doesn't change from the previous time.  This is mostly
harmless but still a big confusing to user-space.

This patch reduces such spurious jack state changes and reports only
when the state really changed.  Also, as a minor optimization, avoid
overwriting the pin ELD data when the state is identical.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index bea7b0961080..c380596b2e84 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1421,7 +1421,7 @@ static void hdmi_pcm_reset_pin(struct hdmi_spec *spec,
 /* update per_pin ELD from the given new ELD;
  * setup info frame and notification accordingly
  */
-static void update_eld(struct hda_codec *codec,
+static bool update_eld(struct hda_codec *codec,
 		       struct hdmi_spec_per_pin *per_pin,
 		       struct hdmi_eld *eld)
 {
@@ -1452,18 +1452,22 @@ static void update_eld(struct hda_codec *codec,
 		snd_hdmi_show_eld(codec, &eld->info);
 
 	eld_changed = (pin_eld->eld_valid != eld->eld_valid);
-	if (eld->eld_valid && pin_eld->eld_valid)
+	eld_changed |= (pin_eld->monitor_present != eld->monitor_present);
+	if (!eld_changed && eld->eld_valid && pin_eld->eld_valid)
 		if (pin_eld->eld_size != eld->eld_size ||
 		    memcmp(pin_eld->eld_buffer, eld->eld_buffer,
 			   eld->eld_size) != 0)
 			eld_changed = true;
 
-	pin_eld->monitor_present = eld->monitor_present;
-	pin_eld->eld_valid = eld->eld_valid;
-	pin_eld->eld_size = eld->eld_size;
-	if (eld->eld_valid)
-		memcpy(pin_eld->eld_buffer, eld->eld_buffer, eld->eld_size);
-	pin_eld->info = eld->info;
+	if (eld_changed) {
+		pin_eld->monitor_present = eld->monitor_present;
+		pin_eld->eld_valid = eld->eld_valid;
+		pin_eld->eld_size = eld->eld_size;
+		if (eld->eld_valid)
+			memcpy(pin_eld->eld_buffer, eld->eld_buffer,
+			       eld->eld_size);
+		pin_eld->info = eld->info;
+	}
 
 	/*
 	 * Re-setup pin and infoframe. This is needed e.g. when
@@ -1481,6 +1485,7 @@ static void update_eld(struct hda_codec *codec,
 			       SNDRV_CTL_EVENT_MASK_VALUE |
 			       SNDRV_CTL_EVENT_MASK_INFO,
 			       &get_hdmi_pcm(spec, pcm_idx)->eld_ctl->id);
+	return eld_changed;
 }
 
 /* update ELD and jack state via HD-audio verbs */
@@ -1582,6 +1587,7 @@ static void sync_eld_via_acomp(struct hda_codec *codec,
 	struct hdmi_spec *spec = codec->spec;
 	struct hdmi_eld *eld = &spec->temp_eld;
 	struct snd_jack *jack = NULL;
+	bool changed;
 	int size;
 
 	mutex_lock(&per_pin->lock);
@@ -1608,15 +1614,13 @@ static void sync_eld_via_acomp(struct hda_codec *codec,
 	 * disconnected event. Jack must be fetched before update_eld()
 	 */
 	jack = pin_idx_to_jack(codec, per_pin);
-	update_eld(codec, per_pin, eld);
+	changed = update_eld(codec, per_pin, eld);
 	if (jack == NULL)
 		jack = pin_idx_to_jack(codec, per_pin);
-	if (jack == NULL)
-		goto unlock;
-	snd_jack_report(jack,
-			(eld->monitor_present && eld->eld_valid) ?
+	if (changed && jack)
+		snd_jack_report(jack,
+				(eld->monitor_present && eld->eld_valid) ?
 				SND_JACK_AVOUT : 0);
- unlock:
 	mutex_unlock(&per_pin->lock);
 }
 
-- 
2.16.4
