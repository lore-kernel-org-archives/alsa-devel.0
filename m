From: Rene Herman <rene.herman@keyaccess.nl>
Subject: [ALSA 2/2] unregister platform device again if probe was unsuccessful
Date: Thu, 06 Apr 2006 04:08:45 +0200
Message-ID: <4434782D.6010700__2263.01736333898$1144289380$gmane$org@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030801070208010208070404"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl [213.51.130.200])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 81068146
	for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2006 04:07:46 +0200 (MEST)
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
Cc: ALSA devel <alsa-devel@alsa-project.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030801070208010208070404
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Rene Herman wrote:

> Yes. I don't see a significantly cleaner solution then than the 
> slightly hackish "using drvdata as a private success flag" that I 
> posted before. Example patch versus snd_adlib attached again. This 
> seems to work well.
> 
> Takashi: do you agree? If the probe() method return is not going to 
> be propagated up, there are few other options.
> 
> (Continuing the loop on IS_ERR(device) is then also a bit 
> questionable again as the IS_ERR then signifies an eror in the bowels
>  of the device model, but I feel it's still the correct thing to do)

And here's the one doing the unregisters. This one could also go to
stable, if you agree with the method...

I've been testing with snd_adlib, and everything seems to be working as
planned, also with the bus_add_device() patch reverted. Ie, not having
the hardware present (at the supplied adress) makes it fail to load, and

echo -n snd_adlib.0 >/sys/bus/platform/drivers/snd_adlib/{un,}bind

makes the driver unbind and bind correctly.

     ad1848/ad1848.c          |    4 ++++
     adlib.c                  |   11 +++++++----
     cmi8330.c                |    4 ++++
     cs423x/cs4231.c          |    4 ++++
     cs423x/cs4236.c          |    4 ++++
     es1688/es1688.c          |    4 ++++
     es18xx.c                 |    4 ++++
     gus/gusclassic.c         |    4 ++++
     gus/gusextreme.c         |    4 ++++
     gus/gusmax.c             |    4 ++++
     gus/interwave.c          |    4 ++++
     opl3sa2.c                |    4 ++++
     opti9xx/miro.c           |    7 +++++--
     opti9xx/opti92x-ad1848.c |    7 +++++--
     sb/sb16.c                |    4 ++++
     sb/sb8.c                 |    4 ++++
     sgalaxy.c                |    4 ++++
     sscape.c                 |    4 ++++
     wavefront/wavefront.c    |    4 ++++
     19 files changed, 81 insertions(+), 8 deletions(-)

Rene





--------------030801070208010208070404
Content-Type: text/plain;
 name="alsa_platform_unregister.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_platform_unregister.diff"

Index: mm/sound/isa/ad1848/ad1848.c
===================================================================
--- mm.orig/sound/isa/ad1848/ad1848.c	2006-04-06 02:45:56.000000000 +0200
+++ mm/sound/isa/ad1848/ad1848.c	2006-04-06 02:55:05.000000000 +0200
@@ -195,6 +195,10 @@ static int __init alsa_card_ad1848_init(
 							 i, NULL, 0);
 		if (IS_ERR(device))
 			continue;
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
 		devices[i] = device;
 		cards++;
 	}
Index: mm/sound/isa/cmi8330.c
===================================================================
--- mm.orig/sound/isa/cmi8330.c	2006-04-06 02:45:56.000000000 +0200
+++ mm/sound/isa/cmi8330.c	2006-04-06 02:55:05.000000000 +0200
@@ -701,6 +701,10 @@ static int __init alsa_card_cmi8330_init
 							 i, NULL, 0);
 		if (IS_ERR(device))
 			continue;
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
 		platform_devices[i] = device;
 		cards++;
 	}
Index: mm/sound/isa/cs423x/cs4231.c
===================================================================
--- mm.orig/sound/isa/cs423x/cs4231.c	2006-04-06 02:45:56.000000000 +0200
+++ mm/sound/isa/cs423x/cs4231.c	2006-04-06 02:55:05.000000000 +0200
@@ -211,6 +211,10 @@ static int __init alsa_card_cs4231_init(
 							 i, NULL, 0);
 		if (IS_ERR(device))
 			continue;
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
 		devices[i] = device;
 		cards++;
 	}
Index: mm/sound/isa/cs423x/cs4236.c
===================================================================
--- mm.orig/sound/isa/cs423x/cs4236.c	2006-04-06 02:45:56.000000000 +0200
+++ mm/sound/isa/cs423x/cs4236.c	2006-04-06 02:55:05.000000000 +0200
@@ -782,6 +782,10 @@ static int __init alsa_card_cs423x_init(
 							 i, NULL, 0);
 		if (IS_ERR(device))
 			continue;
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
 		platform_devices[i] = device;
 		snd_cs423x_devices++;
 	}
