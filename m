From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] echoaudio disable device
Date: Mon, 2 May 2005 21:13:04 +0200
Message-ID: <20050502211304.7ec976bd.pochini@shiny.it>
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
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
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
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
