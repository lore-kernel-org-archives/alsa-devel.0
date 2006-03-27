From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ALSA] ISA drivers bailing on first IS_ERR
Date: Mon, 27 Mar 2006 23:59:51 +0200
Message-ID: <44286057.6080200@keyaccess.nl>
References: <4423848E.9030805@keyaccess.nl> <s5hslp8nlpk.wl%tiwai@suse.de> <4424912F.2080109@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080204040509000907060002"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq3.tilbu1.nb.home.nl (smtpq3.tilbu1.nb.home.nl [213.51.146.202])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 675821E6
	for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2006 23:59:47 +0200 (MEST)
In-Reply-To: <4424912F.2080109@keyaccess.nl>
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
Cc: Greg Kroah-Hartman <gregkh@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080204040509000907060002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rene Herman wrote:

>> These looks OK to me.  Could you regenerate patches against the latest
>> git (or ALSA CVS) ?
>>
>> Or, it might be better against to mm tree, since pnp registrations
>> will be modified there, too.  They should go also to mainstream
>> together.
> 
> Will do.

Attached. This was in fact really just regenerating (against 2.6.16-mm1)
Description:

If platform_driver_register_simple() now returns the probe() method 
error, the init loop should not bail on the first IS_ERR, but try the 
next one.

  sound/isa/ad1848/ad1848.c       |   14 ++++----------
  sound/isa/cmi8330.c             |   14 ++++----------
  sound/isa/cs423x/cs4231.c       |   14 ++++----------
  sound/isa/cs423x/cs4236.c       |   14 ++++----------
  sound/isa/es1688/es1688.c       |   14 ++++----------
  sound/isa/gus/gusclassic.c      |   14 ++++----------
  sound/isa/gus/gusextreme.c      |   14 ++++----------
  sound/isa/gus/gusmax.c          |   14 ++++----------
  sound/isa/gus/interwave.c       |   14 ++++----------
  sound/isa/opl3sa2.c             |   14 ++++----------
  sound/isa/sb/sb16.c             |   14 ++++----------
  sound/isa/sb/sb8.c              |   14 ++++----------
  sound/isa/sgalaxy.c             |   14 ++++----------
  sound/isa/wavefront/wavefront.c |   14 ++++----------
  14 files changed, 56 insertions(+), 140 deletions(-)

Rene.

--------------080204040509000907060002
Content-Type: text/plain;
 name="alsa_platform_is_err.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_platform_is_err.diff"

