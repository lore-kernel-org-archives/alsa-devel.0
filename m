From: libin.yang@intel.com
Subject: [PATCH] ALSA: hda - remove controller dependency on
	i915 power well for SKL
Date: Wed,  3 Jun 2015 09:30:15 +0800
Message-ID: <1433295015-547-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A55C2657F4
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 03:38:39 +0200 (CEST)
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
Cc: Libin Yang <libin.yang@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

For SKL, only the HDMI codec is in the display power well while the
HD-A controller isn't. So the controller flag 'need_i915_power' is
not set to release the display power after probe, and the codec flag
'link_power_control" is set to request/release the display power via
bus link_power ops.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/pci/hda/hda_intel.c  | 9 +++++++--
 sound/pci/hda/patch_hdmi.c | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 391e4f8..e5597fd 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -345,6 +345,11 @@ enum {
 #define use_vga_switcheroo(chip)	0
 #endif
 
+#define CONTROLLER_IN_GPU(pci) (((pci)->device == 0x0a0c) || \
+					((pci)->device == 0x0c0c) || \
+					((pci)->device == 0x0d0c) || \
+					((pci)->device == 0x160c))
+
 static char *driver_short_names[] = {
 	[AZX_DRIVER_ICH] = "HDA Intel",
 	[AZX_DRIVER_PCH] = "HDA Intel PCH",
@@ -1976,8 +1981,8 @@ static int azx_probe_continue(struct azx *chip)
 	 * display codec needs the power and it can be released after probe.
 	 */
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL) {
-		/* Baytral/Braswell controllers don't need this power */
-		if (pci->device != 0x0f04 && pci->device != 0x2284)
+		/* HSW/BDW controllers need this power */
+		if (CONTROLLER_IN_GPU(pci))
 			hda->need_i915_power = 1;
 
 		err = snd_hdac_i915_init(bus);
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 73c20c0..407978b 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2339,7 +2339,7 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 	 * can cover the codec power request, and so need not set this flag.
 	 * For previous platforms, there is no such power well feature.
 	 */
-	if (is_valleyview_plus(codec))
+	if (is_valleyview_plus(codec) || is_skylake(codec))
 		codec->core.link_power_control = 1;
 
 	if (is_haswell_plus(codec) || is_valleyview_plus(codec))
-- 
1.9.1
