From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ics43432: Fix module license" to the
	asoc tree
Date: Fri, 28 Aug 2015 17:25:15 +0100
Message-ID: <E1ZVMSp-0004SM-AD@finisterre>
References: <1440732185.24389.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DF16265A76
 for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2015 18:25:34 +0200 (CEST)
In-Reply-To: <1440732185.24389.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ics43432: Fix module license

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

>From 2f38bc8829b83aed3e2c5e6d43a430d39f1b0e1d Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 28 Aug 2015 11:23:05 +0800
Subject: [PATCH] ASoC: ics43432: Fix module license

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ics43432.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ics43432.c b/sound/soc/codecs/ics43432.c
index d217fed..7c35c98 100644
--- a/sound/soc/codecs/ics43432.c
+++ b/sound/soc/codecs/ics43432.c
@@ -6,7 +6,7 @@
  *
  * Copyright (c) 2015 Axis Communications AB
  *
- * Licensed under GPL2.
+ * Licensed under GPL v2.
  */
 
 #include <linux/module.h>
@@ -73,4 +73,4 @@ module_platform_driver(ics43432_driver);
 
 MODULE_DESCRIPTION("ASoC ICS43432 driver");
 MODULE_AUTHOR("Ricard Wanderlof <ricardw@axis.com>");
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL v2");
-- 
2.5.0
