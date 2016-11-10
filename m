From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 24/30] ALSA: doc: ReSTize Audiophile-USB.txt
Date: Thu, 10 Nov 2016 22:06:35 +0100
Message-ID: <20161110210641.5907-25-tiwai@suse.de>
References: <20161110210641.5907-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DE5AA2673D1
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 22:06:56 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DF680ADFA
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 21:06:53 +0000 (UTC)
In-Reply-To: <20161110210641.5907-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Another simple conversion from a plain text file.
Put to cards directory.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../audiophile-usb.rst}                            | 258 +++++++++++++++------
 Documentation/sound/cards/index.rst                |   1 +
 2 files changed, 184 insertions(+), 75 deletions(-)
 rename Documentation/sound/{alsa/Audiophile-Usb.txt => cards/audiophile-usb.rst} (81%)

diff --git a/Documentation/sound/alsa/Audiophile-Usb.txt b/Documentation/sound/cards/audiophile-usb.rst
similarity index 81%
rename from Documentation/sound/alsa/Audiophile-Usb.txt
rename to Documentation/sound/cards/audiophile-usb.rst
index e7a5ed4dcae8..a7bb5648331f 100644
--- a/Documentation/sound/alsa/Audiophile-Usb.txt
+++ b/Documentation/sound/cards/audiophile-usb.rst
@@ -1,32 +1,41 @@
-	Guide to using M-Audio Audiophile USB with ALSA and Jack	v1.5
-	========================================================
+========================================================
+Guide to using M-Audio Audiophile USB with ALSA and Jack
+========================================================
 
-	    Thibault Le Meur <Thibault.LeMeur@supelec.fr>
+v1.5
+
+Thibault Le Meur <Thibault.LeMeur@supelec.fr>
 
 This document is a guide to using the M-Audio Audiophile USB (tm) device with 
 ALSA and JACK.
 
 History
 =======
+
 * v1.4 - Thibault Le Meur (2007-07-11)
- - Added Low Endianness nature of 16bits-modes
-   found by Hakan Lennestal <Hakan.Lennestal@brfsodrahamn.se>
- - Modifying document structure
+
+  - Added Low Endianness nature of 16bits-modes
+    found by Hakan Lennestal <Hakan.Lennestal@brfsodrahamn.se>
+  - Modifying document structure
+
 * v1.5 - Thibault Le Meur (2007-07-12)
- - Added AC3/DTS passthru info
+  - Added AC3/DTS passthru info
 
 
-1 - Audiophile USB Specs and correct usage
-==========================================
+Audiophile USB Specs and correct usage
+======================================
 
 This part is a reminder of important facts about the functions and limitations 
 of the device.
 
 The device has 4 audio interfaces, and 2 MIDI ports:
+
  * Analog Stereo Input (Ai)
