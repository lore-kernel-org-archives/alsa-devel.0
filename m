From: Stephen Hemminger <shemminger@osdl.org>
Subject: [PATCH] intel_hda: MSI support
Date: Tue, 15 Aug 2006 15:41:29 -0700
Message-ID: <20060815154129.14f82415@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7DA62165
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Aug 2006 00:41:34 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Simple patch to enable Message Signalled Interrupts for the HDA Intel
audio controller.  Tested with:
 Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 03)

MSI is better because it means audio doesn't end up sharing IRQ with USB.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

--- linux-2.6.orig/sound/pci/hda/hda_intel.c	2006-07-13 12:53:49.000000000 -0700
+++ linux-2.6/sound/pci/hda/hda_intel.c	2006-08-15 15:24:12.000000000 -0700
@@ -55,6 +55,7 @@
 static int position_fix;
 static int probe_mask = -1;
 static int single_cmd;
+static int disable_msi;
 
 module_param(index, int, 0444);
 MODULE_PARM_DESC(index, "Index value for Intel HD audio interface.");
@@ -68,6 +69,8 @@
 MODULE_PARM_DESC(probe_mask, "Bitmask to probe codecs (default = -1).");
 module_param(single_cmd, bool, 0444);
 MODULE_PARM_DESC(single_cmd, "Use single command to communicate with codecs (for debugging only).");
+module_param(disable_msi, int, 0);
+MODULE_PARM_DESC(disable_msi, "Disable Message Signaled Interrupt (MSI)");
 
 
 /* just for backward compatibility */
@@ -1402,8 +1405,10 @@
 		msleep(1);
 	}
 
-	if (chip->irq >= 0)
+	if (chip->irq >= 0) {
+		pci_disable_msi(chip->pci);
 		free_irq(chip->irq, (void*)chip);
+	}
 	if (chip->remap_addr)
 		iounmap(chip->remap_addr);
 
@@ -1486,6 +1491,9 @@
 		goto errout;
 	}
 
+	if (!disable_msi)
+		pci_enable_msi(pci);
+
 	if (request_irq(pci->irq, azx_interrupt, IRQF_DISABLED|IRQF_SHARED,
 			"HDA Intel", (void*)chip)) {
 		snd_printk(KERN_ERR SFX "unable to grab IRQ %d\n", pci->irq);

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
