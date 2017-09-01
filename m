From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/2] ALSA: atmel: Remove leftovers of AVR32
	removal
Date: Fri,  1 Sep 2017 19:15:07 +0300
Message-ID: <20170901161507.70966-2-andriy.shevchenko@linux.intel.com>
References: <20170901161507.70966-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 77D95266F7B
 for <alsa-devel@alsa-project.org>; Fri,  1 Sep 2017 18:16:19 +0200 (CEST)
In-Reply-To: <20170901161507.70966-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The ALSA related include header files are left overs after the commit

	020c5260c2b1 ("ALSA: atmel: Remove AVR32 bits from the driver")

Fixes: 020c5260c2b1 ("ALSA: atmel: Remove AVR32 bits from the driver")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/sound/atmel-abdac.h | 23 -----------------------
 include/sound/atmel-ac97c.h | 38 --------------------------------------
 2 files changed, 61 deletions(-)
 delete mode 100644 include/sound/atmel-abdac.h
 delete mode 100644 include/sound/atmel-ac97c.h

diff --git a/include/sound/atmel-abdac.h b/include/sound/atmel-abdac.h
deleted file mode 100644
index a8f735d677fa..000000000000
--- a/include/sound/atmel-abdac.h
+++ /dev/null
@@ -1,23 +0,0 @@
-/*
- * Driver for the Atmel Audio Bitstream DAC (ABDAC)
- *
- * Copyright (C) 2009 Atmel Corporation
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published
- * by the Free Software Foundation.
- */
-#ifndef __INCLUDE_SOUND_ATMEL_ABDAC_H
-#define __INCLUDE_SOUND_ATMEL_ABDAC_H
-
-#include <linux/platform_data/dma-dw.h>
-
-/**
- * struct atmel_abdac_pdata - board specific ABDAC configuration
- * @dws: DMA slave interface to use for sound playback.
- */
-struct atmel_abdac_pdata {
-	struct dw_dma_slave	dws;
-};
-
-#endif /* __INCLUDE_SOUND_ATMEL_ABDAC_H */
diff --git a/include/sound/atmel-ac97c.h b/include/sound/atmel-ac97c.h
deleted file mode 100644
index f2a1cdc37661..000000000000
--- a/include/sound/atmel-ac97c.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * Driver for the Atmel AC97C controller
- *
- * Copyright (C) 2005-2009 Atmel Corporation
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published
- * by the Free Software Foundation.
- */
-#ifndef __INCLUDE_SOUND_ATMEL_AC97C_H
-#define __INCLUDE_SOUND_ATMEL_AC97C_H
-
-#include <linux/platform_data/dma-dw.h>
-
-#define AC97C_CAPTURE	0x01
-#define AC97C_PLAYBACK	0x02
-#define AC97C_BOTH	(AC97C_CAPTURE | AC97C_PLAYBACK)
-
-/**
- * struct atmel_ac97c_pdata - board specific AC97C configuration
- * @rx_dws: DMA slave interface to use for sound capture.
- * @tx_dws: DMA slave interface to use for sound playback.
- * @reset_pin: GPIO pin wired to the reset input on the external AC97 codec,
- *             optional to use, set to -ENODEV if not in use. AC97 layer will
- *             try to do a software reset of the external codec anyway.
- *
- * If the user do not want to use a DMA channel for playback or capture, i.e.
- * only one feature is required on the board. The slave for playback or capture
- * can be set to NULL. The AC97C driver will take use of this when setting up
- * the sound streams.
- */
-struct ac97c_platform_data {
-	struct dw_dma_slave	rx_dws;
-	struct dw_dma_slave	tx_dws;
-	int			reset_pin;
-};
-
-#endif /* __INCLUDE_SOUND_ATMEL_AC97C_H */
-- 
2.14.1
