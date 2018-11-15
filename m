From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8822: convert to SPDX identifiers"
	to the asoc tree
Date: Thu, 15 Nov 2018 19:47:01 +0000 (GMT)
Message-ID: <20181115194701.221DB440078@finisterre.ee.mobilebroadband>
References: <20181115091446.32764-1-CTLIN0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 41F08267B24
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2018 20:47:07 +0100 (CET)
In-Reply-To: <20181115091446.32764-1-CTLIN0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Lin <CTLIN0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, wtli@nuvoton.com, kchsu0@nuvoton.com, lgirdwood@gmail.com, yhchuang@nuvoton.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8822: convert to SPDX identifiers

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

>From ba34f253711a8427d2ef29475afe406b2d6e5118 Mon Sep 17 00:00:00 2001
From: David Lin <CTLIN0@nuvoton.com>
Date: Thu, 15 Nov 2018 17:14:47 +0800
Subject: [PATCH] ASoC: nau8822: convert to SPDX identifiers

This patch updates license to SPDX-License-Identifier
instead of verbose license text.

Signed-off-by: David Lin <CTLIN0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8822.c | 26 +++++++++++---------------
 sound/soc/codecs/nau8822.h | 11 +++++------
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/nau8822.c b/sound/soc/codecs/nau8822.c
index 622ce947f134..c6152a044416 100644
--- a/sound/soc/codecs/nau8822.c
+++ b/sound/soc/codecs/nau8822.c
@@ -1,18 +1,14 @@
-/*
- * nau8822.c  --  NAU8822 ALSA Soc Audio Codec driver
- *
- * Copyright 2017 Nuvoton Technology Corp.
- *
- * Author: David Lin <ctlin0@nuvoton.com>
- * Co-author: John Hsu <kchsu0@nuvoton.com>
- * Co-author: Seven Li <wtli@nuvoton.com>
- *
- * Based on WM8974.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// nau8822.c  --  NAU8822 ALSA Soc Audio driver
+//
+// Copyright 2017 Nuvoton Technology Crop.
+//
+// Author: David Lin <ctlin0@nuvoton.com>
+// Co-author: John Hsu <kchsu0@nuvoton.com>
+// Co-author: Seven Li <wtli@nuvoton.com>
+//
+// Based on WM8974.c
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
diff --git a/sound/soc/codecs/nau8822.h b/sound/soc/codecs/nau8822.h
index aa79c969cd44..d15afd782815 100644
--- a/sound/soc/codecs/nau8822.h
+++ b/sound/soc/codecs/nau8822.h
@@ -1,13 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
- * nau8822.h  --  NAU8822 Soc Audio Codec driver
+ * nau8822.h  --  NAU8822 ALSA SoC Audio driver
+ *
+ * Copyright 2017 Nuvoton Technology Crop.
  *
  * Author: David Lin <ctlin0@nuvoton.com>
- * Co-author: John Hsu <kchsu0@nuvoton.com>
+ * Co-author: John Hsu <kchsu@nuvoton.com>
  * Co-author: Seven Li <wtli@nuvoton.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __NAU8822_H__
-- 
2.19.1
