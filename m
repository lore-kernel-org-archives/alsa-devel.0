From: Rene Herman <rene.herman@keyaccess.nl>
Subject: snd-opti92x-{ad1848,cs4231} won't compile without CONFIG_PNP
Date: Mon, 27 Feb 2006 23:06:40 +0100
Message-ID: <440377F0.6040201@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040801030801080206090307"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl [213.51.130.200])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EE5B917B
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2006 23:05:40 +0100 (MET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040801030801080206090307
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

Noticed the snd-opti92x driver wouldn't compile without ISA-PnP support. 
I see the driver only supports one card meaning it wants a bit more than 
this to bring it inline, but a minimal fix is attached.

I do actually have a pnp opti92x / cs4231 card lying around somewhere 
although not available right now. I'll dig it up and do some cleanup / 
testing in the not too distant future, if you'd like me to.

Rene.


--------------040801030801080206090307
Content-Type: text/plain;
 name="opti92x_pnpc_driver.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="opti92x_pnpc_driver.diff"

Index: local/sound/isa/opti9xx/opti92x-ad1848.c
===================================================================
--- local.orig/sound/isa/opti9xx/opti92x-ad1848.c	2006-02-27 19:22:35.000000000 +0100
+++ local/sound/isa/opti9xx/opti92x-ad1848.c	2006-02-27 22:26:52.000000000 +0100
@@ -2088,9 +2088,12 @@ static int __init alsa_card_opti9xx_init
 	int error;
 	struct platform_device *device;
 
+#ifdef CONFIG_PNP
 	pnp_register_card_driver(&opti9xx_pnpc_driver);
 	if (snd_opti9xx_pnp_is_probed)
 		return 0;
+	pnp_unregister_card_driver(&opti9xx_pnpc_driver);
+#endif
 	if (! is_isapnp_selected()) {
 		error = platform_driver_register(&snd_opti9xx_driver);
 		if (error < 0)
@@ -2102,7 +2105,6 @@ static int __init alsa_card_opti9xx_init
 		}
 		platform_driver_unregister(&snd_opti9xx_driver);
 	}
-	pnp_unregister_card_driver(&opti9xx_pnpc_driver);
 #ifdef MODULE
 	printk(KERN_ERR "no OPTi " CHIP_NAME " soundcard found\n");
 #endif
@@ -2115,7 +2117,10 @@ static void __exit alsa_card_opti9xx_exi
 		platform_device_unregister(snd_opti9xx_platform_device);
 		platform_driver_unregister(&snd_opti9xx_driver);
 	}
-	pnp_unregister_card_driver(&opti9xx_pnpc_driver);
+#ifdef CONFIG_PNP
+	else
+		pnp_unregister_card_driver(&opti9xx_pnpc_driver);
+#endif
 }
 
 module_init(alsa_card_opti9xx_init)

--------------040801030801080206090307--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
