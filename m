From: Armando Di Cianno <armando@goodship.net>
Subject: Re: HDMI v. ICH8 on Dell XPS M1330
Date: Thu, 28 Feb 2008 20:25:53 -0500
Message-ID: <1204248353.12914.83.camel@localhost>
References: <1204152070.12914.18.camel@localhost>
	<s5hablls40f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-svkU5R2fLiRg6DNr+j7n"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from squid9.laughingsquid.net (squid9.laughingsquid.net
	[72.32.92.32]) by alsa0.perex.cz (Postfix) with ESMTP id 1E90724609
	for <alsa-devel@alsa-project.org>; Fri, 29 Feb 2008 02:27:04 +0100 (CET)
In-Reply-To: <s5hablls40f.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--=-svkU5R2fLiRg6DNr+j7n
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Thu, 2008-02-28 at 12:40 +0100, Takashi Iwai wrote:
> The HDMI on HD-audio is currently handled equivalently with SPDIF.
> So, this device is the HDMI.  Try to output this?  Don't forget to
> adjust 'IEC958'-related mixer controls.
Ahh, okay, so it /should/ work.  That is good news.

I've finally had a chance to test tonight.  Toggling the IEC958
mute/unmute doesn't seem to change things via a default aplay.  Using
aplay -D hw:0,1 Noise.wav doesn't work because of set_params errors.
Using the plughw form doesn't output audio, but seems to last the
correct duratioI can happily try any suggested cvs/subversion/mercurial
version, if needed.n of time it should.  If aplay -l looks like this:

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: STAC92xx Digital [STAC92xx Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

... then I'm under the impression that aplay -D plughw:0,1 Noise.wav
should work over HDMI, if everything connected correctly, yes?

> > If there is anyway I can help the core developers get HDMI audio
> > working, I would be glad to help.  I will post all the relevant
> > information I can think of following; please let me know if other
> > information would be helpful.
> 
> Use alsa-info.sh.  This will contain far more information.

Here you go; please find attached, or here: http://pastebin.ca/922821 ;
I really do hope this helps.

Again, I'm using the official 1.0.16 tarball release -- this is mainly
because it survives a suspend/hibernate, while in-kernel does not.

-- 
Armando Di Cianno
http://dicianno.org/blog
armando@dicianno.org
armando@goodship.net




--=-svkU5R2fLiRg6DNr+j7n
Content-Disposition: attachment; filename=alsa-info.txt
Content-Type: text/plain; name=alsa-info.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit

name=fafhrd&type=33&description=/tmp/alsa-info.txt&expiry=&s=Submit+Post&content=
!!################################
!!ALSA Information Script v 0.4.41
!!################################

!!Script ran on: Thu Feb 28 20:23:06 EST 2008


!!Linux Distribution
!!------------------

Gentoo Base System release 1.12.11.1


!!Kernel Information
!!------------------

Kernel release:    2.6.24-gentoo-r3-adc0
Operating System:  GNU/Linux
Architecture:      i686
Processor:         Intel(R) Core(TM)2 Duo CPU T7500 @ 2.20GHz
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.16
Library version:    1.0.16
Utilities version:  1.0.16


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xfebfc000 irq 21


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 82801H (ICH8 Family) HD Audio Controller (rev 02)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:284b (rev 02)
	Subsystem: 1028:0209


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
enable : Y,Y,Y,Y,Y,Y,Y,Y
enable_msi : 0
id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
index : -1,-1,-1,-1,-1,-1,-1,-1
model : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
position_fix : 0,0,0,0,0,0,0,0
power_save : 0
power_save_controller : Y
probe_mask : -1,-1,-1,-1,-1,-1,-1,-1
single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: SigmaTel STAC9228
Address: 0
Vendor Id: 0x83847616
Subsystem Id: 0x10280209
Revision Id: 0x100201
No Modem Function Group found
Default PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x0e, stepsize=0x05, mute=0
Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
GPIO: io=3, o=0, i=0, unsolicited=1, wake=1
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[2]: enable=1, dir=1, wake=0, sticky=0, data=1
Node 0x02 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x76 0x76]
  Converter: stream=5, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x03 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x7f 0x7f]
  Converter: stream=5, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x04 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x76 0x76]
  Converter: stream=5, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x05 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x7f 0x7f]
  Converter: stream=5, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x06 [Vendor Defined Widget] wcaps 0xfd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x07 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Delay: 13 samples
  Connection: 1
     0x1b
  Processing caps: benign=0, ncoeff=0
Node 0x08 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Delay: 13 samples
  Connection: 1
     0x1c
  Processing caps: benign=0, ncoeff=0
