From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: PCM1789: include
	gpio/consumer.h" to the asoc tree
Date: Thu, 31 May 2018 12:06:36 +0100
Message-ID: <E1fOLPg-00020r-K9@debutante>
References: <c99575a2-5172-b42e-dd18-6bc763fee361@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8000435649959086286=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FA1A267923
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 13:06:43 +0200 (CEST)
In-Reply-To: <c99575a2-5172-b42e-dd18-6bc763fee361@infradead.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alsa-devel@alsa-project.org, kbuild test robot <lkp@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?Q?Myl=c3=a8ne_Josserand?= <mylene.josserand@bootlin.com>
List-Id: alsa-devel@alsa-project.org

--===============8000435649959086286==
Content-Type: text/plain

The patch

   ASoC: codecs: PCM1789: include gpio/consumer.h

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 3217004ad97fdae6663e8e75c443d8e616cb7fd0 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 30 May 2018 23:53:45 +0200
Subject: [PATCH] ASoC: codecs: PCM1789: include gpio/consumer.h

When CONFIG_GPIOLIB is disabled, this codec fails to build
because gpio/consumer.h is not included implicitly.

sound/soc/codecs/pcm1789.c: In function 'pcm1789_common_init':
sound/soc/codecs/pcm1789.c:247:19: error: implicit declaration of function 'devm_gpiod_get_optional'; did you mean 'devm_gpio_request_one'? [-Werror=implicit-function-declaration]
  pcm1789->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
                   ^~~~~~~~~~~~~~~~~~~~~~~

Fixes: 4ae340d1be36 ("ASoC: codecs: Add support for PCM1789")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm1789.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/pcm1789.c b/sound/soc/codecs/pcm1789.c
index 507ac9412d6c..21f15219b3ad 100644
--- a/sound/soc/codecs/pcm1789.c
+++ b/sound/soc/codecs/pcm1789.c
@@ -3,7 +3,7 @@
 // Copyright (C) 2018 Bootlin
 // Mylène Josserand <mylene.josserand@bootlin.com>
 
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/workqueue.h>
 
-- 
2.17.0


--===============8000435649959086286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8000435649959086286==--
