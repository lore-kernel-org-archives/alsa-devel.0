From: Rene Herman <rene.herman@gmail.com>
Subject: [PATCH] New Aztech Sound Galaxy driver
Date: Thu, 20 Sep 2007 14:20:01 +0200
Message-ID: <46F26571.501@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040606060303080802020701"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 77AC0243E2
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Sep 2007 14:21:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040606060303080802020701
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

This is a new driver for Aztech Sound Galaxy ISA soundcards based on the 
AZT1605 and AZT2316 chipsets. It's constructed as two seperate drivers for 
either chipset generated from the same source file, with (very) minimal 
ifdeffery.

The drivers check the SB DSP version to decide if they are being loaded for 
the right chip. AZT1605 returns 2.1 by default, and AZT2316 3.1. This isn't 
full-proof as the DSP version can actually be set through software but it's 
close enough -- as far as I've been able to see, the DSP version can not be 
stored in the EEPROM and the cards will therefore startup with the defaults.

This distinction could (with the same success rate) also be used to decide 
which chip we're looking at at runtime meaning a single, merged driver is 
also an option but I feel it's actually nicer this way. A merged driver 
would have to postpone translating the passed in resource values to the card 
configuration until it knew which one it was looking at and would need to 
postpone erring out on mpu_irq=10 for azt1605 and mpu_irq=3 for azt2316. If 
you differ, I will merge them, but I'd rather keep them seperate.

The drivers have been tested on various cards. For snd-azt1605:

FCC-ID I38-MMSN811: Aztech Sound Galaxy Nova 16 Extra
FCC-ID I38-MMSN822: Aztech Sound Galaxy Pro 16 II

and for snd-azt2316:

FCC-ID I38-MMSN824: Aztech Sound Galaxy Pro 16 AB
FCC-ID I38-MMSN826: Trust Sound Expert DeLuxe Wave 32 (05201)
FCC-ID I38-MMSN830: Trust Sound Expert DeLuxe 16+ (05202)
FCC-ID I38-MMSN847: Trust Sound Expert DeLuxe Wave 32-3D (06301)
FCC-ID I38-MMSN852: Aztech Sound Galaxy Waverider Pro 32-3D

I38-MMSN826 is also known as "Aztech Sound Galaxy Waverider 32+".

All cards work fully -- full-duplex PCM, MIDI and FM. Full-duplex is a 
little flaky on some.

