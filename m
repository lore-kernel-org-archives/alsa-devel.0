From: mengdong.lin@intel.com
Subject: [PATCH 1/3] drm/i915: provide interface for audio
	driver to query cdclk
Date: Wed,  2 Jul 2014 22:43:46 +0800
Message-ID: <c92be0f2e8caa9f7c506f184f2f92bad02527fe8.1404311751.git.mengdong.lin@intel.com>
References: <cover.1404311751.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id B799A265151
 for <alsa-devel@alsa-project.org>; Wed,  2 Jul 2014 16:40:48 +0200 (CEST)
In-Reply-To: <cover.1404311751.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, jani.nikula@intel.com
List-Id: alsa-devel@alsa-project.org

From: Jani Nikula <jani.nikula@intel.com>

Signed-off-by: Jani Nikula <jani.nikula@intel.com>

diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index a90fdbd..21170e5 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -6256,6 +6256,27 @@ int i915_release_power_well(void)
 }
 EXPORT_SYMBOL_GPL(i915_release_power_well);
 
+/*
+ * Private interface for the audio driver to get CDCLK in kHz.
+ *
+ * Caller must request power well using i915_request_power_well() prior to
+ * making the call.
+ */
+int i915_get_cdclk_freq(void)
+{
+	struct drm_i915_private *dev_priv;
+
+	if (!hsw_pwr)
+		return -ENODEV;
+
+	dev_priv = container_of(hsw_pwr, struct drm_i915_private,
+				power_domains);
+
+	return intel_ddi_get_cdclk_freq(dev_priv);
+}
+EXPORT_SYMBOL_GPL(i915_get_cdclk_freq);
+
+
 #define POWER_DOMAIN_MASK (BIT(POWER_DOMAIN_NUM) - 1)
 
 #define HSW_ALWAYS_ON_POWER_DOMAINS (			\
diff --git a/include/drm/i915_powerwell.h b/include/drm/i915_powerwell.h
index 2baba99..baa6f11 100644
--- a/include/drm/i915_powerwell.h
+++ b/include/drm/i915_powerwell.h
@@ -32,5 +32,6 @@
 /* For use by hda_i915 driver */
 extern int i915_request_power_well(void);
 extern int i915_release_power_well(void);
+extern int i915_get_cdclk_freq(void);
 
 #endif				/* _I915_POWERWELL_H_ */
-- 
1.8.1.2
