From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-compress: convert to SPDX
	identifiers" to the asoc tree
Date: Mon, 02 Jul 2018 11:10:12 +0100
Message-ID: <E1fZvme-0006Ru-Nq@debutante>
References: <877emef9bf.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 06D672677CB
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 04:59:10 +0200 (CEST)
In-Reply-To: <877emef9bf.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-compress: convert to SPDX identifiers

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

>From b3ed4c86a700b494fc5058a52531eeb14d6fe00f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 2 Jul 2018 06:24:57 +0000
Subject: [PATCH] ASoC: soc-compress: convert to SPDX identifiers

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/compress_driver.h | 21 +++------------------
 sound/soc/soc-compress.c        | 24 +++++++++---------------
 2 files changed, 12 insertions(+), 33 deletions(-)

diff --git a/include/sound/compress_driver.h b/include/sound/compress_driver.h
index 9924bc9cbc7c..ea8c93bbb0e0 100644
--- a/include/sound/compress_driver.h
+++ b/include/sound/compress_driver.h
@@ -1,27 +1,12 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  *  compress_driver.h - compress offload driver definations
  *
  *  Copyright (C) 2011 Intel Corporation
  *  Authors:	Vinod Koul <vinod.koul@linux.intel.com>
  *		Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
- *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; version 2 of the License.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *
  */
+
 #ifndef __COMPRESS_DRIVER_H
 #define __COMPRESS_DRIVER_H
 
diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index e095115fa9f9..b9e1673fea51 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -1,18 +1,12 @@
-/*
- * soc-compress.c  --  ALSA SoC Compress
- *
- * Copyright (C) 2012 Intel Corp.
- *
- * Authors: Namarta Kohli <namartax.kohli@intel.com>
- *          Ramesh Babu K V <ramesh.babu@linux.intel.com>
- *          Vinod Koul <vinod.koul@linux.intel.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// soc-compress.c  --  ALSA SoC Compress
+//
+// Copyright (C) 2012 Intel Corp.
+//
+// Authors: Namarta Kohli <namartax.kohli@intel.com>
+//          Ramesh Babu K V <ramesh.babu@linux.intel.com>
+//          Vinod Koul <vinod.koul@linux.intel.com>
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-- 
2.18.0.rc2
