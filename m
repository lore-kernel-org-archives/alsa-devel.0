From: Jan Gutter <alsa@jangutter.com>
Subject: Re: Intel DG45ID motherboard and weird pinouts
Date: Fri, 07 Nov 2008 06:59:38 +0200
Message-ID: <1226033978.11157.0.camel@sparky.jangutter.com>
References: <9bcb35630810210901t5959bfev654898b0e58e3a68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from labmail.lucidview.net (labmail.lucidview.net [196.213.94.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CBEF103878
	for <alsa-devel@alsa-project.org>; Fri,  7 Nov 2008 06:00:12 +0100 (CET)
Received: from mail.lucidview.net ([192.168.133.216])
	by labmail.lucidview.net (8.14.3/8.14.3) with ESMTP id mA7509pX030284
	for <alsa-devel@alsa-project.org>; Fri, 7 Nov 2008 07:00:10 +0200
Received: from [192.168.1.9]
	(25.18.177.41-get-oneprice-adsl-for-only-R169.cybersmart.co.za
	[41.177.18.25]) (Authenticated sender: jang_mail@lucidview.net)
	by mail.lucidview.net (Postfix) with ESMTPA id 3CD6E310001
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Nov 2008 07:00:07 +0200 (SAST)
In-Reply-To: <9bcb35630810210901t5959bfev654898b0e58e3a68@mail.gmail.com>
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

On Tue, Oct 21, 2008 at 6:01 PM, Jan Arie Gutter <alsa@jangutter.com> wrote:

OK, I've tried 1.0.18 and analog out is still going into all the wrong channels.

Any help guys? Is this the wrong list?

This is the codec config reported:

bollie@laundromat ~ $ cat /proc/asound/Intel/codec#2
Codec: IDT 92HD73E1X5
Address: 2
Vendor Id: 0x111d7676
Subsystem Id: 0x80865002
Revision Id: 0x100202
No Modem Function Group found
Default PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
GPIO: io=8, o=0, i=0, unsolicited=1, wake=1
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[4]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[5]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[6]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[7]: enable=0, dir=0, wake=0, sticky=0, data=0
Node 0x0a [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x0000173f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x0221401f: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=3a, enabled=1
  Connection: 6
     0x15 0x16 0x17 0x18 0x19* 0x1e
Node 0x0b [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x0000173f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x02a19020: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=1b, enabled=1
  Connection: 6
     0x15* 0x16 0x17 0x18 0x19 0x1e
Node 0x0c [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01113014: [Jack] Speaker at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x1, Sequence = 0x4
  Pin-ctls: 0x40: OUT VREF_HIZ
  Unsolicited: tag=2e, enabled=1
  Connection: 6
     0x15* 0x16 0x17 0x18 0x19 0x1e
Node 0x0d [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x0000003f: IN OUT HP Detect Trigger ImpSense
  Pin Default 0x01114010: [Jack] Speaker at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=2f, enabled=1
  Connection: 6
     0x15 0x16 0x17 0x18 0x19* 0x1e
Node 0x0e [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01a19030: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=1e, enabled=1
  Connection: 6
     0x15* 0x16 0x17 0x18 0x19 0x1e
Node 0x0f [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000037: IN OUT Detect Trigger ImpSense
  Pin Default 0x01111012: [Jack] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0x2
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=2f, enabled=1
  Connection: 6
     0x15* 0x16 0x17 0x18 0x19 0x1e
Node 0x10 [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000037: IN OUT Detect Trigger ImpSense
  Pin Default 0x01116011: [Jack] Speaker at Ext Rear
    Conn = 1/8, Color = Orange
    DefAssociation = 0x1, Sequence = 0x1
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=36, enabled=1
  Connection: 6
     0x15 0x16* 0x17 0x18 0x19 0x1e
Node 0x11 [Pin Complex] wcaps 0x400183: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000037: IN OUT Detect Trigger ImpSense
  Pin Default 0x40f000f0: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 6
     0x15 0x16 0x17* 0x18 0x19 0x1e
Node 0x12 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x00000024: IN Detect
  Pin Default 0x40f000f0: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
Node 0x13 [Pin Complex] wcaps 0x400003: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x40f000f0: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x20: IN
Node 0x14 [Pin Complex] wcaps 0x400003: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x40f000f0: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x20: IN
Node 0x15 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x7f 0x7f]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x16 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x7f 0x7f]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x17 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x7f 0x7f]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x18 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x7f 0x7f]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x19 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x1a [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Delay: 13 samples
  Connection: 1
     0x20
  Processing caps: benign=0, ncoeff=0
Node 0x1b [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Delay: 13 samples
  Connection: 1
     0x21
  Processing caps: benign=0, ncoeff=0
Node 0x1c [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=1
  Amp-Out vals:  [0x00]
Node 0x1d [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97]
  Connection: 5
     0x28 0x29 0x2a 0x2b 0x12
Node 0x1e [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f 0x9f]
  Connection: 1
     0x1d
Node 0x1f [Volume Knob Widget] wcaps 0x600000: Mono
  Volume-Knob: delta=1, steps=127, direct=1, val=127
  Connection: 5
     0x15* 0x16 0x17 0x18 0x19
Node 0x20 [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 12
     0x0a 0x0b 0x0c 0x0d 0x0e 0x0f 0x10 0x11 0x12 0x13 0x14 0x1d*
Node 0x21 [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 12
     0x0a 0x0b 0x0c 0x0d 0x0e 0x0f 0x10 0x11 0x12 0x13 0x14 0x1d*
Node 0x22 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x40f000f0: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Connection: 3
     0x25 0x20 0x21*
Node 0x23 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x01451140: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Black
    DefAssociation = 0x4, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 3
     0x26 0x20* 0x21
Node 0x24 [Pin Complex] wcaps 0x400681: Stereo Digital
  Pincap 0x00010024: IN EAPD Detect
  EAPD 0x0:
  Pin Default 0x40f000f0: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
Node 0x25 [Audio Output] wcaps 0x4021d: Stereo Digital Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 4 samples
Node 0x26 [Audio Output] wcaps 0x4021d: Stereo Digital Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 4 samples
Node 0x27 [Audio Input] wcaps 0x14031b: Stereo Digital Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00]
  Converter: stream=0, channel=0
  SDI-Select: 0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 4 samples
  Connection: 1
     0x24
Node 0x28 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0a 0x0b* 0x0d 0x0f
Node 0x29 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0a 0x0e* 0x10 0x11
Node 0x2a [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x0b 0x0c* 0x10 0x11
Node 0x2b [Audio Selector] wcaps 0x300101: Stereo
  Connection: 4
     0x15 0x16 0x17 0x18*

-- 
"-and those damned stupid barbarians with their
damned stupid swords will win after all..."
-- Larry Niven (The Magic Goes Away)
