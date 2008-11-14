From: Manuel Naranjo <manuel@aircable.net>
Subject: Re: Mute Beep (was Regression on alsa-driver-1.0.18a
 on HDA for Dell Inspiron 1521)
Date: Fri, 14 Nov 2008 00:16:41 -0200
Message-ID: <491CDF89.4030907@aircable.net>
References: <a10be5a00811120606s12672837secdda91b80659ac8@mail.gmail.com>	<491AE402.3030507@aircable.net>	<s5hk5b9jaim.wl%tiwai@suse.de>	<491AE7F3.2040203@aircable.net>	<s5h7i79j8k8.wl%tiwai@suse.de>	<Pine.LNX.4.61.0811121603350.13649@tm8103.perex-int.cz>	<s5hzlk5htlu.wl%tiwai@suse.de>	<491B2603.9070802@aircable.net>	<s5hwsf7hlyz.wl%tiwai@suse.de>
	<s5hfxlvheio.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090803000901050808050300"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.249])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D0EC10380E
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 03:16:18 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so1238751rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 18:16:17 -0800 (PST)
In-Reply-To: <s5hfxlvheio.wl%tiwai@suse.de>
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

This is a multi-part message in MIME format.
--------------090803000901050808050300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


> FWIW, I already merged the patches to my git tree.
> So the latest snapshot should have already this.
>   
Takashi,
Sorry for the delayed answer. I tried both by patching my yesterday 
snapshot, and by using the new snapshot, neither of them worked 
completly right.

Good part is that now I can decide if I either want to turn on or off 
the bloody beep. But result is the same on both cases, no matter if it's 
on or off it doesn't make a beep (which is pretty good for my ears, but 
not for the code purspose).

I now compiled with --with-debug=full (sorry I didn't do it before, 
actually I compiled with  -O0 -g to figure out the memory leak, but 
forgot to enable printk debugging), I send two dmesg logs, one is 
without telling hda-intel which model to use, the other one is by 
passing model=dell-m42. I'm also attaching alsa-info.sh output for 
model=dell-m42.

I'll take a look at the code tomorrow too see if I can figure out why it 
doesn't beep at all.

Cheers,
Manuel

--------------090803000901050808050300
Content-Type: text/plain;
 name="alsa-info.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-info.txt"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.52
!!################################

!!Script ran on: vie nov 14 00:12:27 ARST 2008


!!Linux Distribution
!!------------------

Mandriva Linux release 2009.0 (Official) for i586 LSB_VERSION=lsb-3.1-ia32:lsb-3.1-noarch DISTRIB_ID=MandrivaLinux DISTRIB_DESCRIPTION="Mandriva Linux 2009.0" Mandriva Linux release 2009.0 (Official) for i586 Mandriva Linux release 2009.0 (Official) for i586 Mandriva Linux release 2009.0 (Official) for i586 Mandriva Linux release 2009.0 (Official) for i586 Mandriva Linux release 2009.0 (Official) for i586


!!Kernel Information
!!------------------

Kernel release:    2.6.27.4-desktop586-1mnb
Operating System:  GNU/Linux
Architecture:      i686
Processor:         AMD Turion(tm) 64 X2 Mobile Technology TL-56
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.18a
Library version:    1.0.18
Utilities version:  1.0.18


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [SB             ]: HDA-Intel - HDA ATI SB
                      HDA ATI SB at 0xfebfc000 irq 16


!!PCI Soundcards installed in the system
!!--------------------------------------

00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:14.2 0403: 1002:4383
	Subsystem: 1028:01fc


!!Modprobe options (Sound related)
!!--------------------------------

snd_hda_intel: model=dell-m42
snd-ac97-codec: power_save=1


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: SigmaTel STAC9205
Address: 0
Vendor Id: 0x838476a0
Subsystem Id: 0x102801fc
Revision Id: 0x100204
No Modem Function Group found
Default PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=0
Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
GPIO: io=5, o=0, i=0, unsolicited=1, wake=1
  IO[0]: enable=1, dir=1, wake=0, sticky=0, data=1
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0
  IO[4]: enable=0, dir=0, wake=0, sticky=0, data=0
