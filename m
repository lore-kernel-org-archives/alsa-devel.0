From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ssm2602: switch to SPDX identifier" to
	the asoc tree
Date: Wed,  6 Feb 2019 18:17:39 +0000 (GMT)
Message-ID: <20190206181740.011A21127EA3@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D511F26799C
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2019 19:17:40 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ssm2602: switch to SPDX identifier

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

>From 47306401835a095843df8d87a51848f7e5e5099e Mon Sep 17 00:00:00 2001
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Wed, 6 Feb 2019 18:00:03 +0100
Subject: [PATCH] ASoC: ssm2602: switch to SPDX identifier

Drop old license header and switch to SPDX-License-Identifier.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ssm2602.c | 39 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 6f79cb0fbc63..464a4d7873bb 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -1,30 +1,15 @@
-/*
- * File:         sound/soc/codecs/ssm2602.c
- * Author:       Cliff Cai <Cliff.Cai@analog.com>
- *
- * Created:      Tue June 06 2008
- * Description:  Driver for ssm2602 sound chip
- *
- * Modified:
- *               Copyright 2008 Analog Devices Inc.
- *
- * Bugs:         Enter bugs at http://blackfin.uclinux.org/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see the file COPYING, or write
- * to the Free Software Foundation, Inc.,
- * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// File:         sound/soc/codecs/ssm2602.c
+// Author:       Cliff Cai <Cliff.Cai@analog.com>
+//
+// Created:      Tue June 06 2008
+// Description:  Driver for ssm2602 sound chip
+//
+// Modified:
+//               Copyright 2008 Analog Devices Inc.
+//
+// Bugs:         Enter bugs at http://blackfin.uclinux.org/
 
 #include <linux/delay.h>
 #include <linux/module.h>
-- 
2.20.1
