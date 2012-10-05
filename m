From: mefis <mefistof@gmx.com>
Subject: Internal Microphone in Lenovo P580 not working with
	alsa 1.0.25
Date: Fri, 05 Oct 2012 01:20:11 -0500
Message-ID: <506E7C1B.4030703@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout-eu.gmx.com (mailout-eu.gmx.com [213.165.64.43])
 by alsa0.perex.cz (Postfix) with SMTP id DFCBD2615C4
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2012 08:20:19 +0200 (CEST)
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

Hi,

Mic not working in Lenovo P580 with alsa 1.0.25

Alsa Information script output:

http://www.alsa-project.org/db/?f=001523ed61bc76fb5b2ad0d3c354c043f89e5a33

Hope it helps.



!!################################
!!ALSA Information Script v 0.4.61
!!################################

!!Script ran on: Fri Oct  5 05:56:38 UTC 2012


!!Linux Distribution
!!------------------

Ubuntu 12.04.1 LTS \n \l DISTRIB_ID=Ubuntu DISTRIB_DESCRIPTION="Ubuntu 12.04.1 LTS"


!!DMI Information
!!---------------

Manufacturer:      LENOVO
Product Name:      Lenovo IdeaPad P580
Product Version:   Lenovo IdeaPad P580
Firmware Version:  5ECN33WW(V2.03)


!!Kernel Information
!!------------------

Kernel release:    3.2.0-31-generic
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         x86_64
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.25
Library version:    1.0.16
Utilities version:  1.0.25


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
       Installed - Yes (/usr/bin/pulseaudio)
       Running - Yes


!!Soundcards recognised by ALSA
!!-----------------------------

  0 [PCH            ]: HDA-Intel - HDA Intel PCH
                       HDA Intel PCH at 0xe0610000 irq 46


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation Panther Point High Definition Audio Controller (rev 04)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:1b.0 0403: 8086:1e20 (rev 04)
	Subsystem: 17aa:3977


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
snd-hda-intel: model=basic
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
	align_buffer_size : N
	bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	beep_mode : 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : Y
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	model : basic,(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
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

Codec: Conexant CX20590
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x14f1506e
Subsystem Id: 0x17aac02d
Revision Id: 0x100003
No Modem Function Group found
Default PCM:
     rates [0x160]: 44100 48000 96000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=4, o=0, i=0, unsolicited=1, wake=0
   IO[0]: enable=1, dir=1, wake=0, sticky=0, data=1, unsol=0
   IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[3]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x10 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
   Control: name="Master Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Device: name="CONEXANT Analog", type="Audio", device=0
   Amp-Out caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=1
   Amp-Out vals:  [0x39 0x39]
   Converter: stream=8, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0
Node 0x11 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
   Amp-Out caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=1
   Amp-Out vals:  [0x3c 0x3c]
   Converter: stream=0, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0
Node 0x12 [Audio Output] wcaps 0x611: Stereo Digital
   Converter: stream=0, channel=0
   Digital:
   Digital category: 0x49
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0xe]: 16 20 24
     formats [0x5]: PCM AC3
   Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0
Node 0x13 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
   Control: name="Beep Playback Volume", index=0, device=0
     ControlAmp: chs=1, dir=Out, idx=0, ofs=0
   Control: name="Beep Playback Switch", index=0, device=0
     ControlAmp: chs=1, dir=Out, idx=0, ofs=0
   Amp-Out caps: ofs=0x07, nsteps=0x07, stepsize=0x0f, mute=0
   Amp-Out vals:  [0x00]
Node 0x14 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
   Device: name="CONEXANT Analog", type="Audio", device=0
   Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=1
   Amp-In vals:  [0x50 0x50] [0x80 0x80] [0x50 0x50] [0x80 0x80]
   Converter: stream=4, channel=0
   SDI-Select: 0
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0
   Connection: 4
      0x17 0x18 0x23* 0x24
Node 0x15 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
   Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=1
   Amp-In vals:  [0x4a 0x4a] [0x4a 0x4a] [0x4a 0x4a] [0x4a 0x4a]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0
   Connection: 4
      0x17 0x18 0x23 0x24*
Node 0x16 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
   Amp-In caps: ofs=0x4a, nsteps=0x50, stepsize=0x03, mute=1
   Amp-In vals:  [0x4a 0x4a] [0x4a 0x4a] [0x4a 0x4a] [0x4a 0x4a]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0
   Connection: 4
      0x17* 0x18 0x23 0x24
Node 0x17 [Audio Selector] wcaps 0x30050d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
   Amp-Out vals:  [0x02 0x02]
   Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0
   Connection: 4
      0x1a 0x1b* 0x1d 0x1e
