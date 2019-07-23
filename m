From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt1308: Convert headers to SPDX" to the
	asoc tree
Date: Tue, 23 Jul 2019 12:29:10 +0100 (BST)
Message-ID: <20190723112910.B20532742B59@ypsilon.sirena.org.uk>
References: <20190723101247.19741-1-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 41305F803D0
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 13:29:12 +0200 (CEST)
In-Reply-To: <20190723101247.19741-1-shumingf@realtek.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Shuming Fan <shumingf@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>, derek.fang@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt1308: Convert headers to SPDX

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From a789adae592e3d28ae87902c0012a8b11c96eb79 Mon Sep 17 00:00:00 2001
From: Shuming Fan <shumingf@realtek.com>
Date: Tue, 23 Jul 2019 18:12:47 +0800
Subject: [PATCH] ASoC: rt1308: Convert headers to SPDX

Convert include and source files to SPDX.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Link: https://lore.kernel.org/r/20190723101247.19741-1-shumingf@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt1308.c | 17 +++++++----------
 sound/soc/codecs/rt1308.h |  6 ++----
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/rt1308.c b/sound/soc/codecs/rt1308.c
index cf3d72f99705..6f2ee6809dbb 100755
--- a/sound/soc/codecs/rt1308.c
+++ b/sound/soc/codecs/rt1308.c
@@ -1,13 +1,10 @@
-/*
- * rt1308.c  --  RT1308 ALSA SoC amplifier component driver
- *
- * Copyright 2019 Realtek Semiconductor Corp.
- * Author: Derek Fang <derek.fang@realtek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// rt1308.c  --  RT1308 ALSA SoC amplifier component driver
+//
+// Copyright 2019 Realtek Semiconductor Corp.
+// Author: Derek Fang <derek.fang@realtek.com>
+//
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
diff --git a/sound/soc/codecs/rt1308.h b/sound/soc/codecs/rt1308.h
index c330aae1d527..ff7c423e879e 100755
--- a/sound/soc/codecs/rt1308.h
+++ b/sound/soc/codecs/rt1308.h
@@ -1,12 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * RT1308.h  --  RT1308 ALSA SoC amplifier component driver
+ * rt1308.h  --  RT1308 ALSA SoC amplifier component driver
  *
  * Copyright 2019 Realtek Semiconductor Corp.
  * Author: Derek Fang <derek.fang@realtek.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef _RT1308_H_
-- 
2.20.1
