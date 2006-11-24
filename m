From: Pavel Polischouk <pavelvp@inbox.ru>
Subject: [PATCH 1.0.13 1/2] M-Audio USB
Date: Thu, 23 Nov 2006 23:35:30 -0500
Message-ID: <45667692.8090600@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

This patch adds the following capabilities to usbaudio.c:
- Merges support for M-Audio FastTrack USB
- Adds proper support for M-Audio Quattro USB
- Adds hot-reload support for all Audiophile, FastTrack and Quattro. 
This works quite well on Quattro;
Thibault, could you please verify that it works for Audiophile?
- FastTrack "select configuration #2" quirk is present but #ifdef'd out 
pending inclusion of
"usb_driver_set_configuration" function in mainline kernel. This quirk 
could possibly be handled in user space anyway.

Part 2 of the patch contains documentation update.

diff -Naur --exclude '*.maudio' --exclude version.h 
alsa-driver-1.0.13.ref/alsa-kernel/usb/usbaudio.c 
alsa-driver-1.0.13/alsa-kernel/usb/usbaudio.c
--- alsa-driver-1.0.13.ref/alsa-kernel/usb/usbaudio.c    2006-09-29 
07:40:38.000000000 -0400
+++ alsa-driver-1.0.13/alsa-kernel/usb/usbaudio.c    2006-11-23 
20:19:33.000000000 -0500
@@ -2339,11 +2339,16 @@
 {
     switch (chip->usb_id) {
     case USB_ID(0x0763, 0x2001): /* M-Audio Quattro: captured data only */
-        if (fp->endpoint & USB_DIR_IN)
-            return 1;
-        break;
     case USB_ID(0x0763, 0x2003): /* M-Audio Audiophile USB */
         return 1;
+
+     case USB_ID(0x0763, 0x2012): /* M-Audio Fast Track Pro */
+         /* it depends on altsetting wether the device is big-endian or 
not */
+         if(fp->altsetting==2 || fp->altsetting==3 ||
+            fp->altsetting==5 || fp->altsetting==6)
+             return 1;
+         break;
+
     }
     return 0;
 }
@@ -2595,8 +2600,12 @@
     return 0;
 }
 
+static int quattro_skip_setting_quirk(struct snd_usb_audio *chip,
+                     int iface, int altno);
 static int audiophile_skip_setting_quirk(struct snd_usb_audio *chip,
                      int iface, int altno);
