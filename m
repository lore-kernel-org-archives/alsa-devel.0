From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: mpu401_pnp
Date: Mon, 07 Feb 2005 13:59:59 +0100
Message-ID: <4207664F.8030305@free.fr>
References: <Pine.HPX.4.33n.0502070940520.3379-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020700090906020002020007"
Received: from postfix4-1.free.fr (postfix4-1.free.fr [213.228.0.62])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8683F21A
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2005 13:59:59 +0100 (MET)
In-Reply-To: <Pine.HPX.4.33n.0502070940520.3379-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020700090906020002020007
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

attached a version more readable with less ifdef.
It is untested, but it should work.

One question : does snd_card_set_dev(card, &device->dev) is important ? 
It wasn't use with acpi.

regards,

Matthieu

--------------020700090906020002020007
Content-Type: text/x-patch;
 name="mpu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpu.patch"

--- mpu401.c?rev=1.22	2005-02-07 13:26:09.000000000 +0100
+++ mpu401.c	2005-02-07 13:55:30.000000000 +0100
@@ -57,68 +57,13 @@
 MODULE_PARM_DESC(irq, "IRQ # for MPU-401 device.");
 
 static snd_card_t *snd_mpu401_legacy_cards[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
+static int pnp_registered = 0;
 
-#ifdef CONFIG_PNP
-
-#define IO_EXTENT 2
-
-static struct pnp_device_id snd_mpu401_pnpids[] = {
-	{ .id = "PNPb006" },
-	{ .id = "" }
-};
-
-MODULE_DEVICE_TABLE(pnp, snd_mpu401_pnpids);
-
-static int __init snd_mpu401_pnp(int dev, struct pnp_dev *device,
-				 const struct pnp_device_id *id)
-{
-	if (!pnp_port_valid(device, 0) ||
-	    pnp_port_flags(device, 0) & IORESOURCE_DISABLED) {
-		snd_printk(KERN_ERR "no PnP port\n");
-		return -ENODEV;
-	}
-	if (pnp_port_len(device, 0) < IO_EXTENT) {
-		snd_printk(KERN_ERR "PnP port length is %ld, expected %d\n",
-			   pnp_port_len(device, 0), IO_EXTENT);
-		return -ENODEV;
-	}
-	port[dev] = pnp_port_start(device, 0);
-
-	if (!pnp_irq_valid(device, 0) ||
-	    pnp_irq_flags(device, 0) & IORESOURCE_DISABLED) {
-		snd_printk(KERN_WARNING "no PnP irq, using polling\n");
-		irq[dev] = -1;
-	} else {
-		irq[dev] = pnp_irq(device, 0);
-	}
-	return 0;
-}
-#endif
-
-static int __devinit snd_card_mpu401_probe(int dev, struct pnp_dev *device,
-					   const struct pnp_device_id *pnp_id)
+static int snd_card_mpu401_add(int dev)
 {
 	snd_card_t *card;
 	int err;
 
-#ifdef CONFIG_PNP
-	if (!device) {
-#endif
-		if (port[dev] == SNDRV_AUTO_PORT) {
-			snd_printk(KERN_ERR "specify port\n");
-			return -EINVAL;
-		}
-		if (irq[dev] == SNDRV_AUTO_IRQ) {
-			snd_printk(KERN_ERR "specify or disable IRQ\n");
-			return -EINVAL;
-		}
-#ifdef CONFIG_PNP
-	} else {
-		if ((err = snd_mpu401_pnp(dev, device, pnp_id)) < 0)
-			return err;
-	}
-#endif
-
 	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
 	if (card == NULL)
 		return -ENOMEM;
@@ -130,11 +75,13 @@
 	} else {
 		strcat(card->longname, "polled");
 	}
-#ifdef CONFIG_PNP
+
+	/*
 	if (device) {
 		snd_card_set_dev(card, &device->dev);
 	}
-#endif
+	*/
+
 	if (snd_mpu401_uart_new(card, 0,
 				MPU401_HW_MPU401,
 				port[dev], 0,
@@ -147,16 +94,59 @@
 		snd_card_free(card);
 		return err;
 	}
-#ifdef CONFIG_PNP
-	if (device)
-		pnp_set_drvdata(device, card);
-	else
-#endif
 		snd_mpu401_legacy_cards[dev] = card;
 	return 0;
 }
 
+static int __devinit snd_card_mpu401_probe(int dev)
+{
+	if (port[dev] == SNDRV_AUTO_PORT) {
+		snd_printk(KERN_ERR "specify port\n");
+		return -EINVAL;
+	}
+	if (irq[dev] == SNDRV_AUTO_IRQ) {
+		snd_printk(KERN_ERR "specify or disable IRQ\n");
+		return -EINVAL;
+	}
+	return snd_card_mpu401_add(dev);
+}
+
 #ifdef CONFIG_PNP
+
+#define IO_EXTENT 2
+
+static struct pnp_device_id snd_mpu401_pnpids[] = {
+	{ .id = "PNPb006" },
+	{ .id = "" }
+};
+
+MODULE_DEVICE_TABLE(pnp, snd_mpu401_pnpids);
+
+static int __init snd_mpu401_pnp(int dev, struct pnp_dev *device,
+				 const struct pnp_device_id *id)
+{
+	if (!pnp_port_valid(device, 0) ||
+	    pnp_port_flags(device, 0) & IORESOURCE_DISABLED) {
+		snd_printk(KERN_ERR "no PnP port\n");
+		return -ENODEV;
+	}
+	if (pnp_port_len(device, 0) < IO_EXTENT) {
+		snd_printk(KERN_ERR "PnP port length is %ld, expected %d\n",
+			   pnp_port_len(device, 0), IO_EXTENT);
+		return -ENODEV;
+	}
+	port[dev] = pnp_port_start(device, 0);
+
+	if (!pnp_irq_valid(device, 0) ||
+	    pnp_irq_flags(device, 0) & IORESOURCE_DISABLED) {
+		snd_printk(KERN_WARNING "no PnP irq, using polling\n");
+		irq[dev] = -1;
+	} else {
+		irq[dev] = pnp_irq(device, 0);
+	}
+	return snd_card_mpu401_add(dev);
+}
+
 static int __devinit snd_mpu401_pnp_probe(struct pnp_dev *pnp_dev,
 					  const struct pnp_device_id *id)
 {
@@ -166,9 +156,11 @@
 	for ( ; dev < SNDRV_CARDS; ++dev) {
 		if (!enable[dev] || !pnp[dev])
 			continue;
-		err = snd_card_mpu401_probe(dev, pnp_dev, id);
+		err = snd_mpu401_pnp(dev, pnp_dev, id);
 		if (err < 0)
 			return err;
+		pnp_set_drvdata(pnp_dev, snd_mpu401_legacy_cards[dev]);
+		snd_mpu401_legacy_cards[dev] = NULL;
 		++dev;
 		return 0;
 	}
@@ -189,11 +181,14 @@
 	.probe = snd_mpu401_pnp_probe,
 	.remove = __devexit_p(snd_mpu401_pnp_remove),
 };
+#else
+static struct pnp_driver snd_mpu401_pnp_driver;
 #endif
 
 static int __init alsa_card_mpu401_init(void)
 {
 	int dev, devices = 0;
+	int err;
 
 	for (dev = 0; dev < SNDRV_CARDS; dev++) {
 		if (!enable[dev])
@@ -202,19 +197,20 @@
 		if (pnp[dev])
 			continue;
 #endif
-		if (snd_card_mpu401_probe(dev, NULL, NULL) >= 0)
+		if (snd_card_mpu401_probe(dev) >= 0)
 			devices++;
 	}
-#ifdef CONFIG_PNP
-	devices += pnp_register_driver(&snd_mpu401_pnp_driver);
-#endif
+	if ((err = pnp_register_driver(&snd_mpu401_pnp_driver)) >= 0) {
+		pnp_registered = 1;
+		devices += err;
+	}
+
 	if (!devices) {
 #ifdef MODULE
 		printk(KERN_ERR "MPU-401 device not found or device busy\n");
 #endif
-#ifdef CONFIG_PNP
-		pnp_unregister_driver(&snd_mpu401_pnp_driver);
-#endif
+		if (pnp_registered)
+			pnp_unregister_driver(&snd_mpu401_pnp_driver);
 		return -ENODEV;
 	}
 	return 0;
@@ -224,9 +220,8 @@
 {
 	int idx;
 
-#ifdef CONFIG_PNP
-	pnp_unregister_driver(&snd_mpu401_pnp_driver);
-#endif
+	if (pnp_registered)
+		pnp_unregister_driver(&snd_mpu401_pnp_driver);
 	for (idx = 0; idx < SNDRV_CARDS; idx++)
 		snd_card_free(snd_mpu401_legacy_cards[idx]);
 }

--------------020700090906020002020007--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
