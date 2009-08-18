From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH] hda: enable speaker output for
	Compaq	6530s/6531s
Date: Tue, 18 Aug 2009 15:06:44 +0800
Message-ID: <20090818070644.GA8839@localhost>
References: <20090816085317.GA23959@localhost> <s5hvdkoi04w.wl%tiwai@suse.de>
	<20090816110110.GA32187@localhost>
	<s5h4os7vsy1.wl%tiwai@suse.de> <s5hd46thbqw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id EE1C72453F
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Aug 2009 09:06:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hd46thbqw.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lin,
	Ming M" <ming.m.lin@intel.com>
List-Id: alsa-devel@alsa-project.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 18, 2009 at 02:33:43PM +0800, Takashi Iwai wrote:
> At Mon, 17 Aug 2009 08:46:14 +0200,
> I wrote:
> > 
> > At Sun, 16 Aug 2009 19:01:10 +0800,
> > Wu Fengguang wrote:
> > > 
> > > On Sun, Aug 16, 2009 at 05:22:23PM +0800, Takashi Iwai wrote:
> > > > At Sun, 16 Aug 2009 16:53:17 +0800,
> > > > Wu Fengguang wrote:
> > > > > 
> > > > > There are 3 causes to the silence of Compaq 6530s' internal speaker:
> > > > > - HP pin 0x11 always return 0xffff,ffff (pin_presence=1),
> > > > >   which automutes the speaker at module loading time.
> > > > 
> > > > This is odd.  Is the sense-trigger issued before reading the pin sense?
> > > 
> > > Sorry, what do you mean?  The facts I explored are:
> > > - ad1884a_hp_automute() will be explicitly called by ad1884a_hp_init()
> > > - ad1884a_hp_unsol_event() is never called on plug events
> > > - I tried manually execute AC_VERB_SET_PIN_SENSE then read pin sense,
> > >   it takes effect on the impedance, but pin_presence still remains 1.
> > 
> > The fact that it returns only -1 sounds rather like a hardware issue.
> > Or, at least, reading a wrong place or so.
> 
> BTW, could you give alsa-info.sh output on both machines?

Attached the saved ones. I should be able to get access to both boxes
tomorrow.

Thanks,
Fengguang


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa-info-6531s.txt"


!!################################
!!ALSA Information Script v 0.4.57
!!################################

!!Script ran on: Tue Aug  4 15:19:17 UTC 2009


!!Linux Distribution
!!------------------

Fedora release 10 (Cambridge) Fedora release 10 (Cambridge) Fedora release 10 (Cambridge) Fedora release 10 (Cambridge)


!!DMI Information
!!---------------

Manufacturer:      Hewlett-Packard
Product Name:      HP Compaq 6531s


!!Kernel Information
!!------------------

Kernel release:    2.6.31-rc2
Operating System:  GNU/Linux
Architecture:      i686
Processor:         i686
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.20
Library version:    1.0.18rc3
Utilities version:  1.0.18rc3


!!Loaded ALSA modules
!!-------------------



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
                      HDA Intel at 0xd8500000 irq 17


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio Controller (rev 03)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:293e (rev 03)
	Subsystem: 103c:30e9


!!Loaded sound module options
!!--------------------------


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Analog Devices AD1984A
Address: 0
Function Id: 0x1
Vendor Id: 0x11d4194a
Subsystem Id: 0x103c30e9
Revision Id: 0x100400
No Modem Function Group found
Default PCM:
    rates [0x7ff]: 8000 11025 16000 22050 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Default Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
GPIO: io=3, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=1, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x30211: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 3 samples
Node 0x03 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x27 0x27]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
Node 0x04 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x27 0x27]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
Node 0x05 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x06 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x07 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x00 0x00]
  Connection: 2
     0x22 0x21
Node 0x08 [Audio Input] wcaps 0x100501: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Connection: 1
     0x0c
Node 0x09 [Audio Input] wcaps 0x100501: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Connection: 1
     0x0d
