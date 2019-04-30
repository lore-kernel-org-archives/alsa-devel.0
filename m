From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH] ALSA: hda/hdmi - Don't report Jack event if no
	need to do that
Date: Tue, 30 Apr 2019 14:57:11 +0800
Message-ID: <20190430065711.14977-1-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D1B3FF8962C
 for <alsa-devel@alsa-project.org>; Tue, 30 Apr 2019 08:57:27 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On the machines with AMD GPU or Nvidia GPU, we often meet this issues:
after s3, there are 4 HDMI/DP audio devices in the gnome-sound-setting
even there is no any monitors plugged.

When this problem happens, we check the /proc/asound/cardX/eld#N.M, we
will find the monitor_present=1, eld_valid=0.

The root cause is somehow the pin_sense reports the monitor is present
and eld is valid when there is no monitor plugged.

The current driver will read the eld data if the pin_sense reports the
eld is valid, because of no monitor is plugged, there is no valid eld
data, then the eld->valid is set to 0.

If we don't let driver report Jack event when monitor_present=1 while
eld_valid=0, there will be no this issue.

After this change, the driver only reports Jack event with one of the
below 2 conditons:
 eld->monitor_present=1 and eld->eld_valid=1 (a valid monitor detect)
 eld->monitor_present=0 (a monitor is unplugged)

Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 8b3ac690efa3..e5a34fa6f358 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1548,7 +1548,7 @@ static bool hdmi_present_sense_via_verbs(struct hdmi_spec_per_pin *per_pin,
 	else
 		update_eld(codec, per_pin, eld);
 
-	ret = !repoll || !eld->monitor_present || eld->eld_valid;
+	ret = !eld->monitor_present || eld->eld_valid;
 
 	jack = snd_hda_jack_tbl_get(codec, pin_nid);
 	if (jack)
-- 
2.17.1
