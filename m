From: Misha Jiline <mjiline@site.uottawa.ca>
Subject: Phase 22 patch
Date: Mon, 07 Feb 2005 22:03:35 -0500
Message-ID: <1107831815.6750.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-nPysWm6WnSetbYchJd5c"
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-nPysWm6WnSetbYchJd5c
Content-Type: multipart/alternative; boundary="=-yhZZmL3A8B2IuJKtkLQ8"


--=-yhZZmL3A8B2IuJKtkLQ8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


I've struggled for a couple of days with Terratec Phase 22 card. Chips
used on it are well known but the combination is somehow unique. Phase
88 should have been similar... but it actually uses 1712 instead of 1721
(Envy24HT-S). So here is the patch against release 1.0.8 that adds Phase
22 to ice1724. I've tested only analog part (balances 1/4 TRS in and
outs).

I hope maintainers will ok it to be included to the mainstream.

Cheers,
Misha

--=-yhZZmL3A8B2IuJKtkLQ8
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.10">
</HEAD>
<BODY>
<BR>
I've struggled for a couple of days with Terratec Phase 22 card. Chips used on it are well known but the combination is somehow unique. Phase 88 should have been similar... but it actually uses 1712 instead of 1721 (Envy24HT-S). So here is the patch against release 1.0.8 that adds Phase 22 to ice1724. I've tested only analog part (balances 1/4 TRS in and outs).<BR>
<BR>
I hope maintainers will ok it to be included to the mainstream.<BR>
<BR>
Cheers,<BR>
Misha
</BODY>
</HTML>

--=-yhZZmL3A8B2IuJKtkLQ8--

--=-nPysWm6WnSetbYchJd5c
Content-Disposition: attachment; filename=phase22.patch
Content-Type: text/x-patch; name=phase22.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur alsa-driver-1.0.8/alsa-kernel/pci/ice1712/ice1724.c alsa-driver-1.0.8.phase22/alsa-kernel/pci/ice1712/ice1724.c
--- alsa-driver-1.0.8/alsa-kernel/pci/ice1712/ice1724.c	2004-12-03 08:17:13.000000000 -0500
+++ alsa-driver-1.0.8.phase22/alsa-kernel/pci/ice1712/ice1724.c	2005-02-07 18:46:03.000000000 -0500
@@ -47,7 +47,7 @@
 #include "vt1720_mobo.h"
 #include "pontis.h"
 #include "prodigy192.h"
-
+#include "phase.h"
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("VIA ICEnsemble ICE1724/1720 (Envy24HT/PT)");
@@ -59,6 +59,7 @@
 	       VT1720_MOBO_DEVICE_DESC
 	       PONTIS_DEVICE_DESC
 	       PRODIGY192_DEVICE_DESC
+	       PHASE_DEVICE_DESC
 		"{VIA,VT1720},"
 		"{VIA,VT1724},"
 		"{ICEnsemble,Generic ICE1724},"
@@ -1866,6 +1867,7 @@
 	snd_vt1720_mobo_cards,
 	snd_vt1720_pontis_cards,
 	snd_vt1724_prodigy192_cards,
+	snd_vt1724_phase_cards,
 	NULL,
 };
 
diff -Naur alsa-driver-1.0.8/alsa-kernel/pci/ice1712/Makefile alsa-driver-1.0.8.phase22/alsa-kernel/pci/ice1712/Makefile
--- alsa-driver-1.0.8/alsa-kernel/pci/ice1712/Makefile	2004-09-07 11:02:49.000000000 -0400
+++ alsa-driver-1.0.8.phase22/alsa-kernel/pci/ice1712/Makefile	2005-02-07 17:36:52.000000000 -0500
@@ -5,7 +5,7 @@
 
 snd-ice17xx-ak4xxx-objs := ak4xxx.o
 snd-ice1712-objs := ice1712.o delta.o hoontech.o ews.o