Node 0x0a [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x00 0x00]
  Connection: 2
     0x04 0x21
Node 0x0b [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x00 0x00]
  Connection: 2
     0x0f 0x21
Node 0x0c [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-Out vals:  [0x34 0x34]
  Connection: 6
     0x14 0x15* 0x16 0x20 0x25 0x17
Node 0x0d [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 6
     0x14* 0x15 0x16 0x20 0x25 0x17
Node 0x0e [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x03* 0x04
Node 0x0f [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x03* 0x04
Node 0x10 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x00]
Node 0x11 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000001f: OUT HP Detect Trigger ImpSense
  Pin Default 0x02212040: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Grey
    DefAssociation = 0x4, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=37, enabled=1
  Connection: 1
     0x07
Node 0x12 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0001001f: OUT HP EAPD Detect Trigger ImpSense
  EAPD 0x0:
  Pin Default 0x410140f0: [N/A] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Connection: 1
     0x0a
Node 0x13 [Pin Complex] wcaps 0x40050c: Mono Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x00]
  Pincap 0x00010010: OUT EAPD
  EAPD 0x0:
  Pin Default 0x413711f0: [N/A] CD at Ext Rear
    Conn = Analog, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Power: setting=D0, actual=D0
  Connection: 1
     0x1f
Node 0x14 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x02 0x02]
  Pincap 0x00003727: IN Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x02a12060: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Grey
    DefAssociation = 0x6, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=36, enabled=1
Node 0x15 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00003727: IN Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x91a71120: [Fixed] Mic at Int Rear
    Conn = Analog, Color = Black
    DefAssociation = 0x2, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
Node 0x16 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00010037: IN OUT EAPD Detect Trigger ImpSense
  EAPD 0x2: EAPD
  Pin Default 0x92174110: [Fixed] Speaker at Int Front
    Conn = Analog, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Connection: 1
     0x0b
Node 0x17 [Pin Complex] wcaps 0x40020b: Stereo Digital Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x17, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x41a6e130: [N/A] Mic at Ext Rear
    Conn = Digital, Color = White
    DefAssociation = 0x3, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x24: IN
Node 0x18 [Vendor Defined Widget] wcaps 0xf00100: Mono
  Connection: 1
     0x06
Node 0x19 [Power Widget] wcaps 0x500500: Mono
  Power: setting=D0, actual=D0
  Connection: 2
     0x20 0x21
Node 0x1a [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x90f711f0: [Fixed] Other at Int N/A
    Conn = Analog, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x1b [Pin Complex] wcaps 0x40038d: Stereo Digital Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=1
  Amp-Out vals:  [0x27 0x27]
  Pincap 0x00000014: OUT Detect
  Pin Default 0x41561150: [N/A] Digital Out at Ext Rear
    Conn = Digital, Color = Black
    DefAssociation = 0x5, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x02
Node 0x1c [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x41813021: [N/A] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x2, Sequence = 0x1
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x24
Node 0x1d [Vendor Defined Widget] wcaps 0xf00100: Mono
  Connection: 25
     0x07* 0x0a 0x0b 0x0c 0x0d 0x0e 0x0f 0x11 0x12 0x13 0x14 0x15 0x16 0x19 0x1a 0x1c 0x1e 0x1f 0x20 0x21 0x22 0x23 0x24 0x25 0x26
Node 0x1e [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x00 0x00]
  Connection: 2
     0x0e 0x21
Node 0x1f [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x1e
Node 0x20 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x09 0x09] [0x97 0x97]
  Connection: 7
     0x14 0x15 0x16 0x1a 0x25 0x03 0x04
Node 0x21 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1f 0x1f]
  Connection: 1
     0x20
Node 0x22 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x03* 0x04
Node 0x23 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x03* 0x04
Node 0x24 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x23 0x21
Node 0x25 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x1c
Node 0x26 [Vendor Defined Widget] wcaps 0xf00100: Mono
  Connection: 3
     0x14* 0x15 0x1c
Node 0x27 [Vendor Defined Widget] wcaps 0xf00301: Stereo Digital
  Connection: 2
     0x08* 0x09
Node 0x28 [Vendor Defined Widget] wcaps 0xf0030d: Stereo Digital Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 2
     0x08* 0x09
Node 0x29 [Vendor Defined Widget] wcaps 0xf0030d: Stereo Digital Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 2
     0x08* 0x09
Node 0x2a [Vendor Defined Widget] wcaps 0xf00301: Stereo Digital
  Connection: 2
     0x01* 0x27
Codec: LSI ID 1040
Address: 1
Function Id: 0x2
Vendor Id: 0x11c11040
Subsystem Id: 0x103c1378
Revision Id: 0x100200
Modem Function Group: 0x1
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----  1 root root 116, 8 Aug  4 23:13 /dev/snd/controlC0
crw-rw----  1 root root 116, 7 Aug  4 23:13 /dev/snd/hwC0D0
crw-rw----  1 root root 116, 6 Aug  4 23:13 /dev/snd/hwC0D1
crw-rw----  1 root root 116, 5 Aug  4 23:15 /dev/snd/pcmC0D0c
crw-rw----  1 root root 116, 4 Aug  4 23:15 /dev/snd/pcmC0D0p
crw-rw----  1 root root 116, 3 Aug  4 23:13 /dev/snd/seq
crw-rw----  1 root root 116, 2 Aug  4 23:13 /dev/snd/timer


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
card 0: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0xd8500000 irq 17'
  Mixer name	: 'Analog Devices AD1984A'
  Components	: 'HDA:11d4194a,103c30e9,00100400 HDA:11c11040,103c1378,00100200'
  Controls      : 24
  Simple ctrls  : 16
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [0.00dB] [on]
  Front Right: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 23
  Mono:
  Front Left: Playback 9 [39%] [-21.00dB] [on]
  Front Right: Playback 9 [39%] [-21.00dB] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 23
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 2 [67%]
  Front Right: 2 [67%]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 54
  Front Left: Capture 52 [96%] [19.50dB] [on]
  Front Right: Capture 52 [96%] [19.50dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 54
  Front Left: Capture 0 [0%] [-58.50dB] [off]
  Front Right: Capture 0 [0%] [-58.50dB] [off]
Simple mixer control 'Beep',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15
  Mono: Playback 15 [100%] [0.00dB] [off]
Simple mixer control 'Dock',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [off]
  Front Right: Playback [off]
Simple mixer control 'Dock Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 23
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Dock Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%]
  Front Right: 0 [0%]
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Mic' 'Internal Mic' 'Dock Mic' 'Mix'
  Item0: 'Internal Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Mic' 'Internal Mic' 'Dock Mic' 'Mix'
  Item0: 'Mic'
Simple mixer control 'Internal Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 23
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Internal Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%]
  Front Right: 0 [0%]
Simple mixer control 'Speaker',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]


