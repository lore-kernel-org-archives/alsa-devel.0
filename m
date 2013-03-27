From: mengdong.lin@intel.com
Subject: [PATCH] ALSA: hda - bug fix on return value when
	getting HDMI ELD info
Date: Wed, 27 Mar 2013 09:37:26 -0400
Message-ID: <1364391446-23883-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F538264F13
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2013 07:30:44 +0100 (CET)
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

In function snd_hdmi_get_eld(), the variable 'ret' should be initialized to 0.
Otherwise it will be returned uninitialized as non-zero after ELD info is got
successfully. Thus hdmi_present_sense() will always assume ELD info is invalid
by mistake, and /proc file system cannot show the proper ELD info.

This patch also let debug message show 'pin_eld->monitor_present' which is the
real pin response to verb GET_PIN_SENSE.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index 7dd8463..d0d7ac1 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -320,7 +320,7 @@ int snd_hdmi_get_eld(struct hda_codec *codec, hda_nid_t nid,
 		     unsigned char *buf, int *eld_size)
 {
 	int i;
-	int ret;
+	int ret = 0;
 	int size;
 
 	/*
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
