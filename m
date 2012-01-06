From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Fix build dependency for
	SND_AT91_SOC_AFEB9260
Date: Fri, 06 Jan 2012 15:51:59 +0800
Message-ID: <1325836319.22753.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FA9C2414E
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2012 08:52:11 +0100 (CET)
Received: by iaae16 with SMTP id e16so2242284iaa.38
	for <alsa-devel@alsa-project.org>; Thu, 05 Jan 2012 23:52:10 -0800 (PST)
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
Cc: Paul Bolle <pebolle@tiscali.nl>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Make SND_AT91_SOC_AFEB9260 depend on ATMEL_SSC to fix below build errors:

  LD      .tmp_vmlinux1
sound/built-in.o: In function `atmel_ssc_remove':
sound/soc/atmel/atmel_ssc_dai.c:713: undefined reference to `ssc_free'
sound/built-in.o: In function `atmel_ssc_probe':
sound/soc/atmel/atmel_ssc_dai.c:700: undefined reference to `ssc_request'
sound/built-in.o: In function `atmel_ssc_set_audio':
sound/soc/atmel/atmel_ssc_dai.c:845: undefined reference to `ssc_request'
sound/soc/atmel/atmel_ssc_dai.c:851: undefined reference to `ssc_free'
make: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
This patch replaces "[PATCH] ASoC: Fix build dependency for SND_ATMEL_SOC_SSC".

 sound/soc/atmel/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index d1fcc81..72b09cf 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -26,7 +26,7 @@ config SND_AT91_SOC_SAM9G20_WM8731
 
 config SND_AT91_SOC_AFEB9260
 	tristate "SoC Audio support for AFEB9260 board"
-	depends on ARCH_AT91 && MACH_AFEB9260 && SND_ATMEL_SOC
+	depends on ATMEL_SSC && ARCH_AT91 && MACH_AFEB9260 && SND_ATMEL_SOC
 	select SND_ATMEL_SOC_SSC
 	select SND_SOC_TLV320AIC23
 	help
-- 
1.7.5.4
