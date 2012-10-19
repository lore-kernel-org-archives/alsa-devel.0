From: Didier 'Ptitjes' Villevalois <ptitjes@free.fr>
Subject: usb-audio: Reloop Play support (TI TUSB3200AC)
Date: Fri, 19 Oct 2012 15:09:26 +0200
Message-ID: <1350652166.5549.8.camel@didier-laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-OUJWJmgtzkZCopNTprUc"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by alsa0.perex.cz (Postfix) with ESMTP id DA584265338
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 15:09:30 +0200 (CEST)
Received: from [192.168.1.27] (unknown [82.238.146.64])
 by smtp1-g21.free.fr (Postfix) with ESMTP id 42F19940188
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 15:09:26 +0200 (CEST)
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


--=-OUJWJmgtzkZCopNTprUc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hello,

I've bought a Reloop Play usb soundcard and I'd like to make it work
with ALSA.

It is a 4-channels USB soundcard. It is currently correctly recognized
by ALSA as a 4-channels soundcard and I can correctly open the channels
and feed them with audio. However, no audio is output by the box.

It seems to contain a Texas Instrument TUSB3200AC chipset (same chipset
as the Maya44 USB and Hercules DJ console). I guess the problem is a
firmware problem but I don't know what to do about it.

I've got a MacOS X driver that works correctly, if that of any help. (I
suppose the Windows driver works too but I don't have any Windows at
hand.)

I'm willing to do whatever you need me to make it run with ALSA. Could
you help me ?

I attached my alsa-info.sh output.

Didier Villevalois.

--=-OUJWJmgtzkZCopNTprUc
Content-Disposition: attachment; filename="Alsa-info.txt"
Content-Type: text/plain; name="Alsa-info.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit


!!################################
!!ALSA Information Script v 0.4.61
!!################################

!!Script ran on: Tue Oct 16 08:45:03 UTC 2012


!!Linux Distribution
!!------------------

Ubuntu 12.10 \n \l DISTRIB_ID=Ubuntu DISTRIB_DESCRIPTION="Ubuntu 12.10" NAME="Ubuntu" ID=ubuntu ID_LIKE=debian PRETTY_NAME="Ubuntu quantal (12.10)"


!!DMI Information
!!---------------

Manufacturer:      Apple Inc.
Product Name:      MacBookPro8,3
Product Version:   1.0
Firmware Version:     MBP81.88Z.0047.B24.1110141131


!!Kernel Information
!!------------------

Kernel release:    3.5.4-mbp83 
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         x86_64
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.25
Library version:    1.0.25
Utilities version:  1.0.25


!!Loaded ALSA modules
!!-------------------

snd_hda_intel
snd_usb_audio


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - Yes


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xb0900000 irq 48
 1 [PLAY           ]: USB-Audio - RELOOP PLAY
                      RELOOP RELOOP PLAY at usb-0000:00:1d.7-1.2, full speed


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset Family High Definition Audio Controller (rev 05)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:1b.0 0403: 8086:1c20 (rev 05)
	Subsystem: 8086:7270


!!Modprobe options (Sound related)
!!--------------------------------

snd-atiixp-modem: index=-2
snd-intel8x0m: index=-2
snd-via82xx-modem: index=-2
snd-usb-audio: index=-2
snd-usb-caiaq: index=-2
snd-usb-ua101: index=-2
snd-usb-us122l: index=-2
snd-usb-usx2y: index=-2
snd-cmipci: mpu_port=0x330 fm_port=0x388
snd-pcsp: index=-2
snd-usb-audio: index=-2


!!Loaded sound module options
!!---------------------------

!!Module: snd_hda_intel
	align_buffer_size : -1
	bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : -1
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	position_fix : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	power_save : 0
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	single_cmd : N
	snoop : Y

