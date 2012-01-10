From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH RESEND] ASoC: Fix recursive dependency due to
 select ATMEL_SSC in SND_ATMEL_SOC_SSC
Date: Tue, 10 Jan 2012 14:19:12 +0800
Message-ID: <1326176352.4443.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id F01E31038CB
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2012 07:19:23 +0100 (CET)
Received: by yhjj72 with SMTP id j72so757049yhj.38
	for <alsa-devel@alsa-project.org>; Mon, 09 Jan 2012 22:19:23 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Bolle <pebolle@tiscali.nl>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

commit 739be96 "ASoC: Fix build dependency for SND_ATMEL_SOC_SSC"
introduces below build warnings:

drivers/misc/Kconfig:212:error: recursive dependency detected!
drivers/misc/Kconfig:212:       symbol ATMEL_SSC is selected by SND_ATMEL_SOC_SSC
sound/soc/atmel/Kconfig:9:      symbol SND_ATMEL_SOC_SSC is selected by SND_AT91_SOC_SAM9G20_WM8731
sound/soc/atmel/Kconfig:18:     symbol SND_AT91_SOC_SAM9G20_WM8731 depends on ATMEL_SSC

SND_ATMEL_SOC_SSC needs ATMEL_SSC to pass compilation.
This patch remove the "select ATMEL_SSC" from SND_ATMEL_SOC_SSC to avoid above
warnings. And then ensures all the machine drivers that select SND_ATMEL_SOC_SSC
need to depend on ATMEL_SSC.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/atmel/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index a4d6742..72b09cf 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -9,7 +9,6 @@ config SND_ATMEL_SOC
 config SND_ATMEL_SOC_SSC
 	tristate
 	depends on SND_ATMEL_SOC
-	select ATMEL_SSC
 	help
 	  Say Y or M if you want to add support for codecs the
 	  ATMEL SSC interface. You will also needs to select the individual
@@ -27,7 +26,7 @@ config SND_AT91_SOC_SAM9G20_WM8731
 
 config SND_AT91_SOC_AFEB9260
 	tristate "SoC Audio support for AFEB9260 board"
-	depends on ARCH_AT91 && MACH_AFEB9260 && SND_ATMEL_SOC
+	depends on ATMEL_SSC && ARCH_AT91 && MACH_AFEB9260 && SND_ATMEL_SOC
 	select SND_ATMEL_SOC_SSC
 	select SND_SOC_TLV320AIC23
 	help
-- 
1.7.5.4
