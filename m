From: Martin <mwolf@adiumentum.com>
Subject: Re: problem with bisecting a bug in the alsa driver
Date: Sun, 29 Aug 2010 18:52:55 +0200
Message-ID: <4C7A9067.8090809@adiumentum.com>
References: <4C7A8375.3000009@adiumentum.com>
	<alpine.LNX.2.00.1008291805250.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010004060509040701040202"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adiumentum.com (adiumentum.com [83.142.83.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 352072440B
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Aug 2010 18:52:57 +0200 (CEST)
Received: from [192.168.2.26] (p54A87988.dip.t-dialin.net [84.168.121.136])
	by adiumentum.com (Postfix) with ESMTPSA id 5064A4400A0
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Aug 2010 18:52:56 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1008291805250.10278@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010004060509040701040202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

hi,

thanks for the quick help.
here is the diff.txt

Am 29.08.2010 18:09, schrieb Jaroslav Kysela:
> On Sun, 29 Aug 2010, Martin wrote:
>
>    
>> hello,
>>
>> im sorry to post in here but i really dont know how to proceed
>> with finding the bug i have.
>>
>> i have an ALC889A codec and since alsa-driver 1.0.22 my
>> microphone is crackling like hell with every recording.
>>
>> it works flawlessly on windows and till 1.0.21 of alsa driver.
>>      
>
>    
>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5115
>>      
> Try to create a diff (diff -u) between the outputs from alsa-info.sh
> for working 1.0.21 and current ALSA driver.
>
> Bisecting works only for whole kernel 2.6 tree not for the out-of-kernel
> compilation framework.
>
>   					Jaroslav
>
> -----
> Jaroslav Kysela<perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>    


--------------010004060509040701040202
Content-Type: text/plain;
 name="diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="diff.txt"

--- alsa1021.txt	2010-08-29 18:49:05.479945563 +0200
+++ alsa1023.txt	2010-08-29 18:46:02.665960706 +0200
@@ -3,7 +3,7 @@
 !!ALSA Information Script v 0.4.59
 !!################################
 
-!!Script ran on: Sun Aug 29 16:48:50 UTC 2010
+!!Script ran on: Sun Aug 29 16:45:46 UTC 2010
 
 
 !!Linux Distribution
@@ -32,7 +32,7 @@
 !!ALSA Version
 !!------------
 
-Driver version:     1.0.21
+Driver version:     1.0.23
 Library version:    1.0.22
 Utilities version:  1.0.22
 
@@ -59,7 +59,7 @@
 !!-----------------------------
 
  0 [Intel          ]: HDA-Intel - HDA Intel
-                      HDA Intel at 0xfa200000 irq 22
+                      HDA Intel at 0xfa200000 irq 30
 
 
 !!PCI Soundcards installed in the system
@@ -94,8 +94,9 @@
 
 !!Module: snd_hda_intel
 	bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1
+	beep_mode : 1,1,1,1,1,1,1,1
 	enable : Y,Y,Y,Y,Y,Y,Y,Y
-	enable_msi : 0
+	enable_msi : -1
 	id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
 	index : -1,-1,-1,-1,-1,-1,-1,-1
 	model : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
@@ -104,7 +105,7 @@
 	power_save : 0
 	power_save_controller : Y
 	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1
-	probe_only : N,N,N,N,N,N,N,N
+	probe_only : 0,0,0,0,0,0,0,0
 	single_cmd : N
 
 
@@ -129,6 +130,7 @@
   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
 Node 0x02 [Audio Output] wcaps 0x11: Stereo
+  Device: name="ALC889A Analog", type="Audio", device=0
   Converter: stream=0, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
@@ -153,6 +155,12 @@
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
 Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
+  Control: name="IEC958 Playback Con Mask", index=0, device=0
+  Control: name="IEC958 Playback Pro Mask", index=0, device=0
+  Control: name="IEC958 Playback Default", index=0, device=0
+  Control: name="IEC958 Playback Switch", index=0, device=0
+  Control: name="IEC958 Default PCM Playback Switch", index=0, device=0
+  Device: name="ALC889A Digital", type="SPDIF", device=1
   Converter: stream=0, channel=0
   Digital: Enabled GenLevel
   Digital category: 0x2
@@ -161,6 +169,9 @@
     bits [0x1e]: 16 20 24 32
     formats [0x1]: PCM
 Node 0x07 [Audio Input] wcaps 0x10011b: Stereo Amp-In
