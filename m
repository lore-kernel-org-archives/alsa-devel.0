From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 1/2] ad1848: separate header for registers
	definition
Date: Sun, 15 Jun 2008 12:41:21 +0200
Message-ID: <20080615124121.781d8aff.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BC251037FB
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Jun 2008 12:38:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Rene Herman <rene.herman@keyaccess.nl>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Separate AD1848 registers definition into a new header.
The new header can be used by compatible CS4231 chip
driver.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This patch is a start combining ad1848_lib and cs4231_lib
functionality. My approach is to make the cs4231_lib module
use the ad1848_lib module. This should allow removing
most of identical functions from the cs4231_lib and use
the functions from the ad1848_lib directly.

If this approach is not a good idea, please drop the patch.

My current plan is to reuse the ad1848 register constants
in the cs423x code and remove duplicated cs4231 constants.
This should make the ad1848_lib and cs4231_lib easier to
compare for differences.

The next step is to use the snd_cs4231 structure instead of 
the snd_ad1848 structure inside the ad1848_lib. This will make
functions from the ad1848_lib taking the same arguments
as the functions in the cs4231_lib.

The last step would be to export needed functions from the
ad1848_lib and use them directly in the cs4231_lib.

This should reduce the size of the cs4231_lib while preserving
smaller the ad1848_lib for driver which uses only ad1848
functionality.

Kind regards,
Krzysztof

