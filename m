From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] Merge es1688 and es968 drivers
Date: Sat, 1 May 2010 15:52:57 +0200
Message-ID: <20100501155257.b7284b9b.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpo.poczta.interia.pl (smtpo.poczta.interia.pl
	[217.74.65.205])
	by alsa0.perex.cz (Postfix) with ESMTP id 314A11037EA
	for <alsa-devel@alsa-project.org>;
	Sat,  1 May 2010 15:52:37 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The ESS ES968 chip is nothing more then a PnP companion
for non-PnP audio chips. It was paired with non-PnP ESS' chips:
ES688 and ES1688. The ESS' audio chips are handled by the es1688
driver in native mode. The PnP cards are handled by the ES968
driver in SB compatible mode.

Move the ES968 chip handling to the es1688 driver so the driver
can handle both PnP and non-PnP cards. The es968 is removed.

Also, a new PnP id is added for the card I acquired (the change
was tested on this card).

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 Documentation/sound/alsa/ALSA-Configuration.txt |   21 +--
 include/sound/es1688.h                          |    8 +-
 sound/isa/Kconfig                               |   16 +--
 sound/isa/es1688/es1688.c                       |  204 ++++++++++++++++---
 sound/isa/es1688/es1688_lib.c                   |   26 +--
 sound/isa/sb/Makefile                           |    2 -
 sound/isa/sb/es968.c                            |  248 -----------------------
 7 files changed, 198 insertions(+), 327 deletions(-)
 delete mode 100644 sound/isa/sb/es968.c

diff --git a/Documentation/sound/alsa/ALSA-Configuration.txt b/Documentation/sound/alsa/ALSA-Configuration.txt
index bfcbbf8..448cff9 100644
--- a/Documentation/sound/alsa/ALSA-Configuration.txt
+++ b/Documentation/sound/alsa/ALSA-Configuration.txt
@@ -622,28 +622,23 @@ Prior to version 0.9.0rc4 options had a 'snd_' prefix. This was removed.
     
     The power-management is supported.
 
-  Module snd-es968
-  ----------------
-
-    Module for sound cards based on ESS ES968 chip (PnP only).
-
-    This module supports multiple cards, PnP and autoprobe.
-    
-    The power-management is supported.
-
   Module snd-es1688
   -----------------
 
     Module for ESS AudioDrive ES-1688 and ES-688 sound cards.
 
-    port	- port # for ES-1688 chip (0x220,0x240,0x260)
-    fm_port	- port # for OPL3 (option; share the same port as default)
+    isapnp	- ISA PnP detection - 0 = disable, 1 = enable (default)
     mpu_port	- port # for MPU-401 port (0x300,0x310,0x320,0x330), -1 = disable (default)
-    irq		- IRQ # for ES-1688 chip (5,7,9,10)
     mpu_irq	- IRQ # for MPU-401 port (5,7,9,10)
+    fm_port	- port # for OPL3 (option; share the same port as default)
+
+    with isapnp=0, the following additional options are available:
+    port	- port # for ES-1688 chip (0x220,0x240,0x260)
+    irq		- IRQ # for ES-1688 chip (5,7,9,10)
     dma8	- DMA # for ES-1688 chip (0,1,3)
 
-    This module supports multiple cards and autoprobe (without MPU-401 port).
+    This module supports multiple cards and autoprobe (without MPU-401 port)
+    and PnP with the ES968 chip.
 
   Module snd-es18xx
   -----------------
diff --git a/include/sound/es1688.h b/include/sound/es1688.h
index 10fcf14..10d7951 100644
--- a/include/sound/es1688.h
+++ b/include/sound/es1688.h
@@ -44,7 +44,6 @@ struct snd_es1688 {
 	unsigned char pad;
 	unsigned int dma_size;
 
-	struct snd_card *card;
 	struct snd_pcm *pcm;
 	struct snd_pcm_substream *playback_substream;
 	struct snd_pcm_substream *capture_substream;
@@ -113,9 +112,8 @@ int snd_es1688_create(struct snd_card *card,
 		      int irq,
 		      int mpu_irq,
 		      int dma8,
-		      unsigned short hardware,
-		      struct snd_es1688 ** rchip);
-int snd_es1688_pcm(struct snd_es1688 *chip, int device, struct snd_pcm ** rpcm);
-int snd_es1688_mixer(struct snd_es1688 *chip);
+		      unsigned short hardware);
+int snd_es1688_pcm(struct snd_card *card, int device, struct snd_pcm **rpcm);
+int snd_es1688_mixer(struct snd_card *card);
 
 #endif /* __SOUND_ES1688_H */
diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index 755a0a5..c6990c6 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -128,26 +128,14 @@ config SND_CS4236
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-cs4236.
 
-config SND_ES968
-	tristate "Generic ESS ES968 driver"
-	depends on PNP
-	select ISAPNP
-	select SND_MPU401_UART
-	select SND_SB8_DSP
-	help
-	  Say Y here to include support for ESS AudioDrive ES968 chips.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called snd-es968.
-
 config SND_ES1688
-	tristate "Generic ESS ES688/ES1688 driver"
+	tristate "Generic ESS ES688/ES1688 and ES968 PnP driver"
 	select SND_OPL3_LIB
 	select SND_MPU401_UART
 	select SND_PCM
 	help
 	  Say Y here to include support for ESS AudioDrive ES688 or
-	  ES1688 chips.
+	  ES1688 chips. Also, this module support cards with ES968 PnP chip.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-es1688.
diff --git a/sound/isa/es1688/es1688.c b/sound/isa/es1688/es1688.c
index 07df201..4b5cc8c 100644
--- a/sound/isa/es1688/es1688.c
+++ b/sound/isa/es1688/es1688.c
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/isa.h>
+#include <linux/isapnp.h>
 #include <linux/time.h>
 #include <linux/wait.h>
 #include <linux/moduleparam.h>
