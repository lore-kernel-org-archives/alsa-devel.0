From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] hdsp snd_assert
Date: Sun, 22 Feb 2004 16:03:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040222160317.7c8d2cf7.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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




--- pci/rme9652/hdsp.c_old	Sun Feb 22 15:52:59 2004
+++ pci/rme9652/hdsp.c	Sun Feb 22 15:57:43 2004
@@ -3810,8 +3810,8 @@
 {
 	int mapped_channel;
 
-        snd_assert(channel >= 0 || channel < hdsp->max_channels, return NULL);
-        
+	snd_assert(channel >= 0 && channel < hdsp->max_channels, return NULL);
+ 
 	if ((mapped_channel = hdsp->channel_map[channel]) < 0) {
 		return NULL;
 	}


--
Giuliano.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
