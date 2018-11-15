From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: Switch to SPDX identifier" to the
	asoc tree
Date: Thu, 15 Nov 2018 19:46:37 +0000 (GMT)
Message-ID: <20181115194637.571D6440079@finisterre.ee.mobilebroadband>
References: <1542298434-17287-2-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4675D267B0E
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2018 20:46:43 +0100 (CET)
In-Reply-To: <1542298434-17287-2-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, Sanju R Mehta <sanju.mehta@amd.com>, Mark Brown <broonie@kernel.org>, Vijendar Mukunda <vijendar.mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Colin Ian King <colin.king@canonical.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: Switch to SPDX identifier

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

>From d5a932e541f61a2be1cca7bab1e00d2bf7803e71 Mon Sep 17 00:00:00 2001
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Date: Thu, 15 Nov 2018 21:43:50 +0530
Subject: [PATCH] ASoC: amd: Switch to SPDX identifier

Adopt the SPDX license identifier headers to ease license
compliance management.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vijendar Mukunda <vijendar.mukunda@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/raven/Makefile           |  2 ++
 sound/soc/amd/raven/acp3x-pcm-dma.c    | 19 +++++--------------
 sound/soc/amd/raven/acp3x.h            |  7 +++++++
 sound/soc/amd/raven/chip_offset_byte.h | 22 +++-------------------
 sound/soc/amd/raven/pci-acp3x.c        | 19 +++++--------------
 5 files changed, 22 insertions(+), 47 deletions(-)

diff --git a/sound/soc/amd/raven/Makefile b/sound/soc/amd/raven/Makefile
index 8c03e6fccf6a..108d1acf189b 100644
--- a/sound/soc/amd/raven/Makefile
+++ b/sound/soc/amd/raven/Makefile
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Raven Ridge platform Support
 snd-pci-acp3x-objs	:= pci-acp3x.o
 snd-acp3x-pcm-dma-objs	:= acp3x-pcm-dma.o
 obj-$(CONFIG_SND_SOC_AMD_ACP3x)	 += snd-pci-acp3x.o
diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index b16cdd187139..2aa34208ae92 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -1,17 +1,8 @@
-/*
- * AMD ALSA SoC PCM Driver
- *
- * Copyright 2016 Advanced Micro Devices, Inc.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// AMD ALSA SoC PCM Driver
+//
+//Copyright 2016 Advanced Micro Devices, Inc.
 
 #include <linux/platform_device.h>
 #include <linux/module.h>
diff --git a/sound/soc/amd/raven/acp3x.h b/sound/soc/amd/raven/acp3x.h
index 95fef8570577..4f2cadd90a87 100644
--- a/sound/soc/amd/raven/acp3x.h
+++ b/sound/soc/amd/raven/acp3x.h
@@ -1,3 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * AMD ALSA SoC PCM Driver
+ *
+ * Copyright 2016 Advanced Micro Devices, Inc.
+ */
+
 #include "chip_offset_byte.h"
 
 #define ACP3x_PHY_BASE_ADDRESS 0x1240000
diff --git a/sound/soc/amd/raven/chip_offset_byte.h b/sound/soc/amd/raven/chip_offset_byte.h
index fceb7bb40297..9c1fac58fb2a 100644
--- a/sound/soc/amd/raven/chip_offset_byte.h
+++ b/sound/soc/amd/raven/chip_offset_byte.h
@@ -1,24 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * ACP 3.0 Register documentation
+ * AMD ACP 3.0 Register Documentation
  *
- * Copyright (C) 2016 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included
- * in all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
- * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
- * IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ * Copyright 2016 Advanced Micro Devices, Inc.
  */
 
 #ifndef _acp_ip_OFFSET_HEADER
diff --git a/sound/soc/amd/raven/pci-acp3x.c b/sound/soc/amd/raven/pci-acp3x.c
index 0700162b0ed1..ef805e71a98f 100644
--- a/sound/soc/amd/raven/pci-acp3x.c
+++ b/sound/soc/amd/raven/pci-acp3x.c
@@ -1,17 +1,8 @@
-/*
- * AMD ALSA SoC PCM Driver
- *
- * Copyright 2016 Advanced Micro Devices, Inc.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// AMD ACP PCI Driver
+//
+//Copyright 2016 Advanced Micro Devices, Inc.
 
 #include <linux/pci.h>
 #include <linux/module.h>
-- 
2.19.1
