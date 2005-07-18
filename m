From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] echomixer, update driver name
Date: Tue, 19 Jul 2005 00:18:44 +0200
Message-ID: <20050719001844.63635a65.pochini@shiny.it>
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


- Updates echomixer according to the new driver name.


Signed-off-by: Giuliano Pochini <pochini@shiny.it>

--- alsa-tools/echomixer/echomixer.c__orig	Mon Jul 18 23:58:19 2005
+++ alsa-tools/echomixer/echomixer.c	Mon Jul 18 23:59:08 2005
@@ -1889,7 +1889,7 @@
       continue;
     }
     if ((err=snd_ctl_card_info(ctlhandle, hw_info))>=0) {
-      if (!strncmp(snd_ctl_card_info_get_driver(hw_info), "Echoaudio", 9)) {
+      if (!strncmp(snd_ctl_card_info_get_driver(hw_info), "Echo_", 5)) {
         strncpy(card, hwname, 7);
         hwname[7]=0;
         strncpy(cardname, snd_ctl_card_info_get_name(hw_info), 31);


--
Giuliano.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
