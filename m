From: Florian Reitmeir <florian@reitmeir.org>
Subject: kernel v3.4.x wrong pins /  hp z400
Date: Wed, 25 Jul 2012 16:34:16 +0200
Message-ID: <501003E8.60703@reitmeir.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from froxlor0.srv.multi24.com (froxlor0.srv.multi24.com
 [178.63.12.54]) by alsa0.perex.cz (Postfix) with ESMTP id B2DD6265334
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 16:34:44 +0200 (CEST)
Received: from [192.168.3.100] (unknown [212.186.54.228])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by froxlor0.srv.multi24.com (Postfix) with ESMTPSA id 8581416185F22
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 14:34:46 +0000 (UTC)
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

Hi,

i own an HP Z400 Workstation, and audio is not working as expected.

The Problem:

- if i mute the internal speaker, the sound for line out is also muted

- pulse audio, detects the internal speaker as master, so if if use the 
volume control in gnome 3, line-out gets muted, and the internal speaker 
is used

- to hear something on line-out i use alsamixer, and control the volume 
of the "speaker" output to 0

- but even if i set the output of speaker to 0, i can hear the music 
very very silent..

- and last .. the control of "line" does nothing, mute/volume does not 
affect the output

Here some hardware info, if you need more, please tell me.

Thanks.

greetings


 > uname -a
Linux schrank 3.4.3 #1 SMP PREEMPT Wed Jun 20 01:15:11 CEST 2012 x86_64 
GNU/Linux


 > lspci -v
00:1b.0 Audio device: Intel Corporation 82801JI (ICH10 Family) HD Audio 
Controller
         Subsystem: Hewlett-Packard Company Device 1309
         Flags: bus master, fast devsel, latency 0, IRQ 68
         Memory at f6000000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: <access denied>
         Kernel driver in use: snd_hda_intel

 > cat /proc/asound/devices
   1:        : sequencer
   2: [ 0- 2]: digital audio capture
   3: [ 0- 0]: digital audio playback
   4: [ 0- 0]: digital audio capture
   5: [ 0- 0]: hardware dependent
   6: [ 0]   : control
   7: [ 1- 3]: digital audio playback
   8: [ 1- 0]: hardware dependent
   9: [ 1]   : control
  33:        : timer


 > cat /proc/asound/card0/codec\#0
Codec: Realtek ALC262
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0262
Subsystem Id: 0x103c1309
Revision Id: 0x100202
No Modem Function Group found
Default PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=4, o=0, i=0, unsolicited=1, wake=0
   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x11: Stereo
   Converter: stream=8, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x11: Stereo
   Device: name="ALC262 Analog", type="Audio", device=0
   Converter: stream=8, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x04 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x05 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
   Converter: stream=0, channel=0
   Digital:
   Digital category: 0x0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0x1e]: 16 20 24 32
     formats [0x1]: PCM
Node 0x07 [Audio Input] wcaps 0x10011b: Stereo Amp-In
   Control: name="Capture Switch", index=0, device=0
   Control: name="Capture Volume", index=0, device=0
   Device: name="ALC262 Analog", type="Audio", device=0
   Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
   Amp-In vals:  [0x1f 0x1f]
   Converter: stream=4, channel=0
   SDI-Select: 0
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0x6]: 16 20
     formats [0x1]: PCM
   Connection: 1
      0x24
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
   Control: name="Capture Switch", index=1, device=0
   Control: name="Capture Volume", index=1, device=0
   Device: name="ALC262 Analog", type="Audio", device=2
   Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
   Amp-In vals:  [0x00 0x00]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0x6]: 16 20
     formats [0x1]: PCM
   Connection: 1
      0x23
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
   Control: name="Capture Switch", index=2, device=0
   Control: name="Capture Volume", index=2, device=0
   Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
   Amp-In vals:  [0x00 0x00]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0x6]: 16 20
     formats [0x1]: PCM
   Connection: 1
      0x22
Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
   Converter: stream=0, channel=0
   SDI-Select: 0
   Digital:
   Digital category: 0x0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0x1e]: 16 20 24 32
     formats [0x1]: PCM
   Unsolicited: tag=00, enabled=0
   Connection: 1
      0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Control: name="Rear Mic Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Control: name="Rear Mic Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Control: name="Front Mic Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=1, ofs=0
   Control: name="Front Mic Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=1, ofs=0
   Control: name="Line Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=2, ofs=0
   Control: name="Line Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=2, ofs=0
   Control: name="Beep Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=5, ofs=0
   Control: name="Beep Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=5, ofs=0
   Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x1f 0x1f] [0x80 0x80] [0x80 
0x80] [0x9f 0x9f] [0x80 0x80] [0x80 0x80]
   Connection: 8
      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x80 0x80]
   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
   Amp-Out vals:  [0x01 0x01]
   Connection: 2
      0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Control: name="PCM Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
   Amp-Out vals:  [0x1d 0x1d]
   Connection: 2
      0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010e: Mono Amp-In Amp-Out
   Control: name="Speaker Playback Volume", index=0, device=0
     ControlAmp: chs=1, dir=Out, idx=0, ofs=0
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00] [0x00]
   Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
   Amp-Out vals:  [0x00]
   Connection: 2
      0x02 0x0b
