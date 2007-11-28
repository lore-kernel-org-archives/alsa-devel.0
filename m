From: Thibault Le Meur <Thibault.LeMeur@supelec.fr>
Subject: Re: [usb-audio] M-Audio FastTrack Pro giving invalid
 sample rates
Date: Wed, 28 Nov 2007 10:33:57 +0100
Message-ID: <474D3605.5010800@supelec.fr>
References: <474CBC60.9090408@trn.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050805030404020008080500"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.supelec.fr (smtp1.supelec.fr [160.228.120.99])
	by alsa0.perex.cz (Postfix) with ESMTP id AB6DA24B10
	for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2007 10:35:11 +0100 (CET)
In-Reply-To: <474CBC60.9090408@trn.iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic+8nhy@trn.iki.fi>
Cc: peter.oehry@gmx.li, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050805030404020008080500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Lasse K=E4rkk=E4inen a =E9crit :
> Resending because nobody reacted the last time. This is still broken
> with 2.6.23.1, except for the fact that it doesn't seem to be possible
> to adjust bConfigurationValue anymore (this is not exposed under sysfs
> at least on my system), so I am stuck with configuration 1.
>  =20

Peter Oehry once proposed a fix for this device and I think it is not=20
applied to HG yet (but I may be wrong): see thread "snd-usb-audio -=20
Driver for M-Audio Fast Track Pro".
The proposed patch is attached: I don't know if it would fix the issue=20
you're describing.

But one interesting comment may explain why it may have not been applied:
<quote>

+=BB =BB =BB /*=B7This=B7function=B7has=B7to=B7be=B7available=B7by=B7the=B7=
usb=B7core=B7module.=B7
+=BB =BB =BB =B7=B7=B7if=B7it=B7is=B7not=B7avialable=B7the=B7boot=B7quirk=
=B7has=B7to=B7be=B7left=B7out=B7and=B7the
+=BB =BB =BB =B7=B7=B7configuration=B7has=B7to=B7be=B7set=B7by=B7udev=B7o=
r=B7hotplug=B7rules=B7*/
+=BB =BB =BB err=3Dusb_driver_set_configuration(dev,2);

</quote>

I don't have this device and can't help more than that, sorry.

HTH,
Thibault



