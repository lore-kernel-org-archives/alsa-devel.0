From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] MPU-401 ACPI PnP driver
Date: Tue, 02 Mar 2004 16:35:26 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403021626340.25852-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


I'm just too lazy to put port and irq parameters in my modules.conf,
so instead I wrote this driver which gets the resources from the ACPI
PnP information.

This probably should be integrated into the real MPU-401 driver after
testing.


Index: alsa-driver/INSTALL
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/INSTALL,v
retrieving revision 1.159
diff -u -r1.159 INSTALL
--- alsa-driver/INSTALL	24 Feb 2004 15:23:09 -0000	1.159
+++ alsa-driver/INSTALL	2 Mar 2004 14:55:33 -0000
@@ -273,6 +273,14 @@
     This module supports up to 8 cards and autoprobe.


+  Module snd-mpu401-acpi
+  ----------------------
+
+    Module for MPU-401 devices on ACPI-enabled motherboards.
+
+    This module supports up to 8 devices and autoprobe.
+
+
 Trouble Shooting
 ================

Index: alsa-driver/Makefile.conf.in
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/Makefile.conf.in,v
retrieving revision 1.60
diff -u -r1.60 Makefile.conf.in
--- alsa-driver/Makefile.conf.in	30 Jan 2004 11:44:58 -0000	1.60
+++ alsa-driver/Makefile.conf.in	2 Mar 2004 14:55:33 -0000
@@ -77,6 +77,7 @@
 CONFIG_USB		= @CONFIG_USB@
 CONFIG_SND_BIT32_EMUL	= @CONFIG_SND_BIT32_EMUL@
 CONFIG_VIDEO_DEV	= @CONFIG_VIDEO_DEV@
+CONFIG_ACPI_BUS		= @CONFIG_ACPI_BUS@

 ifndef NEW_KBUILD
 INCLUDE		= -I$(TOPDIR)/include @EXTRA_INCLUDES@ @KERNEL_INC@
Index: alsa-driver/configure.in
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/configure.in,v
retrieving revision 1.231
diff -u -r1.231 configure.in
--- alsa-driver/configure.in	1 Mar 2004 08:49:00 -0000	1.231
+++ alsa-driver/configure.in	2 Mar 2004 14:55:34 -0000
@@ -490,6 +490,10 @@
 CHECK_KERNEL_CONFIG(CONFIG_PCI, [PCI support in kernel])
 AC_SUBST(CONFIG_PCI)

+dnl Check for ACPI bus driver...
+CHECK_KERNEL_CONFIG(CONFIG_ACPI_BUS, [ACPI bus driver])
+AC_SUBST(CONFIG_ACPI_BUS)
+
 dnl Check for SGI/MIPS (HAL2) support...
 AC_MSG_CHECKING(for SGI/MIPS (HAL2) architecture)
 CONFIG_SGI=""
Index: alsa-driver/acore/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/acore/Makefile,v
retrieving revision 1.41
diff -u -r1.41 Makefile
--- alsa-driver/acore/Makefile	24 Feb 2004 15:23:09 -0000	1.41
+++ alsa-driver/acore/Makefile	2 Mar 2004 14:55:34 -0000
@@ -17,6 +17,7 @@
 obj-$(CONFIG_SND_INTEL8X0M) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
 obj-$(CONFIG_SND_HDSPM) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o snd-rawmidi.o snd-hwdep.o
 obj-$(CONFIG_SND_ATIIXP) += snd-pcm.o snd-timer.o snd-page-alloc.o snd.o
+obj-$(CONFIG_SND_MPU401_ACPI) += snd-rawmidi.o snd.o snd-timer.o

 export-objs := sound.o pcm.o pcm_lib.o rawmidi.o timer.o hwdep.o memalloc.o
 include $(SND_TOPDIR)/alsa-kernel/core/Makefile
Index: alsa-driver/acore/seq/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/acore/seq/Makefile,v
retrieving revision 1.15
diff -u -r1.15 Makefile
--- alsa-driver/acore/seq/Makefile	3 Feb 2004 15:21:27 -0000	1.15
+++ alsa-driver/acore/seq/Makefile	2 Mar 2004 14:55:34 -0000
@@ -13,6 +13,7 @@
 obj-$(CONFIG_SND_AU8820) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o
 obj-$(CONFIG_SND_AU8830) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o
 obj-$(CONFIG_SND_USB_USX2Y) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o
