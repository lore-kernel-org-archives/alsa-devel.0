From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 3/5] make snd-powermac load even when it cant
	bind the	device
Date: Tue, 18 Jul 2006 19:28:44 +0200
Message-ID: <30254.7240433798$1153248225@news.gmane.org>
References: <20060718172841.046446000@sipsolutions.net>>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 419E9243
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 20:43:23 +0200 (MEST)
Content-Disposition: inline; filename=snd-powermac-platform-device-fixes.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: linuxppc-dev@ozlabs.org
Cc: benh@kernel.crashing.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch makes snd-powermac load when it can't bind the device right
away. That's the expected behaviour for hotplugging, but fixes an
important problem I was seeing with doing a modprobe snd-powermac with
a version that refuses loading on machines with layout-id: snd-powermac
would create a bunch of uevents and then refuse to load, the uevents
causing udev to reload it again, ad eternum.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-fetch.orig/sound/ppc/powermac.c	2006-07-18 18:16:53.633476868 +0200
+++ linux-2.6-fetch/sound/ppc/powermac.c	2006-07-18 18:40:39.243476868 +0200
@@ -181,21 +181,14 @@ static int __init alsa_card_pmac_init(vo
 	if ((err = platform_driver_register(&snd_pmac_driver)) < 0)
 		return err;
 	device = platform_device_register_simple(SND_PMAC_DRIVER, -1, NULL, 0);
-	if (!IS_ERR(device)) {
-		if (platform_get_drvdata(device))
-			return 0;
-		platform_device_unregister(device);
-		err = -ENODEV;
-	} else
-		err = PTR_ERR(device);
-	platform_driver_unregister(&snd_pmac_driver);
-	return err;
+	return 0;
 
 }
 
 static void __exit alsa_card_pmac_exit(void)
 {
-	platform_device_unregister(device);
+	if (!IS_ERR(device))
+		platform_device_unregister(device);
 	platform_driver_unregister(&snd_pmac_driver);
 }
 

--


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
