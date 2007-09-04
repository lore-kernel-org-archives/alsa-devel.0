From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] Gallant SC-6000 driver (3rd version)
Date: Tue, 4 Sep 2007 21:11:22 +0200
Message-ID: <20070904211122.dfeed6d7.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.wp.pl (mx1.wp.pl [212.77.101.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D5B810396D
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Sep 2007 21:05:15 +0200 (CEST)
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <alsa-devel@alsa-project.org>; 4 Sep 2007 21:05:05 +0200
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
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This is port of the Gallant SC-6000 driver from the OSS aedsp16 driver.
This card was also sold as AudioExcel DSP 16 and Zoltrix AV302 (Audio Plus True 16).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

The two issues pointed by Takashi are fixed.

diff -urpN linux-2.6.22.old/sound/isa/Kconfig linux-2.6.22/sound/isa/Kconfig
--- linux-2.6.22.old/sound/isa/Kconfig	2007-08-28 23:14:08.000000000 +0200
+++ linux-2.6.22/sound/isa/Kconfig	2007-09-01 18:38:41.000000000 +0200
@@ -191,6 +191,19 @@ config SND_ES18XX
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-es18xx.
 
+config SND_SC6000
+	tristate "Gallant SC-6000, Audio Excel DSP 16"
+	depends on SND
+	select SND_AD1848_LIB
+	select SND_OPL3_LIB
+	select SND_MPU401_UART
+	help
+	  Say Y here to include support for Gallant SC-6000 card and clones:
+	  Audio Excel DSP 16 and Zoltrix AV302.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-sc6000.
+
 config SND_GUS_SYNTH
 	tristate
 
diff -urpN linux-2.6.22.old/sound/isa/Makefile linux-2.6.22/sound/isa/Makefile
--- linux-2.6.22.old/sound/isa/Makefile	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.22/sound/isa/Makefile	2007-09-03 22:09:58.000000000 +0200
@@ -10,6 +10,7 @@ snd-cmi8330-objs := cmi8330.o
 snd-dt019x-objs := dt019x.o
 snd-es18xx-objs := es18xx.o
 snd-opl3sa2-objs := opl3sa2.o
+snd-sc6000-objs := sc6000.o
 snd-sgalaxy-objs := sgalaxy.o
 snd-sscape-objs := sscape.o
 
@@ -21,6 +22,7 @@ obj-$(CONFIG_SND_CMI8330) += snd-cmi8330
 obj-$(CONFIG_SND_DT019X) += snd-dt019x.o
 obj-$(CONFIG_SND_ES18XX) += snd-es18xx.o
 obj-$(CONFIG_SND_OPL3SA2) += snd-opl3sa2.o
+obj-$(CONFIG_SND_SC6000) += snd-sc6000.o
 obj-$(CONFIG_SND_SGALAXY) += snd-sgalaxy.o
 obj-$(CONFIG_SND_SSCAPE) += snd-sscape.o
 
diff -urpN linux-2.6.22.old/sound/isa/sc6000.c linux-2.6.22/sound/isa/sc6000.c
--- linux-2.6.22.old/sound/isa/sc6000.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.22/sound/isa/sc6000.c	2007-09-04 19:25:04.000000000 +0200
@@ -0,0 +1,630 @@
+/*
+ *  Driver for Gallant SC-6000 soundcard. This card is also known as
+ *  Audio Excel DSP 16 or Zoltrix AV302.
+ *  These cards use CompuMedia ASC-9308 chip + AD1848 codec.
+ *
+ *  Copyright (C) 2007 Krzysztof Helt <krzysztof.h1@wp.pl>
+ *
+ *  I don't have documentation for this card. I used the driver
+ *  for OSS/Free included in the kernel source as reference.
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
+#include <linux/module.h>
+#include <linux/isa.h>
+#include <asm/dma.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/ad1848.h>
+#include <sound/opl3.h>
+#include <sound/mpu401.h>
+#include <sound/control.h>
+#define SNDRV_LEGACY_FIND_FREE_IRQ
+#define SNDRV_LEGACY_FIND_FREE_DMA
+#include <sound/initval.h>
+
+MODULE_AUTHOR("Krzysztof Helt");
+MODULE_DESCRIPTION("Gallant SC-6000");
+MODULE_LICENSE("GPL");
+MODULE_SUPPORTED_DEVICE("{{Gallant, SC-6000},"
+			"{AudioExcel, Audio Excel DSP 16},"
+			"{Zoltrix, AV302}}");
+
+static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
+static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;	/* Enable this card */
+static long port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* 0x220, 0x240 */
+static int irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* 5, 7, 9, 10, 11 */
+static long mss_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* 0x530, 0xe80 */
+static long mpu_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
+						/* 0x300, 0x310, 0x320, 0x330 */
+static int mpu_irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* 5, 7, 9, 10, 0 */
+static int dma[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* 0, 1, 3 */
+
+module_param_array(index, int, NULL, 0444);
+MODULE_PARM_DESC(index, "Index value for sc-6000 based soundcard.");
+module_param_array(id, charp, NULL, 0444);
+MODULE_PARM_DESC(id, "ID string for sc-6000 based soundcard.");
+module_param_array(enable, bool, NULL, 0444);
+MODULE_PARM_DESC(enable, "Enable sc-6000 based soundcard.");
+module_param_array(port, long, NULL, 0444);
+MODULE_PARM_DESC(port, "Port # for sc-6000 driver.");
+module_param_array(mss_port, long, NULL, 0444);
+MODULE_PARM_DESC(mss_port, "MSS Port # for sc-6000 driver.");
+module_param_array(mpu_port, long, NULL, 0444);
+MODULE_PARM_DESC(mpu_port, "MPU-401 port # for sc-6000 driver.");
+module_param_array(irq, int, NULL, 0444);
+MODULE_PARM_DESC(irq, "IRQ # for sc-6000 driver.");
+module_param_array(mpu_irq, int, NULL, 0444);
+MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for sc-6000 driver.");
+module_param_array(dma, int, NULL, 0444);
+MODULE_PARM_DESC(dma, "DMA # for sc-6000 driver.");
+
+/*
+ * Commands of SC6000's DSP (SBPRO+special).
+ * Some of them are COMMAND_xx, in the future they may change.
+ */
+#define WRITE_MDIRQ_CFG	0x50	/* Set M&I&DRQ mask (the real config)	*/
+#define COMMAND_52	0x52	/*					*/
+#define READ_HARD_CFG	0x58	/* Read Hardware Config (I/O base etc)	*/
+#define COMMAND_5C	0x5c	/*					*/
+#define COMMAND_60	0x60	/*					*/
+#define COMMAND_66	0x66	/*					*/
+#define COMMAND_6C	0x6c	/*					*/
+#define COMMAND_6E	0x6e	/*					*/
+#define COMMAND_88	0x88	/* Unknown command 			*/
+#define DSP_INIT_MSS	0x8c	/* Enable Microsoft Sound System mode	*/
+#define COMMAND_C5	0xc5	/*					*/
+#define GET_DSP_VERSION	0xe1	/* Get DSP Version			*/
+#define GET_DSP_COPYRIGHT 0xe3	/* Get DSP Copyright			*/
+
+/*
+ * Offsets of SC6000 DSP I/O ports. The offset is added to base I/O port
+ * to have the actual I/O port.
+ * Register permissions are:
+ * (wo) == Write Only
+ * (ro) == Read  Only
+ * (w-) == Write
+ * (r-) == Read
+ */
+#define DSP_RESET	0x06	/* offset of DSP RESET		(wo) */
+#define DSP_READ	0x0a	/* offset of DSP READ		(ro) */
+#define DSP_WRITE	0x0c	/* offset of DSP WRITE		(w-) */
+#define DSP_COMMAND	0x0c	/* offset of DSP COMMAND	(w-) */
+#define DSP_STATUS	0x0c	/* offset of DSP STATUS		(r-) */
+#define DSP_DATAVAIL	0x0e	/* offset of DSP DATA AVAILABLE	(ro) */
+
+#define PFX "sc6000: "
+
+/* hardware dependent functions */
+
+/*
+ * sc6000_irq_to_softcfg - Decode irq number into cfg code.
+ */
+static inline unsigned char sc6000_irq_to_softcfg(int irq)
+{
+	unsigned char val = 0;
+
+	switch (irq) {
+	case 5:
+		val = 0x28;
+		break;
+	case 7:
+		val = 0x8;
+		break;
+	case 9:
+		val = 0x10;
+		break;
+	case 10:
+		val = 0x18;
+		break;
+	case 11:
+		val = 0x20;
+		break;
+	default:
+		break;
+	}
+	return val;
+}
+
+/*
+ * sc6000_dma_to_softcfg - Decode dma number into cfg code.
+ */
+static inline unsigned char sc6000_dma_to_softcfg(int dma)
+{
+	unsigned char val = 0;
+
+	switch (dma) {
+	case 0:
+		val = 1;
+		break;
+	case 1:
+		val = 2;
+		break;
+	case 3:
+		val = 3;
+		break;
+	default:
+		break;
+	}
+	return val;
+}
+
+/*
+ * sc6000_mpu_irq_to_softcfg - Decode MPU-401 irq number into cfg code.
+ */
+static inline unsigned char sc6000_mpu_irq_to_softcfg(int mpu_irq)
+{
+	unsigned char val = 0;
+
+	switch (mpu_irq) {
+	case 5:
+		val = 4;
+		break;
+	case 7:
+		val = 0x44;
+		break;
+	case 9:
+		val = 0x84;
+		break;
+	case 10:
+		val = 0xc4;
+		break;
+	default:
+		break;
+	}
+	return val;
+}
+
+static __devinit int sc6000_wait_data(int port)
+{
+	int loop = 1000;
+	unsigned char val = 0;
+
+	do {
+		val = inb(port + DSP_DATAVAIL);
+		if (val & 0x80)
+			return 0;
+		cpu_relax();
+	} while (loop--);
+
+	return -EAGAIN;
+}
+
+static inline int sc6000_read(int port)
+{
+	if (sc6000_wait_data(port))
+		return -EBUSY;
+
+	return inb(port + DSP_READ);
+
+}
+
+static __devinit int sc6000_write(int port, int cmd)
+{
+	unsigned char val;
+	int loop = 500000;
+
+	do {
+		val = inb(port + DSP_STATUS);
+		/*
+		 * DSP ready to receive data if bit 7 of val == 0
+		 */
+		if (!(val & 0x80)) {
+			outb(cmd, port + DSP_COMMAND);
+			return 0;
+		}
+		cpu_relax();
+	} while (loop--);
+
+	snd_printk(KERN_ERR "DSP Command (0x%x) timeout.\n", cmd);
+
+	return -EAGAIN;
+}
+
+static int __devinit sc6000_dsp_get_answer(int port, int command, char *data,
+					    int data_len)
+{
+	int len = 0;
+
+	if (sc6000_write(port, command)) {
+		snd_printk(KERN_ERR "CMD 0x%x: failed!\n", command);
+		return -EFAULT;
+	}
+
+	do {
+		int val = sc6000_read(port);
+
+		if (val < 0)
+			break;
+
+		data[len++] = val;
+
+	} while (len < data_len);
+
+	/*
+	 * If no more data available, return to the caller, no error if len>0.
+	 * We have no other way to know when the string is finished.
+	 */
+	return len ? len : -EIO;
+}
+
+static int __devinit sc6000_dsp_reset(int port)
+{
+	outb(1, port + DSP_RESET);
+	udelay(10);
+	outb(0, port + DSP_RESET);
+	udelay(20);
+	if (sc6000_read(port) == 0xaa)
+		return 0;
+	return -EBUSY;
+}
+
+/* detection and initialization */
+static int __devinit sc6000_cfg_write(int port, unsigned char softcfg)
+{
+
+	if (sc6000_write(port, WRITE_MDIRQ_CFG)) {
+		snd_printk(KERN_ERR "CMD 0x%x: failed!\n", WRITE_MDIRQ_CFG);
+		return -EIO;
+	}
+	if (sc6000_write(port, softcfg)) {
+		snd_printk(KERN_ERR "sc6000_cfg_write: failed!\n");
+		return -EIO;
+	}
+	return 0;
+}
+
+static int __devinit sc6000_setup_board(int port, int config)
+{
+	int loop = 10;
+
+	do {
+		if (sc6000_write(port, COMMAND_88)) {
+			snd_printk(KERN_ERR "CMD 0x%x: failed!\n",
+				   COMMAND_88);
+			return -EIO;
+		}
+	} while ((sc6000_wait_data(port) < 0) && loop--);
+
+	if (sc6000_read(port) < 0) {
+		snd_printk(KERN_ERR "sc6000_read after CMD 0x%x: failed\n",
+			   COMMAND_88);
+		return -EIO;
+	}
+
+	if (sc6000_cfg_write(port, config))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int __devinit sc6000_init_mss(int port, int config, int mss_port,
+				     int mss_config)
+{
+	if (sc6000_write(port, DSP_INIT_MSS)) {
+		snd_printk(KERN_ERR "sc6000_init_mss [0x%x]: failed!\n",
+			   DSP_INIT_MSS);
+		return -EIO;
+	}
+
+	msleep(10);
+
+	if (sc6000_cfg_write(port, config))
+		return -EIO;
+
+	outb(mss_config, mss_port);
+
+	return 0;
+}
+
+static int __devinit sc6000_init_board(int port, int irq, int dma,
+					int mss_port, int mpu_irq)
+{
+	char answer[15];
+	char version[2];
+	int mss_config = sc6000_irq_to_softcfg(irq) |
+			 sc6000_dma_to_softcfg(dma);
+	int config = mss_config |
+		     sc6000_mpu_irq_to_softcfg(mpu_irq);
+
+	if (sc6000_dsp_reset(port)) {
+		snd_printk(KERN_ERR "sc6000_dsp_reset: failed!\n");
+		return -EBUSY;
+	}
+
+	if (sc6000_dsp_get_answer(port, GET_DSP_COPYRIGHT, answer, 15) <= 0) {
+		snd_printk(KERN_ERR "sc6000_dsp_copyright: failed!\n");
+		return -ENODEV;
+	}
+	/*
+	 * My SC-6000 card return "SC-6000" in DSPCopyright, so
+	 * if we have something different, we have to be warned.
+	 * Mine returns SC-6000A - KH
+	 */
+	if (strncmp("SC-6000", answer, 7))
+		snd_printk(KERN_WARNING "Warning: non SC-6000 audio card!\n");
+
+	if (sc6000_dsp_get_answer(port, GET_DSP_VERSION, version, 2) < 2) {
+		snd_printk(KERN_ERR "sc6000_dsp_version: failed!\n");
+		return -ENODEV;
+	}
+	printk(KERN_INFO PFX "Detected model: %s version %d.%d\n",
+		answer, version[1], version[0]);
+
+	/*
+	 * 0x0A == (IRQ 7, DMA 1, MIRQ 0)
+	 */
+	if (sc6000_cfg_write(port, 0x0a)) {
+		snd_printk(KERN_ERR "sc6000_cfg_write: failed!\n");
+		return -EFAULT;
+	}
+
+	if (sc6000_setup_board(port, config) < 0) {
+		snd_printk(KERN_ERR "sc6000_setup_board: failed!\n");
+		return -ENODEV;
+	}
+
+	if (sc6000_init_mss(port, config, mss_port,
+			    mss_config) < 0) {
+		snd_printk(KERN_ERR "Can not initialize"
+			   "Microsoft Sound System mode.\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int __devinit snd_sc6000_detect(int dev, int irq, int dma)
+{
+	int err = -ENODEV;
+
+	snd_printd("Initializing BASE[0x%lx] IRQ[%d] DMA[%d] MIRQ[%d]\n",
+		   port[dev], irq, dma,
+		   mpu_irq[dev] == SND_AUTO_IRQ ? 0 : mpu_irq[dev]);
+
+/*
+ * We must request the port region because these are the I/O
+ * ports to access card's control registers.
+ */
+	if (!request_region(port[dev], 0x10, "sc-6000 (base)")) {
+		snd_printk(KERN_ERR
+			   "SC-6000 port I/O port region is already in use.\n");
+		return -EBUSY;
+	}
+
+	err = sc6000_init_board(port[dev], irq, dma,
+				mss_port[dev], mpu_irq[dev]);
+
+	release_region(port[dev], 0x10);
+
+	return err;
+}
+
+static int __devinit snd_sc6000_mixer(struct snd_ad1848 *chip)
+{
+	struct snd_card *card = chip->card;
+	struct snd_ctl_elem_id id1, id2;
+	int err;
+
+	memset(&id1, 0, sizeof(id1));
+	memset(&id2, 0, sizeof(id2));
+	id1.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	id2.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	/* reassign AUX0 to FM */
+	strcpy(id1.name, "Aux Playback Switch");
+	strcpy(id2.name, "FM Playback Switch");
+	err = snd_ctl_rename_id(card, &id1, &id2);
+	if (err < 0)
+		return err;
+	strcpy(id1.name, "Aux Playback Volume");
+	strcpy(id2.name, "FM Playback Volume");
+	err = snd_ctl_rename_id(card, &id1, &id2);
+	if (err < 0)
+		return err;
+	/* reassign AUX1 to CD */
+	strcpy(id1.name, "Aux Playback Switch"); id1.index = 1;
+	strcpy(id2.name, "CD Playback Switch");
+	err = snd_ctl_rename_id(card, &id1, &id2);
+	if (err < 0)
+		return err;
+	strcpy(id1.name, "Aux Playback Volume");
+	strcpy(id2.name, "CD Playback Volume");
+	err = snd_ctl_rename_id(card, &id1, &id2);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
+static int __devinit snd_sc6000_match(struct device *devptr, unsigned int dev)
+{
+	if (!enable[dev])
+		return 0;
+	if (port[dev] == SNDRV_AUTO_PORT) {
+		printk(KERN_ERR PFX "specify IO port\n");
+		return 0;
+	}
+	if (mss_port[dev] == SNDRV_AUTO_PORT) {
+		printk(KERN_ERR PFX "specify MSS port\n");
+		return 0;
+	}
+	if (port[dev] != 0x220 && port[dev] != 0x240) {
+		printk(KERN_ERR PFX "Port must be 0x220 or 0x240\n");
+		return 0;
+	}
+	if (mss_port[dev] != 0x530 && mss_port[dev] != 0xe80) {
+		printk(KERN_ERR PFX "MSS port must be 0x530 or 0xe80\n");
+		return 0;
+	}
+	if (irq[dev] != SNDRV_AUTO_IRQ && !sc6000_irq_to_softcfg(irq[dev])) {
+		printk(KERN_ERR PFX "invalid IRQ %d\n", irq[dev]);
+		return 0;
+	}
+	if (dma[dev] != SNDRV_AUTO_DMA && !sc6000_dma_to_softcfg(dma[dev])) {
+		printk(KERN_ERR PFX "invalid DMA %d\n", dma[dev]);
+		return 0;
+	}
+	if (mpu_port[dev] != SNDRV_AUTO_PORT &&
+	    (mpu_port[dev] & ~0x30l) != 0x300) {
+		printk(KERN_ERR PFX "invalid MPU-401 port %lx\n",
+			mpu_port[dev]);
+		return 0;
+	}
+	if (mpu_port[dev] != SNDRV_AUTO_PORT &&
+	    mpu_irq[dev] != SNDRV_AUTO_IRQ && mpu_irq[dev] != 0 &&
+	    !sc6000_mpu_irq_to_softcfg(mpu_irq[dev])) {
+		printk(KERN_ERR PFX "invalid MPU-401 IRQ %d\n", mpu_irq[dev]);
+		return 0;
+	}
+	return 1;
+}
+
+static int __devinit snd_sc6000_probe(struct device *devptr, unsigned int dev)
+{
+	static int possible_irqs[] = { 7, 9, 10, 11, -1 };
+	static int possible_dmas[] = { 1, 3, 0, -1 };
+	int err;
+	int xirq = irq[dev];
+	int xdma = dma[dev];
+	struct snd_card *card;
+	struct snd_ad1848 *chip;
+	struct snd_opl3 *opl3;
+
+	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
+	if (!card)
+		return -ENOMEM;
+
+	if (xirq == SNDRV_AUTO_IRQ) {
+		xirq = snd_legacy_find_free_irq(possible_irqs);
+		if (xirq < 0) {
+			snd_printk(KERN_ERR "unable to find a free IRQ\n");
+			err = -EBUSY;
+			goto _err;
+		}
+	}
+
+	if (xdma == SNDRV_AUTO_DMA) {
+		xdma = snd_legacy_find_free_dma(possible_dmas);
+		if (xdma < 0) {
+			snd_printk(KERN_ERR "unable to find a free DMA\n");
+			err = -EBUSY;
+			goto _err;
+		}
+	}
+
+	err = snd_sc6000_detect(dev, xirq, xdma);
+	if (err < 0)
+		goto _err;
+
+	err = snd_ad1848_create(card, mss_port[dev] + 4, xirq, xdma,
+				AD1848_HW_DETECT, &chip);
+	if (err < 0)
+		goto _err;
+	card->private_data = chip;
+
+	err = snd_ad1848_pcm(chip, 0, NULL);
+	if (err < 0) {
+		snd_printk(KERN_ERR
+			   "error creating new ad1848 PCM device\n");
+		goto _err;
+	}
+	err = snd_ad1848_mixer(chip);
+	if (err < 0) {
+		snd_printk(KERN_ERR "error creating new ad1848 mixer\n");
+		goto _err;
+	}
+	err = snd_sc6000_mixer(chip);
+	if (err < 0) {
+		snd_printk(KERN_ERR "the mixer rewrite failed\n");
+		goto _err;
+	}
+	if (snd_opl3_create(card,
+			    0x388, 0x388 + 2,
+			    OPL3_HW_AUTO, 0, &opl3) < 0) {
+		snd_printk(KERN_ERR "no OPL device at 0x%x-0x%x ?\n",
+			   0x388, 0x388 + 2);
+	} else {
+		err = snd_opl3_timer_new(opl3, 0, 1);
+		if (err < 0)
+			goto _err;
+
+		err = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
+		if (err < 0)
+			goto _err;
+	}
+
+	if (mpu_port[dev] != SNDRV_AUTO_PORT) {
+		if (mpu_irq[dev] == SNDRV_AUTO_IRQ)
+			mpu_irq[dev] = -1;
+		if (snd_mpu401_uart_new(card, 0,
+					MPU401_HW_MPU401,
+					mpu_port[dev], 0,
+					mpu_irq[dev],
+					mpu_irq[dev] >= 0 ? IRQF_DISABLED : 0,
+					NULL) < 0)
+			snd_printk(KERN_ERR "no MPU-401 device at 0x%lx ?\n",
+					mpu_port[dev]);
+	}
+
+	strcpy(card->driver, "Gallant SC-6000");
+	strcpy(card->shortname, "Gallant SC-6000");
+	sprintf(card->longname, "Gallant SC-6000 at 0x%lx, irq %d, dma %d",
+		mss_port[dev], xirq, xdma);
+
+	snd_card_set_dev(card, devptr);
+
+	err = snd_card_register(card);
+	if (err < 0)
+		goto _err;
+
+	dev_set_drvdata(devptr, card);
+	return 0;
+
+ _err:
+	snd_card_free(card);
+	return err;
+}
+
+static int __devexit snd_sc6000_remove(struct device *devptr, unsigned int dev)
+{
+	snd_card_free(dev_get_drvdata(devptr));
+	dev_set_drvdata(devptr, NULL);
+	return 0;
+}
+
+static struct isa_driver snd_sc6000_driver = {
+	.match		= snd_sc6000_match,
+	.probe		= snd_sc6000_probe,
+	.remove		= __devexit_p(snd_sc6000_remove),
+	/* FIXME: suspend/resume */
+	.driver		= {
+		.name	= "sc6000",
+	},
+};
+
+
+static int __init alsa_card_sc6000_init(void)
+{
+	return isa_register_driver(&snd_sc6000_driver, SNDRV_CARDS);
+}
+
+static void __exit alsa_card_sc6000_exit(void)
+{
+	isa_unregister_driver(&snd_sc6000_driver);
+}
+
+module_init(alsa_card_sc6000_init)
+module_exit(alsa_card_sc6000_exit)
