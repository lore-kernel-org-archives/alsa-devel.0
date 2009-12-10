From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] dt019x: merge into the als100 driver
Date: Thu, 10 Dec 2009 20:39:28 +0100
Message-ID: <20091210203928.0e8f58a9.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 024B5103820
	for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2009 20:37:42 +0100 (CET)
Received: from poczta.interia.pl (mi03.poczta.interia.pl [10.217.12.3])
	by smtp240.poczta.interia.pl (INTERIA.PL) with ESMTP id 50FDC1EF2FC
	for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2009 20:37:37 +0100 (CET)
Received: from krzysio.net (93-181-133-4.as.kn.pl [93.181.133.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id B8ECF3E3835
	for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2009 20:37:35 +0100 (CET)
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

The als100 driver is so similar to the dt019x/als007 driver
that one driver's source can be used for both drivers with
only few changes. Merge the dt019x driver into the als100.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/Kconfig  |   21 +---
 sound/isa/Makefile |    2 -
 sound/isa/als100.c |  121 ++++++++++++++------
 sound/isa/dt019x.c |  321 ----------------------------------------------------
 4 files changed, 90 insertions(+), 375 deletions(-)
 delete mode 100644 sound/isa/dt019x.c

diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index 02fe81c..8ebd070 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -63,15 +63,16 @@ config SND_AD1848
 	  will be called snd-ad1848.
 
 config SND_ALS100
-	tristate "Avance Logic ALS100/ALS120"
+	tristate "Diamond Tech. DT-019x and Avance Logic ALSxxx"
 	depends on PNP
 	select ISAPNP
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_SB16_DSP
 	help
-	  Say Y here to include support for soundcards based on Avance
-	  Logic ALS100, ALS110, ALS120 and ALS200 chips.
+	  Say Y here to include support for soundcards based on the
+	  Diamond Technologies DT-019X or Avance Logic chips: ALS007,
+	  ALS100, ALS110, ALS120 and ALS200 chips.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-als100.
@@ -127,20 +128,6 @@ config SND_CS4236
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-cs4236.
 
-config SND_DT019X
-	tristate "Diamond Technologies DT-019X, Avance Logic ALS-007"
-	depends on PNP
-	select ISAPNP
-	select SND_OPL3_LIB
-	select SND_MPU401_UART
-	select SND_SB16_DSP
-	help
-	  Say Y here to include support for soundcards based on the
-	  Diamond Technologies DT-019X or Avance Logic ALS-007 chips.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called snd-dt019x.
-
 config SND_ES968
 	tristate "Generic ESS ES968 driver"
 	depends on PNP
diff --git a/sound/isa/Makefile b/sound/isa/Makefile
index b906b9a..c73d30c 100644
--- a/sound/isa/Makefile
+++ b/sound/isa/Makefile
@@ -7,7 +7,6 @@ snd-adlib-objs := adlib.o
 snd-als100-objs := als100.o
 snd-azt2320-objs := azt2320.o
 snd-cmi8330-objs := cmi8330.o
-snd-dt019x-objs := dt019x.o
 snd-es18xx-objs := es18xx.o
 snd-opl3sa2-objs := opl3sa2.o
 snd-sc6000-objs := sc6000.o
@@ -19,7 +18,6 @@ obj-$(CONFIG_SND_ADLIB) += snd-adlib.o
 obj-$(CONFIG_SND_ALS100) += snd-als100.o
 obj-$(CONFIG_SND_AZT2320) += snd-azt2320.o
 obj-$(CONFIG_SND_CMI8330) += snd-cmi8330.o
-obj-$(CONFIG_SND_DT019X) += snd-dt019x.o
 obj-$(CONFIG_SND_ES18XX) += snd-es18xx.o
 obj-$(CONFIG_SND_OPL3SA2) += snd-opl3sa2.o
 obj-$(CONFIG_SND_SC6000) += snd-sc6000.o
diff --git a/sound/isa/als100.c b/sound/isa/als100.c
index 5fd52e4..20becc8 100644
--- a/sound/isa/als100.c
+++ b/sound/isa/als100.c
@@ -2,9 +2,13 @@
 /*
     card-als100.c - driver for Avance Logic ALS100 based soundcards.
     Copyright (C) 1999-2000 by Massimo Piccioni <dafastidio@libero.it>
+    Copyright (C) 1999-2002 by Massimo Piccioni <dafastidio@libero.it>
 
     Thanks to Pierfrancesco 'qM2' Passerini.
 
+    Generalised for soundcards based on DT-0196 and ALS-007 chips
+    by Jonathan Woithe <jwoithe@physics.adelaide.edu.au>: June 2002.
+
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation; either version 2 of the License, or
@@ -33,10 +37,10 @@
 
 #define PFX "als100: "
 
-MODULE_AUTHOR("Massimo Piccioni <dafastidio@libero.it>");
-MODULE_DESCRIPTION("Avance Logic ALS1X0");
-MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Avance Logic,ALS100 - PRO16PNP},"
+MODULE_DESCRIPTION("Avance Logic ALS007/ALS1X0");
+MODULE_SUPPORTED_DEVICE("{{Diamond Technologies DT-019X},"
+		"{Avance Logic ALS-007}}"
+		"{{Avance Logic,ALS100 - PRO16PNP},"
 	        "{Avance Logic,ALS110},"
 	        "{Avance Logic,ALS120},"
 	        "{Avance Logic,ALS200},"
@@ -45,9 +49,12 @@ MODULE_SUPPORTED_DEVICE("{{Avance Logic,ALS100 - PRO16PNP},"
 	        "{Avance Logic,ALS120},"
 	        "{RTL,RTL3000}}");
 
+MODULE_AUTHOR("Massimo Piccioni <dafastidio@libero.it>");
+MODULE_LICENSE("GPL");
+
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
-static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_ISAPNP; /* Enable this card */
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;	/* Enable this card */
 static long port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* PnP setup */
 static long mpu_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* PnP setup */
 static long fm_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* PnP setup */
@@ -57,14 +64,15 @@ static int dma8[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* PnP setup */
 static int dma16[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* PnP setup */
 
 module_param_array(index, int, NULL, 0444);
-MODULE_PARM_DESC(index, "Index value for als100 based soundcard.");
+MODULE_PARM_DESC(index, "Index value for Avance Logic based soundcard.");
 module_param_array(id, charp, NULL, 0444);
-MODULE_PARM_DESC(id, "ID string for als100 based soundcard.");
+MODULE_PARM_DESC(id, "ID string for Avance Logic based soundcard.");
 module_param_array(enable, bool, NULL, 0444);
-MODULE_PARM_DESC(enable, "Enable als100 based soundcard.");
+MODULE_PARM_DESC(enable, "Enable Avance Logic based soundcard.");
+
+MODULE_ALIAS("snd-dt019x");
 
 struct snd_card_als100 {
-	int dev_no;
 	struct pnp_dev *dev;
 	struct pnp_dev *devmpu;
 	struct pnp_dev *devopl;
@@ -72,25 +80,43 @@ struct snd_card_als100 {
 };
 
 static struct pnp_card_device_id snd_als100_pnpids[] = {
+	/* DT197A30 */
+	{ .id = "RWB1688",
+	  .devs = { { "@@@0001" }, { "@X@0001" }, { "@H@0001" } },
+	  .driver_data = SB_HW_DT019X },
+	/* DT0196 / ALS-007 */
+	{ .id = "ALS0007",
+	  .devs = { { "@@@0001" }, { "@X@0001" }, { "@H@0001" } },
+	  .driver_data = SB_HW_DT019X },
 	/* ALS100 - PRO16PNP */
-	{ .id = "ALS0001", .devs = { { "@@@0001" }, { "@X@0001" }, { "@H@0001" } } },
+	{ .id = "ALS0001",
+	  .devs = { { "@@@0001" }, { "@X@0001" }, { "@H@0001" } },
+	  .driver_data = SB_HW_ALS100 },
 	/* ALS110 - MF1000 - Digimate 3D Sound */
-	{ .id = "ALS0110", .devs = { { "@@@1001" }, { "@X@1001" }, { "@H@1001" } } },
+	{ .id = "ALS0110",
+	  .devs = { { "@@@1001" }, { "@X@1001" }, { "@H@1001" } },
+	  .driver_data = SB_HW_ALS100 },
 	/* ALS120 */
-	{ .id = "ALS0120", .devs = { { "@@@2001" }, { "@X@2001" }, { "@H@2001" } } },
+	{ .id = "ALS0120",
+	  .devs = { { "@@@2001" }, { "@X@2001" }, { "@H@2001" } },
+	  .driver_data = SB_HW_ALS100 },
 	/* ALS200 */
-	{ .id = "ALS0200", .devs = { { "@@@0020" }, { "@X@0020" }, { "@H@0001" } } },
+	{ .id = "ALS0200",
+	  .devs = { { "@@@0020" }, { "@X@0020" }, { "@H@0001" } },
+	  .driver_data = SB_HW_ALS100 },
 	/* ALS200 OEM */
-	{ .id = "ALS0200", .devs = { { "@@@0020" }, { "@X@0020" }, { "@H@0020" } } },
+	{ .id = "ALS0200",
+	  .devs = { { "@@@0020" }, { "@X@0020" }, { "@H@0020" } },
+	  .driver_data = SB_HW_ALS100 },
 	/* RTL3000 */
-	{ .id = "RTL3000", .devs = { { "@@@2001" }, { "@X@2001" }, { "@H@2001" } } },
-	{ .id = "", } /* end */
+	{ .id = "RTL3000",
+	  .devs = { { "@@@2001" }, { "@X@2001" }, { "@H@2001" } },
+	  .driver_data = SB_HW_ALS100 },
+	{ .id = "" } /* end */
 };
 
 MODULE_DEVICE_TABLE(pnp_card, snd_als100_pnpids);
 
-#define DRIVER_NAME	"snd-card-als100"
-
 static int __devinit snd_card_als100_pnp(int dev, struct snd_card_als100 *acard,
 					 struct pnp_card_link *card,
 					 const struct pnp_card_device_id *id)
@@ -113,8 +139,12 @@ static int __devinit snd_card_als100_pnp(int dev, struct snd_card_als100 *acard,
 		return err;
 	}
 	port[dev] = pnp_port_start(pdev, 0);
-	dma8[dev] = pnp_dma(pdev, 1);
-	dma16[dev] = pnp_dma(pdev, 0);
+	if (id->driver_data == SB_HW_DT019X)
+		dma8[dev] = pnp_dma(pdev, 0);
+	else {
+		dma8[dev] = pnp_dma(pdev, 1);
+		dma16[dev] = pnp_dma(pdev, 0);
+	}
 	irq[dev] = pnp_irq(pdev, 0);
 
 	pdev = acard->devmpu;
@@ -175,22 +205,33 @@ static int __devinit snd_card_als100_probe(int dev,
 	}
 	snd_card_set_dev(card, &pcard->card->dev);
 
-	if ((error = snd_sbdsp_create(card, port[dev],
-				      irq[dev],
-				      snd_sb16dsp_interrupt,
-				      dma8[dev],
-				      dma16[dev],
-				      SB_HW_ALS100, &chip)) < 0) {
+	if (pid->driver_data == SB_HW_DT019X)
+		dma16[dev] = -1;
+
+	error = snd_sbdsp_create(card, port[dev], irq[dev],
+				  snd_sb16dsp_interrupt,
+				  dma8[dev], dma16[dev],
+				  pid->driver_data,
+				  &chip);
+	if (error < 0) {
 		snd_card_free(card);
 		return error;
 	}
 	acard->chip = chip;
 
-	strcpy(card->driver, "ALS100");
-	strcpy(card->shortname, "Avance Logic ALS100");
-	sprintf(card->longname, "%s, %s at 0x%lx, irq %d, dma %d&%d",
-		card->shortname, chip->name, chip->port,
-		irq[dev], dma8[dev], dma16[dev]);
+	if (pid->driver_data == SB_HW_DT019X) {
+		strcpy(card->driver, "DT-019X");
+		strcpy(card->shortname, "Diamond Tech. DT-019X");
+		sprintf(card->longname, "%s, %s at 0x%lx, irq %d, dma %d",
+			card->shortname, chip->name, chip->port,
+			irq[dev], dma8[dev]);
+	} else {
+		strcpy(card->driver, "ALS100");
+		strcpy(card->shortname, "Avance Logic ALS100");
+		sprintf(card->longname, "%s, %s at 0x%lx, irq %d, dma %d&%d",
+			card->shortname, chip->name, chip->port,
+			irq[dev], dma8[dev], dma16[dev]);
+	}
 
 	if ((error = snd_sb16dsp_pcm(chip, 0, NULL)) < 0) {
 		snd_card_free(card);
@@ -203,9 +244,19 @@ static int __devinit snd_card_als100_probe(int dev,
 	}
 
 	if (mpu_port[dev] > 0 && mpu_port[dev] != SNDRV_AUTO_PORT) {
-		if (snd_mpu401_uart_new(card, 0, MPU401_HW_ALS100,
+		int mpu_type = MPU401_HW_ALS100;
+
+		if (mpu_irq[dev] == SNDRV_AUTO_IRQ)
+			mpu_irq[dev] = -1;
+
+		if (pid->driver_data == SB_HW_DT019X)
+			mpu_type = MPU401_HW_MPU401;
+
+		if (snd_mpu401_uart_new(card, 0,
+					mpu_type,
 					mpu_port[dev], 0, 
-					mpu_irq[dev], IRQF_DISABLED,
+					mpu_irq[dev],
+					mpu_irq[dev] >= 0 ? IRQF_DISABLED : 0,
 					NULL) < 0)
 			snd_printk(KERN_ERR PFX "no MPU-401 device at 0x%lx\n", mpu_port[dev]);
 	}
@@ -291,7 +342,7 @@ static int snd_als100_pnp_resume(struct pnp_card_link *pcard)
 
 static struct pnp_card_driver als100_pnpc_driver = {
 	.flags          = PNP_DRIVER_RES_DISABLE,
-        .name           = "als100",
+	.name		= "als100",
         .id_table       = snd_als100_pnpids,
         .probe          = snd_als100_pnp_detect,
         .remove         = __devexit_p(snd_als100_pnp_remove),
@@ -312,7 +363,7 @@ static int __init alsa_card_als100_init(void)
 	if (!als100_devices) {
 		pnp_unregister_card_driver(&als100_pnpc_driver);
 #ifdef MODULE
-		snd_printk(KERN_ERR "no ALS100 based soundcards found\n");
+		snd_printk(KERN_ERR "no Avance Logic based soundcards found\n");
 #endif
 		return -ENODEV;
 	}
diff --git a/sound/isa/dt019x.c b/sound/isa/dt019x.c
deleted file mode 100644
index 80f5b1a..0000000
--- a/sound/isa/dt019x.c
+++ /dev/null
@@ -1,321 +0,0 @@
-
-/*
-    dt019x.c - driver for Diamond Technologies DT-0197H based soundcards.
-    Copyright (C) 1999, 2002 by Massimo Piccioni <dafastidio@libero.it>
-
-    Generalised for soundcards based on DT-0196 and ALS-007 chips 
-    by Jonathan Woithe <jwoithe@physics.adelaide.edu.au>: June 2002.
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
-*/
-
-#include <linux/init.h>
-#include <linux/wait.h>
-#include <linux/pnp.h>
-#include <linux/moduleparam.h>
-#include <sound/core.h>
-#include <sound/initval.h>
-#include <sound/mpu401.h>
-#include <sound/opl3.h>
-#include <sound/sb.h>
-
-#define PFX "dt019x: "
-
-MODULE_AUTHOR("Massimo Piccioni <dafastidio@libero.it>");
-MODULE_DESCRIPTION("Diamond Technologies DT-019X / Avance Logic ALS-007");
-MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{Diamond Technologies DT-019X},"
-	       "{Avance Logic ALS-007}}");
-
-static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
-static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
-static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;	/* Enable this card */
-static long port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* PnP setup */
-static long mpu_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* PnP setup */
-static long fm_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* PnP setup */
-static int irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* PnP setup */
-static int mpu_irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* PnP setup */
-static int dma8[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* PnP setup */
-
-module_param_array(index, int, NULL, 0444);
-MODULE_PARM_DESC(index, "Index value for DT-019X based soundcard.");
-module_param_array(id, charp, NULL, 0444);
-MODULE_PARM_DESC(id, "ID string for DT-019X based soundcard.");
-module_param_array(enable, bool, NULL, 0444);
-MODULE_PARM_DESC(enable, "Enable DT-019X based soundcard.");
-
-struct snd_card_dt019x {
-	struct pnp_dev *dev;
-	struct pnp_dev *devmpu;
-	struct pnp_dev *devopl;
-	struct snd_sb *chip;
-};
-
-static struct pnp_card_device_id snd_dt019x_pnpids[] = {
-	/* DT197A30 */
-	{ .id = "RWB1688", .devs = { { "@@@0001" }, { "@X@0001" }, { "@H@0001" }, } },
-	/* DT0196 / ALS-007 */
-	{ .id = "ALS0007", .devs = { { "@@@0001" }, { "@X@0001" }, { "@H@0001" }, } },
-	{ .id = "",  }
-};
-
-MODULE_DEVICE_TABLE(pnp_card, snd_dt019x_pnpids);
-
-
-#define DRIVER_NAME	"snd-card-dt019x"
-
-
-static int __devinit snd_card_dt019x_pnp(int dev, struct snd_card_dt019x *acard,
-					 struct pnp_card_link *card,
-					 const struct pnp_card_device_id *pid)
-{
-	struct pnp_dev *pdev;
-	int err;
-
-	acard->dev = pnp_request_card_device(card, pid->devs[0].id, NULL);
-	if (acard->dev == NULL)
-		return -ENODEV;
-
-	acard->devmpu = pnp_request_card_device(card, pid->devs[1].id, NULL);
-	acard->devopl = pnp_request_card_device(card, pid->devs[2].id, NULL);
-
-	pdev = acard->dev;
-
-	err = pnp_activate_dev(pdev);
-	if (err < 0) {
-		snd_printk(KERN_ERR PFX "DT-019X AUDIO pnp configure failure\n");
-		return err;
-	}
-
-	port[dev] = pnp_port_start(pdev, 0);
-	dma8[dev] = pnp_dma(pdev, 0);
-	irq[dev] = pnp_irq(pdev, 0);
-	snd_printdd("dt019x: found audio interface: port=0x%lx, irq=0x%x, dma=0x%x\n",
-			port[dev],irq[dev],dma8[dev]);
-
-	pdev = acard->devmpu;
-	if (pdev != NULL) {
-		err = pnp_activate_dev(pdev);
-		if (err < 0) {
-			pnp_release_card_device(pdev);
-			snd_printk(KERN_ERR PFX "DT-019X MPU401 pnp configure failure, skipping\n");
-			goto __mpu_error;
-		}
-		mpu_port[dev] = pnp_port_start(pdev, 0);
-		mpu_irq[dev] = pnp_irq(pdev, 0);
-		snd_printdd("dt019x: found MPU-401: port=0x%lx, irq=0x%x\n",
-			 	mpu_port[dev],mpu_irq[dev]);
-	} else {
-	__mpu_error:
-		acard->devmpu = NULL;
-		mpu_port[dev] = -1;
-	}
-
-	pdev = acard->devopl;
-	if (pdev != NULL) {
-		err = pnp_activate_dev(pdev);
-		if (err < 0) {
-			pnp_release_card_device(pdev);
-			snd_printk(KERN_ERR PFX "DT-019X OPL3 pnp configure failure, skipping\n");
-			goto __fm_error;
-		}
-		fm_port[dev] = pnp_port_start(pdev, 0);
-		snd_printdd("dt019x: found OPL3 synth: port=0x%lx\n",fm_port[dev]);
-	} else {
-	__fm_error:
-		acard->devopl = NULL;
-		fm_port[dev] = -1;
-	}
-
-	return 0;
-}
-
-static int __devinit snd_card_dt019x_probe(int dev, struct pnp_card_link *pcard, const struct pnp_card_device_id *pid)
-{
-	int error;
-	struct snd_sb *chip;
-	struct snd_card *card;
-	struct snd_card_dt019x *acard;
-	struct snd_opl3 *opl3;
-
-	error = snd_card_create(index[dev], id[dev], THIS_MODULE,
-				sizeof(struct snd_card_dt019x), &card);
-	if (error < 0)
-		return error;
-	acard = card->private_data;
-
-	snd_card_set_dev(card, &pcard->card->dev);
-	if ((error = snd_card_dt019x_pnp(dev, acard, pcard, pid))) {
-		snd_card_free(card);
-		return error;
-	}
-
-	if ((error = snd_sbdsp_create(card, port[dev],
-				      irq[dev],
-				      snd_sb16dsp_interrupt,
-				      dma8[dev],
-				      -1,
-				      SB_HW_DT019X,
-				      &chip)) < 0) {
-		snd_card_free(card);
-		return error;
-	}
-	acard->chip = chip;
-
-	strcpy(card->driver, "DT-019X");
-	strcpy(card->shortname, "Diamond Tech. DT-019X");
-	sprintf(card->longname, "%s, %s at 0x%lx, irq %d, dma %d",
-		card->shortname, chip->name, chip->port,
-		irq[dev], dma8[dev]);
-
-	if ((error = snd_sb16dsp_pcm(chip, 0, NULL)) < 0) {
-		snd_card_free(card);
-		return error;
-	}
-	if ((error = snd_sbmixer_new(chip)) < 0) {
-		snd_card_free(card);
-		return error;
-	}
-
-	if (mpu_port[dev] > 0 && mpu_port[dev] != SNDRV_AUTO_PORT) {
-		if (mpu_irq[dev] == SNDRV_AUTO_IRQ)
-			mpu_irq[dev] = -1;
-		if (snd_mpu401_uart_new(card, 0,
-/*					MPU401_HW_SB,*/
-					MPU401_HW_MPU401,
-					mpu_port[dev], 0,
-					mpu_irq[dev],
-					mpu_irq[dev] >= 0 ? IRQF_DISABLED : 0,
-					NULL) < 0)
-			snd_printk(KERN_ERR PFX "no MPU-401 device at 0x%lx ?\n", mpu_port[dev]);
-	}
-
-	if (fm_port[dev] > 0 && fm_port[dev] != SNDRV_AUTO_PORT) {
-		if (snd_opl3_create(card,
-				    fm_port[dev],
-				    fm_port[dev] + 2,
-				    OPL3_HW_AUTO, 0, &opl3) < 0) {
-			snd_printk(KERN_ERR PFX "no OPL device at 0x%lx-0x%lx ?\n",
-				   fm_port[dev], fm_port[dev] + 2);
-		} else {
-			if ((error = snd_opl3_timer_new(opl3, 0, 1)) < 0) {
-				snd_card_free(card);
-				return error;
-			}
-			if ((error = snd_opl3_hwdep_new(opl3, 0, 1, NULL)) < 0) {
-				snd_card_free(card);
-				return error;
-			}
-		}
-	}
-
-	if ((error = snd_card_register(card)) < 0) {
-		snd_card_free(card);
-		return error;
-	}
-	pnp_set_card_drvdata(pcard, card);
-	return 0;
-}
-
-static unsigned int __devinitdata dt019x_devices;
-
-static int __devinit snd_dt019x_pnp_probe(struct pnp_card_link *card,
-					  const struct pnp_card_device_id *pid)
-{
-	static int dev;
-	int res;
-
-	for ( ; dev < SNDRV_CARDS; dev++) {
-		if (!enable[dev])
-			continue;
-		res = snd_card_dt019x_probe(dev, card, pid);
-		if (res < 0)
-			return res;
-		dev++;
-		dt019x_devices++;
-		return 0;
-	}
-	return -ENODEV;
-}
-
-static void __devexit snd_dt019x_pnp_remove(struct pnp_card_link * pcard)
-{
-	snd_card_free(pnp_get_card_drvdata(pcard));
-	pnp_set_card_drvdata(pcard, NULL);
-}
-
-#ifdef CONFIG_PM
-static int snd_dt019x_pnp_suspend(struct pnp_card_link *pcard, pm_message_t state)
-{
-	struct snd_card *card = pnp_get_card_drvdata(pcard);
-	struct snd_card_dt019x *acard = card->private_data;
-	struct snd_sb *chip = acard->chip;
-
-	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend_all(chip->pcm);
-	snd_sbmixer_suspend(chip);
-	return 0;
-}
-
-static int snd_dt019x_pnp_resume(struct pnp_card_link *pcard)
-{
-	struct snd_card *card = pnp_get_card_drvdata(pcard);
-	struct snd_card_dt019x *acard = card->private_data;
-	struct snd_sb *chip = acard->chip;
-
-	snd_sbdsp_reset(chip);
-	snd_sbmixer_resume(chip);
-	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
-	return 0;
-}
-#endif
-
-static struct pnp_card_driver dt019x_pnpc_driver = {
-	.flags          = PNP_DRIVER_RES_DISABLE,
-	.name           = "dt019x",
-	.id_table       = snd_dt019x_pnpids,
-	.probe          = snd_dt019x_pnp_probe,
-	.remove         = __devexit_p(snd_dt019x_pnp_remove),
-#ifdef CONFIG_PM
-	.suspend	= snd_dt019x_pnp_suspend,
-	.resume		= snd_dt019x_pnp_resume,
-#endif
-};
-
-static int __init alsa_card_dt019x_init(void)
-{
-	int err;
-
-	err = pnp_register_card_driver(&dt019x_pnpc_driver);
-	if (err)
-		return err;
-
-	if (!dt019x_devices) {
-		pnp_unregister_card_driver(&dt019x_pnpc_driver);
-#ifdef MODULE
-		snd_printk(KERN_ERR "no DT-019X / ALS-007 based soundcards found\n");
-#endif
-		return -ENODEV;
-	}
-	return 0;
-}
-
-static void __exit alsa_card_dt019x_exit(void)
-{
-	pnp_unregister_card_driver(&dt019x_pnpc_driver);
-}
-
-module_init(alsa_card_dt019x_init)
-module_exit(alsa_card_dt019x_exit)
-- 
1.6.4


----------------------------------------------------------------------
Kup wlasne mieszkanie za 72 tys. zl.
Sprawdz najlepsze oferty >>> http://link.interia.pl/f24ce
