From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 3/6] include, sound: pci_find_device remove (s/pci/ali5451/ali5451.c)
Date: Fri, 2 Sep 2005 23:44:54 +0200
Message-ID: <200509022144.j82Lis1O031338__9152.2294482731$1125697783$gmane$org@wscnet.wsc.cz>
References: <200509022122.j82LMMwV030426@wscnet.wsc.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from wscnet.wsc.cz (wscnet.wsc.cz [212.80.64.118])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E0ABF172
	for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2005 23:44:54 +0200 (MEST)
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

 ali5451.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -326,13 +326,12 @@ static void ali_read_regs(ali_t *codec, 
 static void ali_read_cfg(unsigned int vendor, unsigned deviceid)
 {
 	unsigned int dwVal;
-	struct pci_dev *pci_dev = NULL;
+	struct pci_dev *pci_dev;
 	int i,j;
 
-
-        pci_dev = pci_find_device(vendor, deviceid, pci_dev);
-        if (pci_dev == NULL)
-                return ;
+	pci_dev = pci_get_device(vendor, deviceid, NULL);
+	if (pci_dev == NULL)
+		return ;
 
 	printk("\nM%x PCI CFG\n", deviceid);
 	printk("    ");
@@ -349,6 +348,7 @@ static void ali_read_cfg(unsigned int ve
 		}
 		printk("\n");
 	}
+	pci_dev_put(pci_dev);
  }
 static void ali_read_ac97regs(ali_t *codec, int secondary)
 {
@@ -2112,6 +2112,8 @@ static int snd_ali_free(ali_t * codec)
 #ifdef CONFIG_PM
 	kfree(codec->image);
 #endif
+	pci_dev_put(codec->pci_m1533);
+	pci_dev_put(codec->pci_m7101);
 	kfree(codec);
 	return 0;
 }
@@ -2301,7 +2303,7 @@ static int __devinit snd_ali_create(snd_
 	codec->chregs.data.ainten = 0x00;
 
 	/* M1533: southbridge */
-       	pci_dev = pci_find_device(0x10b9, 0x1533, NULL);
+	pci_dev = pci_get_device(0x10b9, 0x1533, NULL);
 	codec->pci_m1533 = pci_dev;
 	if (! codec->pci_m1533) {
 		snd_printk(KERN_ERR "ali5451: cannot find ALi 1533 chip.\n");
@@ -2309,7 +2311,7 @@ static int __devinit snd_ali_create(snd_
 		return -ENODEV;
 	}
 	/* M7101: power management */
-       	pci_dev = pci_find_device(0x10b9, 0x7101, NULL);
+	pci_dev = pci_get_device(0x10b9, 0x7101, NULL);
 	codec->pci_m7101 = pci_dev;
 	if (! codec->pci_m7101 && codec->revision == ALI_5451_V02) {
 		snd_printk(KERN_ERR "ali5451: cannot find ALi 7101 chip.\n");


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
