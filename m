From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Fix inconsistent
	monitor_present state until repoll
Date: Wed, 13 Apr 2016 17:01:58 +0200
Message-ID: <1460559718-17956-2-git-send-email-tiwai@suse.de>
References: <1460559718-17956-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 48896264FF9
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2016 17:02:00 +0200 (CEST)
In-Reply-To: <1460559718-17956-1-git-send-email-tiwai@suse.de>
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
Cc: Hyungwon Hwang <hyungwon.hwang7@gmail.com>
List-Id: alsa-devel@alsa-project.org

While the previous commit fixed the missing monitor_present flag
update, it may be still in an inconsistent state while the driver
repolls: the flag itself is updated, but the eld_valid flag and the
contents don't follow until the repoll finishes (and may be repeated
for a few times).

The basic problem is that pin_eld->monitor_present is updated in the
caller side.  This should have been updated only in update_eld().  So,
the proper fix is to avoid accessing pin_eld but only spec->temp_eld.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 9de114df270b..c83c1a8d9742 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1396,7 +1396,6 @@ static bool hdmi_present_sense_via_verbs(struct hdmi_spec_per_pin *per_pin,
 	struct hda_codec *codec = per_pin->codec;
 	struct hdmi_spec *spec = codec->spec;
 	struct hdmi_eld *eld = &spec->temp_eld;
-	struct hdmi_eld *pin_eld = &per_pin->sink_eld;
 	hda_nid_t pin_nid = per_pin->pin_nid;
 	/*
 	 * Always execute a GetPinSense verb here, even when called from
@@ -1413,17 +1412,15 @@ static bool hdmi_present_sense_via_verbs(struct hdmi_spec_per_pin *per_pin,
 	present = snd_hda_pin_sense(codec, pin_nid);
 
 	mutex_lock(&per_pin->lock);
-	pin_eld->monitor_present = !!(present & AC_PINSENSE_PRESENCE);
-	eld->monitor_present = pin_eld->monitor_present;
-
-	if (pin_eld->monitor_present)
+	eld->monitor_present = !!(present & AC_PINSENSE_PRESENCE);
+	if (eld->monitor_present)
 		eld->eld_valid  = !!(present & AC_PINSENSE_ELDV);
 	else
 		eld->eld_valid = false;
 
 	codec_dbg(codec,
 		"HDMI status: Codec=%d Pin=%d Presence_Detect=%d ELD_Valid=%d\n",
-		codec->addr, pin_nid, pin_eld->monitor_present, eld->eld_valid);
+		codec->addr, pin_nid, eld->monitor_present, eld->eld_valid);
 
 	if (eld->eld_valid) {
 		if (spec->ops.pin_get_eld(codec, pin_nid, eld->eld_buffer,
@@ -1443,7 +1440,7 @@ static bool hdmi_present_sense_via_verbs(struct hdmi_spec_per_pin *per_pin,
 	else
 		update_eld(codec, per_pin, eld);
 
-	ret = !repoll || !pin_eld->monitor_present || pin_eld->eld_valid;
+	ret = !repoll || !eld->monitor_present || eld->eld_valid;
 
 	jack = snd_hda_jack_tbl_get(codec, pin_nid);
 	if (jack)
-- 
2.8.1
