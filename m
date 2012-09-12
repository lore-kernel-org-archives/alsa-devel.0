From: Wang Xingchao <xingchao.wang@intel.com>
Subject: [PATCH] drm/i915: HDMI - Clear Audio Enable bit for
	Hot Plug
Date: Thu, 13 Sep 2012 07:43:22 +0800
Message-ID: <1347493402-2531-1-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id A453C2615E9
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 09:43:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: intel-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, daniel.vetter@ffwll.ch
Cc: tiwai@suse.de, michael.fu@intel.com, fengguang.wu@intel.com, yakui.zhao@intel.com, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

Clear Audio Enable bit to trigger unsolicated event to notify Audio
Driver part the HDMI hot plug change. The patch fixed the bug when
remove HDMI cable the bit was not cleared correctly.

In intel_hdmi_dpms(), if intel_hdmi->has_audio been true, the "Audio enable bit" will 
be set to trigger unsolicated event to notify Alsa driver the change.

intel_hdmi->has_audio will be reset to false from intel_hdmi_detect() after
remove the hdmi cable, here's debug log:

[  187.494153] [drm:output_poll_execute], [CONNECTOR:17:HDMI-A-1] status updated from 1 to 2
[  187.525349] [drm:intel_hdmi_detect], HDMI: has_audio = 0

so when comes back to intel_hdmi_dpms(), the "Audio enable bit" will not be cleared. And this
cause the eld infomation and pin presence doesnot update accordingly in alsa driver side.

This patch will also trigger unsolicated event to alsa driver to notify the hot plug event:

[  187.853159] ALSA sound/pci/hda/patch_hdmi.c:772 HDMI hot plug event: Codec=3 Pin=5 Presence_Detect=0 ELD_Valid=1
[  187.853268] ALSA sound/pci/hda/patch_hdmi.c:990 HDMI status: Codec=3 Pin=5 Presence_Detect=0 ELD_Valid=0


Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
---
 drivers/gpu/drm/i915/intel_hdmi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_hdmi.c b/drivers/gpu/drm/i915/intel_hdmi.c
index 98f6024..12dc330 100644
--- a/drivers/gpu/drm/i915/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/intel_hdmi.c
@@ -609,7 +609,7 @@ static void intel_hdmi_dpms(struct drm_encoder *encoder, int mode)
 	u32 temp;
 	u32 enable_bits = SDVO_ENABLE;
 
-	if (intel_hdmi->has_audio)
+	if (intel_hdmi->has_audio || mode != DRM_MODE_DPMS_ON)
 		enable_bits |= SDVO_AUDIO_ENABLE;
 
 	temp = I915_READ(intel_hdmi->sdvox_reg);
-- 
1.7.9.5