!!Alsactl output
!!-------------

--startcollapse--
state.Intel {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -4650
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value.0 31
		value.1 31
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Master Playback Switch'
		value.0 true
		value.1 true
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Dock Playback Switch'
		value.0 false
		value.1 false
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Speaker Playback Switch'
		value.0 true
		value.1 true
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 23'
		comment.dbmin -3450
		comment.dbmax 0
		iface MIXER
		name 'PCM Playback Volume'
		value.0 9
		value.1 9
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'PCM Playback Switch'
		value.0 true
		value.1 true
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 23'
		comment.dbmin -3450
		comment.dbmax 0
		iface MIXER
		name 'Mic Playback Volume'
		value.0 0
		value.1 0
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Mic Playback Switch'
		value.0 false
		value.1 false
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 23'
		comment.dbmin -3450
		comment.dbmax 0
		iface MIXER
		name 'Internal Mic Playback Volume'
		value.0 0
		value.1 0
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Internal Mic Playback Switch'
		value.0 false
		value.1 false
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 23'
		comment.dbmin -3450
		comment.dbmax 0
		iface MIXER
		name 'Dock Mic Playback Volume'
		value.0 0
		value.1 0
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Dock Mic Playback Switch'
		value.0 false
		value.1 false
	}
	control.14 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3000
		iface MIXER
		name 'Mic Boost'
		value.0 2
		value.1 2
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3000
		iface MIXER
		name 'Internal Mic Boost'
		value.0 0
		value.1 0
	}
	control.16 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3000
		iface MIXER
		name 'Dock Mic Boost'
		value.0 0
		value.1 0
	}
	control.17 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 54'
		comment.dbmin -5850
		comment.dbmax 2250
		iface MIXER
		name 'Capture Volume'
		value.0 52
		value.1 52
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 54'
		comment.dbmin -5850
		comment.dbmax 2250
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 false
		value.1 false
	}
	control.21 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Internal Mic'
		comment.item.2 'Dock Mic'
		comment.item.3 Mix
		iface MIXER
		name 'Input Source'
		value 'Internal Mic'
	}
	control.22 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Internal Mic'
		comment.item.2 'Dock Mic'
		comment.item.3 Mix
		iface MIXER
		name 'Input Source'
		index 1
		value Mic
	}
	control.23 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 15'
		comment.dbmin -4500
		comment.dbmax 0
		iface MIXER
		name 'Beep Playback Volume'
		value 15
	}
	control.24 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Beep Playback Switch'
		value false
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module


