From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v2] ASoC: max9867: Add copyright and module
	author
Date: Thu, 6 Dec 2018 22:06:38 +0100
Message-ID: <20181206210638.GA26880@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id BA221267CA4
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2018 22:06:44 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23990406AbeLFVGkfM8O6 (ORCPT
 <rfc822;alsa-devel@alsa-project.org>); Thu, 6 Dec 2018 22:06:40 +0100
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

Driver rewritten, assign copyright notice and change module author
as original one remains silent and I want to be notified about bugs.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 CHANGES:
 -v2: convert entire comment block to C++ style

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
2.20.0.rc2
