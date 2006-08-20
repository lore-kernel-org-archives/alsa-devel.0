From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] make
	sound/pci/emu10k1/emu10k1.c:snd_emu10k1_resume() static
Date: Mon, 21 Aug 2006 00:59:24 +0200
Message-ID: <20060820225924.GV7813@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id EFDAE165
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Aug 2006 00:59:23 +0200 (MEST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch makes the needlessly global snd_emu10k1_resume() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc4-mm2/sound/pci/emu10k1/emu10k1.c.old	2006-08-20 23:20:05.000000000 +0200
+++ linux-2.6.18-rc4-mm2/sound/pci/emu10k1/emu10k1.c	2006-08-20 23:21:09.000000000 +0200
@@ -232,7 +232,7 @@
 	return 0;
 }
 
-int snd_emu10k1_resume(struct pci_dev *pci)
+static int snd_emu10k1_resume(struct pci_dev *pci)
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct snd_emu10k1 *emu = card->private_data;


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
