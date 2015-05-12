From: libin.yang@intel.com
Subject: [PATCH 3/3] ALSA: hda - add hda_intel_trace.h
Date: Tue, 12 May 2015 09:43:22 +0800
Message-ID: <1431395002-111613-3-git-send-email-libin.yang@intel.com>
References: <1431395002-111613-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E7AD92651D8
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2015 03:51:10 +0200 (CEST)
In-Reply-To: <1431395002-111613-1-git-send-email-libin.yang@intel.com>
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
Cc: Libin Yang <libin.yang@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

This patch creates hda_intel_trace.h to add some pm trace functions
used in hda_intel.c

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/pci/hda/Makefile          |  1 +
 sound/pci/hda/hda_intel.c       |  9 +++++++
 sound/pci/hda/hda_intel_trace.h | 53 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index c5e6651..9c259ce 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -11,6 +11,7 @@ snd-hda-codec-$(CONFIG_SND_HDA_INPUT_BEEP) += hda_beep.o
 
 # for trace-points
 CFLAGS_hda_controller.o := -I$(src)
+CFLAGS_hda_intel.o := -I$(src)
 
 snd-hda-codec-generic-objs :=	hda_generic.o
 snd-hda-codec-realtek-objs :=	patch_realtek.o
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 706879a..5c84d40 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -64,6 +64,9 @@
 #include "hda_controller.h"
 #include "hda_intel.h"
 
+#define CREATE_TRACE_POINTS
+#include "hda_intel_trace.h"
+
 /* position fix mode */
 enum {
 	POS_FIX_AUTO,
@@ -831,6 +834,8 @@ static int azx_suspend(struct device *dev)
 	if (chip->driver_caps & AZX_DCAPS_I915_POWERWELL
 		&& hda->need_i915_power)
 		hda_display_power(hda, false);
+
+	trace_azx_suspend(chip);
 	return 0;
 }
 
@@ -864,6 +869,8 @@ static int azx_resume(struct device *dev)
 	hda_intel_init_chip(chip, true);
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
+
+	trace_azx_resume(chip);
 	return 0;
 }
 #endif /* CONFIG_PM_SLEEP || SUPPORT_VGA_SWITCHEROO */
@@ -897,6 +904,7 @@ static int azx_runtime_suspend(struct device *dev)
 		&& hda->need_i915_power)
 		hda_display_power(hda, false);
 
+	trace_azx_runtime_suspend(chip);
 	return 0;
 }
 
@@ -945,6 +953,7 @@ static int azx_runtime_resume(struct device *dev)
 	azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) &
 			~STATESTS_INT_MASK);
 
+	trace_azx_runtime_resume(chip);
 	return 0;
 }
 
diff --git a/sound/pci/hda/hda_intel_trace.h b/sound/pci/hda/hda_intel_trace.h
index e69de29..0922d8b 100644
--- a/sound/pci/hda/hda_intel_trace.h
+++ b/sound/pci/hda/hda_intel_trace.h
@@ -0,0 +1,53 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM hda_intel
+#define TRACE_INCLUDE_FILE hda_intel_trace
+
+#if !defined(_TRACE_HDA_INTEL_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_HDA_INTEL_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(hda_pm,
+	TP_PROTO(struct azx *chip),
+
+	TP_ARGS(chip),
+
+	TP_STRUCT__entry(
+		__field(int, dev_index)
+	),
+
+	TP_fast_assign(
+		__entry->dev_index = (chip)->dev_index;
+	),
+
+	TP_printk("card index: %d", __entry->dev_index)
+);
+
+DEFINE_EVENT(hda_pm, azx_suspend,
+	TP_PROTO(struct azx *chip),
+	TP_ARGS(chip)
+);
+
+DEFINE_EVENT(hda_pm, azx_resume,
+	TP_PROTO(struct azx *chip),
+	TP_ARGS(chip)
+);
+
+#ifdef CONFIG_PM
+DEFINE_EVENT(hda_pm, azx_runtime_suspend,
+	TP_PROTO(struct azx *chip),
+	TP_ARGS(chip)
+);
+
+DEFINE_EVENT(hda_pm, azx_runtime_resume,
+	TP_PROTO(struct azx *chip),
+	TP_ARGS(chip)
+);
+#endif
+
+#endif /* _TRACE_HDA_INTEL_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#include <trace/define_trace.h>
-- 
1.9.1
