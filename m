From: Vinod Koul <vinod.koul@intel.com>
Subject: [RFC 1/5] ALSA: hda: move hdaudio header files to
	global include
Date: Sun,  8 Mar 2015 20:07:55 +0530
Message-ID: <1425825479-28780-2-git-send-email-vinod.koul@intel.com>
References: <1425825479-28780-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C3B0260455
 for <alsa-devel@alsa-project.org>; Sun,  8 Mar 2015 15:41:26 +0100 (CET)
In-Reply-To: <1425825479-28780-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

The hd-audio headers are local to sound/pci/hda. Moving them out helps to
use these headers in other places like the upcoming ASoC HDA code

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 {sound/pci/hda => include/sound}/hda_auto_parser.h |    0
 {sound/pci/hda => include/sound}/hda_beep.h        |    0
 {sound/pci/hda => include/sound}/hda_codec.h       |    0
 {sound/pci/hda => include/sound}/hda_controller.h  |    0
 {sound/pci/hda => include/sound}/hda_generic.h     |    0
 {sound/pci/hda => include/sound}/hda_jack.h        |    0
 {sound/pci/hda => include/sound}/hda_local.h       |    0
 {sound/pci/hda => include/sound}/hda_priv.h        |    0
 sound/pci/hda/hda_auto_parser.c                    |    6 +++---
 sound/pci/hda/hda_beep.c                           |    4 ++--
 sound/pci/hda/hda_codec.c                          |    8 ++++----
 sound/pci/hda/hda_controller.c                     |    4 ++--
 sound/pci/hda/hda_eld.c                            |    4 ++--
 sound/pci/hda/hda_generic.c                        |   12 ++++++------
 sound/pci/hda/hda_hwdep.c                          |    4 ++--
 sound/pci/hda/hda_i915.c                           |    2 +-
 sound/pci/hda/hda_intel.c                          |    6 +++---
 sound/pci/hda/hda_jack.c                           |    8 ++++----
 sound/pci/hda/hda_proc.c                           |    4 ++--
 sound/pci/hda/hda_sysfs.c                          |    4 ++--
 20 files changed, 33 insertions(+), 33 deletions(-)
 rename {sound/pci/hda => include/sound}/hda_auto_parser.h (100%)
 rename {sound/pci/hda => include/sound}/hda_beep.h (100%)
 rename {sound/pci/hda => include/sound}/hda_codec.h (100%)
 rename {sound/pci/hda => include/sound}/hda_controller.h (100%)
 rename {sound/pci/hda => include/sound}/hda_generic.h (100%)
 rename {sound/pci/hda => include/sound}/hda_jack.h (100%)
 rename {sound/pci/hda => include/sound}/hda_local.h (100%)
 rename {sound/pci/hda => include/sound}/hda_priv.h (100%)

diff --git a/sound/pci/hda/hda_auto_parser.h b/include/sound/hda_auto_parser.h
similarity index 100%
rename from sound/pci/hda/hda_auto_parser.h
rename to include/sound/hda_auto_parser.h
diff --git a/sound/pci/hda/hda_beep.h b/include/sound/hda_beep.h
similarity index 100%
rename from sound/pci/hda/hda_beep.h
rename to include/sound/hda_beep.h
diff --git a/sound/pci/hda/hda_codec.h b/include/sound/hda_codec.h
similarity index 100%
rename from sound/pci/hda/hda_codec.h
rename to include/sound/hda_codec.h
diff --git a/sound/pci/hda/hda_controller.h b/include/sound/hda_controller.h
similarity index 100%
rename from sound/pci/hda/hda_controller.h
rename to include/sound/hda_controller.h
diff --git a/sound/pci/hda/hda_generic.h b/include/sound/hda_generic.h
similarity index 100%
rename from sound/pci/hda/hda_generic.h
rename to include/sound/hda_generic.h
diff --git a/sound/pci/hda/hda_jack.h b/include/sound/hda_jack.h
similarity index 100%
rename from sound/pci/hda/hda_jack.h
rename to include/sound/hda_jack.h
diff --git a/sound/pci/hda/hda_local.h b/include/sound/hda_local.h
similarity index 100%
rename from sound/pci/hda/hda_local.h
rename to include/sound/hda_local.h
diff --git a/sound/pci/hda/hda_priv.h b/include/sound/hda_priv.h
similarity index 100%
rename from sound/pci/hda/hda_priv.h
rename to include/sound/hda_priv.h
diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 1ede82200ee5..e518a74b3d66 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -13,9 +13,9 @@
 #include <linux/export.h>
 #include <linux/sort.h>
 #include <sound/core.h>
-#include "hda_codec.h"
-#include "hda_local.h"
-#include "hda_auto_parser.h"
+#include <sound/hda_codec.h>
+#include <sound/hda_local.h>
+#include <sound/hda_auto_parser.h>
 
 /*
  * Helper for automatic pin configuration
diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index 1e7de08e77cb..3ce849899bb5 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -24,8 +24,8 @@
 #include <linux/workqueue.h>
 #include <linux/export.h>
 #include <sound/core.h>
-#include "hda_beep.h"
-#include "hda_local.h"
+#include <sound/hda_beep.h>
+#include <sound/hda_local.h>
 
 enum {
 	DIGBEEP_HZ_STEP = 46875,	/* 46.875 Hz */
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 2fe86d2e1b09..5eb244a02b59 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -27,14 +27,14 @@
 #include <linux/module.h>
 #include <linux/async.h>
 #include <sound/core.h>
