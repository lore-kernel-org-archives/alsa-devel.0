From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 1/2] ASoC: Intel: Rename SST trace event header
	to be less generic.
Date: Tue, 18 Feb 2014 10:41:49 +0000
Message-ID: <1392720110-4278-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A54B265162
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 11:42:13 +0100 (CET)
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
 include/trace/events/{sst.h => intel-sst.h} | 0
 sound/soc/intel/sst-dsp.c                   | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename include/trace/events/{sst.h => intel-sst.h} (100%)

diff --git a/include/trace/events/sst.h b/include/trace/events/intel-sst.h
similarity index 100%
rename from include/trace/events/sst.h
rename to include/trace/events/intel-sst.h
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