!!Module: snd_usb_audio
	async_unlink : Y
	device_setup : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	ignore_ctl_error : N
	index : -2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	nrpacks : 8
	pid : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	vid : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Cirrus Logic CS4206
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10134206
Subsystem Id: 0x106b2700
Revision Id: 0x100302
No Modem Function Group found
Default PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=4, o=0, i=0, unsolicited=0, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=1, dir=1, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[3]: enable=1, dir=1, wake=0, sticky=0, data=1, unsol=0
Node 0x02 [Audio Output] wcaps 0xd041d: Stereo Amp-Out
  Control: name="Master Playback Switch", index=0, device=0
  Control: name="Master Playback Volume", index=0, device=0
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x73, nsteps=0x7f, stepsize=0x01, mute=1
  Amp-Out vals:  [0x4b 0x4b]
  Converter: stream=8, channel=0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x03 [Audio Output] wcaps 0xd041d: Stereo Amp-Out
  Control: name="Surround Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Surround Speaker Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x73, nsteps=0x7f, stepsize=0x01, mute=1
  Amp-Out vals:  [0x4b 0x4b]
  Converter: stream=8, channel=0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x04 [Audio Output] wcaps 0xd041d: Stereo Amp-Out
  Control: name="Front Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Front Speaker Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="Cirrus Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x73, nsteps=0x7f, stepsize=0x01, mute=1
  Amp-Out vals:  [0x4b 0x4b]
  Converter: stream=8, channel=0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x05 [Audio Input] wcaps 0x18051b: Stereo Amp-In
  Control: name="Capture Switch", index=0, device=0
  Control: name="Capture Volume", index=0, device=0
  Device: name="Cirrus Analog", type="Audio", device=0
  Amp-In caps: ofs=0x33, nsteps=0x3f, stepsize=0x03, mute=1
  Amp-In vals:  [0x01 0x01] [0x01 0x01]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x1f5]: 8000 16000 32000 44100 48000 88200 96000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 8 samples
  Connection: 2
     0x0c* 0x12
Node 0x06 [Audio Input] wcaps 0x18051b: Stereo Amp-In
  Control: name="Capture Switch", index=0, device=0
  Control: name="Capture Volume", index=0, device=0
  Amp-In caps: ofs=0x33, nsteps=0x3f, stepsize=0x03, mute=1
  Amp-In vals:  [0x01 0x01] [0x01 0x01]
  Converter: stream=4, channel=0
  SDI-Select: 0
  PCM:
    rates [0x1f5]: 8000 16000 32000 44100 48000 88200 96000
    bits [0x1e]: 16 20 24 32
    formats [0x3]: PCM FLOAT
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 8 samples
  Connection: 2
     0x0d* 0x0e
Node 0x07 [Audio Input] wcaps 0x180791: Stereo Digital
  Control: name="IEC958 Capture Switch", index=0, device=0
  Control: name="IEC958 Capture Default", index=0, device=0
  Device: name="Cirrus Digital", type="SPDIF", device=1
  Converter: stream=0, channel=0
  SDI-Select: 0
  Digital: Preemphasis Non-Copyright
  Digital category: 0x0
  PCM:
    rates [0x570]: 32000 44100 48000 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x7]: PCM FLOAT AC3
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 8 samples
  Connection: 1
     0x0f
Node 0x08 [Audio Output] wcaps 0x40611: Stereo Digital
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="IEC958 Default PCM Playback Switch", index=0, device=0
  Device: name="Cirrus Digital", type="SPDIF", device=1
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x7]: PCM FLOAT AC3
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 4 samples
Node 0x09 [Pin Complex] wcaps 0x410581: Stereo
  Control: name="Headphone Jack", index=0, device=0
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0x002b4050: [Jack] HP Out at Ext N/A
    Conn = Comb, Color = Green
    DefAssociation = 0x5, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=01, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 1 samples
  Connection: 1
     0x02
Node 0x0a [Pin Complex] wcaps 0x410581: Stereo
  Pincap 0x00000054: OUT Detect Balanced
  Pin Default 0x90100141: [Fixed] Speaker at Int N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0x4, Sequence = 0x1
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 1 samples
  Connection: 1
     0x03
Node 0x0b [Pin Complex] wcaps 0x410101: Stereo
  Pincap 0x00000050: OUT Balanced
  Pin Default 0x90100140: [Fixed] Speaker at Int N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0x4, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Delay: 1 samples
  Connection: 1
     0x04