-#include "hda_codec.h"
+#include <sound/hda_codec.h>
 #include <sound/asoundef.h>
 #include <sound/tlv.h>
 #include <sound/initval.h>
 #include <sound/jack.h>
-#include "hda_local.h"
-#include "hda_beep.h"
-#include "hda_jack.h"
+#include <sound/hda_local.h>
+#include <sound/hda_beep.h>
+#include <sound/hda_jack.h>
 #include <sound/hda_hwdep.h>
 
 #define CREATE_TRACE_POINTS
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 0cfc9c8c4b4e..5ae5fcb9b8a9 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -30,8 +30,8 @@
 #include <linux/reboot.h>
 #include <sound/core.h>
 #include <sound/initval.h>
-#include "hda_priv.h"
-#include "hda_controller.h"
+#include <sound/hda_priv.h>
+#include <sound/hda_controller.h>
 
 #define CREATE_TRACE_POINTS
 #include "hda_intel_trace.h"
diff --git a/sound/pci/hda/hda_eld.c b/sound/pci/hda/hda_eld.c
index 0e6d7534f491..f1b6493c65d9 100644
--- a/sound/pci/hda/hda_eld.c
+++ b/sound/pci/hda/hda_eld.c
@@ -26,8 +26,8 @@
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <asm/unaligned.h>
-#include "hda_codec.h"
-#include "hda_local.h"
+#include <sound/hda_codec.h>
+#include <sound/hda_local.h>
 
 enum eld_versions {
 	ELD_VER_CEA_861D	= 2,
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index b680b4ec6331..bac07550f7be 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -32,12 +32,12 @@
 #include <sound/core.h>
 #include <sound/jack.h>
 #include <sound/tlv.h>
-#include "hda_codec.h"
-#include "hda_local.h"
-#include "hda_auto_parser.h"
-#include "hda_jack.h"
-#include "hda_beep.h"
-#include "hda_generic.h"
+#include <sound/hda_codec.h>
+#include <sound/hda_local.h>
+#include <sound/hda_auto_parser.h>
+#include <sound/hda_jack.h>
+#include <sound/hda_beep.h>
+#include <sound/hda_generic.h>
 
 
 /**
diff --git a/sound/pci/hda/hda_hwdep.c b/sound/pci/hda/hda_hwdep.c
index 014a7849e8fd..8b17ad1cbb1b 100644
--- a/sound/pci/hda/hda_hwdep.c
+++ b/sound/pci/hda/hda_hwdep.c
@@ -22,8 +22,8 @@
 #include <linux/slab.h>
 #include <linux/compat.h>
 #include <sound/core.h>
-#include "hda_codec.h"
-#include "hda_local.h"
+#include <sound/hda_codec.h>
+#include <sound/hda_local.h>
 #include <sound/hda_hwdep.h>
 #include <sound/minors.h>
 
diff --git a/sound/pci/hda/hda_i915.c b/sound/pci/hda/hda_i915.c
index d4d0375ac181..ca15d465c8b0 100644
--- a/sound/pci/hda/hda_i915.c
+++ b/sound/pci/hda/hda_i915.c
@@ -20,7 +20,7 @@
 #include <linux/module.h>
 #include <sound/core.h>
 #include <drm/i915_powerwell.h>
-#include "hda_priv.h"
+#include <sound/hda_priv.h>
 #include "hda_i915.h"
 
 /* Intel HSW/BDW display HDA controller Extended Mode registers.
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index d426a0bd6a5f..70606016843b 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -60,9 +60,9 @@
 #include <linux/vgaarb.h>
 #include <linux/vga_switcheroo.h>
 #include <linux/firmware.h>
-#include "hda_codec.h"
-#include "hda_controller.h"
-#include "hda_priv.h"
+#include <sound/hda_codec.h>
+#include <sound/hda_controller.h>
+#include <sound/hda_priv.h>
 #include "hda_i915.h"
 
 /* position fix mode */
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index e664307617bd..bcaee91e655e 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -15,10 +15,10 @@
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/jack.h>
-#include "hda_codec.h"
-#include "hda_local.h"
-#include "hda_auto_parser.h"
-#include "hda_jack.h"
+#include <sound/hda_codec.h>
+#include <sound/hda_local.h>
+#include <sound/hda_auto_parser.h>
+#include <sound/hda_jack.h>
 
 /**
  * is_jack_detectable - Check whether the given pin is jack-detectable
diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index ce5a6da83419..9c60c8cbe89d 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -25,8 +25,8 @@
 #include <linux/slab.h>
 #include <sound/core.h>
 #include <linux/module.h>
-#include "hda_codec.h"
-#include "hda_local.h"
+#include <sound/hda_codec.h>
+#include <sound/hda_local.h>
 
 static int dump_coef = -1;
 module_param(dump_coef, int, 0644);
diff --git a/sound/pci/hda/hda_sysfs.c b/sound/pci/hda/hda_sysfs.c
index ccc962a1699f..b25001cc3f83 100644
--- a/sound/pci/hda/hda_sysfs.c
+++ b/sound/pci/hda/hda_sysfs.c
@@ -14,8 +14,8 @@
 #include <linux/string.h>
 #include <linux/export.h>
 #include <sound/core.h>
-#include "hda_codec.h"
-#include "hda_local.h"
+#include <sound/hda_codec.h>
+#include <sound/hda_local.h>
 #include <sound/hda_hwdep.h>
 #include <sound/minors.h>
 
-- 
1.7.9.5
