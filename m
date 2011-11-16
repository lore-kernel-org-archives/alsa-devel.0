From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 3/3] hda - move eld->spk_alloc fixup to
	hdmi_update_eld()
Date: Wed, 16 Nov 2011 16:29:48 +0800
Message-ID: <20111116083514.691170417@intel.com>
References: <20111116082945.414733231@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id DF60B243B2
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 09:39:12 +0100 (CET)
Content-Disposition: inline; filename=eld-move-spk
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
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

It looks more natural and saves two lines of code.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_eld.c    |    8 ++++++++
 sound/pci/hda/patch_hdmi.c |   10 ----------
 2 files changed, 8 insertions(+), 10 deletions(-)

--- linux.orig/sound/pci/hda/hda_eld.c	2011-11-16 09:53:01.000000000 +0800
+++ linux/sound/pci/hda/hda_eld.c	2011-11-16 10:05:06.000000000 +0800
@@ -297,6 +297,14 @@ static int hdmi_update_eld(struct hdmi_e
 					buf + ELD_FIXED_BYTES + mnl + 3 * i);
 	}
 
+	/*
+	 * HDMI sink's ELD info cannot always be retrieved for now, e.g.
+	 * in console or for audio devices. Assume the highest speakers
+	 * configuration, to _not_ prohibit multi-channel audio playback.
+	 */
+	if (!e->spk_alloc)
+		e->spk_alloc = 0xffff;
+
 	e->eld_valid = true;
 	return 0;
 
--- linux.orig/sound/pci/hda/patch_hdmi.c	2011-11-16 10:04:13.000000000 +0800
+++ linux/sound/pci/hda/patch_hdmi.c	2011-11-16 10:05:54.000000000 +0800
@@ -757,7 +757,6 @@ static void hdmi_intrinsic_event(struct 
 	int pd = !!(res & AC_UNSOL_RES_PD);
 	int eldv = !!(res & AC_UNSOL_RES_ELDV);
 	int pin_idx;
-	struct hdmi_eld *eld;
 
 	printk(KERN_INFO
 		"HDMI hot plug event: Codec=%d Pin=%d Presence_Detect=%d ELD_Valid=%d\n",
@@ -766,17 +765,8 @@ static void hdmi_intrinsic_event(struct 
 	pin_idx = pin_nid_to_pin_index(spec, pin_nid);
 	if (pin_idx < 0)
 		return;
-	eld = &spec->pins[pin_idx].sink_eld;
 
 	hdmi_present_sense(&spec->pins[pin_idx], true);
-
-	/*
-	 * HDMI sink's ELD info cannot always be retrieved for now, e.g.
-	 * in console or for audio devices. Assume the highest speakers
-	 * configuration, to _not_ prohibit multi-channel audio playback.
-	 */
-	if (!eld->spk_alloc)
-		eld->spk_alloc = 0xffff;
 }
 
 static void hdmi_non_intrinsic_event(struct hda_codec *codec, unsigned int res)
