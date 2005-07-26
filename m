From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] 2.6.13-rc3-git5: fix Bug #4416 (2/2)
Date: Tue, 26 Jul 2005 12:54:04 +0200
Message-ID: <200507261254.05507.rjw__36457.4233339683$1122375224$gmane$org@sisk.pl>
References: <200507261247.05684.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.sisk.pl (grendel.sisk.pl [217.67.200.140])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 075431C4
	for <alsa-devel@alsa-project.org>; Tue, 26 Jul 2005 12:52:14 +0200 (MEST)
Received: from mail.sisk.pl ([127.0.0.1])
 by localhost (grendel [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 30188-08 for <alsa-devel@alsa-project.org>;
 Tue, 26 Jul 2005 12:50:44 +0200 (CEST)
In-Reply-To: <200507261247.05684.rjw@sisk.pl>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: LKML <linux-kernel@vger.kernel.org>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The following patch adds basic suspend/resume support to the sk98lin
network driver.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

--- linux-2.6.13-rc3-git5/drivers/net/sk98lin/skge.c	2005-07-23 19:26:29.000000000 +0200
+++ patched/drivers/net/sk98lin/skge.c	2005-07-25 18:17:57.000000000 +0200
@@ -5133,6 +5133,75 @@ static void __devexit skge_remove_one(st
 	kfree(pAC);
 }
 
+#ifdef CONFIG_PM
+static int skge_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	DEV_NET *pNet = netdev_priv(dev);
+	SK_AC *pAC = pNet->pAC;
+	struct net_device *otherdev = pAC->dev[1];
+
+	if (pNet->Up) {
+		pAC->WasIfUp[0] = SK_TRUE;
+		DoPrintInterfaceChange = SK_FALSE;
+		SkDrvDeInitAdapter(pAC, 0);  /* performs SkGeClose */
+	}
+	if (otherdev != dev) {
+		pNet = netdev_priv(otherdev);
+		if (pNet->Up) {
+			pAC->WasIfUp[1] = SK_TRUE;
+			DoPrintInterfaceChange = SK_FALSE;
+			SkDrvDeInitAdapter(pAC, 1);  /* performs SkGeClose */
+		}
+	}
+
+	pci_save_state(pdev);
+	pci_enable_wake(pdev, pci_choose_state(pdev, state), 0);
+	if (pAC->AllocFlag & SK_ALLOC_IRQ) {
+		free_irq(dev->irq, dev);
+	}
+	pci_disable_device(pdev);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
+
+	return 0;
+}
+
+static int skge_resume(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	DEV_NET *pNet = netdev_priv(dev);
+	SK_AC *pAC = pNet->pAC;
+	int ret;
+
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+	pci_enable_device(pdev);
+	pci_set_master(pdev);
+	if (pAC->GIni.GIMacsFound == 2)
+		ret = request_irq(dev->irq, SkGeIsr, SA_SHIRQ, pAC->Name, dev);
+	else
+		ret = request_irq(dev->irq, SkGeIsrOnePort, SA_SHIRQ, pAC->Name, dev);
+	if (ret) {
+		printk(KERN_WARNING "sk98lin: unable to acquire IRQ %d\n", dev->irq);
+		pAC->AllocFlag &= ~SK_ALLOC_IRQ;
+		dev->irq = 0;
+		pci_disable_device(pdev);
+		return -EBUSY;
+	}
+
+	if (pAC->WasIfUp[0] == SK_TRUE) {
+		DoPrintInterfaceChange = SK_FALSE;
+		SkDrvInitAdapter(pAC, 0);    /* first device  */
+	}
+	if (pAC->dev[1] != dev && pAC->WasIfUp[1] == SK_TRUE) {
+		DoPrintInterfaceChange = SK_FALSE;
+		SkDrvInitAdapter(pAC, 1);    /* second device  */
+	}
+
+	return 0;
+}
+#endif
+
 static struct pci_device_id skge_pci_tbl[] = {
 	{ PCI_VENDOR_ID_3COM, 0x1700, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_3COM, 0x80eb, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
@@ -5158,6 +5227,8 @@ static struct pci_driver skge_driver = {
 	.id_table	= skge_pci_tbl,
 	.probe		= skge_probe_one,
 	.remove		= __devexit_p(skge_remove_one),
+	.suspend	= skge_suspend,
+	.resume		= skge_resume,
 };
 
 static int __init skge_init(void)


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
