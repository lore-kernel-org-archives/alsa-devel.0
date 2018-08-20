From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] ASoC: atmel: tse850: switch to SPDX license
	identifier
Date: Mon, 20 Aug 2018 12:14:09 +0200
Message-ID: <20180820101409.23328-1-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00103.outbound.protection.outlook.com [40.107.0.103])
 by alsa0.perex.cz (Postfix) with ESMTP id E040326766C
 for <alsa-devel@alsa-project.org>; Mon, 20 Aug 2018 12:14:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@microchip.com>
List-Id: alsa-devel@alsa-project.org

Convert to // comments in the leading comment, drop the boilerplate
license text and use the correct MODULE_LICENSE.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/atmel/tse850-pcm5142.c | 78 +++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 42 deletions(-)

diff --git a/sound/soc/atmel/tse850-pcm5142.c b/sound/soc/atmel/tse850-pcm5142.c
index 3a1393283156..214adcad5419 100644
--- a/sound/soc/atmel/tse850-pcm5142.c
+++ b/sound/soc/atmel/tse850-pcm5142.c
@@ -1,44 +1,38 @@
-/*
- * TSE-850 audio - ASoC driver for the Axentia TSE-850 with a PCM5142 codec
- *
- * Copyright (C) 2016 Axentia Technologies AB
- *
- * Author: Peter Rosin <peda@axentia.se>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-/*
- *               loop1 relays
- *   IN1 +---o  +------------+  o---+ OUT1
- *            \                /
- *             +              +
- *             |   /          |
- *             +--o  +--.     |
- *             |  add   |     |
- *             |        V     |
- *             |      .---.   |
- *   DAC +----------->|Sum|---+
- *             |      '---'   |
- *             |              |
- *             +              +
- *
- *   IN2 +---o--+------------+--o---+ OUT2
- *               loop2 relays
- *
- * The 'loop1' gpio pin controlls two relays, which are either in loop
- * position, meaning that input and output are directly connected, or
- * they are in mixer position, meaning that the signal is passed through
- * the 'Sum' mixer. Similarly for 'loop2'.
- *
- * In the above, the 'loop1' relays are inactive, thus feeding IN1 to the
- * mixer (if 'add' is active) and feeding the mixer output to OUT1. The
- * 'loop2' relays are active, short-cutting the TSE-850 from channel 2.
- * IN1, IN2, OUT1 and OUT2 are TSE-850 connectors and DAC is the PCB name
- * of the (filtered) output from the PCM5142 codec.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// TSE-850 audio - ASoC driver for the Axentia TSE-850 with a PCM5142 codec
+//
+// Copyright (C) 2016 Axentia Technologies AB
+//
+// Author: Peter Rosin <peda@axentia.se>
+//
+//               loop1 relays
+//   IN1 +---o  +------------+  o---+ OUT1
+//            \                /
+//             +              +
+//             |   /          |
+//             +--o  +--.     |
+//             |  add   |     |
+//             |        V     |
+//             |      .---.   |
+//   DAC +----------->|Sum|---+
+//             |      '---'   |
+//             |              |
+//             +              +
+//
+//   IN2 +---o--+------------+--o---+ OUT2
+//               loop2 relays
+//
+// The 'loop1' gpio pin controlls two relays, which are either in loop
+// position, meaning that input and output are directly connected, or
+// they are in mixer position, meaning that the signal is passed through
+// the 'Sum' mixer. Similarly for 'loop2'.
+//
+// In the above, the 'loop1' relays are inactive, thus feeding IN1 to the
+// mixer (if 'add' is active) and feeding the mixer output to OUT1. The
+// 'loop2' relays are active, short-cutting the TSE-850 from channel 2.
+// IN1, IN2, OUT1 and OUT2 are TSE-850 connectors and DAC is the PCB name
+// of the (filtered) output from the PCM5142 codec.
 
 #include <linux/clk.h>
 #include <linux/gpio.h>
@@ -452,4 +446,4 @@ module_platform_driver(tse850_driver);
 /* Module information */
 MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
 MODULE_DESCRIPTION("ALSA SoC driver for TSE-850 with PCM5142 codec");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0