+obj-$(CONFIG_SND_MPU401_ACPI) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o

 export-objs  := seq_device.o seq.o seq_instr.o seq_midi_emul.o \
 		seq_midi_event.o seq_virmidi.o
Index: alsa-driver/drivers/mpu401/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/drivers/mpu401/Makefile,v
retrieving revision 1.10
diff -u -r1.10 Makefile
--- alsa-driver/drivers/mpu401/Makefile	11 Nov 2003 13:12:17 -0000	1.10
+++ alsa-driver/drivers/mpu401/Makefile	2 Mar 2004 14:55:34 -0000
@@ -5,9 +5,14 @@
 include $(SND_TOPDIR)/toplevel.config
 include $(SND_TOPDIR)/Makefile.conf

+snd-mpu401-acpi-objs := mpu401_acpi.o
+
 obj-$(CONFIG_SND_AU8810) += snd-mpu401-uart.o
 obj-$(CONFIG_SND_AU8820) += snd-mpu401-uart.o
 obj-$(CONFIG_SND_AU8830) += snd-mpu401-uart.o
+ifeq (y,$(CONFIG_ACPI_BUS))
+  obj-$(CONFIG_SND_MPU401_ACPI) += snd-mpu401-acpi.o snd-mpu401-uart.o
+endif

 export-objs  := mpu401_uart.o

Index: alsa-driver/utils/Modules.dep
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/utils/Modules.dep,v
retrieving revision 1.32
diff -u -r1.32 Modules.dep
--- alsa-driver/utils/Modules.dep	24 Feb 2004 15:23:10 -0000	1.32
+++ alsa-driver/utils/Modules.dep	2 Mar 2004 14:55:34 -0000
@@ -4,6 +4,7 @@

 %dir linux/sound/drivers
 |snd-serialmidi snd-seq-midi
+|snd-mpu401-acpi snd-mpu401-uart

 %dir linux/sound/pci
 |snd-intel8x0m snd-pcm
