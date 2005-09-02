From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 4/6] include, sound: pci_find_device remove (s/pci/au88x0/au88x0.c)
Date: Fri, 2 Sep 2005 23:44:55 +0200
Message-ID: <200509022144.j82Lit5m031351__26631.9390190349$1125697898$gmane$org@wscnet.wsc.cz>
References: <200509022122.j82LMMwV030426@wscnet.wsc.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from wscnet.wsc.cz (wscnet.wsc.cz [212.80.64.118])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 04C7D172
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

 au88x0.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/sound/pci/au88x0/au88x0.c b/sound/pci/au88x0/au88x0.c
--- a/sound/pci/au88x0/au88x0.c
+++ b/sound/pci/au88x0/au88x0.c
@@ -79,19 +79,21 @@ static void vortex_fix_agp_bridge(struct
 
 static void __devinit snd_vortex_workaround(struct pci_dev *vortex, int fix)
 {
-	struct pci_dev *via;
+	struct pci_dev *via = NULL;
 
 	/* autodetect if workarounds are required */
 	if (fix == 255) {
 		/* VIA KT133 */
-		via = pci_find_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8365_1, NULL);
+		via = pci_get_device(PCI_VENDOR_ID_VIA,
+			PCI_DEVICE_ID_VIA_8365_1, NULL);
 		/* VIA Apollo */
 		if (via == NULL) {
-			via = pci_find_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C598_1, NULL);
-		}
-		/* AMD Irongate */
-		if (via == NULL) {
-			via = pci_find_device(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_FE_GATE_7007, NULL);
+			via = pci_get_device(PCI_VENDOR_ID_VIA,
+				PCI_DEVICE_ID_VIA_82C598_1, NULL);
+			/* AMD Irongate */
+			if (via == NULL)
+				via = pci_get_device(PCI_VENDOR_ID_AMD,
+					PCI_DEVICE_ID_AMD_FE_GATE_7007, NULL);
 		}
 		if (via) {
 			printk(KERN_INFO CARD_NAME ": Activating latency workaround...\n");
@@ -101,13 +103,17 @@ static void __devinit snd_vortex_workaro
 	} else {
 		if (fix & 0x1)
 			vortex_fix_latency(vortex);
-		if ((fix & 0x2) && (via = pci_find_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8365_1, NULL)))
+		if ((fix & 0x2) && (via = pci_get_device(PCI_VENDOR_ID_VIA,
+				PCI_DEVICE_ID_VIA_8365_1, NULL)))
 			vortex_fix_agp_bridge(via);
-		if ((fix & 0x4) && (via = pci_find_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C598_1, NULL)))
+		if ((fix & 0x4) && (via = pci_get_device(PCI_VENDOR_ID_VIA,
+				PCI_DEVICE_ID_VIA_82C598_1, NULL)))
 			vortex_fix_agp_bridge(via);
-		if ((fix & 0x8) && (via = pci_find_device(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_FE_GATE_7007, NULL)))
+		if ((fix & 0x8) && (via = pci_get_device(PCI_VENDOR_ID_AMD,
+				PCI_DEVICE_ID_AMD_FE_GATE_7007, NULL)))
 			vortex_fix_agp_bridge(via);
 	}
+	pci_dev_put(via);
 }
 
 // component-destructor


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
