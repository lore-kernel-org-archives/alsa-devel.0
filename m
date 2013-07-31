From: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] SOUND: au1x: Fix build
Date: Wed, 31 Jul 2013 10:15:19 +0200
Message-ID: <20130731081519.GA18756@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Manuel Lauss <manuel.lauss@gmail.com>, Mark Brown <broonie@linaro.org>, linux-mips@linux-mips.org
List-Id: alsa-devel@alsa-project.org

d8b51c11ff5a70244753ba60abfd47088cf4dcd4 [ASoC: ac97c: Use
module_platform_driver()] broke the build:

 CC      sound/soc/au1x/ac97c.o
/home/ralf/src/linux/upstream-sfr/sound/soc/au1x/ac97c.c:344:1: error: =
expected identifier or =E2=80=98(=E2=80=99 before =E2=80=98&=E2=80=99 t=
oken
/home/ralf/src/linux/upstream-sfr/sound/soc/au1x/ac97c.c:344:1: error: =
pasting "__initcall_" and "&" does not give a valid preprocessing token
/home/ralf/src/linux/upstream-sfr/sound/soc/au1x/ac97c.c:344:1: error: =
expected =E2=80=98=3D=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99=
, =E2=80=98asm=E2=80=99 or =E2=80=98__attribute__=E2=80=99 before =E2=80=
=98&=E2=80=99 token
/home/ralf/src/linux/upstream-sfr/sound/soc/au1x/ac97c.c:344:1: error: =
expected identifier or =E2=80=98(=E2=80=99 before =E2=80=98&=E2=80=99 t=
oken
/home/ralf/src/linux/upstream-sfr/sound/soc/au1x/ac97c.c:344:1: error: =
pasting "__exitcall_" and "&" does not give a valid preprocessing token
/home/ralf/src/linux/upstream-sfr/sound/soc/au1x/ac97c.c:344:1: error: =
expected =E2=80=98=3D=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99=
, =E2=80=98asm=E2=80=99 or =E2=80=98__attribute__=E2=80=99 before =E2=80=
=98&=E2=80=99 token
/home/ralf/src/linux/upstream-sfr/sound/soc/au1x/ac97c.c:334:31: warnin=
g: =E2=80=98au1xac97c_driver=E2=80=99 defined but not used [-Wunused-va=
riable]
make[5]: *** [sound/soc/au1x/ac97c.o] Error 1
make[4]: *** [sound/soc/au1x] Error 2
make[3]: *** [sound/soc] Error 2

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/sound/soc/au1x/ac97c.c b/sound/soc/au1x/ac97c.c
index d6f7694..c8a2de1 100644
--- a/sound/soc/au1x/ac97c.c
+++ b/sound/soc/au1x/ac97c.c
@@ -341,7 +341,7 @@ static struct platform_driver au1xac97c_driver =3D =
{
 	.remove		=3D au1xac97c_drvremove,
 };
=20
-module_platform_driver(&au1xac97c_driver);
+module_platform_driver(au1xac97c_driver);
=20
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Au1000/1500/1100 AC97C ASoC driver");