Node 0x0c [Pin Complex] wcaps 0x41048b: Stereo Amp-In
  Control: name="Line Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Line Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000024: IN Detect
  Pin Default 0x008b3020: [Jack] Line In at Ext N/A
    Conn = Comb, Color = Blue
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x20: IN
  Unsolicited: tag=03, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 1 samples
Node 0x0d [Pin Complex] wcaps 0x41048b: Stereo Amp-In
  Control: name="Mic Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Mic Phantom Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00001764: IN Detect Balanced
    Vref caps: HIZ 50 GRD 80
  Pin Default 0x90a00110: [Fixed] Mic at Int N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 1 samples
Node 0x0e [Pin Complex] wcaps 0x41000b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x02, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Delay: 1 samples
Node 0x0f [Pin Complex] wcaps 0x410681: Stereo Digital
  Control: name="SPDIF In Jack", index=0, device=0
  Pincap 0x00000024: IN Detect
  Pin Default 0x00cbe030: [Jack] SPDIF In at Ext N/A
    Conn = Comb, Color = White
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=05, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 1 samples
Node 0x10 [Pin Complex] wcaps 0x410301: Stereo Digital
  Control: name="SPDIF Phantom Jack", index=0, device=0
  Pincap 0x00000010: OUT
  Pin Default 0x004be060: [Jack] SPDIF Out at Ext N/A
    Conn = Comb, Color = White
    DefAssociation = 0x6, Sequence = 0x0
  Pin-ctls: 0x00:
  Delay: 1 samples
  Connection: 1
     0x08
Node 0x11 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=0, ncoeff=22
Node 0x12 [Pin Complex] wcaps 0x41000b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x02, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000020: IN
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Delay: 1 samples
Node 0x13 [Beep Generator Widget] wcaps 0x700000: Mono
Node 0x14 [Audio Output] wcaps 0x40611: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x7]: PCM FLOAT AC3
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Delay: 4 samples
Node 0x15 [Pin Complex] wcaps 0x410301: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Delay: 1 samples
  Connection: 1
     0x14
--endcollapse--


!!USB Mixer information
!!---------------------
--startcollapse--

USB Mixer: usb_id=0x200c100b, ctrlif=0, ctlerr=0
Card: RELOOP RELOOP PLAY at usb-0000:00:1d.7-1.2, full speed
  Unit: 7
    Control: name="Tone Control - Treble", index=0
    Info: id=7, control=5, cmask=0x0, channels=1, type="S8"
    Volume: min=0, max=96, dBmin=0, dBmax=37
  Unit: 7
    Control: name="Tone Control - Bass", index=0
    Info: id=7, control=3, cmask=0x0, channels=1, type="S8"
    Volume: min=0, max=96, dBmin=0, dBmax=37
  Unit: 7
    Control: name="Speaker Playback Volume", index=0
    Info: id=7, control=2, cmask=0x3, channels=2, type="S16"
    Volume: min=0, max=7936, dBmin=0, dBmax=3100
  Unit: 7
    Control: name="Speaker Playback Switch", index=0
    Info: id=7, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---T  1 root audio 116,  7 Oct 16 08:56 /dev/snd/controlC0
crw-rw---T  1 root audio 116,  9 Oct 16 10:40 /dev/snd/controlC1
crw-rw---T  1 root audio 116,  6 Oct 16 08:56 /dev/snd/hwC0D0
crw-rw---T  1 root audio 116,  5 Oct 16 08:57 /dev/snd/pcmC0D0c
crw-rw---T  1 root audio 116,  4 Oct 16 10:44 /dev/snd/pcmC0D0p
crw-rw---T  1 root audio 116,  3 Oct 16 08:57 /dev/snd/pcmC0D1c
crw-rw---T  1 root audio 116,  2 Oct 16 08:57 /dev/snd/pcmC0D1p
crw-rw---T  1 root audio 116,  8 Oct 16 10:40 /dev/snd/pcmC1D0p
crw-rw---T  1 root audio 116,  1 Oct 16 08:56 /dev/snd/seq
crw-rw---T  1 root audio 116, 33 Oct 16 08:56 /dev/snd/timer

