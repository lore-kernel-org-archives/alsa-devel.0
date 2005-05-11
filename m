From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] (resend) echoaudio disable device
Date: Wed, 11 May 2005 22:36:01 +0200
Message-ID: <20050511223601.5b57518f.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


*sigh*

- Add missing calls to pci_disable_device()


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

diff -du alsa-driver__orig/pci/echoaudio/echoaudio.c alsa-driver/pci/echoaudio/echoaudio.c
--- alsa-driver__orig/pci/echoaudio/echoaudio.c	Sat Apr 23 12:28:27 2005
+++ alsa-driver/pci/echoaudio/echoaudio.c	Mon May  2 21:05:52 2005
@@ -1746,6 +1746,8 @@
 	}
 	DE_INIT(("MMIO freed.\n"));
 
+	pci_disable_device(chip->pci);
+
 	/* release chip data */
 	kfree(chip);
 	DE_INIT(("Chip freed.\n"));
@@ -1784,8 +1786,10 @@
 
 	/* allocate a chip-specific data */
 	chip = kcalloc(1, sizeof(echoaudio_t), GFP_KERNEL);
-	if (!chip)
+	if (!chip) {
+		pci_disable_device(pci);
 		return -ENOMEM;
+	}
 	DE_INIT(("chip=%p\n", chip));
 
 	spin_lock_init(&chip->lock);



--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
