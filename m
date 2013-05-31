From: Halim Sahin <halim.sahin@freenet.de>
Subject: No headphone control for ALC892 on Zotac Motherboard
	D2550ITXS-B-E
Date: Fri, 31 May 2013 13:47:10 +0200
Message-ID: <20130531114710.GA5636@gentoo.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 4EA752619E3
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 13:47:06 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1UiNnT-0004R2-52
 for alsa-devel@alsa-project.org; Fri, 31 May 2013 13:47:03 +0200
Received: from p5b220b54.dip0.t-ipconnect.de ([91.34.11.84])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 13:47:03 +0200
Received: from halim.sahin by p5b220b54.dip0.t-ipconnect.de with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 13:47:03 +0200
Content-Disposition: inline
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


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
Attached is output of alsa-info.
Updated to Alsa-driver 1.0.25 running with 2.6.34 kernel.
Frontpanel of my case has mic and headphone output connectors.
front mic works but no headphones.
Card works except headphones
Can you please help?

-- 
Halim Sahin
E-Mail:				
halim.sahin (at) t-online.de

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="alsa-info.txt"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.62
!!################################

!!Script ran on: Fri May 31 11:10:27 UTC 2013


!!Linux Distribution
!!------------------

openSUSE 11.2 (i586)


!!DMI Information
!!---------------

Manufacturer:      Motherboard by ZOTAC
Product Name:      Motherboard D2550ITXS-B-E
Product Version:   Motherboard XX
Firmware Version:  A212P010


!!Kernel Information
!!------------------

Kernel release:    2.6.34-12-default
Operating System:  GNU/Linux
Architecture:      i686
Processor:         i686
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.25
Library version:    
Utilities version:  1.0.21


!!Loaded ALSA modules
!!-------------------

snd_hda_intel
snd_hda_intel


!!Sound Servers on this system
!!----------------------------

ESound Daemon:
      Installed - Yes (/usr/bin/esd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xdb500000 irq 29
 1 [NVidia         ]: HDA-Intel - HDA NVidia
                      HDA NVidia at 0xdb080000 irq 18


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 02)
02:09.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
03:00.1 Audio device: nVidia Corporation Device 0e08 (rev a1)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:1b.0 0403: 8086:27d8 (rev 02)
	Subsystem: 19da:a130
--
03:00.1 0403: 10de:0e08 (rev a1)
	Subsystem: 19da:2120


!!Loaded sound module options
!!---------------------------

!!Module: snd_hda_intel
	align_buffer_size : N
	bdl_pos_adj : 1,32,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : Y
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	model : auto,(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	position_fix : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	power_save : 0
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	single_cmd : N
	snoop : Y

!!Module: snd_hda_intel
	align_buffer_size : N
	bdl_pos_adj : 1,32,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : Y
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	model : auto,(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	position_fix : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	power_save : 0
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	single_cmd : N
	snoop : Y


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ALC892
Address: 2
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0892
Subsystem Id: 0x19daa130
Revision Id: 0x100302
No Modem Function Group found
Default PCM:
    rates [0x5f0]: 32000 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=2, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Front Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="ALC892 Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x40 0x40]
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x03 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Surround Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x40 0x40]
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x04 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Center Playback Volume", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="LFE Playback Volume", index=0, device=0
    ControlAmp: chs=2, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x40 0x40]
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x05 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x40 0x40]
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x06 [Audio Output] wcaps 0x611: Stereo Digital
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="IEC958 Default PCM Playback Switch", index=0, device=0
  Device: name="ALC892 Digital", type="SPDIF", device=1
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  PCM:
    rates [0x5f0]: 32000 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Control: name="Capture Switch", index=0, device=0
  Control: name="Capture Volume", index=0, device=0
  Device: name="ALC892 Analog", type="Audio", device=0
  Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
  Amp-In vals:  [0x1c 0x1c]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x23
Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Control: name="Capture Switch", index=1, device=0
  Control: name="Capture Volume", index=1, device=0
  Device: name="ALC892 Analog", type="Audio", device=2
  Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
  Amp-In vals:  [0x90 0x90]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x22