diff -urpN linux-ref/include/sound/ad1848-regs.h linux-mm/include/sound/ad1848-regs.h
--- linux-ref/include/sound/ad1848-regs.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-mm/include/sound/ad1848-regs.h	2008-06-15 07:00:08.041351281 +0200
@@ -0,0 +1,104 @@
+#ifndef __SOUND_AD1848_REGS_H
+#define __SOUND_AD1848_REGS_H
+
+/*
+ *  Copyright (c) by Jaroslav Kysela <perex@perex.cz>
+ *  Definitions for AD1847/AD1848/CS4248 chips registers
+ *
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ */
+
+/* IO ports */
+
+#define AD1848P(chip, x) ((chip)->port + c_d_c_AD1848##x)
+
+#define c_d_c_AD1848REGSEL	0
+#define c_d_c_AD1848REG		1
+#define c_d_c_AD1848STATUS	2
+#define c_d_c_AD1848PIO		3
+
+/* codec registers */
+
+#define AD1848_LEFT_INPUT	0x00	/* left input control */
+#define AD1848_RIGHT_INPUT	0x01	/* right input control */
+#define AD1848_AUX1_LEFT_INPUT	0x02	/* left AUX1 input control */
+#define AD1848_AUX1_RIGHT_INPUT	0x03	/* right AUX1 input control */
+#define AD1848_AUX2_LEFT_INPUT	0x04	/* left AUX2 input control */
+#define AD1848_AUX2_RIGHT_INPUT	0x05	/* right AUX2 input control */
+#define AD1848_LEFT_OUTPUT	0x06	/* left output control register */
+#define AD1848_RIGHT_OUTPUT	0x07	/* right output control register */
+#define AD1848_DATA_FORMAT	0x08	/* clock and data format - playback/capture - bits 7-0 MCE */
+#define AD1848_IFACE_CTRL	0x09	/* interface control - bits 7-2 MCE */
+#define AD1848_PIN_CTRL		0x0a	/* pin control */
+#define AD1848_TEST_INIT	0x0b	/* test and initialization */
+#define AD1848_MISC_INFO	0x0c	/* miscellaneous information */
+#define AD1848_LOOPBACK		0x0d	/* loopback control */
+#define AD1848_DATA_UPR_CNT	0x0e	/* playback/capture upper base count */
+#define AD1848_DATA_LWR_CNT	0x0f	/* playback/capture lower base count */
+
+/* definitions for codec register select port - CODECP( REGSEL ) */
+
+#define AD1848_INIT		0x80	/* CODEC is initializing */
+#define AD1848_MCE		0x40	/* mode change enable */
+#define AD1848_TRD		0x20	/* transfer request disable */
+
+/* definitions for codec status register - CODECP( STATUS ) */
+
+#define AD1848_GLOBALIRQ	0x01	/* IRQ is active */
+
+/* definitions for AD1848_LEFT_INPUT and AD1848_RIGHT_INPUT registers */
+
+#define AD1848_ENABLE_MIC_GAIN	0x20
+
+#define AD1848_MIXS_LINE1	0x00
+#define AD1848_MIXS_AUX1	0x40
+#define AD1848_MIXS_LINE2	0x80
+#define AD1848_MIXS_ALL		0xc0
+
+/* definitions for clock and data format register - AD1848_PLAYBK_FORMAT */
+
+#define AD1848_LINEAR_8		0x00	/* 8-bit unsigned data */
+#define AD1848_ALAW_8		0x60	/* 8-bit A-law companded */
+#define AD1848_ULAW_8		0x20	/* 8-bit U-law companded */
+#define AD1848_LINEAR_16	0x40	/* 16-bit twos complement data - little endian */
+#define AD1848_STEREO		0x10	/* stereo mode */
+/* bits 3-1 define frequency divisor */
+#define AD1848_XTAL1		0x00	/* 24.576 crystal */
+#define AD1848_XTAL2		0x01	/* 16.9344 crystal */
+
+/* definitions for interface control register - AD1848_IFACE_CTRL */
+
+#define AD1848_CAPTURE_PIO	0x80	/* capture PIO enable */
+#define AD1848_PLAYBACK_PIO	0x40	/* playback PIO enable */
+#define AD1848_CALIB_MODE	0x18	/* calibration mode bits */
+#define AD1848_AUTOCALIB	0x08	/* auto calibrate */
+#define AD1848_SINGLE_DMA	0x04	/* use single DMA channel */
+#define AD1848_CAPTURE_ENABLE	0x02	/* capture enable */
+#define AD1848_PLAYBACK_ENABLE	0x01	/* playback enable */
+
+/* definitions for pin control register - AD1848_PIN_CTRL */
+
+#define AD1848_IRQ_ENABLE	0x02	/* enable IRQ */
+#define AD1848_XCTL1		0x40	/* external control #1 */
+#define AD1848_XCTL0		0x80	/* external control #0 */
+
+/* definitions for test and init register - AD1848_TEST_INIT */
+
+#define AD1848_CALIB_IN_PROGRESS 0x20	/* auto calibrate in progress */
+#define AD1848_DMA_REQUEST	0x10	/* DMA request in progress */
+
+#endif /* __SOUND_AD1848_REGS_H */
diff -urpN linux-ref/include/sound/ad1848.h linux-mm/include/sound/ad1848.h
--- linux-ref/include/sound/ad1848.h	2008-06-15 06:58:15.293013657 +0200
+++ linux-mm/include/sound/ad1848.h	2008-06-15 00:14:36.728628406 +0200
@@ -25,84 +25,7 @@
 #include "pcm.h"
 #include <linux/interrupt.h>
 
