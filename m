From: Rene Herman <rene.herman@keyaccess.nl>
Subject: [ALSA 1/2] continue on IS_ERR from platform device registration
Date: Thu, 06 Apr 2006 04:08:34 +0200
Message-ID: <44347822.9050206@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080600030206070104070702"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl [213.51.130.200])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6D12E146
	for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2006 04:07:34 +0200 (MEST)
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
--------------080600030206070104070702
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
> of the device model, but I feel it's still the correct thing to do)

If you do agree, here's both patches generated against 2.6.17-rc1-mm1.
First, the continue on IS_ERR one again.

   ad1848/ad1848.c       |   14 ++++----------
   cmi8330.c             |   14 ++++----------
   cs423x/cs4231.c       |   14 ++++----------
   cs423x/cs4236.c       |   14 ++++----------
   es1688/es1688.c       |   14 ++++----------
   es18xx.c              |   14 ++++----------
   gus/gusclassic.c      |   14 ++++----------
   gus/gusextreme.c      |   14 ++++----------
   gus/gusmax.c          |   14 ++++----------
   gus/interwave.c       |   14 ++++----------
   opl3sa2.c             |   14 ++++----------
   sb/sb16.c             |   14 ++++----------
   sb/sb8.c              |   14 ++++----------
   sgalaxy.c             |   14 ++++----------
   sscape.c              |   14 ++++----------
   wavefront/wavefront.c |   14 ++++----------
   16 files changed, 64 insertions(+), 160 deletions(-)

Rene.



--------------080600030206070104070702
Content-Type: text/plain;
 name="alsa_platform_iserr.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa_platform_iserr.diff"

Index: mm/sound/isa/ad1848/ad1848.c
===================================================================
--- mm.orig/sound/isa/ad1848/ad1848.c	2006-04-06 02:16:26.000000000 +0200
+++ mm/sound/isa/ad1848/ad1848.c	2006-04-06 02:45:56.000000000 +0200
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
--- mm.orig/sound/isa/cmi8330.c	2006-04-06 02:16:26.000000000 +0200
+++ mm/sound/isa/cmi8330.c	2006-04-06 02:45:56.000000000 +0200
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
--- mm.orig/sound/isa/cs423x/cs4231.c	2006-04-06 02:16:26.000000000 +0200
+++ mm/sound/isa/cs423x/cs4231.c	2006-04-06 02:45:56.000000000 +0200
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
--- mm.orig/sound/isa/cs423x/cs4236.c	2006-04-06 02:16:26.000000000 +0200
+++ mm/sound/isa/cs423x/cs4236.c	2006-04-06 02:45:56.000000000 +0200
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
--- mm.orig/sound/isa/es1688/es1688.c	2006-04-06 02:16:26.000000000 +0200
+++ mm/sound/isa/es1688/es1688.c	2006-04-06 02:45:56.000000000 +0200
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
--- mm.orig/sound/isa/gus/gusclassic.c	2006-04-06 02:16:26.000000000 +0200
+++ mm/sound/isa/gus/gusclassic.c	2006-04-06 02:45:56.000000000 +0200
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
--- mm.orig/sound/isa/gus/gusextreme.c	2006-04-06 02:16:26.000000000 +0200
+++ mm/sound/isa/gus/gusextreme.c	2006-04-06 02:45:56.000000000 +0200
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
--- mm.orig/sound/isa/gus/gusmax.c	2006-04-06 02:16:26.000000000 +0200
+++ mm/sound/isa/gus/gusmax.c	2006-04-06 02:45:56.000000000 +0200
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
--- mm.orig/sound/isa/gus/interwave.c	2006-04-06 02:16:26.000000000 +0200
+++ mm/sound/isa/gus/interwave.c	2006-04-06 02:45:56.000000000 +0200
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
--- mm.orig/sound/isa/opl3sa2.c	2006-04-06 02:16:26.000000000 +0200
+++ mm/sound/isa/opl3sa2.c	2006-04-06 02:45:56.000000000 +0200
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
--- mm.orig/sound/isa/sb/sb16.c	2006-04-06 02:16:26.000000000 +0200
+++ mm/sound/isa/sb/sb16.c	2006-04-06 02:45:56.000000000 +0200
@@ -721,10 +721,8 @@ static int __init alsa_card_sb16_init(vo
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
@@ -746,14 +744,10 @@ static int __init alsa_card_sb16_init(vo
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
--- mm.orig/sound/isa/sb/sb8.c	2006-04-06 02:16:26.000000000 +0200
+++ mm/sound/isa/sb/sb8.c	2006-04-06 02:45:56.000000000 +0200
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
--- mm.orig/sound/isa/sgalaxy.c	2006-04-06 02:16:26.000000000 +0200
+++ mm/sound/isa/sgalaxy.c	2006-04-06 02:45:56.000000000 +0200
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
--- mm.orig/sound/isa/wavefront/wavefront.c	2006-04-06 02:16:26.000000000 +0200
+++ mm/sound/isa/wavefront/wavefront.c	2006-04-06 02:45:56.000000000 +0200
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
Index: mm/sound/isa/es18xx.c
===================================================================
--- mm.orig/sound/isa/es18xx.c	2006-04-06 02:28:33.000000000 +0200
+++ mm/sound/isa/es18xx.c	2006-04-06 02:45:56.000000000 +0200
@@ -2392,10 +2392,8 @@ static int __init alsa_card_es18xx_init(
 			continue;
 		device = platform_device_register_simple(ES18XX_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			err = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+	       		continue;
 		platform_devices[i] = device;
 		cards++;
 	}
@@ -2412,14 +2410,10 @@ static int __init alsa_card_es18xx_init(
 #ifdef MODULE
 		snd_printk(KERN_ERR "ESS AudioDrive ES18xx soundcard not found or device busy\n");
 #endif
-		err = -ENODEV;
-		goto errout;
+		snd_es18xx_unregister_all();
+		return -ENODEV;
 	}
 	return 0;
-
- errout:
-	snd_es18xx_unregister_all();
-	return err;
 }
 
 static void __exit alsa_card_es18xx_exit(void)
Index: mm/sound/isa/sscape.c
===================================================================
--- mm.orig/sound/isa/sscape.c	2006-04-06 02:08:30.000000000 +0200
+++ mm/sound/isa/sscape.c	2006-04-06 02:52:33.000000000 +0200
@@ -1427,8 +1427,8 @@ static int __init sscape_manual_probe(vo
 		    dma[i] == SNDRV_AUTO_DMA) {
 			printk(KERN_INFO
 			       "sscape: insufficient parameters, need IO, IRQ, MPU-IRQ and DMA\n");
-			ret = -ENXIO;
-			goto errout;
+			sscape_unregister_all();
+			return -ENXIO;
 		}
 
 		/*
@@ -1436,17 +1436,11 @@ static int __init sscape_manual_probe(vo
 		 */
 		device = platform_device_register_simple(SSCAPE_DRIVER,
 							 i, NULL, 0);
-		if (IS_ERR(device)) {
-			ret = PTR_ERR(device);
-			goto errout;
-		}
+		if (IS_ERR(device))
+			continue;
 		platform_devices[i] = device;
 	}
 	return 0;
-
- errout:
-	sscape_unregister_all();
-	return ret;
 }
 
 static void sscape_exit(void)


--------------080600030206070104070702--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
