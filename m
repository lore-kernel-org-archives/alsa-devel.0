From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs4349: include gpio/consumer.h" to the
	asoc tree
Date: Mon, 20 Jul 2015 18:52:05 +0100
Message-ID: <E1ZHFET-0002pQ-4n@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 30E3F26149E
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2015 19:52:12 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs4349: include gpio/consumer.h

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

>From 091571d071a435a517aec42c4f8c56883c5dc531 Mon Sep 17 00:00:00 2001
From: "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Date: Fri, 17 Jul 2015 15:43:46 -0700
Subject: [PATCH] ASoC: cs4349: include gpio/consumer.h

s390 allmodconfig:

sound/soc/codecs/cs4349.c: In function 'cs4349_i2c_probe':
sound/soc/codecs/cs4349.c:300: error: implicit declaration of function 'devm_gpiod_get_optional'
sound/soc/codecs/cs4349.c:301: error: 'GPIOD_OUT_LOW' undeclared (first use in this function)
sound/soc/codecs/cs4349.c:301: error: (Each undeclared identifier is reported only once
sound/soc/codecs/cs4349.c:301: error: for each function it appears in.)
sound/soc/codecs/cs4349.c:306: error: implicit declaration of function 'gpiod_set_value_cansleep'

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs4349.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs4349.c b/sound/soc/codecs/cs4349.c
index 2569010ee396..a7538aea7f99 100644
--- a/sound/soc/codecs/cs4349.c
+++ b/sound/soc/codecs/cs4349.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-- 
2.1.4
