From: asd <asd@marian1000.go.ro>
Subject: Fwd: Re: Patch for power on headphone amp on Realtek
	883
Date: Mon, 09 Jun 2014 10:34:42 +0300
Message-ID: <2655347.m0fpUDov8d@marian1000.go.ro>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart45239958.mc5si8KVpm"
Content-Transfer-Encoding: 7Bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from marian1000.go.ro (5-14-228-204.residential.rdsnet.ro
 [5.14.228.204]) by alsa0.perex.cz (Postfix) with ESMTP id 1266726554B
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 09:34:43 +0200 (CEST)
Received: from localhost ([127.0.0.1] helo=marian1000.go.ro)
 by marian1000.go.ro with esmtp (Exim 4.82)
 (envelope-from <asd@marian1000.go.ro>) id 1Wtu6N-0001XP-Bn
 for alsa-devel@alsa-project.org; Mon, 09 Jun 2014 10:34:43 +0300
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

--nextPart45239958.mc5si8KVpm
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi 
Here is content;
#uname -a
Linux marian1000.go.ro 3.14-1-amd64 #1 SMP Debian 3.14.4-1 (2014-05-13) x86_64 
GNU/Linux
#cat /proc/asound/Intel/codec#0
Codec: Realtek ALC883
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10ec0883
Subsystem Id: 0x1043829f
Revision Id: 0x100002
No Modem Function Group found
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
GPIO: io=2, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x11: Stereo
  Device: name="ALC883 Analog", type="Audio", device=0
  Converter: stream=8, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=8, channel=2
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x04 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=8, channel=4
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x05 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=8, channel=6
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="IEC958 Default PCM Playback Switch", index=0, device=0
  Device: name="ALC883 Digital", type="SPDIF", device=1
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Device: name="ALC883 Analog", type="Audio", device=0
  Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x10 0x10]
  Converter: stream=4, channel=0
  SDI-Select: 0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x23
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Control: name="Capture Volume", index=1, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=1, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Device: name="ALC883 Alt Analog", type="Audio", device=2
  Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80]
  Converter: stream=3, channel=0
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
  IEC Coding Type: 0x0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Front Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Front Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Rear Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Rear Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Line Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="Line Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="Beep Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=5, ofs=0
  Control: name="Beep Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=5, ofs=0
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] 
[0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 10
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Control: name="Front Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x1f 0x1f]
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Control: name="Surround Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x1f 0x1f]
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Control: name="Center Playback Volume", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="LFE Playback Volume", index=0, device=0
    ControlAmp: chs=2, dir=Out, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x1f 0x1f]
  Connection: 2
     0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Control: name="Side Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x1f 0x1f]
  Connection: 2
     0x05 0x0b
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Control: name="Front Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line Out Front Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000003e: IN OUT HP Detect Trigger
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=05, enabled=1
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x15 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Control: name="Surround Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line Out Surround Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000003e: IN OUT HP Detect Trigger
  Pin Default 0x01011012: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0x2
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=06, enabled=1
  Connection: 5
     0x0c 0x0d* 0x0e 0x0f 0x26
Node 0x16 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Control: name="Center Playback Switch", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="LFE Playback Switch", index=0, device=0
    ControlAmp: chs=2, dir=Out, idx=0, ofs=0
  Control: name="Line Out CLFE Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000003e: IN OUT HP Detect Trigger
  Pin Default 0x01016011: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Orange
    DefAssociation = 0x1, Sequence = 0x1
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=07, enabled=1
  Connection: 5
     0x0c 0x0d 0x0e* 0x0f 0x26
