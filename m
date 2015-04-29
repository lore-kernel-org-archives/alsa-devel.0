From: mengdong.lin@intel.com
Subject: [PATCH v3 5/5] ALSA: hda - remove controller
	dependency on i915 power well for Baytrail/Braswell
Date: Wed, 29 Apr 2015 17:43:43 +0800
Message-ID: <bbe7e7b69f8552c6ad3836924f4e700c52afb3fa.1430300071.git.mengdong.lin@intel.com>
References: <cover.1430300071.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id DD1E22604C6
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 11:32:58 +0200 (CEST)
In-Reply-To: <cover.1430300071.git.mengdong.lin@intel.com>
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

For Baytrail (Valleyview) and Braswell (Cherryview), only the HDMI codec is
in the display power well while the HD-A controller isn't. So the controller
flag 'need_i915_power' is not set to release the display power after probe,
and the codec flag 'link_power_control" is set to request/release the display
power via bus link_power ops.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 98e721b..f8b574b 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1903,8 +1903,10 @@ static int azx_probe_continue(struct azx *chip)
 	 * display codec needs the power and it can be released after probe.
 	 */
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
-		/* Assume the controller needs the power by default */
-		hda->need_i915_power = 1;
+		/* Baytral/Braswell controllers don't need this power */
+		if (pci->device != 0x0f04 && pci->device != 0x2284)
+			hda->need_i915_power = 1;
+
 
 #ifdef CONFIG_SND_HDA_I915
 		err = hda_i915_init(hda);
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 5f44f60..a8016e1 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2335,6 +2335,15 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 		intel_haswell_fixup_enable_dp12(codec);
 	}
 
+	/* For Valleyview/Cherryview, only the display codec is in the display
+	 * power well and can use link_power ops to request/release the power.
+	 * For Haswell/Broadwell, the controller is also in the power well and
+	 * can cover the codec power request, and so need not set this flag.
+	 * For previous platforms, there is no such power well feature.
+	 */
+	if (is_valleyview_plus(codec))
+		codec->core.link_power_control = 1;
+
 	if (is_haswell_plus(codec) || is_valleyview_plus(codec))
 		codec->depop_delay = 0;
 
-- 
1.9.1
