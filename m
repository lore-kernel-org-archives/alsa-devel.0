From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCHv2] ASoC: Intel: Rename SST trace event header
	to be less generic.
Date: Tue, 18 Feb 2014 11:43:16 +0000
Message-ID: <1392723796-4773-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id EB58E265268
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:43:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The Intel audio DSP SST trace event header has been renamed from sst.h
to intel-sst.h in order to avoid any confusion with any future
Samoa Standard Time drivers ;)

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/trace/events/{sst.h => intel-sst.h} | 6 +++---
 sound/soc/intel/sst-dsp.c                   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)
 rename include/trace/events/{sst.h => intel-sst.h} (94%)

diff --git a/include/trace/events/sst.h b/include/trace/events/intel-sst.h
similarity index 94%
rename from include/trace/events/sst.h
rename to include/trace/events/intel-sst.h
index 1a0d6b3..76c72d3 100644
--- a/include/trace/events/sst.h
+++ b/include/trace/events/intel-sst.h
@@ -1,8 +1,8 @@
 #undef TRACE_SYSTEM
-#define TRACE_SYSTEM sst
+#define TRACE_SYSTEM intel-sst
 
-#if !defined(_TRACE_SST_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _TRACE_SST_H
+#if !defined(_TRACE_INTEL_SST_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_INTEL_SST_H
 
 #include <linux/types.h>
 #include <linux/ktime.h>
diff --git a/sound/soc/intel/sst-dsp.c b/sound/soc/intel/sst-dsp.c
index 1888de5..e0ad2e5 100644
--- a/sound/soc/intel/sst-dsp.c
+++ b/sound/soc/intel/sst-dsp.c
@@ -24,7 +24,7 @@
 #include "sst-dsp-priv.h"
 
 #define CREATE_TRACE_POINTS
-#include <trace/events/sst.h>
+#include <trace/events/intel-sst.h>
 
 /* Public API */
 void sst_dsp_shim_write(struct sst_dsp *sst, u32 offset, u32 value)
-- 
1.8.3.2