I38-MSN811 tends to not work in full duplex, but sometimes does with the 
highest success rate being achieved when you first start the capture and 
then a playback instead of the other way around (it's a CS4231-KL codec).

The cards with an AD1845XP codec (my I38-MMSN826 and one of my I38-MMSN830s) 
are also somewhat duplex-challenged. Sometimes full-duplex works, sometimes 
not and this varies from try to try. This seems likely to be a timing 
problem somewhere inside cs4231-lib.

I38-MMSN826 has an additional "ICS2115 WaveFront" wavetable synth onboard 
that isn't supported yet. The wavetable synths on I38-MMSN847 and 
I38-MMSN852 are wired directly to the standard MPU-401 UART and the AUX1 
input on the codec and work without problem.

CD-ROM audio on the cards is routed to the codec "Line" input, Line-In to 
its Aux input, and FM/Wavetable to its AUX1 input. I did not rename the 
controls due to the capture source enumeration: I see that capture-source 
overrides are hardcoded in cs4231-lib and this is just too ugly to live.

Versus the old snd-sgalaxy driver, these drivers add support for the models 
without a configuration EEPROM (common), full-duplex, MPU-401 UART and OPL3. 
In the future they should grow support for that ICS2115 WaveFront synth on 
826 and an hwdep interface to write to the EEPROM on the models that have one.

lib.c was split off in preparation of having snd-azt2320 use it as well and 
generally containing non soundgalaxy specific code that might at some point 
make it into an isa/lib.c or something. It's tiny, so it's not constructed 
as a helper module but simply compiled into both drivers.

Signed-off-by: Rene Herman <rene.herman@gmail.com>

[ all of the above is intended as a changelog ]

Given that they are new drivers with new names, they shouldn't disturb 
anything and can as far as I'm concerned make 1.0.15 but if you feel it's 
too late (and/or don't want the two seperate drivers), so be it. I can also 
submit a next patch removing the old sgalaxy driver now or just wait with 
that one...

Patch is against current alsa-kernel hg.

Rene.

--------------040606060303080802020701
Content-Type: text/plain;
 name="galaxy.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="galaxy.diff"

diff -r 0687faf0e009 Documentation/ALSA-Configuration.txt
--- a/Documentation/ALSA-Configuration.txt	Wed Sep 19 21:20:17 2007 +0200
+++ b/Documentation/ALSA-Configuration.txt	Thu Sep 20 14:15:22 2007 +0200
@@ -296,6 +296,74 @@ Prior to version 0.9.0rc4 options had a 
     Note: Some ALSA mixer applications don't handle the SPDIF sample rate 
            control correctly. If you have problems regarding this, try
            another ALSA compliant mixer (alsamixer works).
+
+  Module snd-azt1605
+  ------------------
+
+    Module for Aztech Sound Galaxy soundcards based on the Aztech AZT1605
+    chipset.
+
+    port	- port # for BASE (0x220,0x240,0x260,0x280)
+    wss_port	- port # for WSS (0x530,0x604,0xe80,0xf40)
+    irq		- IRQ # for WSS (7,9,10,11)
+    dma1	- DMA # for WSS playback (0,1,3)
+    dma2	- DMA # for WSS capture (0,1), -1 = disabled (default)
+    mpu_port	- port # for MPU-401 UART (0x300,0x330), -1 = disabled (default)
+    mpu_irq	- IRQ # for MPU-401 UART (3,5,7,9), -1 = disabled (default)
+    fm_port	- port # for OPL3 (0x388), -1 = disabled (default)
+
+    This module supports multiple cards. It does not support autoprobe: port,
+    wss_port, irq and dma1 have to be specified. The other values are
+    optional.
+
+    "port" needs to match the BASE ADDRESS jumper on the card (0x220 or 0x240)
+    or the value stored in the card's EEPROM for cards that have an EEPROM and
+    their "CONFIG MODE" jumper set to "EEPROM SETTING". The other values can
+    be choosen freely from the options enumerated above.
+
+    If dma2 is specified and different from dma1, the card will operate in
+    full-duplex mode. When dma1=3, only dma2=0 is valid and the only way to
+    enable capture since only channels 0 and 1 are available for capture.
+
+    Generic settings are "port=0x220 wss_port=0x530 irq=10 dma1=1 dma2=0
+    mpu_port=0x330 mpu_irq=9 fm_port=0x388".
+
+    Whatever IRQ and DMA channels you pick, be sure to reserve them for
+    legacy ISA in your BIOS.
+
+  Module snd-azt2316
+  ------------------
+
+    Module for Aztech Sound Galaxy soundcards based on the Aztech AZT2316
+    chipset.
+
+    port	- port # for BASE (0x220,0x240,0x260,0x280)
+    wss_port	- port # for WSS (0x530,0x604,0xe80,0xf40)
+    irq		- IRQ # for WSS (7,9,10,11)
+    dma1	- DMA # for WSS playback (0,1,3)
+    dma2	- DMA # for WSS capture (0,1), -1 = disabled (default)
+    mpu_port	- port # for MPU-401 UART (0x300,0x330), -1 = disabled (default)
+    mpu_irq	- IRQ # for MPU-401 UART (5,7,9,10), -1 = disabled (default)
+    fm_port	- port # for OPL3 (0x388), -1 = disabled (default)
+
+    This module supports multiple cards. It does not support autoprobe: port,
+    wss_port, irq and dma1 have to be specified. The other values are
+    optional.
+
+    "port" needs to match the BASE ADDRESS jumper on the card (0x220 or 0x240)
+    or the value stored in the card's EEPROM for cards that have an EEPROM and
+    their "CONFIG MODE" jumper set to "EEPROM SETTING". The other values can
+    be choosen freely from the options enumerated above.
+
+    If dma2 is specified and different from dma1, the card will operate in
+    full-duplex mode. When dma1=3, only dma2=0 is valid and the only way to
+    enable capture since only channels 0 and 1 are available for capture.
+
+    Generic settings are "port=0x220 wss_port=0x530 irq=10 dma1=1 dma2=0
+    mpu_port=0x330 mpu_irq=9 fm_port=0x388".
+
+    Whatever IRQ and DMA channels you pick, be sure to reserve them for
+    legacy ISA in your BIOS.
 
   Module snd-azt2320
   ------------------
diff -r 0687faf0e009 isa/Kconfig
--- a/isa/Kconfig	Wed Sep 19 21:20:17 2007 +0200
+++ b/isa/Kconfig	Thu Sep 20 14:15:22 2007 +0200
@@ -76,6 +76,32 @@ config SND_ALS100
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-als100.
 
+config SND_AZT1605
+	tristate "Aztech AZT1605 Driver"
+	depends on SND
+	select SND_CS4231_LIB
+	select SND_MPU401_UART
+	select SND_OPL3_LIB
+	help
+	  Say Y here to include support for Aztech Sound Galaxy cards
+	  based on the AZT1605 chipset.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-azt1605.
+
+config SND_AZT2316
+	tristate "Aztech AZT2316 Driver"
+	depends on SND
+	select SND_CS4231_LIB
+	select SND_MPU401_UART
+	select SND_OPL3_LIB
+	help
+	  Say Y here to include support for Aztech Sound Galaxy cards
+	  based on the AZT2316 chipset.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-azt2316.
+
 config SND_AZT2320
 	tristate "Aztech Systems AZT2320"
 	depends on SND && PNP && ISA
diff -r 0687faf0e009 isa/Makefile
--- a/isa/Makefile	Wed Sep 19 21:20:17 2007 +0200
+++ b/isa/Makefile	Thu Sep 20 14:15:22 2007 +0200
@@ -26,5 +26,5 @@ obj-$(CONFIG_SND_SGALAXY) += snd-sgalaxy
 obj-$(CONFIG_SND_SGALAXY) += snd-sgalaxy.o
 obj-$(CONFIG_SND_SSCAPE) += snd-sscape.o
 
-obj-$(CONFIG_SND) += ad1816a/ ad1848/ cs423x/ es1688/ gus/ opti9xx/ \
+obj-$(CONFIG_SND) += ad1816a/ ad1848/ cs423x/ es1688/ galaxy/ gus/ opti9xx/ \
 		     sb/ wavefront/
diff -r 0687faf0e009 isa/galaxy/Makefile
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/isa/galaxy/Makefile	Thu Sep 20 14:15:22 2007 +0200
@@ -0,0 +1,10 @@
+#
+# Makefile for ALSA
+# Copyright (c) 2001 by Jaroslav Kysela <perex@suse.cz>
+#
+
+snd-azt1605-objs := azt1605.o lib.o
+snd-azt2316-objs := azt2316.o lib.o
+
+obj-$(CONFIG_SND_AZT1605) += snd-azt1605.o
+obj-$(CONFIG_SND_AZT2316) += snd-azt2316.o
diff -r 0687faf0e009 isa/galaxy/azt1605.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/isa/galaxy/azt1605.c	Thu Sep 20 14:15:22 2007 +0200
@@ -0,0 +1,91 @@
+/*
+ * Aztech AZT1605 Driver
+ * Copyright (C) 2007  Rene Herman
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#define AZT1605
+
+#define CRD_NAME "Aztech AZT1605"
+#define DRV_NAME "AZT1605"
+#define DEV_NAME "azt1605"
+
+#define GALAXY_DSP_MAJOR		2
+#define GALAXY_DSP_MINOR		1
+
+#define GALAXY_CONFIG_SIZE		3
+
+/*
+ * 24-bit config register
+ */
+
+#define GALAXY_CONFIG_SBA_220		(0 << 0)
+#define GALAXY_CONFIG_SBA_240		(1 << 0)
+#define GALAXY_CONFIG_SBA_260		(2 << 0)
+#define GALAXY_CONFIG_SBA_280		(3 << 0)
+#define GALAXY_CONFIG_SBA_MASK		GALAXY_CONFIG_SBA_280
+
+#define GALAXY_CONFIG_MPUA_300		(0 << 2)
+#define GALAXY_CONFIG_MPUA_330		(1 << 2)
+
+#define GALAXY_CONFIG_MPU_ENABLE	(1 << 3)
+
+#define GALAXY_CONFIG_GAME_ENABLE	(1 << 4)
+
+#define GALAXY_CONFIG_CD_PANASONIC	(1 << 5)
+#define GALAXY_CONFIG_CD_MITSUMI	(1 << 6)
+#define GALAXY_CONFIG_CD_MASK		(\
+	GALAXY_CONFIG_CD_PANASONIC | GALAXY_CONFIG_CD_MITSUMI)
+
+#define GALAXY_CONFIG_UNUSED		(1 << 7)
+#define GALAXY_CONFIG_UNUSED_MASK	GALAXY_CONFIG_UNUSED
+
+#define GALAXY_CONFIG_SBIRQ_2		(1 << 8)
+#define GALAXY_CONFIG_SBIRQ_3		(1 << 9)
+#define GALAXY_CONFIG_SBIRQ_5		(1 << 10)
+#define GALAXY_CONFIG_SBIRQ_7		(1 << 11)
+
+#define GALAXY_CONFIG_MPUIRQ_2		(1 << 12)
+#define GALAXY_CONFIG_MPUIRQ_3		(1 << 13)
+#define GALAXY_CONFIG_MPUIRQ_5		(1 << 14)
+#define GALAXY_CONFIG_MPUIRQ_7		(1 << 15)
+
+#define GALAXY_CONFIG_WSSA_530		(0 << 16)
+#define GALAXY_CONFIG_WSSA_604		(1 << 16)
+#define GALAXY_CONFIG_WSSA_E80		(2 << 16)
+#define GALAXY_CONFIG_WSSA_F40		(3 << 16)
+
+#define GALAXY_CONFIG_WSS_ENABLE	(1 << 18)
+
+#define GALAXY_CONFIG_CDIRQ_11		(1 << 19)
+#define GALAXY_CONFIG_CDIRQ_12		(1 << 20)
+#define GALAXY_CONFIG_CDIRQ_15		(1 << 21)
+#define GALAXY_CONFIG_CDIRQ_MASK	(\
+	GALAXY_CONFIG_CDIRQ_11 | GALAXY_CONFIG_CDIRQ_12 |\
+	GALAXY_CONFIG_CDIRQ_15)
+
+#define GALAXY_CONFIG_CDDMA_DISABLE	(0 << 22)
+#define GALAXY_CONFIG_CDDMA_0		(1 << 22)
+#define GALAXY_CONFIG_CDDMA_1		(2 << 22)
+#define GALAXY_CONFIG_CDDMA_3		(3 << 22)
+#define GALAXY_CONFIG_CDDMA_MASK	GALAXY_CONFIG_CDDMA_3
+
+#define GALAXY_CONFIG_MASK		(\
+	GALAXY_CONFIG_SBA_MASK | GALAXY_CONFIG_CD_MASK |\
+	GALAXY_CONFIG_UNUSED_MASK | GALAXY_CONFIG_CDIRQ_MASK |\
+	GALAXY_CONFIG_CDDMA_MASK)
+
+#include "galaxy.c"
diff -r 0687faf0e009 isa/galaxy/azt2316.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/isa/galaxy/azt2316.c	Thu Sep 20 14:15:22 2007 +0200
@@ -0,0 +1,111 @@
+/*
+ * Aztech AZT2316 Driver
+ * Copyright (C) 2007  Rene Herman
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#define AZT2316
+
+#define CRD_NAME "Aztech AZT2316"
+#define DRV_NAME "AZT2316"
+#define DEV_NAME "azt2316"
+
+#define GALAXY_DSP_MAJOR		3
+#define GALAXY_DSP_MINOR		1
+
+#define GALAXY_CONFIG_SIZE		4
+
+/*
+ * 32-bit config register
+ */
+
+#define GALAXY_CONFIG_SBA_220		(0 << 0)
+#define GALAXY_CONFIG_SBA_240		(1 << 0)
+#define GALAXY_CONFIG_SBA_260		(2 << 0)
+#define GALAXY_CONFIG_SBA_280		(3 << 0)
+#define GALAXY_CONFIG_SBA_MASK		GALAXY_CONFIG_SBA_280
+
+#define GALAXY_CONFIG_SBIRQ_2		(1 << 2)
+#define GALAXY_CONFIG_SBIRQ_5		(1 << 3)
+#define GALAXY_CONFIG_SBIRQ_7		(1 << 4)
+#define GALAXY_CONFIG_SBIRQ_10		(1 << 5)
+
+#define GALAXY_CONFIG_SBDMA_DISABLE	(0 << 6)
+#define GALAXY_CONFIG_SBDMA_0		(1 << 6)
+#define GALAXY_CONFIG_SBDMA_1		(2 << 6)
+#define GALAXY_CONFIG_SBDMA_3		(3 << 6)
+
+#define GALAXY_CONFIG_WSSA_530		(0 << 8)
+#define GALAXY_CONFIG_WSSA_604		(1 << 8)
+#define GALAXY_CONFIG_WSSA_E80		(2 << 8)
+#define GALAXY_CONFIG_WSSA_F40		(3 << 8)
+
+#define GALAXY_CONFIG_WSS_ENABLE	(1 << 10)
+
+#define GALAXY_CONFIG_GAME_ENABLE	(1 << 11)
+
+#define GALAXY_CONFIG_MPUA_300		(0 << 12)
+#define GALAXY_CONFIG_MPUA_330		(1 << 12)
+
+#define GALAXY_CONFIG_MPU_ENABLE	(1 << 13)
+
+#define GALAXY_CONFIG_CDA_310		(0 << 14)
+#define GALAXY_CONFIG_CDA_320		(1 << 14)
+#define GALAXY_CONFIG_CDA_340		(2 << 14)
+#define GALAXY_CONFIG_CDA_350		(3 << 14)
+#define GALAXY_CONFIG_CDA_MASK		GALAXY_CONFIG_CDA_350
+
+#define GALAXY_CONFIG_CD_DISABLE	(0 << 16)
+#define GALAXY_CONFIG_CD_PANASONIC	(1 << 16)
+#define GALAXY_CONFIG_CD_SONY		(2 << 16)
+#define GALAXY_CONFIG_CD_MITSUMI	(3 << 16)
+#define GALAXY_CONFIG_CD_AZTECH		(4 << 16)
+#define GALAXY_CONFIG_CD_UNUSED_5	(5 << 16)
+#define GALAXY_CONFIG_CD_UNUSED_6	(6 << 16)
+#define GALAXY_CONFIG_CD_UNUSED_7	(7 << 16)
+#define GALAXY_CONFIG_CD_MASK		GALAXY_CONFIG_CD_UNUSED_7
+
+#define GALAXY_CONFIG_CDDMA8_DISABLE	(0 << 20)
+#define GALAXY_CONFIG_CDDMA8_0		(1 << 20)
+#define GALAXY_CONFIG_CDDMA8_1		(2 << 20)
+#define GALAXY_CONFIG_CDDMA8_3		(3 << 20)
+#define GALAXY_CONFIG_CDDMA8_MASK	GALAXY_CONFIG_CDDMA8_3
+
+#define GALAXY_CONFIG_CDDMA16_DISABLE	(0 << 22)
+#define GALAXY_CONFIG_CDDMA16_5		(1 << 22)
+#define GALAXY_CONFIG_CDDMA16_6		(2 << 22)
+#define GALAXY_CONFIG_CDDMA16_7		(3 << 22)
+#define GALAXY_CONFIG_CDDMA16_MASK	GALAXY_CONFIG_CDDMA16_7
+
+#define GALAXY_CONFIG_MPUIRQ_2		(1 << 24)
+#define GALAXY_CONFIG_MPUIRQ_5		(1 << 25)
+#define GALAXY_CONFIG_MPUIRQ_7		(1 << 26)
+#define GALAXY_CONFIG_MPUIRQ_10		(1 << 27)
+
+#define GALAXY_CONFIG_CDIRQ_5		(1 << 28)
+#define GALAXY_CONFIG_CDIRQ_11		(1 << 29)
+#define GALAXY_CONFIG_CDIRQ_12		(1 << 30)
+#define GALAXY_CONFIG_CDIRQ_15		(1 << 31)
+#define GALAXY_CONFIG_CDIRQ_MASK	(\
+	GALAXY_CONFIG_CDIRQ_5 | GALAXY_CONFIG_CDIRQ_11 |\
+	GALAXY_CONFIG_CDIRQ_12 | GALAXY_CONFIG_CDIRQ_15)
+
+#define GALAXY_CONFIG_MASK		(\
+	GALAXY_CONFIG_SBA_MASK | GALAXY_CONFIG_CDA_MASK |\
+	GALAXY_CONFIG_CD_MASK | GALAXY_CONFIG_CDDMA16_MASK |\
+	GALAXY_CONFIG_CDDMA8_MASK | GALAXY_CONFIG_CDIRQ_MASK)
+
+#include "galaxy.c"
diff -r 0687faf0e009 isa/galaxy/galaxy.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/isa/galaxy/galaxy.c	Thu Sep 20 14:15:22 2007 +0200
@@ -0,0 +1,562 @@
+/*
+ * Aztech AZT1605/AZT2316 Driver
+ * Copyright (C) 2007  Rene Herman
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <sound/driver.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/isa.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/cs4231.h>
+#include <sound/mpu401.h>
+#include <sound/opl3.h>
+#include "lib.h"
+
+MODULE_DESCRIPTION(CRD_NAME);
+MODULE_AUTHOR("Rene Herman");
+MODULE_LICENSE("GPL");
+
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;
+
+module_param_array(index, int, NULL, 0444);
+MODULE_PARM_DESC(index, "Index value for " CRD_NAME " soundcard.");
+module_param_array(id, charp, NULL, 0444);
+MODULE_PARM_DESC(id, "ID string for " CRD_NAME " soundcard.");
+module_param_array(enable, bool, NULL, 0444);
+MODULE_PARM_DESC(enable, "Enable " CRD_NAME " soundcard.");
+
+static long port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
+static long wss_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
+static long mpu_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
+static long fm_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
+static int irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;
+static int mpu_irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;
+static int dma1[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;
+static int dma2[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;
+
+module_param_array(port, long, NULL, 0444);
+MODULE_PARM_DESC(port, "Port # for " CRD_NAME " driver.");
+module_param_array(wss_port, long, NULL, 0444);
+MODULE_PARM_DESC(wss_port, "WSS port # for " CRD_NAME " driver.");
+module_param_array(mpu_port, long, NULL, 0444);
+MODULE_PARM_DESC(mpu_port, "MPU-401 port # for " CRD_NAME " driver.");
+module_param_array(fm_port, long, NULL, 0444);
+MODULE_PARM_DESC(fm_port, "FM port # for " CRD_NAME " driver.");
+module_param_array(irq, int, NULL, 0444);
+MODULE_PARM_DESC(irq, "IRQ # for " CRD_NAME " driver.");
+module_param_array(mpu_irq, int, NULL, 0444);
+MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for " CRD_NAME " driver.");
+module_param_array(dma1, int, NULL, 0444);
+MODULE_PARM_DESC(dma1, "Playback DMA # for " CRD_NAME " driver.");
+module_param_array(dma2, int, NULL, 0444);
+MODULE_PARM_DESC(dma2, "Capture DMA # for " CRD_NAME " driver.");
+
+#define GALAXY_PORT_CONFIG	1024
+#define CONFIG_PORT_SET		4
+
+#define DSP_COMMAND_GALAXY_8	8
+#define GALAXY_COMMAND_GET_TYPE	5
+
+#define DSP_COMMAND_GALAXY_9	9
+#define GALAXY_COMMAND_WSSMODE	0
+#define GALAXY_COMMAND_SB8MODE	1
+
+#define GALAXY_MODE_WSS		GALAXY_COMMAND_WSSMODE
+#define GALAXY_MODE_SB8		GALAXY_COMMAND_SB8MODE
+
+struct snd_galaxy {
+	void __iomem *port;
+	void __iomem *config_port;
+	void __iomem *wss_port;
+	u32 config;
+	struct resource *res_port;
+	struct resource *res_config_port;
+	struct resource *res_wss_port;
+};
+
+static u32 config[SNDRV_CARDS];
+static u8 wss_config[SNDRV_CARDS];
+
+static int __devinit snd_galaxy_match(struct device *dev, unsigned int n)
+{
+	if (!enable[n])
+		return 0;
+
+	switch (port[n]) {
+	case SNDRV_AUTO_PORT:
+		snd_printk(KERN_ERR "%s: please specify port\n", dev->bus_id);
+		return 0;
+	case 0x220:
+		config[n] |= GALAXY_CONFIG_SBA_220;
+		break;
+	case 0x240:
+		config[n] |= GALAXY_CONFIG_SBA_240;
+		break;
+	case 0x260:
+		config[n] |= GALAXY_CONFIG_SBA_260;
+		break;
+	case 0x280:
+		config[n] |= GALAXY_CONFIG_SBA_280;
+		break;
+	default:
+		snd_printk(KERN_ERR "%s: invalid port %#lx\n", dev->bus_id,
+			   port[n]);
+		return 0;
+	}
+
+	switch (wss_port[n]) {
+	case SNDRV_AUTO_PORT:
+		snd_printk(KERN_ERR "%s: please specify wss_port\n",
+			   dev->bus_id);
+		return 0;
+	case 0x530:
+		config[n] |= GALAXY_CONFIG_WSS_ENABLE | GALAXY_CONFIG_WSSA_530;
+		break;
+	case 0x604:
+		config[n] |= GALAXY_CONFIG_WSS_ENABLE | GALAXY_CONFIG_WSSA_604;
+		break;
+	case 0xe80:
+		config[n] |= GALAXY_CONFIG_WSS_ENABLE | GALAXY_CONFIG_WSSA_E80;
+		break;
+	case 0xf40:
+		config[n] |= GALAXY_CONFIG_WSS_ENABLE | GALAXY_CONFIG_WSSA_F40;
+		break;
+	default:
+		snd_printk(KERN_ERR "%s: invalid WSS port %#lx\n", dev->bus_id,
+			   wss_port[n]);
+		return 0;
+	}
+
+	switch (irq[n]) {
+	case SNDRV_AUTO_IRQ:
+		snd_printk(KERN_ERR "%s: please specify irq\n", dev->bus_id);
+		return 0;
+	case 7:
+		wss_config[n] |= WSS_CONFIG_IRQ_7;
+		break;
+	case 2:
+		irq[n] = 9;
+	case 9:
+		wss_config[n] |= WSS_CONFIG_IRQ_9;
+		break;
+	case 10:
+		wss_config[n] |= WSS_CONFIG_IRQ_10;
+		break;
+	case 11:
+		wss_config[n] |= WSS_CONFIG_IRQ_11;
+		break;
+	default:
+		snd_printk(KERN_ERR "%s: invalid IRQ %d\n", dev->bus_id,
+			   irq[n]);
+		return 0;
+	}
+
+	switch (dma1[n]) {
+	case SNDRV_AUTO_DMA:
+		snd_printk(KERN_ERR "%s: please specify dma1\n",
+			   dev->bus_id);
+		return 0;
+	case 0:
+		wss_config[n] |= WSS_CONFIG_DMA_0;
+		break;
+	case 1:
+		wss_config[n] |= WSS_CONFIG_DMA_1;
+		break;
+	case 3:
+		wss_config[n] |= WSS_CONFIG_DMA_3;
+		break;
+	default:
+		snd_printk(KERN_ERR "%s: invalid playback DMA %d\n",
+			   dev->bus_id, dma1[n]);
+		return 0;
+	}
+
+	if (dma2[n] == SNDRV_AUTO_DMA || dma2[n] == dma1[n]) {
+		dma2[n] = -1;
+		goto mpu;
+	}
+
+	wss_config[n] |= WSS_CONFIG_DUPLEX;
+	switch (dma2[n]) {
+	case 1:
+		if (dma1[n] == 0)
+	case 0:
+			break;
+	default:
+		snd_printk(KERN_ERR "%s: invalid capture DMA %d\n",
+			   dev->bus_id, dma2[n]);
+		return 0;
+	}
+
+mpu:
+	switch (mpu_port[n]) {
+	case SNDRV_AUTO_PORT:
+		snd_printk(KERN_WARNING "%s: mpu_port not specified; not using "
+			   "MPU-401\n", dev->bus_id);
+		mpu_port[n] = -1;
+		goto fm;
+	case 0x300:
+		config[n] |= GALAXY_CONFIG_MPU_ENABLE | GALAXY_CONFIG_MPUA_300;
+		break;
+	case 0x330:
+		config[n] |= GALAXY_CONFIG_MPU_ENABLE | GALAXY_CONFIG_MPUA_330;
+		break;
+	default:
+		snd_printk(KERN_ERR "%s: invalid mpu port %#lx\n", dev->bus_id,
+			   mpu_port[n]);
+		return 0;
+	}
+
+	switch (mpu_irq[n]) {
+	case SNDRV_AUTO_IRQ:
+		snd_printk(KERN_WARNING "%s: mpu_irq not specified; using "
+			   "polling mode\n", dev->bus_id);
+		mpu_irq[n] = -1;
+		break;
+	case 2:
+		mpu_irq[n] = 9;
+	case 9:
+		config[n] |= GALAXY_CONFIG_MPUIRQ_2;
+		break;
+#ifdef AZT1605
+	case 3:
+		config[n] |= GALAXY_CONFIG_MPUIRQ_3;
+		break;
+#endif
+	case 5:
+		config[n] |= GALAXY_CONFIG_MPUIRQ_5;
+		break;
+	case 7:
+		config[n] |= GALAXY_CONFIG_MPUIRQ_7;
+		break;
+#ifdef AZT2316
+	case 10:
+		config[n] |= GALAXY_CONFIG_MPUIRQ_10;
+		break;
+#endif
+	default:
+		snd_printk(KERN_ERR "%s: invalid MPU IRQ %d\n", dev->bus_id,
+			   mpu_irq[n]);
+		return 0;
+	}
+
+	if (mpu_irq[n] == irq[n]) {
+		snd_printk(KERN_ERR "%s: cannot share IRQ between WSS and "
+			   "MPU-401\n", dev->bus_id);
+		return 0;
+	}
+
+fm:
+	switch (fm_port[n]) {
+	case SNDRV_AUTO_PORT:
+		snd_printk(KERN_WARNING "%s: fm_port not specified: not using "
+			   "OPL3\n", dev->bus_id);
+		fm_port[n] = -1;
+		break;
+	case 0x388:
+		break;
+	default:
+		snd_printk(KERN_ERR "%s: illegal FM port %#lx\n", dev->bus_id,
+			   fm_port[n]);
+		return 0;
+	}
+
+	config[n] |= GALAXY_CONFIG_GAME_ENABLE;
+	return 1;
+}
+
+static int __devinit __galaxy_init(struct snd_galaxy *galaxy, u8 *type)
+{
+	u8 major;
+	u8 minor;
+	int err;
+
+	err = __dsp_reset(galaxy->port);
+	if (err < 0)
+		return err;
+
+	err = __dsp_get_version(galaxy->port, &major, &minor);
+	if (err < 0)
+		return err;
+
+	if (major != GALAXY_DSP_MAJOR || minor != GALAXY_DSP_MINOR)
+		return -ENODEV;
+
+	err = __dsp_command(galaxy->port, DSP_COMMAND_GALAXY_8);
+	if (err < 0)
+		return err;
+
+	err = __dsp_command(galaxy->port, GALAXY_COMMAND_GET_TYPE);
+	if (err < 0)
+		return err;
+
+	err = __dsp_get_byte(galaxy->port, type);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int __devinit __galaxy_set_mode(struct snd_galaxy *galaxy, u8 mode)
+{
+	int err;
+
+	err = __dsp_command(galaxy->port, DSP_COMMAND_GALAXY_9);
+	if (err < 0)
+		return err;
+
+	err = __dsp_command(galaxy->port, mode);
+	if (err < 0)
+		return err;
+
+#ifdef AZT1605
+	/*
+	 * Needed for MPU IRQ on AZT1605, but AZT2316 loses WSS again
+	 */
+	err = __dsp_reset(galaxy->port);
+	if (err < 0)
+		return err;
+#endif
+
+	return 0;
+}
+
+static void __galaxy_set_config(struct snd_galaxy *galaxy, u32 config)
+{
+	u8 tmp = ioread8(galaxy->config_port + CONFIG_PORT_SET);
+	int i;
+
+	iowrite8(tmp | 0x80, galaxy->config_port + CONFIG_PORT_SET);
+	for (i = 0; i < GALAXY_CONFIG_SIZE; i++) {
+		iowrite8(config, galaxy->config_port + i);
+		config >>= 8;
+	}
+	iowrite8(tmp & 0x7f, galaxy->config_port + CONFIG_PORT_SET);
+	msleep(10);
+}
+
+static void __devinit __galaxy_config(struct snd_galaxy *galaxy, u32 config)
+{
+	int i;
+
+	for (i = GALAXY_CONFIG_SIZE; i; i--) {
+		u8 tmp = ioread8(galaxy->config_port + i - 1);
+		galaxy->config = (galaxy->config << 8) | tmp;
+	}
+	config |= galaxy->config & GALAXY_CONFIG_MASK;
+	__galaxy_set_config(galaxy, config);
+}
+
+static int __devinit __galaxy_wss_config(struct snd_galaxy *galaxy,
+					 u8 wss_config)
+{
+	int err;
+
+	err = __wss_detect(galaxy->wss_port);
+	if (err < 0)
+		return err;
+
+	__wss_set_config(galaxy->wss_port, wss_config);
+
+	err = __galaxy_set_mode(galaxy, GALAXY_MODE_WSS);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static void snd_galaxy_free(struct snd_card *card)
+{
+	struct snd_galaxy *galaxy = card->private_data;
+
+	if (galaxy->wss_port) {
+		__wss_set_config(galaxy->wss_port, 0);
+		ioport_unmap(galaxy->wss_port);
+		release_and_free_resource(galaxy->res_wss_port);
+	}
+	if (galaxy->config_port) {
+		__galaxy_set_config(galaxy, galaxy->config);
+		ioport_unmap(galaxy->config_port);
+		release_and_free_resource(galaxy->res_config_port);
+	}
+	if (galaxy->port) {
+		ioport_unmap(galaxy->port);
+		release_and_free_resource(galaxy->res_port);
+	}
+}
+
+static int __devinit snd_galaxy_probe(struct device *dev, unsigned int n)
+{
+	struct snd_galaxy *galaxy;
+	struct snd_cs4231 *chip;
+	struct snd_card *card;
+	u8 type;
+	int err;
+
+	card = snd_card_new(index[n], id[n], THIS_MODULE, sizeof *galaxy);
+	if (!card)
+		return -EINVAL;
+
+	snd_card_set_dev(card, dev);
+
+	card->private_free = snd_galaxy_free;
+	galaxy = card->private_data;
+
+	galaxy->res_port = request_region(port[n], 16, DRV_NAME);
+	if (!galaxy->res_port) {
+		snd_printk(KERN_ERR "%s: could not grab ports %#lx-%#lx\n",
+			   dev->bus_id, port[n], port[n] + 15);
+		err = -EBUSY;
+		goto error;
+	}
+	galaxy->port = ioport_map(port[n], 16);
+
+	err = __galaxy_init(galaxy, &type);
+	if (err < 0) {
+		snd_printk(KERN_ERR "%s: no Sound Galaxy found at %#lx\n",
+			   dev->bus_id, port[n]);
+		goto error;
+	}
+	snd_printk(KERN_INFO "%s: Sound Galaxy (type %d) found at %#lx\n",
+		   dev->bus_id, type, port[n]);
+
+	galaxy->res_config_port = request_region(port[n] + GALAXY_PORT_CONFIG,
+						 16, DRV_NAME);
+	if (!galaxy->res_config_port) {
+		snd_printk(KERN_ERR "%s: could not grab ports %#lx-%#lx\n",
+			   dev->bus_id, port[n] + GALAXY_PORT_CONFIG,
+			   port[n] + GALAXY_PORT_CONFIG + 15);
+		err = -EBUSY;
+		goto error;
+	}
+	galaxy->config_port = ioport_map(port[n] + GALAXY_PORT_CONFIG, 16);
+
+	__galaxy_config(galaxy, config[n]);
+
+	galaxy->res_wss_port = request_region(wss_port[n], 4, DRV_NAME);
+	if (!galaxy->res_wss_port)  {
+		snd_printk(KERN_ERR "%s: could not grab ports %#lx-%#lx\n",
+			   dev->bus_id, wss_port[n], wss_port[n] + 3);
+		err = -EBUSY;
+		goto error;
+	}
+	galaxy->wss_port = ioport_map(wss_port[n], 4);
+
+	err = __galaxy_wss_config(galaxy, wss_config[n]);
+	if (err < 0) {
+		snd_printk(KERN_ERR "%s: could not configure WSS\n",
+			   dev->bus_id);
+		goto error;
+	}
+
+	strcpy(card->driver, DRV_NAME);
+	strcpy(card->shortname, DRV_NAME);
+	sprintf(card->longname, "%s at %#lx/%#lx, irq %d, dma %d/%d",
+		card->shortname, port[n], wss_port[n], irq[n], dma1[n],
+		dma2[n]);
+
+	err = snd_cs4231_create(card, wss_port[n] + 4, -1, irq[n], dma1[n],
+				dma2[n], CS4231_HW_DETECT, 0, &chip);
+	if (err < 0)
+		goto error;
+
+	err = snd_cs4231_pcm(chip, 0, NULL);
+	if (err < 0)
+		goto error;
+
+	err = snd_cs4231_mixer(chip);
+	if (err < 0)
+		goto error;
+
+	err = snd_cs4231_timer(chip, 0, NULL);
+	if (err < 0)
+		goto error;
+
+	if (mpu_port[n] >= 0) {
+		err = snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
+					  mpu_port[n], 0, mpu_irq[n],
+					  IRQF_DISABLED, NULL);
+		if (err < 0)
+			goto error;
+	}
+
+	if (fm_port[n] >= 0) {
+		struct snd_opl3 *opl3;
+
+		err = snd_opl3_create(card, fm_port[n], fm_port[n] + 2,
+				      OPL3_HW_AUTO, 0, &opl3);
+		if (err < 0) {
+                        snd_printk(KERN_ERR "%s: no OPL device at %#lx\n",
+                                   dev->bus_id, fm_port[n]);
+			goto error;
+		}
+		err = snd_opl3_timer_new(opl3, 1, 2);
+		if (err < 0)
+			goto error;
+
+		err = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
+		if (err < 0)
+			goto error;
+	}
+
+	err = snd_card_register(card);
+	if (err < 0)
+		goto error;
+
+	dev_set_drvdata(dev, card);
+	return 0;
+
+error:
+	snd_card_free(card);
+	return err;
+}
+
+static int __devexit snd_galaxy_remove(struct device *dev, unsigned int n)
+{
+	snd_card_free(dev_get_drvdata(dev));
+	dev_set_drvdata(dev, NULL);
+	return 0;
+}
+
+static struct isa_driver snd_galaxy_driver = {
+	.match		= snd_galaxy_match,
+	.probe		= snd_galaxy_probe,
+	.remove		= __devexit_p(snd_galaxy_remove),
+
+	.driver		= {
+		.name	= DEV_NAME
+	}
+};
+
+static int __init alsa_card_galaxy_init(void)
+{
+	return isa_register_driver(&snd_galaxy_driver, SNDRV_CARDS);
+}
+
+static void __exit alsa_card_galaxy_exit(void)
+{
+	isa_unregister_driver(&snd_galaxy_driver);
+}
+
+module_init(alsa_card_galaxy_init);
+module_exit(alsa_card_galaxy_exit);
diff -r 0687faf0e009 isa/galaxy/lib.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/isa/galaxy/lib.c	Thu Sep 20 14:15:22 2007 +0200
@@ -0,0 +1,118 @@
+/*
+ * Generic SB DSP / WSS support routines
+ * Copyright (C) 2007  Rene Herman
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <asm/processor.h>
+#include "lib.h"
+
+/*
+ * Generic SB DSP
+ */
+
+#define DSP_PORT_RESET		0x6
+#define DSP_PORT_READ		0xa
+#define DSP_PORT_COMMAND	0xc
+#define DSP_PORT_STATUS		0xc
+#define DSP_PORT_DATA_AVAIL	0xe
+
+#define DSP_SIGNATURE		0xaa
+
+#define DSP_COMMAND_GET_VERSION	0xe1
+
+int __devinit __dsp_get_byte(void __iomem *port, u8 *val)
+{
+	int loops = 1000;
+
+	while (!(ioread8(port + DSP_PORT_DATA_AVAIL) & 0x80)) {
+		if (!loops--)
+			return -EIO;
+		cpu_relax();
+	}
+	*val = ioread8(port + DSP_PORT_READ);
+	return 0;
+}
+
+int __devinit __dsp_reset(void __iomem *port)
+{
+	u8 val;
+
+	iowrite8(1, port + DSP_PORT_RESET);
+	udelay(10);
+	iowrite8(0, port + DSP_PORT_RESET);
+
+	if (__dsp_get_byte(port, &val) < 0 || val != DSP_SIGNATURE)
+		return -ENODEV;
+
+	return 0;
+}
+
+int __devinit __dsp_command(void __iomem *port, u8 cmd)
+{
+	int loops = 1000;
+
+	while (ioread8(port + DSP_PORT_STATUS) & 0x80) {
+		if (!loops--)
+			return -EIO;
+		cpu_relax();
+	}
+	iowrite8(cmd, port + DSP_PORT_COMMAND);
+	return 0;
+}
+
+int __devinit __dsp_get_version(void __iomem *port, u8 *major, u8 *minor)
+{
+	int err;
+
+	err = __dsp_command(port, DSP_COMMAND_GET_VERSION);
+	if (err < 0)
+		return err;
+
+	err = __dsp_get_byte(port, major);
+	if (err < 0)
+		return err;
+
+	err = __dsp_get_byte(port, minor);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+/*
+ * Generic WSS
+ */
+
+#define WSS_PORT_CONFIG		0
+#define WSS_PORT_SIGNATURE	3
+
+#define WSS_SIGNATURE		4
+
+int __devinit __wss_detect(void __iomem *wss_port)
+{
+	if ((ioread8(wss_port + WSS_PORT_SIGNATURE) & 0x3f) != WSS_SIGNATURE)
+		return -ENODEV;
+
+	return 0;
+}
+
+void __wss_set_config(void __iomem *wss_port, u8 wss_config)
+{
+	iowrite8(wss_config, wss_port + WSS_PORT_CONFIG);
+}
diff -r 0687faf0e009 isa/galaxy/lib.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/isa/galaxy/lib.h	Thu Sep 20 14:15:22 2007 +0200
@@ -0,0 +1,52 @@
+/*
+ * Generic SB DSP / WSS support routines
+ * Copyright (C) 2007  Rene Herman
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef __SOUND_ISA_GALAXY_LIB_H
+#define __SOUND_ISA_GALAXY_LIB_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+/*
+ * Generic SB DSP support routines
+ */
+int __dsp_get_byte(void __iomem *port, u8 *val);
+int __dsp_reset(void __iomem *port);
+int __dsp_command(void __iomem *port, u8 cmd);
+int __dsp_get_version(void __iomem *port, u8 *major, u8 *minor);
+
+/*
+ * WSS 8-bit configuration register
+ */
+#define WSS_CONFIG_DMA_0	(1 << 0)
+#define WSS_CONFIG_DMA_1	(2 << 0)
+#define WSS_CONFIG_DMA_3	(3 << 0)
+#define WSS_CONFIG_DUPLEX	(1 << 2)
+#define WSS_CONFIG_IRQ_7	(1 << 3)
+#define WSS_CONFIG_IRQ_9	(2 << 3)
+#define WSS_CONFIG_IRQ_10	(3 << 3)
+#define WSS_CONFIG_IRQ_11	(4 << 3)
+
+/*
+ * Generic WSS support routines
+ */
+int __wss_detect(void __iomem *wss_port);
+void __wss_set_config(void __iomem *wss_port, u8 wss_config);
+
+#endif /* __SOUND_ISA_GALAXY_LIB_H */

--------------040606060303080802020701
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040606060303080802020701--
