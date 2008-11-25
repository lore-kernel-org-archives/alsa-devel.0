From: arunks@mistralsolutions.com
Subject: [PATCH] ASoC: Fix TW4030 Kconfig dependency
Date: Tue, 25 Nov 2008 09:56:12 +0530
Message-ID: <1227587172-9523-1-git-send-email-arunks@mistralsolutions.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, david-b@pacbell.net, steve@sakoman.com, Arun KS <arunks@mistralsolutions.com>
List-Id: alsa-devel@alsa-project.org

From: Arun KS <arunks@mistralsolutions.com>

Fixes Kconfig dependency of TWL4030 audio codec driver
with TWL4030 core driver on both overo and omap2evm
boards

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
---
 sound/soc/omap/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
index 6c56277..0900437 100644
--- a/sound/soc/omap/Kconfig
+++ b/sound/soc/omap/Kconfig
@@ -24,7 +24,7 @@ config SND_OMAP_SOC_OSK5912
 
 config SND_OMAP_SOC_OVERO
 	tristate "SoC Audio support for Gumstix Overo"
-	depends on SND_OMAP_SOC && MACH_OVERO
+	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OVERO
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TWL4030
 	help
@@ -32,7 +32,7 @@ config SND_OMAP_SOC_OVERO
 
 config SND_OMAP_SOC_OMAP2EVM
 	tristate "SoC Audio support for OMAP2EVM board"
-	depends on SND_OMAP_SOC && MACH_OMAP2EVM
+	depends on TWL4030_CORE && SND_OMAP_SOC && MACH_OMAP2EVM
 	select SND_OMAP_SOC_MCBSP
 	select SND_SOC_TWL4030
 	help
-- 
1.5.6.3