!!ALSA/HDA dmesg
!!------------------

[   13.148715] ata2.00: ATAPI: Optiarc DVD RW AD-7561S, AH03, max UDMA/100
[   13.155357] HDA Intel 0000:00:1b.0: power state changed by ACPI to D0
[   13.161971] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   13.168508] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   13.168776] ata2.00: ACPI cmd ef/10:03:00:00:00:a0 filtered out
--
[   13.566530] Synaptics Touchpad, model: 1, fw: 6.3, id: 0x1a0b1, caps: 0xa04711/0x200000
[   13.589683] ALSA device list:
[   13.596552]   #0: HDA Intel at 0xd8500000 irq 17
[   13.603683] oprofile: using NMI interrupt.



--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa-info-6530s.txt"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.57
!!################################

!!Script ran on: Thu Jul 30 07:08:50 UTC 2009


!!Linux Distribution
!!------------------

Debian GNU/Linux 5.0 \n \l


!!DMI Information
!!---------------

Manufacturer:      Hewlett-Packard
Product Name:       


!!Kernel Information
!!------------------

Kernel release:    2.6.31-rc4
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.20
Library version:    1.0.19
Utilities version:  1.0.16


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - No

ESound Daemon:
      Installed - Yes (/usr/bin/esd)
      Running - No

Jack:
      Installed - Yes (/usr/bin/jackd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0x98900000 irq 17


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio Controller (rev 03)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:293e (rev 03)
	Subsystem: 103c:30e8


!!Modprobe options (Sound related)
!!--------------------------------

snd-atiixp-modem: index=-2
snd-intel8x0m: index=-2
snd-via82xx-modem: index=-2
snd-pcsp: index=-2


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
	bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1
	enable : Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : 0
	id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
	index : -1,-1,-1,-1,-1,-1,-1,-1
	model : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
	position_fix : 0,0,0,0,0,0,0,0
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1
	probe_only : N,N,N,N,N,N,N,N
	single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Analog Devices AD1984A
Address: 0
Function Id: 0x1
Vendor Id: 0x11d4194a
Subsystem Id: 0x103c30e8
Revision Id: 0x100300
No Modem Function Group found
Default PCM:
    rates [0x7ff]: 8000 11025 16000 22050 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Default Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
GPIO: io=3, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=1, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=1, unsol=0
Node 0x02 [Audio Output] wcaps 0x30211: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 3 samples
Node 0x03 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x27 0x27]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
Node 0x04 [Audio Output] wcaps 0x405: Stereo Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=0
  Amp-Out vals:  [0x27 0x27]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