/dev/snd/by-id:
total 0
drwxr-xr-x 2 root root  60 Oct 16 10:40 .
drwxr-xr-x 4 root root 280 Oct 16 10:40 ..
lrwxrwxrwx 1 root root  12 Oct 16 10:40 usb-RELOOP_RELOOP_PLAY_Thames_YU-00 -> ../controlC1

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  80 Oct 16 10:40 .
drwxr-xr-x 4 root root 280 Oct 16 10:40 ..
lrwxrwxrwx 1 root root  12 Oct 16 08:56 pci-0000:00:1b.0 -> ../controlC0
lrwxrwxrwx 1 root root  12 Oct 16 10:40 pci-0000:00:1d.7-usb-0:1.2:1.0 -> ../controlC1


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: Cirrus Analog [Cirrus Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 1: Cirrus Digital [Cirrus Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: PLAY [RELOOP PLAY], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: Cirrus Analog [Cirrus Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 1: Cirrus Digital [Cirrus Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [PCH]

Card hw:0 'PCH'/'HDA Intel PCH at 0xb0900000 irq 48'
  Mixer name	: 'Cirrus Logic CS4206'
  Components	: 'HDA:10134206,106b2700,00100302'
  Controls      : 27
  Simple ctrls  : 11
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 115
  Mono: Playback 75 [65%] [-20.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 115
  Mono:
  Front Left: Playback 115 [100%] [0.00dB] [on]
  Front Right: Playback 115 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 254 [100%] [0.20dB]
  Front Right: Playback 254 [100%] [0.20dB]
Simple mixer control 'Front Speaker',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 115
  Mono:
  Front Left: Playback 115 [100%] [0.00dB] [on]
  Front Right: Playback 115 [100%] [0.00dB] [on]
Simple mixer control 'Surround Speaker',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 115
  Mono:
  Front Left: Playback 115 [100%] [0.00dB] [on]
  Front Right: Playback 115 [100%] [0.00dB] [on]
Simple mixer control 'Line',0
  Capabilities: cvolume cswitch cswitch-joined cswitch-exclusive penum
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 3
  Front Left: Capture 0 [0%] [0.00dB] [off]
  Front Right: Capture 0 [0%] [0.00dB] [off]
Simple mixer control 'Mic',0
  Capabilities: cvolume cswitch cswitch-joined cswitch-exclusive penum
  Capture exclusive group: 0
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 3
  Front Left: Capture 0 [0%] [0.00dB] [on]
  Front Right: Capture 0 [0%] [0.00dB] [on]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined cswitch cswitch-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Mono: Playback [off] Capture [off]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 63
  Front Left: Capture 1 [2%] [-50.00dB] [on]
  Front Right: Capture 1 [2%] [-50.00dB] [on]
Simple mixer control 'Digital',0
  Capabilities: cvolume penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 60 [50%] [0.00dB]
  Front Right: Capture 60 [50%] [0.00dB]

!!-------Mixer controls for card 1 [PLAY]

Card hw:1 'PLAY'/'RELOOP RELOOP PLAY at usb-0000:00:1d.7-1.2, full speed'
  Mixer name	: 'USB Mixer'
  Components	: 'USB200c:100b'
  Controls      : 4
  Simple ctrls  : 3
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch pswitch-joined penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [0.00dB] [on]
  Front Right: Playback 0 [0%] [0.00dB] [on]
Simple mixer control 'Bass',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 96
  Mono: 48 [50%]
Simple mixer control 'Treble',0
  Capabilities: volume volume-joined penum
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 96
  Mono: 48 [50%]


!!Alsactl output
!!--------------

--startcollapse--
state.PCH {
	control.1 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.2 {
		iface MIXER
		name 'Master Playback Volume'
		value 75
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 115'
			dbmin -5750
			dbmax 0
			dbvalue.0 -2000
		}
	}
	control.3 {
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.4 {
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 115
		value.1 115
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 115'
			dbmin -5750
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.5 {
		iface MIXER
		name 'Front Speaker Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.6 {
		iface MIXER
		name 'Front Speaker Playback Volume'
		value.0 115
		value.1 115
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 115'
			dbmin -5750
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.7 {
		iface MIXER
		name 'Surround Speaker Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.8 {
		iface MIXER
		name 'Surround Speaker Playback Volume'
		value.0 115
		value.1 115
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 115'
			dbmin -5750
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.9 {
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.10 {
		iface MIXER
		name 'Capture Volume'
		value.0 1
		value.1 1
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 63'
			dbmin -5100
			dbmax 1200
			dbvalue.0 -5000
			dbvalue.1 -5000
		}
	}
	control.11 {
		iface MIXER
		name 'Capture Source'
		value Mic
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 Mic
			item.1 Line
		}
	}
	control.12 {
		iface MIXER
		name 'Mic Capture Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3000
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.13 {
		iface MIXER
		name 'Line Capture Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3000
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.14 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.15 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.16 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.17 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.18 {
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.19 {
		iface MIXER
		name 'IEC958 Capture Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.20 {
		iface MIXER
		name 'IEC958 Capture Default'
		value '0800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.21 {
		iface CARD
		name 'Headphone Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.22 {
		iface CARD
		name 'Mic Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.23 {
		iface CARD
		name 'Line Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.24 {
		iface CARD
		name 'SPDIF Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.25 {
		iface CARD
		name 'SPDIF In Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.26 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 254
		value.1 254
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 255'
			tlv '0000000100000008ffffec1400000014'
			dbmin -5100
			dbmax 0
			dbvalue.0 -20
			dbvalue.1 -20
		}
	}
	control.27 {
		iface MIXER
		name 'Digital Capture Volume'
		value.0 60
		value.1 60
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 120'
			tlv '0000000100000008fffff44800000032'
			dbmin -3000
			dbmax 3000
			dbvalue.0 0
			dbvalue.1 0
		}
	}
}
state.PLAY {
	control.1 {
		iface MIXER
		name 'Speaker Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.2 {
		iface MIXER
		name 'Speaker Playback Volume'
		value.0 0
		value.1 0
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin 0
			dbmax 3100
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.3 {
		iface MIXER
		name 'Tone Control - Bass'
		value 48
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 96'
		}
	}
	control.4 {
		iface MIXER
		name 'Tone Control - Treble'
		value 48
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 96'
		}
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
hfsplus
ip6table_filter
ip6_tables
ipt_MASQUERADE
iptable_nat
nf_nat
nf_conntrack_ipv4
nf_defrag_ipv4
xt_state
nf_conntrack
ipt_REJECT
iptable_mangle
xt_tcpudp
iptable_filter
ip_tables
x_tables
bridge
stp
llc
bnep
rfcomm
ipv6
btusb
bluetooth
snd_usb_audio
snd_usbmidi_lib
snd_hda_codec_cirrus
b43
snd_hda_intel
snd_hda_codec
snd_hwdep
snd_pcm_oss
snd_mixer_oss
snd_pcm
snd_seq_oss
snd_seq_midi
applesmc
led_class
snd_rawmidi
input_polldev
snd_seq_midi_event
coretemp
snd_seq
snd_timer
snd_seq_device
firewire_ohci
joydev
firewire_core
bcma
snd
snd_page_alloc
nls_iso8859_1
nls_cp437
vfat
fat


!!ALSA/HDA dmesg
!!--------------

bcma: Core 2 found: PCIe (manuf 0x4BF, id 0x820, rev 0x13, class 0x0)
snd_hda_intel 0000:00:1b.0: enabling device (0000 -> 0002)
snd_hda_intel 0000:00:1b.0: irq 48 for MSI/MSI-X
usb 2-1.2: new full-speed USB device number 4 using ehci_hcd
--
Registered led device: b43-phy0::radio
input: HDA Intel PCH SPDIF In as /devices/pci0000:00/0000:00:1b.0/sound/card0/input7
input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input8
input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input9
applesmc: key=434 fan=2 temp=30 acc=1 lux=2 kbd=1



--=-OUJWJmgtzkZCopNTprUc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-OUJWJmgtzkZCopNTprUc--
