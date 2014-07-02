From: mengdong.lin@intel.com
Subject: [PATCH 2/3] ALSA: hda - define hda_get_display_clk to
	query CDCLK for Haswell/Broadwell
Date: Wed,  2 Jul 2014 22:43:55 +0800
Message-ID: <8b11a79ce0c5e28330577c0d390ed87301677190.1404311751.git.mengdong.lin@intel.com>
References: <cover.1404311751.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 192442657AD
 for <alsa-devel@alsa-project.org>; Wed,  2 Jul 2014 16:41:24 +0200 (CEST)
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
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

This patch defines hda_get_display_clk() to query Core Display Clock (CDCLK)
from the i915 display driver, via a private API i915_get_cdclk_freq().

The audio driver will set M/N values as per the CDCLK for restoring BCLK of
the display HD-A controller.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_i915.c b/sound/pci/hda/hda_i915.c
index e9e8a4a..76db293 100644
--- a/sound/pci/hda/hda_i915.c
+++ b/sound/pci/hda/hda_i915.c
@@ -24,6 +24,7 @@
 
 static int (*get_power)(void);
 static int (*put_power)(void);
+static int (*get_cdclk)(void);
 
 int hda_display_power(bool enable)
 {
@@ -38,6 +39,14 @@ int hda_display_power(bool enable)
 		return put_power();
 }
 
+int hda_get_display_clk(void)
+{
+	if (!get_cdclk)
+		return -ENODEV;
+
+	return get_cdclk();
+}
+
 int hda_i915_init(void)
 {
 	int err = 0;
@@ -55,6 +64,15 @@ int hda_i915_init(void)
 		return -ENODEV;
 	}
 
+	get_cdclk = symbol_request(i915_get_cdclk_freq);
+	if (!get_cdclk) {
+		symbol_put(i915_request_power_well);
+		get_power = NULL;
+		symbol_put(i915_release_power_well);
+		put_power = NULL;
+		return -ENODEV;
+	}
+
 	pr_debug("HDA driver get symbol successfully from i915 module\n");
 
 	return err;
@@ -70,6 +88,10 @@ int hda_i915_exit(void)
 		symbol_put(i915_release_power_well);
 		put_power = NULL;
 	}
+	if (get_cdclk) {
+		symbol_put(i915_get_cdclk_freq);
+		get_cdclk = NULL;
+	}
 
 	return 0;
 }
diff --git a/sound/pci/hda/hda_i915.h b/sound/pci/hda/hda_i915.h
index bfd835f..b4420e1 100644
--- a/sound/pci/hda/hda_i915.h
+++ b/sound/pci/hda/hda_i915.h
@@ -18,6 +18,7 @@
 
 #ifdef CONFIG_SND_HDA_I915
 int hda_display_power(bool enable);
+int hda_get_display_clk(void);
 int hda_i915_init(void);
 int hda_i915_exit(void);
 #else
-- 
1.8.1.2
