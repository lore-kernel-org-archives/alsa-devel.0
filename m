From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH v3 1/4] ASoC: Intel: Skylake: Add debugfs
	support
Date: Fri, 30 Jun 2017 09:06:05 +0530
Message-ID: <20170630033608.31466-2-guneshwor.o.singh@intel.com>
References: <20170630033608.31466-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E81C2673F8
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 05:36:34 +0200 (CEST)
In-Reply-To: <20170630033608.31466-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, Vunny Sodhi <vunnyx.sodhi@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

For debug, the kernel debugfs mechanism is available. We can add various
debug options for driver like module configuration read, firmware register
read etc.

This patch adds debugfs as a child to asoc plaform component and caller is
added for skylake driver to do init and cleanup of debugfs.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Vunny Sodhi <vunnyx.sodhi@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/Makefile    |  4 +++
 sound/soc/intel/skylake/skl-debug.c | 55 +++++++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-pcm.c   |  6 +++-
 sound/soc/intel/skylake/skl.c       |  2 ++
 sound/soc/intel/skylake/skl.h       | 16 +++++++++++
 5 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/intel/skylake/skl-debug.c

diff --git a/sound/soc/intel/skylake/Makefile b/sound/soc/intel/skylake/Makefile
index 60fbc9bbe473..e7d77722d560 100644
--- a/sound/soc/intel/skylake/Makefile
+++ b/sound/soc/intel/skylake/Makefile
@@ -1,6 +1,10 @@
 snd-soc-skl-objs := skl.o skl-pcm.o skl-nhlt.o skl-messages.o \
 skl-topology.o
 
+ifdef CONFIG_DEBUG_FS
+  snd-soc-skl-objs += skl-debug.o
+endif
+
 obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) += snd-soc-skl.o
 
 # Skylake IPC Support
diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
new file mode 100644
index 000000000000..6bc4565773c5
--- /dev/null
+++ b/sound/soc/intel/skylake/skl-debug.c
@@ -0,0 +1,55 @@
+/*
+ *  skl-debug.c - Debugfs for skl driver
+ *
+ *  Copyright (C) 2016-17 Intel Corp
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ */
+
+#include <linux/pci.h>
+#include <linux/debugfs.h>
+#include "skl.h"
+
+struct skl_debug {
+	struct skl *skl;
+	struct device *dev;
+
+	struct dentry *fs;
+};
+
+struct skl_debug *skl_debugfs_init(struct skl *skl)
+{
+	struct skl_debug *d;
+
+	d = devm_kzalloc(&skl->pci->dev, sizeof(*d), GFP_KERNEL);
+	if (!d)
+		return NULL;
+
+	/* create the debugfs dir with platform component's debugfs as parent */
+	d->fs = debugfs_create_dir("dsp",
+				   skl->platform->component.debugfs_root);
+	if (IS_ERR(d->fs) || !d->fs) {
+		dev_err(&skl->pci->dev, "debugfs root creation failed\n");
+		return NULL;
+	}
+
+	d->skl = skl;
+	d->dev = &skl->pci->dev;
+
+	return d;
+}
+
+void skl_debugfs_exit(struct skl_debug *d)
+{
+	debugfs_remove_recursive(d->fs);
+
+	kfree(d);
+
+}
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index e91bbcffc856..0ebea34a4988 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1249,12 +1249,16 @@ static int skl_platform_soc_probe(struct snd_soc_platform *platform)
 
 	pm_runtime_get_sync(platform->dev);
 	if ((ebus_to_hbus(ebus))->ppcap) {
+		skl->platform = platform;
+
+		/* init debugfs */
+		skl->debugfs = skl_debugfs_init(skl);
+
 		ret = skl_tplg_init(platform, ebus);
 		if (ret < 0) {
 			dev_err(platform->dev, "Failed to init topology!\n");
 			return ret;
 		}
-		skl->platform = platform;
 
 		/* load the firmwares, since all is set */
 		ops = skl_get_dsp_ops(skl->pci->device);
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index e761550c6dad..410ce83f4a49 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -866,6 +866,8 @@ static void skl_remove(struct pci_dev *pci)
 	/* codec removal, invoke bus_device_remove */
 	snd_hdac_ext_bus_device_remove(ebus);
 
+	skl_debugfs_exit(skl->debugfs);
+	skl->debugfs = NULL;
 	skl_platform_unregister(&pci->dev);
 	skl_free_dsp(skl);
 	skl_machine_device_unregister(skl);
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 2a630fcb7f08..a47779c819d5 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -42,6 +42,8 @@ struct skl_dsp_resource {
 	u32 mem;
 };
 
+struct skl_debug;
+
 struct skl {
 	struct hdac_ext_bus ebus;
 	struct pci_dev *pci;
@@ -66,6 +68,8 @@ struct skl {
 	int supend_active;
 
 	struct work_struct probe_work;
+
+	struct skl_debug *debugfs;
 };
 
 #define skl_to_ebus(s)	(&(s)->ebus)
@@ -116,4 +120,16 @@ void skl_update_d0i3c(struct device *dev, bool enable);
 int skl_nhlt_create_sysfs(struct skl *skl);
 void skl_nhlt_remove_sysfs(struct skl *skl);
 
+#ifdef CONFIG_DEBUG_FS
+struct skl_debug *skl_debugfs_init(struct skl *skl);
+void skl_debugfs_exit(struct skl_debug *d);
+#else
+static inline struct skl_debug *skl_debugfs_init(struct skl *skl)
+{
+	return NULL;
+}
+static inline void skl_debugfs_exit(struct skl_debug *d)
+{}
+#endif
+
 #endif /* __SOUND_SOC_SKL_H */
-- 
2.13.0
