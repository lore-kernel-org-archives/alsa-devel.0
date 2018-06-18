From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: convert to SPDX identifiers" to
	the asoc tree
Date: Mon, 18 Jun 2018 13:00:39 +0100
Message-ID: <E1fUspr-0000Nf-Id@debutante>
References: <87tvq8r1mc.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 11B0E267772
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 14:00:42 +0200 (CEST)
In-Reply-To: <87tvq8r1mc.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: convert to SPDX identifiers

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

>From 1e0edd4deadbbacd3b35179c233efa26624ab2af Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 12 Jun 2018 05:58:38 +0000
Subject: [PATCH] ASoC: rsnd: convert to SPDX identifiers

Tidyup incoherence between MODULE_LICENSE and header license, too

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/Makefile |  1 +
 sound/soc/sh/rcar/adg.c    | 15 ++++++---------
 sound/soc/sh/rcar/cmd.c    | 17 +++++++----------
 sound/soc/sh/rcar/core.c   | 24 ++++++++++--------------
 sound/soc/sh/rcar/ctu.c    | 15 ++++++---------
 sound/soc/sh/rcar/dma.c    | 17 +++++++----------
 sound/soc/sh/rcar/dvc.c    | 16 ++++++----------
 sound/soc/sh/rcar/gen.c    | 16 ++++++----------
 sound/soc/sh/rcar/mix.c    | 14 +++++---------
 sound/soc/sh/rcar/rsnd.h   | 17 +++++++----------
 sound/soc/sh/rcar/src.c    | 16 ++++++----------
 sound/soc/sh/rcar/ssi.c    | 22 +++++++++-------------
 sound/soc/sh/rcar/ssiu.c   | 15 ++++++---------
 13 files changed, 82 insertions(+), 123 deletions(-)

diff --git a/sound/soc/sh/rcar/Makefile b/sound/soc/sh/rcar/Makefile
index 9c3d5aed99d1..5d1ff8ef26f9 100644
--- a/sound/soc/sh/rcar/Makefile
+++ b/sound/soc/sh/rcar/Makefile
@@ -1,2 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
 snd-soc-rcar-objs	:= core.o gen.o dma.o adg.o ssi.o ssiu.o src.o ctu.o mix.o dvc.o cmd.o
 obj-$(CONFIG_SND_SOC_RCAR)	+= snd-soc-rcar.o
diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 4672688cac32..3a3064dda57f 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -1,12 +1,9 @@
-/*
- * Helper routines for R-Car sound ADG.
- *
- *  Copyright (C) 2013  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Helper routines for R-Car sound ADG.
+//
+//  Copyright (C) 2013  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+
 #include <linux/clk-provider.h>
 #include "rsnd.h"
 
diff --git a/sound/soc/sh/rcar/cmd.c b/sound/soc/sh/rcar/cmd.c
index 5900fb535a2b..d8043ad33540 100644
--- a/sound/soc/sh/rcar/cmd.c
+++ b/sound/soc/sh/rcar/cmd.c
@@ -1,13 +1,10 @@
-/*
- * Renesas R-Car CMD support
- *
- * Copyright (C) 2015 Renesas Solutions Corp.
- * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Renesas R-Car CMD support
+//
+// Copyright (C) 2015 Renesas Solutions Corp.
+// Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+
 #include "rsnd.h"
 
 struct rsnd_cmd {
diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index f237002180c0..eac22fef4543 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1,16 +1,12 @@
-/*
- * Renesas R-Car SRU/SCU/SSIU/SSI support
- *
- * Copyright (C) 2013 Renesas Solutions Corp.
- * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * Based on fsi.c
- * Kuninori Morimoto <morimoto.kuninori@renesas.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Renesas R-Car SRU/SCU/SSIU/SSI support
+//
+// Copyright (C) 2013 Renesas Solutions Corp.
+// Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+//
+// Based on fsi.c
+// Kuninori Morimoto <morimoto.kuninori@renesas.com>
 
 /*
  * Renesas R-Car sound device structure
@@ -1606,7 +1602,7 @@ static struct platform_driver rsnd_driver = {
 };
 module_platform_driver(rsnd_driver);
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Renesas R-Car audio driver");
 MODULE_AUTHOR("Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>");
 MODULE_ALIAS("platform:rcar-pcm-audio");
diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index 83be7d3ae0a8..6a55aa753003 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -1,12 +1,9 @@
-/*
- * ctu.c
- *
- * Copyright (c) 2015 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// ctu.c
+//
+// Copyright (c) 2015 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+
 #include "rsnd.h"
 
 #define CTU_NAME_SIZE	16
diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index ef82b94d038b..fe63ef8600d0 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -1,13 +1,10 @@
-/*
- * Renesas R-Car Audio DMAC support
- *
- * Copyright (C) 2015 Renesas Electronics Corp.
- * Copyright (c) 2015 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Renesas R-Car Audio DMAC support
+//
+// Copyright (C) 2015 Renesas Electronics Corp.
+// Copyright (c) 2015 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+
 #include <linux/delay.h>
 #include <linux/of_dma.h>
 #include "rsnd.h"
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index ca1780e0b830..2b16e0ce6bc5 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -1,13 +1,9 @@
-/*
- * Renesas R-Car DVC support
- *
- * Copyright (C) 2014 Renesas Solutions Corp.
- * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Renesas R-Car DVC support
+//
+// Copyright (C) 2014 Renesas Solutions Corp.
+// Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
 
 /*
  * Playback Volume
diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 25642e92dae0..0230301fe078 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -1,13 +1,9 @@
-/*
- * Renesas R-Car Gen1 SRU/SSI support
- *
- * Copyright (C) 2013 Renesas Solutions Corp.
- * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Renesas R-Car Gen1 SRU/SSI support
+//
+// Copyright (C) 2013 Renesas Solutions Corp.
+// Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
 
 /*
  * #define DEBUG
diff --git a/sound/soc/sh/rcar/mix.c b/sound/soc/sh/rcar/mix.c
index 1881b2de9126..8e3b57eaa708 100644
--- a/sound/soc/sh/rcar/mix.c
+++ b/sound/soc/sh/rcar/mix.c
@@ -1,12 +1,8 @@
-/*
- * mix.c
- *
- * Copyright (c) 2015 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// mix.c
+//
+// Copyright (c) 2015 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
 
 /*
  *		    CTUn	MIXn
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 6d7280d2d9be..96d93330b1e1 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -1,13 +1,10 @@
-/*
- * Renesas R-Car
- *
- * Copyright (C) 2013 Renesas Solutions Corp.
- * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Renesas R-Car
+//
+// Copyright (C) 2013 Renesas Solutions Corp.
+// Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+
 #ifndef RSND_H
 #define RSND_H
 
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 6c72d1a81cf5..beccfbac7581 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -1,13 +1,9 @@
-/*
- * Renesas R-Car SRC support
- *
- * Copyright (C) 2013 Renesas Solutions Corp.
- * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Renesas R-Car SRC support
+//
+// Copyright (C) 2013 Renesas Solutions Corp.
+// Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
 
 /*
  * you can enable below define if you don't need
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 6e1166ec24a0..3d9ea100a64f 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -1,16 +1,12 @@
-/*
- * Renesas R-Car SSIU/SSI support
- *
- * Copyright (C) 2013 Renesas Solutions Corp.
- * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * Based on fsi.c
- * Kuninori Morimoto <morimoto.kuninori@renesas.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Renesas R-Car SSIU/SSI support
+//
+// Copyright (C) 2013 Renesas Solutions Corp.
+// Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+//
+// Based on fsi.c
+// Kuninori Morimoto <morimoto.kuninori@renesas.com>
 
 /*
  * you can enable below define if you don't need
diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index 47bdba9fc582..016fbf5ac242 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -1,12 +1,9 @@
-/*
- * Renesas R-Car SSIU support
- *
- * Copyright (c) 2015 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// Renesas R-Car SSIU support
+//
+// Copyright (c) 2015 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+
 #include "rsnd.h"
 
 #define SSIU_NAME "ssiu"
-- 
2.17.1
