From: Misha Jiline <mjiline@site.uottawa.ca>
Subject: Re: Phase 22 patch
Date: Wed, 09 Feb 2005 00:05:03 -0500
Message-ID: <1107925503.6714.3.camel@localhost.localdomain>
References: <1107831815.6750.20.camel@localhost.localdomain>
	 <s5hk6piu6gv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-RpHv3Cbp2gKOUvSY4ZfZ"
In-Reply-To: <s5hk6piu6gv.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-RpHv3Cbp2gKOUvSY4ZfZ
Content-Type: multipart/alternative; boundary="=-OgRsO3lg+tRPxWRjg8+6"


--=-OgRsO3lg+tRPxWRjg8+6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Could you fix thte above and regenerate the patch against CVS version?
> The ice1712 code was slightly changed since 1.0.8 due to addition of
> Juli board support.
> 
> Also, please give "Signed-off-by" to add your credit in changelog
> (it's required for submitting to linux kernel).


Here you go...

Cheers,
Misha.

--=-OgRsO3lg+tRPxWRjg8+6
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.10">
</HEAD>
<BODY>
<BLOCKQUOTE TYPE=CITE>
<PRE><FONT COLOR="#737373"><I>Could you fix thte above and regenerate the patch against CVS version?
The ice1712 code was slightly changed since 1.0.8 due to addition of
Juli board support.

Also, please give &quot;Signed-off-by&quot; to add your credit in changelog
(it's required for submitting to linux kernel).</I></FONT></PRE>
</BLOCKQUOTE>
<BR>
Here you go...<BR>
<BR>
Cheers,<BR>
Misha.
</BODY>
</HTML>

--=-OgRsO3lg+tRPxWRjg8+6--

--=-RpHv3Cbp2gKOUvSY4ZfZ
Content-Disposition: attachment; filename=phase22.patch
Content-Type: text/x-patch; name=phase22.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Summary: Added support for Terratec PHASE 22
Signed-off-by: Misha Zhilin <misha@epiphan.com>

diff -Naur --exclude CVS alsa-driver/alsa-driver/pci/ice1712/phase.c alsa-driver.phase/alsa-driver/pci/ice1712/phase.c
--- alsa-driver/alsa-driver/pci/ice1712/phase.c	1969-12-31 19:00:00.000000000 -0500
+++ alsa-driver.phase/alsa-driver/pci/ice1712/phase.c	2005-02-08 22:43:57.000000000 -0500
@@ -0,0 +1,2 @@
+#define __NO_VERSION__
+#include "../../alsa-kernel/pci/ice1712/phase.c"
diff -Naur --exclude CVS alsa-driver/alsa-kernel/pci/ice1712/ice1724.c alsa-driver.phase/alsa-kernel/pci/ice1712/ice1724.c
--- alsa-driver/alsa-kernel/pci/ice1712/ice1724.c	2005-01-18 10:48:00.000000000 -0500
+++ alsa-driver.phase/alsa-kernel/pci/ice1712/ice1724.c	2005-02-08 22:25:23.000000000 -0500
@@ -48,6 +48,7 @@
 #include "pontis.h"
 #include "prodigy192.h"
 #include "juli.h"
+#include "phase.h"
 
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
@@ -61,6 +62,7 @@
 	       PONTIS_DEVICE_DESC
 	       PRODIGY192_DEVICE_DESC
 	       JULI_DEVICE_DESC
+	       PHASE_DEVICE_DESC
 		"{VIA,VT1720},"
 		"{VIA,VT1724},"
 		"{ICEnsemble,Generic ICE1724},"
@@ -1869,6 +1871,7 @@
 	snd_vt1720_pontis_cards,
 	snd_vt1724_prodigy192_cards,
 	snd_vt1724_juli_cards,
+	snd_vt1724_phase_cards,
 	NULL,
 };
 
diff -Naur --exclude CVS alsa-driver/alsa-kernel/pci/ice1712/Makefile alsa-driver.phase/alsa-kernel/pci/ice1712/Makefile
--- alsa-driver/alsa-kernel/pci/ice1712/Makefile	2005-01-18 10:48:00.000000000 -0500
+++ alsa-driver.phase/alsa-kernel/pci/ice1712/Makefile	2005-02-08 22:26:59.000000000 -0500
@@ -5,7 +5,7 @@
 
 snd-ice17xx-ak4xxx-objs := ak4xxx.o
 snd-ice1712-objs := ice1712.o delta.o hoontech.o ews.o
-snd-ice1724-objs := ice1724.o amp.o revo.o aureon.o vt1720_mobo.o pontis.o prodigy192.o juli.o
+snd-ice1724-objs := ice1724.o amp.o revo.o aureon.o vt1720_mobo.o pontis.o prodigy192.o juli.o phase.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_ICE1712) += snd-ice1712.o snd-ice17xx-ak4xxx.o
diff -Naur --exclude CVS alsa-driver/alsa-kernel/pci/ice1712/phase.c alsa-driver.phase/alsa-kernel/pci/ice1712/phase.c
--- alsa-driver/alsa-kernel/pci/ice1712/phase.c	1969-12-31 19:00:00.000000000 -0500
+++ alsa-driver.phase/alsa-kernel/pci/ice1712/phase.c	2005-02-08 22:26:38.000000000 -0500
@@ -0,0 +1,138 @@
+/*
+ *   ALSA driver for ICEnsemble ICE1724 (Envy24)
+ *
+ *   Lowlevel functions for Terratec PHASE 22
+ *
+ *	Copyright (c) 2005 Misha Zhilin <misha@epiphan.com>
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
+	ak = ice->akm = kcalloc(1, sizeof(akm4xxx_t), GFP_KERNEL);
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
diff -Naur --exclude CVS alsa-driver/alsa-kernel/pci/ice1712/phase.h alsa-driver.phase/alsa-kernel/pci/ice1712/phase.h
--- alsa-driver/alsa-kernel/pci/ice1712/phase.h	1969-12-31 19:00:00.000000000 -0500
+++ alsa-driver.phase/alsa-kernel/pci/ice1712/phase.h	2005-02-08 22:25:44.000000000 -0500
@@ -0,0 +1,34 @@
+#ifndef __SOUND_PHASE_H
+#define __SOUND_PHASE_H
+
+/*
+ *   ALSA driver for ICEnsemble ICE1712 (Envy24)
+ *
+ *   Lowlevel functions for Terratec PHASE 22
+ *
+ *	Copyright (c) 2005 Misha Zhilin <misha@epiphan.com>
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

--=-RpHv3Cbp2gKOUvSY4ZfZ--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
