From: Imre Deak <imre.deak@intel.com>
Subject: [PATCH 4/5] ALSA: hda: add component support
Date: Mon,  8 Dec 2014 18:42:08 +0200
Message-ID: <1418056929-7977-5-git-send-email-imre.deak@intel.com>
References: <1418056929-7977-1-git-send-email-imre.deak@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DDD326047E
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 17:44:45 +0100 (CET)
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

Register a component to be used to interface with the i915 driver. This
is meant to replace the current interface which is based on module
symbol lookups.

Note that currently we keep the existing behavior and pin the i915
module while the hda driver is loaded. Using the component interface
allows us to remove this dependency once support for dynamically
enabling / disabling the HDMI functionality from the bind/unbind hooks
is added.

Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 sound/pci/hda/hda_i915.c | 120 ++++++++++++++++++++++++++++++++---------------
 sound/pci/hda/hda_priv.h |   7 +++
 2 files changed, 89 insertions(+), 38 deletions(-)

diff --git a/sound/pci/hda/hda_i915.c b/sound/pci/hda/hda_i915.c
index 4e4b733..01f5a5d 100644
--- a/sound/pci/hda/hda_i915.c
+++ b/sound/pci/hda/hda_i915.c
@@ -18,8 +18,10 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/component.h>
+#include <drm/i915_component.h>
 #include <sound/core.h>
-#include <drm/i915_powerwell.h>
 #include "hda_priv.h"
 #include "hda_i915.h"
 
@@ -31,32 +33,33 @@
 #define AZX_REG_EM4			0x100c
 #define AZX_REG_EM5			0x1010
 
-static int (*get_power)(void);
-static int (*put_power)(void);
-static int (*get_cdclk)(void);
-
 int hda_display_power(struct azx *chip, bool enable)
 {
-	if (!get_power || !put_power)
+	struct hda_component *hdac = &chip->component;
+
+	if (!hdac->i915_ops)
 		return -ENODEV;
 
 	pr_debug("HDA display power %s \n",
 			enable ? "Enable" : "Disable");
 	if (enable)
-		return get_power();
+		hdac->i915_ops->get_power(hdac->i915_dev);
 	else
-		return put_power();
+		hdac->i915_ops->put_power(hdac->i915_dev);
+
+	return 0;
 }
 
 void haswell_set_bclk(struct azx *chip)
 {
 	int cdclk_freq;
 	unsigned int bclk_m, bclk_n;
+	struct hda_component *hdac = &chip->component;
 
-	if (!get_cdclk)
+	if (!hdac->i915_ops)
 		return;
 
-	cdclk_freq = get_cdclk();
+	cdclk_freq = hdac->i915_ops->get_cdclk(hdac->i915_dev);
 	switch (cdclk_freq) {
 	case 337500:
 		bclk_m = 16;
@@ -84,47 +87,87 @@ void haswell_set_bclk(struct azx *chip)
 	azx_writew(chip, EM5, bclk_n);
 }
 
+static int hda_component_bind(struct device *hda_dev,
+			      struct device *i915_dev, void *data)
+{
+	struct snd_card *card = dev_get_drvdata(hda_dev);
+	struct azx *chip = card->private_data;
+	struct i915_component_ops *i915_ops = data;
+	struct hda_component *hdac = &chip->component;
+
+	if (WARN_ON(!(i915_ops->get_power && i915_ops->put_power &&
+		      i915_ops->get_cdclk)))
+		return -EINVAL;
+
+	/*
+	 * Atm, we don't support dynamic unbinding initiated by the component
+	 * master, so pin its containing module until we unbind.
+	 */
+	if (!try_module_get(i915_ops->owner))
+		return -ENODEV;
+
+	hdac->i915_dev = i915_dev;
+	hdac->i915_ops = i915_ops;
+
+	return 0;
+}
+
+static void hda_component_unbind(struct device *hda_dev,
+				 struct device *i915_dev, void *data)
+{
+	struct snd_card *card = dev_get_drvdata(hda_dev);
+	struct azx *chip = card->private_data;
+	struct hda_component *hdac = &chip->component;
+
+	module_put(hdac->i915_ops->owner);
+
+	hdac->i915_dev = NULL;
+	hdac->i915_ops = NULL;
+}
+
+static struct component_ops hda_component_ops = {
+	.bind = hda_component_bind,
+	.unbind = hda_component_unbind,
+};
 
 int hda_i915_init(struct azx *chip)
 {
-	int err = 0;
+	struct device *dev = &chip->pci->dev;
+	int ret;
 
-	get_power = symbol_request(i915_request_power_well);
-	if (!get_power) {
-		pr_warn("hda-i915: get_power symbol get fail\n");
-		return -ENODEV;
-	}
-
-	put_power = symbol_request(i915_release_power_well);
-	if (!put_power) {
-		symbol_put(i915_request_power_well);
-		get_power = NULL;
-		return -ENODEV;
-	}
-
-	get_cdclk = symbol_request(i915_get_cdclk_freq);
-	if (!get_cdclk)	/* may have abnormal BCLK and audio playback rate */
-		pr_warn("hda-i915: get_cdclk symbol get fail\n");
-
+	ret = component_add(dev, &hda_component_ops);
+	if (ret < 0)
+		goto out_err;
+
+	/*
+	 * Atm, we don't support deferring the component binding, so make sure
+	 * i915 is loaded and that the binding successfully completes.
+	 */
+	ret = request_module("i915");
+	if (ret < 0)
+		goto out_err;
+
+	if (!chip->component.i915_ops) {
+		ret = -ENODEV;
+		goto out_component_del;
+	}
+
-	pr_debug("HDA driver get symbol successfully from i915 module\n");
+	pr_debug("hda-i915: bound to component master\n");
+
+	return 0;
+out_component_del:
+	component_del(dev, &hda_component_ops);
+out_err:
+	pr_warn("hda-i915: failed to bind to component master (%d)\n", ret);
 
-	return err;
+	return ret;
 }
 
 int hda_i915_exit(struct azx *chip)
 {
-	if (get_power) {
-		symbol_put(i915_request_power_well);
-		get_power = NULL;
-	}
-	if (put_power) {
-		symbol_put(i915_release_power_well);
-		put_power = NULL;
-	}
-	if (get_cdclk) {
-		symbol_put(i915_get_cdclk_freq);
-		get_cdclk = NULL;
-	}
+	struct device *dev = &chip->pci->dev;
+
+	component_del(dev, &hda_component_ops);
 
 	return 0;
 }
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index aa484fd..336d401 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -18,6 +18,7 @@
 #include <linux/clocksource.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
+#include <drm/i915_component.h>
 
 /*
  * registers
@@ -291,6 +292,12 @@ struct azx {
 	struct pci_dev *pci;
 	int dev_index;
 
+	/* i915 component interface */
+	struct hda_component {
+		struct device *i915_dev;
+		const struct i915_component_ops *i915_ops;
+	} component;
+
 	/* chip type specific */
 	int driver_type;
 	unsigned int driver_caps;
-- 
1.8.4
