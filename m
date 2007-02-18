From: Rene Herman <rene.herman@gmail.com>
Subject: isa_bus: gusclassic
Date: Sun, 18 Feb 2007 20:51:46 +0100
Message-ID: <45D8AE52.5000703@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010204040200090905010306"
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
--------------010204040200090905010306
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Good day.

This time with patch attached...

===
gusclassic: port to isa_bus infrastructure

Signed-off-by: Rene Herman <rene.herman@gmail.com>
===

snd_gusclassic_init() is no more -- the flags are already initialized to
0 as part of the snd_gus_card structure itself and while I sort of
expect that the C standard won't have many positive things to say about
initializing bitfields through a kzalloc(), the code relies on this for
other flags as well. The joystick_dac value is set directly in probe()
now (I saw it's the same in all gus variants so should probably at some
point be moved to snd_gus_create).

This has been tested, and works the same as before, which is to say not
quite right.

It plays okay through ALSA's OSS emulation, but native ALSA complains:

   ALSA lib pcm.c:2017:(snd_pcm_open_conf) Invalid type for PCM
   default definition (id: default, value: cards.pcm.default)
   ALSA snd_pcm_open error: Invalid argument

Using "hw:0" gets:

   ALSA snd_pcm_hw_params_set_access error: Invalid argument

and "plughw:0" gets:

   ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to
   find an usable access for 'plughw:0'
   ALSA snd_pcm_hw_params_set_access error: Invalid argument

Although I'm familiar with the ALSA kernel side, I can't say the same
about the userland or the interaction between the two and this looks
like it might be a problem at that level. So I thought I'd just ask
you... ;-)

(but as said, patch is good to go)

Rene.


--------------010204040200090905010306
Content-Type: text/plain;
 name="gusclassic.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gusclassic.diff"

diff --git a/sound/isa/gus/gusclassic.c b/sound/isa/gus/gusclassic.c
index 37057a3..8f23f43 100644
--- a/sound/isa/gus/gusclassic.c
+++ b/sound/isa/gus/gusclassic.c
@@ -22,7 +22,7 @@
 #include <sound/driver.h>
 #include <linux/init.h>
 #include <linux/err.h>
-#include <linux/platform_device.h>
+#include <linux/isa.h>
 #include <linux/delay.h>
 #include <linux/time.h>
 #include <linux/moduleparam.h>
@@ -33,8 +33,11 @@ #define SNDRV_LEGACY_FIND_FREE_IRQ
 #define SNDRV_LEGACY_FIND_FREE_DMA
 #include <sound/initval.h>
 
+#define CRD_NAME "Gravis UltraSound Classic"
+#define DEV_NAME "gusclassic"
+
+MODULE_DESCRIPTION(CRD_NAME);
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
-MODULE_DESCRIPTION("Gravis UltraSound Classic");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Gravis,UltraSound Classic}}");
 
