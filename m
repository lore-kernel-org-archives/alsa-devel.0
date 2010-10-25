From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: snd-hda-intel + ad198x is broken with 2.6.36
Date: Mon, 25 Oct 2010 11:33:26 +0300
Message-ID: <201010251133.26363.anarsoul@gmail.com>
References: <201010242045.49003.anarsoul@gmail.com>
	<s5hzku295d6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WDUxMUbtr62ELMI"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D3DC4103884
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Oct 2010 10:33:39 +0200 (CEST)
Received: by ewy22 with SMTP id 22so1352836ewy.38
	for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2010 01:33:39 -0700 (PDT)
In-Reply-To: <s5hzku295d6.wl%tiwai@suse.de>
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

--Boundary-00=_WDUxMUbtr62ELMI
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Monday 25 October 2010 09:03:01 Takashi Iwai wrote:

> Could you run alsa-info.sh (with --no-upload option) before and after
> the problem occurs, and attach these outputs?

Sure, output is in attachment

> My rough guess is that it's the change of PCM stream assignment in
> 2.6.36.  How about the patch below?

Patch fixed problem, thanks!

Regards
Vasily

--Boundary-00=_WDUxMUbtr62ELMI
Content-Type: text/plain;
  charset="UTF-8";
  name="alsa-info-not-working.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="alsa-info-not-working.txt"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.59
!!################################

!!Script ran on: Mon Oct 25 08:25:09 UTC 2010


!!Linux Distribution
!!------------------

Gentoo Base System release 2.0.1


!!DMI Information
!!---------------

Manufacturer:      LENOVO
Product Name:      0768B9G


!!Kernel Information
!!------------------

Kernel release:    2.6.36-gentoo-anarsoul
Operating System:  GNU/Linux
Architecture:      i686
Processor:         Intel(R) Core(TM)2 CPU T5500 @ 1.66GHz
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.23
Library version:    1.0.23
Utilities version:  1.0.23


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

No sound servers found.


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xd0340000 irq 40


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 02)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:27d8 (rev 02)
	Subsystem: 17aa:2066


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
	bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	position_fix : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Analog Devices AD1986A
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x11d41986
Subsystem Id: 0x17aa2066
Revision Id: 0x100500
No Modem Function Group found
Default PCM:
    rates [0x7f]: 8000 11025 16000 22050 32000 44100 48000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Default Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
GPIO: io=0, o=1, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x30311: Stereo Digital
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="IEC958 Default PCM Playback Switch", index=0, device=0
  Device: name="AD198x Digital", type="SPDIF", device=1
  Converter: stream=8, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x60]: 44100 48000
    bits [0x2]: 16
    formats [0x5]: PCM AC3
  Delay: 3 samples
  Connection: 2
     0x01* 0x06
Node 0x03 [Audio Output] wcaps 0x44d: Stereo Amp-Out
  Control: name="PCM Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="PCM Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="AD198x Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x11 0x11]
  Converter: stream=5, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Processing caps: benign=1, ncoeff=70
Node 0x04 [Audio Output] wcaps 0x40d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Converter: stream=0, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
Node 0x05 [Audio Output] wcaps 0x40d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Converter: stream=0, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
Node 0x06 [Audio Input] wcaps 0x100511: Stereo
  Device: name="AD198x Analog", type="Audio", device=0
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x7f]: 8000 11025 16000 22050 32000 44100 48000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x12
Node 0x07 [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 8
     0x03 0x09 0x13 0x14 0x15 0x16 0x17 0x18
Node 0x08 [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x07
Node 0x09 [Audio Mixer] wcaps 0x20010e: Mono Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80] [0x80]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80]
  Connection: 2
     0x04 0x05
