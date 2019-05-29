From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42xx8: Fix build error with CONFIG_GPIOLIB is not set" to the asoc tree
Date: Wed, 29 May 2019 16:45:27 +0100 (BST)
Message-ID: <20190529154527.8B003440049@finisterre.sirena.org.uk>
References: <20190529033002.16606-1-shengjiu.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190529033002.16606-1-shengjiu.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: alsa-devel@alsa-project.org, brian.austin@cirrus.com, broonie@kernel.org, kbuild test robot <lkp@intel.com>, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, Paul.Handrigan@cirrus.com, perex@perex.cz, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42xx8: Fix build error with CONFIG_GPIOLIB is not set

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 7cda6223503d592f980a222811355ab07611b821 Mon Sep 17 00:00:00 2001
From: Shengjiu Wang <shengjiu.wang@nxp.com>
Date: Wed, 29 May 2019 11:30:02 +0800
Subject: [PATCH] ASoC: cs42xx8: Fix build error with CONFIG_GPIOLIB is not set
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

config: x86_64-randconfig-x000201921-201921
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        make ARCH=x86_64

sound/soc/codecs/cs42xx8.c: In function ‘cs42xx8_probe’:
sound/soc/codecs/cs42xx8.c:472:25: error: implicit declaration of function ‘devm_gpiod_get_optional’; did you mean ‘devm_clk_get_optional’? [-Werror=implicit-function-declaration]
  cs42xx8->gpiod_reset = devm_gpiod_get_optional(dev, "reset",
                         ^~~~~~~~~~~~~~~~~~~~~~~
                         devm_clk_get_optional
sound/soc/codecs/cs42xx8.c:473:8: error: ‘GPIOD_OUT_HIGH’ undeclared (first use in this function); did you mean ‘GPIOF_INIT_HIGH’?
        GPIOD_OUT_HIGH);
        ^~~~~~~~~~~~~~
        GPIOF_INIT_HIGH
sound/soc/codecs/cs42xx8.c:473:8: note: each undeclared identifier is reported only once for each function it appears in
sound/soc/codecs/cs42xx8.c:477:2: error: implicit declaration of function ‘gpiod_set_value_cansleep’; did you mean ‘gpio_set_value_cansleep’? [-Werror=implicit-function-declaration]
  gpiod_set_value_cansleep(cs42xx8->gpiod_reset, 0);
  ^~~~~~~~~~~~~~~~~~~~~~~~
  gpio_set_value_cansleep

Fixes: bfe95dfa4dac ("ASoC: cs42xx8: Add reset gpio handling")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42xx8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index b377cddaf2e6..6203f54d9f25 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -14,7 +14,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <sound/pcm_params.h>
-- 
2.20.1
