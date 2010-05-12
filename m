From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 5/5] hdmi - dont fail on extra nodes
Date: Wed, 12 May 2010 09:30:20 +0800
Message-ID: <20100512015714.216446135@intel.com>
References: <20100512013015.752623810@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id D7EF51037F7
	for <alsa-devel@alsa-project.org>;
	Wed, 12 May 2010 03:58:32 +0200 (CEST)
Content-Disposition: inline; filename=hdmi-permissive-to-extra-nodes.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

The number of HDMI nodes is expected to go up in future.
So don't fail hard on seeing extra converter/pin nodes.

We can still operate safely on the nodes within
MAX_HDMI_CVTS/MAX_HDMI_PINS.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_hdmi.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_hdmi.c	2010-05-11 13:25:35.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_hdmi.c	2010-05-11 13:53:47.000000000 +0800
@@ -766,7 +766,7 @@ static int hdmi_add_pin(struct hda_codec
 	if (spec->num_pins >= MAX_HDMI_PINS) {
 		snd_printk(KERN_WARNING
 			   "HDMI: no space for pin %d\n", pin_nid);
-		return -EINVAL;
+		return -E2BIG;
 	}
 
 	hdmi_present_sense(codec, pin_nid, &spec->sink_eld[spec->num_pins]);
@@ -788,7 +788,7 @@ static int hdmi_add_cvt(struct hda_codec
 	if (spec->num_cvts >= MAX_HDMI_CVTS) {
 		snd_printk(KERN_WARNING
 			   "HDMI: no space for converter %d\n", nid);
-		return -EINVAL;
+		return -E2BIG;
 	}
 
 	spec->cvt[spec->num_cvts] = nid;
@@ -820,15 +820,13 @@ static int hdmi_parse_codec(struct hda_c
 
 		switch (type) {
 		case AC_WID_AUD_OUT:
-			if (hdmi_add_cvt(codec, nid) < 0)
-				return -EINVAL;
+			hdmi_add_cvt(codec, nid);
 			break;
 		case AC_WID_PIN:
 			caps = snd_hda_param_read(codec, nid, AC_PAR_PIN_CAP);
 			if (!(caps & (AC_PINCAP_HDMI | AC_PINCAP_DP)))
 				continue;
-			if (hdmi_add_pin(codec, nid) < 0)
-				return -EINVAL;
+			hdmi_add_pin(codec, nid);
 			break;
 		}
 	}
