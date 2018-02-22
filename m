From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: uniphier: evea: fix lisence comment
	style" to the asoc tree
Date: Thu, 22 Feb 2018 13:16:08 +0000
Message-ID: <E1eoqjI-0006Aq-Rz@debutante>
References: <20180221234232.5252-1-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A1ABC267720
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 14:16:26 +0100 (CET)
In-Reply-To: <20180221234232.5252-1-suzuki.katsuhiro@socionext.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: alsa-devel@alsa-project.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-kernel@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: uniphier: evea: fix lisence comment style

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

>From 24745dca8e7e17c20b6cf2bfb94a9acd09dce1b9 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Date: Thu, 22 Feb 2018 08:42:32 +0900
Subject: [PATCH] ASoC: uniphier: evea: fix lisence comment style

This patch changes lisence comment style from C to C++.
And use SPDX instead of boiler plate of GPLv2, as same as
other audio codec drivers.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/uniphier/evea.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/sound/soc/uniphier/evea.c b/sound/soc/uniphier/evea.c
index ac2d30b55fb6..439f14f91b23 100644
--- a/sound/soc/uniphier/evea.c
+++ b/sound/soc/uniphier/evea.c
@@ -1,22 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
-/*
- * Socionext UniPhier EVEA ADC/DAC codec driver.
- *
- * Copyright (c) 2016-2017 Socionext Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; version 2
- * of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
+//
+// Socionext UniPhier EVEA ADC/DAC codec driver.
+//
+// Copyright (c) 2016-2017 Socionext Inc.
 
 #include <linux/clk.h>
 #include <linux/module.h>
-- 
2.16.1
