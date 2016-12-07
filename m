From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1 linux-next] ASoC: samsung: include gpio consumer.h
Date: Wed,  7 Dec 2016 08:39:02 +0100
Message-ID: <1481096342-19104-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, fabf@skynet.be
List-Id: alsa-devel@alsa-project.org

Fix the following build errors
sound/soc/samsung/tm2_wm5110.c:220:3: error: implicit declaration
of function 'gpiod_set_value_cansleep' [-Werror=implicit-function-declaration]
sound/soc/samsung/tm2_wm5110.c:438:24: error: implicit declaration
of function 'devm_gpiod_get' [-Werror=implicit-function-declaration]

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 sound/soc/samsung/tm2_wm5110.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/samsung/tm2_wm5110.c b/sound/soc/samsung/tm2_wm5110.c
index 5cdf7d1..24cc9d6 100644
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
2.7.4
