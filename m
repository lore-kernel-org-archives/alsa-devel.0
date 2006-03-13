From: "Thibault LE MEUR" <Thibault.LeMeur@supelec.fr>
Subject: RE : [RFC][PATCH] snd-usb-audio and audiophile usb analog capture
Date: Mon, 13 Mar 2006 11:34:40 +0100
Message-ID: <07dc01c64689$bf5e25c0$a578e4a0@supelec.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_07DD_01C64692.21228DC0"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: 'Takashi Iwai' <tiwai@suse.de>, smithbone@gmail.com, sander@3v8.net, 'ronny' <ronny.tittoto@tiscali.it>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

------=_NextPart_000_07DD_01C64692.21228DC0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

Here is the new patch for the Audiophile usb device.

You'll find in this mail:
* the modifications applied to the patch
* a test report from another audiophile usb user


List of modifications since last patch:
> > Could you include it in the patch as a document put in
> > Documentation directory?  Also don't forget to update 
> > ALSA-Configuration.txt when an option is added/modified.

* ALSA-Configuration.txt modified
* Audiophile-USB.txt new documentation file

> > > +static int device_setup = 0x00; /* device specific setup
> > You don't need zero-initialization here.  A static variable
> > is guaranteed to be zero-initialized.

* zero-initialization removed.

> > Also, try not to exeed 80 columns in general :)

* I tried to limit the columns on comments

> > > +int audiophile_skip_setting_quirk(int iface, int altno);
> > 
> > Please make it a static function.

* Done.

> > Put continue to the next line.
> > Put return to the next line (in other places, too).

* Done.



Moreover, I received a test report and comments by Sander van Grieken (man
thanks for that):
> REGRESSION TEST (loading usbaudio module without options)
> ---------------------------------------------------------
> 
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1631
> 
> * trying  signal from jack input connectors
> * arecord -D plughw:0,1 -t wav -c 2 -r 96000 -f S16_LE -d 2 
> -vv test.wav
> 
> (plug conversion to 16 bits, real capture is done in 24 bits)
> 
> Slave: Hardware PCM card 1 'Audiophile USB (tm)' device 1 
> subdevice 0 Its setup is:
>   stream       : CAPTURE
>   access       : MMAP_INTERLEAVED
>   format       : S24_3BE
>   subformat    : STD
>   channels     : 2
>   rate         : 96000
>   exact rate   : 96000 (96000/1)
>   msbits       : 24
>   buffer_size  : 48000
>   period_size  : 12000
>   period_time  : 125000
>   tick_time    : 4000
>   tstamp_mode  : NONE
>   period_step  : 1
>   sleep_min    : 0
>   avail_min    : 12000
>   xfer_align   : 12000
>   start_threshold  : 1
>   stop_threshold   : 48000
>   silence_threshold: 0
>   silence_size : 0
>   boundary     : 1572864000
> 
> * trying signal from jack input connectors
> * arecord -D plughw:0,1 -t wav -c 2 -r 96000 -f S32_LE -d 2 
> -vv test.wav
> 
> (same as above, without the plug conversion)
> 
> Slave: Hardware PCM card 1 'Audiophile USB (tm)' device 1 
> subdevice 0 Its setup is:
>   stream       : CAPTURE
>   access       : MMAP_INTERLEAVED
>   format       : S24_3BE
>   subformat    : STD
>   channels     : 2
>   rate         : 96000
>   exact rate   : 96000 (96000/1)
>   msbits       : 24
>   buffer_size  : 48000
>   period_size  : 12000
>   period_time  : 125000
>   tick_time    : 4000
>   tstamp_mode  : NONE
>   period_step  : 1
>   sleep_min    : 0
>   avail_min    : 12000
>   xfer_align   : 12000
>   start_threshold  : 1
>   stop_threshold   : 48000
>   silence_threshold: 0
>   silence_size : 0
>   boundary     : 1572864000
> 
> *** conclusion: no regressions.

==> Will ensure backward compatibility.

> 
> MODES TEST
> ----------
> 
> * device_setup=0x05
> 
> expected: 16bit, 48001-96000Hz should work. instead samples 
> are 24bit (even 
> though b3 is set to '0'):
> 
> working:
> arecord -D hw:1,1 -t raw -c 2 -r 96000 -f S24_3BE -d 2 -vv test.raw
> 
> your claim '8000-96000 sampling rate' is incorrect:
> 
> any rate below 48001 will be forced to 48001
> Recording raw data 'test.raw' : Signed 24 bit Big Endian in 
> 3bytes, Rate 24000 
> Hz, Stereo
> Warning: rate is not accurate (requested = 24000Hz, got = 48001Hz)
>          please, try the plug plugin (-Dplug:hw:1,1)
> 
> seems like setting b2 implies b3=1

==> Exact, I've modified the docs to be more accurate about available setup
modes.

> 
> 
> * device_setup=0x09
> 
> works as expected:
> arecord -D hw:1,1 -t raw -c 2 -r 48000 -f S24_3BE -d 2 -vv 
> test.raw arecord -D hw:1,1 -t raw -c 2 -r 44100 -f S24_3BE -d 
> 2 -vv test.raw arecord -D hw:1,1 -t raw -c 2 -r 8000 -f 
> S24_3BE -d 2 -vv test.raw
> 
> every sample rate 8000-48000 works.
> 
> * device_setup=0x01
> 
> works as expected:
> arecord -D hw:1,1 -t raw -c 2 -r 48000 -f S16_BE -d 2 -vv 
> test.raw every sample rate 8000-48000 works.

------=_NextPart_000_07DD_01C64692.21228DC0
Content-Type: application/octet-stream;
	name="AudiophileUSB-Alsa-AnalogCapture.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="AudiophileUSB-Alsa-AnalogCapture.diff"

diff -Nru =
alsa-cvs-02282006.orig/alsa-kernel/Documentation/ALSA-Configuration.txt =
alsa-cvs-02282006/alsa-kernel/Documentation/ALSA-Configuration.txt
--- =
alsa-cvs-02282006.orig/alsa-kernel/Documentation/ALSA-Configuration.txt	=
2006-01-24 11:36:57.000000000 +0100
+++ alsa-cvs-02282006/alsa-kernel/Documentation/ALSA-Configuration.txt	=
2006-03-10 20:09:52.000000000 +0100
@@ -1372,6 +1372,9 @@
=20
     vid             - Vendor ID for the device (optional)
     pid             - Product ID for the device (optional)
+    device_setup    - Device specific magic number (optional)
+                    - Influence depends on the device
+                    - Default: 0x0000=20
=20
     This module supports multiple devices, autoprobe and hotplugging.
=20
diff -Nru =
alsa-cvs-02282006.orig/alsa-kernel/Documentation/Audiophile-Usb.txt =
alsa-cvs-02282006/alsa-kernel/Documentation/Audiophile-Usb.txt
--- alsa-cvs-02282006.orig/alsa-kernel/Documentation/Audiophile-Usb.txt	=
1970-01-01 01:00:00.000000000 +0100
+++ alsa-cvs-02282006/alsa-kernel/Documentation/Audiophile-Usb.txt	=
2006-03-13 08:01:47.000000000 +0100
@@ -0,0 +1,330 @@
+	Guide to using M-Audio Audiophile USB with ALSA and Jack	v1.1
+	=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+
+	    Thibault Le Meur <Thibault.LeMeur@supelec.fr>
+
+This document is a guide to using the M-Audio Audiophile USB (tm) =
device with=20
+ALSA and JACK.
+
+1 - Audiophile USB Specs and correct usage
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+This part is a reminder of important facts about the functions and =
limitations=20
+of the device.
+
+The device has 4 audio interfaces, and 2 MIDI ports:
+ * Analog Stereo Input (Ai)
+ * Analog Stereo Output (Ao)
+ * Digital Stereo Input (Di)
+ * Digital Stereo Output (Do)
+ * Midi In (Mi)
+ * Midi Out (Mo)
+
+The internal DAC/ADC has the following caracteristics:
+* sample depth of 16 or 24 bits
+* sample rate from 8kHz to 96kHz
+* Two ports can't use different sample depths at the same =
time.Moreover, the=20
+Audiophile USB documentation gives the following Warning: "Please exit =
any=20
+audio application running before switching between bit depths"
+
+Due to the USB 1.1 bandwidth limitation, a limited number of interfaces =
can be=20
+activated at the same time depending on the audio mode selected:
+ * 16-bit/48kHz =3D=3D> 4 channels in/ 4 channels out
+   - Ai+Ao+Di+Do
+ * 24-bit/48kHz =3D=3D> 4 channels in/2 channels out,=20
+                    or 2 channels in/4 channels out
+   - Ai+Ao+Do or Ai+Di+Ao or Ai+Di+Do or Di+Ao+Do
+ * 24-bit/96kHz =3D=3D> 2 channels in, or 2 channels out (half duplex =
only)
+   - Ai or Ao or Di or Do
+
+Important facts about the Digital interface:
+--------------------------------------------
+ * The Do port additionnaly supports surround-encoded AC-3 and DTS =
passthrough,=20
+though I haven't tested it under linux
+   - Note that in this setup only the Do interface can be enabled
+ * Apart from recording an audio digital stream, enabling the Di port =
is a way=20
+to syncrhonize the device to an external sample clock
+   - As a consequence, the Di port must be enable only if an active =
Digital=20
+source is connected
+   - Enabling Di when no digital source is connected can result in a=20
+synchronization error (for instance sound played at an odd sample rate)
+
+
+2 - Audiophile USB support in ALSA
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+2.1 - MIDI ports
+----------------
+The Audiophile USB MIDI ports will be automatically supported once the=20
+following modules have been loaded:
+ * snd-usb-audio
+ * snd-seq
+ * snd-seq-midi
+
+No additionnal setting is required.
+
+2.2 - Audio ports
+-----------------
+
+Audio functions of the Audiophile USB device are handled by the =
snd-usb-audio=20
+module. This module can work in a default mode (without any =
device-specific=20
+parameter), or in an advanced mode with the device-specific parameter =
called=20
+"device_setup".
+
+2.2.1 - Default Alsa driver mode
+
+The default behaviour of the snd-usb-audio driver is to parse the =
device=20
+capabilities at startup and enable all functions inside the device =
(including=20
+all ports at any sample rates and any sample depths supported). This =
approach=20
+has the advantage to let the driver easily switch from sample =
rates/depths=20
+automatically according to the need of the application claiming the =
device.
+
+In this case the Audiophile ports are mapped to alsa pcm devices in the =

+following way (I suppose the device's index is 1):
+ * hw:1,0 is Ao in playback and Di in capture
+ * hw:1,1 is Do in playback and Ai in capture
+ * hw:1,2 is Do in AC3/DTS passthrough mode
+
+You must note as well that the device uses Big Endian byte encoding so =
that=20
+supported audio format are S16_BE  for 16-bit depth modes and S24_3BE =
for=20
+24-bits depth mode. One exception is the hw:1,2 port which is Little =
Endian=20
+compliant and thus uses S16_LE.
+
+Examples:
+ * playing a S24_3BE encoded raw file to the Ao port
+   % aplay -D hw:1,0 -c2 -t raw -r48000 -fS24_3BE test.raw
+ * recording a  S24_3BE encoded raw file from the Ai port
+   % arecord -D hw:1,1 -c2  -t raw -r48000 -fS24_3BE test.raw
+ * playing a S16_BE encoded raw file to the Do port
+   % aplay -D hw:1,1 -c2 -t raw -r48000 -fS16_BE test.raw
+
+If you're happy with the default Alsa driver setup and don't experience =
any=20
+issue with this mode, then you can skip the following chapter.
+
+2.2.2 - Advanced module setup
+
+Due to the hardware constraints described above, the device =
initialization made=20
+by the Alsa driver in default mode may result in a corrupted state of =
the=20
+device. For instance, a particularly annoying issue is that the sound =
captured=20
+from the Ai port sounds distorted (as if boosted with an excessive high =
volume=20
+gain).
+
+For people having this problem, the snd-usb-audio module has a new =
module=20
+parameter called "device_setup".
+
+2.2.2.1 - Initializing the working mode of the Audiohile USB
+
+As far as the Audiohile USB device is concerned, this value let the =
user=20
+specify:
+ * the sample depth
+ * the sample rate
+ * whether the Di port is used or not=20
+
+Here is a list of supported device_setup values for this device:
+ * device_setup=3D0x00 (or omitted)
+   - Alsa driver default mode
+   - maintains backward compatibility with setups that do not use this=20
+     parameter by not introducing any change
+   - results sometimes in corrupted sound as decribed earlier
+ * device_setup=3D0x01
+   - 16bits 48kHz mode with Di disabled
+   - Ai,Ao,Do can be used at the same time
+   - hw:1,0 is not available in capture mode
+   - hw:1,2 is not available
+ * device_setup=3D0x11
+   - 16bits 48kHz mode with Di enabled
+   - Ai,Ao,Di,Do can be used at the same time
+   - hw:1,0 is available in capture mode
+   - hw:1,2 is not available
+ * device_setup=3D0x09
+   - 24bits 48kHz mode with Di disabled
+   - Ai,Ao,Do can be used at the same time
+   - hw:1,0 is not available in capture mode
+   - hw:1,2 is not available
+ * device_setup=3D0x19
+   - 24bits 48kHz mode with Di enabled
+   - 3 ports from {Ai,Ao,Di,Do} can be used at the same time
+   - hw:1,0 is available in capture mode and an active digital source =
must be=20
+     connected to Di
+   - hw:1,2 is not available
+ * device_setup=3D0x0D or 0x10
+   - 24bits 96kHz mode
+   - Di is enabled by default for this mode but does not need to be =
connected=20
+     to an active source
+   - Only 1 port from {Ai,Ao,Di,Do} can be used at the same time
+   - hw:1,0 is available in captured mode
+   - hw:1,2 is not available
+ * device_setup=3D0x03
+   - 16bits 48kHz mode with only the Do port enabled=20
+   - AC3 with DTS passthru (not tested)
+   - Caution with this setup the Do port is mapped to the pcm device =
hw:1,0
+
+2.2.2.2 - Setting and switching configurations with the device_setup =
parameter
+
+The parameter can be given:
+ * By manually probing the device (as root):
+   # modprobe -r snd-usb-audio
+   # modprobe snd-usb-audio index=3D1 device_setup=3D0x09
+ * Or while configuring the modules options in your modules =
configuration file
+   - For Fedora distributions, edit the /etc/modprobe.conf file:
+       alias snd-card-1 snd-usb-audio
+       options snd-usb-audio index=3D1 device_setup=3D0x09
+
+IMPORTANT NOTE WHEN SWITCHING CONFIGURATION:
+-------------------------------------------
+ * You may need to _first_ intialize the module with the correct =
device_setup=20
+   parameter and _only_after_ turn on the Audiophile USB device
+ * This is especially true when switching the sample depth:
+   - first trun off the device
+   - de-register the snd-usb-audio module
+   - change the device_setup parameter (by either manually reprobing =
the module=20
+     or changing modprobe.conf)
+   - turn on the device
+
+2.2.2.3 - Setting and switching configurations with the device_setup =
parameter
+
+If you want to understand the device_setup magic numbers for the =
Audiophile=20
+USB, you need some very basic understanding of binary computation. =
However,=20
+this is not required to use the parameter and you may skip thi section.
+
+The device_setup is one byte long and its structure is the following:
+
+       +---+---+---+---+---+---+---+---+
+       | b7| b6| b5| b4| b3| b2| b1| b0|
+       +---+---+---+---+---+---+---+---+
+       | 0 | 0 | 0 | Di|24B|96K|DTS|SET|
+       +---+---+---+---+---+---+---+---+
+
+Where:
+ * b0 is the "SET" bit
+   - it MUST be set if device_setup is initialized=20
+ * b1 is the "DTS" bit
+   - it is set only for Digital output with DTS/AC3
+   - this setup is not tested
+ * b2 is the Rate selection flag
+   - When set to "1" the rate range is 48.1-96kHz
+   - Otherwise the sample rate range is 8-48kHz
+ * b3 is the bit depth selection flag
+   - When set to "1" samples are 24bits long
+   - Otherwise they are 16bits long
+   - Note that b2 implies b3 as the 96kHz mode is only supported for 24 =
bits=20
+     samples
+ * b4 is the Digital input flag
+   - When set to "1" the device assumes that an active digital source =
is=20
+     connected=20
+   - You shouldn't enable Di if no source is seen on the port (this =
leads to=20
+     synchronization issues)
+   - b4 is implied by b2 (since only one port is enabled at a time no =
synch=20
+     error can occur)=20
+ * b5 to b7 are reserved for future uses, and must be set to "0"
+   - might become Ao, Do, Ai, for b7, b6, b4 respectively
+
+Caution:
+ * there is no check on the value you will give to device_setup
+   - for instance choosing 0x05 (16bits 96kHz) will fail back to 0x09 =
since=20
+     b2 implies b3. But _there_will_be_no_warning_ in /var/log/messages
+ * Hardware constraints due to the USB bus limitation aren't checked
+   - choosing b2 will prepare all interfaces for 24bits/96kHz but =
you'll
+     only be able to use one at the same time
+
+2.2.3 -  Technical Details for Audiophile Usb=20
+
+You may safely skip this section if you're not interrested in driver=20
+development.
+
+This section describes some internals aspect of the device and =
summarize the=20
+data I got by usb-snooping the windows and linux drivers.
+
+The M-Audio Audiophile USB has 7 Usb Interfaces:
+a "USB interface":
+ * Usb Interface n=C2=B00
+ * Usb Interface n=C2=B01
+   - Audio Control function
+ * Usb Interface n=C2=B02
+   - Analog Output
+ * Usb Interface n=C2=B03
+   - Digital Output
+ * Usb Interface n=C2=B04
+   - Analog Input
+ * Usb Interface n=C2=B05
+   - Digital Input
+ * Usb Interface n=C2=B06
+   - MIDI interface compliant with the MIDIMAN quirk=20
+
+Each interface has 5 altsettings (AltSet 1,2,3,4,5) except:
+ * Interface 3 (Digital Out) has an extra Alset n=C2=B06=20
+ * Interface 5 (Digital In) does not have Alset n=C2=B03 and 5=20
+
+Here is a short description of the AltSettings capabilities:
+ * AltSettings 1 corresponds to
+  - 24-bit depth, 48.1-96kHz sample mode
+  - Adaptive playback (Ao and Do), Synch capture (Ai), or Asynch =
capture (Di)
+ * AltSettings 2 corresponds to
+  - 24-bit depth, 8-48kHz sample mode
+  - Asynch capture and playback  (Ao,Ai,Do,Di)
+ * AltSettings 3 corresponds to
+  - 24-bit depth, 8-48kHz sample mode
+  - Synch capture (Ai) and Adaptive playback (Ao,Do)
+ * AltSettings 4 corresponds to
+  - 16-bit depth, 8-48kHz sample mode
+  - Asynch capture and playback  (Ao,Ai,Do,Di)
+ * AltSettings 5 corresponds to
+  - 16-bit depth, 8-48kHz sample mode
+  - Synch capture (Ai) and Adaptive playback (Ao,Do)
+ * AltSettings 6 corresponds to
+  - 16-bit depth, 8-48kHz sample mode
+  - Synch playback (Do), audio format type III IEC1937_AC-3
+
+In order to ensure a correct intialization of the device, the driver=20
+_must_know_ how the device will be used:
+ * if DTS is choosen, only Interface 2 with AltSet n=C2=B06 must be
+   registered
+ * if 96KHz only AltSets n=C2=B01 of each interface must be selected
+ * if samples are using 24bits/48KHz then AltSet 2 must me used if
+   Digital input is connected, and only AltSet n=C2=B03 if Digital =
input
+   is not connected
+ * if samples are using 16bits/48KHz then AltSet 4 must me used if
+   Digital input is connected, and only AltSet n=C2=B05 if Digital =
input
+   is not connected
+
+When device_setup is given as a parameter to the snd-usb-audio module, =
the=20
+parse_audio_enpoint function uses a quirk called=20
+"audiophile_skip_setting_quirk" in order to prevent AltSettings not=20
+corresponding to device_setup from being registered in the driver.
+
+3 - Audiophile USB and Jack support
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This section deals with support of the Audiophile USB device in Jack.
+The main issue regarding this support is that the device is Big Endian=20
+compliant.
+
+3.1 - Using the plug alsa plugin
+--------------------------------
+
+Jack doesn't directly support big endian devices. Thus, one way to have =
support=20
+for this device with Alsa is to use the Alsa "plug" converter.
+
+For instance here is one way to run Jack with 2 playback channels on Ao =
and 2=20
+capture channels from Ai:
+  % jackd -R -dalsa -dplughw:1 -r48000 -p256 -n2 -D -Cplughw:1,1
+
+
+However you may see the following warning message:
+"You appear to be using the ALSA software "plug" layer, probably a =
result of=20
+using the "default" ALSA device. This is less efficient than it could =
be.=20
+Consider using a hardware device instead rather than using the plug =
layer."
+
+
+3.2 - Patching alsa to use direct pcm device
+-------------------------------------------
+A patch for Jack adds support for Big Endian devices. However it has =
not been=20
+included in the CVS tree.
+
+You can find it at the following URL:
+http://sourceforge.net/tracker/index.php?func=3Ddetail&aid=3D1289682&gro=
up_id=3D39687&
+atid=3D425939
+
+After having applied the patch you can run jackd with the following =
command=20
+line:
+# /usr/local/bin/jackd -R -dalsa -Phw:1,0 -r48000 -p128 -n2 -D -Chw:1,1
+
--- alsa-cvs-02282006.orig2/alsa-driver/usb/usbaudio.c	2006-03-05 =
21:41:48.000000000 +0100
+++ alsa-cvs-02282006/alsa-driver/usb/usbaudio.c	2006-03-10 =
20:01:28.000000000 +0100
@@ -76,6 +76,7 @@
 #else
 0; /* disabled as default for buggy async-unlink handling */
 #endif
