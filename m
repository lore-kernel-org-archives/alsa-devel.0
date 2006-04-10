From: Rene Herman <rene.herman@keyaccess.nl>
Subject: [ALSA STABLE 3/3] unregister platform device again if probe was unsuccessful
Date: Tue, 11 Apr 2006 01:15:14 +0200
Message-ID: <443AE702.6070308@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060303090003040009050707"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq3.tilbu1.nb.home.nl (smtpq3.tilbu1.nb.home.nl [213.51.146.202])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CCCAC188
	for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2006 01:13:45 +0200 (MEST)
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
--------------060303090003040009050707
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi

Unregister the platform device again if the probe was unsuccessful for
-stable. Against 2.6.16.2.

Could you relay this to -stable with your ack?

Rene.


--------------060303090003040009050707
Content-Type: text/plain;
 name="alsa_platform_unregister.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_platform_unregister.diff"

Index: local/sound/isa/ad1848/ad1848.c
===================================================================
--- local.orig/sound/isa/ad1848/ad1848.c	2006-04-10 23:59:58.000000000 +0200
+++ local/sound/isa/ad1848/ad1848.c	2006-04-11 00:02:46.000000000 +0200
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
Index: local/sound/isa/cmi8330.c
===================================================================
--- local.orig/sound/isa/cmi8330.c	2006-04-10 23:59:58.000000000 +0200
+++ local/sound/isa/cmi8330.c	2006-04-11 00:02:46.000000000 +0200
@@ -698,6 +698,10 @@ static int __init alsa_card_cmi8330_init
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
Index: local/sound/isa/cs423x/cs4231.c
===================================================================
--- local.orig/sound/isa/cs423x/cs4231.c	2006-04-10 23:59:58.000000000 +0200
+++ local/sound/isa/cs423x/cs4231.c	2006-04-11 00:02:46.000000000 +0200
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
Index: local/sound/isa/cs423x/cs4236.c
===================================================================
--- local.orig/sound/isa/cs423x/cs4236.c	2006-04-10 23:59:58.000000000 +0200
+++ local/sound/isa/cs423x/cs4236.c	2006-04-11 00:02:46.000000000 +0200
@@ -779,6 +779,10 @@ static int __init alsa_card_cs423x_init(
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
Index: local/sound/isa/es1688/es1688.c
===================================================================
--- local.orig/sound/isa/es1688/es1688.c	2006-04-10 23:59:58.000000000 +0200
+++ local/sound/isa/es1688/es1688.c	2006-04-11 00:02:46.000000000 +0200
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
Index: local/sound/isa/gus/gusclassic.c
===================================================================
--- local.orig/sound/isa/gus/gusclassic.c	2006-04-10 23:59:58.000000000 +0200
+++ local/sound/isa/gus/gusclassic.c	2006-04-11 00:02:47.000000000 +0200
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
Index: local/sound/isa/gus/gusextreme.c
===================================================================
--- local.orig/sound/isa/gus/gusextreme.c	2006-04-10 23:59:58.000000000 +0200
+++ local/sound/isa/gus/gusextreme.c	2006-04-11 00:02:47.000000000 +0200
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
Index: local/sound/isa/gus/gusmax.c
===================================================================
--- local.orig/sound/isa/gus/gusmax.c	2006-04-10 23:59:58.000000000 +0200
+++ local/sound/isa/gus/gusmax.c	2006-04-11 00:02:47.000000000 +0200
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
Index: local/sound/isa/gus/interwave.c
===================================================================
--- local.orig/sound/isa/gus/interwave.c	2006-04-10 23:59:58.000000000 +0200
+++ local/sound/isa/gus/interwave.c	2006-04-11 00:02:47.000000000 +0200
@@ -947,6 +947,10 @@ static int __init alsa_card_interwave_in
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
Index: local/sound/isa/opl3sa2.c
===================================================================
--- local.orig/sound/isa/opl3sa2.c	2006-04-10 23:59:58.000000000 +0200
+++ local/sound/isa/opl3sa2.c	2006-04-11 00:02:47.000000000 +0200
@@ -961,6 +961,10 @@ static int __init alsa_card_opl3sa2_init
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
Index: local/sound/isa/sb/sb16.c
===================================================================
--- local.orig/sound/isa/sb/sb16.c	2006-04-10 23:59:58.000000000 +0200
+++ local/sound/isa/sb/sb16.c	2006-04-11 00:02:47.000000000 +0200
@@ -720,6 +720,10 @@ static int __init alsa_card_sb16_init(vo
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
Index: local/sound/isa/sb/sb8.c
===================================================================
--- local.orig/sound/isa/sb/sb8.c	2006-04-10 23:59:58.000000000 +0200
+++ local/sound/isa/sb/sb8.c	2006-04-11 00:02:47.000000000 +0200
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
Index: local/sound/isa/sgalaxy.c
===================================================================
--- local.orig/sound/isa/sgalaxy.c	2006-04-10 23:59:58.000000000 +0200
+++ local/sound/isa/sgalaxy.c	2006-04-11 00:02:47.000000000 +0200
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
Index: local/sound/isa/wavefront/wavefront.c
===================================================================
--- local.orig/sound/isa/wavefront/wavefront.c	2006-04-10 23:59:58.000000000 +0200
+++ local/sound/isa/wavefront/wavefront.c	2006-04-11 00:02:47.000000000 +0200
@@ -722,6 +722,10 @@ static int __init alsa_card_wavefront_in
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
Index: local/sound/isa/es18xx.c
===================================================================
--- local.orig/sound/isa/es18xx.c	2006-04-10 23:59:58.000000000 +0200
+++ local/sound/isa/es18xx.c	2006-04-11 00:02:47.000000000 +0200
@@ -2233,6 +2233,10 @@ static int __init alsa_card_es18xx_init(
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
Index: local/sound/isa/opti9xx/opti92x-ad1848.c
===================================================================
--- local.orig/sound/isa/opti9xx/opti92x-ad1848.c	2006-04-10 20:31:35.000000000 +0200
+++ local/sound/isa/opti9xx/opti92x-ad1848.c	2006-04-11 00:02:47.000000000 +0200
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
Index: local/sound/isa/sscape.c
===================================================================
--- local.orig/sound/isa/sscape.c	2006-04-10 23:59:58.000000000 +0200
+++ local/sound/isa/sscape.c	2006-04-11 00:02:47.000000000 +0200
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


--------------060303090003040009050707--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
