From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9867: Add copyright and module
	author" to the asoc tree
Date: Fri,  7 Dec 2018 12:23:14 +0000 (GMT)
Message-ID: <20181207122314.A2B5C11253E4@debutante.sirena.org.uk>
References: <20181206210638.GA26880@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8557B267BB3
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2018 13:23:16 +0100 (CET)
In-Reply-To: <20181206210638.GA26880@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9867: Add copyright and module author

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

>From 8084945d3c934cf730cd5fdfb5cc11ebfc4cc386 Mon Sep 17 00:00:00 2001
From: Ladislav Michl <ladis@linux-mips.org>
Date: Thu, 6 Dec 2018 22:06:38 +0100
Subject: [PATCH] ASoC: max9867: Add copyright and module author

Driver rewritten, assign copyright notice and change module author
as original one remains silent and I want to be notified about bugs.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9867.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 7a08e2c70e17..8600c5439e1e 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -1,12 +1,10 @@
-/*
- * max9867.c -- max9867 ALSA SoC Audio driver
- *
- * Copyright 2013-15 Maxim Integrated Products
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// MAX9867 ALSA SoC codec driver
+//
+// Copyright 2013-2015 Maxim Integrated Products
+// Copyright 2018 Ladislav Michl <ladis@linux-mips.org>
+//
 
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -551,6 +549,6 @@ static struct i2c_driver max9867_i2c_driver = {
 
 module_i2c_driver(max9867_i2c_driver);
 
-MODULE_AUTHOR("anish kumar <yesanishhere@gmail.com>");
-MODULE_DESCRIPTION("ALSA SoC MAX9867 driver");
+MODULE_AUTHOR("Ladislav Michl <ladis@linux-mips.org>");
+MODULE_DESCRIPTION("ASoC MAX9867 driver");
 MODULE_LICENSE("GPL");
-- 
2.19.0.rc2
