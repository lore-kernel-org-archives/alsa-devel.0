From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] ASoC: rt5677: add build dependency to spi
Date: Fri, 17 Oct 2014 11:56:42 -0700
Message-ID: <1413572202-18646-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f202.google.com (mail-ie0-f202.google.com
 [209.85.223.202])
 by alsa0.perex.cz (Postfix) with ESMTP id D2BEE2652E8
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 20:56:48 +0200 (CEST)
Received: by mail-ie0-f202.google.com with SMTP id rd18so186933iec.1
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 11:56:47 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Since 9cb715a9d4c the codec has a hardcoded dependency to spi.
Add this dependency to Kconfig. It fixes buildbot compilation failure:

   sound/built-in.o: In function `spi_write':
>> rt5677-spi.c:(.text+0x8265f): undefined reference to `spi_sync'
   sound/built-in.o: In function `rt5677_spi_driver_init':
>> rt5677-spi.c:(.init.text+0x17db): undefined reference to `spi_register_driver'

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 8838838e..1ff565e 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -81,7 +81,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_RT5645 if I2C
 	select SND_SOC_RT5651 if I2C
 	select SND_SOC_RT5670 if I2C
-	select SND_SOC_RT5677 if I2C
+	select SND_SOC_RT5677 if I2C && SPI_MASTER
 	select SND_SOC_SGTL5000 if I2C
 	select SND_SOC_SI476X if MFD_SI476X_CORE
 	select SND_SOC_SIRF_AUDIO_CODEC
-- 
2.1.0.rc2.206.gedb03e5
