From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 5/5] ASoC: max9867: Add copyright and module
	author
Date: Fri, 23 Nov 2018 15:28:52 +0100
Message-ID: <20181123142852.GF7347@lenoch>
References: <20181123142507.GA7347@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 411B42678DF
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 15:28:54 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23992971AbeKWO2xoNPhb (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Fri, 23 Nov 2018 15:28:53 +0100
Content-Disposition: inline
In-Reply-To: <20181123142507.GA7347@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

Driver rewritten, assign copyright notice and change module author
as original one remains silent and I want to be notified about bugs.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 sound/soc/codecs/max9867.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index da6f604793c3..2a35e012f8aa 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -1,11 +1,9 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * max9867.c -- max9867 ALSA SoC Audio driver
  *
  * Copyright 2013-15 Maxim Integrated Products
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * Copyright 2018 Ladislav Michl <ladis@linux-mips.org>
  */
 
 #include <linux/delay.h>
@@ -523,6 +521,6 @@ static struct i2c_driver max9867_i2c_driver = {
 
 module_i2c_driver(max9867_i2c_driver);
 
-MODULE_AUTHOR("anish kumar <yesanishhere@gmail.com>");
-MODULE_DESCRIPTION("ALSA SoC MAX9867 driver");
+MODULE_AUTHOR("Ladislav Michl <ladis@linux-mips.org>");
+MODULE_DESCRIPTION("ASoC MAX9867 driver");
 MODULE_LICENSE("GPL");
-- 
2.19.1
