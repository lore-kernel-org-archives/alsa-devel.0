From: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Subject: [PATCH] ASoC: mt6797: switch to SPDX license tag
Date: Thu, 26 Apr 2018 10:56:05 +0800
Message-ID: <20180426025605.31874-1-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 98B732677A0
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 04:56:13 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, ryder.lee@mediatek.com, wsd_upstream@mediatek.com, chipeng.chang@mediatek.com, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
---
 sound/soc/mediatek/mt6797/Makefile                 | 13 +------------
 sound/soc/mediatek/mt6797/mt6797-afe-clk.c         | 10 +---------
 sound/soc/mediatek/mt6797/mt6797-afe-clk.h         | 10 +---------
 sound/soc/mediatek/mt6797/mt6797-afe-common.h      | 10 +---------
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c         | 10 +---------
 sound/soc/mediatek/mt6797/mt6797-interconnection.h | 10 +---------
 sound/soc/mediatek/mt6797/mt6797-mt6351.c          | 12 ++----------
 sound/soc/mediatek/mt6797/mt6797-reg.h             | 12 ++----------
 8 files changed, 10 insertions(+), 77 deletions(-)

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
index f401440b5f70..3fad3ba50fa5 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-clk.c
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-clk.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * mt6797-afe-clk.c  --  Mediatek 6797 afe clock ctrl
  *
  * Copyright (c) 2018 MediaTek Inc.
  * Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
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
  * Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
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
  * Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
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
index 2df7ca4e98da..91ed02dfca08 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Mediatek ALSA SoC AFE platform driver for 6797
  *
  * Copyright (c) 2018 MediaTek Inc.
  * Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
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
 
 #include <linux/delay.h>
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
  * Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
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
index d42a9d9fbf3e..c3f58bac0960 100644
--- a/sound/soc/mediatek/mt6797/mt6797-mt6351.c
+++ b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * mt6797-mt6351.c  --  MT6797 MT6351 ALSA SoC machine driver
  *
  * Copyright (c) 2018 MediaTek Inc.
- * Author: Ryder Lee <ryder.lee@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+ * Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
  */
 
 #include <linux/module.h>
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
- * Author: Garlic Tseng <garlic.tseng@mediatek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+ * Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
  */
 
 #ifndef _MT6797_REG_H_
-- 
2.12.5
