From: Ady Deac <ady@mikesnet.ro>
Subject: SPDIF In on ALC889 to speakers?
Date: Mon, 20 Jun 2011 16:11:13 +0300
Message-ID: <4DFF46F1.8090402@mikesnet.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www001.mikesnet.ro (www001.mikesnet.ro [78.46.222.131])
	by alsa0.perex.cz (Postfix) with ESMTP id E1007243B6
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 15:11:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by www001.mikesnet.ro (Postfix) with ESMTP id AE0133C947
	for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2011 13:11:13 +0000 (GMT)
Received: from www001.mikesnet.ro ([127.0.0.1])
	by localhost (www001.mikesnet.ro [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ykVpAO9XyDLw for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 13:11:13 +0000 (GMT)
Received: from [172.16.0.13] (unknown [109.100.95.246])
	by www001.mikesnet.ro (Postfix) with ESMTPA
	for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2011 13:11:13 +0000 (GMT)
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

Hi guys,

I have an GA-890FXA-UD5 mobo with an intel-hda sound card. I've 
purchased an additional SPDIF In adapter (bracket) to be able to play 
digital content on my 5.1 speakers. I have the speakers connected to the 
jacks (ie. not to the SPDIF Out). I've checked the Windows drivers, but 
these also only support bypassing SPDIF In to SPDIF Out. Is there any 
way to have this done by the card itself? Maybe some developers tweaks? 
Some chipset routing maybe? :D I know that the CM106 chipset needs some 
special initialization (eg: wr 00  20 05 30 01) to actually bypass the 
SPDIF In to the speakers, but it works! Anything that can be done in 
this case?

Else, is there an easy way of bypassing the SPDIF Input to the speakers 
but also to allow the use of the card for playback?

Thank you!

-- 
Deac Mihai-Adrian

W: www.mikesoftware.com
P: +40-745-256.364, +40-723-85.44.44
F: +40-264-566.033


00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA) (rev 40)

# cat /proc/asound/card0/codec*
Codec: Realtek ALC889
Address: 0
Function Id: 0x1
Vendor Id: 0x10ec0889
Subsystem Id: 0x1458a102
Revision Id: 0x100004
No Modem Function Group found
Default PCM:
     rates [0x5f0]: 32000 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=2, o=0, i=0, unsolicited=1, wake=1
   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x11: Stereo
   Converter: stream=0, channel=0
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x11: Stereo
   Converter: stream=0, channel=2
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x04 [Audio Output] wcaps 0x11: Stereo
   Converter: stream=0, channel=4
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x05 [Audio Output] wcaps 0x11: Stereo
   Converter: stream=0, channel=6
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
   Converter: stream=0, channel=0
   Digital: Enabled
   Digital category: 0x0
   PCM:
     rates [0x5f0]: 32000 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x07 [Audio Input] wcaps 0x10011b: Stereo Amp-In
   Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
   Amp-In vals:  [0x13 0x13]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Connection: 1
      0x24
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
   Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
   Amp-In vals:  [0x00 0x00]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Connection: 1
      0x23
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
   Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
   Amp-In vals:  [0x00 0x00]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Connection: 1
      0x22
Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
   Converter: stream=0, channel=0
   SDI-Select: 0
   Digital:
   Digital category: 0x0
   PCM:
     rates [0x570]: 32000 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Unsolicited: tag=00, enabled=0
   Connection: 1
      0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x1f 0x1f] [0x80 0x80] [0x80 
0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
   Connection: 10
      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x3e, nsteps=0x40, stepsize=0x03, mute=0
   Amp-Out vals:  [0x40 0x40]
   Connection: 2
      0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x3e, nsteps=0x40, stepsize=0x03, mute=0
   Amp-Out vals:  [0x40 0x40]
   Connection: 2
      0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x3e, nsteps=0x40, stepsize=0x03, mute=0
   Amp-Out vals:  [0x40 0x40]
   Connection: 2
      0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x3e, nsteps=0x40, stepsize=0x03, mute=0
   Amp-Out vals:  [0x40 0x40]
   Connection: 2
      0x05 0x0b
Node 0x10 [Audio Output] wcaps 0x211: Stereo Digital
   Converter: stream=0, channel=0
   Digital: Enabled
   Digital category: 0x0
   PCM:
     rates [0x5f0]: 32000 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x11 [Pin Complex] wcaps 0x400300: Mono Digital
   Pincap 0x00000010: OUT
   Pin Default 0x99430140: [Fixed] SPDIF Out at Int ATAPI
     Conn = ATAPI, Color = Unknown
     DefAssociation = 0x4, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Connection: 1
      0x10
Node 0x12 [Pin Complex] wcaps 0x400001: Stereo
   Pincap 0x00000020: IN
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x0000003c: IN OUT HP Detect
   Pin Default 0x01014410: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Green
     DefAssociation = 0x1, Sequence = 0x0
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x0000003c: IN OUT HP Detect
   Pin Default 0x01011412: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0x1, Sequence = 0x2
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c 0x0d* 0x0e 0x0f 0x26
Node 0x16 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x00000034: IN OUT Detect
   Pin Default 0x01016411: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Orange
     DefAssociation = 0x1, Sequence = 0x1
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c 0x0d 0x0e* 0x0f 0x26
Node 0x17 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x00000034: IN OUT Detect
   Pin Default 0x01012414: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Grey
     DefAssociation = 0x1, Sequence = 0x4
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c 0x0d 0x0e 0x0f* 0x26
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0000373c: IN OUT HP Detect
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x01a19c50: [Jack] Mic at Ext Rear
     Conn = 1/8, Color = Pink
     DefAssociation = 0x5, Sequence = 0x0
   Pin-ctls: 0x24: IN VREF_80
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c 0x0d 0x0e 0x0f 0x26*
Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0000373c: IN OUT HP Detect
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x02a19c60: [Jack] Mic at Ext Front
     Conn = 1/8, Color = Pink
     DefAssociation = 0x6, Sequence = 0x0
   Pin-ctls: 0x24: IN VREF_80
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c 0x0d 0x0e 0x0f 0x26*
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0000373c: IN OUT HP Detect
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x0181345f: [Jack] Line In at Ext Rear
     Conn = 1/8, Color = Blue
     DefAssociation = 0x5, Sequence = 0xf
   Pin-ctls: 0x20: IN VREF_HIZ
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c 0x0d 0x0e 0x0f 0x26*
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
   Amp-In vals:  [0x00 0x00]
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0000373c: IN OUT HP Detect
     Vref caps: HIZ 50 GRD 80 100
   Pin Default 0x02214c20: [Jack] HP Out at Ext Front
     Conn = 1/8, Color = Green
     DefAssociation = 0x2, Sequence = 0x0
   Pin-ctls: 0xc0: OUT HP VREF_HIZ
   Unsolicited: tag=00, enabled=0
   Connection: 5
      0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1c [Pin Complex] wcaps 0x400081: Stereo
   Pincap 0x00000024: IN Detect
   Pin Default 0x593301f0: [N/A] CD at Int ATAPI
     Conn = ATAPI, Color = Unknown
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
   Unsolicited: tag=00, enabled=0
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
   Pincap 0x00000020: IN
   Pin Default 0x4005e601: [N/A] Line Out at Ext N/A
     Conn = Optical, Color = White
     DefAssociation = 0x0, Sequence = 0x1
   Pin-ctls: 0x20: IN
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
   Pincap 0x00000010: OUT
   Pin Default 0x014b6130: [Jack] SPDIF Out at Ext Rear
     Conn = Comb, Color = Orange
     DefAssociation = 0x3, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Connection: 1
      0x06
Node 0x1f [Pin Complex] wcaps 0x400280: Mono Digital
   Pincap 0x00000020: IN
   Pin Default 0x01cb7170: [Jack] SPDIF In at Ext Rear
     Conn = Comb, Color = Yellow
     DefAssociation = 0x7, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
   Unsolicited: tag=00, enabled=0
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
   Processing caps: benign=0, ncoeff=28
   Processing Coefficient: 0x00
   Coefficient Index: 0x0f
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 
0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 
0x80]
   Connection: 11
      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 
0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 
0x80]
   Connection: 11
      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x24 [Audio Selector] wcaps 0x300101: Stereo
   Connection: 12
      0x18* 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b 0x12
Node 0x25 [Audio Output] wcaps 0x11: Stereo
   Converter: stream=0, channel=0
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x3e, nsteps=0x40, stepsize=0x03, mute=0
   Amp-Out vals:  [0x3e 0x3e]
   Connection: 2
      0x25 0x0b
