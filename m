From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: kirkwood: Make SND_KIRKWOOD_SOC_OPENRD
 and SND_KIRKWOOD_SOC_T5325 depend on I2C
Date: Sat, 03 Dec 2011 18:38:25 +0800
Message-ID: <1322908705.17054.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CBF7124578
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2011 11:38:37 +0100 (CET)
Received: by iakr3 with SMTP id r3so1395444iak.38
	for <alsa-devel@alsa-project.org>; Sat, 03 Dec 2011 02:38:34 -0800 (PST)
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
Cc: Arnaud Patard <apatard@mandriva.com>, Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SND_KIRKWOOD_SOC_T5325 selects SND_SOC_ALC5623, but SND_SOC_ALC5623 needs
CONFIG_I2C. So we need to make SND_KIRKWOOD_SOC_T5325 depend on I2C,
otherwise I got below build error if CONFIG_I2C is not selected.

  CC      sound/soc/codecs/alc5623.o
sound/soc/codecs/alc5623.c: In function 'alc5623_i2c_probe':
sound/soc/codecs/alc5623.c:1002: error: implicit declaration of function 'i2c_smbus_read_word_data'
sound/soc/codecs/alc5623.c:1009: error: implicit declaration of function 'i2c_smbus_read_byte_data'
sound/soc/codecs/alc5623.c: In function 'alc5623_modinit':
sound/soc/codecs/alc5623.c:1096: error: implicit declaration of function 'i2c_add_driver'
sound/soc/codecs/alc5623.c: In function 'alc5623_modexit':
sound/soc/codecs/alc5623.c:1108: error: implicit declaration of function 'i2c_del_driver'
make[3]: *** [sound/soc/codecs/alc5623.o] Error 1
make[2]: *** [sound/soc/codecs] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

Also fix the same issue for SND_KIRKWOOD_SOC_OPENRD.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/kirkwood/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/kirkwood/Kconfig b/sound/soc/kirkwood/Kconfig
index 8f49e16..c62d715 100644
--- a/sound/soc/kirkwood/Kconfig
+++ b/sound/soc/kirkwood/Kconfig
@@ -12,6 +12,7 @@ config SND_KIRKWOOD_SOC_I2S
 config SND_KIRKWOOD_SOC_OPENRD
 	tristate "SoC Audio support for Kirkwood Openrd Client"
 	depends on SND_KIRKWOOD_SOC && (MACH_OPENRD_CLIENT || MACH_OPENRD_ULTIMATE)
+	depends on I2C
 	select SND_KIRKWOOD_SOC_I2S
 	select SND_SOC_CS42L51
 	help
@@ -20,7 +21,7 @@ config SND_KIRKWOOD_SOC_OPENRD
 
 config SND_KIRKWOOD_SOC_T5325
 	tristate "SoC Audio support for HP t5325"
-	depends on SND_KIRKWOOD_SOC && MACH_T5325
+	depends on SND_KIRKWOOD_SOC && MACH_T5325 && I2C
 	select SND_KIRKWOOD_SOC_I2S
 	select SND_SOC_ALC5623
 	help
-- 
1.7.5.4
