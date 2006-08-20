From: Peter Oehry <peter.oehry@gmx.li>
Subject: Re: snd-usb-audio - Driver for M-Audio Fast Track Pro
Date: Sun, 20 Aug 2006 14:19:09 +0200
Message-ID: <20060820121909.817D6818B4E@zeus.olymp.home>
References: <20060808181650.llg22g6lwgcs4c0s@zeus.oda.li>
	<1155056548.23266.267914050@webmail.messagingengine.com>
	<20060808184722.6627D55E2E7@zeus.olymp.home>
	<20060808222250.kgpv3965ss0oowoo@webmail.supelec.fr>
	<20060808214138.419D4DE279@zeus.olymp.home>
	<20060809000741.7zournuj4c0wcwc8@webmail.supelec.fr>
	<20060810213340.A53144FA617@zeus.olymp.home>
	<20060811112018.8j3chcuqg4c444w4@webmail.supelec.fr>
	<20060813214825.5654969E159@zeus.olymp.home>
	<1155554196.1617.268317929@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Sun__20_Aug_2006_14_19_09_+0200_QCFuVMO=iO/J_S_Q"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1155554196.1617.268317929@webmail.messagingengine.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@lists.sourceforge.net, Thibault.LeMeur@supelec.fr
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart=_Sun__20_Aug_2006_14_19_09_+0200_QCFuVMO=iO/J_S_Q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Aug 2006 13:16:36 +0200
"Clemens Ladisch" <cladisch@fastmail.net> wrote:

> Peter Oehry wrote:
> > Thibault Le Meur <Thibault.LeMeur@supelec.fr> wrote:
> > 2. Another interesting thing is that in fact the device sensds the data
> > little endian in 16-Bit mode and big endian in 24-Bit mode.
> 
> IIRC other M-Audio devices to that, too.  The reasons seems to be that
> the device is basically big-endian, but the 16-bit interfaces are
> designed to work with Windows' usbaudio.sys.
> 
> > For what I think it should be possible to switch modes without restarting
> > the kernel module and switch on and off the device. It should be possible
> > to switch the mode by resetting all interfaces and setting up the new
> > altsets like the windows driver does. This would eventually need a new
> > proc interace
> 
> Why proc?
> 
> If the configuration needs to be changed at runtime, and if the driver
> cannot do this automatically, a mixer control would be the best solution.

I have some questions to the idea of mixer control:
- Which controls would be appropriate to select either 16 or 24 Bit?
- Is it possible to make the restriction that controls can only be changed when the interface is not used?

The windows driver has the following controls:
- Check or uncheck each interface [AnIn DigIn AnOut DigOut]
- Selection of either 16Bit or 24Bit

These controls can only be changed if the card is not used. If the settings are applied all enpoints are set to altsetting 0 and then the used endpoints are configured to the desired altsetting. Is such a behaviour possible with alsa mixer controls?

> 
> > How do I know if I also need a quirk for the midi devices?
> 
> You need a quirk when there aren't any class-specific descriptors for
> the MIDI port.
> 

I could also test the MIDI interface and it works fine without any changes. So I submit a patch that makes all basic functions of the Fast Track Pro available. I've chosen the same concept as for the Audiophile.

The boot quirk can only be used as soon as the usb_driver_set_configuration() is made available in the <linux/usb.h> header. If this function is not available the driver will only work with 16-Bit by default. But the user can change the device configuration to config #2 by a UDEV or hotplug rule.

Peter Oehry

--Multipart=_Sun__20_Aug_2006_14_19_09_+0200_QCFuVMO=iO/J_S_Q
Content-Type: text/x-patch;
 name="FastTrackPro.patch"
Content-Disposition: attachment;
 filename="FastTrackPro.patch"
Content-Transfer-Encoding: 7bit

diff -urN alsa-driver-1.0.12rc3/alsa-kernel/usb/usbaudio.c alsa-driver-1.0.12rc3_patch/alsa-kernel/usb/usbaudio.c
--- alsa-driver-1.0.12rc3/alsa-kernel/usb/usbaudio.c	2006-08-14 12:55:28.000000000 +0200
+++ alsa-driver-1.0.12rc3_patch/alsa-kernel/usb/usbaudio.c	2006-08-20 12:46:30.000000000 +0200
@@ -2306,7 +2306,15 @@
 		break;
 	case USB_ID(0x0763, 0x2003): /* M-Audio Audiophile USB */
 		return 1;
