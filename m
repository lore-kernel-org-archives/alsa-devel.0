From: mengdong.lin@intel.com
Subject: [PATCH v3 3/4] ALSA: hda - Haswell codec exposes
	device list/select info on pins
Date: Mon, 26 Aug 2013 21:35:41 -0400
Message-ID: <1377567341-1215-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 43F19264EBF
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 10:34:44 +0200 (CEST)
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

This patch is only to allow codec proc file to expose devices list/select info
for Haswell codec pins.

Since Haswell Gfx driver cannot support DP1.2 MST now, so all pins' device list
is empty, meaning no pin is multi-streaming capaple.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 030ca86..87ca984 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1989,8 +1989,10 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 		return -EINVAL;
 	}
 	codec->patch_ops = generic_hdmi_patch_ops;
-	if (codec->vendor_id == 0x80862807)
+	if (codec->vendor_id == 0x80862807) {
 		codec->patch_ops.set_power_state = haswell_set_power_state;
+		codec->dp_mst = true;
+	}
 
 	generic_hdmi_init_per_pins(codec);
 
-- 
1.8.1.2
