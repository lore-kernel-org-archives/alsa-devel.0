From: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 1/2] ASoC: mt6797: switch to SPDX license tag
Date: Fri, 27 Apr 2018 09:54:44 +0800
Message-ID: <20180427015445.4334-2-kaichieh.chuang@mediatek.com>
References: <20180427015445.4334-1-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20180427015445.4334-1-kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, chipeng.chang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, wsd_upstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 sound/soc/mediatek/mt6797/Makefile                 | 13 +------------
 sound/soc/mediatek/mt6797/mt6797-afe-clk.c         | 21 ++++++---------------
 sound/soc/mediatek/mt6797/mt6797-afe-clk.h         | 10 +---------
 sound/soc/mediatek/mt6797/mt6797-afe-common.h      | 10 +---------
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c         | 21 ++++++---------------
 sound/soc/mediatek/mt6797/mt6797-interconnection.h | 10 +---------
 sound/soc/mediatek/mt6797/mt6797-mt6351.c          | 21 ++++++---------------
 sound/soc/mediatek/mt6797/mt6797-reg.h             | 12 ++----------
 8 files changed, 24 insertions(+), 94 deletions(-)

diff --git a/sound/soc/mediatek/mt6797/Makefile b/sound/soc/mediatek/mt6797/Makefile
index 58618a0d339a..50fd50f7aa6a 100644
--- a/sound/soc/mediatek/mt6797/Makefile
+++ b/sound/soc/mediatek/mt6797/Makefile
@@ -1,15 +1,4 @@
-#
-# Copyright (C) 2018 MediaTek Inc.
-#
-# This program is free software: you can redistribute it and/or modify
-# it under the terms of the GNU General Public License version 2 as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-# GNU General Public License for more details.
-#
+# SPDX-License-Identifier: GPL-2.0
 
 # platform driver
 snd-soc-mt6797-afe-objs := mt6797-afe-pcm.o mt6797-afe-clk.o
diff --git a/sound/soc/mediatek/mt6797/mt6797-afe-clk.c b/sound/soc/mediatek/mt6797/mt6797-afe-clk.c
index f401440b5f70..6f3e6acfcfab 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-clk.c
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-clk.c
@@ -1,18 +1,9 @@
-/*
- * mt6797-afe-clk.c  --  Mediatek 6797 afe clock ctrl
- *
- * Copyright (c) 2018 MediaTek Inc.
- * Author: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// mt6797-afe-clk.c  --  Mediatek 6797 afe clock ctrl
+//
+// Copyright (c) 2018 MediaTek Inc.
+// Author: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
 
 #include <linux/clk.h>
 
diff --git a/sound/soc/mediatek/mt6797/mt6797-afe-clk.h b/sound/soc/mediatek/mt6797/mt6797-afe-clk.h
index 43d979402f31..a6f0cb572711 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-clk.h
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-clk.h
@@ -1,17 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mt6797-afe-clk.h  --  Mediatek 6797 afe clock ctrl definition
  *
  * Copyright (c) 2018 MediaTek Inc.
  * Author: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef _MT6797_AFE_CLK_H_
diff --git a/sound/soc/mediatek/mt6797/mt6797-afe-common.h b/sound/soc/mediatek/mt6797/mt6797-afe-common.h
index 3509f53360e2..c1de3fc5dc3d 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-common.h
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-common.h
@@ -1,17 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mt6797-afe-common.h  --  Mediatek 6797 audio driver definitions
  *
  * Copyright (c) 2018 MediaTek Inc.
  * Author: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef _MT_6797_AFE_COMMON_H_
diff --git a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
index 2df7ca4e98da..79a3551eb485 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
@@ -1,18 +1,9 @@
-/*
- * Mediatek ALSA SoC AFE platform driver for 6797
- *
- * Copyright (c) 2018 MediaTek Inc.
- * Author: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Mediatek ALSA SoC AFE platform driver for 6797
+//
+// Copyright (c) 2018 MediaTek Inc.
+// Author: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
 
 #include <linux/delay.h>
 #include <linux/module.h>
diff --git a/sound/soc/mediatek/mt6797/mt6797-interconnection.h b/sound/soc/mediatek/mt6797/mt6797-interconnection.h
index 78774cd19383..07b759b20079 100644
--- a/sound/soc/mediatek/mt6797/mt6797-interconnection.h
+++ b/sound/soc/mediatek/mt6797/mt6797-interconnection.h
@@ -1,17 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Mediatek MT6797 audio driver interconnection definition
  *
  * Copyright (c) 2018 MediaTek Inc.
  * Author: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef _MT6797_INTERCONNECTION_H_
diff --git a/sound/soc/mediatek/mt6797/mt6797-mt6351.c b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
index d42a9d9fbf3e..9e5866d6819a 100644
--- a/sound/soc/mediatek/mt6797/mt6797-mt6351.c
+++ b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
@@ -1,18 +1,9 @@
-/*
- * mt6797-mt6351.c  --  MT6797 MT6351 ALSA SoC machine driver
- *
- * Copyright (c) 2018 MediaTek Inc.
- * Author: Ryder Lee <ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// mt6797-mt6351.c  --  MT6797 MT6351 ALSA SoC machine driver
+//
+// Copyright (c) 2018 MediaTek Inc.
+// Author: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
 
 #include <linux/module.h>
 #include <sound/soc.h>
diff --git a/sound/soc/mediatek/mt6797/mt6797-reg.h b/sound/soc/mediatek/mt6797/mt6797-reg.h
index 3330f73fc8bb..ffb55367f59f 100644
--- a/sound/soc/mediatek/mt6797/mt6797-reg.h
+++ b/sound/soc/mediatek/mt6797/mt6797-reg.h
@@ -1,17 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * mt6797-reg.h  --  Mediatek 6797 audio driver reg definition
  *
  * Copyright (c) 2018 MediaTek Inc.
- * Author: Garlic Tseng <garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+ * Author: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
  */
 
 #ifndef _MT6797_REG_H_
-- 
2.12.5
