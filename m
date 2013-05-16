From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 1/2 V3] drm/915: Add private api for power well
	usage
Date: Thu, 16 May 2013 15:52:36 +0800
Message-ID: <1368690757-2856-2-git-send-email-xingchao.wang@linux.intel.com>
References: <1368690757-2856-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1368690757-2856-1-git-send-email-xingchao.wang@linux.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: tiwai@suse.de, daniel@ffwll.ch, liam.r.girdwood@intel.com
Cc: alsa-devel@alsa-project.org, paulo.r.zanoni@intel.com, jocelyn.li@intel.com, mengdong.lin@intel.com, intel-gfx@lists.freedesktop.org, Wang Xingchao <xingchao.wang@linux.intel.com>, jesse.barnes@intel.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Haswell Display audio depends on power well in graphic side, it should
request power well before use it and release power well after use.
I915 will not shutdown power well if it detects audio is using.
This patch protects display audio crash for Intel Haswell C3 stepping board.

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 drivers/gpu/drm/i915/intel_pm.c |   75 +++++++++++++++++++++++++++++++++++----
 include/drm/i915_powerwell.h    |   36 +++++++++++++++++++
 2 files changed, 104 insertions(+), 7 deletions(-)
 create mode 100644 include/drm/i915_powerwell.h

diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index 0f4b46e..88820e1 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -4344,18 +4344,12 @@ bool intel_using_power_well(struct drm_device *dev)
 		return true;
 }
 
-void intel_set_power_well(struct drm_device *dev, bool enable)
+static void enable_power_well(struct drm_device *dev, bool enable)
 {
 	struct drm_i915_private *dev_priv = dev->dev_private;
 	bool is_enabled, enable_requested;
 	uint32_t tmp;
 
-	if (!HAS_POWER_WELL(dev))
-		return;
-
-	if (!i915_disable_power_well && !enable)
-		return;
-
 	tmp = I915_READ(HSW_PWR_WELL_DRIVER);
 	is_enabled = tmp & HSW_PWR_WELL_STATE;
 	enable_requested = tmp & HSW_PWR_WELL_ENABLE;
@@ -4378,6 +4372,73 @@ void intel_set_power_well(struct drm_device *dev, bool enable)
 	}
 }
 
+/* Global drm_device for display audio drvier usage */
+static struct drm_device *power_well_device;
+/* Lock protecting power well setting */
+static DEFINE_SPINLOCK(powerwell_lock);
+static bool i915_power_well_using;
+static int hsw_power_count;
+
+void i915_request_power_well(void)
+{
+	if (!power_well_device)
+		return;
+
+	if (!IS_HASWELL(power_well_device))
+		return;
+
+	spin_lock_irq(&powerwell_lock);
+	if (!hsw_power_count++ && !i915_power_well_using)
+		enable_power_well(power_well_device, true);
+	spin_unlock_irq(&powerwell_lock);
+}
+EXPORT_SYMBOL_GPL(i915_request_power_well);
+
+void i915_release_power_well(void)
+{
+	if (!power_well_device)
+		return;
+
+	if (!IS_HASWELL(power_well_device))
+		return;
+
+	spin_lock_irq(&powerwell_lock);
+	WARN_ON(!hsw_power_count);
+	if (!--hsw_power_count
+			&& !i915_power_well_using)
+		enable_power_well(power_well_device, false);
+	spin_unlock_irq(&powerwell_lock);
+}
+EXPORT_SYMBOL_GPL(i915_release_power_well);
+
+/* TODO: Call this when i915 module unload */
+void i915_remove_power_well(void)
+{
+	i915_power_well_using = false;
+	power_well_device = NULL;
+}
+
+void intel_set_power_well(struct drm_device *dev, bool enable)
+{
+	if (!HAS_POWER_WELL(dev))
+		return;
+
+	power_well_device = dev;
+	spin_lock_irq(&powerwell_lock);
+	i915_power_well_using = enable;
+	if (!enable && hsw_power_count) {
+		DRM_DEBUG_KMS("Display audio power well busy using now\n");
+		goto out;
+	}
+
+	if (!i915_disable_power_well && !enable)
+		goto out;
+
+	enable_power_well(dev, enable);
+out:
+	spin_unlock_irq(&powerwell_lock);
+}
+
 /*
  * Starting with Haswell, we have a "Power Down Well" that can be turned off
  * when not needed anymore. We have 4 registers that can request the power well
diff --git a/include/drm/i915_powerwell.h b/include/drm/i915_powerwell.h
new file mode 100644
index 0000000..cfdc884
--- /dev/null
+++ b/include/drm/i915_powerwell.h
@@ -0,0 +1,36 @@
+/**************************************************************************
+ *
+ * Copyright 2013 Intel Inc.
+ * All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
+ * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+ * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
+ * USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ *
+ **************************************************************************/
+
+#ifndef _I915_POWERWELL_H_
+#define _I915_POWERWELL_H_
+
+/* For use by hda_i915 driver */
+extern void i915_request_power_well(void);
+extern void i915_release_power_well(void);
+
+#endif				/* _I915_POWERWELL_H_ */
-- 
1.7.9.5
