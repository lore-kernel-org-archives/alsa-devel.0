From: Imre Deak <imre.deak@intel.com>
Subject: [PATCH 1/5] drm/i915: add dev_to_i915_priv helper
Date: Mon,  8 Dec 2014 18:42:05 +0200
Message-ID: <1418056929-7977-2-git-send-email-imre.deak@intel.com>
References: <1418056929-7977-1-git-send-email-imre.deak@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 55BA326045C
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 17:42:20 +0100 (CET)
In-Reply-To: <1418056929-7977-1-git-send-email-imre.deak@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: intel-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This will be needed by later patches, so factor it out.

No functional change.

Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/gpu/drm/i915/i915_drv.c  | 15 ++++++---------
 drivers/gpu/drm/i915/intel_drv.h |  8 ++++++++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 71be3c9..32c2e33 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -923,10 +923,10 @@ i915_pci_remove(struct pci_dev *pdev)
 
 static int i915_pm_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_i915_private *dev_priv = dev_to_i915_priv(dev);
+	struct drm_device *drm_dev = dev_priv->dev;
 
-	if (!drm_dev || !drm_dev->dev_private) {
+	if (!drm_dev || !dev_priv) {
 		dev_err(dev, "DRM not initialized, aborting suspend.\n");
 		return -ENODEV;
 	}
@@ -939,8 +939,7 @@ static int i915_pm_suspend(struct device *dev)
 
 static int i915_pm_suspend_late(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_to_i915_priv(dev)->dev;
 
 	/*
 	 * We have a suspedn ordering issue with the snd-hda driver also
@@ -959,8 +958,7 @@ static int i915_pm_suspend_late(struct device *dev)
 
 static int i915_pm_resume_early(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_to_i915_priv(dev)->dev;
 
 	if (drm_dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
@@ -970,8 +968,7 @@ static int i915_pm_resume_early(struct device *dev)
 
 static int i915_pm_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_to_i915_priv(dev)->dev;
 
 	if (drm_dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
diff --git a/drivers/gpu/drm/i915/intel_drv.h b/drivers/gpu/drm/i915/intel_drv.h
index 61a88fa..3de7a55 100644
--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -775,6 +775,14 @@ static inline unsigned int intel_num_planes(struct intel_crtc *crtc)
 	return INTEL_INFO(crtc->base.dev)->num_sprites[crtc->pipe] + 1;
 }
 
+static inline struct drm_i915_private *dev_to_i915_priv(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+
+	return drm_dev->dev_private;
+}
+
 /* intel_fifo_underrun.c */
 bool intel_set_cpu_fifo_underrun_reporting(struct drm_i915_private *dev_priv,
 					   enum pipe pipe, bool enable);
-- 
1.8.4
