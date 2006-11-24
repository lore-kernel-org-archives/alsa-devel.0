From: Pavel Polischouk <pavelvp@inbox.ru>
Subject: [PATCH 1/2] M-Audio USB
Date: Fri, 24 Nov 2006 15:26:42 -0500
Message-ID: <45675582.9060707@inbox.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040702070902070409050006"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040702070902070409050006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Re-send, "hg export" format


--------------040702070902070409050006
Content-Type: text/plain;
 name="maudio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="maudio.patch"

# HG changeset patch
# User Pavel Polischouk <pavelvp@inbox.ru>
# Date 1164392350 18000
# Node ID d447f5a178f0d40ec98c4cde2e3d6e4d012a7f65
# Parent  6f81f7397f82b392e40c582e48a02a7c1cbd7c3e
This patch adds the following capabilities to usbaudio.c:
- Merges support for M-Audio FastTrack USB
- Adds proper support for M-Audio Quattro USB
- Adds hot-reload support for all Audiophile, FastTrack and Quattro.
- FastTrack "select configuration #2" quirk is present but #ifdef'd out
pending inclusion of "usb_driver_set_configuration" function in mainline
kernel. This quirk could possibly be handled in user space anyway.

diff -r 6f81f7397f82 -r d447f5a178f0 usb/usbaudio.c
--- a/usb/usbaudio.c	Fri Nov 24 11:50:29 2006 -0500
+++ b/usb/usbaudio.c	Fri Nov 24 13:19:10 2006 -0500
@@ -2346,11 +2346,16 @@ static int is_big_endian_format(struct s
 {
 	switch (chip->usb_id) {
 	case USB_ID(0x0763, 0x2001): /* M-Audio Quattro: captured data only */
-		if (fp->endpoint & USB_DIR_IN)
-			return 1;
-		break;
 	case USB_ID(0x0763, 0x2003): /* M-Audio Audiophile USB */
 		return 1;
+
+ 	case USB_ID(0x0763, 0x2012): /* M-Audio Fast Track Pro */
+ 		/* it depends on altsetting wether the device is big-endian or not */
+ 		if(fp->altsetting==2 || fp->altsetting==3 ||
+ 		   fp->altsetting==5 || fp->altsetting==6)
+ 			return 1;
+ 		break;
+
 	}
 	return 0;
 }
@@ -2608,8 +2613,12 @@ static int parse_audio_format(struct snd
 	return 0;
 }
 
+static int quattro_skip_setting_quirk(struct snd_usb_audio *chip,
+					 int iface, int altno);
 static int audiophile_skip_setting_quirk(struct snd_usb_audio *chip,
 					 int iface, int altno);
+static int fasttrackpro_skip_setting_quirk(struct snd_usb_audio *chip,
+ int iface, int altno);
 static int parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 {
 	struct usb_device *dev;
@@ -2645,10 +2654,21 @@ static int parse_audio_endpoints(struct 
 			SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
 		altno = altsd->bAlternateSetting;
 	
+		/* quattro usb: skip altsets incompatible with device_setup
+		 */
+		if (chip->usb_id == USB_ID(0x0763, 0x2001) && 
+		    quattro_skip_setting_quirk(chip, iface_no, altno))
+			continue;
+
 		/* audiophile usb: skip altsets incompatible with device_setup
 		 */
 		if (chip->usb_id == USB_ID(0x0763, 0x2003) && 
 		    audiophile_skip_setting_quirk(chip, iface_no, altno))
+			continue;
+
+		/* M-Audio Fast Track Pro: skip alsets incompatible with device_setup */
+		if (chip->usb_id == USB_ID(0x0763, 0x2012) &&
+		    fasttrackpro_skip_setting_quirk(chip, iface_no, altno))
 			continue;
 
 		/* get audio formats */
@@ -3175,44 +3195,140 @@ static int snd_usb_cm106_boot_quirk(stru
 	return snd_usb_cm106_write_int_reg(dev, 2, 0x8004);
 }
 
+static int snd_usb_fasttrackpro_boot_quirk(struct usb_device *dev, int ifnum)
+{
+#if 0
+    int err;
+
+    if(dev->actconfig->desc.bConfigurationValue==1) {
+	if(ifnum==0) {
+	    snd_printk(KERN_INFO "Switching to config #2\n");
+	    /* This function has to be available by the usb core module.
+	       if it is not avialable the boot quirk has to be left out and the
+	       configuration has to be set by udev or hotplug rules */
+	    err=usb_driver_set_configuration(dev,2);
+	    if(err < 0) {
+		snd_printdd("error usb_driver_set_configuration: %d\n", err);
+		return -ENODEV;
+	    }
+	}
+    } else {
+	snd_printk(KERN_INFO "Fast Track Pro config OK\n");
+    }
+#endif
+
+    return 0;
+}
 
 /*
  * Setup quirks
  */
-#define AUDIOPHILE_SET			0x01 /* if set, parse device_setup */
-#define AUDIOPHILE_SET_DTS              0x02 /* if set, enable DTS Digital Output */
-#define AUDIOPHILE_SET_96K              0x04 /* 48-96KHz rate if set, 8-48KHz otherwise */
-#define AUDIOPHILE_SET_24B		0x08 /* 24bits sample if set, 16bits otherwise */
-#define AUDIOPHILE_SET_DI		0x10 /* if set, enable Digital Input */
-#define AUDIOPHILE_SET_MASK		0x1F /* bit mask for setup value */
-#define AUDIOPHILE_SET_24B_48K_DI	0x19 /* value for 24bits+48KHz+Digital Input */
-#define AUDIOPHILE_SET_24B_48K_NOTDI	0x09 /* value for 24bits+48KHz+No Digital Input */
-#define AUDIOPHILE_SET_16B_48K_DI	0x11 /* value for 16bits+48KHz+Digital Input */
-#define AUDIOPHILE_SET_16B_48K_NOTDI	0x01 /* value for 16bits+48KHz+No Digital Input */
-
+#define MAUDIO_SET			0x01 /* if set, parse device_setup */
+#define MAUDIO_SET_COMPATIBLE		0x80 /* if set, use only "win-compatible" interfaces */
+#define MAUDIO_SET_DTS              0x02 /* if set, enable DTS Digital Output */
+#define MAUDIO_SET_96K              0x04 /* 48-96KHz rate if set, 8-48KHz otherwise */
+#define MAUDIO_SET_24B		0x08 /* 24bits sample if set, 16bits otherwise */
+#define MAUDIO_SET_DI		0x10 /* if set, enable Digital Input */
+#define MAUDIO_SET_MASK		0x1F /* bit mask for setup value */
+#define MAUDIO_SET_24B_48K_DI	0x19 /* value for 24bits+48KHz+Digital Input */
+#define MAUDIO_SET_24B_48K_NOTDI	0x09 /* value for 24bits+48KHz+No Digital Input */
+#define MAUDIO_SET_16B_48K_DI	0x11 /* value for 16bits+48KHz+Digital Input */
+#define MAUDIO_SET_16B_48K_NOTDI	0x01 /* value for 16bits+48KHz+No Digital Input */
+
+static int quattro_skip_setting_quirk(struct snd_usb_audio *chip,
+					 int iface, int altno)
+{
+	/* Reset ALL ifaces to 0 altsetting. 
+	   Call it for every possible altsetting of every interface. */
+	usb_set_interface(chip->dev, iface, 0); 
+	if (device_setup[chip->index] & MAUDIO_SET) {
+		if ((device_setup[chip->index] & MAUDIO_SET_COMPATIBLE)) {
+			if((iface != 1) && (iface != 2)) 
+				return 1; /* skip all interfaces but 1 and 2 */
+		} else {
+			if ((iface == 1) || (iface == 2))
+				return 1; /* skip interfaces 1 and 2 */
+			if ((device_setup[chip->index] & MAUDIO_SET_96K)
+			    && altno != 1)
+				return 1; /* skip this altsetting */
+			if ((device_setup[chip->index] & MAUDIO_SET_MASK) ==
+			    MAUDIO_SET_24B_48K_DI && altno != 2)
+				return 1; /* skip this altsetting */
+			if ((device_setup[chip->index] & MAUDIO_SET_MASK) ==
+			    MAUDIO_SET_24B_48K_NOTDI && altno != 3)
+				return 1; /* skip this altsetting */
+			if ((device_setup[chip->index] & MAUDIO_SET_MASK) ==
+			    MAUDIO_SET_16B_48K_NOTDI && altno != 4)
+				return 1; /* skip this altsetting */
+		}
+	}	
+	snd_printdd(KERN_INFO "using altsetting %d for interface %d config %d\n", altno, iface, device_setup[chip->index]);
+	return 0; /* keep this altsetting */
+}
 static int audiophile_skip_setting_quirk(struct snd_usb_audio *chip,
 					 int iface, int altno)
 {
-	if (device_setup[chip->index] & AUDIOPHILE_SET) {
-		if ((device_setup[chip->index] & AUDIOPHILE_SET_DTS)
+	/* Reset ALL ifaces to 0 altsetting. 
+	   Call it for every possible altsetting of every interface. */
+	usb_set_interface(chip->dev, iface, 0); 
+	if (device_setup[chip->index] & MAUDIO_SET) {
+		if ((device_setup[chip->index] & MAUDIO_SET_DTS)
 		    && altno != 6)
 			return 1; /* skip this altsetting */
-		if ((device_setup[chip->index] & AUDIOPHILE_SET_96K)
+		if ((device_setup[chip->index] & MAUDIO_SET_96K)
 		    && altno != 1)
 			return 1; /* skip this altsetting */
-		if ((device_setup[chip->index] & AUDIOPHILE_SET_MASK) ==
-		    AUDIOPHILE_SET_24B_48K_DI && altno != 2)
+		if ((device_setup[chip->index] & MAUDIO_SET_MASK) ==
+		    MAUDIO_SET_24B_48K_DI && altno != 2)
 			return 1; /* skip this altsetting */
-		if ((device_setup[chip->index] & AUDIOPHILE_SET_MASK) ==
-		    AUDIOPHILE_SET_24B_48K_NOTDI && altno != 3)
+		if ((device_setup[chip->index] & MAUDIO_SET_MASK) ==
+		    MAUDIO_SET_24B_48K_NOTDI && altno != 3)
 			return 1; /* skip this altsetting */
-		if ((device_setup[chip->index] & AUDIOPHILE_SET_MASK) ==
-		    AUDIOPHILE_SET_16B_48K_DI && altno != 4)
+		if ((device_setup[chip->index] & MAUDIO_SET_MASK) ==
+		    MAUDIO_SET_16B_48K_DI && altno != 4)
 			return 1; /* skip this altsetting */
-		if ((device_setup[chip->index] & AUDIOPHILE_SET_MASK) ==
-		    AUDIOPHILE_SET_16B_48K_NOTDI && altno != 5)
+		if ((device_setup[chip->index] & MAUDIO_SET_MASK) ==
+		    MAUDIO_SET_16B_48K_NOTDI && altno != 5)
 			return 1; /* skip this altsetting */
 	}	
+	snd_printdd(KERN_INFO "using altsetting %d for interface %d config %d\n", altno, iface, device_setup[chip->index]);
+	return 0; /* keep this altsetting */
+}
+
+static int fasttrackpro_skip_setting_quirk(struct snd_usb_audio *chip,
+		int iface, int altno)
+{
+
+	/* Reset ALL ifaces to 0 altsetting. 
+           Call it for every possible altsetting of every interface. */
+	usb_set_interface(chip->dev, iface, 0); 
+	/* possible configuration where both inputs and only one output is
+	   used is not supported by the current setup */
+
+	if (device_setup[chip->index] & (MAUDIO_SET | MAUDIO_SET_24B)) {
+		if(device_setup[chip->index] & MAUDIO_SET_96K){
+			if((altno != 3) && (altno != 6))
+				return 1;
+		} else if(device_setup[chip->index] & MAUDIO_SET_DI){
+			if(iface == 4)
+				return 1; /* no analog input */
+
+			if((altno != 2) && (altno != 5))
+				return 1; /* enable only altsets 2 and 5 */
+		} else {
+			if(iface == 5)
+				return 1; /* disable digialt input */
+
+			if((altno != 2) && (altno != 5))
+				return 1; /* enalbe only altsets 2 and 5 */
+		}
+	} else {
+		/* keep only 16-Bit mode */
+		if(altno !=1)
+			return 1;
+	}
+
+	snd_printdd(KERN_INFO "using altsetting %d for interface %d config %d\n", altno, iface, device_setup[chip->index]);
 	return 0; /* keep this altsetting */
 }
 
@@ -3452,6 +3568,12 @@ static void *snd_usb_audio_probe(struct 
 			goto __err_val;
 	}
 
+	/* M-Audio Fast Track Pro */
+	if (id == USB_ID(0x0763, 0x2012)) {
+		if (snd_usb_fasttrackpro_boot_quirk(dev, ifnum) < 0)
+			goto __err_val;
+	}
+
 	/*
 	 * found a config.  now register to ALSA
 	 */


--------------040702070902070409050006
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------040702070902070409050006
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------040702070902070409050006--