Node 0x18 [Audio Selector] wcaps 0x30050d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
   Amp-Out vals:  [0x00 0x00]
   Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0
   Connection: 4
      0x1a* 0x1b 0x1d 0x1e
Node 0x19 [Pin Complex] wcaps 0x400581: Stereo
   Pincap 0x0000001c: OUT HP Detect
   Pin Default 0x04211040: [Jack] HP Out at Ext Right
     Conn = 1/8, Color = Black
     DefAssociation = 0x4, Sequence = 0x0
   Pin-ctls: 0xc0: OUT HP
   Unsolicited: tag=37, enabled=1
   Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0
   Connection: 2
      0x10* 0x11
Node 0x1a [Pin Complex] wcaps 0x400481: Stereo
   Pincap 0x00001324: IN Detect
     Vref caps: HIZ 50 80
   Pin Default 0x04a11030: [Jack] Mic at Ext Right
     Conn = 1/8, Color = Black
     DefAssociation = 0x3, Sequence = 0x0
   Pin-ctls: 0x24: IN VREF_80
   Unsolicited: tag=01, enabled=0
   Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0
Node 0x1b [Pin Complex] wcaps 0x400581: Stereo
   Pincap 0x00011334: IN OUT EAPD Detect
     Vref caps: HIZ 50 80
   EAPD 0x2: EAPD
   Pin Default 0x95a70120: [Fixed] Mic at Int Top
     Conn = Analog, Color = Unknown
     DefAssociation = 0x2, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x00: VREF_HIZ
   Unsolicited: tag=38, enabled=1
   Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0
   Connection: 2
      0x10* 0x11
Node 0x1c [Pin Complex] wcaps 0x400581: Stereo
   Pincap 0x00000014: OUT Detect
   Pin Default 0x400001f0: [N/A] Line Out at Ext N/A
     Conn = Unknown, Color = Unknown
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x00:
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0
   Connection: 2
      0x10* 0x11
Node 0x1d [Pin Complex] wcaps 0x400581: Stereo
   Pincap 0x00010034: IN OUT EAPD Detect
   EAPD 0x2: EAPD
   Pin Default 0x400001f0: [N/A] Line Out at Ext N/A
     Conn = Unknown, Color = Unknown
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0
   Connection: 2
      0x10* 0x11
Node 0x1e [Pin Complex] wcaps 0x400481: Stereo
   Pincap 0x00000024: IN Detect
   Pin Default 0x400001f0: [N/A] Line Out at Ext N/A
     Conn = Unknown, Color = Unknown
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0
Node 0x1f [Pin Complex] wcaps 0x400501: Stereo
   Pincap 0x00000010: OUT
   Pin Default 0x92170110: [Fixed] Speaker at Int Front
     Conn = Analog, Color = Unknown
     DefAssociation = 0x1, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x00:
   Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0
   Connection: 2
      0x10* 0x11
Node 0x20 [Pin Complex] wcaps 0x400781: Stereo Digital
   Pincap 0x00000010: OUT
   Pin Default 0x400001f0: [N/A] Line Out at Ext N/A
     Conn = Unknown, Color = Unknown
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=04, enabled=0
   Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0
   Connection: 1
      0x12
Node 0x21 [Audio Output] wcaps 0x611: Stereo Digital
   Converter: stream=0, channel=0
   Digital:
   Digital category: 0x49
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0xe]: 16 20 24
     formats [0x5]: PCM AC3
   Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0
Node 0x22 [Pin Complex] wcaps 0x400781: Stereo Digital
   Pincap 0x00000010: OUT
   Pin Default 0x400001f0: [N/A] Line Out at Ext N/A
     Conn = Unknown, Color = Unknown
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0
   Connection: 1
      0x21
Node 0x23 [Pin Complex] wcaps 0x40040b: Stereo Amp-In
   Amp-In caps: ofs=0x00, nsteps=0x04, stepsize=0x2f, mute=0
   Amp-In vals:  [0x02 0x02]
   Pincap 0x00000020: IN
   Pin Default 0x400001f0: [N/A] Line Out at Ext N/A
     Conn = Unknown, Color = Unknown
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
   Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0
Node 0x24 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
   Amp-In caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=1
   Amp-In vals:  [0x4a 0x4a] [0x4a 0x4a]
   Power states:  D0 D1 D2 D3 D3cold EPSS
   Power: setting=D0, actual=D0
   Connection: 2
      0x10 0x11
