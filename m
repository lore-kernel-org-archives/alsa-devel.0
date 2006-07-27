From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: ESS ES1869 integrated in notebook - PnP not working
Date: Thu, 27 Jul 2006 22:00:18 +0200
Message-ID: <200607272200.18993.linux@rainbow-software.org>
References: <200607231421.12286.linux@rainbow-software.org>
	<s5hmzavp17l.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailhub3.nextra.sk (smtp3.nextra.sk [195.168.1.142])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6CB24238
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Jul 2006 22:00:35 +0200 (MEST)
In-Reply-To: <s5hmzavp17l.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 27 July 2006 16:33, Takashi Iwai wrote:
> At Sun, 23 Jul 2006 14:21:12 +0200,
>
> Ondrej Zary wrote:
> > Hello,
> > I have DTK notebook with integrated ESS ES1869 sound. The problem is that
> > PnP does not work with ALSA driver and I have to use isaspnp=0 parameter.
> > The card probably does not have its own EEPROM and its 3 IDs are inserted
> > into system BIOS (as it's not found by ISA PNP but found by PNP BIOS).
> > lspnp shows:
> > [...]
> > 00:18 ESS0006 (unknown)
> > 00:19 ESS001 (unknown)
> > 00:1a ESS1869 (unknown)
> >
> > I think that the problem is caused by es18xx.c which uses
> > pnp_register_card_driver() and other pnp_card things which probably do
> > not work when the PnP device does not look like ISA card but like 3 PnP
> > devices.
>
> Right, only a few drivers support the PnP BIOS (non ISA PnP).
> Actually, it shouldn't be too hard to add that feature.  For example,
> see opl3sa2.c.  There are opl3sa2_pnpc_driver and opl3sa2_pnp_driver.
> The latter is for PnP BIOS.

Thanks for hint. I looked at opl3sa2.c and cs4236.c and added PnP BIOS support 
to es18xx.c. It works for me. Hopefully I didn't break ISA PnP support as I 
don't have hardware to test that (I had ES1868 card but gave it to friend 
some time ago).


--- linux-2.6.17.5-orig/sound/isa/es18xx.c	2006-07-15 04:38:43.000000000 +0200
+++ linux-2.6.17.5/sound/isa/es18xx.c	2006-07-28 19:40:34.000000000 +0200
@@ -2038,7 +2038,80 @@
 static struct platform_device *platform_devices[SNDRV_CARDS];
 
 #ifdef CONFIG_PNP
