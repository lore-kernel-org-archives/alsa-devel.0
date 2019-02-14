From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: i2s: Convert to SPDX License
	Indentifier" to the asoc tree
Date: Thu, 14 Feb 2019 14:51:11 +0000 (GMT)
Message-ID: <20190214145111.D77E21126F78@debutante.sirena.org.uk>
References: <20190214093747.2414-14-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 290BA267A14
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2019 15:51:13 +0100 (CET)
In-Reply-To: <20190214093747.2414-14-s.nawrocki@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: alsa-devel@alsa-project.org, sbkim73@samsung.com, lgirdwood@gmail.com, krzk@kernel.org, linux-kernel@vger.kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: i2s: Convert to SPDX License Indentifier

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

>From c1b2db4d038938c64f86b1764da2a5b04f95c171 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Thu, 14 Feb 2019 10:37:47 +0100
Subject: [PATCH] ASoC: samsung: i2s: Convert to SPDX License Indentifier

Replace GPL v2.0 license statements with SPDX license identifier.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/i2s.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 84cfa2c0ba68..03fff1c657be 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1,13 +1,9 @@
-/*
- * ALSA SoC Audio Layer - Samsung I2S Controller driver
- *
- * Copyright (c) 2010 Samsung Electronics Co. Ltd.
- *	Jaswinder Singh <jassisinghbrar@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// ALSA SoC Audio Layer - Samsung I2S Controller driver
+//
+// Copyright (c) 2010 Samsung Electronics Co. Ltd.
+//	Jaswinder Singh <jassisinghbrar@gmail.com>
 
 #include <dt-bindings/sound/samsung-i2s.h>
 #include <linux/delay.h>
-- 
2.20.1
