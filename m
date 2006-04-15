From: Thibault Le Meur <Thibault.LeMeur@supelec.fr>
Subject: [patch] Audiophile-Usb.txt update
Date: Sat, 15 Apr 2006 08:48:54 +0200
Message-ID: <20060415084854.nin8kvjxko088wco@webmail.supelec.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_46rcg47ho76s"
Content-Transfer-Encoding: 7bit
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
Cc: kouzinopoulos@gmail.com
List-Id: alsa-devel@alsa-project.org

This message is in MIME format.

--=_46rcg47ho76s
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi,

Here is a small patch to the Audiophile-Usb.txt documentation file.

Summary: Fix typos and add information about Jack support

Signed-Of-By: Charis Kouzinopoulos <kouzinopoulos@gmail.com>
Signed-Of-By: Thibault Le Meur <Thibault.LeMeur@supelec.fr>

Thanks to Charis Kouzinopoulos who sent me the typos fix.

Thibault.

--=_46rcg47ho76s
Content-Type: text/x-patch;
	charset=ISO-8859-1;
	name="Audiophile-Usb.1.3.diff"
Content-Disposition: attachment;
	filename="Audiophile-Usb.1.3.diff"
Content-Transfer-Encoding: 7bit

--- Audiophile-Usb.txt.old	2006-04-14 09:48:55.000000000 +0200
+++ Audiophile-Usb.txt	2006-04-15 09:41:16.000000000 +0200
@@ -1,4 +1,4 @@
-	Guide to using M-Audio Audiophile USB with ALSA and Jack	v1.2
+	Guide to using M-Audio Audiophile USB with ALSA and Jack	v1.3
 	========================================================
 
 	    Thibault Le Meur <Thibault.LeMeur@supelec.fr>
@@ -22,16 +22,16 @@
  * Midi In (Mi)
  * Midi Out (Mo)
 
-The internal DAC/ADC has the following caracteristics:
+The internal DAC/ADC has the following characteristics:
 * sample depth of 16 or 24 bits
 * sample rate from 8kHz to 96kHz
-* Two ports can't use different sample depths at the same time.Moreover, the 
+* Two ports can't use different sample depths at the same time. Moreover, the 
 Audiophile USB documentation gives the following Warning: "Please exit any 
 audio application running before switching between bit depths"
 
 Due to the USB 1.1 bandwidth limitation, a limited number of interfaces can be 
 activated at the same time depending on the audio mode selected:
- * 16-bit/48kHz ==> 4 channels in/ 4 channels out
+ * 16-bit/48kHz ==> 4 channels in/4 channels out
    - Ai+Ao+Di+Do
  * 24-bit/48kHz ==> 4 channels in/2 channels out, 
                     or 2 channels in/4 channels out
@@ -41,8 +41,8 @@
 
 Important facts about the Digital interface:
 --------------------------------------------
- * The Do port additionnaly supports surround-encoded AC-3 and DTS passthrough, 
-though I haven't tested it under linux
+ * The Do port additionally supports surround-encoded AC-3 and DTS passthrough, 
+though I haven't tested it under Linux
    - Note that in this setup only the Do interface can be enabled
  * Apart from recording an audio digital stream, enabling the Di port is a way 
 to synchronize the device to an external sample clock
@@ -60,7 +60,6 @@
 The Audiophile USB MIDI ports will be automatically supported once the 
 following modules have been loaded:
  * snd-usb-audio
- * snd-seq
  * snd-seq-midi
 
 No additionnal setting is required.
@@ -70,14 +69,14 @@
 
 Audio functions of the Audiophile USB device are handled by the snd-usb-audio 
 module. This module can work in a default mode (without any device-specific 
-parameter), or in an advanced mode with the device-specific parameter called 
+parameter), or in an "advanced" mode with the device-specific parameter called 
 "device_setup".
 
 2.2.1 - Default Alsa driver mode
 
-The default behaviour of the snd-usb-audio driver is to parse the device 
+The default behavior of the snd-usb-audio driver is to parse the device 
 capabilities at startup and enable all functions inside the device (including 
-all ports at any sample rates and any sample depths supported). This approach 
+all ports at any supported sample rates and sample depths). This approach 
 has the advantage to let the driver easily switch from sample rates/depths 
 automatically according to the need of the application claiming the device.
 
@@ -114,9 +113,9 @@
 For people having this problem, the snd-usb-audio module has a new module 
 parameter called "device_setup".
 
-2.2.2.1 - Initializing the working mode of the Audiohile USB
+2.2.2.1 - Initializing the working mode of the Audiophile USB
 
