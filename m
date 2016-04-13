From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Fix regression of
	monitor_present flag in eld proc file
Date: Wed, 13 Apr 2016 17:01:57 +0200
Message-ID: <1460559718-17956-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4817B264ED5
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2016 17:02:00 +0200 (CEST)
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

From: Hyungwon Hwang <hyungwon.hwang7@gmail.com>

The commit [bd48128539ab: ALSA: hda - Fix forgotten HDMI
monitor_present update] covered the missing update of monitor_present
flag, but this caused a regression for devices without the i915 eld
notifier.  Since the old code supposed that pin_eld->monitor_present
was updated by the caller side, the hdmi_present_sense_via_verbs()
doesn't update the temporary eld->monitor_present but only
pin_eld->monitor_present, which is now overridden in update_eld().

The fix is to update pin_eld->monitor_present as well before calling
update_eld().

Note that this may still leave monitor_present flag in an inconsistent
state when the driver repolls, but this is at least the old behavior.
More proper fix will follow in the later patch.

Fixes: bd48128539ab ('ALSA: hda - Fix forgotten HDMI monitor_present update')
Signed-off-by: Hyungwon Hwang <hyungwon.hwang7@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 5af372d01834..9de114df270b 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1414,6 +1414,8 @@ static bool hdmi_present_sense_via_verbs(struct hdmi_spec_per_pin *per_pin,
 
 	mutex_lock(&per_pin->lock);
 	pin_eld->monitor_present = !!(present & AC_PINSENSE_PRESENCE);
+	eld->monitor_present = pin_eld->monitor_present;
+
 	if (pin_eld->monitor_present)
 		eld->eld_valid  = !!(present & AC_PINSENSE_ELDV);
 	else
-- 
2.8.1