Node 0x0a [Audio Input] wcaps 0x100711: Stereo Digital
  Converter: stream=0, channel=0
  SDI-Select: 0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Rear Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Rear Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Front Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Front Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Line Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="Line Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 10
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
Node 0x0c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x05 0x0b
Node 0x10 [Audio Output] wcaps 0x611: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5f0]: 32000 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x11 [Pin Complex] wcaps 0x400781: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x411110f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x10
Node 0x12 [Pin Complex] wcaps 0x400401: Stereo
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Front Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line-Out Front Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001003e: IN OUT HP EAPD Detect Trigger
  EAPD 0x2: EAPD
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=01, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x0c
Node 0x15 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Surround Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line-Out Surround Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00000036: IN OUT Detect Trigger
  Pin Default 0x01016012: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Orange
    DefAssociation = 0x1, Sequence = 0x2
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=02, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x0d
Node 0x16 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Center Playback Switch", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="LFE Playback Switch", index=0, device=0
    ControlAmp: chs=2, dir=Out, idx=0, ofs=0
  Control: name="Line-Out CLFE Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00000036: IN OUT Detect Trigger
  Pin Default 0x01011011: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0x1
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=03, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x0e
Node 0x17 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00000036: IN OUT Detect Trigger
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x0f
Node 0x18 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="Rear Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Rear Mic Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003736: IN OUT Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x01a19840: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x4, Sequence = 0x0
  Pin-ctls: 0x21: IN VREF_50
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x19 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="Front Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Front Mic Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373e: IN OUT HP Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x02a19c50: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0x5, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=05, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1a [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="Line Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x00003736: IN OUT Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x0181304f: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x4, Sequence = 0xf
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=06, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0001373e: IN OUT HP EAPD Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  EAPD 0x2: EAPD
  Pin Default 0x02014c20: [Jack] Line Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1c [Pin Complex] wcaps 0x400481: Stereo
  Pincap 0x00000024: IN Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x1d [Pin Complex] wcaps 0x400400: Mono
  Pincap 0x00000020: IN
  Pin Default 0x4005e601: [N/A] Line Out at Ext N/A
    Conn = Optical, Color = White
    DefAssociation = 0x0, Sequence = 0x1
  Pin-ctls: 0x20: IN
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x1e [Pin Complex] wcaps 0x400781: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x01441130: [Jack] SPDIF Out at Ext Rear
    Conn = RCA, Color = Black
    DefAssociation = 0x3, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x06
Node 0x1f [Pin Complex] wcaps 0x400681: Stereo Digital
  Pincap 0x00000020: IN
  Pin Default 0x411411f0: [N/A] Speaker at Ext Rear
    Conn = RCA, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=0, ncoeff=24
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Input Source", index=1, device=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 12
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b 0x12
Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Input Source", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x25 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x40 0x40]
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x26 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x25 0x0b
Codec: Nvidia GPU 1c HDMI/DP
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10de001c
Subsystem Id: 0x19da2120
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x04 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
  Control: name="HDMI/DP,pcm=3 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="ELD", index=0, device=3
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x185600f0: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=01, enabled=1
  Connection: 2
     0x08* 0x09
Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
  Control: name="HDMI/DP,pcm=7 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=1, device=0
  Control: name="IEC958 Playback Pro Mask", index=1, device=0
  Control: name="IEC958 Playback Default", index=1, device=0
  Control: name="IEC958 Playback Switch", index=1, device=0
  Control: name="ELD", index=0, device=7
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x185600f0: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=02, enabled=1
  Connection: 2
     0x08* 0x09
Node 0x06 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
  Control: name="HDMI/DP,pcm=8 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=2, device=0
  Control: name="IEC958 Playback Pro Mask", index=2, device=0
  Control: name="IEC958 Playback Default", index=2, device=0
  Control: name="IEC958 Playback Switch", index=2, device=0
  Control: name="ELD", index=0, device=8
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x185600f0: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=03, enabled=1
  Connection: 2
     0x08* 0x09
Node 0x07 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x585600f0: [N/A] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Connection: 2
     0x08* 0x09
