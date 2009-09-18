From: Robert Hancock <hancockrwd@gmail.com>
Subject: hda_intel: SPDIF not detected on Asus P7P55D PRO
Date: Thu, 17 Sep 2009 21:38:04 -0600
Message-ID: <4AB3009C.1090605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f182.google.com (mail-yw0-f182.google.com
	[209.85.211.182])
	by alsa0.perex.cz (Postfix) with ESMTP id BE75B24543
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Sep 2009 05:38:08 +0200 (CEST)
Received: by ywh12 with SMTP id 12so857486ywh.23
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2009 20:38:07 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-Devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Harald Welte <HaraldWelte@viatech.com>
List-Id: alsa-devel@alsa-project.org

I just set up a new system running an Asus P7P55D PRO motherboard. It 
looks like this uses the VIA VT1828S codec. The analog output seems to 
work but the SPDIF output isn't recognized. Originally tried 2.6.30.5, 
but Linus' current git doesn't seem any different. The device only gets 
detected as HDA Generic, which, from my reading of the code, ignores 
SPDIF outputs. I tried hacking patch_via.c to add the codec ID to match 
existing types like VT1708S and VT1702, each of those got the SPDIF 
output to show up, but no output showed up on the receiver, and also the 
analog output then stopped being recognized (looks like some node IDs 
don't match).

Is there some extra support that needs to be added for this codec, or 
anything else I can try to get this working? The SPDIF does work in 
Windows 7 with just the standard Microsoft HDA driver..

aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: HDA Generic [HDA Generic]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

The codec data seems to have references to the SPDIF output, but no 
device is actually getting created. The data is below. Any suggestions?

cat /proc/asound/card0/codec#0
Codec: VIA ID 4441
Address: 0
Function Id: 0x1
Vendor Id: 0x11064441
Subsystem Id: 0x104383cf
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
     rates [0x0]:
     bits [0x0]:
     formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=1, o=0, i=0, unsolicited=1, wake=0
   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x08 [Audio Output] wcaps 0x41d: Stereo Amp-Out
   Amp-Out caps: ofs=0x2a, nsteps=0x2a, stepsize=0x05, mute=0
   Amp-Out vals:  [0x2a 0x2a]
   Converter: stream=5, channel=0
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power: setting=D0, actual=D0
Node 0x09 [Audio Output] wcaps 0x41d: Stereo Amp-Out
   Amp-Out caps: ofs=0x2a, nsteps=0x2a, stepsize=0x05, mute=0
   Amp-Out vals:  [0x26 0x26]
   Converter: stream=0, channel=0
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power: setting=D0, actual=D0
Node 0x0a [Audio Output] wcaps 0x41d: Stereo Amp-Out
   Amp-Out caps: ofs=0x2a, nsteps=0x2a, stepsize=0x05, mute=0
   Amp-Out vals:  [0x26 0x26]
   Converter: stream=0, channel=0
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power: setting=D0, actual=D0
Node 0x0b [Audio Output] wcaps 0x41d: Stereo Amp-Out
   Amp-Out caps: ofs=0x2a, nsteps=0x2a, stepsize=0x05, mute=0
   Amp-Out vals:  [0x26 0x26]
   Converter: stream=0, channel=0
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power: setting=D0, actual=D0
Node 0x0c [Audio Output] wcaps 0x41d: Stereo Amp-Out
   Amp-Out caps: ofs=0x2a, nsteps=0x2a, stepsize=0x05, mute=0
   Amp-Out vals:  [0x2a 0x2a]
   Converter: stream=0, channel=0
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power: setting=D0, actual=D0
Node 0x0d [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0e [Audio Output] wcaps 0x611: Stereo Digital
   Converter: stream=0, channel=0
   Digital:
   Digital category: 0x0
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power: setting=D0, actual=D0
Node 0x0f [Audio Output] wcaps 0x611: Stereo Digital
   Converter: stream=0, channel=0
   Digital:
   Digital category: 0x0
   PCM:
     rates [0x5e0]: 44100 48000 88200 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power: setting=D0, actual=D0
Node 0x10 [Audio Input] wcaps 0x10051b: Stereo Amp-In
   Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
   Amp-In vals:  [0x14 0x14]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power: setting=D0, actual=D0
   Connection: 1
      0x1e
Node 0x11 [Audio Input] wcaps 0x10051b: Stereo Amp-In
   Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
   Amp-In vals:  [0x8b 0x8b]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power: setting=D0, actual=D0
   Connection: 1
      0x1f
Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x15 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x16 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x17 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x18 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x80 0x80]
   Power: setting=D0, actual=D0
   Connection: 2
      0x08 0x21
Node 0x19 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x80 0x80]
   Power: setting=D0, actual=D0
   Connection: 2
      0x09 0x21
Node 0x1a [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x80 0x80]
   Power: setting=D0, actual=D0
   Connection: 2
      0x0b 0x21
Node 0x1b [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x80 0x80]
   Power: setting=D0, actual=D0
   Connection: 2
      0x34 0x21
Node 0x1c [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x80 0x80] [0x80 0x80]
   Power: setting=D0, actual=D0
   Connection: 2
      0x35 0x21
