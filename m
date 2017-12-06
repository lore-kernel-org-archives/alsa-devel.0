From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hisilicon: remove duplicate includes"
	to the asoc tree
Date: Wed, 06 Dec 2017 17:48:58 +0000
Message-ID: <E1eMdoY-0004hm-SA@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A291A2679FF
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 18:49:00 +0100 (CET)
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
To: Pravin Shedge <pravin.shedge4linux@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hisilicon: remove duplicate includes

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

>From 769e40f0c17df53bac8999939993a280c1ea3dbd Mon Sep 17 00:00:00 2001
From: Pravin Shedge <pravin.shedge4linux@gmail.com>
Date: Wed, 6 Dec 2017 23:09:00 +0530
Subject: [PATCH] ASoC: hisilicon: remove duplicate includes

These duplicate includes have been found with scripts/checkincludes.pl but
they have been removed manually to avoid removing false positives.

Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/hisilicon/hi6210-i2s.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/hisilicon/hi6210-i2s.c b/sound/soc/hisilicon/hi6210-i2s.c
index 0c8f86d4020e..07a57209e055 100644
--- a/sound/soc/hisilicon/hi6210-i2s.c
+++ b/sound/soc/hisilicon/hi6210-i2s.c
@@ -36,7 +36,6 @@
 #include <linux/of_irq.h>
 #include <linux/mfd/syscon.h>
 #include <linux/reset-controller.h>
-#include <linux/clk.h>
 
 #include "hi6210-i2s.h"
 
-- 
2.15.0