+  Control: name="Capture Switch", index=0, device=0
+  Control: name="Capture Volume", index=0, device=0
+  Device: name="ALC889A Analog", type="Audio", device=0
   Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
   Amp-In vals:  [0x2e 0x2e]
   Converter: stream=0, channel=0
@@ -172,6 +183,9 @@
   Connection: 1
      0x24
 Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
+  Control: name="Capture Switch", index=1, device=0
+  Control: name="Capture Volume", index=1, device=0
+  Device: name="ALC889A Analog", type="Audio", device=2
   Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
   Amp-In vals:  [0xae 0xae]
   Converter: stream=0, channel=0
@@ -183,6 +197,8 @@
   Connection: 1
      0x23
 Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
+  Control: name="Capture Switch", index=2, device=0
+  Control: name="Capture Volume", index=2, device=0
   Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
   Amp-In vals:  [0x00 0x00]
   Converter: stream=0, channel=0
@@ -194,6 +210,9 @@
   Connection: 1
      0x22
 Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
+  Control: name="IEC958 Capture Switch", index=0, device=0
+  Control: name="IEC958 Capture Default", index=0, device=0
+  Device: name="ALC889A Digital", type="SPDIF", device=1
   Converter: stream=0, channel=0
   SDI-Select: 0
   Digital:
@@ -206,11 +225,27 @@
   Connection: 1
      0x1f
 Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
+  Control: name="Mic Playback Volume", index=0, device=0
+    ControlAmp: chs=3, dir=In, idx=0, ofs=0
+  Control: name="Mic Playback Switch", index=0, device=0
+    ControlAmp: chs=3, dir=In, idx=0, ofs=0
+  Control: name="Front Mic Playback Volume", index=0, device=0
+    ControlAmp: chs=3, dir=In, idx=1, ofs=0
+  Control: name="Front Mic Playback Switch", index=0, device=0
+    ControlAmp: chs=3, dir=In, idx=1, ofs=0
+  Control: name="Line Playback Volume", index=0, device=0
+    ControlAmp: chs=3, dir=In, idx=2, ofs=0
+  Control: name="Line Playback Switch", index=0, device=0
+    ControlAmp: chs=3, dir=In, idx=2, ofs=0
   Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
-  Amp-In vals:  [0x80 0x80] [0x9f 0x9f] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97]
+  Amp-In vals:  [0x80 0x80] [0x9f 0x9f] [0x80 0x80] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97]
   Connection: 10
      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
 Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
+  Control: name="Front Playback Volume", index=0, device=0
+    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
+  Control: name="Front Playback Switch", index=0, device=0
+    ControlAmp: chs=3, dir=In, idx=2, ofs=0
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
@@ -218,6 +253,10 @@
   Connection: 2
      0x02 0x0b
 Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
+  Control: name="Surround Playback Volume", index=0, device=0
+    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
+  Control: name="Surround Playback Switch", index=0, device=0
+    ControlAmp: chs=3, dir=In, idx=2, ofs=0
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
@@ -225,6 +264,14 @@
   Connection: 2
      0x03 0x0b
 Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
+  Control: name="Center Playback Volume", index=0, device=0
+    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
+  Control: name="LFE Playback Volume", index=0, device=0
+    ControlAmp: chs=2, dir=Out, idx=0, ofs=0
+  Control: name="Center Playback Switch", index=0, device=0
+    ControlAmp: chs=1, dir=In, idx=2, ofs=0
+  Control: name="LFE Playback Switch", index=0, device=0
+    ControlAmp: chs=2, dir=In, idx=2, ofs=0
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
@@ -232,6 +279,10 @@
   Connection: 2
      0x04 0x0b
 Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
+  Control: name="Side Playback Volume", index=0, device=0
+    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
+  Control: name="Side Playback Switch", index=0, device=0
+    ControlAmp: chs=3, dir=In, idx=2, ofs=0
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
@@ -297,6 +348,8 @@
   Connection: 5
      0x0c 0x0d 0x0e 0x0f* 0x26
 Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
+  Control: name="Mic Boost", index=0, device=0
+    ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
@@ -311,6 +364,8 @@
   Connection: 5
      0x0c* 0x0d 0x0e 0x0f 0x26
 Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
+  Control: name="Front Mic Boost", index=0, device=0
+    ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
@@ -339,6 +394,8 @@
   Connection: 5
      0x0c* 0x0d 0x0e 0x0f 0x26
 Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
+  Control: name="Headphone Playback Switch", index=0, device=0
+    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
@@ -383,23 +440,24 @@
   Pin-ctls: 0x20: IN
 Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
   Processing caps: benign=0, ncoeff=17