Node 0x0a [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x07* 0x04 0x05
Node 0x0b [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x07* 0x04
Node 0x0c [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x04* 0x07
Node 0x0d [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x05* 0x08
Node 0x0e [Audio Selector] wcaps 0x300100: Mono
  Connection: 2
     0x08* 0x11
Node 0x0f [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name="Mic Boost", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 8
     0x1f* 0x20 0x1d 0x1d 0x27 0x28 0x29 0x2a
Node 0x10 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x20* 0x1c 0x1f
Node 0x11 [Audio Selector] wcaps 0x300941: Stereo R/L
  Connection: 2
     0x0f* 0x2b
  Processing caps: benign=1, ncoeff=0
Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Capture Source", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 0
Node 0x13 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name="Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x11
Node 0x14 [Audio Selector] wcaps 0x30010c: Mono Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80]
  Connection: 1
     0x23
Node 0x15 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x22
Node 0x16 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x21
Node 0x17 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name="Internal Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Internal Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x10
Node 0x18 [Audio Selector] wcaps 0x30010c: Mono Amp-Out
  Control: name="Beep Playback Volume", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="Beep Playback Switch", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x83]
  Connection: 2
     0x19* 0x24
Node 0x19 [Beep Generator Widget] wcaps 0x700000: Mono
Node 0x1a [Pin Complex] wcaps 0x400185: Stereo Amp-Out
  Control: name="Master Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x19 0x19]
  Pincap 0x0000001f: OUT HP Detect Trigger ImpSense
  Pin Default 0x02214021: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x2, Sequence = 0x1
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=37, enabled=1
  Connection: 1
     0x0a
Node 0x1b [Pin Complex] wcaps 0x400185: Stereo Amp-Out
  Control: name="External Amplifier", index=0, device=0
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x99 0x99]
  Pincap 0x0001001f: OUT HP EAPD Detect Trigger ImpSense
  EAPD 0x0:
  Pin Default 0x81114011: [Fixed] Speaker at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x1
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0b
Node 0x1c [Pin Complex] wcaps 0x400185: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00000037: IN OUT Detect Trigger ImpSense
  Pin Default 0x41013012: [N/A] Line Out at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x1, Sequence = 0x2
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0c
Node 0x1d [Pin Complex] wcaps 0x400985: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x41019015: [N/A] Line Out at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x1, Sequence = 0x5
  Pin-ctls: 0x40: OUT VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0d
Node 0x1e [Pin Complex] wcaps 0x400104: Mono Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80]
  Pincap 0x00000010: OUT
  Pin Default 0x501700f0: [N/A] Speaker at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0e
Node 0x1f [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x00001727: IN Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0xc2a190f0: [Both] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
Node 0x20 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x00001727: IN Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x418130f0: [N/A] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=00, enabled=0
Node 0x21 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x00000027: IN Detect Trigger ImpSense
  Pin Default 0x509700f0: [N/A] Aux at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
Node 0x22 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x903300f0: [Fixed] CD at Int N/A
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x20: IN
Node 0x23 [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x90b70130: [Fixed] Telephony at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0x3, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x24 [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x90f701f0: [Fixed] Other at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x25 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x014511f0: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02
Node 0x26 [Power Widget] wcaps 0x500500: Mono
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 8
     0x07 0x08 0x13 0x14 0x15 0x16 0x17 0x18
Node 0x27 [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 2
     0x1f 0x1d
Node 0x28 [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 2
     0x1f 0x20
Node 0x29 [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 2
     0x1d 0x20
Node 0x2a [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 3
     0x1f 0x1d 0x20
Node 0x2b [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x0f
Codec: LSI ID 1040
Address: 1
MFG Function Id: 0x2 (unsol 1)
Vendor Id: 0x11c11040
Subsystem Id: 0x11c10001
Revision Id: 0x100200
Modem Function Group: 0x1
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root audio 116, 8 Oct 25 11:24 /dev/snd/controlC0
crw-rw---- 1 root audio 116, 7 Oct 25 11:24 /dev/snd/hwC0D0
crw-rw---- 1 root audio 116, 6 Oct 25 11:24 /dev/snd/hwC0D1
crw-rw---- 1 root audio 116, 5 Oct 25 11:24 /dev/snd/pcmC0D0c
crw-rw---- 1 root audio 116, 4 Oct 25 11:25 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116, 3 Oct 25 11:24 /dev/snd/pcmC0D1p
crw-rw---- 1 root audio 116, 9 Oct 25 11:22 /dev/snd/seq
crw-rw---- 1 root audio 116, 2 Oct 25 11:21 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Oct 25 11:24 .
drwxr-xr-x 3 root root 220 Oct 25 11:24 ..
lrwxrwxrwx 1 root root  12 Oct 25 11:24 pci-0000:00:1b.0 -> ../controlC0


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: AD198x Digital [AD198x Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0xd0340000 irq 40'
  Mixer name	: 'Analog Devices AD1986A'
  Components	: 'HDA:11d41986,17aa2066,00100500 HDA:11c11040,11c10001,00100200'
  Controls      : 20
  Simple ctrls  : 11
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 25 [81%] [-9.00dB] [on]
  Front Right: Playback 25 [81%] [-9.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 17 [55%] [-9.00dB] [on]
  Front Right: Playback 17 [55%] [-9.00dB] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch cswitch cswitch-joined cswitch-exclusive penum
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Mono
  Limits: Playback 0 - 31
  Mono: Capture [on]
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Mic Boost',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%]
  Front Right: 0 [0%]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Beep',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 15
  Mono: Playback 3 [20%] [-36.00dB] [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 0 [0%] [0.00dB] [off]
  Front Right: Capture 0 [0%] [0.00dB] [off]
Simple mixer control 'Mix',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive penum
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'External Amplifier',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Internal Mic',0
  Capabilities: pvolume pswitch cswitch cswitch-joined cswitch-exclusive penum
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Mono
  Limits: Playback 0 - 31
  Mono: Capture [off]
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]


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
		value.0 25
		value.1 25
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
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'PCM Playback Volume'
		value.0 17
		value.1 17
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'PCM Playback Switch'
		value.0 true
		value.1 true
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Mic Playback Volume'
		value.0 0
		value.1 0
	}
	control.6 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Mic Playback Switch'
		value.0 false
		value.1 false
	}
	control.7 {
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
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		comment.dbmin 0
		comment.dbmax 2250
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 false
		value.1 false
	}
	control.10 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Internal Mic'
		comment.item.2 Mix
		iface MIXER
		name 'Capture Source'
		value Mic
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'External Amplifier'
		value true
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Internal Mic Playback Volume'
		value.0 0
		value.1 0
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Internal Mic Playback Switch'
		value.0 false
		value.1 false
	}
	control.14 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.15 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.16 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value false
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 15'
		comment.dbmin -4500
		comment.dbmax 0
		iface MIXER
		name 'Beep Playback Volume'
		value 3
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Beep Playback Switch'
		value true
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
snd_hda_intel
snd_seq
snd_seq_device
sco
bnep
rfcomm
l2cap
snd_hda_codec_analog
iwl3945
snd_hda_codec
iwlcore
snd_hwdep
mac80211
snd_pcm
snd_timer
cfg80211
snd
yenta_socket
sdhci_pci
btusb
sdhci
mmc_core
bluetooth
rfkill
pcmcia_core
soundcore
processor
joydev
rng_core
i2c_i801
battery
8139too
ac
evdev
pcmcia_rsrc
thermal
led_class
snd_page_alloc
fuse
nfs
auth_rpcgss
lockd
sunrpc
jfs
reiserfs
ext3
jbd
scsi_wait_scan
ohci1394
ieee1394
usbhid
ohci_hcd
uhci_hcd
usb_storage
hid
ehci_hcd
usbcore
sr_mod
cdrom
sata_via


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x1a 0x02214021
0x1b 0x81114011
0x1c 0x41013012
0x1d 0x41019015
0x1e 0x501700f0
0x1f 0xc2a190f0
0x20 0x418130f0
0x21 0x509700f0
0x22 0x903300f0
0x23 0x90b70130
0x24 0x90f701f0
0x25 0x014511f0

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D1/init_pin_configs:

/sys/class/sound/hwC0D1/driver_pin_configs:

/sys/class/sound/hwC0D1/user_pin_configs:

/sys/class/sound/hwC0D1/init_verbs:


!!ALSA/HDA dmesg
!!------------------

[   12.496774] iwl3945 0000:03:00.0: setting latency timer to 64
[   12.501061] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[   12.501145] HDA Intel 0000:00:1b.0: irq 40 for MSI/MSI-X
[   12.501192] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   12.551508] iwl3945 0000:03:00.0: Tunable channels: 13 802.11bg, 23 802.11a channels
--
[   12.555453] phy0: Selected rate control algorithm 'iwl-3945-rs'
[   12.868183] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input6
[   14.247487] EXT4-fs (sda1): re-mounted. Opts: (null)
--
[   38.763783] cfg80211: Calling CRDA for country: CH
[   93.657925] hda_codec: invalid CONNECT_LIST verb 12[2]:2100
[  179.195571] HDA Intel 0000:00:1b.0: PCI INT A disabled
[  181.912615] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[  181.912717] HDA Intel 0000:00:1b.0: irq 40 for MSI/MSI-X
[  181.912755] HDA Intel 0000:00:1b.0: setting latency timer to 64
[  182.262888] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input7
[  207.582605] hda_codec: invalid CONNECT_LIST verb 12[2]:2100



--Boundary-00=_WDUxMUbtr62ELMI
Content-Type: text/plain;
  charset="UTF-8";
  name="alsa-info-working.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="alsa-info-working.txt"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.59
!!################################

!!Script ran on: Mon Oct 25 08:23:15 UTC 2010


!!Linux Distribution
!!------------------

Gentoo Base System release 2.0.1


!!DMI Information
!!---------------

Manufacturer:      LENOVO
Product Name:      0768B9G


!!Kernel Information
!!------------------

Kernel release:    2.6.36-gentoo-anarsoul
Operating System:  GNU/Linux
Architecture:      i686
Processor:         Intel(R) Core(TM)2 CPU T5500 @ 1.66GHz
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.23
Library version:    1.0.23
Utilities version:  1.0.23


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

No sound servers found.


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xd0340000 irq 40


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 02)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:27d8 (rev 02)
	Subsystem: 17aa:2066


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
	bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	position_fix : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Analog Devices AD1986A
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x11d41986
Subsystem Id: 0x17aa2066
Revision Id: 0x100500
No Modem Function Group found
Default PCM:
    rates [0x7f]: 8000 11025 16000 22050 32000 44100 48000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Default Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
GPIO: io=0, o=1, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x30311: Stereo Digital
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="IEC958 Default PCM Playback Switch", index=0, device=0
  Device: name="AD198x Digital", type="SPDIF", device=1
  Converter: stream=8, channel=0
  Digital: Enabled
  Digital category: 0x0
  PCM:
    rates [0x60]: 44100 48000
    bits [0x2]: 16
    formats [0x5]: PCM AC3
  Delay: 3 samples
  Connection: 2
     0x01* 0x06
Node 0x03 [Audio Output] wcaps 0x44d: Stereo Amp-Out
  Control: name="PCM Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="PCM Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="AD198x Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x11 0x11]
  Converter: stream=5, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Processing caps: benign=1, ncoeff=70
Node 0x04 [Audio Output] wcaps 0x40d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Converter: stream=0, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
Node 0x05 [Audio Output] wcaps 0x40d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Converter: stream=0, channel=0
  Power states:  D0 D3
  Power: setting=D0, actual=D0
Node 0x06 [Audio Input] wcaps 0x100511: Stereo
  Device: name="AD198x Analog", type="Audio", device=0
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x7f]: 8000 11025 16000 22050 32000 44100 48000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x12
Node 0x07 [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 8
     0x03 0x09 0x13 0x14 0x15 0x16 0x17 0x18
Node 0x08 [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x07
Node 0x09 [Audio Mixer] wcaps 0x20010e: Mono Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80] [0x80]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80]
  Connection: 2
     0x04 0x05
Node 0x0a [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x07* 0x04 0x05
Node 0x0b [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x07* 0x04
Node 0x0c [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x04* 0x07
Node 0x0d [Audio Selector] wcaps 0x300101: Stereo
  Connection: 2
     0x05* 0x08
Node 0x0e [Audio Selector] wcaps 0x300100: Mono
  Connection: 2
     0x08* 0x11
Node 0x0f [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name="Mic Boost", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-Out vals:  [0x00 0x00]
  Connection: 8
     0x1f* 0x20 0x1d 0x1d 0x27 0x28 0x29 0x2a
Node 0x10 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 3
     0x20* 0x1c 0x1f
Node 0x11 [Audio Selector] wcaps 0x300941: Stereo R/L
  Connection: 2
     0x0f* 0x2b
  Processing caps: benign=1, ncoeff=0
Node 0x12 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Capture Source", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 0
Node 0x13 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name="Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x11
Node 0x14 [Audio Selector] wcaps 0x30010c: Mono Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80]
  Connection: 1
     0x23
Node 0x15 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x22
Node 0x16 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x21
Node 0x17 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name="Internal Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Internal Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Connection: 1
     0x10
Node 0x18 [Audio Selector] wcaps 0x30010c: Mono Amp-Out
  Control: name="Beep Playback Volume", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="Beep Playback Switch", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x0f, nsteps=0x0f, stepsize=0x0b, mute=1
  Amp-Out vals:  [0x83]
  Connection: 2
     0x19* 0x24
Node 0x19 [Beep Generator Widget] wcaps 0x700000: Mono
Node 0x1a [Pin Complex] wcaps 0x400185: Stereo Amp-Out
  Control: name="Master Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1c 0x1c]
  Pincap 0x0000001f: OUT HP Detect Trigger ImpSense
  Pin Default 0x02214021: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x2, Sequence = 0x1
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=37, enabled=1
  Connection: 1
     0x0a
Node 0x1b [Pin Complex] wcaps 0x400185: Stereo Amp-Out
  Control: name="External Amplifier", index=0, device=0
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9c 0x9c]
  Pincap 0x0001001f: OUT HP EAPD Detect Trigger ImpSense
  EAPD 0x0:
  Pin Default 0x81114011: [Fixed] Speaker at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x1
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0b
Node 0x1c [Pin Complex] wcaps 0x400185: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00000037: IN OUT Detect Trigger ImpSense
  Pin Default 0x41013012: [N/A] Line Out at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x1, Sequence = 0x2
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0c
Node 0x1d [Pin Complex] wcaps 0x400985: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00001737: IN OUT Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x41019015: [N/A] Line Out at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x1, Sequence = 0x5
  Pin-ctls: 0x40: OUT VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x0d
Node 0x1e [Pin Complex] wcaps 0x400104: Mono Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80]
  Pincap 0x00000010: OUT
  Pin Default 0x501700f0: [N/A] Speaker at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0e
Node 0x1f [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x00001727: IN Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0xc2a190f0: [Both] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
Node 0x20 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x00001727: IN Detect Trigger ImpSense
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x418130f0: [N/A] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=00, enabled=0
Node 0x21 [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x00000027: IN Detect Trigger ImpSense
  Pin Default 0x509700f0: [N/A] Aux at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
Node 0x22 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x903300f0: [Fixed] CD at Int N/A
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x20: IN
Node 0x23 [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x90b70130: [Fixed] Telephony at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0x3, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x24 [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x90f701f0: [Fixed] Other at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
Node 0x25 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x014511f0: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02
Node 0x26 [Power Widget] wcaps 0x500500: Mono
  Power states:  D0 D3
  Power: setting=D0, actual=D0
  Connection: 8
     0x07 0x08 0x13 0x14 0x15 0x16 0x17 0x18
Node 0x27 [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 2
     0x1f 0x1d
Node 0x28 [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 2
     0x1f 0x20
Node 0x29 [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 2
     0x1d 0x20
Node 0x2a [Audio Mixer] wcaps 0x200101: Stereo
  Connection: 3
     0x1f 0x1d 0x20
Node 0x2b [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x0f
Codec: LSI ID 1040
Address: 1
MFG Function Id: 0x2 (unsol 1)
Vendor Id: 0x11c11040
Subsystem Id: 0x11c10001
Revision Id: 0x100200
Modem Function Group: 0x1
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root audio 116, 8 Oct 25 11:21 /dev/snd/controlC0
crw-rw---- 1 root audio 116, 7 Oct 25 11:21 /dev/snd/hwC0D0
crw-rw---- 1 root audio 116, 6 Oct 25 11:21 /dev/snd/hwC0D1
crw-rw---- 1 root audio 116, 5 Oct 25 11:21 /dev/snd/pcmC0D0c
crw-rw---- 1 root audio 116, 4 Oct 25 11:22 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116, 3 Oct 25 11:22 /dev/snd/pcmC0D1p
crw-rw---- 1 root audio 116, 9 Oct 25 11:22 /dev/snd/seq
crw-rw---- 1 root audio 116, 2 Oct 25 11:21 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Oct 25 11:21 .
drwxr-xr-x 3 root root 220 Oct 25 11:22 ..
lrwxrwxrwx 1 root root  12 Oct 25 11:21 pci-0000:00:1b.0 -> ../controlC0


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: AD198x Digital [AD198x Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0xd0340000 irq 40'
  Mixer name	: 'Analog Devices AD1986A'
  Components	: 'HDA:11d41986,17aa2066,00100500 HDA:11c11040,11c10001,00100200'
  Controls      : 20
  Simple ctrls  : 11
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 28 [90%] [-4.50dB] [on]
  Front Right: Playback 28 [90%] [-4.50dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 17 [55%] [-9.00dB] [on]
  Front Right: Playback 17 [55%] [-9.00dB] [on]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch cswitch cswitch-joined cswitch-exclusive penum
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Mono
  Limits: Playback 0 - 31
  Mono: Capture [on]
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Mic Boost',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%]
  Front Right: 0 [0%]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Beep',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 15
  Mono: Playback 3 [20%] [-36.00dB] [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 0 [0%] [0.00dB] [off]
  Front Right: Capture 0 [0%] [0.00dB] [off]
Simple mixer control 'Mix',0
  Capabilities: cswitch cswitch-joined cswitch-exclusive penum
  Capture exclusive group: 0
  Capture channels: Mono
  Mono: Capture [off]
Simple mixer control 'External Amplifier',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Internal Mic',0
  Capabilities: pvolume pswitch cswitch cswitch-joined cswitch-exclusive penum
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Mono
  Limits: Playback 0 - 31
  Mono: Capture [off]
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]


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
		value.0 28
		value.1 28
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
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'PCM Playback Volume'
		value.0 17
		value.1 17
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'PCM Playback Switch'
		value.0 true
		value.1 true
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Mic Playback Volume'
		value.0 0
		value.1 0
	}
	control.6 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Mic Playback Switch'
		value.0 false
		value.1 false
	}
	control.7 {
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
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		comment.dbmin 0
		comment.dbmax 2250
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 false
		value.1 false
	}
	control.10 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic
		comment.item.1 'Internal Mic'
		comment.item.2 Mix
		iface MIXER
		name 'Capture Source'
		value Mic
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'External Amplifier'
		value true
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Internal Mic Playback Volume'
		value.0 0
		value.1 0
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Internal Mic Playback Switch'
		value.0 false
		value.1 false
	}
	control.14 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.15 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.16 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value false
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 15'
		comment.dbmin -4500
		comment.dbmax 0
		iface MIXER
		name 'Beep Playback Volume'
		value 3
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Beep Playback Switch'
		value true
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
snd_seq
snd_seq_device
sco
bnep
rfcomm
l2cap
snd_hda_codec_analog
snd_hda_intel
iwl3945
snd_hda_codec
iwlcore
snd_hwdep
mac80211
snd_pcm
snd_timer
cfg80211
snd
yenta_socket
sdhci_pci
btusb
sdhci
mmc_core
bluetooth
rfkill
pcmcia_core
soundcore
processor
joydev
rng_core
i2c_i801
battery
8139too
ac
evdev
pcmcia_rsrc
thermal
led_class
snd_page_alloc
fuse
nfs
auth_rpcgss
lockd
sunrpc
jfs
reiserfs
ext3
jbd
scsi_wait_scan
ohci1394
ieee1394
usbhid
ohci_hcd
uhci_hcd
usb_storage
hid
ehci_hcd
usbcore
sr_mod
cdrom
sata_via


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x1a 0x02214021
0x1b 0x81114011
0x1c 0x41013012
0x1d 0x41019015
0x1e 0x501700f0
0x1f 0xc2a190f0
0x20 0x418130f0
0x21 0x509700f0
0x22 0x903300f0
0x23 0x90b70130
0x24 0x90f701f0
0x25 0x014511f0

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D1/init_pin_configs:

/sys/class/sound/hwC0D1/driver_pin_configs:

/sys/class/sound/hwC0D1/user_pin_configs:

/sys/class/sound/hwC0D1/init_verbs:


!!ALSA/HDA dmesg
!!------------------

[   12.496774] iwl3945 0000:03:00.0: setting latency timer to 64
[   12.501061] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[   12.501145] HDA Intel 0000:00:1b.0: irq 40 for MSI/MSI-X
[   12.501192] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   12.551508] iwl3945 0000:03:00.0: Tunable channels: 13 802.11bg, 23 802.11a channels
--
[   12.555453] phy0: Selected rate control algorithm 'iwl-3945-rs'
[   12.868183] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input6
[   14.247487] EXT4-fs (sda1): re-mounted. Opts: (null)
--
[   38.763783] cfg80211: Calling CRDA for country: CH
[   93.657925] hda_codec: invalid CONNECT_LIST verb 12[2]:2100



--Boundary-00=_WDUxMUbtr62ELMI
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_WDUxMUbtr62ELMI--
