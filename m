From: Hyungwon Hwang <hyungwon.hwang7@gmail.com>
Subject: [PATCH] ALSA: hda - Update HDMI monitor_present from a
	temporary structure
Date: Wed, 13 Apr 2016 09:27:39 +0900
Message-ID: <1460507259-6589-1-git-send-email-hyungwon.hwang7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 077A52650DB
 for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2016 02:27:48 +0200 (CEST)
Received: by mail-pf0-f193.google.com with SMTP id e190so2573791pfe.0
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 17:27:47 -0700 (PDT)
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

pin_eld is a temporary structure. So before calling update_eld(),
eld should be updated from pin_eld.

Signed-off-by: Hyungwon Hwang <hyungwon.hwang7@gmail.com>
---
 sound/pci/hda/patch_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 5af372d..9de114d 100644
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
2.5.5
