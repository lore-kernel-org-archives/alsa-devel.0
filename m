From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] echoaudio, typo fix
Date: Sun, 17 Apr 2005 15:48:43 +0200
Message-ID: <20050417154843.0d179f2f.pochini@shiny.it>
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


- Fix an Oops when an error occurs.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

diff -du alsa-driver__cvs/pci/echoaudio/echoaudio.c alsa-driver/pci/echoaudio/echoaudio.c
--- alsa-driver__cvs/pci/echoaudio/echoaudio.c	Sat Apr 16 10:56:47 2005
+++ alsa-driver/pci/echoaudio/echoaudio.c	Sun Apr 17 15:39:35 2005
@@ -402,7 +402,7 @@
 		chip->can_set_rate=0;
 dout_exit:
 	up(&chip->mode_mutex);
-	return 0;
+	return err;
 }
 
 #endif /* !ECHOCARD_HAS_VMIXER */



--
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
