From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] echoaudio, fix driver name overflow.
Date: Tue, 19 Jul 2005 00:16:48 +0200
Message-ID: <20050719001648.54e266af.pochini@shiny.it>
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


- Driver name is only 16 bytes long. This patch fixes a string overflow in
the driver of some cards.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-driver/pci/echoaudio/echoaudio.c__orig	Mon Jul 18 23:49:12 2005
+++ alsa-driver/pci/echoaudio/echoaudio.c	Mon Jul 18 23:50:00 2005
@@ -1878,7 +1878,7 @@
 		return err;
 	}
 
-	strcpy(card->driver, "Echoaudio " ECHOCARD_NAME);
+	strcpy(card->driver, "Echo_" ECHOCARD_NAME);
 	strcpy(card->shortname, chip->card_name);
 
 	dsp = "56301";



--
Giuliano.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