Node 0x05 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x06 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x07 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x00 0x00]
  Connection: 2
     0x22 0x21
Node 0x08 [Audio Input] wcaps 0x100501: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Connection: 1
     0x0c
Node 0x09 [Audio Input] wcaps 0x100501: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Connection: 1
     0x0d
Node 0x0a [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x00 0x00]
  Connection: 2
     0x04 0x21
Node 0x0b [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x00 0x00]
  Connection: 2
     0x0f 0x21
Node 0x0c [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-Out vals:  [0x25 0x25]
  Connection: 6
     0x14 0x15* 0x16 0x20 0x25 0x17
Node 0x0d [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-Out vals:  [0x25 0x25]
  Connection: 6
     0x14* 0x15 0x16 0x20 0x25 0x17
Node 0x0e [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x03* 0x04
Node 0x0f [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x03* 0x04
Node 0x10 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x00]
Node 0x11 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000001f: OUT HP Detect Trigger ImpSense
  Pin Default 0x02212040: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Grey
    DefAssociation = 0x4, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=37, enabled=1
  Connection: 1
     0x07
Node 0x12 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0001001f: OUT HP EAPD Detect Trigger ImpSense
  EAPD 0x0:
  Pin Default 0x410140f0: [N/A] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Connection: 1
     0x0a
Node 0x13 [Pin Complex] wcaps 0x40050c: Mono Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x00]
  Pincap 0x00010010: OUT EAPD
  EAPD 0x0:
  Pin Default 0x413711f0: [N/A] CD at Ext Rear
    Conn = Analog, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Power: setting=D0, actual=D0
  Connection: 1
     0x1f
Node 0x14 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00003727: IN Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x02a12060: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Grey
    DefAssociation = 0x6, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=36, enabled=1
Node 0x15 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x02 0x02]
  Pincap 0x00003727: IN Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x91a71120: [Fixed] Mic at Int Rear
    Conn = Analog, Color = Black
    DefAssociation = 0x2, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
Node 0x16 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00010037: IN OUT EAPD Detect Trigger ImpSense
  EAPD 0x0:
  Pin Default 0x92174110: [Fixed] Speaker at Int Front
    Conn = Analog, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Connection: 1
     0x0b
Node 0x17 [Pin Complex] wcaps 0x40020b: Stereo Digital Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x17, mute=0
  Amp-In vals:  [0x02 0x02]
  Pincap 0x00000020: IN
  Pin Default 0x41a6e130: [N/A] Mic at Ext Rear
    Conn = Digital, Color = White
    DefAssociation = 0x3, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x24: IN
Node 0x18 [Vendor Defined Widget] wcaps 0xf00100: Mono
  Connection: 1
     0x06
Node 0x19 [Power Widget] wcaps 0x500500: Mono
  Power: setting=D0, actual=D0
  Connection: 2
     0x20 0x21
Node 0x1a [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x90f711f0: [Fixed] Other at Int N/A
    Conn = Analog, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x1b [Pin Complex] wcaps 0x40038d: Stereo Digital Amp-Out
  Amp-Out caps: ofs=0x27, nsteps=0x27, stepsize=0x05, mute=1
  Amp-Out vals:  [0x27 0x27]
  Pincap 0x00000014: OUT Detect
  Pin Default 0x41561150: [N/A] Digital Out at Ext Rear
    Conn = Digital, Color = Black
    DefAssociation = 0x5, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x02
Node 0x1c [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x018130f0: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x24
Node 0x1d [Vendor Defined Widget] wcaps 0xf00100: Mono
  Connection: 25
     0x07* 0x0a 0x0b 0x0c 0x0d 0x0e 0x0f 0x11 0x12 0x13 0x14 0x15 0x16 0x19 0x1a 0x1c 0x1e 0x1f 0x20 0x21 0x22 0x23 0x24 0x25 0x26
Node 0x1e [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x00 0x00]
  Connection: 2
     0x0e 0x21
Node 0x1f [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x1e
Node 0x20 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x10 0x10] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x17 0x17] [0x97 0x97]
  Connection: 7
     0x14 0x15 0x16 0x1a 0x25 0x03 0x04
Node 0x21 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1f 0x1f]
  Connection: 1
     0x20
Node 0x22 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x03* 0x04
Node 0x23 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x03* 0x04
Node 0x24 [Audio Mixer] wcaps 0x200103: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x23 0x21
Node 0x25 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x1c
Node 0x26 [Vendor Defined Widget] wcaps 0xf00100: Mono
  Connection: 3
     0x14* 0x15 0x1c
Node 0x27 [Vendor Defined Widget] wcaps 0xf00301: Stereo Digital
  Connection: 2
     0x08* 0x09
Node 0x28 [Vendor Defined Widget] wcaps 0xf0030d: Stereo Digital Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 2
     0x08* 0x09
Node 0x29 [Vendor Defined Widget] wcaps 0xf0030d: Stereo Digital Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 2
     0x08* 0x09
Node 0x2a [Vendor Defined Widget] wcaps 0xf00301: Stereo Digital
  Connection: 2
     0x01* 0x27
Codec: LSI ID 1040
Address: 1
Function Id: 0x2
Vendor Id: 0x11c11040
Subsystem Id: 0x103c1378
Revision Id: 0x100200
Modem Function Group: 0x1
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root audio 116,  0 Jul 30  2009 /dev/snd/controlC0
crw-rw---- 1 root audio 116,  4 Jul 30  2009 /dev/snd/hwC0D0
crw-rw---- 1 root audio 116,  5 Jul 30  2009 /dev/snd/hwC0D1
crw-rw---- 1 root audio 116, 24 Jul 30  2009 /dev/snd/pcmC0D0c
crw-rw---- 1 root audio 116, 16 Jul 30 15:08 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116,  1 Jul 30  2009 /dev/snd/seq
crw-rw---- 1 root audio 116, 33 Jul 30  2009 /dev/snd/timer


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0x98900000 irq 17'
  Mixer name	: 'Analog Devices AD1984A'
  Components	: 'HDA:11d4194a,103c30e8,00100300 HDA:11c11040,103c1378,00100200'
  Controls      : 23
  Simple ctrls  : 15
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 31 [100%] [0.00dB] [on]
  Front Right: Playback 31 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 23
  Mono:
  Front Left: Playback 23 [100%] [0.00dB] [on]
  Front Right: Playback 23 [100%] [0.00dB] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 23
  Mono:
  Front Left: Playback 16 [70%] [-10.50dB] [on]
  Front Right: Playback 16 [70%] [-10.50dB] [on]
Simple mixer control 'Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%]
  Front Right: 0 [0%]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 54
  Front Left: Capture 37 [69%] [-3.00dB] [on]
  Front Right: Capture 37 [69%] [-3.00dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 54
  Front Left: Capture 37 [69%] [-3.00dB] [on]
  Front Right: Capture 37 [69%] [-3.00dB] [on]
Simple mixer control 'Beep',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 15
  Mono: Playback 15 [100%] [0.00dB] [on]
Simple mixer control 'Digital',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 60 [50%] [0.00dB]
  Front Right: Capture 60 [50%] [0.00dB]
Simple mixer control 'Dock',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [off]
  Front Right: Playback [off]
Simple mixer control 'Dock Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 23
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Dock Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%]
  Front Right: 0 [0%]
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Mic' 'Internal Mic' 'Dock Mic' 'Mix'
  Item0: 'Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Mic' 'Internal Mic' 'Dock Mic' 'Mix'
  Item0: 'Mic'
Simple mixer control 'Internal Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 23
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Internal Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 2 [67%]
  Front Right: 2 [67%]


!!Alsactl output
!!-------------

--startcollapse--
state.Intel {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -4650
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value.0 31
		value.1 31
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Master Playback Switch'
		value.0 true
		value.1 true
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Dock Playback Switch'
		value.0 false
		value.1 false
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 23'
		comment.dbmin -3450
		comment.dbmax 0
		iface MIXER
		name 'PCM Playback Volume'
		value.0 23
		value.1 23
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'PCM Playback Switch'
		value.0 true
		value.1 true
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 23'
		comment.dbmin -3450
		comment.dbmax 0
		iface MIXER
		name 'Mic Playback Volume'
		value.0 16
		value.1 16
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Mic Playback Switch'
		value.0 true
		value.1 true
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 23'
		comment.dbmin -3450
		comment.dbmax 0
		iface MIXER
		name 'Internal Mic Playback Volume'
		value.0 0
		value.1 0
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Internal Mic Playback Switch'
		value.0 false
		value.1 false
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 23'
		comment.dbmin -3450
		comment.dbmax 0
		iface MIXER
		name 'Dock Mic Playback Volume'
		value.0 0
		value.1 0
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Dock Mic Playback Switch'
		value.0 false
		value.1 false
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3000
		iface MIXER
		name 'Mic Boost'
		value.0 0
		value.1 0
	}
	control.13 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3000
		iface MIXER
		name 'Internal Mic Boost'
		value.0 2
		value.1 2
	}
	control.14 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3000
		iface MIXER
		name 'Dock Mic Boost'
		value.0 0
		value.1 0
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 54'
		comment.dbmin -5850
		comment.dbmax 2250
		iface MIXER
		name 'Capture Volume'
		value.0 37
		value.1 37
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
	}
	control.17 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 54'
		comment.dbmin -5850
		comment.dbmax 2250
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 37
		value.1 37
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 true
		value.1 true
	}
	control.19 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Internal Mic'
		comment.item.2 'Dock Mic'
		comment.item.3 Mix
		iface MIXER
		name 'Input Source'
		value Mic
	}
	control.20 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Internal Mic'
		comment.item.2 'Dock Mic'
		comment.item.3 Mix
		iface MIXER
		name 'Input Source'
		index 1
		value Mic
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 15'
		comment.dbmin -4500
		comment.dbmax 0
		iface MIXER
		name 'Beep Playback Volume'
		value 15
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Beep Playback Switch'
		value true
	}
	control.23 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 120'
		comment.tlv '0000000100000008fffff44800000032'
		comment.dbmin -3000
		comment.dbmax 3000
		iface MIXER
		name 'Digital Capture Volume'
		value.0 60
		value.1 60
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
iwlagn
iwlcore
led_class
snd_hda_codec_analog
snd_hda_intel
snd_hda_codec
snd_hwdep
snd_pcm
snd_seq
snd_timer
snd_seq_device
snd
soundcore
snd_page_alloc
video


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x11 0x02212040
0x12 0x410140f0
0x13 0x413711f0
0x14 0x02a12060
0x15 0x91a71120
0x16 0x92174110
0x17 0x41a6e130
0x1a 0x90f711f0
0x1b 0x41561150
0x1c 0x018130f0

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D1/init_pin_configs:

/sys/class/sound/hwC0D1/driver_pin_configs:

/sys/class/sound/hwC0D1/user_pin_configs:

/sys/class/sound/hwC0D1/init_verbs:


!!ALSA/HDA dmesg
!!------------------

[   12.287483] path_id used greatest stack depth: 2336 bytes left
[   12.829953] HDA Intel 0000:00:1b.0: power state changed by ACPI to D0
[   12.830404] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[   12.831024] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   17.145749] iwlagn: Intel(R) Wireless WiFi Link AGN driver for Linux, 1.3.27k



--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--bg08WKrSYDhXBjb5--
