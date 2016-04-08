From: Cyrille Dunant <cfd30@cam.ac.uk>
Subject: A tweak to the intel codec to get rid of the hiss.
Date: Fri, 08 Apr 2016 13:02:37 +0100
Message-ID: <4565539.erS6kNQS3B@cam-puter>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2436202.b5R3S4KWN9"
Content-Transfer-Encoding: 7Bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ppsw-42.csi.cam.ac.uk (ppsw-42.csi.cam.ac.uk [131.111.8.142])
 by alsa0.perex.cz (Postfix) with ESMTP id 493FE2625EE
 for <alsa-devel@alsa-project.org>; Fri,  8 Apr 2016 14:05:00 +0200 (CEST)
Received: from uselesspc64.eng.cam.ac.uk ([129.169.70.18]:59243
 helo=cam-puter.localnet)
 by ppsw-42.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:25)
 with esmtpsa (PLAIN:cfd30) (TLSv1:ECDHE-RSA-AES256-SHA:256)
 id 1aoV9n-0007pV-8b (Exim 4.86_36-e07b163) for alsa-devel@alsa-project.org
 (return-path <cfd30@cam.ac.uk>); Fri, 08 Apr 2016 13:04:59 +0100
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

This is a multi-part message in MIME format.

--nextPart2436202.b5R3S4KWN9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

I apologise for the noise on the list, but I noted that on a number of HDA 
card, the default produces a small static noise, and I tracked it down to some 
channels which I believe ought to be muted.

Attached is the output of alsa-info.sh, and the diff from the python hda tweak 
tool.

This helped both for my laptop and desktop (both HDA cards, different models).

Cheers!

Diff for codec 1/0 (0x10ec0280):
--- 
+++ 
@@ -17,17 +17,17 @@
   IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[4]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
 Node 0x02 [Audio Output] wcaps 0x41d: Stereo Amp-Out
   Device: name="ALC3220 Analog", type="Audio", device=0
   Control: name="PCM Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=1, idx=0, ofs=0
   Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
-  Amp-Out vals: [0x2e 0x2e]
+  Amp-Out vals: [0x2f 0x2f]
   Converter: stream=8, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power: setting=D0, actual=D0
 Node 0x03 [Audio Output] wcaps 0x41d: Stereo Amp-Out
   Control: name="Headphone Playback Volume", index=0, device=0
@@ -66,17 +66,17 @@
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power: setting=D0, actual=D0
   Connection: 1
      0x23
 Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
   Amp-In caps: ofs=0x17, nsteps=0x3f, stepsize=0x02, mute=1
-  Amp-In vals: [0x97 0x97]
+  Amp-In vals: [0x17 0x17]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power: setting=D0, actual=D0
   Connection: 1
@@ -87,27 +87,27 @@
     ControlAmp: chs=3, dir=1, idx=2, ofs=0
   Control: name="Front Mic Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=1, idx=2, ofs=0
   Control: name="Rear Mic Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=1, idx=0, ofs=0
   Control: name="Rear Mic Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=1, idx=0, ofs=0
   Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