+static int fasttrackpro_skip_setting_quirk(struct snd_usb_audio *chip,
+ int iface, int altno);
 static int parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 {
     struct usb_device *dev;
@@ -2632,12 +2641,23 @@
             SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
         altno = altsd->bAlternateSetting;
     
+        /* quattro usb: skip altsets incompatible with device_setup
+         */
+        if (chip->usb_id == USB_ID(0x0763, 0x2001) &&
+            quattro_skip_setting_quirk(chip, iface_no, altno))
+            continue;
+
         /* audiophile usb: skip altsets incompatible with device_setup
          */
         if (chip->usb_id == USB_ID(0x0763, 0x2003) &&
             audiophile_skip_setting_quirk(chip, iface_no, altno))
             continue;
 
+        /* M-Audio Fast Track Pro: skip alsets incompatible with 
device_setup */
+        if (chip->usb_id == USB_ID(0x0763, 0x2012) &&
+            fasttrackpro_skip_setting_quirk(chip, iface_no, altno))
+            continue;
+
         /* get audio formats */
         fmt = snd_usb_find_csint_desc(alts->extra, alts->extralen, 
NULL, AS_GENERAL);
         if (!fmt) {
@@ -3164,44 +3184,145 @@
     return snd_usb_cm106_write_int_reg(dev, 2, 0x8004);
 }
 
+static int snd_usb_fasttrackpro_boot_quirk(struct usb_device *dev, int 
ifnum)
+{
+#if 0
+    int err;
+
+    if(dev->actconfig->desc.bConfigurationValue==1) {
+    if(ifnum==0) {
+        snd_printk(KERN_INFO "Switching to config #2\n");
+        /* This function has to be available by the usb core module.
+           if it is not avialable the boot quirk has to be left out and the
+           configuration has to be set by udev or hotplug rules */
+        err=usb_driver_set_configuration(dev,2);
+        if(err < 0) {
+        snd_printdd("error usb_driver_set_configuration: %d\n", err);
+        return -ENODEV;
+        }
+    }
+    } else {
+    snd_printk(KERN_INFO "Fast Track Pro config OK\n");
+    }
+#endif
+
+    return 0;
+}
 
 /*
  * Setup quirks
  */
-#define AUDIOPHILE_SET            0x01 /* if set, parse device_setup */
-#define AUDIOPHILE_SET_DTS              0x02 /* if set, enable DTS 
Digital Output */
-#define AUDIOPHILE_SET_96K              0x04 /* 48-96KHz rate if set, 
8-48KHz otherwise */
-#define AUDIOPHILE_SET_24B        0x08 /* 24bits sample if set, 16bits 
otherwise */
-#define AUDIOPHILE_SET_DI        0x10 /* if set, enable Digital Input */
-#define AUDIOPHILE_SET_MASK        0x1F /* bit mask for setup value */
-#define AUDIOPHILE_SET_24B_48K_DI    0x19 /* value for 
24bits+48KHz+Digital Input */
-#define AUDIOPHILE_SET_24B_48K_NOTDI    0x09 /* value for 
24bits+48KHz+No Digital Input */
-#define AUDIOPHILE_SET_16B_48K_DI    0x11 /* value for 
16bits+48KHz+Digital Input */
-#define AUDIOPHILE_SET_16B_48K_NOTDI    0x01 /* value for 
16bits+48KHz+No Digital Input */
+#define MAUDIO_SET            0x01 /* if set, parse device_setup */
+#define MAUDIO_SET_COMPATIBLE        0x80 /* if set, use only 
"win-compatible" interfaces */
+#define MAUDIO_SET_DTS              0x02 /* if set, enable DTS Digital 
Output */
+#define MAUDIO_SET_96K              0x04 /* 48-96KHz rate if set, 
8-48KHz otherwise */
+#define MAUDIO_SET_24B        0x08 /* 24bits sample if set, 16bits 
otherwise */
+#define MAUDIO_SET_DI        0x10 /* if set, enable Digital Input */
+#define MAUDIO_SET_MASK        0x1F /* bit mask for setup value */
+#define MAUDIO_SET_24B_48K_DI    0x19 /* value for 24bits+48KHz+Digital 
Input */
+#define MAUDIO_SET_24B_48K_NOTDI    0x09 /* value for 24bits+48KHz+No 
Digital Input */
+#define MAUDIO_SET_16B_48K_DI    0x11 /* value for 16bits+48KHz+Digital 
Input */
+#define MAUDIO_SET_16B_48K_NOTDI    0x01 /* value for 16bits+48KHz+No 
Digital Input */
 
+static int quattro_skip_setting_quirk(struct snd_usb_audio *chip,
+                     int iface, int altno)
+{
+    /* Reset ALL ifaces to 0 altsetting.
+       Call it for every possible altsetting of every interface. */
+    usb_set_interface(chip->dev, iface, 0);
+    snd_printdd(KERN_INFO "resetting to altsetting 0 for interface 
%d\n", iface);
+    if (device_setup[chip->index] & MAUDIO_SET) {
+        if ((device_setup[chip->index] & MAUDIO_SET_COMPATIBLE)) {
+            if((iface != 1) && (iface != 2))
+                return 1; /* skip all interfaces but 1 and 2 */
+        } else {
+            if ((iface == 1) || (iface == 2)){
+                return 1; /* skip interfaces 1 and 2 */
+            }
+            if ((device_setup[chip->index] & MAUDIO_SET_96K)
+                    && altno != 1){
+                return 1; /* skip this altsetting */
+            }
+            if ((device_setup[chip->index] & MAUDIO_SET_MASK) ==
+                    MAUDIO_SET_24B_48K_DI && altno != 2){
+                return 1; /* skip this altsetting */
+            }
+            if ((device_setup[chip->index] & MAUDIO_SET_MASK) ==
+                    MAUDIO_SET_24B_48K_NOTDI && altno != 3){
+                return 1; /* skip this altsetting */
+            }
+            if ((device_setup[chip->index] & MAUDIO_SET_MASK) ==
+                    MAUDIO_SET_16B_48K_NOTDI && altno != 4){
+                return 1; /* skip this altsetting */
+            }
+        }
+    }    
+    snd_printdd(KERN_INFO "using altsetting %d for interface %d config 
%d\n", altno, iface, device_setup[chip->index]);
+    return 0; /* keep this altsetting */
+}
 static int audiophile_skip_setting_quirk(struct snd_usb_audio *chip,
                      int iface, int altno)
 {
-    if (device_setup[chip->index] & AUDIOPHILE_SET) {
-        if ((device_setup[chip->index] & AUDIOPHILE_SET_DTS)
+    /* Reset ALL ifaces to 0 altsetting.
+       Call it for every possible altsetting of every interface. */
+    usb_set_interface(chip->dev, iface, 0);
+    if (device_setup[chip->index] & MAUDIO_SET) {
+        if ((device_setup[chip->index] & MAUDIO_SET_DTS)
             && altno != 6)
             return 1; /* skip this altsetting */
-        if ((device_setup[chip->index] & AUDIOPHILE_SET_96K)
+        if ((device_setup[chip->index] & MAUDIO_SET_96K)
             && altno != 1)
             return 1; /* skip this altsetting */
-        if ((device_setup[chip->index] & AUDIOPHILE_SET_MASK) ==
-            AUDIOPHILE_SET_24B_48K_DI && altno != 2)
+        if ((device_setup[chip->index] & MAUDIO_SET_MASK) ==
+            MAUDIO_SET_24B_48K_DI && altno != 2)
             return 1; /* skip this altsetting */
-        if ((device_setup[chip->index] & AUDIOPHILE_SET_MASK) ==
-            AUDIOPHILE_SET_24B_48K_NOTDI && altno != 3)
+        if ((device_setup[chip->index] & MAUDIO_SET_MASK) ==
+            MAUDIO_SET_24B_48K_NOTDI && altno != 3)
             return 1; /* skip this altsetting */
-        if ((device_setup[chip->index] & AUDIOPHILE_SET_MASK) ==
-            AUDIOPHILE_SET_16B_48K_DI && altno != 4)
+        if ((device_setup[chip->index] & MAUDIO_SET_MASK) ==
+            MAUDIO_SET_16B_48K_DI && altno != 4)
             return 1; /* skip this altsetting */
-        if ((device_setup[chip->index] & AUDIOPHILE_SET_MASK) ==
-            AUDIOPHILE_SET_16B_48K_NOTDI && altno != 5)
+        if ((device_setup[chip->index] & MAUDIO_SET_MASK) ==
+            MAUDIO_SET_16B_48K_NOTDI && altno != 5)
             return 1; /* skip this altsetting */
     }    
+    snd_printdd(KERN_INFO "using altsetting %d for interface %d config 
%d\n", altno, iface, device_setup[chip->index]);
+    return 0; /* keep this altsetting */
+}
+
+static int fasttrackpro_skip_setting_quirk(struct snd_usb_audio *chip,
+        int iface, int altno)
+{
+
+    /* Reset ALL ifaces to 0 altsetting.
+           Call it for every possible altsetting of every interface. */
+    usb_set_interface(chip->dev, iface, 0);
+    /* possible configuration where both inputs and only one output is
+       used is not supported by the current setup */
+
+    if (device_setup[chip->index] & (MAUDIO_SET | MAUDIO_SET_24B)) {
+        if(device_setup[chip->index] & MAUDIO_SET_96K){
+            if((altno != 3) && (altno != 6))
+                return 1;
+        } else if(device_setup[chip->index] & MAUDIO_SET_DI){
+            if(iface == 4)
+                return 1; /* no analog input */
+
+            if((altno != 2) && (altno != 5))
+                return 1; /* enable only altsets 2 and 5 */
+        } else {
+            if(iface == 5)
+                return 1; /* disable digialt input */
+
+            if((altno != 2) && (altno != 5))
+                return 1; /* enalbe only altsets 2 and 5 */
+        }
+    } else {
+        /* keep only 16-Bit mode */
+        if(altno !=1)
+            return 1;
+    }
+
     return 0; /* keep this altsetting */
 }
 
@@ -3441,6 +3562,12 @@
             goto __err_val;
     }
 
+    /* M-Audio Fast Track Pro */
+    if (id == USB_ID(0x0763, 0x2012)) {
+        if (snd_usb_fasttrackpro_boot_quirk(dev, ifnum) < 0)
+            goto __err_val;
+    }
+
     /*
      * found a config.  now register to ALSA
      */


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