+static int device_setup; /* device parameter for this card*/
=20
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for the USB audio adapter.");
@@ -91,6 +92,8 @@
 MODULE_PARM_DESC(nrpacks, "Max. number of packets per URB.");
 module_param(async_unlink, bool, 0444);
 MODULE_PARM_DESC(async_unlink, "Use async unlink mode.");
+module_param(device_setup, int, 0444);
+MODULE_PARM_DESC(device_setup, "Specific device setup (if needed).");
=20
=20
 /*
@@ -2547,6 +2550,7 @@
 	return 0;
 }
=20
+static int audiophile_skip_setting_quirk(int iface, int altno);
 static int parse_audio_endpoints(struct snd_usb_audio *chip, int =
iface_no)
 {
 	struct usb_device *dev;
@@ -2585,6 +2589,11 @@
 		stream =3D (get_endpoint(alts, 0)->bEndpointAddress & USB_DIR_IN) ?
 			SNDRV_PCM_STREAM_CAPTURE : SNDRV_PCM_STREAM_PLAYBACK;
 		altno =3D altsd->bAlternateSetting;
+=09
+		/* audiophile usb: skip altsets incompatible with device_setup */
+		if (chip->usb_id =3D=3D USB_ID(0x0763, 0x2003) &&=20
+		    audiophile_skip_setting_quirk(iface_no,altno))
+			continue;
=20
 		/* get audio formats */
 		fmt =3D snd_usb_find_csint_desc(alts->extra, alts->extralen, NULL, =
AS_GENERAL);
@@ -2683,7 +2692,7 @@
 			continue;
 		}