@@ -47,6 +48,9 @@ MODULE_SUPPORTED_DEVICE("{{ESS,ES688 PnP AudioDrive,pnp:ESS0100},"
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
+#ifdef CONFIG_PNP
+static int isapnp[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_ISAPNP;
+#endif
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;	/* Enable this card */
 static long port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* 0x220,0x240,0x260 */
 static long fm_port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* Usually 0x388 */
@@ -60,6 +64,10 @@ MODULE_PARM_DESC(index, "Index value for " CRD_NAME " soundcard.");
 module_param_array(id, charp, NULL, 0444);
 MODULE_PARM_DESC(id, "ID string for " CRD_NAME " soundcard.");
 module_param_array(enable, bool, NULL, 0444);
+#ifdef CONFIG_PNP
+module_param_array(isapnp, bool, NULL, 0444);
+MODULE_PARM_DESC(isapnp, "PnP detection for specified soundcard.");
+#endif
 MODULE_PARM_DESC(enable, "Enable " CRD_NAME " soundcard.");
 module_param_array(port, long, NULL, 0444);
 MODULE_PARM_DESC(port, "Port # for " CRD_NAME " driver.");
@@ -74,13 +82,19 @@ MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for " CRD_NAME " driver.");
 module_param_array(dma8, int, NULL, 0444);
 MODULE_PARM_DESC(dma8, "8-bit DMA # for " CRD_NAME " driver.");
 
+#ifdef CONFIG_PNP
+#define is_isapnp_selected(dev)		isapnp[dev]
+#else
+#define is_isapnp_selected(dev)		0
+#endif
+
 static int __devinit snd_es1688_match(struct device *dev, unsigned int n)
 {
-	return enable[n];
+	return enable[n] && !is_isapnp_selected(n);
 }
 
-static int __devinit snd_es1688_legacy_create(struct snd_card *card, 
-		struct device *dev, unsigned int n, struct snd_es1688 **rchip)
+static int __devinit snd_es1688_legacy_create(struct snd_card *card,
+					struct device *dev, unsigned int n)
 {
 	static long possible_ports[] = {0x220, 0x240, 0x260};
 	static int possible_irqs[] = {5, 9, 10, 7, -1};
@@ -105,41 +119,32 @@ static int __devinit snd_es1688_legacy_create(struct snd_card *card,
 
 	if (port[n] != SNDRV_AUTO_PORT)
 		return snd_es1688_create(card, port[n], mpu_port[n], irq[n],
-				mpu_irq[n], dma8[n], ES1688_HW_AUTO, rchip);
+				mpu_irq[n], dma8[n], ES1688_HW_AUTO);
 
 	i = 0;
 	do {
 		port[n] = possible_ports[i];
 		error = snd_es1688_create(card, port[n], mpu_port[n], irq[n],
-				mpu_irq[n], dma8[n], ES1688_HW_AUTO, rchip);
+				mpu_irq[n], dma8[n], ES1688_HW_AUTO);
 	} while (error < 0 && ++i < ARRAY_SIZE(possible_ports));
 
 	return error;
 }
 
-static int __devinit snd_es1688_probe(struct device *dev, unsigned int n)
+static int __devinit snd_es1688_probe(struct snd_card *card, unsigned int n)
 {
-	struct snd_card *card;
-	struct snd_es1688 *chip;
+	struct snd_es1688 *chip = card->private_data;
 	struct snd_opl3 *opl3;
 	struct snd_pcm *pcm;
 	int error;
 
-	error = snd_card_create(index[n], id[n], THIS_MODULE, 0, &card);
+	error = snd_es1688_pcm(card, 0, &pcm);
 	if (error < 0)
 		return error;
 
-	error = snd_es1688_legacy_create(card, dev, n, &chip);
-	if (error < 0)
-		goto out;
-
-	error = snd_es1688_pcm(chip, 0, &pcm);
-	if (error < 0)
-		goto out;
-
-	error = snd_es1688_mixer(chip);
+	error = snd_es1688_mixer(card);
 	if (error < 0)
-		goto out;
+		return error;
 
 	strcpy(card->driver, "ES1688");
 	strcpy(card->shortname, pcm->name);
@@ -152,12 +157,12 @@ static int __devinit snd_es1688_probe(struct device *dev, unsigned int n)
 	if (fm_port[n] > 0) {
 		if (snd_opl3_create(card, fm_port[n], fm_port[n] + 2,
 				OPL3_HW_OPL3, 0, &opl3) < 0)
-			dev_warn(dev,
+			dev_warn(card->dev,
 				 "opl3 not detected at 0x%lx\n", fm_port[n]);
 		else {
 			error =	snd_opl3_hwdep_new(opl3, 0, 1, NULL);
 			if (error < 0)
-				goto out;
+				return error;
 		}
 	}
 
@@ -167,23 +172,41 @@ static int __devinit snd_es1688_probe(struct device *dev, unsigned int n)
 				chip->mpu_port, 0,
 				mpu_irq[n], IRQF_DISABLED, NULL);
 		if (error < 0)
-			goto out;
+			return error;
 	}
 
+	return snd_card_register(card);
+}
+
+static int __devinit snd_es1688_isa_probe(struct device *dev, unsigned int n)
+{
+	struct snd_card *card;
+	int error;
+
+	error = snd_card_create(index[n], id[n], THIS_MODULE,
+				sizeof(struct snd_es1688), &card);
+	if (error < 0)
+		return error;
+
+	error = snd_es1688_legacy_create(card, dev, n);
+	if (error < 0)
+		goto out;
+
 	snd_card_set_dev(card, dev);
 
-	error = snd_card_register(card);
+	error = snd_es1688_probe(card, n);
 	if (error < 0)
 		goto out;
 
 	dev_set_drvdata(dev, card);
-	return 0;
 
-out:	snd_card_free(card);
+	return 0;
+out:
+	snd_card_free(card);
 	return error;
 }
 