-As far as the Audiohile USB device is concerned, this value let the user 
+As far as the Audiophile USB device is concerned, this value let the user 
 specify:
  * the sample depth
  * the sample rate
@@ -174,20 +173,20 @@
 
 IMPORTANT NOTE WHEN SWITCHING CONFIGURATION:
 -------------------------------------------
- * You may need to _first_ intialize the module with the correct device_setup 
+ * You may need to _first_ initialize the module with the correct device_setup 
    parameter and _only_after_ turn on the Audiophile USB device
  * This is especially true when switching the sample depth:
-   - first trun off the device
-   - de-register the snd-usb-audio module
-   - change the device_setup parameter (by either manually reprobing the module 
-     or changing modprobe.conf)
+   - first turn off the device
+   - de-register the snd-usb-audio module (modprobe -r)
+   - change the device_setup parameter by changing the device_setup
+     option in /etc/modprobe.conf 
    - turn on the device
 
 2.2.2.3 - Audiophile USB's device_setup structure
 
 If you want to understand the device_setup magic numbers for the Audiophile 
 USB, you need some very basic understanding of binary computation. However, 
-this is not required to use the parameter and you may skip thi section.
+this is not required to use the parameter and you may skip this section.
 
 The device_setup is one byte long and its structure is the following:
 
@@ -231,11 +230,11 @@
 
 2.2.3 -  USB implementation details for this device
 
-You may safely skip this section if you're not interrested in driver 
+You may safely skip this section if you're not interested in driver 
 development.
 
-This section describes some internals aspect of the device and summarize the 
-data I got by usb-snooping the windows and linux drivers.
+This section describes some internal aspects of the device and summarize the 
+data I got by usb-snooping the windows and Linux drivers.
 
 The M-Audio Audiophile USB has 7 USB Interfaces:
 a "USB interface":
@@ -277,9 +276,9 @@
   - 16-bit depth, 8-48kHz sample mode
   - Synch playback (Do), audio format type III IEC1937_AC-3
 
-In order to ensure a correct intialization of the device, the driver 
+In order to ensure a correct initialization of the device, the driver 
 _must_know_ how the device will be used:
- * if DTS is choosen, only Interface 2 with AltSet nb.6 must be
+ * if DTS is chosen, only Interface 2 with AltSet nb.6 must be
    registered
  * if 96KHz only AltSets nb.1 of each interface must be selected
  * if samples are using 24bits/48KHz then AltSet 2 must me used if
@@ -317,9 +316,8 @@
 using the "default" ALSA device. This is less efficient than it could be. 
 Consider using a hardware device instead rather than using the plug layer."
 
-
 3.2 - Patching alsa to use direct pcm device
--------------------------------------------
+--------------------------------------------
 A patch for Jack by Andreas Steinmetz adds support for Big Endian devices. 
 However it has not been included in the CVS tree.
 
@@ -331,3 +329,32 @@
 line:
   % jackd -R -dalsa -Phw:1,0 -r48000 -p128 -n2 -D -Chw:1,1
 
+3.2 - Getting 2 input and/or output interfaces in Jack
+------------------------------------------------------
+
+As you can see, starting the Jack server this way will only enable 1 stereo
+input (Di or Ai) and 1 stereo output (Ao or Do).
+
+This is due to the following restrictions:
+* Jack can only open one capture device and one playback device at a time
+* The Audiophile USB is seen as 2 (or three) Alsa devices: hw:1,0, hw:1,1
+  (and optionnally hw:1,2)
+If you want to get Ai+Di and/or Ao+Do support with Jack, you would need to
+combine the Alsa devices into one logical "complex" device.
+
+If you want to give it a try, I recommend reading the information from
+this page: http://www.sound-man.co.uk/linuxaudio/ice1712multi.html
+It is related to another device (ice1712) but can be adapted to suit
+the Audiophile USB.
+
+Enabling multiple Audiophile USB interfaces for Jackd will certainly require:
+* patching Jack with the previously mentioned "Big Endian" patch
+* patching Jackd with the MMAP_COMPLEX patch (see the ice1712 page)
+* patching the alsa-lib/src/pcm/pcm_multi.c file (see the ice1712 page)
+* define a multi device (combination of hw:1,0 and hw:1,1) in your .asoundrc
+  file 
+* start jackd with this device
+
+I had no success in testing this for now, but this may be due to my OS
+configuration. If you have any success with this kind of setup, please
+drop me an email.

--=_46rcg47ho76s--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