Node 0x08 [Audio Output] wcaps 0x62b1: 8-Channels Digital Stripe
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Unsolicited: tag=00, enabled=0
Node 0x09 [Audio Output] wcaps 0x62b1: 8-Channels Digital Stripe
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Unsolicited: tag=00, enabled=0
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root audio 116,  7 May 31 13:01 /dev/snd/controlC0
crw-rw---- 1 root audio 116, 12 May 31 13:01 /dev/snd/controlC1
crw-rw---- 1 root audio 116,  6 May 31 13:01 /dev/snd/hwC0D2
crw-rw---- 1 root audio 116, 11 May 31 13:01 /dev/snd/hwC1D0
crw-rw---- 1 root audio 116,  5 May 31 13:01 /dev/snd/pcmC0D0c
crw-rw---- 1 root audio 116,  4 May 31 13:01 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116,  3 May 31 13:01 /dev/snd/pcmC0D1p
crw-rw---- 1 root audio 116,  2 May 31 13:01 /dev/snd/pcmC0D2c
crw-rw---- 1 root audio 116, 10 May 31 13:01 /dev/snd/pcmC1D3p
crw-rw---- 1 root audio 116,  9 May 31 13:01 /dev/snd/pcmC1D7p
crw-rw---- 1 root audio 116,  8 May 31 13:01 /dev/snd/pcmC1D8p
crw-rw---- 1 root audio 116,  1 Jan  9  2012 /dev/snd/seq
crw-rw---- 1 root audio 116, 33 Jan  9  2012 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  80 May 31 13:01 .
drwxr-xr-x 3 root root 320 May 31 13:01 ..
lrwxrwxrwx 1 root root  12 May 31 13:01 pci-0000:00:1b.0 -> ../controlC0
lrwxrwxrwx 1 root root  12 May 31 13:01 pci-0000:03:00.1 -> ../controlC1


!!ALSA configuration files
!!------------------------

!!System wide config file (/etc/asound.conf)

