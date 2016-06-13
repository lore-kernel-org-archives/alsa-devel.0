From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs53l30: include gpio/consumer.h" to the asoc tree
Date: Mon, 13 Jun 2016 17:54:52 +0100
Message-ID: <E1bCV8W-0004eQ-0K@finisterre>
References: <1465832422-2998958-3-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465832422-2998958-3-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Brian Austin <brian.austin@cirrus.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs53l30: include gpio/consumer.h

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 53d4b031e3c31cc6160c2d0cdc326fb74280d239 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 13 Jun 2016 17:39:44 +0200
Subject: [PATCH] ASoC: cs53l30: include gpio/consumer.h

When GPIOLIB is disabled, we don't see the declarations from
gpio/consumer.h, so we have to include the header explicitly
to avoid this build error:

sound/soc/codecs/cs53l30.c: In function 'cs53l30_i2c_probe':
sound/soc/codecs/cs53l30.c:931:24: error: implicit declaration of function 'devm_gpiod_get_optional' [-Werror=implicit-function-declaration]
  cs53l30->reset_gpio = devm_gpiod_get_optional(dev, reset,
                        ^~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/cs53l30.c:932:13: error: 'GPIOD_OUT_LOW' undeclared (first use in this function)
             GPIOD_OUT_LOW);
             ^~~~~~~~~~~~~
sound/soc/codecs/cs53l30.c:932:13: note: each undeclared identifier is reported only once for each function it appears in
sound/soc/codecs/cs53l30.c:939:3: error: implicit declaration of function 'gpiod_set_value_cansleep' [-Werror=implicit-function-declaration]
   gpiod_set_value_cansleep(cs53l30->reset_gpio, 1);

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs53l30.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index ac90dd79857e..aa511e70099e 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -17,6 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
-- 
2.8.1
