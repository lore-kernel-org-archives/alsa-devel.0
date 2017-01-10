From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: tm2_wm5110: include gpio/consumer.h
Date: Tue, 10 Jan 2017 16:30:50 +0100
Message-ID: <20170110153104.3143248-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>, Sangbeom Kim <sbkim73@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Inha Song <ideal.song@samsung.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

gpiod_set_value_cansleep is declared in linux/gpio/consumer.h, but that
is not always included implicitly, so we have to include both
gpio.h and gpio/consumer.h here:

sound/soc/samsung/tm2_wm5110.c: In function 'tm2_mic_bias':
sound/soc/samsung/tm2_wm5110.c:220:3: error: implicit declaration of function 'gpiod_set_value_cansleep';did you mean 'gpio_set_value_cansleep'? [-Werror=implicit-function-declaration]

Fixes: 1bfbc260a5b4 ("ASoC: samsung: Add machine driver for Exynos5433 based TM2 board")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/samsung/tm2_wm5110.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/samsung/tm2_wm5110.c b/sound/soc/samsung/tm2_wm5110.c
index 5cdf7d19b87f..24cc9d63ce87 100644
--- a/sound/soc/samsung/tm2_wm5110.c
+++ b/sound/soc/samsung/tm2_wm5110.c
@@ -12,6 +12,7 @@
 
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <sound/pcm_params.h>
-- 
2.9.0