-static int __devexit snd_es1688_remove(struct device *dev, unsigned int n)
+static int __devexit snd_es1688_isa_remove(struct device *dev, unsigned int n)
 {
 	snd_card_free(dev_get_drvdata(dev));
 	dev_set_drvdata(dev, NULL);
@@ -192,8 +215,8 @@ static int __devexit snd_es1688_remove(struct device *dev, unsigned int n)
 
 static struct isa_driver snd_es1688_driver = {
 	.match		= snd_es1688_match,
-	.probe		= snd_es1688_probe,
-	.remove		= __devexit_p(snd_es1688_remove),
+	.probe		= snd_es1688_isa_probe,
+	.remove		= __devexit_p(snd_es1688_isa_remove),
 #if 0	/* FIXME */
 	.suspend	= snd_es1688_suspend,
 	.resume		= snd_es1688_resume,
@@ -203,14 +226,137 @@ static struct isa_driver snd_es1688_driver = {
 	}
 };
 
+static int snd_es968_pnp_is_probed;
+
+#ifdef CONFIG_PNP
+static int __devinit snd_card_es968_pnp(struct snd_card *card, unsigned int n,
+					struct pnp_card_link *pcard,
+					const struct pnp_card_device_id *pid)
+{
+	struct pnp_dev *pdev;
+	int error;
+
+	pdev = pnp_request_card_device(pcard, pid->devs[0].id, NULL);
+	if (pdev == NULL)
+		return -ENODEV;
+
+	error = pnp_activate_dev(pdev);
+	if (error < 0) {
+		snd_printk(KERN_ERR "ES968 pnp configure failure\n");
+		return error;
+	}
+	port[n] = pnp_port_start(pdev, 0);
+	dma8[n] = pnp_dma(pdev, 0);
+	irq[n] = pnp_irq(pdev, 0);
+
+	return snd_es1688_create(card, port[n], mpu_port[n], irq[n],
+				 mpu_irq[n], dma8[n], ES1688_HW_AUTO);
+}
+
+static int __devinit snd_es968_pnp_detect(struct pnp_card_link *pcard,
+					  const struct pnp_card_device_id *pid)
+{
+	struct snd_card *card;
+	static unsigned int dev;
+	int error;
+	struct snd_es1688 *chip;
+
+	if (snd_es968_pnp_is_probed)
+		return -EBUSY;
+	for ( ; dev < SNDRV_CARDS; dev++) {
+		if (enable[dev] && isapnp[dev])
+			break;
+	}
+
+	error = snd_card_create(index[dev], id[dev], THIS_MODULE,
+				sizeof(struct snd_es1688), &card);
+	if (error < 0)
+		return error;
+	chip = card->private_data;
+
+	error = snd_card_es968_pnp(card, dev, pcard, pid);
+	if (error < 0) {
+		snd_card_free(card);
+		return error;
+	}
+	snd_card_set_dev(card, &pcard->card->dev);
+	error = snd_es1688_probe(card, dev);
+	if (error < 0)
+		return error;
+	pnp_set_card_drvdata(pcard, card);
+	snd_es968_pnp_is_probed = 1;
+	return 0;
+}
+
+static void __devexit snd_es968_pnp_remove(struct pnp_card_link * pcard)
+{
+	snd_card_free(pnp_get_card_drvdata(pcard));
+	pnp_set_card_drvdata(pcard, NULL);
+	snd_es968_pnp_is_probed = 0;
+}
+
+#ifdef CONFIG_PM
+static int snd_es968_pnp_suspend(struct pnp_card_link *pcard,
+				 pm_message_t state)
+{
+	struct snd_card *card = pnp_get_card_drvdata(pcard);
+	struct snd_es1688 *chip = card->private_data;
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
+	snd_pcm_suspend_all(chip->pcm);
+	return 0;
+}
+
+static int snd_es968_pnp_resume(struct pnp_card_link *pcard)
+{
+	struct snd_card *card = pnp_get_card_drvdata(pcard);
+
+	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
+	return 0;
+}
+#endif
+
+static struct pnp_card_device_id snd_es968_pnpids[] = {
+	{ .id = "ESS0968", .devs = { { "@@@0968" }, } },
+	{ .id = "ESS0968", .devs = { { "ESS0968" }, } },
+	{ .id = "", } /* end */
+};
+
+MODULE_DEVICE_TABLE(pnp_card, snd_es968_pnpids);
+
+static struct pnp_card_driver es968_pnpc_driver = {
+	.flags		= PNP_DRIVER_RES_DISABLE,
+	.name		= DEV_NAME " PnP",
+	.id_table	= snd_es968_pnpids,
+	.probe		= snd_es968_pnp_detect,
+	.remove		= __devexit_p(snd_es968_pnp_remove),
+#ifdef CONFIG_PM
+	.suspend	= snd_es968_pnp_suspend,
+	.resume		= snd_es968_pnp_resume,
+#endif
+};
+#endif
+
 static int __init alsa_card_es1688_init(void)
 {
+#ifdef CONFIG_PNP
+	pnp_register_card_driver(&es968_pnpc_driver);
+	if (snd_es968_pnp_is_probed)
+		return 0;
+	pnp_unregister_card_driver(&es968_pnpc_driver);
+#endif
 	return isa_register_driver(&snd_es1688_driver, SNDRV_CARDS);
 }
 
 static void __exit alsa_card_es1688_exit(void)
 {
-	isa_unregister_driver(&snd_es1688_driver);
+	if (!snd_es968_pnp_is_probed) {
+		isa_unregister_driver(&snd_es1688_driver);
+		return;
+	}
+#ifdef CONFIG_PNP
+	pnp_unregister_card_driver(&es968_pnpc_driver);
+#endif
 }
 
 module_init(alsa_card_es1688_init);
diff --git a/sound/isa/es1688/es1688_lib.c b/sound/isa/es1688/es1688_lib.c
index c76bb00..9632dda 100644
--- a/sound/isa/es1688/es1688_lib.c
+++ b/sound/isa/es1688/es1688_lib.c
@@ -643,20 +643,14 @@ int snd_es1688_create(struct snd_card *card,
 		      int irq,
 		      int mpu_irq,
 		      int dma8,
-		      unsigned short hardware,
-		      struct snd_es1688 **rchip)
+		      unsigned short hardware)
 {
 	static struct snd_device_ops ops = {
 		.dev_free =	snd_es1688_dev_free,
 	};
-                                
-	struct snd_es1688 *chip;
+	struct snd_es1688 *chip = card->private_data;
 	int err;
 
-	*rchip = NULL;
-	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	if (chip == NULL)
-		return -ENOMEM;
 	chip->irq = -1;
 	chip->dma8 = -1;
 	
@@ -680,7 +674,6 @@ int snd_es1688_create(struct snd_card *card,
 
 	spin_lock_init(&chip->reg_lock);
 	spin_lock_init(&chip->mixer_lock);
-	chip->card = card;
 	chip->port = port;
 	mpu_port &= ~0x000f;
 	if (mpu_port < 0x300 || mpu_port > 0x330)
@@ -704,7 +697,6 @@ int snd_es1688_create(struct snd_card *card,
 		return err;
 	}
 
-	*rchip = chip;
 	return 0;
 }
 
@@ -730,12 +722,14 @@ static struct snd_pcm_ops snd_es1688_capture_ops = {
 	.pointer =		snd_es1688_capture_pointer,
 };
 
-int snd_es1688_pcm(struct snd_es1688 * chip, int device, struct snd_pcm ** rpcm)
+int snd_es1688_pcm(struct snd_card *card, int device, struct snd_pcm **rpcm)
 {
 	struct snd_pcm *pcm;
+	struct snd_es1688 *chip = card->private_data;
 	int err;
 
-	if ((err = snd_pcm_new(chip->card, "ESx688", device, 1, 1, &pcm)) < 0)
+	err = snd_pcm_new(card, "ESx688", device, 1, 1, &pcm);
+	if (err < 0)
 		return err;
 
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_es1688_playback_ops);
@@ -1009,17 +1003,17 @@ static unsigned char snd_es1688_init_table[][2] = {
 	{ ES1688_REC_DEV, 0x17 }
 };
                                         
-int snd_es1688_mixer(struct snd_es1688 *chip)
+int snd_es1688_mixer(struct snd_card *card)
 {
-	struct snd_card *card;
+	struct snd_es1688 *chip;
 	unsigned int idx;
 	int err;
 	unsigned char reg, val;
 
-	if (snd_BUG_ON(!chip || !chip->card))
+	if (snd_BUG_ON(!card || !card->private_data))
 		return -EINVAL;
 
-	card = chip->card;
+	chip = card->private_data;
 
 	strcpy(card->mixername, snd_es1688_chip_id(chip));
 
diff --git a/sound/isa/sb/Makefile b/sound/isa/sb/Makefile
index af36696..08b9fb9 100644
--- a/sound/isa/sb/Makefile
+++ b/sound/isa/sb/Makefile
@@ -11,7 +11,6 @@ snd-sb8-objs := sb8.o
 snd-sb16-objs := sb16.o
 snd-sbawe-objs := sbawe.o emu8000.o
 snd-emu8000-synth-objs := emu8000_synth.o emu8000_callback.o emu8000_patch.o emu8000_pcm.o
-snd-es968-objs := es968.o
 snd-jazz16-objs := jazz16.o
 
 # Toplevel Module Dependency
@@ -21,7 +20,6 @@ obj-$(CONFIG_SND_SB8_DSP) += snd-sb8-dsp.o
 obj-$(CONFIG_SND_SB8) += snd-sb8.o
 obj-$(CONFIG_SND_SB16) += snd-sb16.o
 obj-$(CONFIG_SND_SBAWE) += snd-sbawe.o
-obj-$(CONFIG_SND_ES968) += snd-es968.o
 obj-$(CONFIG_SND_JAZZ16) += snd-jazz16.o
 ifeq ($(CONFIG_SND_SB16_CSP),y)
   obj-$(CONFIG_SND_SB16) += snd-sb16-csp.o
diff --git a/sound/isa/sb/es968.c b/sound/isa/sb/es968.c
deleted file mode 100644
index ff18286..0000000
--- a/sound/isa/sb/es968.c
+++ /dev/null
@@ -1,248 +0,0 @@
-
-/*
-    card-es968.c - driver for ESS AudioDrive ES968 based soundcards.
-    Copyright (C) 1999 by Massimo Piccioni <dafastidio@libero.it>
-
-    Thanks to Pierfrancesco 'qM2' Passerini.
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
-#include <linux/time.h>
-#include <linux/pnp.h>
-#include <linux/moduleparam.h>
-#include <sound/core.h>
-#include <sound/initval.h>
-#include <sound/sb.h>
-
-#define PFX "es968: "
-
-MODULE_AUTHOR("Massimo Piccioni <dafastidio@libero.it>");
-MODULE_DESCRIPTION("ESS AudioDrive ES968");
-MODULE_LICENSE("GPL");
-MODULE_SUPPORTED_DEVICE("{{ESS,AudioDrive ES968}}");
-
-static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
-static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
-static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_ISAPNP; /* Enable this card */
-static long port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* PnP setup */
-static int irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* Pnp setup */
-static int dma8[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* PnP setup */
-
-module_param_array(index, int, NULL, 0444);
-MODULE_PARM_DESC(index, "Index value for es968 based soundcard.");
-module_param_array(id, charp, NULL, 0444);
-MODULE_PARM_DESC(id, "ID string for es968 based soundcard.");
-module_param_array(enable, bool, NULL, 0444);
-MODULE_PARM_DESC(enable, "Enable es968 based soundcard.");
-
-struct snd_card_es968 {
-	struct pnp_dev *dev;
-	struct snd_sb *chip;
-};
-
-static struct pnp_card_device_id snd_es968_pnpids[] = {
-	{ .id = "ESS0968", .devs = { { "@@@0968" }, } },
-	{ .id = "", } /* end */
-};
-
-MODULE_DEVICE_TABLE(pnp_card, snd_es968_pnpids);
-
-#define	DRIVER_NAME	"snd-card-es968"
-
-static irqreturn_t snd_card_es968_interrupt(int irq, void *dev_id)
-{
-	struct snd_sb *chip = dev_id;
-
-	if (chip->open & SB_OPEN_PCM) {
-		return snd_sb8dsp_interrupt(chip);
-	} else {
-		return snd_sb8dsp_midi_interrupt(chip);
-	}
-}
-
-static int __devinit snd_card_es968_pnp(int dev, struct snd_card_es968 *acard,
-					struct pnp_card_link *card,
-					const struct pnp_card_device_id *id)
-{
-	struct pnp_dev *pdev;
-	int err;
-
-	acard->dev = pnp_request_card_device(card, id->devs[0].id, NULL);
-	if (acard->dev == NULL)
-		return -ENODEV;
-
-	pdev = acard->dev;
-
-	err = pnp_activate_dev(pdev);
-	if (err < 0) {
-		snd_printk(KERN_ERR PFX "AUDIO pnp configure failure\n");
-		return err;
-	}
-	port[dev] = pnp_port_start(pdev, 0);
-	dma8[dev] = pnp_dma(pdev, 0);
-	irq[dev] = pnp_irq(pdev, 0);
-
-	return 0;
-}
-
-static int __devinit snd_card_es968_probe(int dev,
-					struct pnp_card_link *pcard,
-					const struct pnp_card_device_id *pid)
-{
-	int error;
-	struct snd_sb *chip;
-	struct snd_card *card;
-	struct snd_card_es968 *acard;
-
-	error = snd_card_create(index[dev], id[dev], THIS_MODULE,
-				sizeof(struct snd_card_es968), &card);
-	if (error < 0)
-		return error;
-	acard = card->private_data;
-	if ((error = snd_card_es968_pnp(dev, acard, pcard, pid))) {
-		snd_card_free(card);
-		return error;
-	}
-	snd_card_set_dev(card, &pcard->card->dev);
-
-	if ((error = snd_sbdsp_create(card, port[dev],
-				      irq[dev],
-				      snd_card_es968_interrupt,
-				      dma8[dev],
-				      -1,
-				      SB_HW_AUTO, &chip)) < 0) {
-		snd_card_free(card);
-		return error;
-	}
-	acard->chip = chip;
-
-	if ((error = snd_sb8dsp_pcm(chip, 0, NULL)) < 0) {
-		snd_card_free(card);
-		return error;
-	}
-
-	if ((error = snd_sbmixer_new(chip)) < 0) {
-		snd_card_free(card);
-		return error;
-	}
-
-	if ((error = snd_sb8dsp_midi(chip, 0, NULL)) < 0) {
-		snd_card_free(card);
-		return error;
-	}
-
-	strcpy(card->driver, "ES968");
-	strcpy(card->shortname, "ESS ES968");
-	sprintf(card->longname, "%s soundcard, %s at 0x%lx, irq %d, dma %d",
-		card->shortname, chip->name, chip->port, irq[dev], dma8[dev]);
-
-	if ((error = snd_card_register(card)) < 0) {
-		snd_card_free(card);
-		return error;
-	}
-	pnp_set_card_drvdata(pcard, card);
-	return 0;
-}
-
-static unsigned int __devinitdata es968_devices;
-
-static int __devinit snd_es968_pnp_detect(struct pnp_card_link *card,
-                                          const struct pnp_card_device_id *id)
-{
-	static int dev;
-	int res;
-
-	for ( ; dev < SNDRV_CARDS; dev++) {
-		if (!enable[dev])
-			continue;
-		res = snd_card_es968_probe(dev, card, id);
-		if (res < 0)
-			return res;
-		dev++;
-		es968_devices++;
-		return 0;
-	}
-	return -ENODEV;
-}
-
-static void __devexit snd_es968_pnp_remove(struct pnp_card_link * pcard)
-{
-	snd_card_free(pnp_get_card_drvdata(pcard));
-	pnp_set_card_drvdata(pcard, NULL);
-}
-
-#ifdef CONFIG_PM
-static int snd_es968_pnp_suspend(struct pnp_card_link *pcard, pm_message_t state)
-{
-	struct snd_card *card = pnp_get_card_drvdata(pcard);
-	struct snd_card_es968 *acard = card->private_data;
-	struct snd_sb *chip = acard->chip;
-
-	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	snd_pcm_suspend_all(chip->pcm);
-	snd_sbmixer_suspend(chip);
-	return 0;
-}
-
-static int snd_es968_pnp_resume(struct pnp_card_link *pcard)
-{
-	struct snd_card *card = pnp_get_card_drvdata(pcard);
-	struct snd_card_es968 *acard = card->private_data;
-	struct snd_sb *chip = acard->chip;
-
-	snd_sbdsp_reset(chip);
-	snd_sbmixer_resume(chip);
-	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
-	return 0;
-}
-#endif
-
-static struct pnp_card_driver es968_pnpc_driver = {
-	.flags		= PNP_DRIVER_RES_DISABLE,
-	.name		= "es968",
-	.id_table	= snd_es968_pnpids,
-	.probe		= snd_es968_pnp_detect,
-	.remove		= __devexit_p(snd_es968_pnp_remove),
-#ifdef CONFIG_PM
-	.suspend	= snd_es968_pnp_suspend,
-	.resume		= snd_es968_pnp_resume,
-#endif
-};
-
-static int __init alsa_card_es968_init(void)
-{
-	int err = pnp_register_card_driver(&es968_pnpc_driver);
-	if (err)
-		return err;
-
-	if (!es968_devices) {
-		pnp_unregister_card_driver(&es968_pnpc_driver);
-#ifdef MODULE
-		snd_printk(KERN_ERR "no ES968 based soundcards found\n");
-#endif
-		return -ENODEV;
-	}
-	return 0;
-}
-
-static void __exit alsa_card_es968_exit(void)
-{
-	pnp_unregister_card_driver(&es968_pnpc_driver);
-}
-
-module_init(alsa_card_es968_init)
-module_exit(alsa_card_es968_exit)
-- 
1.6.4


----------------------------------------------------------------------
Szukasz pracy? Zobacz ciekawe oferty w Twoim miescie
Sprawdz >>> http://linkint.pl/f26b2
