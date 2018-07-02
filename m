From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-acpi: convert to SPDX identifiers"
	to the asoc tree
Date: Mon, 02 Jul 2018 11:10:57 +0100
Message-ID: <E1fZvnN-0006W9-DR@debutante>
References: <87d0w6f9cx.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 91FEC2677B0
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 04:59:04 +0200 (CEST)
In-Reply-To: <87d0w6f9cx.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-acpi: convert to SPDX identifiers

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

>From 7730bb13c7472620b585783f248b2dccd09d1819 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 2 Jul 2018 06:24:04 +0000
Subject: [PATCH] ASoC: soc-acpi: convert to SPDX identifiers

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-acpi-intel-match.h | 14 ++------------
 include/sound/soc-acpi.h             | 13 ++-----------
 sound/soc/soc-acpi.c                 | 20 +++++---------------
 3 files changed, 9 insertions(+), 38 deletions(-)

diff --git a/include/sound/soc-acpi-intel-match.h b/include/sound/soc-acpi-intel-match.h
index 917ddd0f2762..bb1d24b703fb 100644
--- a/include/sound/soc-acpi-intel-match.h
+++ b/include/sound/soc-acpi-intel-match.h
@@ -1,16 +1,6 @@
-
-/*
- * Copyright (C) 2017, Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+/* SPDX-License-Identifier: GPL-2.0
  *
+ * Copyright (C) 2017, Intel Corporation. All rights reserved.
  */
 
 #ifndef __LINUX_SND_SOC_ACPI_INTEL_MATCH_H
diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index 082224275f52..e45b2330d16a 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -1,15 +1,6 @@
-/*
- * Copyright (C) 2013-15, Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
+/* SPDX-License-Identifier: GPL-2.0
  *
+ * Copyright (C) 2013-15, Intel Corporation. All rights reserved.
  */
 
 #ifndef __LINUX_SND_SOC_ACPI_H
diff --git a/sound/soc/soc-acpi.c b/sound/soc/soc-acpi.c
index 3d7e1ff79139..b8e72b52db30 100644
--- a/sound/soc/soc-acpi.c
+++ b/sound/soc/soc-acpi.c
@@ -1,18 +1,8 @@
-/*
- * soc-apci.c - support for ACPI enumeration.
- *
- * Copyright (c) 2013-15, Intel Corporation.
- *
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
+// SPDX-License-Identifier: GPL-2.0
+//
+// soc-apci.c - support for ACPI enumeration.
+//
+// Copyright (c) 2013-15, Intel Corporation.
 
 #include <sound/soc-acpi.h>
 
-- 
2.18.0.rc2