diff -urN alsa-driver/drivers/mpu401/mpu401_acpi.c alsa-driver/drivers/mpu401/mpu401_acpi.c
--- alsa-driver/drivers/mpu401/mpu401_acpi.c	1970-01-01 01:00:00.000000000 +0100
+++ alsa-driver/drivers/mpu401/mpu401_acpi.c	2004-03-02 15:51:41.606447000 +0100
@@ -0,0 +1,195 @@
+/*
+ * mpu401_acpi.c - driver for motherboard MPU-401 ports identified by ACPI PnP
+ * Copyright (c) 2004 Clemens Ladisch <clemens@ladisch.de>
+ *
+ * based on 8250_acpi.c
+ * Copyright (c) 2002-2003 Matthew Wilcox for Hewlett-Packard
+ * Copyright (C) 2004 Hewlett-Packard Co
+ *      Bjorn Helgaas <bjorn.helgaas@hp.com>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <sound/driver.h>
+#include <linux/init.h>
+#include <acpi/acpi_bus.h>
+#include <sound/core.h>
+#include <sound/mpu401.h>
+#define SNDRV_GET_ID
+#include <sound/initval.h>
+
+MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
+MODULE_DESCRIPTION("MPU-401 UART (ACPI)");
+MODULE_LICENSE("GPL");
+MODULE_CLASSES("{sound}");
+
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX; /* Index 0-MAX */
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR; /* ID for this card */
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP; /* Enable this card */
+
+MODULE_PARM(index, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(index, "Index value for MPU-401 device.");
+MODULE_PARM_SYNTAX(index, SNDRV_INDEX_DESC);
+MODULE_PARM(id, "1-" __MODULE_STRING(SNDRV_CARDS) "s");
+MODULE_PARM_DESC(id, "ID string for MPU-401 device.");
+MODULE_PARM_SYNTAX(id, SNDRV_ID_DESC);
+MODULE_PARM(enable, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
+MODULE_PARM_DESC(enable, "Enable MPU-401 device.");
+MODULE_PARM_SYNTAX(enable, SNDRV_ENABLE_DESC);
+
+#define MPU401_PNP_ID "PNPB006"
+
+struct mpu401_resources {
+	unsigned long port;
+	int irq;
+};
+
+static acpi_status __devinit snd_mpu401_acpi_resource(struct acpi_resource *res, void *data)
+{
+	struct mpu401_resources *resources = (struct mpu401_resources *)data;
+
+	if (res->id == ACPI_RSTYPE_IRQ) {
+		if (res->data.irq.number_of_interrupts > 0) {
+#ifdef CONFIG_IA64
+			resources->irq = acpi_register_irq(res->data.irq.interrupts[0],
+							   res->data.irq.active_high_low,
+							   res->data.irq.edge_level);
+#else
+			resources->irq = res->data.irq.interrupts[0];
+#endif
+		}
+	} else if (res->id == ACPI_RSTYPE_IO) {
+		if (res->data.io.range_length >= 2) {
+			resources->port = res->data.io.min_base_address;
+		}
+	}
+	return AE_OK;
+}
+
+static int __devinit snd_mpu401_acpi_add(struct acpi_device *device)
+{
+	static int dev;
+	snd_card_t *card;
+	struct mpu401_resources resources;
+	acpi_status status;
+	int err;
+
+	if (dev >= SNDRV_CARDS)
+		return -ENODEV;
+	if (!enable[dev]) {
+		++dev;
+		return -ENOENT;
+	}
+
+	resources.port = -1;
+	resources.irq = -1;
+	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
+				     snd_mpu401_acpi_resource, &resources);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+	if (resources.port < 0 || resources.irq < 0) {
+		snd_printk(KERN_ERR "no port or irq in %s _CRS\n",
+			   acpi_device_bid(device));
+		return -ENODEV;
+	}
+
+	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
+	if (!card)
+		return -ENOMEM;
+
+	strcpy(card->driver, "MPU-401 (ACPI)");
+	strcpy(card->shortname, "MPU-401 UART");
+	snprintf(card->longname, sizeof(card->longname),
+		 "%s at %#lx, irq %d, bus id %s", card->shortname,
+		 resources.port, resources.irq, acpi_device_bid(device));
+
+	err = snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401, resources.port,
+				  0, resources.irq, SA_INTERRUPT, NULL);
+	if (err < 0) {
+		printk(KERN_ERR "MPU401 not detected at %#lx\n", resources.port);
+		snd_card_free(card);
+		return err;
+	}
+
+	if ((err = snd_card_register(card)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+	acpi_driver_data(device) = card;
+	++dev;
+	return 0;
+}
+
+static int __devexit snd_mpu401_acpi_remove(struct acpi_device *device, int type)
+{
+	snd_card_t *card;
+
+	if (!device || !acpi_driver_data(device))
+		return -EINVAL;
+
+	card = (snd_card_t *)acpi_driver_data(device);
+	snd_card_free(card);
+	acpi_driver_data(device) = NULL;
+	return 0;
+}
+
+static struct acpi_driver snd_mpu401_acpi_driver = {
+	.name = "snd-mpu401-acpi",
+	.class = "",
+	.ids = MPU401_PNP_ID,
+	.ops = {
+		.add = snd_mpu401_acpi_add,
+		.remove = __devexit_p(snd_mpu401_acpi_remove),
+	},
+};
+
+static int __init alsa_card_mpu401_acpi_init(void)
+{
+	int err;
+	err = acpi_bus_register_driver(&snd_mpu401_acpi_driver);
+	return err < 0 ? err : 0;
+}
+
+static void __exit alsa_card_mpu401_acpi_exit(void)
+{
+	acpi_bus_unregister_driver(&snd_mpu401_acpi_driver);
+}
+
+module_init(alsa_card_mpu401_acpi_init)
+module_exit(alsa_card_mpu401_acpi_exit)
+
+#ifndef MODULE
+
+/* format is: snd-mpu401-acpi=enable,index,id */
+
+static int __init alsa_card_mpu401_setup(char *str)
+{
+	static unsigned __initdata nr_dev = 0;
+
+	if (nr_dev >= SNDRV_CARDS)
+		return 0;
+	(void)(get_option(&str, &enable[nr_dev]) == 2 &&
+	       get_option(&str, &index[nr_dev]) == 2 &&
+	       get_id(&str, &id[nr_dev]) == 2);
+	nr_dev++;
+	return 1;
+}
+
+__setup("snd-mpu401-acpi=", alsa_card_mpu401_setup);
+
+#endif /* ifndef MODULE */
+
+EXPORT_NO_SYMBOLS;




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