-  Processing Coefficient: 0xf012
-  Coefficient Index: 0x01
 Node 0x21 [Volume Knob Widget] wcaps 0x600080: Mono
   Volume-Knob: delta=0, steps=32, direct=0, val=0
   Unsolicited: tag=00, enabled=0
   Connection: 0
 Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
+  Control: name="Input Source", index=2, device=0
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
   Connection: 11
      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
 Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
+  Control: name="Input Source", index=1, device=0
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
   Connection: 11
      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
 Node 0x24 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
+  Control: name="Input Source", index=0, device=0
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
   Connection: 11
@@ -423,21 +481,21 @@
 !!ALSA Device nodes
 !!-----------------
 
-crw-rw----+ 1 root audio 116,  0 Aug 29 18:48 /dev/snd/controlC0
-crw-rw----+ 1 root audio 116,  6 Aug 29 18:48 /dev/snd/hwC0D2
-crw-rw----+ 1 root audio 116, 24 Aug 29 18:48 /dev/snd/pcmC0D0c
-crw-rw----+ 1 root audio 116, 16 Aug 29 18:48 /dev/snd/pcmC0D0p
-crw-rw----+ 1 root audio 116, 25 Aug 29 18:48 /dev/snd/pcmC0D1c
-crw-rw----+ 1 root audio 116, 17 Aug 29 18:48 /dev/snd/pcmC0D1p
-crw-rw----+ 1 root audio 116, 26 Aug 29 18:48 /dev/snd/pcmC0D2c
-crw-rw----+ 1 root audio 116,  1 Aug 29 18:48 /dev/snd/seq
-crw-rw----+ 1 root audio 116, 33 Aug 29 18:48 /dev/snd/timer
+crw-rw----+ 1 root audio 116,  0 Aug 29 18:45 /dev/snd/controlC0
+crw-rw----+ 1 root audio 116,  6 Aug 29 18:45 /dev/snd/hwC0D2
+crw-rw----+ 1 root audio 116, 24 Aug 29 18:45 /dev/snd/pcmC0D0c
+crw-rw----+ 1 root audio 116, 16 Aug 29 18:45 /dev/snd/pcmC0D0p
+crw-rw----+ 1 root audio 116, 25 Aug 29 18:45 /dev/snd/pcmC0D1c
+crw-rw----+ 1 root audio 116, 17 Aug 29 18:45 /dev/snd/pcmC0D1p
+crw-rw----+ 1 root audio 116, 26 Aug 29 18:45 /dev/snd/pcmC0D2c
+crw-rw----+ 1 root audio 116,  1 Aug 29 18:45 /dev/snd/seq
+crw-rw----+ 1 root audio 116, 33 Aug 29 18:45 /dev/snd/timer
 
 /dev/snd/by-path:
 total 0
-drwxr-xr-x 2 root root  60 Aug 29 18:48 .
-drwxr-xr-x 3 root root 240 Aug 29 18:48 ..
-lrwxrwxrwx 1 root root  12 Aug 29 18:48 pci-0000:00:1b.0 -> ../controlC0
+drwxr-xr-x 2 root root  60 Aug 29 18:45 .
+drwxr-xr-x 3 root root 240 Aug 29 18:45 ..
+lrwxrwxrwx 1 root root  12 Aug 29 18:45 pci-0000:00:1b.0 -> ../controlC0
 
 
 !!Aplay/Arecord output
@@ -472,11 +530,11 @@
 
 !!-------Mixer controls for card 0 [Intel]
 
-Card hw:0 'Intel'/'HDA Intel at 0xfa200000 irq 22'
+Card hw:0 'Intel'/'HDA Intel at 0xfa200000 irq 30'
   Mixer name	: 'Realtek ALC889A'
   Components	: 'HDA:10ec0885,1458a002,00100101'
-  Controls      : 41
-  Simple ctrls  : 23
+  Controls      : 39
+  Simple ctrls  : 22
 Simple mixer control 'Master',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
   Playback channels: Mono
@@ -570,13 +628,6 @@
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [on]
-Simple mixer control 'Beep',0
-  Capabilities: pvolume pswitch penum
-  Playback channels: Front Left - Front Right
-  Limits: Playback 0 - 31
-  Mono:
-  Front Left: Playback 23 [74%] [0.00dB] [off]
-  Front Right: Playback 23 [74%] [0.00dB] [off]
 Simple mixer control 'Capture',0
   Capabilities: cvolume cswitch penum
   Capture channels: Front Left - Front Right
