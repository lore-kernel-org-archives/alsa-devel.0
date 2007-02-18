From: Rene Herman <rene.herman@gmail.com>
Subject: isa_bus: gusextreeme
Date: Sun, 18 Feb 2007 21:01:46 +0100
Message-ID: <45D8B0AA.2040608@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080807000209010609020202"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080807000209010609020202
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Good day.

===
gusextreme: port to isa_bus infrastructure

Signed-off-by: Rene Herman <rene.herman@gmail.com>
===

Straightforward combination of es1688 and gusclassic. The legacy create 
has been divided into one es1688 and one gus_card function really only 
due to the:

        if (gf1_port[n] < 0)
                gf1_port[n] = es1688->port + 0x20;

line that wants to be in between -- this should be done even when we 
weren't doing legacy probing for es1688 so wants to be in probe() 
itself. This does change the order in which resources are requested by 
the code, bus that's actually a good thing. The gusextreme included the 
es1688 specifically for soundblaster compatibility, meaning the standard 
port=0220,irq=5,dma=1 soundblaster triple should preferably be assigned 
to it as happens now; in the old situation, GF1 got IRQ5. GF1 now first 
probes for the IRQs the es1688 can't use anyway ...

Has been tested and works fine, if not for one small bug also present in 
the original -- see next message.

Rene.

--------------080807000209010609020202
Content-Type: text/plain;
 name="gusextreme.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gusextreme.diff"

diff --git a/sound/isa/gus/gusextreme.c b/sound/isa/gus/gusextreme.c
index 532c56e..74e34e6 100644
--- a/sound/isa/gus/gusextreme.c
+++ b/sound/isa/gus/gusextreme.c
@@ -22,7 +22,7 @@
 #include <sound/driver.h>
 #include <linux/init.h>
 #include <linux/err.h>
-#include <linux/platform_device.h>
+#include <linux/isa.h>
 #include <linux/delay.h>
 #include <linux/time.h>
 #include <linux/moduleparam.h>
@@ -37,8 +37,11 @@ #define SNDRV_LEGACY_FIND_FREE_IRQ
 #define SNDRV_LEGACY_FIND_FREE_DMA
 #include <sound/initval.h>
 
+#define CRD_NAME "Gravis UltraSound Extreme"
+#define DEV_NAME "gusextreme"
+
+MODULE_DESCRIPTION(CRD_NAME);
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
-MODULE_DESCRIPTION("Gravis UltraSound Extreme");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Gravis,UltraSound Extreme}}");
 