Node 0x25 [Vendor Defined Widget] wcaps 0xf00000: Mono
Codec: Intel PantherPoint HDMI
Address: 3
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x80862806
Subsystem Id: 0x80860101
Revision Id: 0x100000
No Modem Function Group found
Default PCM:
     rates [0x0]:
     bits [0x0]:
     formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x6611: 8-Channels Digital
   Converter: stream=0, channel=0
   Digital: Enabled
   Digital category: 0x0
   PCM:
     rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
     bits [0x1e]: 16 20 24 32
     formats [0x5]: PCM AC3
   Power states:  D0 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x03 [Audio Output] wcaps 0x6611: 8-Channels Digital
   Converter: stream=0, channel=0
   Digital: Enabled
   Digital category: 0x0
   PCM:
     rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
     bits [0x1e]: 16 20 24 32
     formats [0x5]: PCM AC3
   Power states:  D0 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x04 [Audio Output] wcaps 0x6611: 8-Channels Digital
   Converter: stream=0, channel=0
   Digital: Enabled
   Digital category: 0x0
   PCM:
     rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
     bits [0x1e]: 16 20 24 32
     formats [0x5]: PCM AC3
   Power states:  D0 D3 EPSS
   Power: setting=D0, actual=D0
Node 0x05 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
   Control: name="HDMI/DP,pcm=3 Jack", index=0, device=0
   Control: name="IEC958 Playback Con Mask", index=0, device=0
   Control: name="IEC958 Playback Pro Mask", index=0, device=0
   Control: name="IEC958 Playback Default", index=0, device=0
   Control: name="IEC958 Playback Switch", index=0, device=0
   Control: name="ELD", index=0, device=3
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x09000094: OUT Detect HBR HDMI DP
   Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
     Conn = Digital, Color = Unknown
     DefAssociation = 0x1, Sequence = 0x0
   Pin-ctls: 0x00:
   Unsolicited: tag=01, enabled=1
   Power states:  D0 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 1
      0x02
Node 0x06 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x80]
   Pincap 0x09000094: OUT Detect HBR HDMI DP
   Pin Default 0x58560020: [N/A] Digital Out at Int HDMI
     Conn = Digital, Color = Unknown
     DefAssociation = 0x2, Sequence = 0x0
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 1
      0x03
Node 0x07 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x80]
   Pincap 0x09000094: OUT Detect HBR HDMI DP
   Pin Default 0x58560030: [N/A] Digital Out at Int HDMI
     Conn = Digital, Color = Unknown
     DefAssociation = 0x3, Sequence = 0x0
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=00, enabled=0
   Power states:  D0 D3 EPSS
   Power: setting=D0, actual=D0
   Connection: 1
      0x04
Node 0x08 [Vendor Defined Widget] wcaps 0xf00000: Mono
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---T  1 root audio 116,  7 Oct  5 00:44 /dev/snd/controlC0
crw-rw---T  1 root audio 116,  6 Oct  5 00:44 /dev/snd/hwC0D0
crw-rw---T  1 root audio 116,  5 Oct  5 00:44 /dev/snd/hwC0D3
crw-rw---T  1 root audio 116,  4 Oct  5 00:48 /dev/snd/pcmC0D0c
crw-rw---T  1 root audio 116,  3 Oct  5 00:48 /dev/snd/pcmC0D0p
crw-rw---T  1 root audio 116,  2 Oct  5 00:44 /dev/snd/pcmC0D3p
crw-rw---T  1 root audio 116,  1 Oct  5 00:44 /dev/snd/seq
crw-rw---T  1 root audio 116, 33 Oct  5 00:44 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Oct  5 00:44 .
drwxr-xr-x 3 root root 220 Oct  5 00:44 ..
lrwxrwxrwx 1 root root  12 Oct  5 00:44 pci-0000:00:1b.0 -> ../controlC0


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: CONEXANT Analog [CONEXANT Analog]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 3: HDMI 0 [HDMI 0]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: CONEXANT Analog [CONEXANT Analog]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [PCH]

Card hw:0 'PCH'/'HDA Intel PCH at 0xe0610000 irq 46'
   Mixer name	: 'Intel PantherPoint HDMI'
   Components	: 'HDA:14f1506e,17aac02d,00100003 HDA:80862806,80860101,00100000'
   Controls      : 15
   Simple ctrls  : 7
Simple mixer control 'Master',0
   Capabilities: pvolume pswitch pswitch-joined penum
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 74
   Mono:
   Front Left: Playback 57 [77%] [-17.00dB] [on]
   Front Right: Playback 57 [77%] [-17.00dB] [on]
Simple mixer control 'PCM',0
   Capabilities: pvolume penum
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 255
   Mono:
   Front Left: Playback 135 [53%] [-24.00dB]
   Front Right: Playback 135 [53%] [-24.00dB]
Simple mixer control 'IEC958',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [on]
Simple mixer control 'Beep',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
   Playback channels: Mono
   Limits: Playback 0 - 7
   Mono: Playback 3 [43%] [-16.00dB] [on]
