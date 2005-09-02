From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 6/6] include, sound: pci_find_device remove (s/pci/via82xx.c)
Date: Fri, 2 Sep 2005 23:44:54 +0200
Message-ID: <200509022144.j82LisdZ031334__9522.12195047668$1125697768$gmane$org@wscnet.wsc.cz>
References: <200509022122.j82LMMwV030426@wscnet.wsc.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from wscnet.wsc.cz (wscnet.wsc.cz [212.80.64.118])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AD951171
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

 via82xx.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -1933,11 +1933,12 @@ static int snd_via82xx_chip_init(via82xx
 		 * DXS channels don't work properly with VRA if MC97 is disabled.
 		 */
 		struct pci_dev *pci;
-		pci = pci_find_device(0x1106, 0x3068, NULL); /* MC97 */
+		pci = pci_get_device(0x1106, 0x3068, NULL); /* MC97 */
 		if (pci) {
 			unsigned char data;
 			pci_read_config_byte(pci, 0x44, &data);
 			pci_write_config_byte(pci, 0x44, data | 0x40);
+			pci_dev_put(pci);
 		}
 	}
 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