Node 0x09 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Delay: 13 samples
  Connection: 1
     0x1d
  Processing caps: benign=0, ncoeff=0
Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x08173f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x02214020: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=30, enabled=1
  Connection: 2
     0x02* 0x03
Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x08173f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x02a19080: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0x8, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Connection: 2
     0x02 0x03*
Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x0181304e: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x4, Sequence = 0xe
  Pin-ctls: 0x40: OUT VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x03
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x08173f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x02
Node 0x0e [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01a19040: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x4, Sequence = 0x0
  Pin-ctls: 0x40: OUT VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x04
Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x01011012: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0x2
  Pin-ctls: 0x40: OUT VREF_HIZ
  Unsolicited: tag=30, enabled=1
  Connection: 1
     0x05
Node 0x10 [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0837: IN OUT Detect Trigger ImpSense
  Pin Default 0x01016011: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Orange
    DefAssociation = 0x1, Sequence = 0x1
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x04
Node 0x11 [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0837: IN OUT Detect Trigger ImpSense
  Pin Default 0x40000100: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0x0, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x03
Node 0x12 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x40000100: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0x0, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
Node 0x13 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x40000100: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0x0, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x14 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x40000100: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0x0, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x15 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x03 0x03]
  Connection: 9
     0x0e 0x12 0x0f 0x0b 0x0c* 0x0d 0x0a 0x10 0x11
Node 0x16 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x03 0x03]
  Connection: 9
     0x0e 0x12 0x0f 0x0b 0x0c* 0x0d 0x0a 0x10 0x11
Node 0x17 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x04 0x04]
  Connection: 9
     0x0e 0x12 0x0f 0x0b 0x0c* 0x0d 0x0a 0x10 0x11
Node 0x18 [Audio Selector] wcaps 0x300103: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x0c 0x0c]
  Connection: 1
     0x15
Node 0x19 [Audio Selector] wcaps 0x300103: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x0c 0x0c]
  Connection: 1
     0x16
Node 0x1a [Audio Selector] wcaps 0x300103: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x0c 0x0c]
  Connection: 1
     0x17
