From: Thibault Le Meur <Thibault.LeMeur@supelec.fr>
Subject: RE : RE :  M-Audio Audiophile USB,
	native little	endian  (S16_LE) ?
Date: Wed, 11 Jul 2007 23:48:03 +0200
Message-ID: <20070711234803.ar9mahpbks0sogc0@webmail.supelec.fr>
References: <012401c7c3a7$a1719a00$161ce4a0@supelec.fr>
	<012501c7c3a8$77077d10$161ce4a0@supelec.fr>
	<s5hwsx7i5e7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_7e5wmq3mg8co"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpn.supelec.fr (smtpn.supelec.fr [160.228.120.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 50FA81038F1
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2007 23:48:06 +0200 (CEST)
In-Reply-To: <s5hwsx7i5e7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, 'Hakan Lennestal' <Hakan.Lennestal@brfsodrahamn.se>
List-Id: alsa-devel@alsa-project.org

This message is in MIME format.

--=_7e5wmq3mg8co
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

>> > Ok, since Hakan reported a success for this patch, I'll
>> > prepare a new diff including Documentation update.

Here is  a slightly modified fix which takes into account a special  
case: when no device_setup is used, all interfaces are Big-endians  
even if used in 16bits modes.
So I had to add a check for device_setup beeing 0x00 or not.

Summary: Audiophile-usb fix (corrects little-endianness in 16bit  
modes, resets interfaces at device initialization, and updates the  
documentation)

Signed-Of-By: Thibault Le Meur <Thibault.LeMeur@supelec.fr>


--=_7e5wmq3mg8co
Content-Type: text/x-patch;
	charset=UTF-8;
	name="ma-audiophile_S16_LE.diff"
Content-Disposition: attachment;
	filename="ma-audiophile_S16_LE.diff"
Content-Transfer-Encoding: quoted-printable

--- orig/alsa-kernel/Documentation/Audiophile-Usb.txt=092007-07-10 21:16:06.=
000000000 +0200
+++ alsa-kernel/Documentation/Audiophile-Usb.txt=092007-07-11 23:22:16.00000=
0000 +0200
@@ -1,4 +1,4 @@
-=09Guide to using M-Audio Audiophile USB with ALSA and Jack=09v1.3
+=09Guide to using M-Audio Audiophile USB with ALSA and Jack=09v1.4
 =09=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
=20
 =09    Thibault Le Meur <Thibault.LeMeur@supelec.fr>
@@ -6,8 +6,17 @@
 This document is a guide to using the M-Audio Audiophile USB (tm) device wi=
th=20
 ALSA and JACK.
=20
+History
+=3D=3D=3D=3D=3D=3D=3D
+* v1.4 - Thibault Le Meur (2007-07-11)
+ - Added Low Endianness nature of 16bits-modes
+   found by Hakan Lennestal <Hakan.Lennestal@brfsodrahamn.se>
+ - Modifying document structure
+
+
 1 - Audiophile USB Specs and correct usage
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
 This part is a reminder of important facts about the functions and limitati=
ons=20
 of the device.
=20
@@ -25,18 +34,18 @@
 The internal DAC/ADC has the following characteristics:
 * sample depth of 16 or 24 bits
 * sample rate from 8kHz to 96kHz
-* Two ports can't use different sample depths at the same time. Moreover, t=
he=20
-Audiophile USB documentation gives the following Warning: "Please exit any=
=20
-audio application running before switching between bit depths"
+* Two interfaces can't use different sample depths at the same time.
+Moreover, the Audiophile USB documentation gives the following Warning:
+"Please exit any audio application running before switching between bit dep=
ths"
=20
 Due to the USB 1.1 bandwidth limitation, a limited number of interfaces can=
 be=20
 activated at the same time depending on the audio mode selected:
- * 16-bit/48kHz =3D=3D> 4 channels in/4 channels out
+ * 16-bit/48kHz =3D=3D> 4 channels in + 4 channels out
    - Ai+Ao+Di+Do
- * 24-bit/48kHz =3D=3D> 4 channels in/2 channels out,=20
-                    or 2 channels in/4 channels out
+ * 24-bit/48kHz =3D=3D> 4 channels in + 2 channels out,=20
+                    or 2 channels in + 4 channels out
    - Ai+Ao+Do or Ai+Di+Ao or Ai+Di+Do or Di+Ao+Do
