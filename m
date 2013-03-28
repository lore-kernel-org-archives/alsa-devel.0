From: mengdong.lin@intel.com
Subject: [PATCH v2 2/2] ALSA: hda - bug fix on HDMI ELD debug
	message
Date: Thu, 28 Mar 2013 05:21:28 -0400
Message-ID: <1364462488-30444-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 17DD0265B79
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2013 03:14:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

This patch let ELD debug message show 'pin_eld->monitor_present' which reflects
the real pin response to verb GET_PIN_SENSE.

'eld->monitor_present' should not be used here because 'eld' is a temp
structure now and so its "monitor_present" is not set.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 78e1827..de8ac5c 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1196,7 +1196,7 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 
 	_snd_printd(SND_PR_VERBOSE,
 		"HDMI status: Codec=%d Pin=%d Presence_Detect=%d ELD_Valid=%d\n",
-		codec->addr, pin_nid, eld->monitor_present, eld->eld_valid);
+		codec->addr, pin_nid, pin_eld->monitor_present, eld->eld_valid);
 
 	if (eld->eld_valid) {
 		if (snd_hdmi_get_eld(codec, pin_nid, eld->eld_buffer,
-- 
1.7.10.4