Simple mixer control 'Capture',0
   Capabilities: cvolume cswitch penum
   Capture channels: Front Left - Front Right
   Limits: Capture 0 - 80
   Front Left: Capture 80 [100%] [6.00dB] [on]
   Front Right: Capture 80 [100%] [6.00dB] [on]
Simple mixer control 'Analog Mic Boost',0
   Capabilities: cenum
   Items: '0dB' '10dB' '20dB' '30dB' '40dB'
   Item0: '20dB'
Simple mixer control 'Digital',0
   Capabilities: cvolume penum
   Capture channels: Front Left - Front Right
   Limits: Capture 0 - 120
   Front Left: Capture 60 [50%] [0.00dB]
   Front Right: Capture 60 [50%] [0.00dB]


!!Alsactl output
!!--------------

--startcollapse--
state.PCH {
	control.1 {
		iface MIXER
		name 'Master Playback Volume'
		value.0 57
		value.1 57
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 74'
			dbmin -7400
			dbmax 0
			dbvalue.0 -1700
			dbvalue.1 -1700
		}
	}
	control.2 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.3 {
		iface MIXER
		name 'Analog Mic Boost Capture Enum'
		value '20dB'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 '0dB'
			item.1 '10dB'
			item.2 '20dB'
			item.3 '30dB'
			item.4 '40dB'
		}
	}
	control.4 {
		iface MIXER
		name 'Capture Volume'
		value.0 80
		value.1 80
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 80'
			dbmin -7400
			dbmax 600
			dbvalue.0 600
			dbvalue.1 600
		}
	}
	control.5 {
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
	control.6 {
		iface MIXER
		name 'Beep Playback Volume'
		value 3
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 7'
			dbmin -2800
			dbmax 0
			dbvalue.0 -1600
		}
	}
	control.7 {
		iface MIXER
		name 'Beep Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.8 {
		iface CARD
		name 'HDMI/DP,pcm=3 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.9 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.10 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.11 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.12 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.13 {
		iface PCM
		device 3
		name ELD
		value ''
		comment {
			access read
			type BYTES
			count 0
		}
	}
	control.14 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 135
		value.1 135
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 255'
			tlv '0000000100000008ffffec1400000014'
			dbmin -5100
			dbmax 0
			dbvalue.0 -2400
			dbvalue.1 -2400
		}
	}
	control.15 {
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
--endcollapse--


!!All Loaded Modules
!!------------------

Module
rfcomm
bnep
bluetooth
parport_pc
ppdev
binfmt_misc
snd_hda_codec_hdmi
snd_hda_codec_conexant
joydev
snd_hda_intel
snd_hda_codec
snd_hwdep
snd_pcm_oss
snd_mixer_oss
snd_pcm
snd_seq_dummy
snd_seq_oss
snd_seq_midi_event
snd_seq
snd_timer
snd_seq_device
snd
alx
compat
arc4
soundcore
snd_page_alloc
iwlwifi
mac80211
uvcvideo
ideapad_laptop
videodev
i915
drm_kms_helper
v4l2_compat_ioctl32
mei
drm
sparse_keymap
cfg80211
i2c_algo_bit
video
psmouse
mac_hid
serio_raw
lp
parport
usbhid
hid


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x19 0x04211040
0x1a 0x04a11030
0x1b 0x95a70120
0x1c 0x400001f0
0x1d 0x400001f0
0x1e 0x400001f0
0x1f 0x92170110
0x20 0x400001f0
0x22 0x400001f0
0x23 0x400001f0

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D3/init_pin_configs:
0x05 0x18560010
0x06 0x58560020
0x07 0x58560030

/sys/class/sound/hwC0D3/driver_pin_configs:

/sys/class/sound/hwC0D3/user_pin_configs:

/sys/class/sound/hwC0D3/init_verbs:


!!ALSA/HDA dmesg
!!--------------

[   18.438062] mei 0000:00:16.0: irq 45 for MSI/MSI-X
[   18.583957] snd_hda_intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[   18.584008] snd_hda_intel 0000:00:1b.0: irq 46 for MSI/MSI-X
[   18.584036] snd_hda_intel 0000:00:1b.0: setting latency timer to 64
[   18.650583] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.0, id: 0x1e2b1, caps: 0xd00123/0x840300/0x123c00
[   18.724639] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input9
[   19.124515] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input10
[   19.128227] HDMI status: Codec=3 Pin=5 Presence_Detect=0 ELD_Valid=0
[   19.128283] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1b.0/sound/card0/input11
[   19.888422] EXT4-fs (sda5): re-mounted. Opts: errors=remount-ro
