From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 4/4 V6] i915/drm: Add private api for power
	well usage
Date: Mon, 27 May 2013 17:15:16 +0800
Message-ID: <1369646116-11942-5-git-send-email-xingchao.wang@linux.intel.com>
References: <1369646116-11942-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C45D2616EF
 for <alsa-devel@alsa-project.org>; Mon, 27 May 2013 11:42:23 +0200 (CEST)
In-Reply-To: <1369646116-11942-1-git-send-email-xingchao.wang@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: daniel@ffwll.ch, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, jocelyn.li@intel.com, intel-gfx@lists.freedesktop.org, Wang Xingchao <xingchao.wang@linux.intel.com>, xingchao.wang@intel.com, liam.r.girdwood@intel.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Haswell Display audio depends on power well in graphic side, it should
request power well before use it and release power well after use.
I915 will not shutdown power well if it detects audio is using.
This patch protects display audio crash for Intel Haswell C3 stepping board.

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_dma.c  |    6 +++
 drivers/gpu/drm/i915/i915_drv.h  |   12 +++++
 drivers/gpu/drm/i915/intel_drv.h |    4 ++
 drivers/gpu/drm/i915/intel_pm.c  |   92 +++++++++++++++++++++++++++++++++++---
 include/drm/i915_powerwell.h     |   36 +++++++++++++++
 5 files changed, 143 insertions(+), 7 deletions(-)
 create mode 100644 include/drm/i915_powerwell.h

diff --git a/drivers/gpu/drm/i915/i915_dma.c b/drivers/gpu/drm/i915/i915_dma.c
index f5addac..b702915 100644
--- a/drivers/gpu/drm/i915/i915_dma.c
+++ b/drivers/gpu/drm/i915/i915_dma.c
@@ -1652,6 +1652,9 @@ int i915_driver_load(struct drm_device *dev, unsigned long flags)
 	/* Start out suspended */
 	dev_priv->mm.suspended = 1;
 
+	if (IS_HASWELL(dev))
+		i915_init_power_well(dev);
+
 	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
 		ret = i915_load_modeset_init(dev);
 		if (ret < 0) {
@@ -1708,6 +1711,9 @@ int i915_driver_unload(struct drm_device *dev)
 
 	intel_gpu_ips_teardown();
 
+	if (IS_HASWELL(dev))
+		i915_remove_power_well(dev);
+
 	i915_teardown_sysfs(dev);
 
 	if (dev_priv->mm.inactive_shrinker.shrink)
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 14817de..ea94e5e 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -720,6 +720,15 @@ struct intel_ilk_power_mgmt {
 	struct drm_i915_gem_object *renderctx;
 };
 
+/* Power well structure for haswell */
+struct i915_power_well {
+	struct drm_device *device;
+	spinlock_t lock;
+	/* power well enable/disable usage count */
+	int count;
+	int i915_request;
+};
+
 struct i915_dri1_state {
 	unsigned allow_batchbuffer : 1;
 	u32 __iomem *gfx_hws_cpu_addr;
@@ -1073,6 +1082,9 @@ typedef struct drm_i915_private {
 	 * mchdev_lock in intel_pm.c */
 	struct intel_ilk_power_mgmt ips;
 
+	/* Haswell power well */
+	struct i915_power_well *hsw_pwr;
+
 	enum no_fbc_reason no_fbc_reason;
 
 	struct drm_mm_node *compressed_fb;
diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_drv.h
index 0f35545..8b5017d 100644
--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -754,6 +754,10 @@ extern void intel_update_fbc(struct drm_device *dev);
 extern void intel_gpu_ips_init(struct drm_i915_private *dev_priv);
 extern void intel_gpu_ips_teardown(void);
 
+/* Power well */
+extern int i915_init_power_well(struct drm_device *dev);
+extern void i915_remove_power_well(struct drm_device *dev);
+
 extern bool intel_display_power_enabled(struct drm_device *dev,
 					enum intel_display_power_domain domain);
 extern void intel_init_power_well(struct drm_device *dev);
diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index 1a76572..f429347 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -4502,18 +4502,12 @@ bool intel_display_power_enabled(struct drm_device *dev,
 	}
 }
 
-void intel_set_power_well(struct drm_device *dev, bool enable)
+static void __intel_set_power_well(struct drm_device *dev, bool enable)
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
@@ -4536,6 +4530,90 @@ void intel_set_power_well(struct drm_device *dev, bool enable)
 	}
 }
 
+static struct i915_power_well *hsw_pwr;
+
+/* Display audio driver power well request */
+void i915_request_power_well(void)
+{
+	if (hsw_pwr == NULL)
+		return;
+
+	spin_lock_irq(&hsw_pwr->lock);
+	if (!hsw_pwr->count++ &&
+			!hsw_pwr->i915_request)
+		__intel_set_power_well(hsw_pwr->device, true);
+	spin_unlock_irq(&hsw_pwr->lock);
+}
+EXPORT_SYMBOL_GPL(i915_request_power_well);
+
+/* Display audio driver power well release */
+void i915_release_power_well(void)
+{
+	if (hsw_pwr == NULL)
+		return;
+
+	spin_lock_irq(&hsw_pwr->lock);
+	WARN_ON(!hsw_pwr->count);
+	if (!--hsw_pwr->count &&
+		       !hsw_pwr->i915_request)
+		__intel_set_power_well(hsw_pwr->device, false);
+	spin_unlock_irq(&hsw_pwr->lock);
+}
+EXPORT_SYMBOL_GPL(i915_release_power_well);
+
+int i915_init_power_well(struct drm_device *dev)
+{
+	struct drm_i915_private *dev_priv = dev->dev_private;
+
+	hsw_pwr = kzalloc(sizeof *hsw_pwr, GFP_KERNEL);
+	if (hsw_pwr == NULL)
+		return -ENOMEM;
+
+	dev_priv->hsw_pwr = hsw_pwr;
+
+	hsw_pwr->device = dev;
+	spin_lock_init(&hsw_pwr->lock);
+	hsw_pwr->count = 0;
+
+	return 0;
+}
+
+void i915_remove_power_well(struct drm_device *dev)
+{
+	struct drm_i915_private *dev_priv = dev->dev_private;
+
+	kfree(dev_priv->hsw_pwr);
+	dev_priv->hsw_pwr = NULL;
+	hsw_pwr = NULL;
+}
+
+void intel_set_power_well(struct drm_device *dev, bool enable)
+{
+	struct drm_i915_private *dev_priv = dev->dev_private;
+	struct i915_power_well *power_well = dev_priv->hsw_pwr;
+
+	if (!HAS_POWER_WELL(dev))
+		return;
+
+	if (!i915_disable_power_well && !enable)
+		return;
+
+	if (!power_well)
+		return;
+
+	spin_lock_irq(&power_well->lock);
+	power_well->i915_request = enable;
+
+	/* only reject "disable" power well request */
+	if (power_well->count && !enable) {
+		spin_unlock_irq(&power_well->lock);
+		return;
+	}
+
+	__intel_set_power_well(dev, enable);
+	spin_unlock_irq(&power_well->lock);
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
