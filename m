From: Jeff Muizelaar <muizelaar@rogers.com>
Subject: [PATCH 6/6] au88x0: comment and whitespace cleanup
Date: Sun, 24 Oct 2004 18:09:52 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041024220954.15687.40769.24229@pluton>
References: <20041024220909.15687.40786.20603@pluton>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from simmts12-srv.bellnexxia.net (simmts12.bellnexxia.net [206.47.199.141])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7864D283
	for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2004 00:09:53 +0200 (MEST)
In-Reply-To: <20041024220909.15687.40786.20603@pluton>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: openvortex-dev@nongnu.org, Jeff Muizelaar <muizelaar@rogers.com>
List-Id: alsa-devel@alsa-project.org

Remove an obsolete comment and cleanup up some whitespace a bit

Signed-off-by: Jeff Muizelaar <muizelaar@rogers.com>

diff -ur name/sound/pci/au88x0/au88x0.c working/sound/pci/au88x0/au88x0.c
--- name/sound/pci/au88x0/au88x0.c	2004-10-23 21:07:23 -0400
+++ working/sound/pci/au88x0/au88x0.c	2004-10-23 21:47:43 -0400
@@ -170,9 +170,8 @@
 	if ((err = pci_request_regions(pci, CARD_NAME_SHORT)) != 0)
 		goto regions_out;
 
-	chip->mmio =
-	    ioremap_nocache(pci_resource_start(pci, 0),
-			    pci_resource_len(pci, 0));
+	chip->mmio = ioremap_nocache(pci_resource_start(pci, 0),
+	                             pci_resource_len(pci, 0));
 	if (!chip->mmio) {
 		printk(KERN_ERR "MMIO area remap failed.\n");
 		err = -ENOMEM;
@@ -187,10 +186,9 @@
 		goto core_out;
 	}
 
-	if ((err =
-	     request_irq(pci->irq, vortex_interrupt,
-			 SA_INTERRUPT | SA_SHIRQ, CARD_NAME_SHORT,
-			 (void *)chip)) != 0) {
+	if ((err = request_irq(pci->irq, vortex_interrupt,
+	                       SA_INTERRUPT | SA_SHIRQ, CARD_NAME_SHORT,
+	                       chip)) != 0) {
 		printk(KERN_ERR "cannot grab irq\n");
 		goto irq_out;
 	}
@@ -214,7 +212,6 @@
       irq_out:
 	vortex_core_shutdown(chip);
       core_out:
-	//FIXME: the type of chip->mmio might need to be changed??
 	iounmap(chip->mmio);
       ioremap_out:
 	pci_release_regions(chip->pci_dev);


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