Node 0x0a [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0000173f: IN OUT HP Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x0321101f: [Jack] HP Out at Ext Left
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=3a, enabled=1
  Connection: 2
     0x10* 0x11
Node 0x0b [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x03a11020: [Jack] Mic at Ext Left
    Conn = 1/8, Color = Black
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=1b, enabled=1
  Connection: 2
     0x10* 0x11
Node 0x0c [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x400003fa: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0xa
    Misc = NO_PRESENCE
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x11
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0000003f: IN OUT HP Detect Trigger ImpSense
  Pin Default 0x90170310: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x10
Node 0x0e [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x400003fb: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0xb
    Misc = NO_PRESENCE
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x10
Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x400003fc: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0xc
    Misc = NO_PRESENCE
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x11
Node 0x10 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x4f 0x4f]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x11 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0xff 0xff]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x12 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Delay: 13 samples
  Connection: 1
     0x1d
  Processing caps: benign=0, ncoeff=0
Node 0x13 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Delay: 13 samples
  Connection: 1
     0x1e
  Processing caps: benign=0, ncoeff=0
Node 0x14 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x00]
  Pincap 0x00000010: OUT
  Pin Default 0x400003fd: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0xd
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Connection: 1
     0x15
Node 0x15 [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x10
Node 0x16 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x40f000f9: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x9
  Pin-ctls: 0x00:
Node 0x17 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x90a60330: [Fixed] Mic at Int N/A
    Conn = Digital, Color = Unknown
    DefAssociation = 0x3, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x18 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x400003ff: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0xf
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x19 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x04 0x04]
  Connection: 7
     0x0e 0x16 0x0f 0x0b* 0x0c 0x0d 0x0a
Node 0x1a [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x04 0x04]
  Connection: 7
     0x0e 0x16 0x0f 0x0b* 0x0c 0x0d 0x0a
Node 0x1b [Audio Selector] wcaps 0x300103: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x0c 0x0c]
  Connection: 1
     0x19
Node 0x1c [Audio Selector] wcaps 0x300103: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x0c 0x0c]
  Connection: 1
     0x1a
