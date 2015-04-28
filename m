From: mengdong.lin@intel.com
Subject: [PATCH v2 3/3] ALSA: hda - implement a refcount for
	i915 power well switch
Date: Tue, 28 Apr 2015 20:43:19 +0800
Message-ID: <1430224999-22271-1-git-send-email-mengdong.lin@intel.com>
References: <4530387c0b63ccfafb5dbb3399a39b4093651c48.1429880424.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B430260687
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 14:32:36 +0200 (CEST)
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

This is to check the refcount of audio driver and reduce calling to i915.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_i915.c b/sound/pci/hda/hda_i915.c
index 52a85d8..e831691 100644
--- a/sound/pci/hda/hda_i915.c
+++ b/sound/pci/hda/hda_i915.c
@@ -42,11 +42,16 @@ int hda_display_power(struct hda_intel *hda, bool enable)
 
 	dev_dbg(&hda->chip.pci->dev, "display power %s\n",
 		enable ? "enable" : "disable");
-	if (enable)
-		acomp->ops->get_power(acomp->dev);
-	else
-		acomp->ops->put_power(acomp->dev);
-
+	mutex_lock(&hda->display_power.lock);
+	if (enable) {
+		if (!hda->display_power.use_count++)
+			acomp->ops->get_power(acomp->dev);
+	} else {
+		WARN_ON(!hda->display_power.use_count);
+		if (!--hda->display_power.use_count)
+			acomp->ops->put_power(acomp->dev);
+	}
+	mutex_unlock(&hda->display_power.lock);
 	return 0;
 }
 
@@ -171,6 +176,8 @@ int hda_i915_init(struct hda_intel *hda)
 
 	dev_dbg(dev, "bound to i915 component master\n");
 
+	mutex_init(&hda->display_power.lock);
+
 	return 0;
 out_master_del:
 	component_master_del(dev, &hda_component_master_ops);
diff --git a/sound/pci/hda/hda_intel.h b/sound/pci/hda/hda_intel.h
index 2069898..3ca000a 100644
--- a/sound/pci/hda/hda_intel.h
+++ b/sound/pci/hda/hda_intel.h
@@ -19,6 +19,11 @@
 #include <drm/i915_component.h>
 #include "hda_controller.h"
 
+struct i915_display_power {
+	struct mutex lock;
+	int use_count;
+};
+
 struct hda_intel {
 	struct azx chip;
 
@@ -46,6 +51,7 @@ struct hda_intel {
 
 	/* i915 component interface */
 	struct i915_audio_component audio_component;
+	struct i915_display_power display_power;
 };
 
 #ifdef CONFIG_SND_HDA_I915
-- 
1.9.1
