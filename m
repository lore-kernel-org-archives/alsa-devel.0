From: Rene Herman <rene.herman@keyaccess.nl>
Subject: [ALSA 2/2] a few more -- unregister platform device again if probe
 was unsuccessful
Date: Thu, 13 Apr 2006 03:43:30 +0200
Message-ID: <443DACC2.5050802__26403.7441499115$1144892595$gmane$org@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010204000408050302020006"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq3.tilbu1.nb.home.nl (smtpq3.tilbu1.nb.home.nl [213.51.146.202])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9ED06D8
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2006 03:41:51 +0200 (MEST)
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
--------------010204000408050302020006
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

This second one unregisters the platform device again when the probe is
unsuccesful for sound/drivers, sound/arm/sa11xx-uda1341.c and
sound/ppc/powermac.c. This gets them all.

   sound/arm/sa11xx-uda1341.c    |   14 +++++++++-----
   sound/drivers/dummy.c         |    4 ++++
   sound/drivers/mpu401/mpu401.c |    4 ++++
   sound/drivers/mtpav.c         |   14 +++++++++-----
   sound/drivers/serial-u16550.c |    4 ++++
   sound/drivers/virmidi.c       |    4 ++++
   sound/ppc/powermac.c          |   14 +++++++++-----

Signed-off-by: Rene Herman <rene.herman@keyaccess.nl>



--------------010204000408050302020006
Content-Type: text/plain;
 name="alsa_platform_unregister_remainder.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_platform_unregister_remainder.diff"

Index: mm/sound/arm/sa11xx-uda1341.c
===================================================================
--- mm.orig/sound/arm/sa11xx-uda1341.c	2006-03-20 06:53:29.000000000 +0100
+++ mm/sound/arm/sa11xx-uda1341.c	2006-04-13 02:04:30.000000000 +0200
@@ -984,11 +984,15 @@ static int __init sa11xx_uda1341_init(vo
 	if ((err = platform_driver_register(&sa11xx_uda1341_driver)) < 0)
 		return err;
 	device = platform_device_register_simple(SA11XX_UDA1341_DRIVER, -1, NULL, 0);
-	if (IS_ERR(device)) {
-		platform_driver_unregister(&sa11xx_uda1341_driver);
-		return PTR_ERR(device);
-	}
-	return 0;
+	if (!IS_ERR(device)) {
+		if (platform_get_drvdata(device))
+			return 0;
+		platform_device_unregister(device);
+		err = -ENODEV
+	} else
+		err = PTR_ERR(device);
+	platform_driver_unregister(&sa11xx_uda1341_driver);
+	return err;
 }
 
 static void __exit sa11xx_uda1341_exit(void)
Index: mm/sound/drivers/dummy.c
===================================================================
--- mm.orig/sound/drivers/dummy.c	2006-04-13 01:45:57.000000000 +0200
+++ mm/sound/drivers/dummy.c	2006-04-13 02:05:33.000000000 +0200
@@ -677,6 +677,10 @@ static int __init alsa_card_dummy_init(v
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
Index: mm/sound/drivers/mpu401/mpu401.c
===================================================================
--- mm.orig/sound/drivers/mpu401/mpu401.c	2006-04-13 01:45:57.000000000 +0200
+++ mm/sound/drivers/mpu401/mpu401.c	2006-04-13 02:06:23.000000000 +0200
@@ -254,6 +254,10 @@ static int __init alsa_card_mpu401_init(
 							 i, NULL, 0);
 		if (IS_ERR(device))
 			continue;
+		if (!platform_get_drvdata(device)) {
+			platform_device_unregister(device);
+			continue;
+		}
 		platform_devices[i] = device;
 		snd_mpu401_devices++;
 	}
Index: mm/sound/drivers/mtpav.c
===================================================================
--- mm.orig/sound/drivers/mtpav.c	2006-04-13 01:45:57.000000000 +0200
+++ mm/sound/drivers/mtpav.c	2006-04-13 02:08:27.000000000 +0200
@@ -770,11 +770,15 @@ static int __init alsa_card_mtpav_init(v
 		return err;
 
 	device = platform_device_register_simple(SND_MTPAV_DRIVER, -1, NULL, 0);
-	if (IS_ERR(device)) {
-		platform_driver_unregister(&snd_mtpav_driver);
-		return PTR_ERR(device);
-	}
-	return 0;
+	if (!IS_ERR(device)) {
+		if (platform_get_drvdata(device))
+			return 0;
+		platform_device_unregister(device);
+		err = -ENODEV;
+	} else
+		err = PTR_ERR(device);
+	platform_driver_unregister(&snd_mtpav_driver);
+	return err;
 }
 
 static void __exit alsa_card_mtpav_exit(void)
Index: mm/sound/drivers/serial-u16550.c
===================================================================
--- mm.orig/sound/drivers/serial-u16550.c	2006-04-13 01:45:57.000000000 +0200
+++ mm/sound/drivers/serial-u16550.c	2006-04-13 02:09:07.000000000 +0200
@@ -998,6 +998,10 @@ static int __init alsa_card_serial_init(
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
Index: mm/sound/drivers/virmidi.c
===================================================================
--- mm.orig/sound/drivers/virmidi.c	2006-04-13 01:45:57.000000000 +0200
+++ mm/sound/drivers/virmidi.c	2006-04-13 02:09:53.000000000 +0200
@@ -171,6 +171,10 @@ static int __init alsa_card_virmidi_init
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
Index: mm/sound/ppc/powermac.c
===================================================================
--- mm.orig/sound/ppc/powermac.c	2006-03-20 06:53:29.000000000 +0100
+++ mm/sound/ppc/powermac.c	2006-04-13 02:11:27.000000000 +0200
@@ -188,11 +188,15 @@ static int __init alsa_card_pmac_init(vo
 	if ((err = platform_driver_register(&snd_pmac_driver)) < 0)
 		return err;
 	device = platform_device_register_simple(SND_PMAC_DRIVER, -1, NULL, 0);
-	if (IS_ERR(device)) {
-		platform_driver_unregister(&snd_pmac_driver);
-		return PTR_ERR(device);
-	}
-	return 0;
+	if (!IS_ERR(device)) {
+		if (platform_get_drvdata(device))
+			return 0;
+		platform_device_unregister(device);
+		err = -ENODEV;
+	} else
+		err = PTR_ERR(device);
+	platform_driver_unregister(&snd_pmac_driver);
+	return err;
 
 }
 


--------------010204000408050302020006--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
