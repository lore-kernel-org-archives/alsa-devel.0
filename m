From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mt6797: switch to SPDX license tag" to
	the asoc tree
Date: Fri, 27 Apr 2018 11:53:11 +0100
Message-ID: <E1fC103-0003Hl-VH@debutante>
References: <20180427015445.4334-2-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 716C0267860
 for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2018 12:53:26 +0200 (CEST)
In-Reply-To: <20180427015445.4334-2-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, ryder.lee@mediatek.com, wsd_upstream@mediatek.com, chipeng.chang@mediatek.com, garlic.tseng@mediatek.com, broonie@kernel.org, linux-mediatek@lists.infradead.org, kaichieh.chuang@mediatek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mt6797: switch to SPDX license tag

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

>From 4135d8b6e94a38fc997414e986062d068043784b Mon Sep 17 00:00:00 2001
From: Kai Chieh Chuang <kaichieh.chuang@mediatek.com>
Date: Fri, 27 Apr 2018 09:54:44 +0800
Subject: [PATCH] ASoC: mt6797: switch to SPDX license tag

Signed-off-by: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/mediatek/mt6797/Makefile            | 13 +-----------
 sound/soc/mediatek/mt6797/mt6797-afe-clk.c    | 21 ++++++-------------
 sound/soc/mediatek/mt6797/mt6797-afe-clk.h    | 10 +--------
 sound/soc/mediatek/mt6797/mt6797-afe-common.h | 10 +--------
 sound/soc/mediatek/mt6797/mt6797-afe-pcm.c    | 21 ++++++-------------
 .../mediatek/mt6797/mt6797-interconnection.h  | 10 +--------
 sound/soc/mediatek/mt6797/mt6797-mt6351.c     | 21 ++++++-------------
 sound/soc/mediatek/mt6797/mt6797-reg.h        | 12 ++---------
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
- * Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
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
+// Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
 
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
index 2df7ca4e98da..79a3551eb485 100644
--- a/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
+++ b/sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
@@ -1,18 +1,9 @@
-/*
- * Mediatek ALSA SoC AFE platform driver for 6797
- *
- * Copyright (c) 2018 MediaTek Inc.
- * Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
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
+// Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
 
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
index d42a9d9fbf3e..9e5866d6819a 100644
--- a/sound/soc/mediatek/mt6797/mt6797-mt6351.c
+++ b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
@@ -1,18 +1,9 @@
-/*
- * mt6797-mt6351.c  --  MT6797 MT6351 ALSA SoC machine driver
- *
- * Copyright (c) 2018 MediaTek Inc.
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
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// mt6797-mt6351.c  --  MT6797 MT6351 ALSA SoC machine driver
+//
+// Copyright (c) 2018 MediaTek Inc.
+// Author: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
 
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
2.17.0
