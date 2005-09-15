From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] remove bogus match method for ac97_bus
Date: Wed, 14 Sep 2005 21:54:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509142146070.31877@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


The bus_id is initialized with a generic identifier string which is not 
really useful for proper driver matching.  Let the driver decide what it 
needs via its probe method instead.

Signed-off-by: Nicolas Pitre <nico@cam.org>

Index: linux-2.6/sound/pci/ac97/ac97_bus.c
===================================================================
--- linux-2.6.orig/sound/pci/ac97/ac97_bus.c
+++ linux-2.6/sound/pci/ac97/ac97_bus.c
@@ -17,12 +17,13 @@
 #include <linux/string.h>
 
 /*
- * Codec families have names seperated by commas, so we search for an
- * individual codec name within the family string. 
+ * Let drivers decide whether they want to support given codec from their
+ * probe method.  Drivers have direct access to the ac97_t structure and may
+ * decide based on the id field amongst other things.
  */
 static int ac97_bus_match(struct device *dev, struct device_driver *drv)
 {
-	return (strstr(dev->bus_id, drv->name) != NULL);
+	return 1;
 }
 
 static int ac97_bus_suspend(struct device *dev, pm_message_t state)


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