Node 0x0f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Pin Complex] wcaps 0x400001: Stereo
   Pincap 0x00000020: IN
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x00:
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0000003e: IN OUT HP Detect Trigger
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
   Unsolicited: tag=00, enabled=0
   Connection: 2
      0x0c* 0x0d
Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Control: name="PCM Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Control: name="Line Out Jack", index=0, device=0
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0000003e: IN OUT HP Detect Trigger
   Pin Default 0x01014c10: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Green
     DefAssociation = 0x1, Sequence = 0x0
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=02, enabled=1
   Connection: 2
      0x0c 0x0d*
Node 0x16 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
   Control: name="Speaker Playback Switch", index=0, device=0
     ControlAmp: chs=1, dir=Out, idx=0, ofs=0
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80]
   Pincap 0x00000010: OUT
   Pin Default 0x99030120: [Fixed] Line Out at Int ATAPI
     Conn = ATAPI, Color = Unknown
     DefAssociation = 0x2, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Connection: 1
      0x0e
Node 0x17 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Control: name="Rear Mic Boost Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Control: name="Rear Mic Jack", index=0, device=0
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0000173e: IN OUT HP Detect Trigger
     Vref caps: HIZ 50 GRD 80
   Pin Default 0x01a19c30: [Jack] Mic at Ext Rear
     Conn = 1/8, Color = Pink
     DefAssociation = 0x3, Sequence = 0x0
   Pin-ctls: 0x21: IN VREF_50
   Unsolicited: tag=03, enabled=1
   Connection: 2
      0x0c* 0x0d
Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Control: name="Front Mic Boost Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Control: name="Front Mic Jack", index=0, device=0
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0000173e: IN OUT HP Detect Trigger
     Vref caps: HIZ 50 GRD 80
   Pin Default 0x02a11c31: [Jack] Mic at Ext Front
     Conn = 1/8, Color = Black
     DefAssociation = 0x3, Sequence = 0x1
   Pin-ctls: 0x24: IN VREF_80
   Unsolicited: tag=04, enabled=1
   Connection: 2
      0x0c* 0x0d
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Control: name="Line Jack", index=0, device=0
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0000173e: IN OUT HP Detect Trigger
     Vref caps: HIZ 50 GRD 80
   Pin Default 0x01813c3f: [Jack] Line In at Ext Rear
     Conn = 1/8, Color = Blue
     DefAssociation = 0x3, Sequence = 0xf
   Pin-ctls: 0x20: IN VREF_HIZ
   Unsolicited: tag=05, enabled=1
   Connection: 2
      0x0c* 0x0d
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Control: name="Headphone Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Control: name="Front Headphone Jack", index=0, device=0
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0000173e: IN OUT HP Detect Trigger
     Vref caps: HIZ 50 GRD 80
   Pin Default 0x02211c40: [Jack] HP Out at Ext Front
     Conn = 1/8, Color = Black
     DefAssociation = 0x4, Sequence = 0x0
   Pin-ctls: 0xc0: OUT HP VREF_HIZ
   Unsolicited: tag=01, enabled=1
   Connection: 2
      0x0c 0x0d*
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
   Pincap 0x00000020: IN
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
   Pincap 0x00000020: IN
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
Node 0x1e [Pin Complex] wcaps 0x400380: Mono Digital
   Pincap 0x00000010: OUT
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=00, enabled=0
   Connection: 1
      0x06
Node 0x1f [Pin Complex] wcaps 0x400280: Mono Digital
   Pincap 0x00000020: IN
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
   Unsolicited: tag=00, enabled=0
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
   Processing caps: benign=0, ncoeff=17
Node 0x21 [Volume Knob Widget] wcaps 0x600080: Mono
   Volume-Knob: delta=0, steps=32, direct=0, val=64
   Unsolicited: tag=00, enabled=0
   Connection: 0
Node 0x22 [Audio Selector] wcaps 0x300101: Stereo
   Control: name="Input Source", index=2, device=0
   Connection: 10
      0x18* 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x0b 0x12
Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Control: name="Input Source", index=1, device=0
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 
0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
   Connection: 9
      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x0b
Node 0x24 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Control: name="Input Source", index=0, device=0
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 
0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
   Connection: 9
      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x0b




-- 
Florian Reitmeir
E-Mail: florian@reitmeir.org
Tel: +43 650 2661660
