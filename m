From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic31xx: Fix GPIO header
	includes" to the asoc tree
Date: Thu, 07 Dec 2017 17:48:22 +0000
Message-ID: <E1eN0HW-00042L-FZ@debutante>
References: <20171207153900.9831-2-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B08FE267B5D
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 18:48:25 +0100 (CET)
In-Reply-To: <20171207153900.9831-2-afd@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "Andrew F ., Davis" <afd@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic31xx: Fix GPIO header includes

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

>From 283c35062f778fc40f8eb5dc004ca37a7208ea66 Mon Sep 17 00:00:00 2001
From: "Andrew F. Davis" <afd@ti.com>
Date: Thu, 7 Dec 2017 09:38:51 -0600
Subject: [PATCH] ASoC: tlv320aic31xx: Fix GPIO header includes

Use of gpiod_* needs <linux/gpio/consumer.h>, add this here.

Fixes: b6b247cd5e37 ("ASoC: tlv320aic31xx: Switch GPIO handling to use gpiod_* API")
Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 38fd6ea275fb..13471a900085 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -18,7 +18,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/i2c.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
-- 
2.15.1
