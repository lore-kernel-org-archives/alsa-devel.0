From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 4/5] ALSA: hda - Fix module dependency with gfx
	i915
Date: Mon, 13 May 2013 15:37:27 +0800
Message-ID: <1368430648-2353-5-git-send-email-xingchao.wang@linux.intel.com>
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

hda_i915 has dependency on i915 module, this patch check whether
symbol exist before calling API there. If i915 module not loaded it
will try to load before use.

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 sound/pci/hda/hda_i915.c |   42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_i915.c b/sound/pci/hda/hda_i915.c
index 00def82..edf1a08 100644
--- a/sound/pci/hda/hda_i915.c
+++ b/sound/pci/hda/hda_i915.c
@@ -22,16 +22,54 @@
 #include <drm/i915_powerwell.h>
 #include "hda_i915.h"
 
+const char *name = "i915";
+static void (*get_power)(const char *name);
+static void (*put_power)(const char *name);
+
 /* Power well has impact on Haswell controller and codecs */
 void hda_display_power(bool enable)
 {
 	snd_printk(KERN_INFO "HDA display power %s \n", enable ? "Enable" : "Disable");
+
+	if (!get_power || !put_power)
+		return;
+
 	if (enable)
-		i915_request_power_well("hda");
+		get_power("hda");
 	else
-		i915_release_power_well("hda");
+		put_power("hda");
 }
 EXPORT_SYMBOL(hda_display_power);
 
+static int __init hda_i915_init(void)
+{
+	struct module *i915;
+	mutex_lock(&module_mutex);
+	i915 = find_module(name);
+	mutex_unlock(&module_mutex);
+
+	if (!i915)
+		request_module_nowait(name);
+
+	if (!try_module_get(i915))
+		return -EFAULT;
+
+	get_power = symbol_get(i915_request_power_well);
+	put_power = symbol_get(i915_release_power_well);
+
+	module_put(i915);
+	return 0;
+}
+
+#if 0
+static void __exit hda_i915_exit(void)
+{
+	drm_pci_exit(&driver, &i915_pci_driver);
+}
+
+module_init(hda_i915_init);
+module_exit(hda_i915_exit);
+#endif
+module_init(hda_i915_init);
 MODULE_DESCRIPTION("HDA power well");
 MODULE_LICENSE("GPL");
-- 
1.7.9.5
