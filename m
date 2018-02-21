From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH] ASoC: uniphier: evea: fix lisence comment style
Date: Thu, 22 Feb 2018 08:42:32 +0900
Message-ID: <20180221234232.5252-1-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by alsa0.perex.cz (Postfix) with ESMTP id 61EB5266F88
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 00:42:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-arm-kernel@lists.infradead.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch changes lisence comment style from C to C++.
And use SPDX instead of boiler plate of GPLv2, as same as
other audio codec drivers.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
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
