From: <shumingf@realtek.com>
Subject: [PATCH v2] ASoC: rt1308: Convert headers to SPDX
Date: Tue, 23 Jul 2019 18:12:47 +0800
Message-ID: <20190723101247.19741-1-shumingf@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F260F80227
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 12:12:59 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, derek.fang@realtek.com, Shuming Fan <shumingf@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Shuming Fan <shumingf@realtek.com>

Convert include and source files to SPDX.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt1308.c | 17 +++++++----------
 sound/soc/codecs/rt1308.h |  6 ++----
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/rt1308.c b/sound/soc/codecs/rt1308.c
index cf3d72f99705..6f2ee6809dbb 100644
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
index c330aae1d527..ff7c423e879e 100644
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
2.22.0