Node 0x1d [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1e [Audio Selector] wcaps 0x300501: Stereo
   Power: setting=D0, actual=D0
   Connection: 6
      0x2c* 0x2b 0x2a 0x29 0x28 0x21
Node 0x1f [Audio Selector] wcaps 0x300501: Stereo
   Power: setting=D0, actual=D0
   Connection: 6
      0x2c 0x2b* 0x2a 0x29 0x28 0x21
Node 0x20 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x21 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
   Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
   Amp-In vals:  [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97]
   Power: setting=D0, actual=D0
   Connection: 5
      0x2c 0x2b 0x2a 0x29 0x28
Node 0x22 [Beep Generator Widget] wcaps 0x70040c: Mono Amp-Out
   Amp-Out caps: ofs=0x0a, nsteps=0x12, stepsize=0x05, mute=1
   Amp-Out vals:  [0x00]
   Power: setting=D0, actual=D0
Node 0x23 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x24 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x0001001c: OUT HP EAPD Detect
   EAPD 0x0:
   Pin Default 0x01014010: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Green
     DefAssociation = 0x1, Sequence = 0x0
   Pin-ctls: 0xc0: OUT HP
   Unsolicited: tag=00, enabled=0
   Power: setting=D0, actual=D0
   Connection: 1
      0x18
Node 0x25 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x0000001c: OUT HP Detect
   Pin Default 0x01011012: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0x1, Sequence = 0x2
   Pin-ctls: 0x00:
   Unsolicited: tag=00, enabled=0
   Power: setting=D0, actual=D0
   Connection: 1
      0x19
Node 0x26 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x00000014: OUT Detect
   Pin Default 0x01016011: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Orange
     DefAssociation = 0x1, Sequence = 0x1
   Pin-ctls: 0x00:
   Unsolicited: tag=00, enabled=0
   Power: setting=D0, actual=D0
   Connection: 1
      0x0a
Node 0x27 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x00000014: OUT Detect
   Pin Default 0x01012014: [Jack] Line Out at Ext Rear
     Conn = 1/8, Color = Grey
     DefAssociation = 0x1, Sequence = 0x4
   Pin-ctls: 0x00:
   Unsolicited: tag=00, enabled=0
   Power: setting=D0, actual=D0
   Connection: 1
      0x1a
Node 0x28 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x0000233c: IN OUT HP Detect
     Vref caps: HIZ 50 100
   Pin Default 0x0221401f: [Jack] HP Out at Ext Front
     Conn = 1/8, Color = Green
     DefAssociation = 0x1, Sequence = 0xf
   Pin-ctls: 0xc0: OUT HP VREF_HIZ
   Unsolicited: tag=00, enabled=0
   Power: setting=D0, actual=D0
   Connection: 1
      0x1b
Node 0x29 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x0000233c: IN OUT HP Detect
     Vref caps: HIZ 50 100
   Pin Default 0x02a19037: [Jack] Mic at Ext Front
     Conn = 1/8, Color = Pink
     DefAssociation = 0x3, Sequence = 0x7
   Pin-ctls: 0x00: VREF_HIZ
   Unsolicited: tag=00, enabled=0
   Power: setting=D0, actual=D0
   Connection: 1
      0x1c
Node 0x2a [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x00002334: IN OUT Detect
     Vref caps: HIZ 50 100
   Pin Default 0x0181303e: [Jack] Line In at Ext Rear
     Conn = 1/8, Color = Blue
     DefAssociation = 0x3, Sequence = 0xe
   Pin-ctls: 0x00: VREF_HIZ
   Unsolicited: tag=00, enabled=0
   Power: setting=D0, actual=D0
   Connection: 2
      0x09* 0x0c
Node 0x2b [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x00002334: IN OUT Detect
     Vref caps: HIZ 50 100
   Pin Default 0x01a19036: [Jack] Mic at Ext Rear
     Conn = 1/8, Color = Pink
     DefAssociation = 0x3, Sequence = 0x6
   Pin-ctls: 0x00: VREF_HIZ
   Unsolicited: tag=00, enabled=0
   Power: setting=D0, actual=D0
   Connection: 2
      0x0a* 0x0c
Node 0x2c [Pin Complex] wcaps 0x400401: Stereo
   Pincap 0x00000020: IN
   Pin Default 0x90331138: [Fixed] CD at Int N/A
     Conn = ATAPI, Color = Black
     DefAssociation = 0x3, Sequence = 0x8
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
   Power: setting=D0, actual=D0
Node 0x2d [Pin Complex] wcaps 0x400701: Stereo Digital
   Pincap 0x00000090: OUT HDMI
   Pin Default 0x185600f0: [Jack] Digital Out at Int HDMI
     Conn = Digital, Color = Unknown
     DefAssociation = 0xf, Sequence = 0x0
   Pin-ctls: 0x00:
   Power: setting=D0, actual=D0
   Connection: 1
      0x0e
Node 0x2e [Pin Complex] wcaps 0x400701: Stereo Digital
   Pincap 0x00000010: OUT
   Pin Default 0x074411f0: [Jack] SPDIF Out at Ext Rear Panel
     Conn = RCA, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x00:
   Power: setting=D0, actual=D0
   Connection: 1
      0x0f
Node 0x2f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x30 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x31 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x32 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x33 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x34 [Audio Selector] wcaps 0x300501: Stereo
   Power: setting=D0, actual=D0
   Connection: 3
      0x08* 0x0b 0x0c
Node 0x35 [Audio Selector] wcaps 0x300501: Stereo
   Power: setting=D0, actual=D0
   Connection: 3
      0x08* 0x0b 0x0c