> Original message follows:
>
>
> This bug has been around for years...
>
> ALSA seems to think that the card supports a wide range of sampling
> rates, but it does not manage to set them in practice. I do not know
> which is faulty, ALSA rate setting or the USB info sent by the device,
> but the problem needs to be fixed.
>
> I did some measurements with the alsarate program, attached to my other
> post (subject: ALSA C++ API).
>
> Using bConfigurationValue=3D1 and measuring the actual rate with alsara=
te,
> I get
>
>  =20
>>>> Testing playback
>>>>        =20
> Opening ALSA device hw:0,1 at 44100 Hz.
> Got 44100 Hz, 2 channels, period 1.02 ms.
> 96.27 seconds, measured rate 45807 Hz.
>  =20
>>>> Testing capture
>>>>        =20
> Opening ALSA device hw:0,1 at 44100 Hz.
> Got 44100 Hz, 2 channels, period 1.02 ms.
> 97.29 seconds, measured rate 45330 Hz.
>
> As expected, 44.1 kHz works. The measured rate seems a bit higher than
> it should be, but I assume that this is an alsarate inaccuracy rather
> than an actual phenomenon.
>
>  =20
>>>> Testing playback
>>>>        =20
> Opening ALSA device hw:0,1 at 48000 Hz.
> Got 44100 Hz, 2 channels, period 1 ms.
> 96.27 seconds, measured rate 45808 Hz.
>  =20
>>>> Testing capture
>>>>        =20
> Opening ALSA device hw:0,1 at 48000 Hz.
> Got 48000 Hz, 2 channels, period 1 ms.
> 105.89 seconds, measured rate 45330 Hz.
>
> Using 48 kHz for playback is not possible, the
> snd_pcm_hw_params_rate_near returns a new rate of 44.1 kHz. This is all
> fine and the measured rate still is around 44.1 kHz as it should.
>
> In the capture part, we see the first problem: rate_near returned 48
> kHz, but the measured value hasn't changed. So, the application thinks
> that it is recording at 48 kHz, but ALSA only gives it data at 44.1 kHz=
.
> This is a bug in ALSA.
>
>  =20
>>>> Testing playback
>>>>        =20
> Opening ALSA device hw:0,1 at 8000 Hz.
> Got 44100 Hz, 2 channels, period 1.02 ms.
> 96.27 seconds, measured rate 45808 Hz.
>  =20
>>>> Testing capture
>>>>        =20
> Opening ALSA device hw:0,1 at 8000 Hz.
> Got 8000 Hz, 2 channels, period 2 ms.
> 17.66 seconds, measured rate 45309 Hz.
>
> Trying to use 8 kHz yields similar results to the 48 kHz test. No
> problems with playback, but the capture part reports that it is using 8
> kHz, even though it really uses 44.1 kHz.
>
>  =20
>>>> Testing playback
>>>>        =20
> Opening ALSA device hw:0,1 at 96000 Hz.
> Got 44100 Hz, 2 channels, period 1.02 ms.
> 96.27 seconds, measured rate 45808 Hz.
>  =20
>>>> Testing capture
>>>>        =20
> Opening ALSA device hw:0,1 at 96000 Hz.
> Got 48000 Hz, 2 channels, period 1 ms.
> 105.89 seconds, measured rate 45330 Hz.
>
> 96 kHz makes little difference. Now the capture rate is reported to be
> 48 kHz, but the actual rates are still always 44.1 kHz.
>
>
> That was all done using the default configuration. When using the other
> configuration, bConfigurationValue=3D2, the following results are gathe=
red:
>
>  =20
>>>> Testing playback
>>>>        =20
> Opening ALSA device hw:0,1 at 44100 Hz.
> Got 44100 Hz, 2 channels, period 1.02 ms.
> 96.27 seconds, measured rate 45808 Hz.
>  =20
>>>> Testing capture
>>>>        =20
> Opening ALSA device hw:0,1 at 44100 Hz.
> Got 44100 Hz, 2 channels, period 1.02 ms.
> 97.29 seconds, measured rate 45330 Hz.
>
> 44.1 kHz is identical to that in the other configuration.
>
>  =20
>>>> Testing playback
>>>>        =20
> Opening ALSA device hw:0,1 at 48000 Hz.
> Got 48000 Hz, 2 channels, period 1 ms.
> 96.29 seconds, measured rate 49849 Hz.
>  =20
>>>> Testing capture
>>>>        =20
> Opening ALSA device hw:0,1 at 48000 Hz.
> Got 48000 Hz, 2 channels, period 1 ms.
> 97.29 seconds, measured rate 49339 Hz.
>
> 48 kHz now works properly for both playback and capture (note: measured
> rate over 49 kHz, but the measurements displaying about 1.5 kHz too hig=
h
> is consistent).
>
>  =20
>>>> Testing playback
>>>>        =20
> Opening ALSA device hw:0,1 at 8000 Hz.
> Got 8000 Hz, 2 channels, period 2 ms.
> 15.89 seconds, measured rate 50336 Hz.
>  =20
>>>> Testing capture
>>>>        =20
> Opening ALSA device hw:0,1 at 8000 Hz.
> Got 8000 Hz, 2 channels, period 2 ms.
> 16.22 seconds, measured rate 49313 Hz.
>
> 8 kHz still doesn't work. ALSA reports that it does, but in reality
> gives 48 kHz (within the bounds of the measurement accuracy).
>
>  =20
>>>> Testing playback
>>>>        =20
> Opening ALSA device hw:0,1 at 96000 Hz.
> Got 48000 Hz, 2 channels, period 1 ms.
> 96.29 seconds, measured rate 49849 Hz.
>  =20
>>>> Testing capture
>>>>        =20
> Opening ALSA device hw:0,1 at 96000 Hz.
> Got 48000 Hz, 2 channels, period 1 ms.
> 97.29 seconds, measured rate 49339 Hz.
>
> 96 kHz works kinda like it should, except for the fact that the hardwar=
e
> should support that rate as well.
>
>
> Summa summarum:
>
> Config 1 only uses 44.1 kHz, but claims to support 8-48 kHz on capture.
> Config 2 only uses 44.1 and 48 kHz, but claims to support 8-48 kHz on
> both capture and playback.
>
> The card in reality, according to specs, supports up to 96 kHz.
> According to lspci (attached), it supports everything within the 8-96
> kHz range.
>
>  =20
> -----------------------------------------------------------------------=
-
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


--------------050805030404020008080500
Content-Type: text/x-patch;
 name="FastTrackPro.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="FastTrackPro.patch"

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

--------------050805030404020008080500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050805030404020008080500--
