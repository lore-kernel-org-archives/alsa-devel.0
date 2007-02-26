From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] aoa: fix a sparse warning
Date: Tue, 27 Feb 2007 00:23:59 +0100
Message-ID: <1172532239.3870.210.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C38872F5
	for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2007 00:24:18 +0100 (MET)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This fixes a warning sparse gives.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
There are more sparse warnings but they're about signedness where I
explicitly need to get signed values from the hw but the functions are
declared unsigned because I also need unsigned values sometimes...

 sound/aoa/soundbus/core.c     |    2 --
 sound/aoa/soundbus/soundbus.h |    2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

--- wireless-dev.orig/sound/aoa/soundbus/core.c	2007-02-27 00:18:47.534692803 +0100
+++ wireless-dev/sound/aoa/soundbus/core.c	2007-02-27 00:18:52.994692803 +0100
@@ -179,8 +179,6 @@ static int soundbus_device_resume(struct
 
 #endif /* CONFIG_PM */
 
-extern struct device_attribute soundbus_dev_attrs[];
-
 static struct bus_type soundbus_bus_type = {
 	.name		= "aoa-soundbus",
 	.probe		= soundbus_probe,
--- wireless-dev.orig/sound/aoa/soundbus/soundbus.h	2007-02-27 00:17:50.574692803 +0100
+++ wireless-dev/sound/aoa/soundbus/soundbus.h	2007-02-27 00:18:58.224692803 +0100
@@ -199,4 +199,6 @@ struct soundbus_driver {
 extern int soundbus_register_driver(struct soundbus_driver *drv);
 extern void soundbus_unregister_driver(struct soundbus_driver *drv);
 
+extern struct device_attribute soundbus_dev_attrs[];
+
 #endif /* __SOUNDBUS_H */



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