#defaults.pcm.card 1
#defaults.pcm.device 7


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC892 Analog [ALC892 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: ALC892 Digital [ALC892 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 7: HDMI 1 [HDMI 1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: NVidia [HDA NVidia], device 8: HDMI 2 [HDMI 2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC892 Analog [ALC892 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 2: ALC892 Analog [ALC892 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0xdb500000 irq 29'
  Mixer name	: 'Realtek ALC892'
  Components	: 'HDA:10ec0892,19daa130,00100302'
  Controls      : 36
  Simple ctrls  : 17
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 64 [100%] [0.00dB] [on]
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
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Front Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Front Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [off]
  Front Right: Playback 64 [100%] [0.00dB] [off]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 64 [100%] [0.00dB] [off]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 64 [100%] [0.00dB] [off]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 46
  Front Left: Capture 28 [61%] [12.00dB] [on]
  Front Right: Capture 28 [61%] [12.00dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 46
  Front Left: Capture 16 [35%] [0.00dB] [off]
  Front Right: Capture 16 [35%] [0.00dB] [off]
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Rear Mic' 'Front Mic' 'Line'
  Item0: 'Rear Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Rear Mic' 'Front Mic' 'Line'
  Item0: 'Rear Mic'
Simple mixer control 'Rear Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Rear Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]

!!-------Mixer controls for card 1 [NVidia]

Card hw:1 'NVidia'/'HDA NVidia at 0xdb080000 irq 18'
  Mixer name	: 'Nvidia GPU 1c HDMI/DP'
  Components	: 'HDA:10de001c,19da2120,00100100'
  Controls      : 19
  Simple ctrls  : 4
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 255 [100%] [0.00dB]
  Front Right: Playback 255 [100%] [0.00dB]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',2
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]


!!Alsactl output
!!--------------

--startcollapse--
state.Intel {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'Front Playback Volume'
		value.0 64
		value.1 64
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Front Playback Switch'
		value.0 true
		value.1 true
	}
	control.3 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'Surround Playback Volume'
		value.0 64
		value.1 64
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Surround Playback Switch'
		value.0 false
		value.1 false
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 64'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'Center Playback Volume'
		value 64
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 64'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'LFE Playback Volume'
		value 64
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Center Playback Switch'
		value false
	}
	control.8 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'LFE Playback Switch'
		value false
	}
	control.9 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Rear Mic Playback Volume'
		value.0 0
		value.1 0
	}
	control.10 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Rear Mic Playback Switch'
		value.0 false
		value.1 false
	}
	control.11 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Front Mic Playback Volume'
		value.0 0
		value.1 0
	}
	control.12 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Front Mic Playback Switch'
		value.0 false
		value.1 false
	}
	control.13 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		comment.dbmin -3450
		comment.dbmax 1200
		iface MIXER
		name 'Line Playback Volume'
		value.0 0
		value.1 0
	}
	control.14 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Line Playback Switch'
		value.0 false
		value.1 false
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3000
		iface MIXER
		name 'Rear Mic Boost Volume'
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
		name 'Front Mic Boost Volume'
		value.0 0
		value.1 0
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		index 1
		value.0 false
		value.1 false
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 46'
		comment.dbmin -1600
		comment.dbmax 3000
		iface MIXER
		name 'Capture Volume'
		value.0 28
		value.1 28
	}
	control.20 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 46'
		comment.dbmin -1600
		comment.dbmax 3000
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 16
		value.1 16
	}
	control.21 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Rear Mic'
		comment.item.1 'Front Mic'
		comment.item.2 Line
		iface MIXER
		name 'Input Source'
		value 'Rear Mic'
	}
	control.22 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Rear Mic'
		comment.item.1 'Front Mic'
		comment.item.2 Line
		iface MIXER
		name 'Input Source'
		index 1
		value 'Rear Mic'
	}
	control.23 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.24 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.25 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.26 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
	}
	control.27 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value true
	}
	control.28 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 64'
		comment.dbmin -6400
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value 64
	}
	control.29 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.30 {
		comment.access read
		comment.type BOOLEAN
		comment.count 1
		iface CARD
		name 'Line-Out Front Jack'
		value false
	}
	control.31 {
		comment.access read
		comment.type BOOLEAN
		comment.count 1
		iface CARD
		name 'Line-Out Surround Jack'
		value false
	}
	control.32 {
		comment.access read
		comment.type BOOLEAN
		comment.count 1
		iface CARD
		name 'Line-Out CLFE Jack'
		value false
	}
	control.33 {
		comment.access read
		comment.type BOOLEAN
		comment.count 1
		iface CARD
		name 'Rear Mic Jack'
		value false
	}
	control.34 {
		comment.access read
		comment.type BOOLEAN
		comment.count 1
		iface CARD
		name 'Front Mic Jack'
		value true
	}
	control.35 {
		comment.access read
		comment.type BOOLEAN
		comment.count 1
		iface CARD
		name 'Line Jack'
		value false
	}
	control.36 {
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
state.NVidia {
	control.1 {
		comment.access read
		comment.type BOOLEAN
		comment.count 1
		iface CARD
		name 'HDMI/DP,pcm=3 Jack'
		value false
	}
	control.2 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.3 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.4 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
	}
	control.6 {
		comment.access read
		comment.type BYTES
		comment.count 0
		iface PCM
		device 3
		name ELD
		value ''
	}
	control.7 {
		comment.access read
		comment.type BOOLEAN
		comment.count 1
		iface CARD
		name 'HDMI/DP,pcm=7 Jack'
		value false
	}
	control.8 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		index 1
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.9 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		index 1
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.10 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		index 1
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		index 1
		value true
	}
	control.12 {
		comment.access read
		comment.type BYTES
		comment.count 0
		iface PCM
		device 7
		name ELD
		value ''
	}
	control.13 {
		comment.access read
		comment.type BOOLEAN
		comment.count 1
		iface CARD
		name 'HDMI/DP,pcm=8 Jack'
		value false
	}
	control.14 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		index 2
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.15 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		index 2
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.16 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		index 2
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		index 2
		value false
	}
	control.18 {
		comment.access read
		comment.type BYTES
		comment.count 0
		iface PCM
		device 8
		name ELD
		value ''
	}
	control.19 {
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
snd_hda_intel
af_packet
rfcomm
bridge
stp
llc
bnep
snd_seq
autofs4
snd_seq_device
lnbp21
lnbp22
tda826x
tda10086
tda8261
tda827x
stb6100
stb0899
dvb_usb_vp7045
dvb_usb_ttusb2
dvb_usb_pctv452e
dvb_usb_dib0700
dib7000p
dib0090
dib7000m
dib0070
dvb_usb
dib8000
dib9000
dib3000mc
dibx000_common
budget_ci
rc_core
lirc_serial
lirc_dev
ext4
jbd2
loop
tda10023
snd_hda_codec_hdmi
budget_av
saa7146_vv
videodev
arc4
media
iwldvm
sg
sr_mod
videobuf_dma_sg
mac80211
snd_hda_codec_realtek
videobuf_core
iwlwifi
cdrom
sd_mod
budget_core
dvb_core
snd_hda_codec
btusb
bluetooth
crc16
snd_hwdep
saa7146
cfg80211
snd_pcm
ahci
ttpci_eeprom
snd_timer
libata
rfkill
xhci_hcd
uhci_hcd
compat
r8169
pcspkr
nvidia
ehci_hcd
i2c_core
thermal
shpchp
snd
pci_hotplug
serio_raw
processor
scsi_mod
soundcore
button
usbcore
snd_page_alloc
thermal_sys
hwmon
rtc_cmos
rtc_core
rtc_lib


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D2/init_pin_configs:
0x11 0x411110f0
0x12 0x411111f0
0x14 0x01014010
0x15 0x01016012
0x16 0x01011011
0x17 0x411111f0
0x18 0x01a19840
0x19 0x02a19c50
0x1a 0x0181304f
0x1b 0x02014c20
0x1c 0x411111f0
0x1d 0x4005e601
0x1e 0x01441130
0x1f 0x411411f0

/sys/class/sound/hwC0D2/driver_pin_configs:

/sys/class/sound/hwC0D2/user_pin_configs:

/sys/class/sound/hwC0D2/init_verbs:

/sys/class/sound/hwC0D2/hints:

/sys/class/sound/hwC1D0/init_pin_configs:
0x04 0x185600f0
0x05 0x185600f0
0x06 0x185600f0
0x07 0x585600f0

/sys/class/sound/hwC1D0/driver_pin_configs:

/sys/class/sound/hwC1D0/user_pin_configs:

/sys/class/sound/hwC1D0/init_verbs:

/sys/class/sound/hwC1D0/hints:


!!ALSA/HDA dmesg
!!--------------

[   10.516623]   alloc kstat_irqs on node -1
[   10.516639] snd_hda_intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[   10.516736]   alloc irq_desc for 29 on node -1
[   10.516741]   alloc kstat_irqs on node -1
[   10.516762] snd_hda_intel 0000:00:1b.0: irq 29 for MSI/MSI-X
[   10.516818] snd_hda_intel 0000:00:1b.0: setting latency timer to 64
[   10.537396] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
--
[   10.572093] sd 0:0:0:0: [sda] Attached SCSI disk
[   10.637364] input: HDA Intel Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input4
[   10.637542] input: HDA Intel Front Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input5
[   10.637685] input: HDA Intel Rear Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input6
[   10.637820] input: HDA Intel Line-Out CLFE as /devices/pci0000:00/0000:00:1b.0/sound/card0/input7
[   10.637959] input: HDA Intel Line-Out Surround as /devices/pci0000:00/0000:00:1b.0/sound/card0/input8
[   10.638094] input: HDA Intel Line-Out Front as /devices/pci0000:00/0000:00:1b.0/sound/card0/input9
[   10.638629] snd_hda_intel 0000:03:00.1: PCI INT B -> GSI 18 (level, low) -> IRQ 18
[   10.638637] hda_intel: Disabling MSI
[   10.638707] snd_hda_intel 0000:03:00.1: setting latency timer to 64
[   10.649746] sr0: scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda caddy
--
[   11.031149] budget_av: KNC1-0: MAC addr = 00:09:d6:6d:c1:00
[   11.130613] HDMI status: Codec=0 Pin=4 Presence_Detect=0 ELD_Valid=0
[   11.139100] HDMI status: Codec=0 Pin=5 Presence_Detect=0 ELD_Valid=0
[   11.151088] HDMI status: Codec=0 Pin=6 Presence_Detect=0 ELD_Valid=0
[   11.151251] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1c.1/0000:03:00.1/sound/card1/input10
[   11.151477] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1c.1/0000:03:00.1/sound/card1/input11
[   11.151671] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1c.1/0000:03:00.1/sound/card1/input12
[   11.184046] DVB: registering adapter 0 frontend 0 (Philips TDA10023 DVB-C)...
--
[   16.192732] Bluetooth: c8d09f48
[   21.468063] hda-intel: IRQ timing workaround is activated for card #1. Suggest a bigger bdl_pos_adj.
[   22.776651] r8169 0000:06:0b.0: eth0: link up
--
[   24.967074] NVRM: corruption and stability problems, and is not supported.
[   25.066580] HDMI hot plug event: Codec=0 Pin=5 Presence_Detect=1 ELD_Valid=0
[   25.070928] HDMI status: Codec=0 Pin=5 Presence_Detect=1 ELD_Valid=0
[   25.087409] HDMI hot plug event: Codec=0 Pin=5 Presence_Detect=0 ELD_Valid=1
[   25.094968] HDMI status: Codec=0 Pin=5 Presence_Detect=1 ELD_Valid=1
[   25.876189] HDMI: detected monitor Philips FTV
[   25.876193]   at connection type HDMI
[   25.876198] HDMI: available speakers: FL/FR
[   25.876207] HDMI: supports coding type LPCM: channels = 2, rates = 32000 44100 48000 96000 176400, bits = 16 20 24
[   25.876214] HDMI: supports coding type AC-3: channels = 6, rates = 32000 44100 48000, max bitrate = 640000
[   33.165098] eth0: no IPv6 routers present
[160644.169752] HDMI hot plug event: Codec=0 Pin=5 Presence_Detect=1 ELD_Valid=0
[160644.175603] HDMI status: Codec=0 Pin=5 Presence_Detect=0 ELD_Valid=0
[160656.320166] snd_hda_intel 0000:03:00.1: PCI INT B disabled
[160656.607340] snd_hda_intel 0000:00:1b.0: PCI INT A disabled
[160685.418164] snd_hda_intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[160685.418290] snd_hda_intel 0000:00:1b.0: irq 29 for MSI/MSI-X
[160685.418338] snd_hda_intel 0000:00:1b.0: setting latency timer to 64
[160685.461352] input: HDA Intel Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[160685.461581] input: HDA Intel Front Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input14
[160685.461758] input: HDA Intel Rear Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input15
[160685.461937] input: HDA Intel Line-Out CLFE as /devices/pci0000:00/0000:00:1b.0/sound/card0/input16
[160685.462262] input: HDA Intel Line-Out Surround as /devices/pci0000:00/0000:00:1b.0/sound/card0/input17
[160685.462520] input: HDA Intel Line-Out Front as /devices/pci0000:00/0000:00:1b.0/sound/card0/input18
[160685.463251] snd_hda_intel 0000:03:00.1: PCI INT B -> GSI 18 (level, low) -> IRQ 18
[160685.463262] hda_intel: Disabling MSI
[160685.463375] snd_hda_intel 0000:03:00.1: setting latency timer to 64
[160685.946592] HDMI status: Codec=0 Pin=4 Presence_Detect=0 ELD_Valid=0
[160685.956080] HDMI status: Codec=0 Pin=5 Presence_Detect=0 ELD_Valid=0
[160685.964065] HDMI status: Codec=0 Pin=6 Presence_Detect=0 ELD_Valid=0
[160685.964228] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1c.1/0000:03:00.1/sound/card1/input19
[160685.964455] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1c.1/0000:03:00.1/sound/card1/input20
[160685.964636] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1c.1/0000:03:00.1/sound/card1/input21
[160701.791584] snd_hda_intel 0000:03:00.1: PCI INT B disabled
[160702.078206] snd_hda_intel 0000:00:1b.0: PCI INT A disabled
[160714.091623] snd_hda_intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[160714.091761] snd_hda_intel 0000:00:1b.0: irq 29 for MSI/MSI-X
[160714.091811] snd_hda_intel 0000:00:1b.0: setting latency timer to 64
[160714.138907] input: HDA Intel Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input22
[160714.139127] input: HDA Intel Front Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input23
[160714.139305] input: HDA Intel Rear Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input24
[160714.139509] input: HDA Intel Line-Out CLFE as /devices/pci0000:00/0000:00:1b.0/sound/card0/input25
[160714.139677] input: HDA Intel Line-Out Surround as /devices/pci0000:00/0000:00:1b.0/sound/card0/input26
[160714.139855] input: HDA Intel Line-Out Front as /devices/pci0000:00/0000:00:1b.0/sound/card0/input27
[160714.140762] snd_hda_intel 0000:03:00.1: PCI INT B -> GSI 18 (level, low) -> IRQ 18
[160714.140773] hda_intel: Disabling MSI
[160714.140899] snd_hda_intel 0000:03:00.1: setting latency timer to 64
[160714.627985] HDMI status: Codec=0 Pin=4 Presence_Detect=0 ELD_Valid=0
[160714.635969] HDMI status: Codec=0 Pin=5 Presence_Detect=0 ELD_Valid=0
[160714.643955] HDMI status: Codec=0 Pin=6 Presence_Detect=0 ELD_Valid=0
[160714.644124] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1c.1/0000:03:00.1/sound/card1/input28
[160714.644350] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1c.1/0000:03:00.1/sound/card1/input29
[160714.644539] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1c.1/0000:03:00.1/sound/card1/input30



--AhhlLboLdkugWU4S
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--AhhlLboLdkugWU4S--
