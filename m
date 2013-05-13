From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 1/5] drm/915: Add private api for power well
	usage
Date: Mon, 13 May 2013 15:37:24 +0800
Message-ID: <1368430648-2353-2-git-send-email-xingchao.wang@linux.intel.com>
References: <1368430648-2353-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1368430648-2353-1-git-send-email-xingchao.wang@linux.intel.com>
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
This patch protects display audio crash for Intel Haswell mobile
C3 stepping board.

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 drivers/gpu/drm/i915/intel_pm.c |  127 ++++++++++++++++++++++++++++++++++++---
 include/drm/i915_powerwell.h    |   39 ++++++++++++
 2 files changed, 159 insertions(+), 7 deletions(-)
 create mode 100644 include/drm/i915_powerwell.h

diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index 0f4b46e..642c4b6 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -4344,18 +4344,12 @@ bool intel_using_power_well(struct drm_device *dev)
 		return true;
 }
 
-void intel_set_power_well(struct drm_device *dev, bool enable)
+void enable_power_well(struct drm_device *dev, bool enable)
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
@@ -4378,6 +4372,125 @@ void intel_set_power_well(struct drm_device *dev, bool enable)
 	}
 }
 
+/* Global drm_device for display audio drvier usage */
+static struct drm_device *power_well_device;
+/* Lock protecting power well setting */
+DEFINE_SPINLOCK(powerwell_lock);
+static bool i915_power_well_using;
+
+struct i915_power_well {
+	int user_cnt;
+	struct list_head power_well_list;
+};
+
+static struct i915_power_well hsw_power = {
+	.user_cnt = 0,
+	.power_well_list = LIST_HEAD_INIT(hsw_power.power_well_list),
+};
+
+struct i915_power_well_user {
+	char name[16];
+	struct list_head list;
+};
+
+void i915_request_power_well(const char *name)
+{
+	struct i915_power_well_user *user;
+
+	DRM_DEBUG_KMS("request power well for %s\n", name);
+	spin_lock_irq(&powerwell_lock);
+	if (!power_well_device)
+		goto out;
+
+	if (!IS_HASWELL(power_well_device))
+		goto out;
+
+	list_for_each_entry(user, &hsw_power.power_well_list, list) {
+		if (!strcmp(user->name, name)) {
+			goto out;
+		}
+	}
+
+	user = kzalloc(sizeof(*user), GFP_KERNEL);
+	if (user == NULL) {
+		goto out;
+	}
+	strcpy(user->name, name);
+
+	list_add(&user->list, &hsw_power.power_well_list);
+	hsw_power.user_cnt++;
+
+	if (hsw_power.user_cnt == 1) {
+		enable_power_well(power_well_device, true);
+		DRM_DEBUG_KMS("%s set power well on\n", user->name);
+	}
+out:
+	spin_unlock_irq(&powerwell_lock);
+	return;
+}
+EXPORT_SYMBOL_GPL(i915_request_power_well);
+
+void i915_release_power_well(const char *name)
+{
+	struct i915_power_well_user *user;
+
+	DRM_DEBUG_KMS("release power well from %s\n", name);
+	spin_lock_irq(&powerwell_lock);
+	if (!power_well_device)
+		goto out;
+
+	if (!IS_HASWELL(power_well_device))
+		goto out;
+
+	list_for_each_entry(user, &hsw_power.power_well_list, list) {
+		if (!strcmp(user->name, name)) {
+			list_del(&user->list);
+			hsw_power.user_cnt--;
+			DRM_DEBUG_KMS("Releaseing power well:%s, user_cnt:%d, i915 using:%d\n",
+					user->name, hsw_power.user_cnt, i915_power_well_using);
+			if (!hsw_power.user_cnt && !i915_power_well_using)
+				enable_power_well(power_well_device, false);
+			goto out;
+		}
+	}
+
+	DRM_DEBUG_KMS("power well %s doesnot exist\n", name);
+out:
+	spin_unlock_irq(&powerwell_lock);
+	return;
+}
+EXPORT_SYMBOL_GPL(i915_release_power_well);
+
+/* TODO: Call this when i915 module unload */
+void remove_power_well(void)
+{
+	spin_lock_irq(&powerwell_lock);
+	i915_power_well_using = false;
+	power_well_device = NULL;
+	spin_unlock_irq(&powerwell_lock);
+}
+
+void intel_set_power_well(struct drm_device *dev, bool enable)
+{
+	if (!HAS_POWER_WELL(dev))
+		return;
+
+	spin_lock_irq(&powerwell_lock);
+	power_well_device = dev;
+	i915_power_well_using = enable;
+	if (!enable && hsw_power.user_cnt) {
+		DRM_DEBUG_KMS("Display audio power well busy using now\n");
+		goto out;
+	}
+
+	if (!i915_disable_power_well && !enable)
+		goto out;
+	enable_power_well(dev, enable);
+out:
+	spin_unlock_irq(&powerwell_lock);
+	return;
+}
+
 /*
  * Starting with Haswell, we have a "Power Down Well" that can be turned off
  * when not needed anymore. We have 4 registers that can request the power well
diff --git a/include/drm/i915_powerwell.h b/include/drm/i915_powerwell.h
new file mode 100644
index 0000000..87e0a2e
--- /dev/null
+++ b/include/drm/i915_powerwell.h
@@ -0,0 +1,39 @@
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
+/*
+ * Authors:
+ * Wang Xingchao <xingchao.wang@intel.com>
+ */
+
+#ifndef _I915_POWERWELL_H_
+#define _I915_POWERWELL_H_
+
+extern void i915_request_power_well(const char *name);
+extern void i915_release_power_well(const char *name);
+
+#endif				/* _I915_POWERWELL_H_ */
-- 
1.7.9.5
