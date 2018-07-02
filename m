From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-topology: convert to SPDX
	identifiers" to the asoc tree
Date: Mon, 02 Jul 2018 11:10:32 +0100
Message-ID: <E1fZvmy-0006T4-BF@debutante>
References: <878t6uf9bt.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D8189267796
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 04:59:07 +0200 (CEST)
In-Reply-To: <878t6uf9bt.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-topology: convert to SPDX identifiers

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

>From f2b6a1b25fecc48a46c8a41636101af8a41c88a8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 2 Jul 2018 06:24:45 +0000
Subject: [PATCH] ASoC: soc-topology: convert to SPDX identifiers

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-topology.h |  7 ++----
 sound/soc/soc-topology.c     | 47 ++++++++++++++++--------------------
 2 files changed, 23 insertions(+), 31 deletions(-)

diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index 401ef2c45d6c..fa4b8413d2e2 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -1,13 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * linux/sound/soc-topology.h -- ALSA SoC Firmware Controls and DAPM
  *
  * Copyright (C) 2012 Texas Instruments Inc.
  * Copyright (C) 2015 Intel Corporation.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Simple file API to load FW that includes mixers, coefficients, DAPM graphs,
  * algorithms, equalisers, DAIs, widgets, FE caps, BE caps, codec link caps etc.
  */
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 05d177d689e2..66e77e020745 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1,29 +1,24 @@
-/*
- * soc-topology.c  --  ALSA SoC Topology
- *
- * Copyright (C) 2012 Texas Instruments Inc.
- * Copyright (C) 2015 Intel Corporation.
- *
- * Authors: Liam Girdwood <liam.r.girdwood@linux.intel.com>
- *		K, Mythri P <mythri.p.k@intel.com>
- *		Prusty, Subhransu S <subhransu.s.prusty@intel.com>
- *		B, Jayachandran <jayachandran.b@intel.com>
- *		Abdullah, Omair M <omair.m.abdullah@intel.com>
- *		Jin, Yao <yao.jin@intel.com>
- *		Lin, Mengdong <mengdong.lin@intel.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  Add support to read audio firmware topology alongside firmware text. The
- *  topology data can contain kcontrols, DAPM graphs, widgets, DAIs, DAI links,
- *  equalizers, firmware, coefficients etc.
- *
- *  This file only manages the core ALSA and ASoC components, all other bespoke
- *  firmware topology data is passed to component drivers for bespoke handling.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// soc-topology.c  --  ALSA SoC Topology
+//
+// Copyright (C) 2012 Texas Instruments Inc.
+// Copyright (C) 2015 Intel Corporation.
+//
+// Authors: Liam Girdwood <liam.r.girdwood@linux.intel.com>
+//		K, Mythri P <mythri.p.k@intel.com>
+//		Prusty, Subhransu S <subhransu.s.prusty@intel.com>
+//		B, Jayachandran <jayachandran.b@intel.com>
+//		Abdullah, Omair M <omair.m.abdullah@intel.com>
+//		Jin, Yao <yao.jin@intel.com>
+//		Lin, Mengdong <mengdong.lin@intel.com>
+//
+//  Add support to read audio firmware topology alongside firmware text. The
+//  topology data can contain kcontrols, DAPM graphs, widgets, DAIs, DAI links,
+//  equalizers, firmware, coefficients etc.
+//
+//  This file only manages the core ALSA and ASoC components, all other bespoke
+//  firmware topology data is passed to component drivers for bespoke handling.
 
 #include <linux/kernel.h>
 #include <linux/export.h>
-- 
2.18.0.rc2
