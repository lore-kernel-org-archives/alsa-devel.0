From: Axel Lin <axel.lin@gmail.com>
Subject: [RFC][PATCH] ASoC: Make wm1250-ev1 depends on GPIOLIB
Date: Tue, 27 Sep 2011 10:49:59 +0800
Message-ID: <1317091799.315.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I got below build error if GPIO support is disabled.
Make wm1250-ev1 depends on GPIOLIB to fix below build error.

  CC      sound/soc/codecs/wm1250-ev1.o
sound/soc/codecs/wm1250-ev1.c:32:14: error: array type has incomplete e=
lement type
sound/soc/codecs/wm1250-ev1.c: In function =E2=80=98wm1250_ev1_pdata=E2=
=80=99:
sound/soc/codecs/wm1250-ev1.c:126:18: warning: type defaults to =E2=80=98=
int=E2=80=99 in type name
sound/soc/codecs/wm1250-ev1.c:126:18: warning: type defaults to =E2=80=98=
int=E2=80=99 in type name
sound/soc/codecs/wm1250-ev1.c:126:18: error: negative width in bit-fiel=
d =E2=80=98<anonymous>=E2=80=99
sound/soc/codecs/wm1250-ev1.c:134:42: warning: type defaults to =E2=80=98=
int=E2=80=99 in type name
sound/soc/codecs/wm1250-ev1.c:134:42: warning: type defaults to =E2=80=98=
int=E2=80=99 in type name
sound/soc/codecs/wm1250-ev1.c:134:42: error: negative width in bit-fiel=
d =E2=80=98<anonymous>=E2=80=99
sound/soc/codecs/wm1250-ev1.c: In function =E2=80=98wm1250_ev1_free=E2=80=
=99:
sound/soc/codecs/wm1250-ev1.c:155:34: warning: type defaults to =E2=80=98=
int=E2=80=99 in type name
sound/soc/codecs/wm1250-ev1.c:155:34: warning: type defaults to =E2=80=98=
int=E2=80=99 in type name
sound/soc/codecs/wm1250-ev1.c:155:34: error: negative width in bit-fiel=
d =E2=80=98<anonymous>=E2=80=99
make[3]: *** [sound/soc/codecs/wm1250-ev1.o] Error 1
make[2]: *** [sound/soc/codecs] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
I got the build error while trying to build for SND_MFLD_MACHINE and SN=
D_SST_PLATFORM.
( "Enable ALSA for SoC audio support" and "Build all ASoC CODEC drivers=
" on X86 )

Axel
 sound/soc/codecs/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 3449431..0ad80fe 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -58,7 +58,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_UDA134X
 	select SND_SOC_UDA1380 if I2C
 	select SND_SOC_WL1273 if MFD_WL1273_CORE
-	select SND_SOC_WM1250_EV1 if I2C
+	select SND_SOC_WM1250_EV1 if I2C && GPIOLIB
 	select SND_SOC_WM2000 if I2C
 	select SND_SOC_WM5100 if I2C
 	select SND_SOC_WM8350 if MFD_WM8350
--=20
1.7.4.1
