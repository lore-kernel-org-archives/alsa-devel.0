From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Creamware Noah, snd-usb-audio capable?
Date: Thu, 12 Feb 2004 12:02:30 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402111431430.12076-100000@studcom.urz.uni-halle.de>
References: <1076450884.3640.10.camel@chief.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1076450884.3640.10.camel@chief.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Hartmut Geissbauer <nwgbh@swissonline.ch>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hartmut Geissbauer wrote:
> I own a piece of hardware called Noah EX. It's a "tactive
> instrument modeller".
> My goal is to get this device working with the alsa usb driver,
> because the output of lsusb -v leads me to the hope, that it has a
> standard usb audio interface.
> ...
> Interface Descriptor:
>   bInterfaceClass         1 Audio
>   bInterfaceSubClass      1 Control Device
>   ...
>   bInterfaceSubClass      2 Streaming       (= PCM)
>   ...
>   bInterfaceSubClass      3 Non Streaming   (= MIDI)

Well, this device indeed has standard descriptors.

> What I discoverd yet, is that the device is offering two
> configurations. And the second is the audio and midi related one.
> The first seems to be the configuration "channel".

> Feb  5 00:28:33 chief kernel: usb 1-2.4: configuration #1 chosen from 2 choices

The problem is that the kernel automatically selects the first
configuration.  Please try the patch below.


HTH
Clemens

-- 

Index: alsa-kernel/usb/usbquirks.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbquirks.h,v
retrieving revision 1.27
diff -u -r1.27 usbquirks.h
--- alsa-kernel/usb/usbquirks.h	11 Feb 2004 12:15:55 -0000	1.27
+++ alsa-kernel/usb/usbquirks.h	12 Feb 2004 10:56:21 -0000
@@ -698,4 +698,13 @@
 	}
 },

+{
+	USB_DEVICE_VENDOR_SPEC(0x1107, 0x0102),
+	.driver_info = (unsigned long) & (const snd_usb_audio_quirk_t) {
+		.vendor_name = "CreamWare",
+		.product_name = "Noah",
+		.ifnum = QUIRK_NO_INTERFACE
+	}
+},
+
 #undef USB_DEVICE_VENDOR_SPEC
Index: alsa-kernel/usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.79
diff -u -r1.79 usbaudio.c
--- alsa-kernel/usb/usbaudio.c	9 Feb 2004 16:25:38 -0000	1.79
+++ alsa-kernel/usb/usbaudio.c	12 Feb 2004 10:56:21 -0000
@@ -2820,6 +2820,14 @@
 			goto __err_val;
 		config = dev->actconfig;
 	}
+	/* Creamware Noah needs to be set to the second configuration */
+	if (dev->descriptor.idVendor == 0x1107 && dev->descriptor.idProduct == 0x0102 &&
+	    ifnum == 0) {
+		if (get_cfg_desc(dev->actconfig)->bConfigurationValue == 1)
+			usb_set_configuration(dev, 2);
+		/* but don't actually claim interface 0 */
+		goto __err_val;
+	}

 	/*
 	 * found a config.  now register to ALSA




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