@@ -978,27 +1029,6 @@
 	control.36 {
 		comment.access 'read write'
 		comment.type INTEGER
-		comment.count 2
-		comment.range '0 - 31'
-		comment.dbmin -3450
-		comment.dbmax 1200
-		iface MIXER
-		name 'Beep Playback Volume'
-		value.0 23
-		value.1 23
-	}
-	control.37 {
-		comment.access 'read write'
-		comment.type BOOLEAN
-		comment.count 2
-		iface MIXER
-		name 'Beep Playback Switch'
-		value.0 false
-		value.1 false
-	}
-	control.38 {
-		comment.access 'read write'
-		comment.type INTEGER
 		comment.count 1
 		comment.range '0 - 64'
 		comment.dbmin -6400
@@ -1007,7 +1037,7 @@
 		name 'Master Playback Volume'
 		value 64
 	}
-	control.39 {
+	control.37 {
 		comment.access 'read write'
 		comment.type BOOLEAN
 		comment.count 1
@@ -1015,7 +1045,7 @@
 		name 'Master Playback Switch'
 		value true
 	}
-	control.40 {
+	control.38 {
 		comment.access 'read write user'
 		comment.type INTEGER
 		comment.count 2
@@ -1028,7 +1058,7 @@
 		value.0 255
 		value.1 255
 	}
-	control.41 {
+	control.39 {
 		comment.access 'read write user'
 		comment.type INTEGER
 		comment.count 2
@@ -1051,7 +1081,17 @@
 Module
 binfmt_misc
 ppdev
+joydev
+hid_logitech
+ff_memless
+usbhid
 snd_hda_codec_realtek
+hid
+fbcon
+tileblit
+font
+bitblit
+softcursor
 snd_hda_intel
 snd_hda_codec
 snd_hwdep
@@ -1063,36 +1103,26 @@
 snd_seq
 snd_timer
 snd_seq_device
+snd
+lp
 uvcvideo
 videodev
 v4l1_compat
 v4l2_compat_ioctl32
-fbcon
-tileblit
-font
-bitblit
-softcursor
-joydev
-snd
+soundcore
+snd_page_alloc
+intel_agp
 nvidia
 vga16fb
 vgastate
-intel_agp
-soundcore
-snd_page_alloc
-lp
 parport
-hid_logitech
-ff_memless
-usbhid
-hid
-ohci1394
 floppy
-pata_jmicron
-ieee1394
+ohci1394
 r8169
 mii
+pata_jmicron
 ahci
+ieee1394
 
 
 !!Sysfs Files
@@ -1122,14 +1152,22 @@
 !!ALSA/HDA dmesg
 !!------------------
 
-[   16.176781]   alloc kstat_irqs on node -1
-[   16.176785] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
-[   16.176815] HDA Intel 0000:00:1b.0: setting latency timer to 64
-[   16.234511] Console: switching to colour frame buffer device 80x30
+[   12.478065]   alloc kstat_irqs on node -1
+[   12.478069] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
+[   12.478071] hda_intel: position_fix set to 1 for device 1458:a022
+[   12.478159]   alloc irq_desc for 30 on node -1
+[   12.478160]   alloc kstat_irqs on node -1
+[   12.478166] HDA Intel 0000:00:1b.0: irq 30 for MSI/MSI-X
+[   12.478184] HDA Intel 0000:00:1b.0: setting latency timer to 64
+[   12.651207] Console: switching to colour frame buffer device 80x30
+--
+[   12.690914] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  256.44  Thu Jul 29 01:22:44 PDT 2010
+[   12.727771] hda_codec: ALC889A: BIOS auto-probing.
+[   12.729083] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input5
+[   13.056702] usbcore: registered new interface driver hiddev
 --
-[   16.260389] NVRM: loading NVIDIA UNIX x86_64 Kernel Module  256.44  Thu Jul 29 01:22:44 PDT 2010
-[   16.324997] hda_codec: ALC889A: BIOS auto-probing.
-[   16.326329] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input8
-[   16.631050] type=1505 audit(1283100504.725:5):  operation="profile_load" pid=1003 name="/usr/share/gdm/guest-session/Xsession"
+[   15.991327]   groups: 1 0
+[   17.708288] hda-intel: IRQ timing workaround is activated for card #0. Suggest a bigger bdl_pos_adj.
+[   23.920043] eth0: no IPv6 routers present
 
 

--------------010004060509040701040202
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010004060509040701040202--
