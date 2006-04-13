From: Rene Herman <rene.herman@keyaccess.nl>
Subject: [ALSA STABLE 2/3] a few more -- continue on IS_ERR from platform
 device registration
Date: Thu, 13 Apr 2006 03:45:03 +0200
Message-ID: <443DAD1F.3070802__3965.89615052125$1144892650$gmane$org@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000105060902020304040909"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl [213.51.146.200])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D366810D
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2006 03:43:21 +0200 (MEST)
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
--------------000105060902020304040909
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

And continue-on-iserr for sound/drivers...

   sound/drivers/dummy.c         |   14 ++++----------
   sound/drivers/mpu401/mpu401.c |   14 ++++----------
   sound/drivers/serial-u16550.c |   14 ++++----------
   sound/drivers/virmidi.c       |   14 ++++----------
   4 files changed, 16 insertions(+), 40 deletions(-)

Signed-off-by: Rene Herman <rene.herman@keyaccess.nl>


--------------000105060902020304040909
Content-Type: text/plain;
 name="alsa_platform_iserr_remainder.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_platform_iserr_remainder.diff"

Index: local/sound/drivers/mpu401/mpu401.c
===================================================================
--- local.orig/sound/drivers/mpu401/mpu401.c	2006-04-13 03:03:18.000000000 +0200
+++ local/sound/drivers/mpu401/mpu401.c	2006-04-13 03:11:35.000000000 +0200
@@ -250,10 +250,8 @@ static int __init alsa_card_mpu401_init(
 #endif
 		device = platform_device_register_simple(SND_MPU401_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		platform_devices[i] = device;
 		devices++;
 	}
@@ -266,14 +264,10 @@ static int __init alsa_card_mpu401_init(
 #ifdef MODULE
 		printk(KERN_ERR "MPU-401 device not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_mpu401_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_mpu401_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_mpu401_exit(void)
Index: local/sound/drivers/serial-u16550.c
===================================================================
--- local.orig/sound/drivers/serial-u16550.c	2006-04-13 03:03:50.000000000 +0200
+++ local/sound/drivers/serial-u16550.c	2006-04-13 03:11:35.000000000 +0200
@@ -995,10 +995,8 @@ static int __init alsa_card_serial_init(
 			continue;
 		device = platform_device_register_simple(SND_SERIAL_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		devices[i] = device;
 		cards++;
 	}
@@ -1006,14 +1004,10 @@ static int __init alsa_card_serial_init(
 #ifdef MODULE
 		printk(KERN_ERR "serial midi soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_serial_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_serial_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_serial_exit(void)
Index: local/sound/drivers/virmidi.c
===================================================================
--- local.orig/sound/drivers/virmidi.c	2006-04-13 03:04:17.000000000 +0200
+++ local/sound/drivers/virmidi.c	2006-04-13 03:11:35.000000000 +0200
@@ -169,10 +169,8 @@ static int __init alsa_card_virmidi_init
 			continue;
 		device = platform_device_register_simple(SND_VIRMIDI_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		devices[i] = device;
 		cards++;
 	}
@@ -180,14 +178,10 @@ static int __init alsa_card_virmidi_init
 #ifdef MODULE
 		printk(KERN_ERR "Card-VirMIDI soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_virmidi_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_virmidi_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_virmidi_exit(void)
Index: local/sound/drivers/dummy.c
===================================================================
--- local.orig/sound/drivers/dummy.c	2006-04-13 03:02:43.000000000 +0200
+++ local/sound/drivers/dummy.c	2006-04-13 03:11:35.000000000 +0200
@@ -675,10 +675,8 @@ static int __init alsa_card_dummy_init(v
 			continue;
 		device = platform_device_register_simple(SND_DUMMY_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		devices[i] = device;
 		cards++;
 	}
@@ -686,14 +684,10 @@ static int __init alsa_card_dummy_init(v
 #ifdef MODULE
 		printk(KERN_ERR "Dummy soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_dummy_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_dummy_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_dummy_exit(void)


--------------000105060902020304040909--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
