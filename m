From: Hyungwon Hwang <hyungwon.hwang7@gmail.com>
Subject: [PATCH] ALSA: hda - Remove temporary buffer for ELD
	update
Date: Tue, 12 Apr 2016 02:10:51 +0900
Message-ID: <1460394651-2519-1-git-send-email-hyungwon.hwang7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 873D9265451
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 19:11:00 +0200 (CEST)
Received: by mail-pa0-f47.google.com with SMTP id td3so124905007pab.2
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 10:11:00 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc: Hyungwon Hwang <hyungwon.hwang7@gmail.com>
List-Id: alsa-devel@alsa-project.org

With the introduce of pcm_lock and per_pin->lock, this temporary buffer
is not needed anymore.

Signed-off-by: Hyungwon Hwang <hyungwon.hwang7@gmail.com>
---
 sound/pci/hda/patch_hdmi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 5af372d..a24d5b4 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1395,8 +1395,7 @@ static bool hdmi_present_sense_via_verbs(struct hdmi_spec_per_pin *per_pin,
 	struct hda_jack_tbl *jack;
 	struct hda_codec *codec = per_pin->codec;
 	struct hdmi_spec *spec = codec->spec;
-	struct hdmi_eld *eld = &spec->temp_eld;
-	struct hdmi_eld *pin_eld = &per_pin->sink_eld;
+	struct hdmi_eld *eld = &per_pin->sink_eld;
 	hda_nid_t pin_nid = per_pin->pin_nid;
 	/*
 	 * Always execute a GetPinSense verb here, even when called from
@@ -1413,15 +1412,15 @@ static bool hdmi_present_sense_via_verbs(struct hdmi_spec_per_pin *per_pin,
 	present = snd_hda_pin_sense(codec, pin_nid);
 
 	mutex_lock(&per_pin->lock);
-	pin_eld->monitor_present = !!(present & AC_PINSENSE_PRESENCE);
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
@@ -1441,7 +1440,7 @@ static bool hdmi_present_sense_via_verbs(struct hdmi_spec_per_pin *per_pin,
 	else
 		update_eld(codec, per_pin, eld);
 
-	ret = !repoll || !pin_eld->monitor_present || pin_eld->eld_valid;
+	ret = !repoll || !eld->monitor_present || eld->eld_valid;
 
 	jack = snd_hda_jack_tbl_get(codec, pin_nid);
 	if (jack)
-- 
2.5.0
