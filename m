From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] clean suspend/resume calls for ac97_bus_type
Date: Wed, 14 Sep 2005 22:22:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509142207110.31877@localhost.localdomain>
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


A single call to the driver suspend/resume method for each device is 
enough. The level and SUSPEND_*/RESUME_* arguments are deprecated and 
said to be removed eventually anyway (no other subsystem are using them 
anymore except platform devices).

Signed-off-by: Nicolas Pitre <nico@cam.org>

Index: linux-2.6/sound/pci/ac97/ac97_bus.c
===================================================================
--- linux-2.6.orig/sound/pci/ac97/ac97_bus.c
+++ linux-2.6/sound/pci/ac97/ac97_bus.c
@@ -30,13 +30,8 @@
 {
 	int ret = 0;
 
-	if (dev->driver && dev->driver->suspend) {
-		ret = dev->driver->suspend(dev, state, SUSPEND_DISABLE);
-		if (ret == 0)
-			ret = dev->driver->suspend(dev, state, SUSPEND_SAVE_STATE);
-		if (ret == 0)
-			ret = dev->driver->suspend(dev, state, SUSPEND_POWER_DOWN);
-	}
+	if (dev->driver && dev->driver->suspend)
+		ret = dev->driver->suspend(dev, state, SUSPEND_POWER_DOWN);
 	return ret;
 }
 
@@ -44,13 +39,8 @@
 {
 	int ret = 0;
 
-	if (dev->driver && dev->driver->resume) {
+	if (dev->driver && dev->driver->resume)
 		ret = dev->driver->resume(dev, RESUME_POWER_ON);
-		if (ret == 0)
-			ret = dev->driver->resume(dev, RESUME_RESTORE_STATE);
-		if (ret == 0)
-			ret = dev->driver->resume(dev, RESUME_ENABLE);
-	}
 	return ret;
 }
 


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
