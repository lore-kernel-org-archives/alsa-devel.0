From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] aoa: remove suspend/resume printks
Date: Wed, 07 Feb 2007 13:30:14 +0100
Message-ID: <1170851414.6798.35.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2F7D034F
	for <alsa-devel@alsa-project.org>; Wed,  7 Feb 2007 13:33:04 +0100 (MET)
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

This just removes two useless printks.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Takashi Iwai <tiwai@suse.de>

---
Please apply to the alsa tree.

--- linux-2.6-git.orig/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2007-02-07 04:22:33.441855996 +0100
+++ linux-2.6-git/sound/aoa/fabrics/snd-aoa-fabric-layout.c	2007-02-07 04:40:56.862855996 +0100
@@ -1077,8 +1077,6 @@ static int aoa_fabric_layout_suspend(str
 {
 	struct layout_dev *ldev = sdev->ofdev.dev.driver_data;
 
-	printk("aoa_fabric_layout_suspend()\n");
-
 	if (ldev->gpio.methods && ldev->gpio.methods->all_amps_off)
 		ldev->gpio.methods->all_amps_off(&ldev->gpio);
 
@@ -1089,8 +1087,6 @@ static int aoa_fabric_layout_resume(stru
 {
 	struct layout_dev *ldev = sdev->ofdev.dev.driver_data;
 
-	printk("aoa_fabric_layout_resume()\n");
-
 	if (ldev->gpio.methods && ldev->gpio.methods->all_amps_off)
 		ldev->gpio.methods->all_amps_restore(&ldev->gpio);
 



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
