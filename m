From: Nicolas Pitre <nico@cam.org>
Subject: [patch] fix to pxa2xx-ac97 driver
Date: Fri, 4 Feb 2005 00:16:21 -0500 (EST)
Message-ID: <Pine.LNX.4.61.0502040015040.25997@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Rather obvious...

Index: linux-2.6.10/sound/arm/pxa2xx-ac97.c
===================================================================
--- linux-2.6.10.orig/sound/arm/pxa2xx-ac97.c
+++ linux-2.6.10/sound/arm/pxa2xx-ac97.c
@@ -115,7 +115,7 @@
 	udelay(50);
 #else
 	GCR = GCR_COLD_RST;
-	GCR |= GCR_PRIRDY_IEN|GCR_SECRDY_IEN;*/
+	GCR |= GCR_PRIRDY_IEN|GCR_SECRDY_IEN;
 	wait_event_timeout(gsr_wq, gsr_bits & (GSR_PCR | GSR_SCR), 1);
 #endif
 


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