Node 0x1b [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Connection: 3
     0x18* 0x13 0x14
Node 0x1c [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Connection: 3
     0x19* 0x13 0x14
Node 0x1d [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Connection: 3
     0x1a* 0x13 0x14
Node 0x1e [Audio Output] wcaps 0x40211: Stereo Digital
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x1
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 4 samples
Node 0x1f [Vendor Defined Widget] wcaps 0xf30201: Stereo Digital
  Delay: 3 samples
Node 0x20 [Audio Input] wcaps 0x140311: Stereo Digital
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
     0x22
Node 0x21 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x01442070: [Jack] SPDIF Out at Ext Rear
    Conn = RCA, Color = Grey
    DefAssociation = 0x7, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Connection: 5
     0x1e* 0x1f 0x1b 0x1c 0x1d
Node 0x22 [Pin Complex] wcaps 0x430681: Stereo Digital
  Pincap 0x0810024: IN EAPD Detect
  EAPD 0x0:
  Pin Default 0x40000100: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0x0, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Delay: 3 samples
Node 0x23 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=0
  Amp-Out vals:  [0x00]
Node 0x24 [Volume Knob Widget] wcaps 0x600000: Mono
  Volume-Knob: delta=1, steps=127, direct=1, val=127
  Connection: 4
     0x02* 0x03 0x04 0x05
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root audio 116,  0 2008-02-27 22:46 /dev/snd/controlC0
crw-rw---- 1 root audio 116,  4 2008-02-27 22:46 /dev/snd/hwC0D0
crw-rw---- 1 root audio 116, 24 2008-02-27 22:46 /dev/snd/pcmC0D0c
crw-rw---- 1 root audio 116, 16 2008-02-28 20:15 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116, 17 2008-02-28 20:18 /dev/snd/pcmC0D1p
crw-rw---- 1 root audio 116,  1 2008-02-27 22:46 /dev/snd/seq
crw-rw---- 1 root audio 116, 33 2008-02-27 22:46 /dev/snd/timer


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: STAC92xx Digital [STAC92xx Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 3/3
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Simple mixer control 'Master',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 127 [100%] [0.00dB] [on]
  Front Right: Playback 127 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 235 [92%] [-4.00dB]
  Front Right: Playback 235 [92%] [-4.00dB]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 118 [93%] [-6.75dB] [on]
  Front Right: Playback 118 [93%] [-6.75dB] [on]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 118 [93%] [-6.75dB] [on]
  Front Right: Playback 118 [93%] [-6.75dB] [on]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 127 [100%] [0.00dB] [on]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 127 [100%] [0.00dB] [on]
Simple mixer control 'Line In as Output',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Mic as Output',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 14
  Front Left: Capture 12 [86%] [18.00dB] [on]
  Front Right: Capture 12 [86%] [18.00dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 14
  Front Left: Capture 12 [86%] [18.00dB] [on]
  Front Right: Capture 12 [86%] [18.00dB] [on]
Simple mixer control 'Capture',2
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 14
  Front Left: Capture 12 [86%] [18.00dB] [on]
  Front Right: Capture 12 [86%] [18.00dB] [on]
Simple mixer control 'Analog Loopback',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Digital Input Source',0
  Capabilities: enum
  Items: 'Analog Inputs'
  Item0: 'Analog Inputs'
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Mic' 'Front Mic' 'Line'
  Item0: 'Line'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Mic' 'Front Mic' 'Line'
  Item0: 'Line'
Simple mixer control 'Input Source',2
  Capabilities: cenum
  Items: 'Mic' 'Front Mic' 'Line'
  Item0: 'Line'
Simple mixer control 'Mux',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 4
  Front Left: Capture 3 [75%] [30.00dB]
  Front Right: Capture 3 [75%] [30.00dB]
Simple mixer control 'Mux',1
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 4
  Front Left: Capture 3 [75%] [30.00dB]
  Front Right: Capture 3 [75%] [30.00dB]
Simple mixer control 'Mux',2
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 4
  Front Left: Capture 4 [100%] [40.00dB]
  Front Right: Capture 4 [100%] [40.00dB]
Simple mixer control 'Swap Center/LFE',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]


!!Alsactl output
!!-------------

--startcollapse--
state.Intel {
	control.1 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Front Mic'
		comment.item.2 Line
		iface MIXER
		name 'Input Source'
		value Line
	}
	control.2 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Front Mic'
		comment.item.2 Line
		iface MIXER
		name 'Input Source'
		index 1
		value Line
	}
	control.3 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Front Mic'
		comment.item.2 Line
		iface MIXER
		name 'Input Source'
		index 2
		value Line
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Analog Loopback'
		value false
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 14'
		comment.dbmin 0
		comment.dbmax 2100
		iface MIXER
		name 'Capture Volume'
		value.0 12
		value.1 12
	}
	control.6 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
	}
	control.7 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 4'
		comment.dbmin 0
		comment.dbmax 4000
		iface MIXER
		name 'Mux Capture Volume'
		value.0 3
		value.1 3
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 14'
		comment.dbmin 0
		comment.dbmax 2100
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 12
		value.1 12
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 true
		value.1 true
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 4'
		comment.dbmin 0
		comment.dbmax 4000
		iface MIXER
		name 'Mux Capture Volume'
		index 1
		value.0 3
		value.1 3
	}
	control.11 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 14'
		comment.dbmin 0
		comment.dbmax 2100
		iface MIXER
		name 'Capture Volume'
		index 2
		value.0 12
		value.1 12
	}
	control.12 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		index 2
		value.0 true
		value.1 true
	}
	control.13 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 4'
		comment.dbmin 0
		comment.dbmax 4000
		iface MIXER
		name 'Mux Capture Volume'
		index 2
		value.0 4
		value.1 4
	}
	control.14 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 127'
		comment.dbmin -9525
		comment.dbmax 0
		iface MIXER
		name 'Front Playback Volume'
		value.0 118
		value.1 118
	}
	control.15 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Front Playback Switch'
		value.0 true
		value.1 true
	}
	control.16 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 127'
		comment.dbmin -9525
		comment.dbmax 0
		iface MIXER
		name 'Surround Playback Volume'
		value.0 118
		value.1 118
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Surround Playback Switch'
		value.0 true
		value.1 true
	}
	control.18 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 127'
		comment.dbmin -9525
		comment.dbmax 0
		iface MIXER
		name 'Center Playback Volume'
		value 127
	}
	control.19 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Center Playback Switch'
		value true
	}
	control.20 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 127'
		comment.dbmin -9525
		comment.dbmax 0
		iface MIXER
		name 'LFE Playback Volume'
		value 127
	}
	control.21 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'LFE Playback Switch'
		value true
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Swap Center/LFE Playback Switch'
		value true
	}
	control.23 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Line In as Output Switch'
		value true
	}
	control.24 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic as Output Switch'
		value true
	}
	control.25 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 127'
		comment.dbmin -9525
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value.0 127
		value.1 127
	}
	control.26 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Master Playback Switch'
		value.0 true
		value.1 true
	}
	control.27 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Analog Inputs'
		iface MIXER
		name 'Digital Input Source'
		value 'Analog Inputs'
	}
	control.28 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.29 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.30 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.31 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
	}
	control.32 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 255'
		comment.tlv '0000000100000008ffffec1400000014'
		comment.dbmin -5100
		comment.dbmax 0
		iface MIXER
		name 'PCM Playback Volume'
		value.0 235
		value.1 235
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
snd_seq_oss
snd_seq_midi_event
snd_seq
snd_seq_device
snd_pcm_oss
snd_mixer_oss
snd_hda_intel
snd_pcm
snd_timer
snd_page_alloc
snd_hwdep
snd
vmnet
vmmon
vmblock
rfcomm
l2cap
eth1394
ohci1394
tg3
uinput
video
backlight
uvcvideo
compat_ioctl32
videodev
v4l1_compat
v4l2_common
nvidia
ricoh_mmc
iwl4965
mac80211
sdhci
i2c_i801
hci_usb



--=-svkU5R2fLiRg6DNr+j7n
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-svkU5R2fLiRg6DNr+j7n--
