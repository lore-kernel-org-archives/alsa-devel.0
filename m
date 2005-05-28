From: domen@coderock.org
Subject: [patch 1/1] sound/pci/ca0106: Use the DMA_32BIT_MASK constant
Date: Sun, 29 May 2005 01:17:01 +0200
Message-ID: <20050528231700.448498000@nd47.coderock.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from trashy.coderock.org (coderock.org [193.77.147.115])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 07E1A1DD
	for <alsa-devel@alsa-project.org>; Sun, 29 May 2005 01:17:09 +0200 (MEST)
Content-Disposition: inline; filename=dma_mask-sound_pci_ca0106_ca0106_main
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, Tobias Klauser <tklauser@nuerscht.ch>, domen@coderock.org
List-Id: alsa-devel@alsa-project.org

From: Tobias Klauser <tklauser@nuerscht.ch>


Use the DMA_32BIT_MASK constant from dma-mapping.h
when calling pci_set_dma_mask() or pci_set_consistent_dma_mask()
See http://marc.theaimsgroup.com/?t=108001993000001&r=1&w=2 for details

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>
Signed-off-by: Domen Puncer <domen@coderock.org>

---
 ca0106_main.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

Index: quilt/sound/pci/ca0106/ca0106_main.c
===================================================================
--- quilt.orig/sound/pci/ca0106/ca0106_main.c
+++ quilt/sound/pci/ca0106/ca0106_main.c
@@ -136,6 +136,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/moduleparam.h>
+#include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
@@ -1003,8 +1004,8 @@ static int __devinit snd_ca0106_create(s
   
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
-	if (pci_set_dma_mask(pci, 0xffffffffUL) < 0 ||
-	    pci_set_consistent_dma_mask(pci, 0xffffffffUL) < 0) {
+	if (pci_set_dma_mask(pci, DMA_32BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(pci, DMA_32BIT_MASK) < 0) {
 		printk(KERN_ERR "error to set 32bit mask DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;

--


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