-  Amp-In vals: [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
+  Amp-In vals: [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
   Connection: 5
      0x18 0x19 0x1a 0x1b 0x1d
 Node 0x0c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals: [0x00 0x00] [0x00 0x00]
   Connection: 2
      0x02 0x0b
 Node 0x0d [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
-  Amp-In vals: [0x00 0x00] [0x00 0x00]
+  Amp-In vals: [0x00 0x00] [0x80 0x80]
   Connection: 2
      0x03 0x0b
 Node 0x0e [Vendor Defined Widget] wcaps 0xf00000: Mono
 Node 0x0f [Audio Mixer] wcaps 0x20010a: Mono Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals: 0x80 0x00
   Connection: 2
      0x02 0x0
--nextPart2436202.b5R3S4KWN9
Content-Disposition: attachment; filename="alsa-info.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="alsa-info.txt"

name=cyrille&type=33&description=/tmp/alsa-info.txt&expiry=&s=Submit+Post&content=
!!################################
!!ALSA Information Script v 0.4.64
!!################################

!!Script ran on: Fri Apr  8 11:58:21 UTC 2016


!!Linux Distribution
!!------------------




!!DMI Information
!!---------------

Manufacturer:      Dell Inc.
Product Name:      OptiPlex 9020
Product Version:   00
Firmware Version:  A14


!!Kernel Information
!!------------------

Kernel release:    3.13.0-83-generic
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         x86_64
SMP Enabled:       No


!!ALSA Version
!!------------

Driver version:     k3.13.0-83-generic
Library version:    1.0.27.2
Utilities version:  1.0.27.2


!!Loaded ALSA modules
!!-------------------

snd_hda_intel
snd_hda_intel
snd_usb_audio


!!Sound Servers on this system
!!----------------------------


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [HDMI           ]: HDA-Intel - HDA Intel HDMI
                      HDA Intel HDMI at 0xf7c34000 irq 49
 1 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xf7c30000 irq 50
 2 [U0x46d0x825    ]: USB-Audio - USB Device 0x46d:0x825
                      USB Device 0x46d:0x825 at usb-0000:00:14.0-4, high speed


!!Modprobe options (Sound related)
!!--------------------------------

snd_atiixp_modem: index=-2
snd_intel8x0m: index=-2
snd_via82xx_modem: index=-2
snd_usb_audio: index=-2
snd_usb_caiaq: index=-2
snd_usb_ua101: index=-2
snd_usb_us122l: index=-2
snd_usb_usx2y: index=-2
snd_hda_intel: model=dell-m4-1 STAC92HD71B
snd_intel8x0: ac97_quirk=1 buggy_irq=1 enable=1 index=0
snd_cmipci: mpu_port=0x330 fm_port=0x388
snd_pcsp: index=-2
snd_usb_audio: index=-2


!!Loaded sound module options
!!---------------------------

!!Module: snd_hda_intel
-ne 	
align_buffer_size : -1
-ne 	
bdl_pos_adj : 32,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
-ne 	
beep_mode : N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N
-ne 	
enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
-ne 	
enable_msi : -1
-ne 	
id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
-ne 	
index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
-ne 	
jackpoll_ms : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
-ne 	
model : dell-m4-1,(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
-ne 	
patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
-ne 	
position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
-ne 	
power_save : 0
-ne 	
power_save_controller : N
-ne 	
probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
-ne 	
probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
-ne 	
single_cmd : N
-ne 	
snoop : Y

!!Module: snd_hda_intel
-ne 	
align_buffer_size : -1
-ne 	
bdl_pos_adj : 32,1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
-ne 	
beep_mode : N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N
-ne 	
enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
-ne 	
enable_msi : -1
-ne 	
id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
-ne 	
index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
-ne 	
jackpoll_ms : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
-ne 	
model : dell-m4-1,(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
-ne 	
patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
-ne 	
position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
-ne 	
power_save : 0
-ne 	
power_save_controller : N
-ne 	
probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
-ne 	
probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
-ne 	
single_cmd : N
-ne 	
snoop : Y

!!Module: snd_usb_audio
-ne 	
autoclock : Y
-ne 	
device_setup : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
-ne 	
enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
-ne 	
id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
-ne 	
ignore_ctl_error : N
-ne 	
index : -2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
-ne 	
pid : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
-ne 	
vid : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Intel Haswell HDMI
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x80862807
Subsystem Id: 0x80860101
Revision Id: 0x100000
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D3 CLKSTOP EPSS
  Power: setting=D0, actual=D0, Clock-stop-OK
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Converter: stream=1, channel=0
  Digital: Enabled KAE
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x03 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Converter: stream=0, channel=0
  Digital: Enabled KAE
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=D3, actual=D3
Node 0x04 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Converter: stream=0, channel=0
  Digital: Enabled KAE
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=D3, actual=D3
Node 0x05 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0b000094: OUT Detect HBR HDMI DP
  Pin Default 0x58560010: [N/A] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Devices: 0
  Connection: 0
Node 0x06 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name="HDMI/DP,pcm=3 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="ELD", index=0, device=3
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0b000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560020: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=01, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Devices: 0
  Connection: 0
  In-driver Connection: 3
     0x02 0x03 0x04
Node 0x07 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Control: name="HDMI/DP,pcm=7 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=1, device=0
  Control: name="IEC958 Playback Pro Mask", index=1, device=0
  Control: name="IEC958 Playback Default", index=1, device=0
  Control: name="IEC958 Playback Switch", index=1, device=0
  Control: name="ELD", index=0, device=7
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0b000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560030: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=02, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Devices: 0
  Connection: 0
  In-driver Connection: 3
     0x02 0x03 0x04
Node 0x08 [Vendor Defined Widget] wcaps 0xf00000: Mono
Codec: Realtek ALC3220
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0280
Subsystem Id: 0x102805a4
Revision Id: 0x100003
No Modem Function Group found
Default PCM:
    rates [0x5f0]: 32000 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D1 D2 D3 CLKSTOP EPSS
  Power: setting=D0, actual=D0
GPIO: io=5, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[4]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="PCM Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="ALC3220 Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
  Amp-Out vals:  [0x2f 0x2f]
  Converter: stream=8, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x03 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
  Amp-Out vals:  [0x23 0x23]
  Converter: stream=8, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x04 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x05 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x06 [Audio Output] wcaps 0x611: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x5f0]: 32000 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Device: name="ALC3220 Analog", type="Audio", device=0
  Amp-In caps: ofs=0x17, nsteps=0x3f, stepsize=0x02, mute=1
  Amp-In vals:  [0x00 0x00]
  Converter: stream=4, channel=0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x23
Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x3f, stepsize=0x02, mute=1
  Amp-In vals:  [0x17 0x17]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x22
Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Front Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="Front Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="Rear Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Rear Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Connection: 5
     0x18 0x19 0x1a 0x1b 0x1d
Node 0x0c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x03 0x0b
Node 0x0e [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0f [Audio Mixer] wcaps 0x20010a: Mono Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80] [0x00]
  Connection: 2
     0x02 0x03
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Pin Complex] wcaps 0x40040b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x4008c000: [N/A] Line Out at Ext N/A
    Conn = DIN, Color = UNKNOWN
    DefAssociation = 0x0, Sequence = 0x0
  Pin-ctls: 0x00:
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x13 [Pin Complex] wcaps 0x40040b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x14 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Speaker Phantom Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00010010: OUT EAPD
  EAPD 0x2: EAPD
  Pin Default 0x90170110: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 2
     0x0c* 0x0d
Node 0x15 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Front Headphone Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001001c: OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x0221401f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=01, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 2
     0x0c 0x0d*
Node 0x16 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00010014: OUT EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 2
     0x0c* 0x0d
Node 0x17 [Pin Complex] wcaps 0x40050c: Mono Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80]
  Pincap 0x00000010: OUT
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x0f
Node 0x18 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="Rear Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Rear Mic Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003734: IN OUT Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x01a13040: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x4, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 2
     0x0c* 0x0d
Node 0x19 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000024: IN Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x1a [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="Front Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Front Mic Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x02a19030: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=03, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 2
     0x0c* 0x0d
Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="PCM Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line Out Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x2f, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00003734: IN OUT Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x01014020: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=02, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 2
     0x0c* 0x0d
Node 0x1c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1d [Pin Complex] wcaps 0x400400: Mono
  Pincap 0x00000020: IN
  Pin Default 0x40400001: [N/A] SPDIF Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0x0, Sequence = 0x1
  Pin-ctls: 0x20: IN
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x1e [Pin Complex] wcaps 0x400781: Stereo Digital
  Pincap 0x00000014: OUT Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x06
Node 0x1f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=0, ncoeff=107
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 8
     0x18* 0x19 0x1a 0x1b 0x1d 0x0b 0x12 0x13
Node 0x23 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 6
     0x18* 0x19 0x1a 0x1b 0x1d 0x0b
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
--endcollapse--


!!USB Mixer information
!!---------------------
--startcollapse--

USB Mixer: usb_id=0x046d0825, ctrlif=2, ctlerr=0
Card: USB Device 0x46d:0x825 at usb-0000:00:14.0-4, high speed
  Unit: 5
    Control: name="Mic Capture Volume", index=0
    Info: id=5, control=2, cmask=0x0, channels=1, type="S16"
    Volume: min=1536, max=7680, dBmin=600, dBmax=3000
  Unit: 5
    Control: name="Mic Capture Switch", index=0
    Info: id=5, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  5 Mar 24 08:38 /dev/snd/controlC0
crw-rw----+ 1 root audio 116,  9 Mar 24 08:38 /dev/snd/controlC1
crw-rw----+ 1 root audio 116, 11 Mar 24 08:38 /dev/snd/controlC2
crw-rw----+ 1 root audio 116,  4 Mar 24 08:38 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116,  8 Mar 24 08:38 /dev/snd/hwC1D0
crw-rw----+ 1 root audio 116,  3 Mar 24 08:39 /dev/snd/pcmC0D3p
crw-rw----+ 1 root audio 116,  2 Mar 24 08:39 /dev/snd/pcmC0D7p
crw-rw----+ 1 root audio 116,  7 Mar 24 08:39 /dev/snd/pcmC1D0c
crw-rw----+ 1 root audio 116,  6 Apr  8 12:53 /dev/snd/pcmC1D0p
crw-rw----+ 1 root audio 116, 10 Mar 24 08:40 /dev/snd/pcmC2D0c
crw-rw----+ 1 root audio 116,  1 Mar 24 08:38 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 Mar 24 08:38 /dev/snd/timer

/dev/snd/by-id:
total 0
drwxr-xr-x 2 root root  60 Mar 24 08:38 .
drwxr-xr-x 4 root root 320 Mar 24 08:38 ..
lrwxrwxrwx 1 root root  12 Mar 24 08:38 usb-046d_0825_2F416CE0-02 -> ../controlC2

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root 100 Mar 24 08:38 .
drwxr-xr-x 4 root root 320 Mar 24 08:38 ..
lrwxrwxrwx 1 root root  12 Mar 24 08:38 pci-0000:00:03.0 -> ../controlC0
lrwxrwxrwx 1 root root  12 Mar 24 08:38 pci-0000:00:14.0-usb-0:4:1.2 -> ../controlC2
lrwxrwxrwx 1 root root  12 Mar 24 08:38 pci-0000:00:1b.0 -> ../controlC1


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: HDMI [HDA Intel HDMI], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: HDMI [HDA Intel HDMI], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: PCH [HDA Intel PCH], device 0: ALC3220 Analog [ALC3220 Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 1: PCH [HDA Intel PCH], device 0: ALC3220 Analog [ALC3220 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: U0x46d0x825 [USB Device 0x46d:0x825], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [HDMI]

Card hw:0 'HDMI'/'HDA Intel HDMI at 0xf7c34000 irq 49'
  Mixer name	: 'Intel Haswell HDMI'
  Components	: 'HDA:80862807,80860101,00100000'
  Controls      : 14
  Simple ctrls  : 2
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]

!!-------Mixer controls for card 1 [PCH]

Card hw:1 'PCH'/'HDA Intel PCH at 0xf7c30000 irq 50'
  Mixer name	: 'Realtek ALC3220'
  Components	: 'HDA:10ec0280,102805a4,00100003'
  Controls      : 23
  Simple ctrls  : 10
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 87
  Mono: Playback 35 [40%] [-39.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 87
  Mono:
  Front Left: Playback 87 [100%] [0.00dB] [on]
  Front Right: Playback 87 [100%] [0.00dB] [on]
Simple mixer control 'Speaker',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [off]
  Front Right: Playback [off]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 87
  Mono:
  Front Left: Playback 87 [100%] [0.00dB] [on]
  Front Right: Playback 87 [100%] [0.00dB] [on]
Simple mixer control 'Front Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Front Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 63
  Front Left: Capture 0 [0%] [-17.25dB] [on]
  Front Right: Capture 0 [0%] [-17.25dB] [on]
Simple mixer control 'Auto-Mute Mode',0
  Capabilities: enum
  Items: 'Disabled' 'Speaker Only' 'Line Out+Speaker'
  Item0: 'Line Out+Speaker'
Simple mixer control 'Rear Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Rear Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]

!!-------Mixer controls for card 2 [U0x46d0x825]

Card hw:2 'U0x46d0x825'/'USB Device 0x46d:0x825 at usb-0000:00:14.0-4, high speed'
  Mixer name	: 'USB Mixer'
  Components	: 'USB046d:0825'
  Controls      : 3
  Simple ctrls  : 1
Simple mixer control 'Mic',0
  Capabilities: cvolume cvolume-joined cswitch cswitch-joined
  Capture channels: Mono
  Limits: Capture 0 - 16
  Mono: Capture 16 [100%] [30.00dB] [on]


!!Alsactl output
!!--------------

--startcollapse--
state.HDMI {
	control.1 {
		iface CARD
		name 'HDMI/DP,pcm=3 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.2 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.3 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.4 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.5 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.6 {
		iface PCM
		device 3
		name ELD
		value ''
		comment {
			access 'read volatile'
			type BYTES
			count 0
		}
	}
	control.7 {
		iface CARD
		name 'HDMI/DP,pcm=7 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.8 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		index 1
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.9 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		index 1
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.10 {
		iface MIXER
		name 'IEC958 Playback Default'
		index 1
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.11 {
		iface MIXER
		name 'IEC958 Playback Switch'
		index 1
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.12 {
		iface PCM
		device 7
		name ELD
		value ''
		comment {
			access 'read volatile'
			type BYTES
			count 0
		}
	}
	control.13 {
		iface PCM
		device 3
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		comment {
			access 'read write'
			type INTEGER
			count 8
			range '0 - 36'
		}
	}
	control.14 {
		iface PCM
		device 7
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		comment {
			access 'read write'
			type INTEGER
			count 8
			range '0 - 36'
		}
	}
}
state.PCH {
	control.1 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 87
		value.1 87
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 87'
			dbmin -6525
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.2 {
		iface MIXER
		name 'PCM Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.3 {
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 87
		value.1 87
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 87'
			dbmin -6525
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.4 {
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.5 {
		iface MIXER
		name 'Speaker Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.6 {
		iface MIXER
		name 'Front Mic Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -3450
			dbvalue.1 -3450
		}
	}
	control.7 {
		iface MIXER
		name 'Front Mic Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.8 {
		iface MIXER
		name 'Rear Mic Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -3450
			dbvalue.1 -3450
		}
	}
	control.9 {
		iface MIXER
		name 'Rear Mic Playback Switch'
		value.0 false
		value.1 false
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.10 {
		iface MIXER
		name 'Auto-Mute Mode'
		value 'Line Out+Speaker'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Disabled
			item.1 'Speaker Only'
			item.2 'Line Out+Speaker'
		}
	}
	control.11 {
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 63'
			dbmin -1725
			dbmax 3000
			dbvalue.0 -1725
			dbvalue.1 -1725
		}
	}
	control.12 {
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.13 {
		iface MIXER
		name 'Front Mic Boost Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3600
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.14 {
		iface MIXER
		name 'Rear Mic Boost Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3600
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.15 {
		iface MIXER
		name 'Master Playback Volume'
		value 35
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 87'
			dbmin -6525
			dbmax 0
			dbvalue.0 -3900
		}
	}
	control.16 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.17 {
		iface CARD
		name 'Front Mic Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.18 {
		iface CARD
		name 'Rear Mic Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.19 {
		iface CARD
		name 'Line Out Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.20 {
		iface CARD
		name 'Front Headphone Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.21 {
		iface CARD
		name 'Speaker Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.22 {
		iface PCM
		name 'Playback Channel Map'
		value.0 3
		value.1 4
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
	control.23 {
		iface PCM
		name 'Capture Channel Map'
		value.0 0
		value.1 0
		comment {
			access read
			type INTEGER
			count 2
			range '0 - 36'
		}
	}
}
state.U0x46d0x825 {
	control.1 {
		iface PCM
		name 'Capture Channel Map'
		value 0
		comment {
			access read
			type INTEGER
			count 1
			range '0 - 36'
		}
	}
	control.2 {
		iface MIXER
		name 'Mic Capture Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.3 {
		iface MIXER
		name 'Mic Capture Volume'
		value 16
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 16'
			dbmin 600
			dbmax 3000
			dbvalue.0 3000
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
ufs
qnx4
hfsplus
hfs
minix
ntfs
msdos
jfs
xfs
bnep
rfcomm
bluetooth
dm_crypt
snd_usb_audio
x86_pkg_temp_thermal
intel_powerclamp
snd_hda_codec_realtek
snd_hda_codec_generic
snd_hda_codec_hdmi
coretemp
snd_hda_intel
snd_hda_controller
snd_usbmidi_lib
snd_hda_codec
snd_hwdep
kvm_intel
kvm
uvcvideo
snd_pcm
videobuf2_vmalloc
crct10dif_pclmul
snd_seq_midi
snd_page_alloc
snd_seq_midi_event
videobuf2_memops
crc32_pclmul
snd_rawmidi
videobuf2_core
videodev
aesni_intel
snd_seq
dell_wmi
snd_seq_device
sparse_keymap
dcdbas
aes_x86_64
lrw
mei_me
snd_timer
parport_pc
ppdev
lp
parport
snd
mei
gf128mul
glue_helper
ablk_helper
cryptd
dm_multipath
serio_raw
lpc_ich
shpchp
soundcore
scsi_dh
mac_hid
btrfs
xor
raid6_pq
libcrc32c
hid_generic
usbhid
hid
psmouse
i915
e1000e
ahci
libahci
ptp
i2c_algo_bit
pps_core
drm_kms_helper
drm
wmi
video


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x05 0x58560010
0x06 0x18560020
0x07 0x18560030

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D0/hints:

/sys/class/sound/hwC1D0/init_pin_configs:
0x12 0x4008c000
0x13 0x411111f0
0x14 0x90170110
0x15 0x0221401f
0x16 0x411111f0
0x17 0x411111f0
0x18 0x01a13040
0x19 0x411111f0
0x1a 0x02a19030
0x1b 0x01014020
0x1d 0x40400001
0x1e 0x411111f0

/sys/class/sound/hwC1D0/driver_pin_configs:

/sys/class/sound/hwC1D0/user_pin_configs:

/sys/class/sound/hwC1D0/init_verbs:

/sys/class/sound/hwC1D0/hints:


!!ALSA/HDA dmesg
!!--------------

[   14.577509] USB Video Class driver (1.1.1)
[   14.758388] snd_hda_intel: unknown parameter 'STAC92HD71B' ignored
[   14.758476] snd_hda_intel 0000:00:03.0: Probing card using HDA DKMS, version 0.201409230816~ubuntu14.04.1
[   14.758580] snd_hda_intel 0000:00:03.0: irq 49 for MSI/MSI-X
[   14.758606] snd_hda_intel 0000:00:1b.0: Probing card using HDA DKMS, version 0.201409230816~ubuntu14.04.1
[   14.758688] snd_hda_intel 0000:00:1b.0: irq 50 for MSI/MSI-X
[   14.769279] input: HDA Intel HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.0/sound/card0/input11
[   14.769320] input: HDA Intel HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.0/sound/card0/input10
[   14.787376] sound hdaudioC1D0: autoconfig: line_outs=1 (0x1b/0x0/0x0/0x0/0x0) type:line
[   14.787379] sound hdaudioC1D0:    speaker_outs=1 (0x14/0x0/0x0/0x0/0x0)
[   14.787380] sound hdaudioC1D0:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
[   14.787381] sound hdaudioC1D0:    mono: mono_out=0x0
[   14.787382] sound hdaudioC1D0:    inputs:
[   14.787383] sound hdaudioC1D0:      Front Mic=0x1a
[   14.787385] sound hdaudioC1D0:      Rear Mic=0x18
[   14.791832] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card1/input15
[   14.791868] input: HDA Intel PCH Line Out as /devices/pci0000:00/0000:00:1b.0/sound/card1/input14
[   14.792074] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input13
[   14.792418] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:00:1b.0/sound/card1/input12
[   15.251024] init: failsafe main process (741) killed by TERM signal
--
[   16.202280] set resolution quirk: cval->res = 384
[   16.202468] usbcore: registered new interface driver snd-usb-audio
[   16.227974] e1000e 0000:00:19.0: irq 46 for MSI/MSI-X



--nextPart2436202.b5R3S4KWN9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--nextPart2436202.b5R3S4KWN9--