@@ -51,32 +54,80 @@ static int channels[SNDRV_CARDS] = {[0 .
 static int pcm_channels[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 2};
 
 module_param_array(index, int, NULL, 0444);
-MODULE_PARM_DESC(index, "Index value for GUS Classic soundcard.");
+MODULE_PARM_DESC(index, "Index value for " CRD_NAME " soundcard.");
 module_param_array(id, charp, NULL, 0444);
-MODULE_PARM_DESC(id, "ID string for GUS Classic soundcard.");
+MODULE_PARM_DESC(id, "ID string for " CRD_NAME " soundcard.");
 module_param_array(enable, bool, NULL, 0444);
-MODULE_PARM_DESC(enable, "Enable GUS Classic soundcard.");
+MODULE_PARM_DESC(enable, "Enable " CRD_NAME " soundcard.");
 module_param_array(port, long, NULL, 0444);
-MODULE_PARM_DESC(port, "Port # for GUS Classic driver.");
+MODULE_PARM_DESC(port, "Port # for " CRD_NAME " driver.");
 module_param_array(irq, int, NULL, 0444);
-MODULE_PARM_DESC(irq, "IRQ # for GUS Classic driver.");
+MODULE_PARM_DESC(irq, "IRQ # for " CRD_NAME " driver.");
 module_param_array(dma1, int, NULL, 0444);
-MODULE_PARM_DESC(dma1, "DMA1 # for GUS Classic driver.");
+MODULE_PARM_DESC(dma1, "DMA1 # for " CRD_NAME " driver.");
 module_param_array(dma2, int, NULL, 0444);
-MODULE_PARM_DESC(dma2, "DMA2 # for GUS Classic driver.");
+MODULE_PARM_DESC(dma2, "DMA2 # for " CRD_NAME " driver.");
 module_param_array(joystick_dac, int, NULL, 0444);
-MODULE_PARM_DESC(joystick_dac, "Joystick DAC level 0.59V-4.52V or 0.389V-2.98V for GUS Classic driver.");
+MODULE_PARM_DESC(joystick_dac, "Joystick DAC level 0.59V-4.52V or 0.389V-2.98V for " CRD_NAME " driver.");
 module_param_array(channels, int, NULL, 0444);
-MODULE_PARM_DESC(channels, "GF1 channels for GUS Classic driver.");
+MODULE_PARM_DESC(channels, "GF1 channels for " CRD_NAME " driver.");
 module_param_array(pcm_channels, int, NULL, 0444);
-MODULE_PARM_DESC(pcm_channels, "Reserved PCM channels for GUS Classic driver.");
+MODULE_PARM_DESC(pcm_channels, "Reserved PCM channels for " CRD_NAME " driver.");
+
+static int __devinit snd_gusclassic_match(struct device *dev, unsigned int n)
+{
+	return enable[n];
+}
+
+static int __devinit snd_gusclassic_create(struct snd_card *card,
+		struct device *dev, unsigned int n, struct snd_gus_card **rgus)
+{
+	static long possible_ports[] = {0x220, 0x230, 0x240, 0x250, 0x260};
+	static int possible_irqs[] = {5, 11, 12, 9, 7, 15, 3, 4, -1};
+	static int possible_dmas[] = {5, 6, 7, 1, 3, -1};
+
+	int i, error;
+
+	if (irq[n] == SNDRV_AUTO_IRQ) {
+		irq[n] = snd_legacy_find_free_irq(possible_irqs);
+		if (irq[n] < 0) {
+			snd_printk(KERN_ERR "%s: unable to find a free IRQ\n",
+				dev->bus_id);
+			return -EBUSY;
+		}
+	}
+	if (dma1[n] == SNDRV_AUTO_DMA) {
+		dma1[n] = snd_legacy_find_free_dma(possible_dmas);
+		if (dma1[n] < 0) {
+			snd_printk(KERN_ERR "%s: unable to find a free DMA1\n",
+				dev->bus_id);
+			return -EBUSY;
+		}
+	}
+	if (dma2[n] == SNDRV_AUTO_DMA) {
+		dma2[n] = snd_legacy_find_free_dma(possible_dmas);
+		if (dma2[n] < 0) {
+			snd_printk(KERN_ERR "%s: unable to find a free DMA2\n",
+				dev->bus_id);
+			return -EBUSY;
+		}
+	}
 
-static struct platform_device *devices[SNDRV_CARDS];
+	if (port[n] != SNDRV_AUTO_PORT)
+		return snd_gus_create(card, port[n], irq[n], dma1[n], dma2[n],
+				0, channels[n], pcm_channels[n], 0, rgus);
 
+	i = 0;
+	do {
+		port[n] = possible_ports[i];
+		error = snd_gus_create(card, port[n], irq[n], dma1[n], dma2[n],
+				0, channels[n], pcm_channels[n], 0, rgus);
+	} while (error < 0 && ++i < ARRAY_SIZE(possible_ports));
 
-#define PFX	"gusclassic: "
+	return error;
+}
 
-static int __init snd_gusclassic_detect(struct snd_gus_card * gus)
+static int __devinit snd_gusclassic_detect(struct snd_gus_card *gus)
 {
 	unsigned char d;
 
@@ -95,187 +146,104 @@ static int __init snd_gusclassic_detect(
 	return 0;
 }
 
-static void __init snd_gusclassic_init(int dev, struct snd_gus_card * gus)
-{
-	gus->equal_irq = 0;
-	gus->codec_flag = 0;
-	gus->max_flag = 0;
-	gus->joystick_dac = joystick_dac[dev];
-}
-
-static int __init snd_gusclassic_probe(struct platform_device *pdev)
+static int __devinit snd_gusclassic_probe(struct device *dev, unsigned int n)
 {
-	int dev = pdev->id;
-	static int possible_irqs[] = {5, 11, 12, 9, 7, 15, 3, 4, -1};
-	static int possible_dmas[] = {5, 6, 7, 1, 3, -1};
-	int xirq, xdma1, xdma2;
 	struct snd_card *card;
-	struct snd_gus_card *gus = NULL;
-	int err;
-
-	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
-	if (card == NULL)
-		return -ENOMEM;
-	if (pcm_channels[dev] < 2)
-		pcm_channels[dev] = 2;
-
-	xirq = irq[dev];
-	if (xirq == SNDRV_AUTO_IRQ) {
-		if ((xirq = snd_legacy_find_free_irq(possible_irqs)) < 0) {
-			snd_printk(KERN_ERR PFX "unable to find a free IRQ\n");
-			err = -EBUSY;
-			goto _err;
-		}
-	}
-	xdma1 = dma1[dev];
-	if (xdma1 == SNDRV_AUTO_DMA) {
-		if ((xdma1 = snd_legacy_find_free_dma(possible_dmas)) < 0) {
-			snd_printk(KERN_ERR PFX "unable to find a free DMA1\n");
-			err = -EBUSY;
-			goto _err;
-		}
-	}
-	xdma2 = dma2[dev];
-	if (xdma2 == SNDRV_AUTO_DMA) {
-		if ((xdma2 = snd_legacy_find_free_dma(possible_dmas)) < 0) {
-			snd_printk(KERN_ERR PFX "unable to find a free DMA2\n");
-			err = -EBUSY;
-			goto _err;
-		}
-	}
+	struct snd_gus_card *gus;
+	int error;
 
-	if (port[dev] != SNDRV_AUTO_PORT) {
-		err = snd_gus_create(card,
-				     port[dev],
-				     xirq, xdma1, xdma2,
-				     0, channels[dev], pcm_channels[dev],
-				     0, &gus);
-	} else {
-		/* auto-probe legacy ports */
-		static unsigned long possible_ports[] = {
-			0x220, 0x230, 0x240, 0x250, 0x260,
-		};
-		int i;
-		for (i = 0; i < ARRAY_SIZE(possible_ports); i++) {
-			err = snd_gus_create(card,
-					     possible_ports[i],
-					     xirq, xdma1, xdma2,
-					     0, channels[dev], pcm_channels[dev],
-					     0, &gus);
-			if (err >= 0) {
-				port[dev] = possible_ports[i];
-				break;
-			}
-		}
-	}
-	if (err < 0)
-		goto _err;
+	card = snd_card_new(index[n], id[n], THIS_MODULE, 0);
+	if (!card)
+		return -EINVAL;
 
-	if ((err = snd_gusclassic_detect(gus)) < 0)
-		goto _err;
+	if (pcm_channels[n] < 2)
+		pcm_channels[n] = 2;
 
-	snd_gusclassic_init(dev, gus);
-	if ((err = snd_gus_initialize(gus)) < 0)
-		goto _err;
+	error = snd_gusclassic_create(card, dev, n, &gus);
+	if (error < 0)
+		goto out;
 
+	error = snd_gusclassic_detect(gus);
+	if (error < 0)
+		goto out;
+
+	gus->joystick_dac = joystick_dac[n];
+
+	error = snd_gus_initialize(gus);
+	if (error < 0)
+		goto out;
+
+	error = -ENODEV;
 	if (gus->max_flag || gus->ess_flag) {
-		snd_printk(KERN_ERR PFX "GUS Classic or ACE soundcard was not detected at 0x%lx\n", gus->gf1.port);
-		err = -ENODEV;
-		goto _err;
+		snd_printk(KERN_ERR "%s: GUS Classic or ACE soundcard was "
+			"not detected at 0x%lx\n", dev->bus_id, gus->gf1.port);
+		goto out;
 	}
 
-	if ((err = snd_gf1_new_mixer(gus)) < 0)
-		goto _err;
+	error = snd_gf1_new_mixer(gus);
+	if (error < 0)
+		goto out;
 
-	if ((err = snd_gf1_pcm_new(gus, 0, 0, NULL)) < 0)
-		goto _err;
+	error = snd_gf1_pcm_new(gus, 0, 0, NULL);
+	if (error < 0)
+		goto out;
 
 	if (!gus->ace_flag) {
-		if ((err = snd_gf1_rawmidi_new(gus, 0, NULL)) < 0)
-			goto _err;
+		error = snd_gf1_rawmidi_new(gus, 0, NULL);
+		if (error < 0)
+			goto out;
 	}
-	sprintf(card->longname + strlen(card->longname), " at 0x%lx, irq %d, dma %d", gus->gf1.port, xirq, xdma1);
-	if (xdma2 >= 0)
-		sprintf(card->longname + strlen(card->longname), "&%d", xdma2);
 
-	snd_card_set_dev(card, &pdev->dev);
+	sprintf(card->longname + strlen(card->longname),
+		" at 0x%lx, irq %d, dma %d",
+		gus->gf1.port, gus->gf1.irq, gus->gf1.dma1);
 
-	if ((err = snd_card_register(card)) < 0)
-		goto _err;
+	if (gus->gf1.dma2 >= 0)
+		sprintf(card->longname + strlen(card->longname),
+			"&%d", gus->gf1.dma2);
 
-	platform_set_drvdata(pdev, card);
+	snd_card_set_dev(card, dev);
+
+	error = snd_card_register(card);
+	if (error < 0)
+		goto out;
+
+	dev_set_drvdata(dev, card);
 	return 0;
 
- _err:
-	snd_card_free(card);
-	return err;
+out:	snd_card_free(card);
+	return error;
 }
 
-static int snd_gusclassic_remove(struct platform_device *devptr)
+static int __devexit snd_gusclassic_remove(struct device *dev, unsigned int n)
 {
-	snd_card_free(platform_get_drvdata(devptr));
-	platform_set_drvdata(devptr, NULL);
+	snd_card_free(dev_get_drvdata(dev));
+	dev_set_drvdata(dev, NULL);
 	return 0;
 }
 
-#define GUSCLASSIC_DRIVER	"snd_gusclassic"
-
-static struct platform_driver snd_gusclassic_driver = {
+static struct isa_driver snd_gusclassic_driver = {
+	.match		= snd_gusclassic_match,
 	.probe		= snd_gusclassic_probe,
+	.remove		= __devexit_p(snd_gusclassic_remove),
+#if 0	/* FIXME */
+	.suspend	= snd_gusclassic_suspend,
 	.remove		= snd_gusclassic_remove,
-	/* FIXME: suspend/resume */
+#endif
 	.driver		= {
-		.name	= GUSCLASSIC_DRIVER
-	},
+		.name	= DEV_NAME
+	}
 };
 
-static void __init_or_module snd_gusclassic_unregister_all(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(devices); ++i)
-		platform_device_unregister(devices[i]);
-	platform_driver_unregister(&snd_gusclassic_driver);
-}
-
 static int __init alsa_card_gusclassic_init(void)
 {
-	int i, cards, err;
-
-	err = platform_driver_register(&snd_gusclassic_driver);
-	if (err < 0)
-		return err;
-
-	cards = 0;
-	for (i = 0; i < SNDRV_CARDS; i++) {
-		struct platform_device *device;
-		if (! enable[i])
-			continue;
-		device = platform_device_register_simple(GUSCLASSIC_DRIVER,
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
-		printk(KERN_ERR "GUS Classic soundcard not found or device busy\n");
-#endif
-		snd_gusclassic_unregister_all();
-		return -ENODEV;
-	}
-	return 0;
+	return isa_register_driver(&snd_gusclassic_driver, SNDRV_CARDS);
 }
 
 static void __exit alsa_card_gusclassic_exit(void)
 {
-	snd_gusclassic_unregister_all();
+	isa_unregister_driver(&snd_gusclassic_driver);
 }
 
-module_init(alsa_card_gusclassic_init)
-module_exit(alsa_card_gusclassic_exit)
+module_init(alsa_card_gusclassic_init);
+module_exit(alsa_card_gusclassic_exit);

--------------010204040200090905010306
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------010204040200090905010306
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------010204040200090905010306--
