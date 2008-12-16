From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: [PATCH] 2/2 ALSA: ca0106 support 44100Hz playback
	to	spdif
Date: Wed, 17 Dec 2008 01:40:42 +1100
Message-ID: <1229438442.13074.121.camel@localhost>
References: <1229438227.13074.116.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pecan2.exetel.com.au (pecan2.exetel.com.au [220.233.0.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 545222414F
	for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2008 15:40:42 +0100 (CET)
Received: from 168.78.233.220.exetel.com.au ([220.233.78.168]
	helo=[192.168.1.2]) by pecan2.exetel.com.au with esmtp (Exim 4.68)
	(envelope-from <Ben.Stanley@exemail.com.au>) id 1LCb6H-0008SH-Ka
	for alsa-devel@alsa-project.org; Wed, 17 Dec 2008 01:40:41 +1100
In-Reply-To: <1229438227.13074.116.camel@localhost>
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

>From a4ddd52a7031cce64beee1e428e16ddd1b1b8084 Mon Sep 17 00:00:00 2001
From: Ben Stanley <Ben.Stanley@exemail.com.au>
Date: Wed, 17 Dec 2008 00:40:05 +1100
Subject: [PATCH] ALSA: ca0106 support 44100Hz playback to spdif

This is the patch to the alsa-driver tree to support the 
44100Hz spdif playback. Its really just a code cleanup, and is
independent of the other functionality.

Signed-off-by: Ben Stanley <Ben.Stanley@exemail.com.au>
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
- 	printk(KERN_INFO "snd-ca0106: Model %04x Rev %08x Serial %08x\n", chip->model,
--	       pci->revision, chip->serial);
-+	       snd_pci_revision(pci), chip->serial);
+	printk(KERN_INFO DRVNAME ": Model %04x Rev %08x Serial %08x\n",
+-		chip->model, pci->revision, chip->serial);
++		chip->model, snd_pci_revision(pci), chip->serial);
  #endif
  	strcpy(card->driver, "CA0106");
  	strcpy(card->shortname, "CA0106");
-- 
1.5.4.3
