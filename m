From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 2/6] ASoC: Intel: Skylake: move NHLT header
	to common directory
Date: Thu, 23 May 2019 18:39:47 -0500
Message-ID: <20190523233951.31122-3-pierre-louis.bossart@linux.intel.com>
References: <20190523233951.31122-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7E1F8F89674
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 01:40:36 +0200 (CEST)
In-Reply-To: <20190523233951.31122-1-pierre-louis.bossart@linux.intel.com>
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
 sound/soc/intel/{skylake/skl-nhlt.h => common/intel-nhlt.h} | 0
 sound/soc/intel/skylake/skl-nhlt.c                          | 1 +
 sound/soc/intel/skylake/skl-ssp-clk.c                       | 1 +
 sound/soc/intel/skylake/skl-topology.c                      | 1 +
 sound/soc/intel/skylake/skl.h                               | 1 -
 5 files changed, 3 insertions(+), 1 deletion(-)
 rename sound/soc/intel/{skylake/skl-nhlt.h => common/intel-nhlt.h} (100%)

diff --git a/sound/soc/intel/skylake/skl-nhlt.h b/sound/soc/intel/common/intel-nhlt.h
similarity index 100%
rename from sound/soc/intel/skylake/skl-nhlt.h
rename to sound/soc/intel/common/intel-nhlt.h
diff --git a/sound/soc/intel/skylake/skl-nhlt.c b/sound/soc/intel/skylake/skl-nhlt.c
index 5d125a3df527..8c72b737c1fa 100644
--- a/sound/soc/intel/skylake/skl-nhlt.c
+++ b/sound/soc/intel/skylake/skl-nhlt.c
@@ -18,6 +18,7 @@
  *
  */
 #include <linux/pci.h>
+#include "../common/intel-nhlt.h"
 #include "skl.h"
 #include "skl-i2s.h"
 
diff --git a/sound/soc/intel/skylake/skl-ssp-clk.c b/sound/soc/intel/skylake/skl-ssp-clk.c
index cda1b5fa7436..55a066c22c81 100644
--- a/sound/soc/intel/skylake/skl-ssp-clk.c
+++ b/sound/soc/intel/skylake/skl-ssp-clk.c
@@ -14,6 +14,7 @@
 #include "skl.h"
 #include "skl-ssp-clk.h"
 #include "skl-topology.h"
+#include "../common/intel-nhlt.h"
 
 #define to_skl_clk(_hw)	container_of(_hw, struct skl_clk, hw)
 
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 389f1862bc43..a900c38328d5 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -30,6 +30,7 @@
 #include "skl.h"
 #include "../common/sst-dsp.h"
 #include "../common/sst-dsp-priv.h"
+#include "../common/intel-nhlt.h"
 
 #define SKL_CH_FIXUP_MASK		(1 << 0)
 #define SKL_RATE_FIXUP_MASK		(1 << 1)
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index 85f8bb6687dc..f0a15cb3d311 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -25,7 +25,6 @@
 #include <sound/hdaudio_ext.h>
 #include <sound/hda_codec.h>
 #include <sound/soc.h>
-#include "skl-nhlt.h"
 #include "skl-ssp-clk.h"
 
 #define SKL_SUSPEND_DELAY 2000
-- 
2.20.1
