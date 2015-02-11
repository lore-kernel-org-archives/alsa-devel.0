From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>
Subject: [PATCH] ASoC: max98357a: Fix missing include
Date: Wed, 11 Feb 2015 23:08:59 +0100
Message-ID: <1423692539-31333-1-git-send-email-vincent.stehle@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@laposte.net>, Kenneth Westfield <kwestfie@codeaurora.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

This fixes the following compilation errors:

  sound/soc/codecs/max98357a.c: In function =E2=80=98max98357a_daiops_t=
rigger=E2=80=99:
  sound/soc/codecs/max98357a.c:30:3: error: implicit declaration of fun=
ction =E2=80=98gpiod_set_value=E2=80=99 [-Werror=3Dimplicit-function-de=
claration]
  sound/soc/codecs/max98357a.c: In function =E2=80=98max98357a_codec_pr=
obe=E2=80=99:
  sound/soc/codecs/max98357a.c:55:2: error: implicit declaration of fun=
ction =E2=80=98devm_gpiod_get=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]
  sound/soc/codecs/max98357a.c:61:2: error: implicit declaration of fun=
ction =E2=80=98gpiod_direction_output=E2=80=99 [-Werror=3Dimplicit-func=
tion-declaration]
  cc1: some warnings being treated as errors

Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@laposte.net>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>
---


Hi,

Those compilation errors can be seen for example with hppa allmodconfig=
=2E

Best regards,

V.


 sound/soc/codecs/max98357a.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.=
c
index 1806333..f493fb6 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -14,6 +14,7 @@
=20
 #include <linux/module.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <sound/soc.h>
=20
 #define DRV_NAME "max98357a"
--=20
2.1.4
