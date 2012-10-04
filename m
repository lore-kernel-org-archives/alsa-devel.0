From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/2] ASoC: Fix wrong include for McPDM
Date: Thu,  4 Oct 2012 11:27:15 +0300
Message-ID: <1349339236-3622-2-git-send-email-peter.ujfalusi@ti.com>
References: <1349339236-3622-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1349339236-3622-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Tony Lindgren <tony@atomide.com>

McPDM needs platt/cpu.h for omap_rev and not omap_hwmod.h.
Drivers must not include omap_hwmod.h at, it will be
private to mach-omap2 soon. Fix the problem before other
drivers will also start including omap_hwmod.h.

Note that also plat/cpu.h will be going away, so the
omap_rev check needs to be replaced with mcpdm-watchdog
flag from platform_data or DT.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 sound/soc/omap/omap-mcpdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 7755650..fdf655e 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -40,7 +40,7 @@
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 
-#include <plat/omap_hwmod.h>
+#include <plat/cpu.h>
 #include "omap-mcpdm.h"
 #include "omap-pcm.h"
 
-- 
1.7.12

