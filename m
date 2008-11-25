From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 11/13] ASoC: Fix TWL4030 Kconfig dependency
Date: Tue, 25 Nov 2008 15:44:47 +0000
Message-ID: <1227627889-8373-11-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081125154302.GA8319@rakim.wolfsonmicro.main>
	<1227627889-8373-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-8-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-9-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1227627889-8373-10-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6FB9B24490
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2008 16:44:52 +0100 (CET)
In-Reply-To: <1227627889-8373-10-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Arun KS <arunks@mistralsolutions.com>
List-Id: alsa-devel@alsa-project.org

From: Arun KS <arunks@mistralsolutions.com>

Fixes Kconfig dependency of TWL4030 audio codec driver
with TWL4030 core driver on both overo and omap2evm
boards

Signed-off-by: Arun KS <arunks@mistralsolutions.com>
Acked-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
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
1.5.6.5