+
    - This port supports 2 pairs of line-level audio inputs (1/4" TS and RCA) 
    - When the 1/4" TS (jack) connectors are connected, the RCA connectors
      are disabled
+
  * Analog Stereo Output (Ao)
  * Digital Stereo Input (Di)
  * Digital Stereo Output (Do)
@@ -34,56 +43,69 @@ The device has 4 audio interfaces, and 2 MIDI ports:
  * Midi Out (Mo)
 
 The internal DAC/ADC has the following characteristics:
+
 * sample depth of 16 or 24 bits
 * sample rate from 8kHz to 96kHz
 * Two interfaces can't use different sample depths at the same time.
+
 Moreover, the Audiophile USB documentation gives the following Warning:
-"Please exit any audio application running before switching between bit depths"
+  Please exit any audio application running before switching between bit depths
 
 Due to the USB 1.1 bandwidth limitation, a limited number of interfaces can be 
 activated at the same time depending on the audio mode selected:
+
  * 16-bit/48kHz ==> 4 channels in + 4 channels out
+
    - Ai+Ao+Di+Do
+
  * 24-bit/48kHz ==> 4 channels in + 2 channels out, 
-                    or 2 channels in + 4 channels out
+   or 2 channels in + 4 channels out
+
    - Ai+Ao+Do or Ai+Di+Ao or Ai+Di+Do or Di+Ao+Do
+
  * 24-bit/96kHz ==> 2 channels in _or_ 2 channels out (half duplex only)
+
    - Ai or Ao or Di or Do
 
 Important facts about the Digital interface:
 --------------------------------------------
+
  * The Do port additionally supports surround-encoded AC-3 and DTS passthrough, 
-though I haven't tested it under Linux
+   though I haven't tested it under Linux
+
    - Note that in this setup only the Do interface can be enabled
+
  * Apart from recording an audio digital stream, enabling the Di port is a way 
-to synchronize the device to an external sample clock
+   to synchronize the device to an external sample clock
+
    - As a consequence, the Di port must be enable only if an active Digital 
-source is connected
+     source is connected
    - Enabling Di when no digital source is connected can result in a 
-synchronization error (for instance sound played at an odd sample rate)
+     synchronization error (for instance sound played at an odd sample rate)
 
 
-2 - Audiophile USB MIDI support in ALSA
-=======================================
+Audiophile USB MIDI support in ALSA
+===================================
 
 The Audiophile USB MIDI ports will be automatically supported once the
 following modules have been loaded:
+
  * snd-usb-audio
  * snd-seq-midi
 
 No additional setting is required.
 
 
-3 - Audiophile USB Audio support in ALSA
-========================================
+Audiophile USB Audio support in ALSA
+====================================
 
 Audio functions of the Audiophile USB device are handled by the snd-usb-audio 
 module. This module can work in a default mode (without any device-specific 
 parameter), or in an "advanced" mode with the device-specific parameter called 
-"device_setup".
+``device_setup``.
 
-3.1 - Default Alsa driver mode
-------------------------------
+Default Alsa driver mode
+------------------------
 
 The default behavior of the snd-usb-audio driver is to list the device 
 capabilities at startup and activate the required mode when required 
@@ -101,6 +123,7 @@ Default Alsa driver mode can lead to device misconfigurations.
 Let's get back to the Default Alsa driver mode for now.  In this case the 
 Audiophile interfaces are mapped to alsa pcm devices in the following 
 way (I suppose the device's index is 1):
+
  * hw:1,0 is Ao in playback and Di in capture
  * hw:1,1 is Do in playback and Ai in capture
  * hw:1,2 is Do in AC3/DTS passthrough mode
@@ -115,20 +138,28 @@ This has been fixed in kernel 2.6.23 and above and now the hw:1,2 interface
 is reported to be big endian in this default driver mode.
 
 Examples:
- * playing a S24_3BE encoded raw file to the Ao port
+
+ * playing a S24_3BE encoded raw file to the Ao port::
+
    % aplay -D hw:1,0 -c2 -t raw -r48000 -fS24_3BE test.raw
- * recording a  S24_3BE encoded raw file from the Ai port
+
+ * recording a  S24_3BE encoded raw file from the Ai port::
+
    % arecord -D hw:1,1 -c2  -t raw -r48000 -fS24_3BE test.raw
- * playing a S16_BE encoded raw file to the Do port
+
+ * playing a S16_BE encoded raw file to the Do port::
+
    % aplay -D hw:1,1 -c2 -t raw -r48000 -fS16_BE test.raw
- * playing an ac3 sample file to the Do port
+
+ * playing an ac3 sample file to the Do port::
+
    % aplay -D hw:1,2 --channels=6 ac3_S16_BE_encoded_file.raw
 
 If you're happy with the default Alsa driver mode and don't experience any 
 issue with this mode, then you can skip the following chapter.
 
-3.2 - Advanced module setup
----------------------------
+Advanced module setup
+---------------------
 
 Due to the hardware constraints described above, the device initialization made 
 by the Alsa driver in default mode may result in a corrupted state of the 
@@ -137,34 +168,39 @@ from the Ai interface sounds distorted (as if boosted with an excessive high
 volume gain).
 
 For people having this problem, the snd-usb-audio module has a new module 
-parameter called "device_setup" (this parameter was introduced in kernel
+parameter called ``device_setup`` (this parameter was introduced in kernel
 release 2.6.17)
 
-3.2.1 - Initializing the working mode of the Audiophile USB
+Initializing the working mode of the Audiophile USB
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 As far as the Audiophile USB device is concerned, this value let the user 
 specify:
+
  * the sample depth
  * the sample rate
  * whether the Di port is used or not 
 
-When initialized with "device_setup=0x00", the snd-usb-audio module has
+When initialized with ``device_setup=0x00``, the snd-usb-audio module has
 the same behaviour as when the parameter is omitted (see paragraph "Default 
 Alsa driver mode" above)
 
 Others modes are described in the following subsections.
 
-3.2.1.1 - 16-bit modes
+16-bit modes
+~~~~~~~~~~~~
 
 The two supported modes are:
 
- * device_setup=0x01
+ * ``device_setup=0x01``
+
    - 16bits 48kHz mode with Di disabled
    - Ai,Ao,Do can be used at the same time
    - hw:1,0 is not available in capture mode
    - hw:1,2 is not available
 
- * device_setup=0x11
+ * ``device_setup=0x11``
+
    - 16bits 48kHz mode with Di enabled
    - Ai,Ao,Di,Do can be used at the same time
    - hw:1,0 is available in capture mode
@@ -173,33 +209,43 @@ The two supported modes are:
 In this modes the device operates only at 16bits-modes. Before kernel 2.6.23,
 the devices where reported to be Big-Endian when in fact they were Little-Endian
 so that playing a file was a matter of using:
+::
+
    % aplay -D hw:1,1 -c2 -t raw -r48000 -fS16_BE test_S16_LE.raw
+
 where "test_S16_LE.raw" was in fact a little-endian sample file.
 
 Thanks to Hakan Lennestal (who discovered the Little-Endiannes of the device in
 these modes) a fix has been committed (expected in kernel 2.6.23) and
 Alsa now reports Little-Endian interfaces. Thus playing a file now is as simple as
 using:
+::
+
    % aplay -D hw:1,1 -c2 -t raw -r48000 -fS16_LE test_S16_LE.raw
 
-3.2.1.2 - 24-bit modes
+
+24-bit modes
+~~~~~~~~~~~~
 
 The three supported modes are:
 
- * device_setup=0x09
+ * ``device_setup=0x09``
+
    - 24bits 48kHz mode with Di disabled
    - Ai,Ao,Do can be used at the same time
    - hw:1,0 is not available in capture mode
    - hw:1,2 is not available
 
- * device_setup=0x19
+ * ``device_setup=0x19``
+
    - 24bits 48kHz mode with Di enabled
    - 3 ports from {Ai,Ao,Di,Do} can be used at the same time
    - hw:1,0 is available in capture mode and an active digital source must be 
      connected to Di
    - hw:1,2 is not available
 
- * device_setup=0x0D or 0x10
+ * ``device_setup=0x0D`` or ``0x10``
+
    - 24bits 96kHz mode
    - Di is enabled by default for this mode but does not need to be connected 
      to an active source
@@ -210,29 +256,35 @@ The three supported modes are:
 In these modes the device is only Big-Endian compliant (see "Default Alsa driver 
 mode" above for an aplay command example)
 
-3.2.1.3 - AC3 w/ DTS passthru mode
+AC3 w/ DTS passthru mode
+~~~~~~~~~~~~~~~~~~~~~~~~
 
 Thanks to Hakan Lennestal, I now have a report saying that this mode works.
 
- * device_setup=0x03
+ * ``device_setup=0x03``
+
    - 16bits 48kHz mode with only the Do port enabled 
    - AC3 with DTS passthru
    - Caution with this setup the Do port is mapped to the pcm device hw:1,0
 
 The command line used to playback the AC3/DTS encoded .wav-files in this mode:
+::
+
    % aplay -D hw:1,0 --channels=6 ac3_S16_LE_encoded_file.raw
 
-3.2.2 - How to use the device_setup parameter
-----------------------------------------------
+How to use the ``device_setup`` parameter
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The parameter can be given:
 
- * By manually probing the device (as root):
+ * By manually probing the device (as root):::
+
    # modprobe -r snd-usb-audio
    # modprobe snd-usb-audio index=1 device_setup=0x09
 
  * Or while configuring the modules options in your modules configuration file
-   (typically a .conf file in /etc/modprobe.d/ directory:
+   (typically a .conf file in /etc/modprobe.d/ directory:::
+
        alias snd-card-1 snd-usb-audio
        options snd-usb-audio index=1 device_setup=0x09
 
@@ -250,26 +302,31 @@ CAUTION when initializing the device
  * If you've correctly initialized the device in a valid mode and then want to switch
    to  another mode (possibly with another sample-depth), please use also the following 
    procedure:
+
    - first turn off the device
    - de-register the snd-usb-audio module (modprobe -r)
    - change the device_setup parameter by changing the device_setup
-     option in /etc/modprobe.d/*.conf
+     option in ``/etc/modprobe.d/*.conf``
    - turn on the device
+
  * A workaround for this last issue has been applied to kernel 2.6.23, but it may not
    be enough to ensure the 'stability' of the device initialization.
 
-3.2.3 - Technical details for hackers
--------------------------------------
+Technical details for hackers
+-----------------------------
+
 This section is for hackers, wanting to understand details about the device
 internals and how Alsa supports it.
 
-3.2.3.1 - Audiophile USB's device_setup structure
+Audiophile USB's ``device_setup`` structure
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 If you want to understand the device_setup magic numbers for the Audiophile 
 USB, you need some very basic understanding of binary computation. However, 
 this is not required to use the parameter and you may skip this section.
 
 The device_setup is one byte long and its structure is the following:
+::
 
        +---+---+---+---+---+---+---+---+
        | b7| b6| b5| b4| b3| b2| b1| b0|
@@ -278,38 +335,55 @@ The device_setup is one byte long and its structure is the following:
        +---+---+---+---+---+---+---+---+
 
 Where:
- * b0 is the "SET" bit
+
+ * b0 is the ``SET`` bit
+
    - it MUST be set if device_setup is initialized 
- * b1 is the "DTS" bit
+
+ * b1 is the ``DTS`` bit
+
    - it is set only for Digital output with DTS/AC3
    - this setup is not tested
+
  * b2 is the Rate selection flag
-   - When set to "1" the rate range is 48.1-96kHz
+
+   - When set to ``1`` the rate range is 48.1-96kHz
    - Otherwise the sample rate range is 8-48kHz
+
  * b3 is the bit depth selection flag
-   - When set to "1" samples are 24bits long
+
+   - When set to ``1`` samples are 24bits long
    - Otherwise they are 16bits long
    - Note that b2 implies b3 as the 96kHz mode is only supported for 24 bits 
      samples
+
  * b4 is the Digital input flag
-   - When set to "1" the device assumes that an active digital source is 
+
+   - When set to ``1`` the device assumes that an active digital source is 
      connected 
    - You shouldn't enable Di if no source is seen on the port (this leads to 
      synchronization issues)
    - b4 is implied by b2 (since only one port is enabled at a time no synch 
      error can occur) 
- * b5 to b7 are reserved for future uses, and must be set to "0"
+
+ * b5 to b7 are reserved for future uses, and must be set to ``0``
+
    - might become Ao, Do, Ai, for b7, b6, b4 respectively
 
 Caution:
+
  * there is no check on the value you will give to device_setup
+
    - for instance choosing 0x05 (16bits 96kHz) will fail back to 0x09 since 
      b2 implies b3. But _there_will_be_no_warning_ in /var/log/messages
+
  * Hardware constraints due to the USB bus limitation aren't checked
+
    - choosing b2 will prepare all interfaces for 24bits/96kHz but you'll
      only be able to use one at the same time
 
-3.2.3.2 -  USB implementation details for this device
+USB implementation details for this device
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 You may safely skip this section if you're not interested in driver 
 hacking.
@@ -319,46 +393,72 @@ data I got by usb-snooping the windows and Linux drivers.
 
 The M-Audio Audiophile USB has 7 USB Interfaces:
 a "USB interface":
+
  * USB Interface nb.0
  * USB Interface nb.1
+
    - Audio Control function
+
  * USB Interface nb.2
+
    - Analog Output
+
  * USB Interface nb.3
+
    - Digital Output
+
  * USB Interface nb.4
+
    - Analog Input
+
  * USB Interface nb.5
+
    - Digital Input
+
  * USB Interface nb.6
+
    - MIDI interface compliant with the MIDIMAN quirk 
 
 Each interface has 5 altsettings (AltSet 1,2,3,4,5) except:
+
  * Interface 3 (Digital Out) has an extra Alset nb.6 
  * Interface 5 (Digital In) does not have Alset nb.3 and 5 
 
 Here is a short description of the AltSettings capabilities:
- * AltSettings 1 corresponds to
+
+* AltSettings 1 corresponds to
+
   - 24-bit depth, 48.1-96kHz sample mode
   - Adaptive playback (Ao and Do), Synch capture (Ai), or Asynch capture (Di)
- * AltSettings 2 corresponds to
+
+* AltSettings 2 corresponds to
+
   - 24-bit depth, 8-48kHz sample mode
   - Asynch capture and playback  (Ao,Ai,Do,Di)
- * AltSettings 3 corresponds to
+
+* AltSettings 3 corresponds to
+
   - 24-bit depth, 8-48kHz sample mode
   - Synch capture (Ai) and Adaptive playback (Ao,Do)
- * AltSettings 4 corresponds to
+
+* AltSettings 4 corresponds to
+
   - 16-bit depth, 8-48kHz sample mode
   - Asynch capture and playback  (Ao,Ai,Do,Di)
- * AltSettings 5 corresponds to
+
+* AltSettings 5 corresponds to
+
   - 16-bit depth, 8-48kHz sample mode
   - Synch capture (Ai) and Adaptive playback (Ao,Do)
- * AltSettings 6 corresponds to
+
+* AltSettings 6 corresponds to
+
   - 16-bit depth, 8-48kHz sample mode
   - Synch playback (Do), audio format type III IEC1937_AC-3
 
 In order to ensure a correct initialization of the device, the driver 
-_must_know_ how the device will be used:
+*must* *know* how the device will be used:
+
  * if DTS is chosen, only Interface 2 with AltSet nb.6 must be
    registered
  * if 96KHz only AltSets nb.1 of each interface must be selected
@@ -371,20 +471,21 @@ _must_know_ how the device will be used:
 
 When device_setup is given as a parameter to the snd-usb-audio module, the 
 parse_audio_endpoints function uses a quirk called 
-"audiophile_skip_setting_quirk" in order to prevent AltSettings not 
+``audiophile_skip_setting_quirk`` in order to prevent AltSettings not 
 corresponding to device_setup from being registered in the driver.
 
-4 - Audiophile USB and Jack support
-===================================
+Audiophile USB and Jack support
+===============================
 
 This section deals with support of the Audiophile USB device in Jack.
 
 There are 2 main potential issues when using Jackd with the device:
+
 * support for Big-Endian devices in 24-bit modes
 * support for 4-in / 4-out channels
 
-4.1 - Direct support in Jackd
------------------------------
+Direct support in Jackd
+-----------------------
 
 Jack supports big endian devices only in recent versions (thanks to
 Andreas Steinmetz for his first big-endian patch). I can't remember 
@@ -396,29 +497,35 @@ are now Little Endians ;-) ).
 
 You can run jackd with the following command for playback with Ao and
 record with Ai:
+::
+
   % jackd -R -dalsa -Phw:1,0 -r48000 -p128 -n2 -D -Chw:1,1
 
-4.2 - Using Alsa plughw
------------------------
+Using Alsa plughw
+-----------------
+
 If you don't have a recent Jackd installed, you can downgrade to using
-the Alsa "plug" converter.
+the Alsa ``plug`` converter.
 
 For instance here is one way to run Jack with 2 playback channels on Ao and 2 
 capture channels from Ai:
+::
+
   % jackd -R -dalsa -dplughw:1 -r48000 -p256 -n2 -D -Cplughw:1,1
 
 However you may see the following warning message:
-"You appear to be using the ALSA software "plug" layer, probably a result of 
-using the "default" ALSA device. This is less efficient than it could be. 
-Consider using a hardware device instead rather than using the plug layer."
+  You appear to be using the ALSA software "plug" layer, probably a result of 
+  using the "default" ALSA device. This is less efficient than it could be. 
+  Consider using a hardware device instead rather than using the plug layer.
 
-4.3 - Getting 2 input and/or output interfaces in Jack
-------------------------------------------------------
+Getting 2 input and/or output interfaces in Jack
+------------------------------------------------
 
 As you can see, starting the Jack server this way will only enable 1 stereo
 input (Di or Ai) and 1 stereo output (Ao or Do).
 
 This is due to the following restrictions:
+
 * Jack can only open one capture device and one playback device at a time
 * The Audiophile USB is seen as 2 (or three) Alsa devices: hw:1,0, hw:1,1
   (and optionally hw:1,2)
@@ -432,6 +539,7 @@ It is related to another device (ice1712) but can be adapted to suit
 the Audiophile USB.
 
 Enabling multiple Audiophile USB interfaces for Jackd will certainly require:
+
 * Making sure your Jackd version has the MMAP_COMPLEX patch (see the ice1712 page)
 * (maybe) patching the alsa-lib/src/pcm/pcm_multi.c file (see the ice1712 page)
 * define a multi device (combination of hw:1,0 and hw:1,1) in your .asoundrc
diff --git a/Documentation/sound/cards/index.rst b/Documentation/sound/cards/index.rst
index 4fcb88049ccc..e92a4f7e86fc 100644
--- a/Documentation/sound/cards/index.rst
+++ b/Documentation/sound/cards/index.rst
@@ -10,3 +10,4 @@ Card-Specific Information
    audigy-mixer
    emu10k1-jack
    via82xx-mixer
+   audiophile-usb
-- 
2.10.2