-static int pnp_registered;
+static int pnp_registered, pnpc_registered;
+
+static struct pnp_device_id snd_audiodrive_pnpbiosids[] = {
+	{ .id = "ESS1869" },
+	{ .id = "" }		/* end */
+};
+
+MODULE_DEVICE_TABLE(pnp, snd_audiodrive_pnpbiosids);
+
+/* PnP main device initialization */
+static int __devinit snd_audiodrive_pnp_init_main(int dev, struct pnp_dev *pdev,
+						  struct pnp_resource_table *cfg)
+{
+	int err;
+
+	pnp_init_resource_table(cfg);
+	if (port[dev] != SNDRV_AUTO_PORT)
+		pnp_resource_change(&cfg->port_resource[0], port[dev], 16);
+	if (fm_port[dev] != SNDRV_AUTO_PORT)
+		pnp_resource_change(&cfg->port_resource[1], fm_port[dev], 4);
+	if (mpu_port[dev] != SNDRV_AUTO_PORT)
+		pnp_resource_change(&cfg->port_resource[2], mpu_port[dev], 2);
+	if (dma1[dev] != SNDRV_AUTO_DMA)
+		pnp_resource_change(&cfg->dma_resource[0], dma1[dev], 1);
+	if (dma2[dev] != SNDRV_AUTO_DMA)
+		pnp_resource_change(&cfg->dma_resource[1], dma2[dev], 1);
+	if (irq[dev] != SNDRV_AUTO_IRQ)
+		pnp_resource_change(&cfg->irq_resource[0], irq[dev], 1);
+	if (pnp_device_is_isapnp(pdev)) {
+		err = pnp_manual_config_dev(pdev, cfg, 0);
+		if (err < 0)
+			snd_printk(KERN_ERR PFX "PnP manual resources are invalid, using auto config\n");
+	}
+	err = pnp_activate_dev(pdev);
+	if (err < 0) {
+		snd_printk(KERN_ERR PFX "PnP configure failure (out of resources?)\n");
+		return -EBUSY;
+	}
+	/* ok. hack using Vendor-Defined Card-Level registers */
+	/* skip csn and logdev initialization - already done in isapnp_configure */
+	if (pnp_device_is_isapnp(pdev)) {
+		isapnp_cfg_begin(isapnp_card_number(pdev), isapnp_csn_number(pdev));
+		isapnp_write_byte(0x27, pnp_irq(pdev, 0));	/* Hardware Volume IRQ Number */
+		if (mpu_port[dev] != SNDRV_AUTO_PORT)
+			isapnp_write_byte(0x28, pnp_irq(pdev, 0)); /* MPU-401 IRQ Number */
+		isapnp_write_byte(0x72, pnp_irq(pdev, 0));	/* second IRQ */
+		isapnp_cfg_end();
+	}
+	port[dev] = pnp_port_start(pdev, 0);
+	fm_port[dev] = pnp_port_start(pdev, 1);
+	mpu_port[dev] = pnp_port_start(pdev, 2);
+	dma1[dev] = pnp_dma(pdev, 0);
+	dma2[dev] = pnp_dma(pdev, 1);
+	irq[dev] = pnp_irq(pdev, 0);
+	snd_printdd("PnP ES18xx: port=0x%lx, fm port=0x%lx, mpu port=0x%lx\n", port[dev], fm_port[dev], mpu_port[dev]);
+	snd_printdd("PnP ES18xx: dma1=%i, dma2=%i, irq=%i\n", dma1[dev], dma2[dev], irq[dev]);
+	return 0;
+}
+
+static int __devinit snd_audiodrive_pnp(int dev, struct snd_audiodrive *acard,
+					struct pnp_dev *pdev)
+{
+	struct pnp_resource_table * cfg = kmalloc(sizeof(struct pnp_resource_table), GFP_KERNEL);
+
+	if (!cfg)
+		return -ENOMEM;
+	acard->dev = pdev;
+	if (snd_audiodrive_pnp_init_main(dev, acard->dev, cfg) < 0) {
+		kfree(cfg);
+		return -EBUSY;
+	}
+	kfree(cfg);
+	return 0;
+}
 
 static struct pnp_card_device_id snd_audiodrive_pnpids[] = {
 	/* ESS 1868 (integrated on Compaq dual P-Pro motherboard and Genius 18PnP 3D) */
@@ -2061,13 +2134,11 @@
 
 MODULE_DEVICE_TABLE(pnp_card, snd_audiodrive_pnpids);
 
-static int __devinit snd_audiodrive_pnp(int dev, struct snd_audiodrive *acard,
+static int __devinit snd_audiodrive_pnpc(int dev, struct snd_audiodrive *acard,
 					struct pnp_card_link *card,
 					const struct pnp_card_device_id *id)
 {
-	struct pnp_dev *pdev;
 	struct pnp_resource_table * cfg = kmalloc(sizeof(struct pnp_resource_table), GFP_KERNEL);
-	int err;
 
 	if (!cfg)
 		return -ENOMEM;
@@ -2082,57 +2153,15 @@
 		return -EBUSY;
 	}
 	/* Control port initialization */
-	err = pnp_activate_dev(acard->devc);
-	if (err < 0) {
+	if (pnp_activate_dev(acard->devc) < 0) {
 		snd_printk(KERN_ERR PFX "PnP control configure failure (out of resources?)\n");
-		kfree(cfg);
 		return -EAGAIN;
 	}
-	snd_printdd("pnp: port=0x%lx\n", pnp_port_start(acard->devc, 0));
-	/* PnP initialization */
-	pdev = acard->dev;
-	pnp_init_resource_table(cfg);
-	if (port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[0], port[dev], 16);
-	if (fm_port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[1], fm_port[dev], 4);
-	if (mpu_port[dev] != SNDRV_AUTO_PORT)
-		pnp_resource_change(&cfg->port_resource[2], mpu_port[dev], 2);
-	if (dma1[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[0], dma1[dev], 1);
-	if (dma2[dev] != SNDRV_AUTO_DMA)
-		pnp_resource_change(&cfg->dma_resource[1], dma2[dev], 1);
-	if (irq[dev] != SNDRV_AUTO_IRQ)
-		pnp_resource_change(&cfg->irq_resource[0], irq[dev], 1);
-	err = pnp_manual_config_dev(pdev, cfg, 0);
-	if (err < 0)
-		snd_printk(KERN_ERR PFX "PnP manual resources are invalid, using auto config\n");
-	err = pnp_activate_dev(pdev);
-	if (err < 0) {
-		snd_printk(KERN_ERR PFX "PnP configure failure (out of resources?)\n");
+	snd_printdd("pnp: port=0x%lx\n", pnp_port_start(pdev, 0));
+	if (snd_audiodrive_pnp_init_main(dev, acard->dev, cfg) < 0) {
 		kfree(cfg);
 		return -EBUSY;
 	}
-	/* ok. hack using Vendor-Defined Card-Level registers */
-	/* skip csn and logdev initialization - already done in isapnp_configure */
-	if (pnp_device_is_isapnp(pdev)) {
-		isapnp_cfg_begin(isapnp_card_number(pdev), isapnp_csn_number(pdev));
-		isapnp_write_byte(0x27, pnp_irq(pdev, 0));	/* Hardware Volume IRQ Number */
-		if (mpu_port[dev] != SNDRV_AUTO_PORT)
-			isapnp_write_byte(0x28, pnp_irq(pdev, 0)); /* MPU-401 IRQ Number */
-		isapnp_write_byte(0x72, pnp_irq(pdev, 0));	/* second IRQ */
-		isapnp_cfg_end();
-	} else {
-		snd_printk(KERN_ERR PFX "unable to install ISA PnP hack, expect malfunction\n");
-	}
-	port[dev] = pnp_port_start(pdev, 0);
-	fm_port[dev] = pnp_port_start(pdev, 1);
-	mpu_port[dev] = pnp_port_start(pdev, 2);
-	dma1[dev] = pnp_dma(pdev, 0);
-	dma2[dev] = pnp_dma(pdev, 1);
-	irq[dev] = pnp_irq(pdev, 0);
-	snd_printdd("PnP ES18xx: port=0x%lx, fm port=0x%lx, mpu port=0x%lx\n", port[dev], fm_port[dev], mpu_port[dev]);
-	snd_printdd("PnP ES18xx: dma1=%i, dma2=%i, irq=%i\n", dma1[dev], dma2[dev], irq[dev]);
 	kfree(cfg);
 	return 0;
 }
@@ -2301,7 +2330,69 @@
 #ifdef CONFIG_PNP
 static unsigned int __devinitdata es18xx_pnp_devices;
 
-static int __devinit snd_audiodrive_pnp_detect(struct pnp_card_link *pcard,
+static int __devinit snd_audiodrive_pnp_detect(struct pnp_dev *pdev,
+					    const struct pnp_device_id *id)
+{
+	static int dev;
+	int err;
+	struct snd_card *card;
+
+	if (pnp_device_is_isapnp(pdev))
+		return -ENOENT;	/* we have another procedure - card */
+	for (; dev < SNDRV_CARDS; dev++) {
+		if (enable[dev] && isapnp[dev])
+			break;
+	}
+	if (dev >= SNDRV_CARDS)
+		return -ENODEV;
+
+	card = snd_es18xx_card_new(dev);
+	if (! card)
+		return -ENOMEM;
+	if ((err = snd_audiodrive_pnp(dev, card->private_data, pdev)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+	snd_card_set_dev(card, &pdev->dev);
+	if ((err = snd_audiodrive_probe(card, dev)) < 0) {
+		snd_card_free(card);
+		return err;
+	}
+	pnp_set_drvdata(pdev, card);
+	dev++;
+	es18xx_pnp_devices++;
+	return 0;
+}
+
+static void __devexit snd_audiodrive_pnp_remove(struct pnp_dev * pdev)
+{
+	snd_card_free(pnp_get_drvdata(pdev));
+	pnp_set_drvdata(pdev, NULL);
+}
+
+#ifdef CONFIG_PM
+static int snd_audiodrive_pnp_suspend(struct pnp_dev *pdev, pm_message_t state)
+{
+	return snd_es18xx_suspend(pnp_get_drvdata(pdev), state);
+}
+static int snd_audiodrive_pnp_resume(struct pnp_dev *pdev)
+{
+	return snd_es18xx_resume(pnp_get_drvdata(pdev));
+}
+#endif
+
+static struct pnp_driver es18xx_pnp_driver = {
+	.name = "es18xx-pnpbios",
+	.id_table = snd_audiodrive_pnpbiosids,
+	.probe = snd_audiodrive_pnp_detect,
+	.remove = __devexit_p(snd_audiodrive_pnp_remove),
+#ifdef CONFIG_PM
+	.suspend = snd_audiodrive_pnp_suspend,
+	.resume = snd_audiodrive_pnp_resume,
+#endif
+};
+
+static int __devinit snd_audiodrive_pnpc_detect(struct pnp_card_link *pcard,
 					       const struct pnp_card_device_id *pid)
 {
 	static int dev;
@@ -2319,7 +2410,7 @@
 	if (! card)
 		return -ENOMEM;
 
-	if ((res = snd_audiodrive_pnp(dev, card->private_data, pcard, pid)) < 0) {
+	if ((res = snd_audiodrive_pnpc(dev, card->private_data, pcard, pid)) < 0) {
 		snd_card_free(card);
 		return res;
 	}
@@ -2335,19 +2426,19 @@
 	return 0;
 }
 
-static void __devexit snd_audiodrive_pnp_remove(struct pnp_card_link * pcard)
+static void __devexit snd_audiodrive_pnpc_remove(struct pnp_card_link * pcard)
 {
 	snd_card_free(pnp_get_card_drvdata(pcard));
 	pnp_set_card_drvdata(pcard, NULL);
 }
 
 #ifdef CONFIG_PM
-static int snd_audiodrive_pnp_suspend(struct pnp_card_link *pcard, pm_message_t state)
+static int snd_audiodrive_pnpc_suspend(struct pnp_card_link *pcard, pm_message_t state)
 {
 	return snd_es18xx_suspend(pnp_get_card_drvdata(pcard), state);
 }
 
-static int snd_audiodrive_pnp_resume(struct pnp_card_link *pcard)
+static int snd_audiodrive_pnpc_resume(struct pnp_card_link *pcard)
 {
 	return snd_es18xx_resume(pnp_get_card_drvdata(pcard));
 }
@@ -2358,11 +2449,11 @@
 	.flags = PNP_DRIVER_RES_DISABLE,
 	.name = "es18xx",
 	.id_table = snd_audiodrive_pnpids,
-	.probe = snd_audiodrive_pnp_detect,
-	.remove = __devexit_p(snd_audiodrive_pnp_remove),
+	.probe = snd_audiodrive_pnpc_detect,
+	.remove = __devexit_p(snd_audiodrive_pnpc_remove),
 #ifdef CONFIG_PM
-	.suspend	= snd_audiodrive_pnp_suspend,
-	.resume		= snd_audiodrive_pnp_resume,
+	.suspend	= snd_audiodrive_pnpc_suspend,
+	.resume		= snd_audiodrive_pnpc_resume,
 #endif
 };
 #endif /* CONFIG_PNP */
@@ -2372,8 +2463,10 @@
 	int i;
 
 #ifdef CONFIG_PNP
-	if (pnp_registered)
+	if (pnpc_registered)
 		pnp_unregister_card_driver(&es18xx_pnpc_driver);
+	if (pnp_registered)
+		pnp_unregister_driver(&es18xx_pnp_driver);
 #endif
 	for (i = 0; i < ARRAY_SIZE(platform_devices); ++i)
 		platform_device_unregister(platform_devices[i]);
@@ -2404,9 +2497,12 @@
 	}
 
 #ifdef CONFIG_PNP
+	err = pnp_register_driver(&es18xx_pnp_driver);
+	if (!err)
+		pnp_registered = 1;
 	err = pnp_register_card_driver(&es18xx_pnpc_driver);
 	if (!err) {
-		pnp_registered = 1;
+		pnpc_registered = 1;
 		cards += es18xx_pnp_devices;
 	}
 #endif


-- 
Ondrej Zary

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
