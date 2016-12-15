From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: include gpio consumer.h" to the asoc tree
Date: Thu, 15 Dec 2016 12:21:08 +0000
Message-ID: <E1cHV24-0000iq-7Q@debutante>
References: <1481096342-19104-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481096342-19104-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, fabf@skynet.be, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: include gpio consumer.h

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

>From 5d079fdc12ffe1f939890035f5172374b5c0f2be Mon Sep 17 00:00:00 2001
From: Fabian Frederick <fabf@skynet.be>
Date: Fri, 9 Dec 2016 19:12:50 +0100
Subject: [PATCH] ASoC: samsung: include gpio consumer.h

Fix the following build errors on X86_32 !GPIOLIB

sound/soc/samsung/tm2_wm5110.c:220:3: error: implicit declaration
of function 'gpiod_set_value_cansleep' [-Werror=implicit-function-declaration]
sound/soc/samsung/tm2_wm5110.c:438:24: error: implicit declaration
of function 'devm_gpiod_get' [-Werror=implicit-function-declaration]

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Fabian Frederick <fabf@skynet.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.11.0