Node 0x1d [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Connection: 3
     0x1b* 0x17 0x18
Node 0x1e [Audio Selector] wcaps 0x30090d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Connection: 3
     0x1c* 0x17 0x18
Node 0x1f [Audio Output] wcaps 0x40211: Stereo Digital
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Delay: 4 samples
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
  Pincap 0x00000010: OUT
  Pin Default 0x0144131f: [Jack] SPDIF Out at Ext Rear
    Conn = RCA, Color = Black
    DefAssociation = 0x1, Sequence = 0xf
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 3
     0x1f* 0x1d 0x1e
Node 0x22 [Pin Complex] wcaps 0x430681: Stereo Digital
  Pincap 0x00010024: IN EAPD Detect
  EAPD 0x0:
  Pin Default 0x40c003fe: [N/A] SPDIF In at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0xe
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
  Connection: 2
     0x10* 0x11
Node 0x25 [Vendor Defined Widget] wcaps 0xf00001: Stereo
Codec: Conexant ID 2c06
Address: 1
Vendor Id: 0x14f12c06
Subsystem Id: 0x14f1000f
Revision Id: 0x100000
Modem Function Group: 0x2
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  0 2008-11-14 00:09 /dev/snd/controlC0
crw-rw----+ 1 root audio 116, 24 2008-11-14 00:12 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116, 16 2008-11-14 00:12 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116, 17 2008-11-14 00:09 /dev/snd/pcmC0D1p
crw-rw----+ 1 root audio 116,  1 2008-11-14 00:09 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 2008-11-14 00:09 /dev/snd/timer


!!ALSA configuration files
!!------------------------

!!User specific config file (~/.asoundrc)

#pcm.bluetooth {
#    type bluetooth
#    device 00:12:0E:06:C5:8A
#    profile "voice"
#}

pcm.pulse {
    type pulse
}
    
ctl.pulse {
    type pulse
}
        

!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 1: STAC92xx Digital [STAC92xx Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [SB]

Card hw:0 'SB'/'HDA ATI SB at 0xfebfc000 irq 16'
  Mixer name	: 'SigmaTel STAC9205'
  Components	: 'HDA:838476a0,102801fc,00100204 HDA:14f12c06,14f1000f,00100000'
  Controls      : 24
  Simple ctrls  : 16
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 79 [62%] [-36.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 127 [100%] [0.00dB] [on]
  Front Right: Playback 127 [100%] [0.00dB] [on]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958 Playback Source',0
  Capabilities: enum
  Items: 'Digital Playback' 'Analog Mux 1' 'Analog Mux 2'
  Item0: 'Digital Playback'
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 12 [80%] [18.00dB] [on]
  Front Right: Capture 12 [80%] [18.00dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 12 [80%] [18.00dB] [on]
  Front Right: Capture 12 [80%] [18.00dB] [on]
Simple mixer control 'Analog Loopback',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Digital',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 120 [100%] [30.00dB]
  Front Right: Capture 120 [100%] [30.00dB]
Simple mixer control 'Digital Input Source',0
  Capabilities: enum
  Items: 'Analog Inputs' 'Digital Mic 1'
  Item0: 'Analog Inputs'
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Mic'
  Item0: 'Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Mic'
  Item0: 'Mic'
Simple mixer control 'Mux',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 4
  Front Left: Capture 4 [100%] [40.00dB]
  Front Right: Capture 4 [100%] [40.00dB]
Simple mixer control 'Mux',1
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 4
  Front Left: Capture 4 [100%] [40.00dB]
  Front Right: Capture 4 [100%] [40.00dB]
Simple mixer control 'PC Beep',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 3
  Mono: Playback 3 [100%] [0.00dB] [on]


!!Alsactl output
!!-------------

--startcollapse--
state.SB {
	control.1 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		iface MIXER
		name 'Input Source'
		value Mic
	}
	control.2 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		iface MIXER
		name 'Input Source'
		index 1
		value Mic
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Analog Loopback'
		value false
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		comment.dbmin 0
		comment.dbmax 2250
		iface MIXER
		name 'Capture Volume'
		value.0 12
		value.1 12
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		comment.dbmin 0
		comment.dbmax 2250
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 12
		value.1 12
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 true
		value.1 true
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 127'
		comment.dbmin -9525
		comment.dbmax 0
		iface MIXER
		name 'Front Playback Volume'
		value.0 127
		value.1 127
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Front Playback Switch'
		value.0 true
		value.1 true
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 3'
		comment.dbmin -1800
		comment.dbmax 0
		iface MIXER
		name 'PC Beep Playback Volume'
		value 3
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PC Beep Playback Switch'
		value true
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 4'
		comment.dbmin 0
		comment.dbmax 4000
		iface MIXER
		name 'Mux Capture Volume'
		value.0 4
		value.1 4
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
		index 1
		value.0 4
		value.1 4
	}
	control.14 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Analog Inputs'
		comment.item.1 'Digital Mic 1'
		iface MIXER
		name 'Digital Input Source'
		value 'Analog Inputs'
	}
	control.15 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Digital Playback'
		comment.item.1 'Analog Mux 1'
		comment.item.2 'Analog Mux 2'
		iface MIXER
		name 'IEC958 Playback Source'
		value 'Digital Playback'
	}
	control.16 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.17 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.18 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.19 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value true
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 127'
		comment.dbmin -9525
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value 79
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.23 {
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
	control.24 {
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 120'
		comment.tlv '0000000100000008fffff44800000032'
		comment.dbmin -3000
		comment.dbmax 3000
		iface MIXER
		name 'Digital Capture Volume'
		value.0 120
		value.1 120
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
snd_hda_intel
snd_seq_oss
snd_seq_midi_event
snd_seq
snd_seq_device
snd_pcm_oss
snd_pcm
snd_timer
snd_page_alloc
snd_mixer_oss
snd
soundcore
af_packet
fglrx
ipv6
vboxdrv
binfmt_misc
loop
vfat
fat
dm_mod
cpufreq_ondemand
cpufreq_conservative
cpufreq_powersave
powernow_k8
freq_table
nvram
i8k
b44
ssb
pcmcia
uvcvideo
pcmcia_core
sdhci_pci
video
compat_ioctl32
mmc_block
output
mii
i2c_piix4
ohci1394
videodev
sdhci
v4l1_compat
ricoh_mmc
mmc_core
battery
rtc_cmos
ieee1394
wmi
thermal
ac
i2c_core
button
processor
k8temp
dcdbas
ati_agp
sr_mod
agpgart
ndiswrapper
shpchp
pci_hotplug
joydev
evdev
sg
pata_atiixp
ata_piix
ahci
libata
dock
sd_mod
scsi_mod
crc_t10dif
ext3
jbd
uhci_hcd
ohci_hcd
ehci_hcd
usbcore



--------------090803000901050808050300
Content-Type: text/plain;
 name="log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="log"

ALSA /home/manuel/tmp/alsa/alsa-driver/acore/../alsa-kernel/core/device.c:102: device free dc3fd81c (from stac92xx_free+0x56/0x90 [snd_hda_intel]), not found
ALSA /home/manuel/tmp/alsa/alsa-driver/acore/../alsa-kernel/core/device.c:102: device free dc3fd828 (from stac92xx_free+0x56/0x90 [snd_hda_intel]), not found
HDA Intel 0000:00:14.2: PCI INT A disabled
HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
ALSA /home/manuel/tmp/alsa/alsa-driver/pci/hda/hda_codec.c:3312: autoconfig: line_outs=1 (0xd/0x0/0x0/0x0/0x0)
ALSA /home/manuel/tmp/alsa/alsa-driver/pci/hda/hda_codec.c:3316:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /home/manuel/tmp/alsa/alsa-driver/pci/hda/hda_codec.c:3320:    hp_outs=1 (0xa/0x0/0x0/0x0/0x0)
ALSA /home/manuel/tmp/alsa/alsa-driver/pci/hda/hda_codec.c:3321:    mono: mono_out=0x0
ALSA /home/manuel/tmp/alsa/alsa-driver/pci/hda/hda_codec.c:3329:    inputs: mic=0xb, fmic=0x0, line=0x0, fline=0x0, cd=0x0, aux=0x0
ALSA /home/manuel/tmp/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:2786: dac_nids=1 (0x10/0x0/0x0/0x0/0x0)
input: HDA Digital PCBeep as /class/input/input18
input: HDA ATI SB at 0xfebfc000 irq 16 Mic at Ext Left Jack as /class/input/input19
input: HDA ATI SB at 0xfebfc000 irq 16 HP Out at Ext Left Jack as /class/input/input20
hda-intel: Invalid position buffer, using LPIB read method instead.

--------------090803000901050808050300
Content-Type: text/plain;
 name="log.model"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="log.model"

ALSA /home/manuel/tmp/alsa/alsa-driver/acore/../alsa-kernel/core/device.c:102: device free dc3fcc1c (from stac92xx_free+0x56/0x90 [snd_hda_intel]), not found
ALSA /home/manuel/tmp/alsa/alsa-driver/acore/../alsa-kernel/core/device.c:102: device free dc3fcc28 (from stac92xx_free+0x56/0x90 [snd_hda_intel]), not found
HDA Intel 0000:00:14.2: PCI INT A disabled
HDA Intel 0000:00:14.2: PCI INT A -> GSI 16 (level, low) -> IRQ 16
ALSA /home/manuel/tmp/alsa/alsa-driver/pci/hda/hda_codec.c:2596: hda_codec: model 'dell-m42' is selected
ALSA /home/manuel/tmp/alsa/alsa-driver/pci/hda/hda_codec.c:3312: autoconfig: line_outs=1 (0xd/0x0/0x0/0x0/0x0)
ALSA /home/manuel/tmp/alsa/alsa-driver/pci/hda/hda_codec.c:3316:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
ALSA /home/manuel/tmp/alsa/alsa-driver/pci/hda/hda_codec.c:3320:    hp_outs=1 (0xa/0x0/0x0/0x0/0x0)
ALSA /home/manuel/tmp/alsa/alsa-driver/pci/hda/hda_codec.c:3321:    mono: mono_out=0x0
ALSA /home/manuel/tmp/alsa/alsa-driver/pci/hda/hda_codec.c:3329:    inputs: mic=0xb, fmic=0x0, line=0x0, fline=0x0, cd=0x0, aux=0x0
ALSA /home/manuel/tmp/alsa/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_sigmatel.c:2786: dac_nids=1 (0x10/0x0/0x0/0x0/0x0)
input: HDA Digital PCBeep as /class/input/input21
input: HDA ATI SB at 0xfebfc000 irq 16 Mic at Ext Left Jack as /class/input/input22
input: HDA ATI SB at 0xfebfc000 irq 16 HP Out at Ext Left Jack as /class/input/input23
hda-intel: Invalid position buffer, using LPIB read method instead.

--------------090803000901050808050300
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------090803000901050808050300--
