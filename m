From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ssm2305: fix header layout" to the asoc
	tree
Date: Fri, 18 May 2018 17:10:18 +0100
Message-ID: <E1fJhxS-0001Sb-8H@debutante>
References: <20180518095506.28875-1-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 397DE267412
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 18:10:23 +0200 (CEST)
In-Reply-To: <20180518095506.28875-1-m.felsch@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ssm2305: fix header layout

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

>From d460a2ea24db8b99eb7485ecccb453764e7d6b13 Mon Sep 17 00:00:00 2001
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Fri, 18 May 2018 11:55:06 +0200
Subject: [PATCH] ASoC: ssm2305: fix header layout

Make C-header and SPDX-License-Identifier header uniform.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ssm2305.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/ssm2305.c b/sound/soc/codecs/ssm2305.c
index 39d8b01cd852..2968959c4b75 100644
--- a/sound/soc/codecs/ssm2305.c
+++ b/sound/soc/codecs/ssm2305.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Analog Devices SSM2305 Amplifier Driver
- *
- * Copyright (C) 2018 Pengutronix, Marco Felsch <kernel@pengutronix.de>
- */
+//
+// Analog Devices SSM2305 Amplifier Driver
+//
+// Copyright (C) 2018 Pengutronix, Marco Felsch <kernel@pengutronix.de>
+//
 
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
-- 
2.17.0