- * 24-bit/96kHz =3D=3D> 2 channels in, or 2 channels out (half duplex only)
+ * 24-bit/96kHz =3D=3D> 2 channels in _or_ 2 channels out (half duplex only=
)
    - Ai or Ao or Di or Do
=20
 Important facts about the Digital interface:
@@ -52,44 +61,53 @@
 synchronization error (for instance sound played at an odd sample rate)
=20
=20
-2 - Audiophile USB support in ALSA
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
+2 - Audiophile USB MIDI support in ALSA
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-2.1 - MIDI ports
-----------------
-The Audiophile USB MIDI ports will be automatically supported once the=20
+The Audiophile USB MIDI ports will be automatically supported once the
 following modules have been loaded:
  * snd-usb-audio
  * snd-seq-midi
=20
 No additional setting is required.
=20
-2.2 - Audio ports
------------------
+
+3 - Audiophile USB Audio support in ALSA
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Audio functions of the Audiophile USB device are handled by the snd-usb-aud=
io=20
 module. This module can work in a default mode (without any device-specific=
=20
 parameter), or in an "advanced" mode with the device-specific parameter cal=
led=20
 "device_setup".
=20
-2.2.1 - Default Alsa driver mode
-
-The default behavior of the snd-usb-audio driver is to parse the device=20
-capabilities at startup and enable all functions inside the device (includi=
ng=20
-all ports at any supported sample rates and sample depths). This approach=
=20
-has the advantage to let the driver easily switch from sample rates/depths=
=20
-automatically according to the need of the application claiming the device.
+3.1 - Default Alsa driver mode
+------------------------------
=20
-In this case the Audiophile ports are mapped to alsa pcm devices in the=20
-following way (I suppose the device's index is 1):
+The default behavior of the snd-usb-audio driver is to list the device=20
+capabilities at startup and activate the required mode when required=20
+by the applications: for instance if the user is recording in a=20
+24bit-depth-mode and immediately after wants to switch to a 16bit-depth mod=
e,
+the snd-usb-audio module will reconfigure the device on the fly.
+
+This approach has the advantage to let the driver automatically switch from=
 sample=20
+rates/depths automatically according to the user's needs. However, those wh=
o=20
+are using the device under windows know that this is not how the device is =
meant to
+work: under windows applications must be closed before using the m-audio co=
ntrol
+panel to switch the device working mode. Thus as we'll see in next section,=
 this=20
+Default Alsa driver mode can lead to device misconfigurations.
+
+Let's get back to the Default Alsa driver mode for now.  In this case the=
=20
+Audiophile interfaces are mapped to alsa pcm devices in the following=20
+way (I suppose the device's index is 1):
  * hw:1,0 is Ao in playback and Di in capture
  * hw:1,1 is Do in playback and Ai in capture
  * hw:1,2 is Do in AC3/DTS passthrough mode
=20
-You must note as well that the device uses Big Endian byte encoding so that=
=20
-supported audio format are S16_BE  for 16-bit depth modes and S24_3BE for=
=20
-24-bits depth mode. One exception is the hw:1,2 port which is Little Endian=
=20
-compliant and thus uses S16_LE.
+In this mode, the device uses Big Endian byte-encoding so that=20
+supported audio format are S16_BE for 16-bit depth modes and S24_3BE for=20
+24-bits depth mode. One exception is the hw:1,2 port which is reported=20
+to be Little Endian compliant (supposedly supporting S16_LE) but processes=
=20
+in fact only S16_BE streams.
=20
 Examples:
  * playing a S24_3BE encoded raw file to the Ao port
@@ -99,21 +117,23 @@
  * playing a S16_BE encoded raw file to the Do port
    % aplay -D hw:1,1 -c2 -t raw -r48000 -fS16_BE test.raw
=20
-If you're happy with the default Alsa driver setup and don't experience any=
=20
+If you're happy with the default Alsa driver mode and don't experience any=
=20
 issue with this mode, then you can skip the following chapter.
=20
-2.2.2 - Advanced module setup
+3.2 - Advanced module setup
+---------------------------
=20
 Due to the hardware constraints described above, the device initialization =
made=20
 by the Alsa driver in default mode may result in a corrupted state of the=
=20
 device. For instance, a particularly annoying issue is that the sound captu=
red=20
-from the Ai port sounds distorted (as if boosted with an excessive high vol=
ume=20
-gain).
+from the Ai interface sounds distorted (as if boosted with an excessive hig=
h
+volume gain).
=20
 For people having this problem, the snd-usb-audio module has a new module=
=20
-parameter called "device_setup".
+parameter called "device_setup" (this parameter was introduced in kernel
+release 2.6.17)
=20
-2.2.2.1 - Initializing the working mode of the Audiophile USB
+3.2.1 - Initializing the working mode of the Audiophile USB
=20
 As far as the Audiophile USB device is concerned, this value let the user=
=20
 specify:
@@ -121,33 +141,57 @@
  * the sample rate
  * whether the Di port is used or not=20
=20
-Here is a list of supported device_setup values for this device:
- * device_setup=3D0x00 (or omitted)
-   - Alsa driver default mode
-   - maintains backward compatibility with setups that do not use this=20
-     parameter by not introducing any change
-   - results sometimes in corrupted sound as described earlier
+When initialized with "device_setup=3D0x00", the snd-usb-audio module has
+the same behaviour as when the parameter is omitted (see paragraph "Default=
=20
+Alsa driver mode" above)
+
+Others modes are described in the following subsections.
+
+3.2.1.1 - 16-bit modes
+
+The two supported modes are:
+
  * device_setup=3D0x01
    - 16bits 48kHz mode with Di disabled
    - Ai,Ao,Do can be used at the same time
    - hw:1,0 is not available in capture mode
    - hw:1,2 is not available
+
  * device_setup=3D0x11
    - 16bits 48kHz mode with Di enabled
    - Ai,Ao,Di,Do can be used at the same time
    - hw:1,0 is available in capture mode
    - hw:1,2 is not available
+
+In this modes the device operates only at 16bits-modes. Before kernel 2.6.2=
3,
+the devices where reported to be Big-Endian when in fact they were Little-E=
ndian
+so that playing a file was a matter of using:
+   % aplay -D hw:1,1 -c2 -t raw -r48000 -fS16_BE test_S16_LE.raw
+where "test_S16_LE.raw" was in fact a little-endian sample file.
+
+Thanks to Hakan Lennestal (who discovered the Little-Endiannes of the devic=
e in
+these modes) a fix has been committed (expected in kernel 2.6.23) and
+Alsa now reports Little-Endian interfaces. Thus playing a file now is as si=
mple as
+using:
+   % aplay -D hw:1,1 -c2 -t raw -r48000 -fS16_LE test_S16_LE.raw
+
+3.2.1.2 - 24-bit modes
+
+The three supported modes are:
+
  * device_setup=3D0x09
    - 24bits 48kHz mode with Di disabled
    - Ai,Ao,Do can be used at the same time
    - hw:1,0 is not available in capture mode
    - hw:1,2 is not available
+
  * device_setup=3D0x19
    - 24bits 48kHz mode with Di enabled
    - 3 ports from {Ai,Ao,Di,Do} can be used at the same time
    - hw:1,0 is available in capture mode and an active digital source must =
be=20
      connected to Di
    - hw:1,2 is not available
+
  * device_setup=3D0x0D or 0x10
    - 24bits 96kHz mode
    - Di is enabled by default for this mode but does not need to be connect=
ed=20
@@ -155,34 +199,61 @@
    - Only 1 port from {Ai,Ao,Di,Do} can be used at the same time
    - hw:1,0 is available in captured mode
    - hw:1,2 is not available
+
+In these modes the device is only Big-Endian compliant (see "Default Alsa d=
river=20
+mode" above for an aplay command example)
+
+3.2.1.3 - AC3 w/ DTS passthru mode
+
+This mode is untested, I have no AC3 compliant device to test it. I uses:
+
  * device_setup=3D0x03
    - 16bits 48kHz mode with only the Do port enabled=20
    - AC3 with DTS passthru (not tested)
    - Caution with this setup the Do port is mapped to the pcm device hw:1,0
=20
-2.2.2.2 - Setting and switching configurations with the device_setup parame=
ter
+3.2.2 - How to use the device_setup parameter
+----------------------------------------------
=20
 The parameter can be given:
+
  * By manually probing the device (as root):
    # modprobe -r snd-usb-audio
    # modprobe snd-usb-audio index=3D1 device_setup=3D0x09
+
  * Or while configuring the modules options in your modules configuration f=
ile
    - For Fedora distributions, edit the /etc/modprobe.conf file:
        alias snd-card-1 snd-usb-audio
        options snd-usb-audio index=3D1 device_setup=3D0x09
=20
-IMPORTANT NOTE WHEN SWITCHING CONFIGURATION:
--------------------------------------------
- * You may need to _first_ initialize the module with the correct device_se=
tup=20
-   parameter and _only_after_ turn on the Audiophile USB device
- * This is especially true when switching the sample depth:
+CAUTION when initializaing the device
+-------------------------------------
+
+ * Correct initialization on the device requires that device_setup is given=
 to
+   the module BEFORE the device is turned on. So, if you use the "manual pr=
obing"
+   method described above, take care to power-on the device AFTER this init=
ialization.
+
+ * Failing to respect this will lead in a misconfiguration of the device. I=
n this case
+   turn off the device, unproble the snd-usb-audio module, then probe it ag=
ain with=20
+   correct device_setup parameter and then (and only then) turn on the devi=
ce again.
+
+ * If you've correctly initialized the device in a valid mode and then want=
 to switch
+   to  another mode (possibly with another sample-depth), please use also t=
he following=20
+   procedure:
    - first turn off the device
    - de-register the snd-usb-audio module (modprobe -r)
    - change the device_setup parameter by changing the device_setup
      option in /etc/modprobe.conf=20
    - turn on the device
+ * A workaround for this last issue has been applied to kernel 2.6.23, but =
it may not
+   be enough to ensure the 'stability' of the device initialization.
=20
-2.2.2.3 - Audiophile USB's device_setup structure
+3.2.3 - Technical details for hackers
+-------------------------------------
+This section is for hackers, wanting to understand details about the device
+internals and how Alsa supports it.
+
+3.2.3.1 - Audiophile USB's device_setup structure
=20
 If you want to understand the device_setup magic numbers for the Audiophile=
=20
 USB, you need some very basic understanding of binary computation. However,=
=20
@@ -228,12 +299,12 @@
    - choosing b2 will prepare all interfaces for 24bits/96kHz but you'll
      only be able to use one at the same time
=20
-2.2.3 -  USB implementation details for this device
+3.2.3.2 -  USB implementation details for this device
=20
 You may safely skip this section if you're not interested in driver=20
-development.
+hacking.
=20
-This section describes some internal aspects of the device and summarize th=
e=20
+This section describes some internal aspects of the device and summarizes t=
he=20
 data I got by usb-snooping the windows and Linux drivers.
=20
 The M-Audio Audiophile USB has 7 USB Interfaces:
@@ -293,43 +364,45 @@
 "audiophile_skip_setting_quirk" in order to prevent AltSettings not=20
 corresponding to device_setup from being registered in the driver.
=20
-3 - Audiophile USB and Jack support
+4 - Audiophile USB and Jack support
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 This section deals with support of the Audiophile USB device in Jack.
-The main issue regarding this support is that the device is Big Endian=20
-compliant.
=20
-3.1 - Using the plug alsa plugin
---------------------------------
+There are 2 main potential issues when using Jackd with the device:
+* support for Big-Endian devices in 24-bit modes
+* support for 4-in / 4-out channels
+
+4.1 - Direct support in Jackd
+-----------------------------
+
+Jack supports big endian devices only in recent versions (thanks to
+Andreas Steinmetz for his first big-endian patch). I can't remember=20
+extacly when this support was released into jackd, let's just say that=20
+with jackd version 0.103.0 it's almost ok (just a small bug is affecting=20
+16bits Big-Endian devices, but since you've read  carefully the above=20
+paragraphs, you're now using kernel >=3D 2.6.23 and your 16bits devices=20
+are now Little Endians ;-) ).
+
+You can run jackd with the following command for playback with Ao and
+record with Ai:
+  % jackd -R -dalsa -Phw:1,0 -r48000 -p128 -n2 -D -Chw:1,1
=20
-Jack doesn't directly support big endian devices. Thus, one way to have sup=
port=20
-for this device with Alsa is to use the Alsa "plug" converter.
+4.2 - Using Alsa plughw
+-----------------------
+If you don't have a recent Jackd installed, you can downgrade to using
+the Alsa "plug" converter.
=20
 For instance here is one way to run Jack with 2 playback channels on Ao and=
 2=20
 capture channels from Ai:
   % jackd -R -dalsa -dplughw:1 -r48000 -p256 -n2 -D -Cplughw:1,1
=20
-
 However you may see the following warning message:
 "You appear to be using the ALSA software "plug" layer, probably a result o=
f=20
 using the "default" ALSA device. This is less efficient than it could be.=
=20
 Consider using a hardware device instead rather than using the plug layer."
=20
-3.2 - Patching alsa to use direct pcm device
---------------------------------------------
-A patch for Jack by Andreas Steinmetz adds support for Big Endian devices.=
=20
-However it has not been included in the CVS tree.
-
-You can find it at the following URL:
-http://sourceforge.net/tracker/index.php?func=3Ddetail&aid=3D1289682&group_=
id=3D39687&
-atid=3D425939
-
-After having applied the patch you can run jackd with the following command=
=20
-line:
-  % jackd -R -dalsa -Phw:1,0 -r48000 -p128 -n2 -D -Chw:1,1
-
-3.2 - Getting 2 input and/or output interfaces in Jack
+4.3 - Getting 2 input and/or output interfaces in Jack
 ------------------------------------------------------
=20
 As you can see, starting the Jack server this way will only enable 1 stereo
@@ -339,6 +412,7 @@
 * Jack can only open one capture device and one playback device at a time
 * The Audiophile USB is seen as 2 (or three) Alsa devices: hw:1,0, hw:1,1
   (and optionally hw:1,2)
+
 If you want to get Ai+Di and/or Ao+Do support with Jack, you would need to
 combine the Alsa devices into one logical "complex" device.
=20
@@ -348,13 +422,11 @@
 the Audiophile USB.
=20
 Enabling multiple Audiophile USB interfaces for Jackd will certainly requir=
e:
-* patching Jack with the previously mentioned "Big Endian" patch
-* patching Jackd with the MMAP_COMPLEX patch (see the ice1712 page)
-* patching the alsa-lib/src/pcm/pcm_multi.c file (see the ice1712 page)
+* Making sure your Jackd version has the MMAP_COMPLEX patch (see the ice171=
2 page)
+* (maybe) patching the alsa-lib/src/pcm/pcm_multi.c file (see the ice1712 p=
age)
 * define a multi device (combination of hw:1,0 and hw:1,1) in your .asoundr=
c
   file=20
 * start jackd with this device
=20
-I had no success in testing this for now, but this may be due to my OS
-configuration. If you have any success with this kind of setup, please
-drop me an email.
+I had no success in testing this for now, if you have any success with this=
 kind=20
+of setup, please drop me an email.
--- orig/alsa-kernel/usb/usbaudio.c=092007-07-10 21:16:07.000000000 +0200
+++ alsa-kernel/usb/usbaudio.c=092007-07-11 20:53:28.000000000 +0200
@@ -2350,7 +2350,9 @@
 =09=09=09return 1;
 =09=09break;
 =09case USB_ID(0x0763, 0x2003): /* M-Audio Audiophile USB */
-=09=09return 1;
+=09=09if (device_setup[chip->index] =3D=3D 0x00 ||
+=09=09    fp->altsetting=3D=3D1 || fp->altsetting=3D=3D2 || fp->altsetting=
=3D=3D3)
+=09=09=09return 1;
 =09}
 =09return 0;
 }
@@ -3251,6 +3253,10 @@
 static int audiophile_skip_setting_quirk(struct snd_usb_audio *chip,
 =09=09=09=09=09 int iface, int altno)
 {
+=09/* Reset ALL ifaces to 0 altsetting.=20
+=09Call it for every possible altsetting of every interface. */
+=09usb_set_interface(chip->dev, iface, 0);=20
+
 =09if (device_setup[chip->index] & AUDIOPHILE_SET) {
 =09=09if ((device_setup[chip->index] & AUDIOPHILE_SET_DTS)
 =09=09    && altno !=3D 6)

--=_7e5wmq3mg8co
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=_7e5wmq3mg8co--
