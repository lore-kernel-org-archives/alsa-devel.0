From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] ASoC: madera: Update SPDX headers
Date: Tue, 25 Jun 2019 16:37:27 +0100
Message-ID: <20190625153727.28060-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8AEBF8071F
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2019 17:37:33 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The madera driver was merged too late to catch Thomas Gleixner's cleanup
of the SPDX headers tree wide. Update the headers to match what was done
in that patch.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/dt-bindings/sound/madera.h | 6 +-----
 include/sound/madera-pdata.h       | 6 +-----
 sound/soc/codecs/cs47l35.c         | 6 +-----
 sound/soc/codecs/cs47l85.c         | 6 +-----
 sound/soc/codecs/cs47l90.c         | 6 +-----
 sound/soc/codecs/madera.c          | 6 +-----
 sound/soc/codecs/madera.h          | 6 +-----
 7 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/include/dt-bindings/sound/madera.h b/include/dt-bindings/sound/madera.h
index 9ff4eae5259b0..d0096d5eb0dab 100644
--- a/include/dt-bindings/sound/madera.h
+++ b/include/dt-bindings/sound/madera.h
@@ -1,13 +1,9 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Device Tree defines for Madera codecs
  *
  * Copyright (C) 2016-2017 Cirrus Logic, Inc. and
  *                         Cirrus Logic International Semiconductor Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef DT_BINDINGS_SOUND_MADERA_H
diff --git a/include/sound/madera-pdata.h b/include/sound/madera-pdata.h
index 441decefb7f34..e3060f48f1081 100644
--- a/include/sound/madera-pdata.h
+++ b/include/sound/madera-pdata.h
@@ -1,13 +1,9 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Platform data for Madera codec driver
  *
  * Copyright (C) 2016-2019 Cirrus Logic, Inc. and
  *                         Cirrus Logic International Semiconductor Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef MADERA_CODEC_PDATA_H
diff --git a/sound/soc/codecs/cs47l35.c b/sound/soc/codecs/cs47l35.c
index 02f193dadd41a..511d0d6fa962a 100644
--- a/sound/soc/codecs/cs47l35.c
+++ b/sound/soc/codecs/cs47l35.c
@@ -1,14 +1,10 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 //
 // ALSA SoC Audio driver for CS47L35 codec
 //
 // Copyright (C) 2015-2019 Cirrus Logic, Inc. and
 //                         Cirrus Logic International Semiconductor Ltd.
 //
-// This program is free software; you can redistribute it and/or modify
-// it under the terms of the GNU General Public License as published by the
-// Free Software Foundation; version 2.
-//
 
 #include <linux/delay.h>
 #include <linux/device.h>
diff --git a/sound/soc/codecs/cs47l85.c b/sound/soc/codecs/cs47l85.c
index 4c4bae6e2c57e..32fe7ffb75268 100644
--- a/sound/soc/codecs/cs47l85.c
+++ b/sound/soc/codecs/cs47l85.c
@@ -1,14 +1,10 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 //
 // ALSA SoC Audio driver for CS47L85 codec
 //
 // Copyright (C) 2015-2019 Cirrus Logic, Inc. and
 //                         Cirrus Logic International Semiconductor Ltd.
 //
-// This program is free software; you can redistribute it and/or modify
-// it under the terms of the GNU General Public License as published by the
-// Free Software Foundation; version 2.
-//
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
diff --git a/sound/soc/codecs/cs47l90.c b/sound/soc/codecs/cs47l90.c
index 83c4e4628bdea..c4ecb0e6911af 100644
--- a/sound/soc/codecs/cs47l90.c
+++ b/sound/soc/codecs/cs47l90.c
@@ -1,14 +1,10 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 //
 // ALSA SoC Audio driver for CS47L90 codec
 //
 // Copyright (C) 2015-2019 Cirrus Logic, Inc. and
 //                         Cirrus Logic International Semiconductor Ltd.
 //
-// This program is free software; you can redistribute it and/or modify
-// it under the terms of the GNU General Public License as published by the
-// Free Software Foundation; version 2.
-//
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
diff --git a/sound/soc/codecs/madera.c b/sound/soc/codecs/madera.c
index 6146c7a070cb3..1b1be19a2f991 100644
--- a/sound/soc/codecs/madera.c
+++ b/sound/soc/codecs/madera.c
@@ -1,14 +1,10 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 //
 // Cirrus Logic Madera class codecs common support
 //
 // Copyright (C) 2015-2019 Cirrus Logic, Inc. and
 //                         Cirrus Logic International Semiconductor Ltd.
 //
-// This program is free software; you can redistribute it and/or modify
-// it under the terms of the GNU General Public License as published by the
-// Free Software Foundation; version 2.
-//
 
 #include <linux/delay.h>
 #include <linux/gcd.h>
diff --git a/sound/soc/codecs/madera.h b/sound/soc/codecs/madera.h
index aa2db156582b9..0af66f2807708 100644
--- a/sound/soc/codecs/madera.h
+++ b/sound/soc/codecs/madera.h
@@ -1,13 +1,9 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Cirrus Logic Madera class codecs common support
  *
  * Copyright (C) 2015-2018 Cirrus Logic, Inc. and
  *                         Cirrus Logic International Semiconductor Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by the
- * Free Software Foundation; version 2.
  */
 
 #ifndef ASOC_MADERA_H
-- 
2.11.0
