From: Art Haas <ahaas@airmail.net>
Subject: [PATCH] C99 initializers for alsa-lib/aserver/aserver.c
Date: Sat, 26 Jul 2003 10:30:47 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030726153047.GA21082@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi.

The cleanup of the obsolete GCC initializers in alsa-lib looks good.
Here's a small patch for aserver/aserver.c that got missed.

Art Haas

Index: aserver/aserver.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/aserver/aserver.c,v
retrieving revision 1.56
diff -u -u -r1.56 aserver.c
--- aserver/aserver.c	18 Mar 2003 18:00:05 -0000	1.56
+++ aserver/aserver.c	26 Jul 2003 15:27:46 -0000
@@ -518,9 +518,9 @@
 }
 
 transport_ops_t pcm_shm_ops = {
-	open: pcm_shm_open,
-	cmd: pcm_shm_cmd,
-	close: pcm_shm_close,
+	.open	= pcm_shm_open,
+	.cmd	= pcm_shm_cmd,
+	.close	= pcm_shm_close,
 };
 
 static int ctl_handler(waiter_t *waiter, unsigned short events)
@@ -712,9 +712,9 @@
 }
 
 transport_ops_t ctl_shm_ops = {
-	open: ctl_shm_open,
-	cmd: ctl_shm_cmd,
-	close: ctl_shm_close,
+	.open	= ctl_shm_open,
+	.cmd	= ctl_shm_cmd,
+	.close	= ctl_shm_close,
 };
 
 static int snd_client_open(client_t *client)
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