Index: mm/sound/isa/es1688/es1688.c
===================================================================
--- mm.orig/sound/isa/es1688/es1688.c	2006-04-06 02:45:56.000000000 +0200
+++ mm/sound/isa/es1688/es1688.c	2006-04-06 02:55:05.000000000 +0200
@@ -215,6 +215,10 @@ static int __init alsa_card_es1688_init(
 							 i, NULL, 0);
 		if (IS_ERR(device))
 			continue;
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
 		devices[i] = device;
 		cards++;
 	}
Index: mm/sound/isa/gus/gusclassic.c
===================================================================
--- mm.orig/sound/isa/gus/gusclassic.c	2006-04-06 02:45:56.000000000 +0200
+++ mm/sound/isa/gus/gusclassic.c	2006-04-06 02:55:05.000000000 +0200
@@ -255,6 +255,10 @@ static int __init alsa_card_gusclassic_i
 							 i, NULL, 0);
 		if (IS_ERR(device))
 			continue;
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
 		devices[i] = device;
 		cards++;
 	}
Index: mm/sound/isa/gus/gusextreme.c
===================================================================
--- mm.orig/sound/isa/gus/gusextreme.c	2006-04-06 02:45:56.000000000 +0200
+++ mm/sound/isa/gus/gusextreme.c	2006-04-06 02:55:05.000000000 +0200
@@ -365,6 +365,10 @@ static int __init alsa_card_gusextreme_i
 							 i, NULL, 0);
 		if (IS_ERR(device))
 			continue;
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
 		devices[i] = device;
 		cards++;
 	}
Index: mm/sound/isa/gus/gusmax.c
===================================================================
--- mm.orig/sound/isa/gus/gusmax.c	2006-04-06 02:45:56.000000000 +0200
+++ mm/sound/isa/gus/gusmax.c	2006-04-06 02:55:05.000000000 +0200
@@ -392,6 +392,10 @@ static int __init alsa_card_gusmax_init(
 							 i, NULL, 0);
 		if (IS_ERR(device))
 			continue;
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
 		devices[i] = device;
 		cards++;
 	}
Index: mm/sound/isa/gus/interwave.c
===================================================================
--- mm.orig/sound/isa/gus/interwave.c	2006-04-06 02:45:56.000000000 +0200
+++ mm/sound/isa/gus/interwave.c	2006-04-06 02:55:05.000000000 +0200
@@ -949,6 +949,10 @@ static int __init alsa_card_interwave_in
 							 i, NULL, 0);
 		if (IS_ERR(device))
 			continue;
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
 		platform_devices[i] = device;
 		cards++;
 	}
Index: mm/sound/isa/opl3sa2.c
===================================================================
--- mm.orig/sound/isa/opl3sa2.c	2006-04-06 02:45:56.000000000 +0200
+++ mm/sound/isa/opl3sa2.c	2006-04-06 02:55:05.000000000 +0200
@@ -964,6 +964,10 @@ static int __init alsa_card_opl3sa2_init
 							 i, NULL, 0);
 		if (IS_ERR(device))
 			continue;
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
 		platform_devices[i] = device;
 		snd_opl3sa2_devices++;
 	}
Index: mm/sound/isa/sb/sb16.c
===================================================================
--- mm.orig/sound/isa/sb/sb16.c	2006-04-06 02:45:56.000000000 +0200
+++ mm/sound/isa/sb/sb16.c	2006-04-06 02:55:05.000000000 +0200
@@ -723,6 +723,10 @@ static int __init alsa_card_sb16_init(vo
 							 i, NULL, 0);
 		if (IS_ERR(device))
 			continue;
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
 		platform_devices[i] = device;
 		cards++;
 	}
Index: mm/sound/isa/sb/sb8.c
===================================================================
--- mm.orig/sound/isa/sb/sb8.c	2006-04-06 02:45:56.000000000 +0200
+++ mm/sound/isa/sb/sb8.c	2006-04-06 02:55:05.000000000 +0200
@@ -266,6 +266,10 @@ static int __init alsa_card_sb8_init(voi
 							 i, NULL, 0);
 		if (IS_ERR(device))
 			continue;
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
 		devices[i] = device;
 		cards++;
 	}
Index: mm/sound/isa/sgalaxy.c
===================================================================
--- mm.orig/sound/isa/sgalaxy.c	2006-04-06 02:45:56.000000000 +0200
+++ mm/sound/isa/sgalaxy.c	2006-04-06 02:55:05.000000000 +0200
@@ -368,6 +368,10 @@ static int __init alsa_card_sgalaxy_init
 							 i, NULL, 0);
 		if (IS_ERR(device))
 			continue;
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
 		devices[i] = device;
 		cards++;
 	}
