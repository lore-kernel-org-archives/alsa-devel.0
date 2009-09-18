From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: hda_intel: SPDIF not detected on Asus P7P55D PRO
Date: Fri, 18 Sep 2009 08:38:26 -0600
Message-ID: <51f3faa70909180738y6c8d1ecevb7ce90b3de6699b0@mail.gmail.com>
References: <4AB3009C.1090605@gmail.com> <s5hiqfg6aj5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f220.google.com (mail-ew0-f220.google.com
	[209.85.219.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B35624414
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Sep 2009 16:38:27 +0200 (CEST)
Received: by ewy20 with SMTP id 20so1367554ewy.45
	for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2009 07:38:26 -0700 (PDT)
In-Reply-To: <s5hiqfg6aj5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-Devel <alsa-devel@alsa-project.org>, Harald Welte <HaraldWelte@viatech.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 18, 2009 at 12:18 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 17 Sep 2009 21:38:04 -0600,
> Robert Hancock wrote:
>>
>> I just set up a new system running an Asus P7P55D PRO motherboard. It
>> looks like this uses the VIA VT1828S codec. The analog output seems to
>> work but the SPDIF output isn't recognized. Originally tried 2.6.30.5,
>> but Linus' current git doesn't seem any different. The device only gets
>> detected as HDA Generic, which, from my reading of the code, ignores
>> SPDIF outputs. I tried hacking patch_via.c to add the codec ID to match
>> existing types like VT1708S and VT1702, each of those got the SPDIF
>> output to show up, but no output showed up on the receiver, and also the
>> analog output then stopped being recognized (looks like some node IDs
>> don't match).
>
> Could you give alsa-info.sh output (run with --no-upload option)?

Here it is:

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.58
!!################################

!!Script ran on: Fri Sep 18 14:36:47 UTC 2009


!!Linux Distribution
!!------------------

Fedora release 11 (Leonidas) Fedora release 11 (Leonidas) Fedora
release 11 (Leonidas) Fedora release 11 (Leonidas)


!!DMI Information
!!---------------

Manufacturer:      System manufacturer
Product Name:      System Product Name


!!Kernel Information
!!------------------

Kernel release:    2.6.30.5-43.fc11.x86_64
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         x86_64
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.20
Library version:    1.0.21
Utilities version:  1.0.21


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - Yes

aRts:
      Installed - Yes (/usr/bin/artsd)
      Running - No

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xf7ff8000 irq 37


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation Ibex Peak High Definition Audio (rev 05)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:3b56 (rev 05)
	Subsystem: 1043:8375


!!Modprobe options (Sound related)
!!--------------------------------

snd_hda_intel: enable_msi=1


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
	bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : 1
	id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	model : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
	position_fix : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	power_save : 5
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N
	single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

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
  Amp-Out vals:  [0x28 0x28]
  Converter: stream=0, channel=0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power: setting=D0, actual=D0
Node 0x0a [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Amp-Out caps: ofs=0x2a, nsteps=0x2a, stepsize=0x05, mute=0
  Amp-Out vals:  [0x28 0x28]
  Converter: stream=0, channel=0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power: setting=D0, actual=D0
Node 0x0b [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Amp-Out caps: ofs=0x2a, nsteps=0x2a, stepsize=0x05, mute=0
  Amp-Out vals:  [0x28 0x28]
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
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
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
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116, 6 Sep 17 23:42 /dev/snd/controlC0
crw-rw----+ 1 root audio 116, 5 Sep 17 23:42 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116, 4 Sep 17 23:43 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116, 3 Sep 18 08:36 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116, 2 Sep 17 23:42 /dev/snd/timer


!!ALSA configuration files
!!------------------------

!!System wide config file (/etc/asound.conf)

#
# Place your global alsa-lib configuration here...
#

@hooks [
	{
		func load
		files [
			"/etc/alsa/pulse-default.conf"
		]
		errors false
	}
]


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: HDA Generic [HDA Generic]
  Subdevices: 0/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: HDA Generic [HDA Generic]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0xf7ff8000 irq 37'
  Mixer name	: 'VIA ID 4441'
  Components	: 'HDA:11064441,104383cf,00100100'
  Controls      : 4
  Simple ctrls  : 3
Simple mixer control 'Master',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 42
  Mono:
  Front Left: Playback 42 [100%] [0.00dB]
  Front Right: Playback 42 [100%] [0.00dB]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 20 [65%] [13.50dB] [on]
  Front Right: Capture 20 [65%] [13.50dB] [on]


!!Alsactl output
!!-------------

--startcollapse--
state.Intel {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -1650
		comment.dbmax 3000
		iface MIXER
		name 'Capture Volume'
		value.0 20
		value.1 20
	}
	control.3 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 42'
		comment.dbmin -6300
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value.0 42
		value.1 42
	}
	control.4 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 255'
		comment.tlv '0000000100000008ffffec1400000014'
		comment.dbmin -5100
		comment.dbmax 0
		iface MIXER
		name 'PCM Playback Volume'
		value.0 255
		value.1 255
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
ipv6
vboxnetadp
vboxnetflt
vboxdrv
cpufreq_ondemand
acpi_cpufreq
freq_table
fuse
dm_multipath
uinput
nvidia
snd_hda_codec_via
snd_hda_intel
snd_hda_codec
snd_hwdep
gspca_spca561
snd_pcm
gspca_main
snd_timer
videodev
r8169
snd
firewire_ohci
i2c_i801
v4l1_compat
firewire_core
soundcore
v4l2_compat_ioctl32
asus_atk0110
crc_itu_t
snd_page_alloc
mii
i2c_core
usb_storage
wmi
pata_jmicron
joydev
pcspkr
hwmon
serio_raw
ata_generic
pata_acpi
sata_nv


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x24 0x01014010
0x25 0x01011012
0x26 0x01016011
0x27 0x01012014
0x28 0x0221401f
0x29 0x02a19037
0x2a 0x0181303e
0x2b 0x01a19036
0x2c 0x90331138
0x2d 0x185600f0
0x2e 0x074411f0

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:


!!ALSA/HDA dmesg
!!------------------

  alloc kstat_irqs on cpu 0 node 0
HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
  alloc irq_desc for 37 on cpu 0 node 0
  alloc kstat_irqs on cpu 0 node 0
HDA Intel 0000:00:1b.0: irq 37 for MSI/MSI-X
HDA Intel 0000:00:1b.0: setting latency timer to 64
firewire_core: created device fw0: GUID 001e8c0001fee238, S400
--
SELinux: initialized (dev fuse, type fuse), uses genfs_contexts
ALSA sound/pci/hda/hda_intel.c:623: hda_intel: No response from codec,
disabling MSI: last cmd=0x024f0c00
ALSA sound/pci/hda/hda_intel.c:636: hda_intel: azx_get_response
timeout, switching to polling mode: last cmd=0x024f0c00
ACPI: EC: non-query interrupt received, switching to interrupt mode
