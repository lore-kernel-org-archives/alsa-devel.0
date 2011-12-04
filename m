From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Make SND_SOC_MX27VIS_AIC32X4 depend on
	I2C
Date: Sun, 04 Dec 2011 16:11:16 +0800
Message-ID: <1322986276.22605.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BB47245E8
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2011 09:11:33 +0100 (CET)
Received: by iakr3 with SMTP id r3so2527868iak.38
	for <alsa-devel@alsa-project.org>; Sun, 04 Dec 2011 00:11:30 -0800 (PST)
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, Eric =?ISO-8859-1?Q?B=E9nard?= <eric@eukrea.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

SND_SOC_MX27VIS_AIC32X4 selects SND_SOC_TLV320AIC32X4,
but SND_SOC_TLV320AIC32X4 needs CONFIG_I2C.
So we need to make SND_SOC_MX27VIS_AIC32X4 depend on I2C.
otherwise I got below build error if CONFIG_I2C is not selected.

  CC      sound/soc/codecs/tlv320aic32x4.o
sound/soc/codecs/tlv320aic32x4.c: In function 'aic32x4_read':
sound/soc/codecs/tlv320aic32x4.c:323: error: implicit declaration of function 'i2c_smbus_read_byte_data'
sound/soc/codecs/tlv320aic32x4.c: In function 'aic32x4_probe':
sound/soc/codecs/tlv320aic32x4.c:641: error: 'i2c_master_send' undeclared (first use in this function)
sound/soc/codecs/tlv320aic32x4.c:641: error: (Each undeclared identifier is reported only once
sound/soc/codecs/tlv320aic32x4.c:641: error: for each function it appears in.)
sound/soc/codecs/tlv320aic32x4.c: In function 'aic32x4_modinit':
sound/soc/codecs/tlv320aic32x4.c:763: error: implicit declaration of function 'i2c_add_driver'
sound/soc/codecs/tlv320aic32x4.c: In function 'aic32x4_exit':
sound/soc/codecs/tlv320aic32x4.c:774: error: implicit declaration of function 'i2c_del_driver'
make[3]: *** [sound/soc/codecs/tlv320aic32x4.o] Error 1
make[2]: *** [sound/soc/codecs] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/imx/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index b133bfc..7383917 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -28,7 +28,7 @@ config SND_MXC_SOC_WM1133_EV1
 
 config SND_SOC_MX27VIS_AIC32X4
 	tristate "SoC audio support for Visstrim M10 boards"
-	depends on MACH_IMX27_VISSTRIM_M10
+	depends on MACH_IMX27_VISSTRIM_M10 && I2C
 	select SND_SOC_TLV320AIC32X4
 	select SND_MXC_SOC_MX2
 	help
-- 
1.7.5.4