Index: mm/sound/isa/wavefront/wavefront.c
===================================================================
--- mm.orig/sound/isa/wavefront/wavefront.c	2006-04-06 02:45:56.000000000 +0200
+++ mm/sound/isa/wavefront/wavefront.c	2006-04-06 02:55:05.000000000 +0200
@@ -724,6 +724,10 @@ static int __init alsa_card_wavefront_in
 							 i, NULL, 0);
 		if (IS_ERR(device))
 			continue;
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
 		platform_devices[i] = device;
 		cards++;
 	}
Index: mm/sound/isa/adlib.c
===================================================================
--- mm.orig/sound/isa/adlib.c	2006-04-06 02:45:56.000000000 +0200
+++ mm/sound/isa/adlib.c	2006-04-06 02:55:05.000000000 +0200
@@ -43,8 +43,7 @@ static int __devinit snd_adlib_probe(str
 	struct snd_card *card;
 	struct snd_opl3 *opl3;
 
-	int error;
-	int i = device->id;
+	int error, i = device->id;
 
 	if (port[i] == SNDRV_AUTO_PORT) {
 		snd_printk(KERN_ERR DRV_NAME ": please specify port\n");
@@ -95,8 +94,7 @@ static int __devinit snd_adlib_probe(str
 	return 0;
 
 out1:	snd_card_free(card);
- out0:	error = -EINVAL; /* FIXME: should be the original error code */
-	return error;
+out0:	return error;
 }
 
 static int __devexit snd_adlib_remove(struct platform_device *device)
@@ -134,6 +132,11 @@ static int __init alsa_card_adlib_init(v
 		if (IS_ERR(device))
 			continue;
 
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
+
 		devices[i] = device;
 		cards++;
 	}
Index: mm/sound/isa/es18xx.c
===================================================================
--- mm.orig/sound/isa/es18xx.c	2006-04-06 02:45:56.000000000 +0200
+++ mm/sound/isa/es18xx.c	2006-04-06 02:55:05.000000000 +0200
@@ -2394,6 +2394,10 @@ static int __init alsa_card_es18xx_init(
 							 i, NULL, 0);
 		if (IS_ERR(device))
 	       		continue;
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
 		platform_devices[i] = device;
 		cards++;
 	}
Index: mm/sound/isa/opti9xx/miro.c
===================================================================
--- mm.orig/sound/isa/opti9xx/miro.c	2006-04-06 02:45:56.000000000 +0200
+++ mm/sound/isa/opti9xx/miro.c	2006-04-06 02:55:05.000000000 +0200
@@ -1436,8 +1436,11 @@ static int __init alsa_card_miro_init(vo
 	if ((error = platform_driver_register(&snd_miro_driver)) < 0)
 		return error;
 	device = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
-	if (! IS_ERR(device))
-		return 0;
+	if (! IS_ERR(device)) {
+		if (platform_get_drvdata(device))
+			return 0;
+		platform_device_unregister(device);
+	}
 #ifdef MODULE
 	printk(KERN_ERR "no miro soundcard found\n");
 #endif
Index: mm/sound/isa/opti9xx/opti92x-ad1848.c
===================================================================
--- mm.orig/sound/isa/opti9xx/opti92x-ad1848.c	2006-04-06 02:45:56.000000000 +0200
+++ mm/sound/isa/opti9xx/opti92x-ad1848.c	2006-04-06 02:55:05.000000000 +0200
@@ -2099,8 +2099,11 @@ static int __init alsa_card_opti9xx_init
 			return error;
 		device = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
 		if (!IS_ERR(device)) {
-			snd_opti9xx_platform_device = device;
-			return 0;
+			if (platform_get_drvdata(device)) {
+				snd_opti9xx_platform_device = device;
+				return 0;
+			}
+			platform_device_unregister(device);
 		}
 		platform_driver_unregister(&snd_opti9xx_driver);
 	}
Index: mm/sound/isa/sscape.c
===================================================================
--- mm.orig/sound/isa/sscape.c	2006-04-06 02:52:33.000000000 +0200
+++ mm/sound/isa/sscape.c	2006-04-06 02:56:48.000000000 +0200
@@ -1438,6 +1438,10 @@ static int __init sscape_manual_probe(vo
 							 i, NULL, 0);
 		if (IS_ERR(device))
 			continue;
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
 		platform_devices[i] = device;
 	}
 	return 0;





--------------030801070208010208070404--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
