From: mengdong.lin@intel.com
Subject: [PATCH v3 1/5] ALSA: hda - implement a refcount for
	i915 power well switch
Date: Wed, 29 Apr 2015 17:43:12 +0800
Message-ID: <c86a72ee24f199eb4277d74d88f30cd1ba1c65a8.1430300071.git.mengdong.lin@intel.com>
References: <cover.1430300071.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id CB3D62604AF
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 11:32:27 +0200 (CEST)
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

This is to check the refcount of audio driver and reduce calling to i915.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_i915.c b/sound/pci/hda/hda_i915.c
index 52a85d8..b648928 100644
--- a/sound/pci/hda/hda_i915.c
+++ b/sound/pci/hda/hda_i915.c
@@ -42,10 +42,15 @@ int hda_display_power(struct hda_intel *hda, bool enable)
 
 	dev_dbg(&hda->chip.pci->dev, "display power %s\n",
 		enable ? "enable" : "disable");
-	if (enable)
-		acomp->ops->get_power(acomp->dev);
-	else
-		acomp->ops->put_power(acomp->dev);
+
+	if (enable) {
+		if (!hda->i915_power_refcount++)
+			acomp->ops->get_power(acomp->dev);
+	} else {
+		WARN_ON(!hda->i915_power_refcount);
+		if (!--hda->i915_power_refcount)
+			acomp->ops->put_power(acomp->dev);
+	}
 
 	return 0;
 }
@@ -183,6 +188,11 @@ out_err:
 int hda_i915_exit(struct hda_intel *hda)
 {
 	struct device *dev = &hda->chip.pci->dev;
+	struct i915_audio_component *acomp = &hda->audio_component;
+
+	WARN_ON(hda->i915_power_refcount);
+	if (hda->i915_power_refcount > 0 && acomp->ops)
+		acomp->ops->put_power(acomp->dev);
 
 	component_master_del(dev, &hda_component_master_ops);
 
diff --git a/sound/pci/hda/hda_intel.h b/sound/pci/hda/hda_intel.h
index 2069898..dc1d3ff 100644
--- a/sound/pci/hda/hda_intel.h
+++ b/sound/pci/hda/hda_intel.h
@@ -46,6 +46,7 @@ struct hda_intel {
 
 	/* i915 component interface */
 	struct i915_audio_component audio_component;
+	int i915_power_refcount;
 };
 
 #ifdef CONFIG_SND_HDA_I915
-- 
1.9.1
