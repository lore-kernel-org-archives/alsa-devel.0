From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 1/5] ASoC: Intel: Skylake: move NHLT header
	to common directory
Date: Fri, 19 Jul 2019 15:37:48 -0500
Message-ID: <20190719203752.11151-2-pierre-louis.bossart@linux.intel.com>
References: <20190719203752.11151-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 23D55F80228
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2019 22:37:57 +0200 (CEST)
In-Reply-To: <20190719203752.11151-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>, Hui Wang <hui.wang@canonical.com>, Curtis Malainey <cujomalainey@google.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Prepare move from NHLT code to common directory, starting with header.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/skylake/skl-nhlt.h => include/sound/intel-nhlt.h | 0
 sound/soc/intel/skylake/skl-nhlt.c                               | 1 +
 sound/soc/intel/skylake/skl-ssp-clk.c                            | 1 +
 sound/soc/intel/skylake/skl-topology.c                           | 1 +
 sound/soc/intel/skylake/skl.h                                    | 1 -
 5 files changed, 3 insertions(+), 1 deletion(-)
 rename sound/soc/intel/skylake/skl-nhlt.h => include/sound/intel-nhlt.h (100%)

diff --git a/sound/soc/intel/skylake/skl-nhlt.h b/include/sound/intel-nhlt.h
similarity index 100%
rename from sound/soc/intel/skylake/skl-nhlt.h
rename to include/sound/intel-nhlt.h
diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index 1132109cb992..aabc5d71650e 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -9,6 +9,7 @@
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 #include <linux/pci.h>
+#include <sound/intel-nhlt.h>
 #include "skl.h"
 #include "skl-i2s.h"
 
diff --git a/sound/soc/intel/skylake/skl-ssp-clk.c b/sound/soc/intel/skylake/skl-ssp-clk.c
index 5bb6e40d4d3e..5bfcd46452f9 100644
--- a/sound/soc/intel/skylake/skl-ssp-clk.c
+++ b/sound/soc/intel/skylake/skl-ssp-clk.c
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
+#include <sound/intel-nhlt.h>
 #include "skl.h"
 #include "skl-ssp-clk.h"
 #include "skl-topology.h"
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 6241e35213af..f8a501cf5fbd 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <linux/firmware.h>
 #include <linux/uuid.h>
+#include <sound/intel-nhlt.h>
 #include <sound/soc.h>
 #include <sound/soc-topology.h>
 #include <uapi/sound/snd_sst_tokens.h>
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 6070666a6392..928e8115a1a7 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -16,7 +16,6 @@
 #include <sound/hdaudio_ext.h>
 #include <sound/hda_codec.h>
 #include <sound/soc.h>
-#include "skl-nhlt.h"
 #include "skl-ssp-clk.h"
 
 #define SKL_SUSPEND_DELAY 2000
-- 
2.20.1