=20
-		snd_printdd(KERN_INFO "%d:%u:%d: add audio endpoint 0x%x\n", =
dev->devnum, iface_no, i, fp->endpoint);
+		snd_printdd(KERN_INFO "%d:%u:%d: add audio endpoint 0x%x\n", =
dev->devnum, iface_no, altno, fp->endpoint);
 		err =3D add_audio_endpoint(chip, stream, fp);
 		if (err < 0) {
 			kfree(fp->rate_table);
@@ -3112,6 +3121,41 @@
 	return 0;
 }
=20
+/*
+ * Setup quirks
+ */
+#define AUDIOPHILE_SET			0x01 /* if set, parse device_setup */
+#define AUDIOPHILE_SET_DTS              0x02 /* if set, enable DTS =
Digital Output */
+#define AUDIOPHILE_SET_96K              0x04 /* 48-96KHz rate if set, =
8-48KHz otherwise */
+#define AUDIOPHILE_SET_24B              0x08 /* 24bits sample if set, =
16bits otherwise */
+#define AUDIOPHILE_SET_DI               0x10 /* if set, enable Digital =
Input */
+#define AUDIOPHILE_SET_MASK      	0x1F /* bit mask for setup value */
+#define AUDIOPHILE_SET_24B_48K_DI	0x19 /* value for =
24bits+48KHz+Digital Input */
+#define AUDIOPHILE_SET_24B_48K_NOTDI 	0x09 /* value for 24bits+48KHz+No =
Digital Input */
+#define AUDIOPHILE_SET_16B_48K_DI    	0x11 /* value for =
16bits+48KHz+Digital Input */
+#define AUDIOPHILE_SET_16B_48K_NOTDI 	0x01 /* value for 16bits+48KHz+No =
Digital Input */
+
+int audiophile_skip_setting_quirk(int iface, int altno) {
+	if (device_setup & AUDIOPHILE_SET) {
+		if ((device_setup & AUDIOPHILE_SET_DTS) && altno !=3D 6)
+			return 1; /* skip this altsetting */
+		if ((device_setup & AUDIOPHILE_SET_96K) && altno !=3D 1)
+			return 1; /* skip this altsetting */
+		if ((device_setup & AUDIOPHILE_SET_MASK) =3D=3D =
AUDIOPHILE_SET_24B_48K_DI &&
+		     altno !=3D 2)
+			return 1; /* skip this altsetting */
+		if ((device_setup & AUDIOPHILE_SET_MASK) =3D=3D =
AUDIOPHILE_SET_24B_48K_NOTDI &&
+		     altno !=3D 3)
+			return 1; /* skip this altsetting */
+		if ((device_setup & AUDIOPHILE_SET_MASK) =3D=3D =
AUDIOPHILE_SET_16B_48K_DI &&
+		     altno !=3D 4)
+			return 1; /* skip this altsetting */
+		if ((device_setup & AUDIOPHILE_SET_MASK) =3D=3D =
AUDIOPHILE_SET_16B_48K_NOTDI &&
+		     altno !=3D 5)
+			return 1; /* skip this altsetting */
+	}=09
+	return 0; /* keep this altsetting */
+}
=20
 /*
  * audio-interface quirks

------=_NextPart_000_07DD_01C64692.21228DC0--




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