@@ -59,43 +62,107 @@ static int channels[SNDRV_CARDS] = {[0 .
 static int pcm_channels[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 2};
 
 module_param_array(index, int, NULL, 0444);
-MODULE_PARM_DESC(index, "Index value for GUS Extreme soundcard.");
+MODULE_PARM_DESC(index, "Index value for " CRD_NAME " soundcard.");
 module_param_array(id, charp, NULL, 0444);
-MODULE_PARM_DESC(id, "ID string for GUS Extreme soundcard.");
+MODULE_PARM_DESC(id, "ID string for " CRD_NAME " soundcard.");
 module_param_array(enable, bool, NULL, 0444);
-MODULE_PARM_DESC(enable, "Enable GUS Extreme soundcard.");
+MODULE_PARM_DESC(enable, "Enable " CRD_NAME " soundcard.");
 module_param_array(port, long, NULL, 0444);
-MODULE_PARM_DESC(port, "Port # for GUS Extreme driver.");
+MODULE_PARM_DESC(port, "Port # for " CRD_NAME " driver.");
 module_param_array(gf1_port, long, NULL, 0444);
-MODULE_PARM_DESC(gf1_port, "GF1 port # for GUS Extreme driver (optional).");
+MODULE_PARM_DESC(gf1_port, "GF1 port # for " CRD_NAME " driver (optional).");
 module_param_array(mpu_port, long, NULL, 0444);
-MODULE_PARM_DESC(mpu_port, "MPU-401 port # for GUS Extreme driver.");
+MODULE_PARM_DESC(mpu_port, "MPU-401 port # for " CRD_NAME " driver.");
 module_param_array(irq, int, NULL, 0444);
-MODULE_PARM_DESC(irq, "IRQ # for GUS Extreme driver.");
+MODULE_PARM_DESC(irq, "IRQ # for " CRD_NAME " driver.");
 module_param_array(mpu_irq, int, NULL, 0444);
-MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for GUS Extreme driver.");
+MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for " CRD_NAME " driver.");
 module_param_array(gf1_irq, int, NULL, 0444);
-MODULE_PARM_DESC(gf1_irq, "GF1 IRQ # for GUS Extreme driver.");
+MODULE_PARM_DESC(gf1_irq, "GF1 IRQ # for " CRD_NAME " driver.");
 module_param_array(dma8, int, NULL, 0444);
-MODULE_PARM_DESC(dma8, "8-bit DMA # for GUS Extreme driver.");
+MODULE_PARM_DESC(dma8, "8-bit DMA # for " CRD_NAME " driver.");
 module_param_array(dma1, int, NULL, 0444);
-MODULE_PARM_DESC(dma1, "GF1 DMA # for GUS Extreme driver.");
+MODULE_PARM_DESC(dma1, "GF1 DMA # for " CRD_NAME " driver.");
 module_param_array(joystick_dac, int, NULL, 0444);
-MODULE_PARM_DESC(joystick_dac, "Joystick DAC level 0.59V-4.52V or 0.389V-2.98V for GUS Extreme driver.");
+MODULE_PARM_DESC(joystick_dac, "Joystick DAC level 0.59V-4.52V or 0.389V-2.98V for " CRD_NAME " driver.");
 module_param_array(channels, int, NULL, 0444);
-MODULE_PARM_DESC(channels, "GF1 channels for GUS Extreme driver.");
+MODULE_PARM_DESC(channels, "GF1 channels for " CRD_NAME " driver.");
 module_param_array(pcm_channels, int, NULL, 0444);
-MODULE_PARM_DESC(pcm_channels, "Reserved PCM channels for GUS Extreme driver.");
+MODULE_PARM_DESC(pcm_channels, "Reserved PCM channels for " CRD_NAME " driver.");
+
+static int __devinit snd_gusextreme_match(struct device *dev, unsigned int n)
+{
+	return enable[n];
+}
+
+static int __devinit snd_gusextreme_es1688_create(struct snd_card *card,
+		struct device *dev, unsigned int n, struct snd_es1688 **rchip)
+{
+	static long possible_ports[] = {0x220, 0x240, 0x260};
+	static int possible_irqs[] = {5, 9, 10, 7, -1};
+	static int possible_dmas[] = {1, 3, 0, -1};
+
+	int i, error;
+
+	if (irq[n] == SNDRV_AUTO_IRQ) {
+		irq[n] = snd_legacy_find_free_irq(possible_irqs);
+		if (irq[n] < 0) {
+			snd_printk(KERN_ERR "%s: unable to find a free IRQ "
+				"for ES1688\n", dev->bus_id);
+			return -EBUSY;
+		}
+	}
+	if (dma8[n] == SNDRV_AUTO_DMA) {
+		dma8[n] = snd_legacy_find_free_dma(possible_dmas);
+		if (dma8[n] < 0) {
+			snd_printk(KERN_ERR "%s: unable to find a free DMA "
+				"for ES1688\n", dev->bus_id);
+			return -EBUSY;
+		}
+	}
 
-static struct platform_device *devices[SNDRV_CARDS];
+	if (port[n] != SNDRV_AUTO_PORT)
+		return snd_es1688_create(card, port[n], mpu_port[n], irq[n],
+				mpu_irq[n], dma8[n], ES1688_HW_1688, rchip);
 
+	i = 0;
+	do {
+		port[n] = possible_ports[i];
+		error = snd_es1688_create(card, port[n], mpu_port[n], irq[n],
+				mpu_irq[n], dma8[n], ES1688_HW_1688, rchip);
+	} while (error < 0 && ++i < ARRAY_SIZE(possible_ports));
 
-#define PFX	"gusextreme: "
+	return error;
+}
 
-static int __init snd_gusextreme_detect(int dev,
-					struct snd_card *card,
-					struct snd_gus_card * gus,
-					struct snd_es1688 *es1688)
+static int __devinit snd_gusextreme_gus_card_create(struct snd_card *card,
+		struct device *dev, unsigned int n, struct snd_gus_card **rgus)
+{
+	static int possible_irqs[] = {11, 12, 15, 9, 5, 7, 3, -1};
+	static int possible_dmas[] = {5, 6, 7, 3, 1, -1};
+
+	if (gf1_irq[n] == SNDRV_AUTO_IRQ) {
+		gf1_irq[n] = snd_legacy_find_free_irq(possible_irqs);
+		if (gf1_irq[n] < 0) {
+			snd_printk(KERN_ERR "%s: unable to find a free IRQ "
+				"for GF1\n", dev->bus_id);
+			return -EBUSY;
+		}
+	}
+	if (dma1[n] == SNDRV_AUTO_DMA) {
+		dma1[n] = snd_legacy_find_free_dma(possible_dmas);
+		if (dma1[n] < 0) {
+			snd_printk(KERN_ERR "%s: unable to find a free DMA "
+				"for GF1\n", dev->bus_id);
+			return -EBUSY;
+		}
+	}
+	return snd_gus_create(card, gf1_port[n], gf1_irq[n], dma1[n], -1,
+			0, channels[n], pcm_channels[n], 0, rgus);
+}
+
+static int __devinit snd_gusextreme_detect(struct snd_gus_card *gus,
+	struct snd_es1688 *es1688)
 {
 	unsigned long flags;
 	unsigned char d;
@@ -117,12 +184,13 @@ static int __init snd_gusextreme_detect(
 	spin_lock_irqsave(&es1688->mixer_lock, flags);
 	snd_es1688_mixer_write(es1688, 0x40, 0x0b);	/* don't change!!! */
 	spin_unlock_irqrestore(&es1688->mixer_lock, flags);
+
 	spin_lock_irqsave(&es1688->reg_lock, flags);
-	outb(gf1_port[dev] & 0x040 ? 2 : 0, ES1688P(es1688, INIT1));
+	outb(gus->gf1.port & 0x040 ? 2 : 0, ES1688P(es1688, INIT1));
 	outb(0, 0x201);
-	outb(gf1_port[dev] & 0x020 ? 2 : 0, ES1688P(es1688, INIT1));
+	outb(gus->gf1.port & 0x020 ? 2 : 0, ES1688P(es1688, INIT1));
 	outb(0, 0x201);
-	outb(gf1_port[dev] & 0x010 ? 3 : 1, ES1688P(es1688, INIT1));
+	outb(gus->gf1.port & 0x010 ? 3 : 1, ES1688P(es1688, INIT1));
 	spin_unlock_irqrestore(&es1688->reg_lock, flags);
 
 	udelay(100);
@@ -139,253 +207,171 @@ static int __init snd_gusextreme_detect(
 		snd_printdd("[0x%lx] check 2 failed - 0x%x\n", gus->gf1.port, d);
 		return -EIO;
 	}
-	return 0;
-}
 
-static void __init snd_gusextreme_init(int dev, struct snd_gus_card * gus)
-{
-	gus->joystick_dac = joystick_dac[dev];
+	return 0;
 }
 
-static int __init snd_gusextreme_mixer(struct snd_es1688 *chip)
+static int __devinit snd_gusextreme_mixer(struct snd_es1688 *chip)
 {
 	struct snd_card *card = chip->card;
 	struct snd_ctl_elem_id id1, id2;
-	int err;
+	int error;
 
 	memset(&id1, 0, sizeof(id1));
 	memset(&id2, 0, sizeof(id2));
 	id1.iface = id2.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+
 	/* reassign AUX to SYNTHESIZER */
 	strcpy(id1.name, "Aux Playback Volume");
 	strcpy(id2.name, "Synth Playback Volume");
-	if ((err = snd_ctl_rename_id(card, &id1, &id2)) < 0)
-		return err;
+	error = snd_ctl_rename_id(card, &id1, &id2);
+	if (error < 0)
+		return error;
+
 	/* reassign Master Playback Switch to Synth Playback Switch */
 	strcpy(id1.name, "Master Playback Switch");
 	strcpy(id2.name, "Synth Playback Switch");
-	if ((err = snd_ctl_rename_id(card, &id1, &id2)) < 0)
-		return err;
+	error = snd_ctl_rename_id(card, &id1, &id2);
+	if (error < 0)
+		return error;
+
 	return 0;
 }
 
-static int __init snd_gusextreme_probe(struct platform_device *pdev)
+static int __devinit snd_gusextreme_probe(struct device *dev, unsigned int n)
 {
-	int dev = pdev->id;
-	static int possible_ess_irqs[] = {5, 9, 10, 7, -1};
-	static int possible_ess_dmas[] = {1, 3, 0, -1};
-	static int possible_gf1_irqs[] = {5, 11, 12, 9, 7, 15, 3, -1};
-	static int possible_gf1_dmas[] = {5, 6, 7, 1, 3, -1};
-	int xgf1_irq, xgf1_dma, xess_irq, xmpu_irq, xess_dma;
 	struct snd_card *card;
 	struct snd_gus_card *gus;
 	struct snd_es1688 *es1688;
 	struct snd_opl3 *opl3;
-	int err;
+	int error;
 
-	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
-	if (card == NULL)
-		return -ENOMEM;
+	card = snd_card_new(index[n], id[n], THIS_MODULE, 0);
+	if (!card)
+		return -EINVAL;
 
-	xgf1_irq = gf1_irq[dev];
-	if (xgf1_irq == SNDRV_AUTO_IRQ) {
-		if ((xgf1_irq = snd_legacy_find_free_irq(possible_gf1_irqs)) < 0) {
-			snd_printk(KERN_ERR PFX "unable to find a free IRQ for GF1\n");
-			err = -EBUSY;
-			goto out;
-		}
-	}
-	xess_irq = irq[dev];
-	if (xess_irq == SNDRV_AUTO_IRQ) {
-		if ((xess_irq = snd_legacy_find_free_irq(possible_ess_irqs)) < 0) {
-			snd_printk(KERN_ERR PFX "unable to find a free IRQ for ES1688\n");
-			err = -EBUSY;
-			goto out;
-		}
-	}
-	if (mpu_port[dev] == SNDRV_AUTO_PORT)
-		mpu_port[dev] = 0;
-	xmpu_irq = mpu_irq[dev];
-	if (xmpu_irq > 15)
-		xmpu_irq = -1;
-	xgf1_dma = dma1[dev];
-	if (xgf1_dma == SNDRV_AUTO_DMA) {
-		if ((xgf1_dma = snd_legacy_find_free_dma(possible_gf1_dmas)) < 0) {
-			snd_printk(KERN_ERR PFX "unable to find a free DMA for GF1\n");
-			err = -EBUSY;
-			goto out;
-		}
-	}
-	xess_dma = dma8[dev];
-	if (xess_dma == SNDRV_AUTO_DMA) {
-		if ((xess_dma = snd_legacy_find_free_dma(possible_ess_dmas)) < 0) {
-			snd_printk(KERN_ERR PFX "unable to find a free DMA for ES1688\n");
-			err = -EBUSY;
-			goto out;
-		}
-	}
+	if (mpu_port[n] == SNDRV_AUTO_PORT)
+		mpu_port[n] = 0;
 
-	if (port[dev] != SNDRV_AUTO_PORT) {
-		err = snd_es1688_create(card, port[dev], mpu_port[dev],
-					xess_irq, xmpu_irq, xess_dma,
-					ES1688_HW_1688, &es1688);
-	} else {
-		/* auto-probe legacy ports */
-		static unsigned long possible_ports[] = {0x220, 0x240, 0x260};
-		int i;
-		for (i = 0; i < ARRAY_SIZE(possible_ports); i++) {
-			err = snd_es1688_create(card,
-						possible_ports[i],
-						mpu_port[dev],
-						xess_irq, xmpu_irq, xess_dma,
-						ES1688_HW_1688, &es1688);
-			if (err >= 0) {
-				port[dev] = possible_ports[i];
-				break;
-			}
-		}
-	}
-	if (err < 0)
+	if (mpu_irq[n] > 15)
+		mpu_irq[n] = -1;
+
+	error = snd_gusextreme_es1688_create(card, dev, n, &es1688);
+	if (error < 0)
 		goto out;
 
-	if (gf1_port[dev] < 0)
-		gf1_port[dev] = port[dev] + 0x20;
-	if ((err = snd_gus_create(card,
-				  gf1_port[dev],
-				  xgf1_irq,
-				  xgf1_dma,
-				  -1,
-				  0, channels[dev],
-				  pcm_channels[dev], 0,
-				  &gus)) < 0)
+	if (gf1_port[n] < 0)
+		gf1_port[n] = es1688->port + 0x20;
+
+	error = snd_gusextreme_gus_card_create(card, dev, n, &gus);
+	if (error < 0)
 		goto out;
 
-	if ((err = snd_gusextreme_detect(dev, card, gus, es1688)) < 0)
+	error = snd_gusextreme_detect(gus, es1688);
+	if (error < 0)
 		goto out;
 
-	snd_gusextreme_init(dev, gus);
-	if ((err = snd_gus_initialize(gus)) < 0)
+	gus->joystick_dac = joystick_dac[n];
+
+	error = snd_gus_initialize(gus);
+	if (error < 0)
 		goto out;
 
+	error = -ENODEV;
 	if (!gus->ess_flag) {
-		snd_printk(KERN_ERR PFX "GUS Extreme soundcard was not detected at 0x%lx\n", gus->gf1.port);
-		err = -ENODEV;
+		snd_printk(KERN_ERR "%s: GUS Extreme soundcard was not "
+			"detected at 0x%lx\n", dev->bus_id, gus->gf1.port);
 		goto out;
 	}
-	if ((err = snd_es1688_pcm(es1688, 0, NULL)) < 0)
+
+	error = snd_es1688_pcm(es1688, 0, NULL);
+	if (error < 0)
 		goto out;
 
-	if ((err = snd_es1688_mixer(es1688)) < 0)
+	error = snd_es1688_mixer(es1688);
+	if (error < 0)
 		goto out;
 
 	snd_component_add(card, "ES1688");
-	if (pcm_channels[dev] > 0) {
-		if ((err = snd_gf1_pcm_new(gus, 1, 1, NULL)) < 0)
+
+	if (pcm_channels[n] > 0) {
+		error = snd_gf1_pcm_new(gus, 1, 1, NULL);
+		if (error < 0)
 			goto out;
 	}
-	if ((err = snd_gf1_new_mixer(gus)) < 0)
+
+	error = snd_gf1_new_mixer(gus);
+	if (error < 0)
 		goto out;
 
-	if ((err = snd_gusextreme_mixer(es1688)) < 0)
+	error = snd_gusextreme_mixer(es1688);
+	if (error < 0)
 		goto out;
 
 	if (snd_opl3_create(card, es1688->port, es1688->port + 2,
-			    OPL3_HW_OPL3, 0, &opl3) < 0) {
-		printk(KERN_ERR PFX "gusextreme: opl3 not detected at 0x%lx\n", es1688->port);
-	} else {
-		if ((err = snd_opl3_hwdep_new(opl3, 0, 2, NULL)) < 0)
+			OPL3_HW_OPL3, 0, &opl3) < 0)
+		printk(KERN_ERR "%s: opl3 not detected at 0x%lx\n",
+			dev->bus_id, es1688->port);
+	else {
+		error = snd_opl3_hwdep_new(opl3, 0, 2, NULL);
+		if (error < 0)
 			goto out;
 	}
 
-	if (es1688->mpu_port >= 0x300 &&
-	    (err = snd_mpu401_uart_new(card, 0, MPU401_HW_ES1688,
-					       es1688->mpu_port, 0,
-					       xmpu_irq,
-					       IRQF_DISABLED,
-					       NULL)) < 0)
-		goto out;
+	if (es1688->mpu_port >= 0x300) {
+		error = snd_mpu401_uart_new(card, 0, MPU401_HW_ES1688,
+				es1688->mpu_port, 0,
+				mpu_irq[n], IRQF_DISABLED, NULL);
+		if (error < 0)
+			goto out;
+	}
 
-	sprintf(card->longname, "Gravis UltraSound Extreme at 0x%lx, irq %i&%i, dma %i&%i",
-		es1688->port, xgf1_irq, xess_irq, xgf1_dma, xess_dma);
+	sprintf(card->longname, "Gravis UltraSound Extreme at 0x%lx, "
+		"irq %i&%i, dma %i&%i", es1688->port,
+		gus->gf1.irq, es1688->irq, gus->gf1.dma1, es1688->dma8);
 
-	snd_card_set_dev(card, &pdev->dev);
+	snd_card_set_dev(card, dev);
 
-	if ((err = snd_card_register(card)) < 0)
+	error = snd_card_register(card);
+	if (error < 0)
 		goto out;
 
-	platform_set_drvdata(pdev, card);
+	dev_set_drvdata(dev, card);
 	return 0;
 
-      out:
-	snd_card_free(card);
-	return err;
+out:	snd_card_free(card);
+	return error;
 }
 
-static int snd_gusextreme_remove(struct platform_device *devptr)
+static int __devexit snd_gusextreme_remove(struct device *dev, unsigned int n)
 {
-	snd_card_free(platform_get_drvdata(devptr));
-	platform_set_drvdata(devptr, NULL);
+	snd_card_free(dev_get_drvdata(dev));
+	dev_set_drvdata(dev, NULL);
 	return 0;
 }
 
-#define GUSEXTREME_DRIVER	"snd_gusextreme"
-
-static struct platform_driver snd_gusextreme_driver = {
+static struct isa_driver snd_gusextreme_driver = {
+	.match		= snd_gusextreme_match,
 	.probe		= snd_gusextreme_probe,
 	.remove		= snd_gusextreme_remove,
-	/* FIXME: suspend/resume */
+#if 0	/* FIXME */
+	.suspend	= snd_gusextreme_suspend,
+	.resume		= snd_gusextreme_resume,
+#endif
 	.driver		= {
-		.name	= GUSEXTREME_DRIVER
-	},
+		.name	= DEV_NAME
+	}
 };
 
-static void __init_or_module snd_gusextreme_unregister_all(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(devices); ++i)
-		platform_device_unregister(devices[i]);
-	platform_driver_unregister(&snd_gusextreme_driver);
-}
-
 static int __init alsa_card_gusextreme_init(void)
 {
-	int i, cards, err;
-
-	err = platform_driver_register(&snd_gusextreme_driver);
-	if (err < 0)
-		return err;
-
-	cards = 0;
-	for (i = 0; i < SNDRV_CARDS; i++) {
-		struct platform_device *device;
-		if (! enable[i])
-			continue;
-		device = platform_device_register_simple(GUSEXTREME_DRIVER,
-							 i, NULL, 0);
-		if (IS_ERR(device))
-			continue;
-		if (!platform_get_drvdata(device)) {
-			platform_device_unregister(device);
-			continue;
-		}
-		devices[i] = device;
-		cards++;
-	}
-	if (!cards) {
-#ifdef MODULE
-		printk(KERN_ERR "GUS Extreme soundcard not found or device busy\n");
-#endif
-		snd_gusextreme_unregister_all();
-		return -ENODEV;
-	}
-	return 0;
+	return isa_register_driver(&snd_gusextreme_driver, SNDRV_CARDS);
 }
 
 static void __exit alsa_card_gusextreme_exit(void)
 {
-	snd_gusextreme_unregister_all();
+	isa_unregister_driver(&snd_gusextreme_driver);
 }
 
-module_init(alsa_card_gusextreme_init)
-module_exit(alsa_card_gusextreme_exit)
+module_init(alsa_card_gusextreme_init);
+module_exit(alsa_card_gusextreme_exit);

--------------080807000209010609020202
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------080807000209010609020202
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------080807000209010609020202--
