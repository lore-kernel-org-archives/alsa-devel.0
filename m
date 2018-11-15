From: David Lin <CTLIN0@nuvoton.com>
Subject: [PATCH] ASoC: nau8822: convert to SPDX identifiers
Date: Thu, 15 Nov 2018 17:14:47 +0800
Message-ID: <20181115091446.32764-1-CTLIN0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server-codec (60-250-207-217.hinet-ip.hinet.net
 [60.250.207.217])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DDCF26751A
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2018 10:18:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, wtli@nuvoton.com, kchsu0@nuvoton.com, lgirdwood@gmail.com, yhchuang@nuvoton.com, David Lin <CTLIN0@nuvoton.com>
List-Id: alsa-devel@alsa-project.org

This patch updates license to SPDX-License-Identifier
instead of verbose license text.

Signed-off-by: David Lin <CTLIN0@nuvoton.com>
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
2.18.0
