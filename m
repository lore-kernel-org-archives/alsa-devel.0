From: mengdong.lin@intel.com
Subject: [RFC PATCH 2/2] ALSA: hda - remove controller
	dependency on i915 power well for Baytrail/Braswell
Date: Fri, 24 Apr 2015 21:02:01 +0800
Message-ID: <9bc80cdc2de52c4181074de0de644e61cb2db3ec.1429880424.git.mengdong.lin@intel.com>
References: <4530387c0b63ccfafb5dbb3399a39b4093651c48.1429880424.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 7ADF826669C
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 14:51:24 +0200 (CEST)
In-Reply-To: <4530387c0b63ccfafb5dbb3399a39b4093651c48.1429880424.git.mengdong.lin@intel.com>
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

For Baytrail (Valleyview) and Braswell (Cherryview), not the HD-A controller
but only the display codec is in the shared power well with gfx.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index f6c3e37..ac30667 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1865,6 +1865,10 @@ static int azx_probe_continue(struct azx *chip)
 
 	/* Request power well for Haswell HDA controller and codec */
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
+		/* Baytral/Braswell controllers don't need this power */
+		if (pci->device != 0x0f04 && pci->device != 0x2284)
+			chip->need_i915_power = 1;
+
 #ifdef CONFIG_SND_HDA_I915
 		err = hda_i915_init(hda);
 		if (err < 0)
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 5f44f60..55488ee 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2335,6 +2335,9 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 		intel_haswell_fixup_enable_dp12(codec);
 	}
 
+	if (is_valleyview_plus(codec))
+		codec->need_i915_power = 1;
+
 	if (is_haswell_plus(codec) || is_valleyview_plus(codec))
 		codec->depop_delay = 0;
 
-- 
1.9.1
