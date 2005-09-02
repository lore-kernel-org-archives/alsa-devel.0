From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 2/6] include, sound: pci_find_device remove (s/core/memalloc.c)
Date: Fri, 2 Sep 2005 23:44:55 +0200
Message-ID: <200509022144.j82LitUL031342__41479.6984558508$1125697898$gmane$org@wscnet.wsc.cz>
References: <200509022122.j82LMMwV030426@wscnet.wsc.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from wscnet.wsc.cz (wscnet.wsc.cz [212.80.64.118])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 601F9172
	for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2005 23:44:55 +0200 (MEST)
In-reply-to: <200509022122.j82LMMwV030426@wscnet.wsc.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Greg KH <gregkh@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org



Generated in 2.6.13-mm1 kernel version.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 memalloc.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -567,8 +567,8 @@ static int snd_mem_proc_write(struct fil
 		char *endp;
 		int vendor, device, size, buffers;
 		long mask;
-		int i, alloced;
-		struct pci_dev *pci;
+		int i, alloced = 0;
+		struct pci_dev *pci = NULL;
 
 		if ((token = gettoken(&p)) == NULL ||
 		    (vendor = simple_strtol(token, NULL, 0)) <= 0 ||
@@ -588,13 +588,12 @@ static int snd_mem_proc_write(struct fil
 		vendor &= 0xffff;
 		device &= 0xffff;
 
-		alloced = 0;
-		pci = NULL;
-		while ((pci = pci_find_device(vendor, device, pci)) != NULL) {
+		while ((pci = pci_get_device(vendor, device, pci)) != NULL) {
 			if (mask > 0 && mask < 0xffffffff) {
 				if (pci_set_dma_mask(pci, mask) < 0 ||
 				    pci_set_consistent_dma_mask(pci, mask) < 0) {
 					printk(KERN_ERR "snd-page-alloc: cannot set DMA mask %lx for pci %04x:%04x\n", mask, vendor, device);
+					pci_dev_put(pci);
 					return (int)count;
 				}
 			}
@@ -604,6 +603,7 @@ static int snd_mem_proc_write(struct fil
 				if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
 							size, &dmab) < 0) {
 					printk(KERN_ERR "snd-page-alloc: cannot allocate buffer pages (size = %d)\n", size);
+					pci_dev_put(pci);
 					return (int)count;
 				}
 				snd_dma_reserve_buf(&dmab, snd_dma_pci_buf_id(pci));


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
