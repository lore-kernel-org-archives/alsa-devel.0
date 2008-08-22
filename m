From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: [PATCH 2/2] ca0106 playback 44100Hz support to SPDIF
	and playback	format & rate constraints
Date: Sat, 23 Aug 2008 00:38:45 +1000
Message-ID: <1219415925.32652.255.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pecan2.exetel.com.au (pecan2.exetel.com.au [220.233.0.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A93710389E
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Aug 2008 16:38:47 +0200 (CEST)
Received: from 168.78.233.220.exetel.com.au ([220.233.78.168]
	helo=[192.168.1.2]) by pecan2.exetel.com.au with esmtp (Exim 4.68)
	(envelope-from <Ben.Stanley@exemail.com.au>) id 1KWXmn-0008U5-LI
	for alsa-devel@alsa-project.org; Sat, 23 Aug 2008 00:38:45 +1000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ben Stanley Ben.Stanley@exemail.com.au

This is the patch against alsa-driver.
---
 pci/ca0106/ca0106_main.patch |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/pci/ca0106/ca0106_main.patch b/pci/ca0106/ca0106_main.patch
index 03820b3..d661011 100644
--- a/pci/ca0106/ca0106_main.patch
+++ b/pci/ca0106/ca0106_main.patch
@@ -14,12 +14,12 @@
  
  static struct snd_ca0106_details ca0106_chip_details[] = {
         /* Sound Blaster X-Fi Extreme Audio. This does not have an AC97. 53SB079000000 */
-@@ -1352,7 +1353,7 @@
+@@ -1542,7 +1543,7 @@
        pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &chip->model);
  #if 1
-       printk(KERN_INFO "snd-ca0106: Model %04x Rev %08x Serial %08x\n", chip->model,
--             pci->revision, chip->serial);
-+             snd_pci_revision(pci), chip->serial);
+       printk(KERN_INFO DRVNAME ": Model %04x Rev %08x Serial %08x\n",
+-              chip->model, pci->revision, chip->serial);
++              chip->model, snd_pci_revision(pci), chip->serial);
  #endif
        strcpy(card->driver, "CA0106");
        strcpy(card->shortname, "CA0106");
-- 
1.5.4.3