Index: mm/sound/isa/ad1848/ad1848.c
===================================================================
--- mm.orig/sound/isa/ad1848/ad1848.c	2006-03-26 23:25:56.000000000 +0200
+++ mm/sound/isa/ad1848/ad1848.c	2006-03-27 23:15:27.000000000 +0200
@@ -193,10 +193,8 @@ static int __init alsa_card_ad1848_init(
 			continue;
 		device = platform_device_register_simple(SND_AD1848_DRIVER,
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
@@ -204,14 +202,10 @@ static int __init alsa_card_ad1848_init(
 #ifdef MODULE
 		printk(KERN_ERR "AD1848 soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_ad1848_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_ad1848_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_ad1848_exit(void)
Index: mm/sound/isa/cmi8330.c
===================================================================
--- mm.orig/sound/isa/cmi8330.c	2006-03-26 23:25:56.000000000 +0200
+++ mm/sound/isa/cmi8330.c	2006-03-27 23:15:27.000000000 +0200
@@ -699,10 +699,8 @@ static int __init alsa_card_cmi8330_init
 			continue;
 		device = platform_device_register_simple(CMI8330_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		platform_devices[i] = device;
 		cards++;
 	}
@@ -719,14 +717,10 @@ static int __init alsa_card_cmi8330_init
 #ifdef MODULE
 		snd_printk(KERN_ERR "CMI8330 not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_cmi8330_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_cmi8330_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_cmi8330_exit(void)
Index: mm/sound/isa/cs423x/cs4231.c
===================================================================
--- mm.orig/sound/isa/cs423x/cs4231.c	2006-03-26 23:25:56.000000000 +0200
+++ mm/sound/isa/cs423x/cs4231.c	2006-03-27 23:15:27.000000000 +0200
@@ -209,10 +209,8 @@ static int __init alsa_card_cs4231_init(
 			continue;
 		device = platform_device_register_simple(SND_CS4231_DRIVER,
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
@@ -220,14 +218,10 @@ static int __init alsa_card_cs4231_init(
 #ifdef MODULE
 		printk(KERN_ERR "CS4231 soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_cs4231_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_cs4231_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_cs4231_exit(void)
Index: mm/sound/isa/cs423x/cs4236.c
===================================================================
--- mm.orig/sound/isa/cs423x/cs4236.c	2006-03-26 23:25:56.000000000 +0200
+++ mm/sound/isa/cs423x/cs4236.c	2006-03-27 23:15:27.000000000 +0200
@@ -780,10 +780,8 @@ static int __init alsa_card_cs423x_init(
 			continue;
 		device = platform_device_register_simple(CS423X_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		platform_devices[i] = device;
 		snd_cs423x_devices++;
 	}
@@ -802,14 +800,10 @@ static int __init alsa_card_cs423x_init(
 #ifdef MODULE
 		printk(KERN_ERR IDENT " soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_cs423x_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_cs423x_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_cs423x_exit(void)
Index: mm/sound/isa/es1688/es1688.c
===================================================================
--- mm.orig/sound/isa/es1688/es1688.c	2006-03-26 23:25:56.000000000 +0200
+++ mm/sound/isa/es1688/es1688.c	2006-03-27 23:15:27.000000000 +0200
@@ -213,10 +213,8 @@ static int __init alsa_card_es1688_init(
 			continue;
 		device = platform_device_register_simple(ES1688_DRIVER,
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
@@ -224,14 +222,10 @@ static int __init alsa_card_es1688_init(
 #ifdef MODULE
 		printk(KERN_ERR "ESS AudioDrive ES1688 soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_es1688_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_es1688_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_es1688_exit(void)
Index: mm/sound/isa/gus/gusclassic.c
===================================================================
--- mm.orig/sound/isa/gus/gusclassic.c	2006-03-26 23:25:56.000000000 +0200
+++ mm/sound/isa/gus/gusclassic.c	2006-03-27 23:15:27.000000000 +0200
@@ -253,10 +253,8 @@ static int __init alsa_card_gusclassic_i
 			continue;
 		device = platform_device_register_simple(GUSCLASSIC_DRIVER,
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
@@ -264,14 +262,10 @@ static int __init alsa_card_gusclassic_i
 #ifdef MODULE
 		printk(KERN_ERR "GUS Classic soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_gusclassic_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_gusclassic_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_gusclassic_exit(void)
Index: mm/sound/isa/gus/gusextreme.c
===================================================================
--- mm.orig/sound/isa/gus/gusextreme.c	2006-03-26 23:25:56.000000000 +0200
+++ mm/sound/isa/gus/gusextreme.c	2006-03-27 23:15:27.000000000 +0200
@@ -363,10 +363,8 @@ static int __init alsa_card_gusextreme_i
 			continue;
 		device = platform_device_register_simple(GUSEXTREME_DRIVER,
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
@@ -374,14 +372,10 @@ static int __init alsa_card_gusextreme_i
 #ifdef MODULE
 		printk(KERN_ERR "GUS Extreme soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_gusextreme_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_gusextreme_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_gusextreme_exit(void)
Index: mm/sound/isa/gus/gusmax.c
===================================================================
--- mm.orig/sound/isa/gus/gusmax.c	2006-03-26 23:25:56.000000000 +0200
+++ mm/sound/isa/gus/gusmax.c	2006-03-27 23:15:27.000000000 +0200
@@ -390,10 +390,8 @@ static int __init alsa_card_gusmax_init(
 			continue;
 		device = platform_device_register_simple(GUSMAX_DRIVER,
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
@@ -401,14 +399,10 @@ static int __init alsa_card_gusmax_init(
 #ifdef MODULE
 		printk(KERN_ERR "GUS MAX soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_gusmax_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_gusmax_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_gusmax_exit(void)
Index: mm/sound/isa/gus/interwave.c
===================================================================
--- mm.orig/sound/isa/gus/interwave.c	2006-03-26 23:25:56.000000000 +0200
+++ mm/sound/isa/gus/interwave.c	2006-03-27 23:15:27.000000000 +0200
@@ -947,10 +947,8 @@ static int __init alsa_card_interwave_in
 #endif
 		device = platform_device_register_simple(INTERWAVE_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		platform_devices[i] = device;
 		cards++;
 	}
@@ -966,14 +964,10 @@ static int __init alsa_card_interwave_in
 #ifdef MODULE
 		printk(KERN_ERR "InterWave soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_interwave_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_interwave_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_interwave_exit(void)
Index: mm/sound/isa/opl3sa2.c
===================================================================
--- mm.orig/sound/isa/opl3sa2.c	2006-03-26 23:25:56.000000000 +0200
+++ mm/sound/isa/opl3sa2.c	2006-03-27 23:15:27.000000000 +0200
@@ -962,10 +962,8 @@ static int __init alsa_card_opl3sa2_init
 #endif
 		device = platform_device_register_simple(OPL3SA2_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		platform_devices[i] = device;
 		snd_opl3sa2_devices++;
 	}
@@ -983,14 +981,10 @@ static int __init alsa_card_opl3sa2_init
 #ifdef MODULE
 		snd_printk(KERN_ERR "Yamaha OPL3-SA soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_opl3sa2_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_opl3sa2_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_opl3sa2_exit(void)
Index: mm/sound/isa/sb/sb16.c
===================================================================
--- mm.orig/sound/isa/sb/sb16.c	2006-03-26 23:25:56.000000000 +0200
+++ mm/sound/isa/sb/sb16.c	2006-03-27 23:15:27.000000000 +0200
@@ -720,10 +720,8 @@ static int __init alsa_card_sb16_init(vo
 			continue;
 		device = platform_device_register_simple(SND_SB16_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		platform_devices[i] = device;
 		cards++;
 	}
@@ -745,14 +743,10 @@ static int __init alsa_card_sb16_init(vo
 		snd_printk(KERN_ERR "In case, if you have AWE card, try snd-sbawe module\n");
 #endif
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_sb16_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_sb16_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_sb16_exit(void)
Index: mm/sound/isa/sb/sb8.c
===================================================================
--- mm.orig/sound/isa/sb/sb8.c	2006-03-26 23:25:56.000000000 +0200
+++ mm/sound/isa/sb/sb8.c	2006-03-27 23:15:27.000000000 +0200
@@ -264,10 +264,8 @@ static int __init alsa_card_sb8_init(voi
 			continue;
 		device = platform_device_register_simple(SND_SB8_DRIVER,
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
@@ -275,14 +273,10 @@ static int __init alsa_card_sb8_init(voi
 #ifdef MODULE
 		snd_printk(KERN_ERR "Sound Blaster soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_sb8_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_sb8_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_sb8_exit(void)
Index: mm/sound/isa/sgalaxy.c
===================================================================
--- mm.orig/sound/isa/sgalaxy.c	2006-03-26 23:25:56.000000000 +0200
+++ mm/sound/isa/sgalaxy.c	2006-03-27 23:15:27.000000000 +0200
@@ -366,10 +366,8 @@ static int __init alsa_card_sgalaxy_init
 			continue;
 		device = platform_device_register_simple(SND_SGALAXY_DRIVER,
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
@@ -377,14 +375,10 @@ static int __init alsa_card_sgalaxy_init
 #ifdef MODULE
 		snd_printk(KERN_ERR "Sound Galaxy soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_sgalaxy_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_sgalaxy_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_sgalaxy_exit(void)
Index: mm/sound/isa/wavefront/wavefront.c
===================================================================
--- mm.orig/sound/isa/wavefront/wavefront.c	2006-03-26 23:25:56.000000000 +0200
+++ mm/sound/isa/wavefront/wavefront.c	2006-03-27 23:15:27.000000000 +0200
@@ -722,10 +722,8 @@ static int __init alsa_card_wavefront_in
 #endif
 		device = platform_device_register_simple(WAVEFRONT_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		platform_devices[i] = device;
 		cards++;
 	}
@@ -742,14 +740,10 @@ static int __init alsa_card_wavefront_in
 #ifdef MODULE
 		printk (KERN_ERR "No WaveFront cards found or devices busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_wavefront_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_wavefront_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_wavefront_exit(void)

--------------080204040509000907060002--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
