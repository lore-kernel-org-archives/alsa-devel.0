From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Fix build dependency for
	SND_ATMEL_SOC_SSC
Date: Fri, 06 Jan 2012 14:54:24 +0800
Message-ID: <1325832864.31496.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 14555103B39
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2012 07:54:35 +0100 (CET)
Received: by yenr11 with SMTP id r11so554854yen.38
	for <alsa-devel@alsa-project.org>; Thu, 05 Jan 2012 22:54:34 -0800 (PST)
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
Cc: Sedji Gaouaou <sedji.gaouaou@atmel.com>, Paul Bolle <pebolle@tiscali.nl>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Make SND_ATMEL_SOC_SSC select ATMEL_SSC to fix below build errors:

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
This patch is against linux-next 20120103.
 sound/soc/atmel/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
index d1fcc81..a4d6742 100644
--- a/sound/soc/atmel/Kconfig
+++ b/sound/soc/atmel/Kconfig
@@ -9,6 +9,7 @@ config SND_ATMEL_SOC
 config SND_ATMEL_SOC_SSC
 	tristate
 	depends on SND_ATMEL_SOC
+	select ATMEL_SSC
 	help
 	  Say Y or M if you want to add support for codecs the
 	  ATMEL SSC interface. You will also needs to select the individual
-- 
1.7.5.4
