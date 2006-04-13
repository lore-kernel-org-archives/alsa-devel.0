From: Rene Herman <rene.herman@keyaccess.nl>
Subject: [ALSA 1/2] a few more -- continue on IS_ERR from platform device
 registration
Date: Thu, 13 Apr 2006 03:41:40 +0200
Message-ID: <443DAC54.5010801__45236.9246435866$1144892478$gmane$org@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040701090302030204060606"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq3.tilbu1.nb.home.nl (smtpq3.tilbu1.nb.home.nl [213.51.146.202])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 57C0814B
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2006 03:40:02 +0200 (MEST)
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
--------------040701090302030204060606
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi

I previously only concerned myself with sound/isa. When I now checked
for more platform_device_register_simple() usages in ALSA I found a
couple more drivers that needed the same patches as already submitted
for all the ISA drivers.

This first one is the continue-on-iserr patch for sound/drivers. This
gets them all.

   sound/drivers/dummy.c         |   14 ++++----------
   sound/drivers/mpu401/mpu401.c |   14 ++++----------
   sound/drivers/serial-u16550.c |   14 ++++----------
   sound/drivers/virmidi.c       |   14 ++++----------
   4 files changed, 16 insertions(+), 40 deletions(-)

Signed-off-by: Rene Herman <rene.herman@keyaccess.nl>


--------------040701090302030204060606
Content-Type: text/plain;
 name="alsa_platform_iserr_remainder.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_platform_iserr_remainder.diff"

Index: mm/sound/drivers/mpu401/mpu401.c
===================================================================
--- mm.orig/sound/drivers/mpu401/mpu401.c	2006-04-13 01:37:08.000000000 +0200
+++ mm/sound/drivers/mpu401/mpu401.c	2006-04-13 01:37:40.000000000 +0200
@@ -252,10 +252,8 @@ static int __init alsa_card_mpu401_init(
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
 		snd_mpu401_devices++;
 	}
@@ -267,14 +265,10 @@ static int __init alsa_card_mpu401_init(
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
Index: mm/sound/drivers/serial-u16550.c
===================================================================
--- mm.orig/sound/drivers/serial-u16550.c	2006-04-13 01:36:54.000000000 +0200
+++ mm/sound/drivers/serial-u16550.c	2006-04-13 01:37:40.000000000 +0200
@@ -996,10 +996,8 @@ static int __init alsa_card_serial_init(
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
@@ -1007,14 +1005,10 @@ static int __init alsa_card_serial_init(
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
Index: mm/sound/drivers/virmidi.c
===================================================================
--- mm.orig/sound/drivers/virmidi.c	2006-04-13 01:36:54.000000000 +0200
+++ mm/sound/drivers/virmidi.c	2006-04-13 01:37:40.000000000 +0200
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
Index: mm/sound/drivers/dummy.c
===================================================================
--- mm.orig/sound/drivers/dummy.c	2006-04-13 01:36:54.000000000 +0200
+++ mm/sound/drivers/dummy.c	2006-04-13 01:39:12.000000000 +0200
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


--------------040701090302030204060606--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
