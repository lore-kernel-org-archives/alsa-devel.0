From: Ryan Mallon <ryan@bluewatersys.com>
Subject: [PATCH] Fix Atmel soc audio boards Kconfig dependency
Date: Thu, 11 Nov 2010 09:02:30 +1300
Message-ID: <4CDAFA56.2050504@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hayes.bluewaternz.com (mail.bluewatersys.com [202.124.120.130])
	by alsa0.perex.cz (Postfix) with ESMTP id BA867243AB
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 21:01:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, gwossum@acm.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Add Kconfig dependency on AT91_PROGRAMMABLE_CLOCKS for the Atmel SoC
audio SAM9G20-EK and PlayPaq boards. Fixes link errors on missing
clk_set_parent and clk_set_rate when building without
AT91_PROGRAMMABLE_CLOCKS.

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index e720d5e..bee3c94 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -16,7 +16,8 @@ config SND_ATMEL_SOC_SSC
 
 config SND_AT91_SOC_SAM9G20_WM8731
 	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
-	depends on ATMEL_SSC && ARCH_AT91SAM9G20 && SND_ATMEL_SOC
+	depends on ATMEL_SSC && ARCH_AT91SAM9G20 && SND_ATMEL_SOC && \
+                   AT91_PROGRAMMABLE_CLOCKS
 	select SND_ATMEL_SOC_SSC
 	select SND_SOC_WM8731
 	help
@@ -25,7 +26,7 @@ config SND_AT91_SOC_SAM9G20_WM8731
 
 config SND_AT32_SOC_PLAYPAQ
         tristate "SoC Audio support for PlayPaq with WM8510"
-        depends on SND_ATMEL_SOC && BOARD_PLAYPAQ
+        depends on SND_ATMEL_SOC && BOARD_PLAYPAQ && AT91_PROGRAMMABLE_CLOCKS
         select SND_ATMEL_SOC_SSC
         select SND_SOC_WM8510
         help