-/* IO ports */
-
-#define AD1848P( chip, x ) ( (chip) -> port + c_d_c_AD1848##x )
-
-#define c_d_c_AD1848REGSEL	0
-#define c_d_c_AD1848REG		1
-#define c_d_c_AD1848STATUS	2
-#define c_d_c_AD1848PIO		3
-
-/* codec registers */
-
-#define AD1848_LEFT_INPUT	0x00	/* left input control */
-#define AD1848_RIGHT_INPUT	0x01	/* right input control */
-#define AD1848_AUX1_LEFT_INPUT	0x02	/* left AUX1 input control */
-#define AD1848_AUX1_RIGHT_INPUT	0x03	/* right AUX1 input control */
-#define AD1848_AUX2_LEFT_INPUT	0x04	/* left AUX2 input control */
-#define AD1848_AUX2_RIGHT_INPUT	0x05	/* right AUX2 input control */
-#define AD1848_LEFT_OUTPUT	0x06	/* left output control register */
-#define AD1848_RIGHT_OUTPUT	0x07	/* right output control register */
-#define AD1848_DATA_FORMAT	0x08	/* clock and data format - playback/capture - bits 7-0 MCE */
-#define AD1848_IFACE_CTRL	0x09	/* interface control - bits 7-2 MCE */
-#define AD1848_PIN_CTRL		0x0a	/* pin control */
-#define AD1848_TEST_INIT	0x0b	/* test and initialization */
-#define AD1848_MISC_INFO	0x0c	/* miscellaneous information */
-#define AD1848_LOOPBACK		0x0d	/* loopback control */
-#define AD1848_DATA_UPR_CNT	0x0e	/* playback/capture upper base count */
-#define AD1848_DATA_LWR_CNT	0x0f	/* playback/capture lower base count */
-
-/* definitions for codec register select port - CODECP( REGSEL ) */
-
-#define AD1848_INIT		0x80	/* CODEC is initializing */
-#define AD1848_MCE		0x40	/* mode change enable */
-#define AD1848_TRD		0x20	/* transfer request disable */
-
-/* definitions for codec status register - CODECP( STATUS ) */
-
-#define AD1848_GLOBALIRQ	0x01	/* IRQ is active */
-
-/* definitions for AD1848_LEFT_INPUT and AD1848_RIGHT_INPUT registers */
-
-#define AD1848_ENABLE_MIC_GAIN	0x20
-
-#define AD1848_MIXS_LINE1	0x00
-#define AD1848_MIXS_AUX1	0x40
-#define AD1848_MIXS_LINE2	0x80
-#define AD1848_MIXS_ALL		0xc0
-
-/* definitions for clock and data format register - AD1848_PLAYBK_FORMAT */
-
-#define AD1848_LINEAR_8		0x00	/* 8-bit unsigned data */
-#define AD1848_ALAW_8		0x60	/* 8-bit A-law companded */
-#define AD1848_ULAW_8		0x20	/* 8-bit U-law companded */
-#define AD1848_LINEAR_16	0x40	/* 16-bit twos complement data - little endian */
-#define AD1848_STEREO		0x10	/* stereo mode */
-/* bits 3-1 define frequency divisor */
-#define AD1848_XTAL1		0x00	/* 24.576 crystal */
-#define AD1848_XTAL2		0x01	/* 16.9344 crystal */
-
-/* definitions for interface control register - AD1848_IFACE_CTRL */
-
-#define AD1848_CAPTURE_PIO	0x80	/* capture PIO enable */
-#define AD1848_PLAYBACK_PIO	0x40	/* playback PIO enable */
-#define AD1848_CALIB_MODE	0x18	/* calibration mode bits */
-#define AD1848_AUTOCALIB	0x08	/* auto calibrate */
-#define AD1848_SINGLE_DMA	0x04	/* use single DMA channel */
-#define AD1848_CAPTURE_ENABLE	0x02	/* capture enable */
-#define AD1848_PLAYBACK_ENABLE	0x01	/* playback enable */
-
-/* definitions for pin control register - AD1848_PIN_CTRL */
-
-#define AD1848_IRQ_ENABLE	0x02	/* enable IRQ */
-#define AD1848_XCTL1		0x40	/* external control #1 */
-#define AD1848_XCTL0		0x80	/* external control #0 */
-
-/* definitions for test and init register - AD1848_TEST_INIT */
-
-#define AD1848_CALIB_IN_PROGRESS 0x20	/* auto calibrate in progress */
-#define AD1848_DMA_REQUEST	0x10	/* DMA request in progress */
+#include "ad1848-regs.h"
 
 /* defines for codec.mode */
 

----------------------------------------------------------------------
Tania telefonia internetowa!
Sprawdz >>>  http://link.interia.pl/f1e2e
