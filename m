From: shengjiu.wang@nxp.com
Subject: [PATCH] ASoC: cs42xx8: Fix build error with CONFIG_GPIOLIB is not set
Date: Wed, 29 May 2019 11:30:02 +0800
Message-ID: <20190529033002.16606-1-shengjiu.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Shengjiu Wang <shengjiu.wang@nxp.com>

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
---
 sound/soc/codecs/cs42xx8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index 3e8dbf63adbe..3bbc62322dfe 100644
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
2.21.0