Node 0x17 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Control: name="Side Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line Out Side Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000003e: IN OUT HP Detect Trigger
  Pin Default 0x01012014: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Grey
    DefAssociation = 0x1, Sequence = 0x4
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=08, enabled=1
  Connection: 5
     0x0c 0x0d 0x0e 0x0f* 0x26
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
  Pin Default 0x01a19840: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x4, Sequence = 0x0
  Pin-ctls: 0x21: IN VREF_50
  Unsolicited: tag=03, enabled=1
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
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
  Pin Default 0x02a19c50: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0x5, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=02, enabled=1
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Control: name="Line Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Line Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000173e: IN OUT HP Detect Trigger
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x0181304f: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x4, Sequence = 0xf
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=04, enabled=1
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Front Headphone Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000173e: IN OUT HP Detect Trigger
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x02214c20: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=01, enabled=1
  Connection: 5
     0x0c 0x0d 0x0e 0x0f 0x26*
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x593301f0: [N/A] CD at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x4015e601: [N/A] Speaker at Ext N/A
    Conn = Optical, Color = White
    DefAssociation = 0x0, Sequence = 0x1
  Pin-ctls: 0x00:
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
  Control: name="SPDIF Phantom Jack", index=0, device=0
  Pincap 0x00000010: OUT
  Pin Default 0x01441130: [Jack] SPDIF Out at Ext Rear
    Conn = RCA, Color = Black
    DefAssociation = 0x3, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Connection: 1
     0x06
Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=0, ncoeff=17
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] 
[0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00 0x00]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x23 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] 
[0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00 0x00]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x25 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0
  Amp-Out vals:  [0x1f 0x1f]
  Connection: 2
     0x25 0x0b


--nextPart45239958.mc5si8KVpm
Content-Type: message/rfc822
Content-Disposition: inline; filename="forwarded message"
Content-Description: Takashi Iwai <tiwai@suse.de>: Re: [alsa-devel] Patch for power on headphone amp on Realtek 883

