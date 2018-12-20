From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: xlnx: change license header format
	style" to the asoc tree
Date: Thu, 20 Dec 2018 16:00:07 +0000 (GMT)
Message-ID: <20181220160007.193B81121B87@debutante.sirena.org.uk>
References: <1545212440-109949-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id ABC0F267AAA
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2018 17:00:09 +0100 (CET)
In-Reply-To: <1545212440-109949-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Michal Simek <michal.simek@xilinx.com>, Vishal Sagar <vsagar@xilinx.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: xlnx: change license header format style

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

>From b5ac0078aa6c40ea46760dcebf1ac4022217a51d Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Date: Wed, 19 Dec 2018 15:10:40 +0530
Subject: [PATCH] ASoC: xlnx: change license header format style

Changed License header from C to C++ style comment block.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/xilinx/xlnx_i2s.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/xilinx/xlnx_i2s.c b/sound/soc/xilinx/xlnx_i2s.c
index d4ae9eff41ce..8b353166ad44 100644
--- a/sound/soc/xilinx/xlnx_i2s.c
+++ b/sound/soc/xilinx/xlnx_i2s.c
@@ -1,12 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Xilinx ASoC I2S audio support
- *
- * Copyright (C) 2018 Xilinx, Inc.
- *
- * Author: Praveen Vuppala <praveenv@xilinx.com>
- * Author: Maruthi Srinivas Bayyavarapu <maruthis@xilinx.com>
- */
+//
+// Xilinx ASoC I2S audio support
+//
+// Copyright (C) 2018 Xilinx, Inc.
+//
+// Author: Praveen Vuppala <praveenv@xilinx.com>
+// Author: Maruthi Srinivas Bayyavarapu <maruthis@xilinx.com>
 
 #include <linux/io.h>
 #include <linux/module.h>
-- 
2.20.1
