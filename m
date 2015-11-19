From: han.lu@intel.com
Subject: [PATCH 1/1] drm/i915/audio: apply SKL codec wake up
	patch to BXT
Date: Thu, 19 Nov 2015 16:48:39 +0800
Message-ID: <1447922919-27077-1-git-send-email-han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 0659C2614A0
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 09:49:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: daniel.vetter@ffwll.ch, jani.nikula@intel.com, intel-gfx@lists.freedesktop.org, tiwai@suse.de, libin.yang@linux.intel.com, mengdong.lin@linux.intel.com, han.lu@linux.intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/drivers/gpu/drm/i915/intel_audio.c b/drivers/gpu/drm/i915/intel_audio.c
index 63d4706..8310bf3 100644
--- a/drivers/gpu/drm/i915/intel_audio.c
+++ b/drivers/gpu/drm/i915/intel_audio.c
@@ -591,7 +591,8 @@ static void i915_audio_component_codec_wake_override(struct device *dev,
 	struct drm_i915_private *dev_priv = dev_to_i915(dev);
 	u32 tmp;
 
-	if (!IS_SKYLAKE(dev_priv) && !IS_KABYLAKE(dev_priv))
+	if (!IS_SKYLAKE(dev_priv) && !IS_BROXTON(dev_priv) &&
+			!IS_KABYLAKE(dev_priv))
 		return;
 
 	/*
-- 
2.5.0