Return-Path: <alsa-devel-bounces@alsa-project.org>
Envelope-to: asd@marian1000.go.ro
Delivery-date: Mon, 09 Jun 2014 10:28:54 +0300
Received: from alsa0.perex.cz ([77.48.224.243]) by marian1000.go.ro with esmtp (Exim 4.82) (envelope-from <alsa-devel-bounces@alsa-project.org>) id 1Wtu0k-0001TZ-Ht for asd@marian1000.go.ro; Mon, 09 Jun 2014 10:28:54 +0300
Received: by alsa0.perex.cz (Postfix, from userid 1000) id 043092655E6; Mon,  9 Jun 2014 09:28:52 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on mail1.perex.cz
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=disabled version=3.2.4
Received: from alsa0.perex.cz (localhost [IPv6:::1]) by alsa0.perex.cz (Postfix) with ESMTP id 3EDA82655B8; Mon,  9 Jun 2014 09:28:20 +0200 (CEST)
X-Original-To: Alsa-devel@alsa-project.org
Delivered-To: Alsa-devel@alsa-project.org
Received: by alsa0.perex.cz (Postfix, from userid 1000) id 21122265551; Mon,  9 Jun 2014 09:28:18 +0200 (CEST)
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15]) by alsa0.perex.cz (Postfix) with ESMTP id 9660D265367 for <Alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 09:28:10 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254]) by mx2.suse.de (Postfix) with ESMTP id BACADAC34; Mon,  9 Jun 2014 07:28:09 +0000 (UTC)
Date: Mon, 09 Jun 2014 09:28:09 +0200
Message-ID: <s5hvbsawnhy.wl%tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: asd <asd@marian1000.go.ro>
In-Reply-To: <1552287.TJAWsn00qn@marian1000.go.ro>
References: <1552287.TJAWsn00qn@marian1000.go.ro>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI/1.14.6 (Maruoka) FLIM/1.14.9 =?UTF-8?B?KEdvasWNKQ==?= APEL/10.8 Emacs/24.3 (x86_64-suse-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0
Cc: Alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Patch for power on headphone amp on Realtek 883
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers - http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>, <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org

The complete context is missing: on which machine, what this patch
really fixes, why it's needed, how it achieves, and which kernel to be
applied.

Please give details.  It's much more important than the code change.


thanks,

Takashi

At Mon, 09 Jun 2014 10:06:59 +0300,
asd wrote:
> 
> Index: hda/hda_codec.h
> ===================================================================
> --- hda.orig/hda_codec.h	2014-06-08 22:54:07.000000000 +0300
> +++ hda/hda_codec.h	2014-06-09 09:43:42.359115743 +0300
> @@ -259,6 +259,7 @@
>  	HDA_PCM_NTYPES
>  };
>  
> +
>  /* for PCM creation */
>  struct hda_pcm {
>  	char *name;
> @@ -287,6 +288,14 @@
>  	u32 subsystem_id;
>  	u32 revision_id;
>  
> +	/* custom pin complex headphone amp */
> +	bool hp_set;
> +	hda_nid_t hp_front;
> +	hda_nid_t hp_rear;
> +	hda_nid_t hp_clfe;
> +	hda_nid_t hp_side;
> +	hda_nid_t hp_fout;
> +
>  	/* detected preset */
>  	const struct hda_codec_preset *preset;
>  	struct module *owner;
> Index: hda/patch_realtek.c
> ===================================================================
> --- hda.orig/patch_realtek.c	2014-06-07 12:38:24.000000000 +0300
> +++ hda/patch_realtek.c	2014-06-09 09:22:53.306622242 +0300
> @@ -322,6 +322,12 @@
>  		case 0x10ec0880:
>  		case 0x10ec0882:
>  		case 0x10ec0883:
> +			codec->hp_set = 1;
> +			codec->hp_front = 0x14;
> +			codec->hp_rear = 0x15;
> +			codec->hp_clfe = 0x16;
> +			codec->hp_side = 0x17;
> +			codec->hp_fout = 0x1b;
>  		case 0x10ec0885:
>  		case 0x10ec0887:
>  		/*case 0x10ec0889:*/ /* this causes an SPDIF problem */
> Index: hda/hda_codec.c
> ===================================================================
> --- hda.orig/hda_codec.c	2014-06-08 22:54:07.000000000 +0300
> +++ hda/hda_codec.c	2014-06-09 09:45:32.473468469 +0300
> @@ -27,6 +27,7 @@
>  #include <linux/mutex.h>
>  #include <linux/module.h>
>  #include <linux/async.h>
> +#include <linux/delay.h>
>  #include <sound/core.h>
>  #include "hda_codec.h"
>  #include <sound/asoundef.h>
> @@ -120,6 +121,56 @@
>  #define hda_call_pm_notify(codec, state) {}
>  #endif
>  
> +static void enable_hp_codec(struct hda_codec *codec)
> +{
> +
> +	mutex_unlock(&codec->control_mutex);
> +	if ((codec->hp_set = 1)) {
> +	snd_hda_codec_write(codec, codec->hp_front, 0,
> +			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc0);
> +
> +	snd_hda_codec_write(codec, codec->hp_rear, 0,
> +			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc0);
> +
> +	snd_hda_codec_write(codec, codec->hp_clfe, 0,
> +			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc0);
> +
> +	snd_hda_codec_write(codec, codec->hp_side, 0,
> +			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc0);
> +
> +	snd_hda_codec_write(codec, codec->hp_fout, 0,
> +			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc0);
> +	} 
> +
> +	mutex_lock(&codec->control_mutex);
> +
> +}
> +
> +static void mute_all_analog_outs(struct hda_codec *codec)
> +{
> +	mutex_unlock(&codec->control_mutex);
> +	if ((codec->hp_set = 1)) {
> +	snd_hda_codec_write(codec,codec->hp_front, 0,
> +			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
> +
> +	snd_hda_codec_write(codec,codec->hp_rear, 0,
> +			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
> +
> +	snd_hda_codec_write(codec,codec->hp_clfe, 0,
> +			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
> +
> +	snd_hda_codec_write(codec,codec->hp_side, 0,
> +			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
> +
> +	snd_hda_codec_write(codec,codec->hp_fout, 0,
> +			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
> +	}
> +	mutex_lock(&codec->control_mutex);
> +}
> +
> +
> +
> +
>  /**
>   * snd_hda_get_jack_location - Give a location string of the jack
>   * @cfg: pin default config value
> @@ -5418,8 +5469,9 @@
>  				/* FIXME: need notify? */
>  			}
>  		}
> -		mutex_unlock(&codec->spdif_mutex);
> +		mutex_unlock(&codec->spdif_mutex);    
>  	}
> +	enable_hp_codec(codec);
>  	return snd_pcm_hw_constraint_step(substream->runtime, 0,
>  					  SNDRV_PCM_HW_PARAM_CHANNELS, 2);
>  }
> @@ -5530,6 +5582,7 @@
>  		mout->dig_out_used = 0;
>  	}
>  	mutex_unlock(&codec->spdif_mutex);
> +	mute_all_analog_outs(codec);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(snd_hda_multi_out_analog_cleanup);
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--nextPart45239958.mc5si8KVpm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--nextPart45239958.mc5si8KVpm--