-	}
+		
+	case USB_ID(0x0763, 0x2012): /* M-Audio Fast Track Pro */
+		/* it depends on altsetting wether the device is big-endian or not */
+		if(fp->altsetting==2 || fp->altsetting==3 || 
+			 fp->altsetting==5 || fp->altsetting==6)
+			return 1;
+		break;
+		
+	}	
 	return 0;
 }
 
@@ -2551,6 +2559,8 @@
 
 static int audiophile_skip_setting_quirk(struct snd_usb_audio *chip,
 					 int iface, int altno);
+static int fasttrackpro_skip_setting_quirk(struct snd_usb_audio *chip,
+					 int iface, int altno);
 static int parse_audio_endpoints(struct snd_usb_audio *chip, int iface_no)
 {
 	struct usb_device *dev;
@@ -2592,6 +2602,11 @@
 		    audiophile_skip_setting_quirk(chip, iface_no, altno))
 			continue;
 
+		/* M-Audio Fast Track Pro: skip alsets incompatible with device_setup */
+		if (chip->usb_id == USB_ID(0x0763, 0x2012) && 
+		    fasttrackpro_skip_setting_quirk(chip, iface_no, altno))
+			continue;
+
 		/* get audio formats */
 		fmt = snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, AS_GENERAL);
 		if (!fmt) {
@@ -3118,6 +3133,28 @@
 	return snd_usb_cm106_write_int_reg(dev, 2, 0x8004);
 }
 
+static int snd_usb_fasttrackpro_boot_quirk(struct usb_device *dev, int ifnum)
+{
+	int err;
+	
+	if(dev->actconfig->desc.bConfigurationValue==1) {
+		if(ifnum==0) {
+			snd_printk(KERN_INFO "Switching to config #2\n");
+			/* This function has to be available by the usb core module. 
+			   if it is not avialable the boot quirk has to be left out and the
+			   configuration has to be set by udev or hotplug rules */
+			err=usb_driver_set_configuration(dev,2);
+			if(err < 0) {
+				snd_printdd("error usb_driver_set_configuration: %d\n", err);
+				return -ENODEV;
+			}
+		}
+	} else {
+		snd_printk(KERN_INFO "Fast Track Pro config OK\n");
+	}
+	
+	return 0;
+}
 
 /*
  * Setup quirks
@@ -3159,6 +3196,39 @@
 	return 0; /* keep this altsetting */
 }
 
+static int fasttrackpro_skip_setting_quirk(struct snd_usb_audio *chip,
+					 int iface, int altno)
+{
+	
+	/* possible configuration where both inputs and only one output is
+	   used is not supported by the current setup */
+	
+	if (device_setup[chip->index] & (AUDIOPHILE_SET | AUDIOPHILE_SET_24B)) {
+		if(device_setup[chip->index] & AUDIOPHILE_SET_96K){
+			if((altno != 3) && (altno != 6))
+				return 1;
+		}else if(device_setup[chip->index] & AUDIOPHILE_SET_DI){
+			if(iface == 4) 
+				return 1; /* no analog input */
+			
+			if((altno != 2) && (altno != 5))
+				return 1; /* enable only altsets 2 and 5 */
+		}else{
+			if(iface == 5) 
+				return 1; /* disable digialt input */
+			
+			if((altno != 2) && (altno != 5))
+				return 1; /* enalbe only altsets 2 and 5 */
+		}
+	}else{
+		/* keep only 16-Bit mode */
+		if(altno !=1) 
+			return 1;
+	}
+	
+	return 0; /* keep this altsetting */
+}
+
 /*
  * audio-interface quirks
  *
@@ -3394,6 +3464,12 @@
 		if (snd_usb_cm106_boot_quirk(dev) < 0)
 			goto __err_val;
 	}
+	
+	/* M-Audio Fast Track Pro */
+	if (id == USB_ID(0x0763, 0x2012)) { 
+		if (snd_usb_fasttrackpro_boot_quirk(dev, ifnum) < 0)
+			goto __err_val;
+	}
 
 	/*
 	 * found a config.  now register to ALSA

--Multipart=_Sun__20_Aug_2006_14_19_09_+0200_QCFuVMO=iO/J_S_Q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--Multipart=_Sun__20_Aug_2006_14_19_09_+0200_QCFuVMO=iO/J_S_Q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Multipart=_Sun__20_Aug_2006_14_19_09_+0200_QCFuVMO=iO/J_S_Q--