-snd-ice1724-objs := ice1724.o amp.o revo.o aureon.o vt1720_mobo.o pontis.o prodigy192.o
+snd-ice1724-objs := ice1724.o amp.o revo.o aureon.o vt1720_mobo.o pontis.o prodigy192.o phase.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_ICE1712) += snd-ice1712.o snd-ice17xx-ak4xxx.o
diff -Naur alsa-driver-1.0.8/alsa-kernel/pci/ice1712/phase.c alsa-driver-1.0.8.phase22/alsa-kernel/pci/ice1712/phase.c
--- alsa-driver-1.0.8/alsa-kernel/pci/ice1712/phase.c	1969-12-31 19:00:00.000000000 -0500
+++ alsa-driver-1.0.8.phase22/alsa-kernel/pci/ice1712/phase.c	2005-02-07 21:24:49.000000000 -0500
@@ -0,0 +1,138 @@
+/*
+ *   ALSA driver for ICEnsemble ICE1724 (Envy24)
+ *
+ *   Lowlevel functions for Terratec PHASE 22
+ *
+ *	Copyright (c) 2003 Misha Zhilin <misha@epiphan.com>
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
+/* PHASE 22 overview:
+ *   Audio controller: VIA Envy24HT-S (slightly trimmed down version of Envy24HT)
+ *   Analog chip: AK4524 (partially via Philip's 74HCT125)
+ *   Digital receiver: CS8414-CS (not supported in this release)
+ *
+ *   Envy connects to AK4524
+ *	- CS directly from GPIO 10
+ *	- CCLK via 74HCT125's gate #4 from GPIO 4
+ *	- CDTI via 74HCT125's gate #2 from GPIO 5
+ *		CDTI may be completely blocked by 74HCT125's gate #1 controlled by GPIO 3
+ */
+
+#include <sound/driver.h>
+#include <asm/io.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+
+#include "ice1712.h"
+#include "envy24ht.h"
+#include "phase.h"
+
+static akm4xxx_t akm_phase22 __devinitdata = {
+	.type = SND_AK4524,
+	.num_dacs = 2,
+	.num_adcs = 2,
+};
+
+static struct snd_ak4xxx_private akm_phase22_priv __devinitdata = {
+	.caddr =	2,
+	.cif =		1,
+	.data_mask =	1 << 4,
+	.clk_mask =	1 << 5,
+	.cs_mask =	1 << 10,
+	.cs_addr =	1 << 10,
+	.cs_none =	0,
+	.add_flags = 	1 << 3,
+	.mask_flags =	0,
+};
+
+static int __devinit phase22_init(ice1712_t *ice)
+{
+	akm4xxx_t *ak;
+	int err;
+
+	// Configure DAC/ADC description for generic part of ice1724
+	switch (ice->eeprom.subvendor) {
+	case VT1724_SUBDEVICE_PHASE22:
+		ice->num_total_dacs = 2;
+		ice->num_total_adcs = 2;
+		ice->vt1720 = 1; // Envy24HT-S have 16 bit wide GPIO
+		break;
+	default:
+		snd_BUG();
+		return -EINVAL;
+	}
+
+	// Initialize analog chips
+	ak = ice->akm = kmalloc(sizeof(akm4xxx_t), GFP_KERNEL);
+	if (! ak)
+		return -ENOMEM;
+	ice->akm_codecs = 1;
+	switch (ice->eeprom.subvendor) {
+	case VT1724_SUBDEVICE_PHASE22:
+		if ((err = snd_ice1712_akm4xxx_init(ak, &akm_phase22, &akm_phase22_priv, ice)) < 0)
+			return err;
+		break;
+	}
+
+	return 0;
+}
+
+static int __devinit phase22_add_controls(ice1712_t *ice)
+{
+	int err = 0;
+
+	switch (ice->eeprom.subvendor) {
+	case VT1724_SUBDEVICE_PHASE22:
+		err = snd_ice1712_akm4xxx_build_controls(ice);
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
+static unsigned char phase22_eeprom[] __devinitdata = {
+	0x00,	/* SYSCONF: 1xADC, 1xDACs */
+	0x80,	/* ACLINK: I2S */
+	0xf8,	/* I2S: vol, 96k, 24bit*/
+	0xc3,	/* SPDIF: out-en, out-int, spdif-in */
+	0xFF,	/* GPIO_DIR */
+	0xFF,	/* GPIO_DIR1 */
+	0xFF,	/* GPIO_DIR2 */
+	0x00,	/* GPIO_MASK */
+	0x00,	/* GPIO_MASK1 */
+	0x00,	/* GPIO_MASK2 */
+	0x00,	/* GPIO_STATE: */
+	0x00,	/* GPIO_STATE1: */
+	0x00,	/* GPIO_STATE2 */
+};
+
+struct snd_ice1712_card_info snd_vt1724_phase_cards[] __devinitdata = {
+	{
+		.subvendor = VT1724_SUBDEVICE_PHASE22,
+		.name = "Terratec PHASE 22",
+		.model = "phase22",
+		.chip_init = phase22_init,
+		.build_controls = phase22_add_controls,
+		.eeprom_size = sizeof(phase22_eeprom),
+		.eeprom_data = phase22_eeprom,
+	},
+	{ } /* terminator */
+};
diff -Naur alsa-driver-1.0.8/alsa-kernel/pci/ice1712/phase.h alsa-driver-1.0.8.phase22/alsa-kernel/pci/ice1712/phase.h
--- alsa-driver-1.0.8/alsa-kernel/pci/ice1712/phase.h	1969-12-31 19:00:00.000000000 -0500
+++ alsa-driver-1.0.8.phase22/alsa-kernel/pci/ice1712/phase.h	2005-02-07 21:24:04.000000000 -0500
@@ -0,0 +1,34 @@
+#ifndef __SOUND_PHASE_H
+#define __SOUND_PHASE_H
+
+/*
+ *   ALSA driver for ICEnsemble ICE1712 (Envy24)
+ *
+ *   Lowlevel functions for Terratec PHASE 22
+ *
+ *	Copyright (c) 2003 Misha Zhilin <misha@epiphan.com>
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
+#define PHASE_DEVICE_DESC "{Terratec,Phase 22},"
+
+#define VT1724_SUBDEVICE_PHASE22	0x3b155011
+
+/* entry point */
+extern struct snd_ice1712_card_info snd_vt1724_phase_cards[];
+
+#endif /* __SOUND_PHASE */
diff -Naur alsa-driver-1.0.8/pci/ice1712/phase.c alsa-driver-1.0.8.phase22/pci/ice1712/phase.c
--- alsa-driver-1.0.8/pci/ice1712/phase.c	1969-12-31 19:00:00.000000000 -0500
+++ alsa-driver-1.0.8.phase22/pci/ice1712/phase.c	2005-02-07 18:50:10.000000000 -0500
@@ -0,0 +1,2 @@
+#define __NO_VERSION__
+#include "../../alsa-kernel/pci/ice1712/phase.c"

--=-nPysWm6WnSetbYchJd5c--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
