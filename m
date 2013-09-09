From: Vincent Thiele <vincentthiele@gmail.com>
Subject: Sound distorted on Intel HDA (Realtek ALC889) (Kernel
	3.x)
Date: Mon, 9 Sep 2013 23:04:36 +0200
Message-ID: <CAEZsi7E9Ls8K_z59pad=wBpxg8Wvdq-+CzEne5ywur2WKCf0wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f169.google.com (mail-we0-f169.google.com
 [74.125.82.169])
 by alsa0.perex.cz (Postfix) with ESMTP id C958E2619F5
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 23:04:37 +0200 (CEST)
Received: by mail-we0-f169.google.com with SMTP id t60so5977831wes.28
 for <alsa-devel@alsa-project.org>; Mon, 09 Sep 2013 14:04:37 -0700 (PDT)
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

Using Audio device: Intel Corporation 6 Series/C200 Series Chipset
Family High Definition Audio Controller (rev 05)
Mainboard is: http://www.asus.com/Motherboards/MAXIMUS_IV_GENEZ/
Only fix at the moment is changing "load-module module-udev-detect
use_ucm=0" in "/etc/pulse/default.pa" to "load-module
module-udev-detect tsched=0".
Maybe you should add a specific rule for this device which adds this
fix automatically.
Best regards

alsa-info.sh output:

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.62
!!################################

!!Script ran on: Mon Jul 22 18:15:08 UTC 2013


!!Linux Distribution
!!------------------

Ubuntu 13.04 \n \l DISTRIB_ID=Ubuntu DISTRIB_DESCRIPTION="Ubuntu
13.04" NAME="Ubuntu" ID=ubuntu ID_LIKE=debian PRETTY_NAME="Ubuntu
13.04" HOME_URL="http://www.ubuntu.com/"
SUPPORT_URL="http://help.ubuntu.com/"
BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"


!!DMI Information
!!---------------

Manufacturer:      System manufacturer
Product Name:      System Product Name
Product Version:   System Version
Firmware Version:  3603


!!Kernel Information
!!------------------

Kernel release:    3.11.0-031100rc2-generic
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         x86_64
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k3.11.0-031100rc2-generic
Library version:    1.0.25
Utilities version:  1.0.25


!!Loaded ALSA modules
!!-------------------

snd_hda_intel
snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - Yes


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xf7420000 irq 54
 1 [NVidia         ]: HDA-Intel - HDA NVidia
                      HDA NVidia at 0xf7080000 irq 17


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset
Family High Definition Audio Controller (rev 05)
01:00.1 Audio device: NVIDIA Corporation Device 0e0b (rev a1)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:1b.0 0403: 8086:1c20 (rev 05)
Subsystem: 1043:84dc
--
01:00.1 0403: 10de:0e0b (rev a1)
Subsystem: 1043:8422


!!Modprobe options (Sound related)
!!--------------------------------

snd_atiixp_modem: index=-2
snd_intel8x0m: index=-2
snd_via82xx_modem: index=-2
snd_usb_audio: index=-2
snd_usb_caiaq: index=-2
snd_usb_ua101: index=-2
snd_usb_us122l: index=-2
snd_usb_usx2y: index=-2
snd_cmipci: mpu_port=0x330 fm_port=0x388
snd_pcsp: index=-2
snd_usb_audio: index=-2


!!Loaded sound module options
!!---------------------------

!!Module: snd_hda_intel
align_buffer_size : -1
bdl_pos_adj : 1,32,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
beep_mode : N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N
enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
enable_msi : -1
id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
jackpoll_ms : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
power_save : 0
power_save_controller : Y
probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
single_cmd : N
snoop : Y

!!Module: snd_hda_intel
align_buffer_size : -1
bdl_pos_adj : 1,32,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
beep_mode : N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N
enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
enable_msi : -1
id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
jackpoll_ms : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
model : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
patch : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
position_fix : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
power_save : 0
power_save_controller : Y
probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
probe_only : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
single_cmd : N
snoop : Y


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ALC889
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0889
Subsystem Id: 0x1043846b
Revision Id: 0x100004
No Modem Function Group found
Default PCM:
    rates [0x5f0]: 32000 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D1 D2 D3 CLKSTOP EPSS
  Power: setting=D0, actual=D0
GPIO: io=2, o=0, i=0, unsolicited=1, wake=1
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x11: Stereo
  Device: name="ALC889 Analog", type="Audio", device=0
  Converter: stream=8, channel=0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=8, channel=0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x04 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=8, channel=0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x05 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=8, channel=0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  Converter: stream=8, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x5f0]: 32000 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x07 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Device: name="ALC889 Analog", type="Audio", device=0
  Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
  Amp-In vals:  [0x00 0x00]
  Converter: stream=4, channel=0
  SDI-Select: 0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Connection: 1
     0x24
Node 0x08 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Control: name="Capture Volume", index=1, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=1, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Device: name="ALC889 Alt Analog", type="Audio", device=2
  Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
  Amp-In vals:  [0x80 0x80]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Connection: 1
     0x23
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Control: name="Capture Volume", index=2, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=2, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
  Amp-In vals:  [0x80 0x80]
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
  IEC Coding Type: 0x0
  PCM:
    rates [0x570]: 32000 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Unsolicited: tag=00, enabled=0
  Connection: 1
     0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Front Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Front Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Rear Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Rear Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Line Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="Line Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="Beep Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=5, ofs=0
  Control: name="Beep Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=5, ofs=0
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 10
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Control: name="Front Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x3e, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x39 0x39]
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Control: name="Surround Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x3e, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x39 0x39]
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Control: name="Center Playback Volume", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="LFE Playback Volume", index=0, device=0
    ControlAmp: chs=2, dir=Out, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x3e, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x39 0x39]
  Connection: 2
     0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Control: name="Side Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x3e, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x39 0x39]
  Connection: 2
     0x05 0x0b
Node 0x10 [Audio Output] wcaps 0x211: Stereo Digital
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="IEC958 Default PCM Playback Switch", index=0, device=0
  Device: name="ALC889 Digital", type="SPDIF", device=1
  Converter: stream=8, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x5f0]: 32000 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x11 [Pin Complex] wcaps 0x400300: Mono Digital
  Control: name="SPDIF Phantom Jack", index=0, device=0
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
  Pin-ctls: 0x00:
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Front Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line Out Front Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001003c: IN OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=05, enabled=1
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Surround Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line Out Surround Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001003c: IN OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x01011012: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0x2
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=06, enabled=1
  Connection: 5
     0x0c 0x0d* 0x0e 0x0f 0x26
Node 0x16 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Center Playback Switch", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="LFE Playback Switch", index=0, device=0
    ControlAmp: chs=2, dir=Out, idx=0, ofs=0
  Control: name="Line Out CLFE Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00000034: IN OUT Detect
  Pin Default 0x01016011: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Orange
    DefAssociation = 0x1, Sequence = 0x1
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=07, enabled=1
  Connection: 5
     0x0c 0x0d 0x0e* 0x0f 0x26
Node 0x17 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Control: name="Side Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line Out Side Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00000034: IN OUT Detect
  Pin Default 0x01012014: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Grey
    DefAssociation = 0x1, Sequence = 0x4
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=08, enabled=1
  Connection: 5
     0x0c 0x0d 0x0e 0x0f* 0x26
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Control: name="Rear Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Rear Mic Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x01a19850: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
    DefAssociation = 0x5, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=03, enabled=1
  Connection: 5
     0x0c 0x0d 0x0e 0x0f 0x26*
Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Control: name="Front Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Front Mic Jack", index=0, device=0
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
  Unsolicited: tag=02, enabled=1
  Connection: 5
     0x0c 0x0d 0x0e 0x0f 0x26*
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Control: name="Line Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Line Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x0181305f: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
    DefAssociation = 0x5, Sequence = 0xf
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=04, enabled=1
  Connection: 5
     0x0c 0x0d 0x0e 0x0f 0x26*
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Front Headphone Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000373c: IN OUT HP Detect
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x02214c20: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Green
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=01, enabled=1
  Connection: 5
     0x0c 0x0d 0x0e 0x0f 0x26*
Node 0x1c [Pin Complex] wcaps 0x400081: Stereo
  Pincap 0x00000024: IN Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x00000020: IN
  Pin Default 0x4007e629: [N/A] Line Out at Ext N/A
    Conn = Analog, Color = White
    DefAssociation = 0x2, Sequence = 0x9
  Pin-ctls: 0x20: IN
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
  Control: name="SPDIF Phantom Jack", index=1, device=0
  Pincap 0x00000010: OUT
  Pin Default 0x01451130: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Black
    DefAssociation = 0x3, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x06
Node 0x1f [Pin Complex] wcaps 0x400280: Mono Digital
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
  Processing caps: benign=0, ncoeff=28
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
[0x80 0x80]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80
0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
[0x80 0x80]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x24 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 12
     0x18 0x19* 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b 0x12
Node 0x25 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=8, channel=0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x3e, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x39 0x39]
  Connection: 2
     0x25 0x0b
Codec: Nvidia GPU 41 HDMI/DP
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10de0041
Subsystem Id: 0x10438422
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D1 D2 D3 CLKSTOP EPSS
  Power: setting=D0, actual=D0
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
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=01, enabled=1
  Connection: 4
     0x08* 0x09 0x0a 0x0b
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
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=02, enabled=1
  Connection: 4
     0x08* 0x09 0x0a 0x0b
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
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=03, enabled=1
  Connection: 4
     0x08* 0x09 0x0a 0x0b
Node 0x07 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
  Control: name="HDMI/DP,pcm=9 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=3, device=0
  Control: name="IEC958 Playback Pro Mask", index=3, device=0
  Control: name="IEC958 Playback Default", index=3, device=0
  Control: name="IEC958 Playback Switch", index=3, device=0
  Control: name="ELD", index=0, device=9
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x185600f0: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=04, enabled=1
  Connection: 4
     0x08* 0x09 0x0a 0x0b
Node 0x08 [Audio Output] wcaps 0x62b1: 8-Channels Digital Stripe
  Converter: stream=8, channel=0
  Digital: Enabled
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Unsolicited: tag=00, enabled=0
Node 0x09 [Audio Output] wcaps 0x62b1: 8-Channels Digital Stripe
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Unsolicited: tag=00, enabled=0
Node 0x0a [Audio Output] wcaps 0x62b1: 8-Channels Digital Stripe
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Unsolicited: tag=00, enabled=0
Node 0x0b [Audio Output] wcaps 0x62b1: 8-Channels Digital Stripe
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Unsolicited: tag=00, enabled=0
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---T+ 1 root audio 116,  7 Jul 22 20:08 /dev/snd/controlC0
crw-rw---T+ 1 root audio 116, 13 Jul 22 20:08 /dev/snd/controlC1
crw-rw---T+ 1 root audio 116,  6 Jul 22 20:08 /dev/snd/hwC0D0
crw-rw---T+ 1 root audio 116, 12 Jul 22 20:08 /dev/snd/hwC1D0
crw-rw---T+ 1 root audio 116,  5 Jul 22 20:09 /dev/snd/pcmC0D0c
crw-rw---T+ 1 root audio 116,  4 Jul 22 20:10 /dev/snd/pcmC0D0p
crw-rw---T+ 1 root audio 116,  3 Jul 22 20:09 /dev/snd/pcmC0D1p
crw-rw---T+ 1 root audio 116,  2 Jul 22 20:08 /dev/snd/pcmC0D2c
crw-rw---T+ 1 root audio 116, 11 Jul 22 20:09 /dev/snd/pcmC1D3p
crw-rw---T+ 1 root audio 116, 10 Jul 22 20:09 /dev/snd/pcmC1D7p
crw-rw---T+ 1 root audio 116,  9 Jul 22 20:09 /dev/snd/pcmC1D8p
crw-rw---T+ 1 root audio 116,  8 Jul 22 20:09 /dev/snd/pcmC1D9p
crw-rw---T+ 1 root audio 116,  1 Jul 22 20:08 /dev/snd/seq
crw-rw---T+ 1 root audio 116, 33 Jul 22 20:08 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  80 Jul 22 20:08 .
drwxr-xr-x 3 root root 340 Jul 22 20:08 ..
lrwxrwxrwx 1 root root  12 Jul 22 20:08 pci-0000:00:1b.0 -> ../controlC0
lrwxrwxrwx 1 root root  12 Jul 22 20:08 pci-0000:01:00.1 -> ../controlC1


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC889 Analog [ALC889 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 1: ALC889 Digital [ALC889 Digital]
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
card 1: NVidia [HDA NVidia], device 9: HDMI 3 [HDMI 3]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC889 Analog [ALC889 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 2: ALC889 Alt Analog [ALC889 Alt Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [PCH]

Card hw:0 'PCH'/'HDA Intel PCH at 0xf7420000 irq 54'
  Mixer name : 'Realtek ALC889'
  Components : 'HDA:10ec0889,1043846b,00100004'
  Controls      : 57
  Simple ctrls  : 25
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 59 [92%] [-5.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 62 [97%] [0.00dB] [on]
  Front Right: Playback 62 [97%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 254 [100%] [0.20dB]
  Front Right: Playback 254 [100%] [0.20dB]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 62 [97%] [0.00dB] [on]
  Front Right: Playback 62 [97%] [0.00dB] [on]
Simple mixer control 'Front Mic',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Front Mic Boost',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 62 [97%] [0.00dB] [on]
  Front Right: Playback 62 [97%] [0.00dB] [on]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 62 [97%] [0.00dB] [on]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 62 [97%] [0.00dB] [on]
Simple mixer control 'Side',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 62 [97%] [0.00dB] [on]
  Front Right: Playback 62 [97%] [0.00dB] [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Line Boost',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Beep',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 46
  Front Left: Capture 0 [0%] [-16.00dB] [on]
  Front Right: Capture 0 [0%] [-16.00dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 46
  Front Left: Capture 0 [0%] [-16.00dB] [off]
  Front Right: Capture 0 [0%] [-16.00dB] [off]
Simple mixer control 'Capture',2
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 46
  Front Left: Capture 0 [0%] [-16.00dB] [off]
  Front Right: Capture 0 [0%] [-16.00dB] [off]
Simple mixer control 'Auto-Mute Mode',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Enabled'
Simple mixer control 'Digital',0
  Capabilities: cvolume penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 60 [50%] [0.00dB]
  Front Right: Capture 60 [50%] [0.00dB]
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Front Mic' 'Rear Mic' 'Line'
  Item0: 'Front Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Front Mic' 'Rear Mic' 'Line'
  Item0: 'Front Mic'
Simple mixer control 'Input Source',2
  Capabilities: cenum
  Items: 'Front Mic' 'Rear Mic' 'Line'
  Item0: 'Front Mic'
Simple mixer control 'Rear Mic',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Rear Mic Boost',0
  Capabilities: volume penum
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]

!!-------Mixer controls for card 1 [NVidia]

Card hw:1 'NVidia'/'HDA NVidia at 0xf7080000 irq 17'
  Mixer name : 'Nvidia GPU 41 HDMI/DP'
  Components : 'HDA:10de0041,10438422,00100100'
  Controls      : 28
  Simple ctrls  : 4
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',1
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',2
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',3
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [on]


!!Alsactl output
!!--------------

--startcollapse--
state.PCH {
control.1 {
iface MIXER
name 'Front Playback Volume'
value.0 62
value.1 62
comment {
access 'read write'
type INTEGER
count 2
range '0 - 64'
dbmin -6200
dbmax 200
dbvalue.0 0
dbvalue.1 0
}
}
control.2 {
iface MIXER
name 'Front Playback Switch'
value.0 true
value.1 true
comment {
access 'read write'
type BOOLEAN
count 2
}
}
control.3 {
iface MIXER
name 'Surround Playback Volume'
value.0 62
value.1 62
comment {
access 'read write'
type INTEGER
count 2
range '0 - 64'
dbmin -6200
dbmax 200
dbvalue.0 0
dbvalue.1 0
}
}
control.4 {
iface MIXER
name 'Surround Playback Switch'
value.0 true
value.1 true
comment {
access 'read write'
type BOOLEAN
count 2
}
}
control.5 {
iface MIXER
name 'Center Playback Volume'
value 62
comment {
access 'read write'
type INTEGER
count 1
range '0 - 64'
dbmin -6200
dbmax 200
dbvalue.0 0
}
}
control.6 {
iface MIXER
name 'LFE Playback Volume'
value 62
comment {
access 'read write'
type INTEGER
count 1
range '0 - 64'
dbmin -6200
dbmax 200
dbvalue.0 0
}
}
control.7 {
iface MIXER
name 'Center Playback Switch'
value true
comment {
access 'read write'
type BOOLEAN
count 1
}
}
control.8 {
iface MIXER
name 'LFE Playback Switch'
value true
comment {
access 'read write'
type BOOLEAN
count 1
}
}
control.9 {
iface MIXER
name 'Side Playback Volume'
value.0 62
value.1 62
comment {
access 'read write'
type INTEGER
count 2
range '0 - 64'
dbmin -6200
dbmax 200
dbvalue.0 0
dbvalue.1 0
}
}
control.10 {
iface MIXER
name 'Side Playback Switch'
value.0 true
value.1 true
comment {
access 'read write'
type BOOLEAN
count 2
}
}
control.11 {
iface MIXER
name 'Headphone Playback Volume'
value.0 62
value.1 62
comment {
access 'read write'
type INTEGER
count 2
range '0 - 64'
dbmin -6200
dbmax 200
dbvalue.0 0
dbvalue.1 0
}
}
control.12 {
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
control.13 {
iface MIXER
name 'Front Mic Playback Volume'
value.0 0
value.1 0
comment {
access 'read write'
type INTEGER
count 2
range '0 - 31'
dbmin -3450
dbmax 1200
dbvalue.0 -3450
dbvalue.1 -3450
}
}
control.14 {
iface MIXER
name 'Front Mic Playback Switch'
value.0 false
value.1 false
comment {
access 'read write'
type BOOLEAN
count 2
}
}
control.15 {
iface MIXER
name 'Rear Mic Playback Volume'
value.0 0
value.1 0
comment {
access 'read write'
type INTEGER
count 2
range '0 - 31'
dbmin -3450
dbmax 1200
dbvalue.0 -3450
dbvalue.1 -3450
}
}
control.16 {
iface MIXER
name 'Rear Mic Playback Switch'
value.0 false
value.1 false
comment {
access 'read write'
type BOOLEAN
count 2
}
}
control.17 {
iface MIXER
name 'Line Playback Volume'
value.0 0
value.1 0
comment {
access 'read write'
type INTEGER
count 2
range '0 - 31'
dbmin -3450
dbmax 1200
dbvalue.0 -3450
dbvalue.1 -3450
}
}
control.18 {
iface MIXER
name 'Line Playback Switch'
value.0 false
value.1 false
comment {
access 'read write'
type BOOLEAN
count 2
}
}
control.19 {
iface MIXER
name 'Auto-Mute Mode'
value Enabled
comment {
access 'read write'
type ENUMERATED
count 1
item.0 Disabled
item.1 Enabled
}
}
control.20 {
iface MIXER
name 'Input Source'
value 'Front Mic'
comment {
access 'read write'
type ENUMERATED
count 1
item.0 'Front Mic'
item.1 'Rear Mic'
item.2 Line
}
}
control.21 {
iface MIXER
name 'Input Source'
index 1
value 'Front Mic'
comment {
access 'read write'
type ENUMERATED
count 1
item.0 'Front Mic'
item.1 'Rear Mic'
item.2 Line
}
}
control.22 {
iface MIXER
name 'Input Source'
index 2
value 'Front Mic'
comment {
access 'read write'
type ENUMERATED
count 1
item.0 'Front Mic'
item.1 'Rear Mic'
item.2 Line
}
}
control.23 {
iface MIXER
name 'Capture Volume'
value.0 0
value.1 0
comment {
access 'read write'
type INTEGER
count 2
range '0 - 46'
dbmin -1600
dbmax 3000
dbvalue.0 -1600
dbvalue.1 -1600
}
}
control.24 {
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
control.25 {
iface MIXER
name 'Capture Volume'
index 1
value.0 0
value.1 0
comment {
access 'read write'
type INTEGER
count 2
range '0 - 46'
dbmin -1600
dbmax 3000
dbvalue.0 -1600
dbvalue.1 -1600
}
}
control.26 {
iface MIXER
name 'Capture Switch'
index 1
value.0 false
value.1 false
comment {
access 'read write'
type BOOLEAN
count 2
}
}
control.27 {
iface MIXER
name 'Capture Volume'
index 2
value.0 0
value.1 0
comment {
access 'read write'
type INTEGER
count 2
range '0 - 46'
dbmin -1600
dbmax 3000
dbvalue.0 -1600
dbvalue.1 -1600
}
}
control.28 {
iface MIXER
name 'Capture Switch'
index 2
value.0 false
value.1 false
comment {
access 'read write'
type BOOLEAN
count 2
}
}
control.29 {
iface MIXER
name 'Front Mic Boost Volume'
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
control.30 {
iface MIXER
name 'Rear Mic Boost Volume'
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
control.31 {
iface MIXER
name 'Line Boost Volume'
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
control.32 {
iface MIXER
name 'IEC958 Playback Con Mask'
value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
comment {
access read
type IEC958
count 1
}
}
control.33 {
iface MIXER
name 'IEC958 Playback Pro Mask'
value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
comment {
access read
type IEC958
count 1
}
}
control.34 {
iface MIXER
name 'IEC958 Playback Default'
value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
comment {
access 'read write'
type IEC958
count 1
}
}
control.35 {
iface MIXER
name 'IEC958 Playback Switch'
value false
comment {
access 'read write'
type BOOLEAN
count 1
}
}
control.36 {
iface MIXER
name 'IEC958 Default PCM Playback Switch'
value true
comment {
access 'read write'
type BOOLEAN
count 1
}
}
control.37 {
iface MIXER
name 'Master Playback Volume'
value 59
comment {
access 'read write'
type INTEGER
count 1
range '0 - 64'
dbmin -6400
dbmax 0
dbvalue.0 -500
}
}
control.38 {
iface MIXER
name 'Master Playback Switch'
value true
comment {
access 'read write'
type BOOLEAN
count 1
}
}
control.39 {
iface CARD
name 'Front Mic Jack'
value false
comment {
access read
type BOOLEAN
count 1
}
}
control.40 {
iface CARD
name 'Rear Mic Jack'
value false
comment {
access read
type BOOLEAN
count 1
}
}
control.41 {
iface CARD
name 'Line Jack'
value false
comment {
access read
type BOOLEAN
count 1
}
}
control.42 {
iface CARD
name 'Line Out Front Jack'
value true
comment {
access read
type BOOLEAN
count 1
}
}
control.43 {
iface CARD
name 'Line Out Surround Jack'
value false
comment {
access read
type BOOLEAN
count 1
}
}
control.44 {
iface CARD
name 'Line Out CLFE Jack'
value false
comment {
access read
type BOOLEAN
count 1
}
}
control.45 {
iface CARD
name 'Line Out Side Jack'
value false
comment {
access read
type BOOLEAN
count 1
}
}
control.46 {
iface CARD
name 'Front Headphone Jack'
value false
comment {
access read
type BOOLEAN
count 1
}
}
control.47 {
iface CARD
name 'SPDIF Phantom Jack'
value true
comment {
access read
type BOOLEAN
count 1
}
}
control.48 {
iface CARD
name 'SPDIF Phantom Jack'
index 1
value true
comment {
access read
type BOOLEAN
count 1
}
}
control.49 {
iface MIXER
name 'Beep Playback Volume'
value.0 0
value.1 0
comment {
access 'read write'
type INTEGER
count 2
range '0 - 31'
dbmin -3450
dbmax 1200
dbvalue.0 -3450
dbvalue.1 -3450
}
}
control.50 {
iface MIXER
name 'Beep Playback Switch'
value.0 false
value.1 false
comment {
access 'read write'
type BOOLEAN
count 2
}
}
control.51 {
iface PCM
name 'Playback Channel Map'
value.0 0
value.1 0
value.2 0
value.3 0
value.4 0
value.5 0
value.6 0
value.7 0
comment {
access read
type INTEGER
count 8
range '0 - 36'
}
}
control.52 {
iface PCM
name 'Capture Channel Map'
value.0 0
value.1 0
comment {
access read
type INTEGER
count 2
range '0 - 36'
}
}
control.53 {
iface PCM
device 1
name 'Playback Channel Map'
value.0 0
value.1 0
comment {
access read
type INTEGER
count 2
range '0 - 36'
}
}
control.54 {
iface PCM
device 2
name 'Capture Channel Map'
value.0 0
value.1 0
comment {
access read
type INTEGER
count 2
range '0 - 36'
}
}
control.55 {
iface PCM
device 2
name 'Capture Channel Map'
index 1
value.0 0
value.1 0
comment {
access read
type INTEGER
count 2
range '0 - 36'
}
}
control.56 {
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
control.57 {
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
state.NVidia {
control.1 {
iface CARD
name 'HDMI/DP,pcm=3 Jack'
value false
comment {
access read
type BOOLEAN
count 1
}
}
control.2 {
iface MIXER
name 'IEC958 Playback Con Mask'
value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
comment {
access read
type IEC958
count 1
}
}
control.3 {
iface MIXER
name 'IEC958 Playback Pro Mask'
value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
comment {
access read
type IEC958
count 1
}
}
control.4 {
iface MIXER
name 'IEC958 Playback Default'
value '0482000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
comment {
access 'read write'
type IEC958
count 1
}
}
control.5 {
iface MIXER
name 'IEC958 Playback Switch'
value true
comment {
access 'read write'
type BOOLEAN
count 1
}
}
control.6 {
iface PCM
device 3
name ELD
value ''
comment {
access 'read volatile'
type BYTES
count 0
}
}
control.7 {
iface CARD
name 'HDMI/DP,pcm=7 Jack'
value false
comment {
access read
type BOOLEAN
count 1
}
}
control.8 {
iface MIXER
name 'IEC958 Playback Con Mask'
index 1
value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
comment {
access read
type IEC958
count 1
}
}
control.9 {
iface MIXER
name 'IEC958 Playback Pro Mask'
index 1
value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
comment {
access read
type IEC958
count 1
}
}
control.10 {
iface MIXER
name 'IEC958 Playback Default'
index 1
value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
comment {
access 'read write'
type IEC958
count 1
}
}
control.11 {
iface MIXER
name 'IEC958 Playback Switch'
index 1
value true
comment {
access 'read write'
type BOOLEAN
count 1
}
}
control.12 {
iface PCM
device 7
name ELD
value ''
comment {
access 'read volatile'
type BYTES
count 0
}
}
control.13 {
iface CARD
name 'HDMI/DP,pcm=8 Jack'
value false
comment {
access read
type BOOLEAN
count 1
}
}
control.14 {
iface MIXER
name 'IEC958 Playback Con Mask'
index 2
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
index 2
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
index 2
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
index 2
value true
comment {
access 'read write'
type BOOLEAN
count 1
}
}
control.18 {
iface PCM
device 8
name ELD
value ''
comment {
access 'read volatile'
type BYTES
count 0
}
}
control.19 {
iface CARD
name 'HDMI/DP,pcm=9 Jack'
value false
comment {
access read
type BOOLEAN
count 1
}
}
control.20 {
iface MIXER
name 'IEC958 Playback Con Mask'
index 3
value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
comment {
access read
type IEC958
count 1
}
}
control.21 {
iface MIXER
name 'IEC958 Playback Pro Mask'
index 3
value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
comment {
access read
type IEC958
count 1
}
}
control.22 {
iface MIXER
name 'IEC958 Playback Default'
index 3
value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
comment {
access 'read write'
type IEC958
count 1
}
}
control.23 {
iface MIXER
name 'IEC958 Playback Switch'
index 3
value true
comment {
access 'read write'
type BOOLEAN
count 1
}
}
control.24 {
iface PCM
device 9
name ELD
value ''
comment {
access 'read volatile'
type BYTES
count 0
}
}
control.25 {
iface PCM
device 3
name 'Playback Channel Map'
value.0 0
value.1 0
value.2 0
value.3 0
value.4 0
value.5 0
value.6 0
value.7 0
comment {
access 'read write'
type INTEGER
count 8
range '0 - 36'
}
}
control.26 {
iface PCM
device 7
name 'Playback Channel Map'
value.0 0
value.1 0
value.2 0
value.3 0
value.4 0
value.5 0
value.6 0
value.7 0
comment {
access 'read write'
type INTEGER
count 8
range '0 - 36'
}
}
control.27 {
iface PCM
device 8
name 'Playback Channel Map'
value.0 0
value.1 0
value.2 0
value.3 0
value.4 0
value.5 0
value.6 0
value.7 0
comment {
access 'read write'
type INTEGER
count 8
range '0 - 36'
}
}
control.28 {
iface PCM
device 9
name 'Playback Channel Map'
value.0 0
value.1 0
value.2 0
value.3 0
value.4 0
value.5 0
value.6 0
value.7 0
comment {
access 'read write'
type INTEGER
count 8
range '0 - 36'
}
}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
pci_stub
vboxpci
vboxnetadp
vboxnetflt
vboxdrv
snd_hda_codec_hdmi
hid_generic
usbhid
hid
rfcomm
bnep
parport_pc
bluetooth
ppdev
joydev
snd_hda_codec_realtek
xpad
ff_memless
snd_hda_intel
snd_hda_codec
snd_hwdep
snd_pcm
snd_page_alloc
nls_iso8859_1
snd_seq_midi
eeepc_wmi
asus_wmi
sparse_keymap
snd_seq_midi_event
snd_rawmidi
snd_seq
snd_seq_device
nouveau
psmouse
snd_timer
serio_raw
snd
mxm_wmi
ttm
drm_kms_helper
drm
lpc_ich
i2c_algo_bit
wmi
video
mac_hid
soundcore
mei_me
mei
lp
parport
usb_storage
ahci
libahci
e1000e
ptp
pps_core


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x11 0x99430140
0x12 0x411111f0
0x14 0x01014010
0x15 0x01011012
0x16 0x01016011
0x17 0x01012014
0x18 0x01a19850
0x19 0x02a19c60
0x1a 0x0181305f
0x1b 0x02214c20
0x1c 0x411111f0
0x1d 0x4007e629
0x1e 0x01451130
0x1f 0x411111f0

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D0/hints:

/sys/class/sound/hwC1D0/init_pin_configs:
0x04 0x185600f0
0x05 0x185600f0
0x06 0x185600f0
0x07 0x185600f0

/sys/class/sound/hwC1D0/driver_pin_configs:

/sys/class/sound/hwC1D0/user_pin_configs:

/sys/class/sound/hwC1D0/init_verbs:

/sys/class/sound/hwC1D0/hints:


!!ALSA/HDA dmesg
!!--------------

[    2.420876] usb 2-1.3: new full-speed USB device number 3 using ehci-pci
[    2.428149] snd_hda_intel 0000:00:1b.0: enabling device (0000 -> 0002)
[    2.428271] snd_hda_intel 0000:00:1b.0: irq 54 for MSI/MSI-X
[    2.441009] input: Microsoft X-Box 360 pad as
/devices/pci0000:00/0000:00:1c.4/0000:03:00.0/usb3/3-2/3-2:1.0/input/input3
--
[    2.445106] realtek: Enabling init ASM_ID=0x846b CODEC_ID=10ec0889
[    2.468021] input: HDA Intel PCH Front Headphone as
/devices/pci0000:00/0000:00:1b.0/sound/card0/input4
[    2.468197] input: HDA Intel PCH Line Out Side as
/devices/pci0000:00/0000:00:1b.0/sound/card0/input5
[    2.468305] input: HDA Intel PCH Line Out CLFE as
/devices/pci0000:00/0000:00:1b.0/sound/card0/input6
[    2.468419] input: HDA Intel PCH Line Out Surround as
/devices/pci0000:00/0000:00:1b.0/sound/card0/input7
[    2.468529] input: HDA Intel PCH Line Out Front as
/devices/pci0000:00/0000:00:1b.0/sound/card0/input8
[    2.468644] input: HDA Intel PCH Line as
/devices/pci0000:00/0000:00:1b.0/sound/card0/input9
[    2.468720] input: HDA Intel PCH Rear Mic as
/devices/pci0000:00/0000:00:1b.0/sound/card0/input10
[    2.468788] input: HDA Intel PCH Front Mic as
/devices/pci0000:00/0000:00:1b.0/sound/card0/input11
[    2.502287] init: avahi-cups-reload main process (1122) terminated
with status 1
--
[    2.592465] [drm] Initialized nouveau 1.1.1 20120801 for
0000:01:00.0 on minor 0
[    2.592525] snd_hda_intel 0000:01:00.1: enabling device (0000 -> 0002)
[    2.592581] hda_intel: Disabling MSI
[    2.592587] hda-intel 0000:01:00.1: Handle VGA-switcheroo audio client
[    2.592621] hda-intel 0000:01:00.1: Disabling 64bit DMA
[    2.593469] usb 2-1.4: new low-speed USB device number 4 using ehci-pci
[    2.599949] hda-intel 0000:01:00.1: Enable delay in RIRB handling
[    2.613131] usbcore: registered new interface driver usbhid
--
[    3.060378] sd 9:0:0:0: [sdd] Attached SCSI disk
[    3.093719] input: HDA NVidia HDMI/DP,pcm=9 as
/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input15
[    3.093814] input: HDA NVidia HDMI/DP,pcm=8 as
/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input16
[    3.093882] input: HDA NVidia HDMI/DP,pcm=7 as
/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input17
[    3.093948] input: HDA NVidia HDMI/DP,pcm=3 as
/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1/input18
[    3.190738] scsi 10:0:0:0: Direct-Access     WD       Ext HDD 1021
   2002 PQ: 0 ANSI: 4
--
[    4.633575] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    4.694338] hda-intel: IRQ timing workaround is activated for card
#1. Suggest a bigger bdl_pos_adj.

pulseverbose.log:

(   0.000|   0.000) I: [pulseaudio] main.c: setrlimit(RLIMIT_NICE,
(31, 31)) failed: Operation not permitted
(   0.000|   0.000) I: [pulseaudio] main.c: setrlimit(RLIMIT_RTPRIO,
(9, 9)) failed: Operation not permitted
(   0.000|   0.000) D: [pulseaudio] core-rtclock.c: Timer slack is set to 50 us.
(   0.003|   0.003) D: [pulseaudio] core-util.c: RealtimeKit worked.
(   0.003|   0.000) I: [pulseaudio] core-util.c: Successfully gained
nice level -11.
(   0.003|   0.000) I: [pulseaudio] main.c: This is PulseAudio 3.0
(   0.003|   0.000) D: [pulseaudio] main.c: Compilation host:
x86_64-pc-linux-gnu
(   0.003|   0.000) D: [pulseaudio] main.c: Compilation CFLAGS: -g -O2
-fstack-protector --param=ssp-buffer-size=4 -Wformat
-Werror=format-security -Wall -W -Wextra -pipe -Wno-long-long
-Wno-overlength-strings -Wunsafe-loop-optimizations -Wundef -Wformat=2
-Wlogical-op -Wsign-compare -Wformat-security -Wmissing-include-dirs
-Wformat-nonliteral -Wpointer-arith -Winit-self
-Wdeclaration-after-statement -Wfloat-equal -Wmissing-prototypes
-Wredundant-decls -Wmissing-declarations -Wmissing-noreturn -Wshadow
-Wendif-labels -Wcast-align -Wstrict-aliasing -Wwrite-strings
-Wno-unused-parameter -ffast-math -Wp,-D_FORTIFY_SOURCE=2 -fno-common
-fdiagnostics-show-option
(   0.003|   0.000) D: [pulseaudio] main.c: Running on host: Linux
x86_64 3.11.0-031100rc2-generic #201307211535 SMP Sun Jul 21 19:36:42
UTC 2013
(   0.003|   0.000) D: [pulseaudio] main.c: Found 4 CPUs.
(   0.003|   0.000) I: [pulseaudio] main.c: Page size is 4096 bytes
(   0.003|   0.000) D: [pulseaudio] main.c: Compiled with Valgrind support: no
(   0.003|   0.000) D: [pulseaudio] main.c: Running in valgrind mode: no
(   0.003|   0.000) D: [pulseaudio] main.c: Running in VM: no
(   0.003|   0.000) D: [pulseaudio] main.c: Optimized build: yes
(   0.003|   0.000) D: [pulseaudio] main.c: FASTPATH defined, only
fast path asserts disabled.
(   0.003|   0.000) I: [pulseaudio] main.c: Machine ID is
7bd695a64b57f140878196e351d1dc20.
(   0.003|   0.000) I: [pulseaudio] main.c: Using runtime directory
/run/user/vincent/pulse.
(   0.003|   0.000) I: [pulseaudio] main.c: Using state directory
/home/vincent/.config/pulse.
(   0.003|   0.000) I: [pulseaudio] main.c: Using modules directory
/usr/lib/pulse-3.0/modules.
(   0.003|   0.000) I: [pulseaudio] main.c: Running in system mode: no
(   0.003|   0.000) I: [pulseaudio] main.c: Fresh high-resolution
timers available! Bon appetit!
(   0.004|   0.000) D: [pulseaudio] memblock.c: Using shared memory
pool with 1024 slots of size 64.0 KiB each, total size is 64.0 MiB,
maximum usable slot size is 65472
(   0.004|   0.000) I: [pulseaudio] cpu-x86.c: CPU flags: CMOV MMX SSE
SSE2 SSE3 SSSE3 SSE4_1 SSE4_2
(   0.004|   0.000) I: [pulseaudio] svolume_mmx.c: Initialising MMX
optimized volume functions.
(   0.004|   0.000) I: [pulseaudio] remap_mmx.c: Initialising MMX
optimized remappers.
(   0.004|   0.000) I: [pulseaudio] svolume_sse.c: Initialising SSE2
optimized volume functions.
(   0.004|   0.000) I: [pulseaudio] remap_sse.c: Initialising SSE2
optimized remappers.
(   0.004|   0.000) I: [pulseaudio] sconv_sse.c: Initialising SSE2
optimized conversions.
(   0.004|   0.000) I: [pulseaudio] svolume_orc.c: Initialising ORC
optimized volume functions.
(   0.004|   0.000) D: [pulseaudio] database-tdb.c: Opened TDB
database '/home/vincent/.config/pulse/7bd695a64b57f140878196e351d1dc20-device-volumes.tdb'
(   0.004|   0.000) I: [pulseaudio] module-device-restore.c:
Successfully opened database file
'/home/vincent/.config/pulse/7bd695a64b57f140878196e351d1dc20-device-volumes'.
(   0.004|   0.000) I: [pulseaudio] module.c: Loaded
"module-device-restore" (index: #0; argument: "").
(   0.004|   0.000) D: [pulseaudio] database-tdb.c: Opened TDB
database '/home/vincent/.config/pulse/7bd695a64b57f140878196e351d1dc20-stream-volumes.tdb'
(   0.004|   0.000) I: [pulseaudio] module-stream-restore.c:
Successfully opened database file
'/home/vincent/.config/pulse/7bd695a64b57f140878196e351d1dc20-stream-volumes'.
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1 added for object
/org/pulseaudio/stream_restore1
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry0
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry1
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry2
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry3
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry4
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry5
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry6
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry7
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry8
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry9
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry10
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry11
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry12
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry13
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry14
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry15
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry16
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry17
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry18
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry19
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry20
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry21
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry22
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry23
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry24
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry25
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry26
(   0.005|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry added for object
/org/pulseaudio/stream_restore1/entry27
(   0.005|   0.000) I: [pulseaudio] module.c: Loaded
"module-stream-restore" (index: #1; argument: "").
(   0.005|   0.000) D: [pulseaudio] database-tdb.c: Opened TDB
database '/home/vincent/.config/pulse/7bd695a64b57f140878196e351d1dc20-card-database.tdb'
(   0.005|   0.000) I: [pulseaudio] module-card-restore.c:
Successfully opened database file
'/home/vincent/.config/pulse/7bd695a64b57f140878196e351d1dc20-card-database'.
(   0.005|   0.000) I: [pulseaudio] module.c: Loaded
"module-card-restore" (index: #2; argument: "").
(   0.006|   0.000) I: [pulseaudio] module.c: Loaded
"module-augment-properties" (index: #3; argument: "").
(   0.006|   0.000) D: [pulseaudio] cli-command.c: Checking for
existence of '/usr/lib/pulse-3.0/modules/module-udev-detect.so':
success
(   0.006|   0.000) D: [pulseaudio] module-udev-detect.c:
/dev/snd/controlC1 is accessible: yes
(   0.006|   0.000) D: [pulseaudio] module-udev-detect.c:
/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1 is busy: no
(   0.006|   0.000) D: [pulseaudio] module-udev-detect.c: Loading
module-alsa-card with arguments 'device_id="1" name="pci-0000_01_00.1"
card_name="alsa_card.pci-0000_01_00.1" namereg_fail=false tsched=no
fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes
card_properties="module-udev-detect.discovered=1"'
(   0.008|   0.001) D: [pulseaudio] dbus-util.c: Successfully
connected to D-Bus session bus 8923dc8a05563d0ffe2f214c51ed7550 as
:1.110
(   0.008|   0.000) D: [pulseaudio] reserve-wrap.c: Successfully
acquired reservation lock on device 'Audio1'
(   0.008|   0.000) I: [pulseaudio] (alsa-lib)utils.c: could not open
configuration file /usr/share/alsa/ucm/HDA NVidia/HDA NVidia.conf
(   0.008|   0.000) I: [pulseaudio] (alsa-lib)parser.c: error: could
not parse configuration for card HDA NVidia
(   0.008|   0.000) I: [pulseaudio] (alsa-lib)main.c: error: failed to
import HDA NVidia use case configuration -2
(   0.008|   0.000) I: [pulseaudio] alsa-ucm.c: UCM not available for
card HDA NVidia
(   0.009|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
input:analog-mono
(   0.009|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
recording on Analog Mono (analog-mono)
(   0.009|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:1 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.009|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open
'/dev/snd/pcmC1D0c' failed (-2)
(   0.009|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device hw:1: No such file or directory
(   0.010|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open input:analog-mono
(   0.010|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
input:analog-stereo
(   0.010|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
recording on Analog Stereo (analog-stereo)
(   0.010|   0.000) D: [pulseaudio] alsa-util.c: Trying front:1 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.011|   0.001) I: [pulseaudio] (alsa-lib)pcm_hw.c: open
'/dev/snd/pcmC1D0c' failed (-2)
(   0.011|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device front:1: No such file or directory
(   0.011|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:1 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.011|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open
'/dev/snd/pcmC1D0c' failed (-2)
(   0.011|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device hw:1: No such file or directory
(   0.011|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open input:analog-stereo
(   0.011|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
input:iec958-stereo
(   0.011|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
recording on Digital Stereo (IEC958) (iec958-stereo)
(   0.011|   0.000) D: [pulseaudio] alsa-util.c: Trying iec958:1 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.011|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open
'/dev/snd/pcmC1D1c' failed (-2)
(   0.011|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device iec958:1: No such file or directory
(   0.011|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open input:iec958-stereo
(   0.011|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:analog-mono
(   0.011|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Analog Mono (analog-mono)
(   0.011|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:1 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.011|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open
'/dev/snd/pcmC1D0p' failed (-2)
(   0.011|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device hw:1: No such file or directory
(   0.011|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:analog-mono
(   0.011|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-mono+input:analog-mono - will not be able to open
output:analog-mono
(   0.011|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-mono+input:analog-stereo - will not be able to open
output:analog-mono
(   0.011|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-mono+input:iec958-stereo - will not be able to open
output:analog-mono
(   0.011|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:analog-stereo
(   0.011|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Analog Stereo (analog-stereo)
(   0.011|   0.000) D: [pulseaudio] alsa-util.c: Trying front:1 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.011|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open
'/dev/snd/pcmC1D0p' failed (-2)
(   0.011|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device front:1: No such file or directory
(   0.011|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:1 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.011|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open
'/dev/snd/pcmC1D0p' failed (-2)
(   0.011|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device hw:1: No such file or directory
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:analog-stereo
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-stereo+input:analog-mono - will not be able to open
output:analog-stereo
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-stereo+input:analog-stereo - will not be able to open
output:analog-stereo
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-stereo+input:iec958-stereo - will not be able to open
output:analog-stereo
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:analog-surround-40
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Analog Surround 4.0 (analog-surround-40)
(   0.012|   0.000) D: [pulseaudio] alsa-util.c: Trying surround40:1
with SND_PCM_NO_AUTO_FORMAT ...
(   0.012|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open
'/dev/snd/pcmC1D0p' failed (-2)
(   0.012|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device surround40:1: No such file or directory
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:analog-surround-40
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-40+input:analog-mono - will not be able to open
output:analog-surround-40
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-40+input:analog-stereo - will not be able to
open output:analog-surround-40
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-40+input:iec958-stereo - will not be able to
open output:analog-surround-40
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:analog-surround-41
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Analog Surround 4.1 (analog-surround-41)
(   0.012|   0.000) D: [pulseaudio] alsa-util.c: Trying surround41:1
with SND_PCM_NO_AUTO_FORMAT ...
(   0.012|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open
'/dev/snd/pcmC1D0p' failed (-2)
(   0.012|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device surround41:1: No such file or directory
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:analog-surround-41
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-41+input:analog-mono - will not be able to open
output:analog-surround-41
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-41+input:analog-stereo - will not be able to
open output:analog-surround-41
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-41+input:iec958-stereo - will not be able to
open output:analog-surround-41
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:analog-surround-50
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Analog Surround 5.0 (analog-surround-50)
(   0.012|   0.000) D: [pulseaudio] alsa-util.c: Trying surround50:1
with SND_PCM_NO_AUTO_FORMAT ...
(   0.012|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open
'/dev/snd/pcmC1D0p' failed (-2)
(   0.012|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device surround50:1: No such file or directory
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:analog-surround-50
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-50+input:analog-mono - will not be able to open
output:analog-surround-50
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-50+input:analog-stereo - will not be able to
open output:analog-surround-50
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-50+input:iec958-stereo - will not be able to
open output:analog-surround-50
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:analog-surround-51
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Analog Surround 5.1 (analog-surround-51)
(   0.012|   0.000) D: [pulseaudio] alsa-util.c: Trying surround51:1
with SND_PCM_NO_AUTO_FORMAT ...
(   0.012|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open
'/dev/snd/pcmC1D0p' failed (-2)
(   0.012|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device surround51:1: No such file or directory
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:analog-surround-51
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-51+input:analog-mono - will not be able to open
output:analog-surround-51
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-51+input:analog-stereo - will not be able to
open output:analog-surround-51
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-51+input:iec958-stereo - will not be able to
open output:analog-surround-51
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:analog-surround-71
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Analog Surround 7.1 (analog-surround-71)
(   0.012|   0.000) D: [pulseaudio] alsa-util.c: Trying surround71:1
with SND_PCM_NO_AUTO_FORMAT ...
(   0.012|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open
'/dev/snd/pcmC1D0p' failed (-2)
(   0.012|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device surround71:1: No such file or directory
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:analog-surround-71
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-71+input:analog-mono - will not be able to open
output:analog-surround-71
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-71+input:analog-stereo - will not be able to
open output:analog-surround-71
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-71+input:iec958-stereo - will not be able to
open output:analog-surround-71
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:iec958-stereo
(   0.012|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Stereo (IEC958) (iec958-stereo)
(   0.012|   0.000) D: [pulseaudio] alsa-util.c: Trying iec958:1 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.013|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open
'/dev/snd/pcmC1D1p' failed (-2)
(   0.013|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device iec958:1: No such file or directory
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:iec958-stereo
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-stereo+input:analog-mono - will not be able to open
output:iec958-stereo
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-stereo+input:analog-stereo - will not be able to open
output:iec958-stereo
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-stereo+input:iec958-stereo - will not be able to open
output:iec958-stereo
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:iec958-ac3-surround-40
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Surround 4.0 (IEC958/AC3) (iec958-ac3-surround-40)
(   0.013|   0.000) D: [pulseaudio] alsa-util.c: Trying a52:1 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.013|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM a52:1
(   0.013|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device a52:1: No such file or directory
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:iec958-ac3-surround-40
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-ac3-surround-40+input:analog-mono - will not be able to
open output:iec958-ac3-surround-40
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-ac3-surround-40+input:analog-stereo - will not be able
to open output:iec958-ac3-surround-40
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-ac3-surround-40+input:iec958-stereo - will not be able
to open output:iec958-ac3-surround-40
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:iec958-ac3-surround-51
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Surround 5.1 (IEC958/AC3) (iec958-ac3-surround-51)
(   0.013|   0.000) D: [pulseaudio] alsa-util.c: Trying a52:1 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.013|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM a52:1
(   0.013|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device a52:1: No such file or directory
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:iec958-ac3-surround-51
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-ac3-surround-51+input:analog-mono - will not be able to
open output:iec958-ac3-surround-51
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-ac3-surround-51+input:analog-stereo - will not be able
to open output:iec958-ac3-surround-51
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-ac3-surround-51+input:iec958-stereo - will not be able
to open output:iec958-ac3-surround-51
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:iec958-dts-surround-51
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Surround 5.1 (IEC958/DTS) (iec958-dts-surround-51)
(   0.013|   0.000) D: [pulseaudio] alsa-util.c: Trying dca:1 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.013|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dca:1
(   0.013|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device dca:1: No such file or directory
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:iec958-dts-surround-51
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-dts-surround-51+input:analog-mono - will not be able to
open output:iec958-dts-surround-51
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-dts-surround-51+input:analog-stereo - will not be able
to open output:iec958-dts-surround-51
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-dts-surround-51+input:iec958-stereo - will not be able
to open output:iec958-dts-surround-51
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:hdmi-stereo
(   0.013|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Stereo (HDMI) (hdmi-stereo)
(   0.013|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.013|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1
(   0.013|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 371 ms
(   0.029|   0.016) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   0.045|   0.016) D: [pulseaudio] alsa-mixer.c: Profile
output:hdmi-stereo supported.
(   0.045|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL hdmi:1
(   0.045|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to
mixer hdmi:1: No such file or directory
(   0.046|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached
to mixer 'hw:1'
(   0.046|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'hdmi-output-0'
(   0.046|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack
'HDMI/DP,pcm=3 Jack' succeeded (found!)
(   0.046|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer
paths (after tidying):
(   0.046|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xc7ab50, direction=1
(   0.046|   0.000) D: [pulseaudio] alsa-mixer.c: Path hdmi-output-0
(HDMI / DisplayPort), direction=1, priority=59, probed=yes,
supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0,
max_volume=0, min_dB=inf, max_dB=-inf
(   0.046|   0.000) D: [pulseaudio] alsa-mixer.c: Jack HDMI/DP,pcm=3,
alsa_name='HDMI/DP,pcm=3 Jack', detection possible
(   0.046|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo+input:analog-mono - will not be able to open
input:analog-mono
(   0.046|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo+input:analog-stereo - will not be able to open
input:analog-stereo
(   0.046|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo+input:iec958-stereo - will not be able to open
input:iec958-stereo
(   0.046|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:hdmi-surround
(   0.046|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Surround 5.1 (HDMI) (hdmi-surround)
(   0.046|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.046|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1
(   0.046|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 123 ms
(   0.077|   0.031) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   0.093|   0.016) D: [pulseaudio] alsa-mixer.c: Profile
output:hdmi-surround supported.
(   0.093|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL hdmi:1
(   0.093|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to
mixer hdmi:1: No such file or directory
(   0.093|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached
to mixer 'hw:1'
(   0.094|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer
paths (after tidying):
(   0.094|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xc8cce0, direction=1
(   0.094|   0.000) D: [pulseaudio] alsa-mixer.c: Path hdmi-output-0
(HDMI / DisplayPort), direction=1, priority=59, probed=yes,
supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0,
max_volume=0, min_dB=inf, max_dB=-inf
(   0.094|   0.000) D: [pulseaudio] alsa-mixer.c: Jack HDMI/DP,pcm=3,
alsa_name='HDMI/DP,pcm=3 Jack', detection possible
(   0.094|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround+input:analog-mono - will not be able to open
input:analog-mono
(   0.094|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround+input:analog-stereo - will not be able to open
input:analog-stereo
(   0.094|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround+input:iec958-stereo - will not be able to open
input:iec958-stereo
(   0.094|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:hdmi-stereo-extra1
(   0.094|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Stereo (HDMI) (hdmi-stereo-extra1)
(   0.094|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,1 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.094|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1,1
(   0.094|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 371 ms
(   0.125|   0.031) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   0.141|   0.015) D: [pulseaudio] alsa-mixer.c: Profile
output:hdmi-stereo-extra1 supported.
(   0.141|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL hdmi:1,1
(   0.141|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to
mixer hdmi:1,1: No such file or directory
(   0.142|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached
to mixer 'hw:1'
(   0.142|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'hdmi-output-1'
(   0.142|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack
'HDMI/DP,pcm=7 Jack' succeeded (found!)
(   0.142|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer
paths (after tidying):
(   0.142|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xc8ef10, direction=1
(   0.142|   0.000) D: [pulseaudio] alsa-mixer.c: Path hdmi-output-1
(HDMI / DisplayPort 2), direction=1, priority=58, probed=yes,
supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0,
max_volume=0, min_dB=inf, max_dB=-inf
(   0.142|   0.000) D: [pulseaudio] alsa-mixer.c: Jack HDMI/DP,pcm=7,
alsa_name='HDMI/DP,pcm=7 Jack', detection possible
(   0.142|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo-extra1+input:analog-mono - will not be able to open
input:analog-mono
(   0.142|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo-extra1+input:analog-stereo - will not be able to
open input:analog-stereo
(   0.142|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo-extra1+input:iec958-stereo - will not be able to
open input:iec958-stereo
(   0.142|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:hdmi-surround-extra1
(   0.142|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Surround 5.1 (HDMI) (hdmi-surround-extra1)
(   0.142|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,1 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.142|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1,1
(   0.142|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 123 ms
(   0.173|   0.031) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   0.189|   0.015) D: [pulseaudio] alsa-mixer.c: Profile
output:hdmi-surround-extra1 supported.
(   0.189|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL hdmi:1,1
(   0.189|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to
mixer hdmi:1,1: No such file or directory
(   0.189|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached
to mixer 'hw:1'
(   0.190|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer
paths (after tidying):
(   0.190|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xcb2960, direction=1
(   0.190|   0.000) D: [pulseaudio] alsa-mixer.c: Path hdmi-output-1
(HDMI / DisplayPort 2), direction=1, priority=58, probed=yes,
supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0,
max_volume=0, min_dB=inf, max_dB=-inf
(   0.190|   0.000) D: [pulseaudio] alsa-mixer.c: Jack HDMI/DP,pcm=7,
alsa_name='HDMI/DP,pcm=7 Jack', detection possible
(   0.190|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround-extra1+input:analog-mono - will not be able to
open input:analog-mono
(   0.190|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround-extra1+input:analog-stereo - will not be able to
open input:analog-stereo
(   0.190|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround-extra1+input:iec958-stereo - will not be able to
open input:iec958-stereo
(   0.190|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:hdmi-stereo-extra2
(   0.190|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Stereo (HDMI) (hdmi-stereo-extra2)
(   0.190|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,2 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.190|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1,2
(   0.190|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 371 ms
(   0.221|   0.031) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   0.237|   0.015) D: [pulseaudio] alsa-mixer.c: Profile
output:hdmi-stereo-extra2 supported.
(   0.237|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL hdmi:1,2
(   0.237|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to
mixer hdmi:1,2: No such file or directory
(   0.238|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached
to mixer 'hw:1'
(   0.238|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'hdmi-output-2'
(   0.238|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack
'HDMI/DP,pcm=8 Jack' succeeded (found!)
(   0.238|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer
paths (after tidying):
(   0.238|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xcb2d80, direction=1
(   0.238|   0.000) D: [pulseaudio] alsa-mixer.c: Path hdmi-output-2
(HDMI / DisplayPort 3), direction=1, priority=57, probed=yes,
supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0,
max_volume=0, min_dB=inf, max_dB=-inf
(   0.238|   0.000) D: [pulseaudio] alsa-mixer.c: Jack HDMI/DP,pcm=8,
alsa_name='HDMI/DP,pcm=8 Jack', detection possible
(   0.238|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo-extra2+input:analog-mono - will not be able to open
input:analog-mono
(   0.238|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo-extra2+input:analog-stereo - will not be able to
open input:analog-stereo
(   0.238|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo-extra2+input:iec958-stereo - will not be able to
open input:iec958-stereo
(   0.238|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:hdmi-surround-extra2
(   0.238|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Surround 5.1 (HDMI) (hdmi-surround-extra2)
(   0.238|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,2 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.238|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1,2
(   0.238|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 123 ms
(   0.269|   0.031) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   0.285|   0.016) D: [pulseaudio] alsa-mixer.c: Profile
output:hdmi-surround-extra2 supported.
(   0.285|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL hdmi:1,2
(   0.285|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to
mixer hdmi:1,2: No such file or directory
(   0.285|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached
to mixer 'hw:1'
(   0.285|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer
paths (after tidying):
(   0.286|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xcb4f20, direction=1
(   0.286|   0.000) D: [pulseaudio] alsa-mixer.c: Path hdmi-output-2
(HDMI / DisplayPort 3), direction=1, priority=57, probed=yes,
supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0,
max_volume=0, min_dB=inf, max_dB=-inf
(   0.286|   0.000) D: [pulseaudio] alsa-mixer.c: Jack HDMI/DP,pcm=8,
alsa_name='HDMI/DP,pcm=8 Jack', detection possible
(   0.286|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround-extra2+input:analog-mono - will not be able to
open input:analog-mono
(   0.286|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround-extra2+input:analog-stereo - will not be able to
open input:analog-stereo
(   0.286|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround-extra2+input:iec958-stereo - will not be able to
open input:iec958-stereo
(   0.286|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:hdmi-stereo-extra3
(   0.286|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Stereo (HDMI) (hdmi-stereo-extra3)
(   0.286|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,3 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.286|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1,3
(   0.286|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 371 ms
(   0.317|   0.031) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   0.333|   0.016) D: [pulseaudio] alsa-mixer.c: Profile
output:hdmi-stereo-extra3 supported.
(   0.333|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL hdmi:1,3
(   0.333|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to
mixer hdmi:1,3: No such file or directory
(   0.334|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached
to mixer 'hw:1'
(   0.334|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'hdmi-output-3'
(   0.334|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack
'HDMI/DP,pcm=9 Jack' succeeded (found!)
(   0.334|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer
paths (after tidying):
(   0.334|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xc190e0, direction=1
(   0.334|   0.000) D: [pulseaudio] alsa-mixer.c: Path hdmi-output-3
(HDMI / DisplayPort 4), direction=1, priority=56, probed=yes,
supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0,
max_volume=0, min_dB=inf, max_dB=-inf
(   0.334|   0.000) D: [pulseaudio] alsa-mixer.c: Jack HDMI/DP,pcm=9,
alsa_name='HDMI/DP,pcm=9 Jack', detection possible
(   0.334|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo-extra3+input:analog-mono - will not be able to open
input:analog-mono
(   0.334|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo-extra3+input:analog-stereo - will not be able to
open input:analog-stereo
(   0.334|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo-extra3+input:iec958-stereo - will not be able to
open input:iec958-stereo
(   0.334|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:hdmi-surround-extra3
(   0.334|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Surround 5.1 (HDMI) (hdmi-surround-extra3)
(   0.334|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,3 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.334|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1,3
(   0.334|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 123 ms
(   0.365|   0.031) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   0.381|   0.016) D: [pulseaudio] alsa-mixer.c: Profile
output:hdmi-surround-extra3 supported.
(   0.381|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL hdmi:1,3
(   0.381|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to
mixer hdmi:1,3: No such file or directory
(   0.381|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached
to mixer 'hw:1'
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer
paths (after tidying):
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xcb53c0, direction=1
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Path hdmi-output-3
(HDMI / DisplayPort 4), direction=1, priority=56, probed=yes,
supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0,
max_volume=0, min_dB=inf, max_dB=-inf
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Jack HDMI/DP,pcm=9,
alsa_name='HDMI/DP,pcm=9 Jack', detection possible
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround-extra3+input:analog-mono - will not be able to
open input:analog-mono
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround-extra3+input:analog-stereo - will not be able to
open input:analog-stereo
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround-extra3+input:iec958-stereo - will not be able to
open input:iec958-stereo
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Profile set
0xc26dc0, auto_profiles=yes, probed=yes, n_mappings=8, n_profiles=8,
n_decibel_fixes=0
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping hdmi-stereo
(Digital Stereo (HDMI)), priority=54,
channel_map=front-left,front-right, supported=yes, direction=1
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping
hdmi-surround (Digital Surround 5.1 (HDMI)), priority=3,
channel_map=front-left,front-right,rear-left,rear-right,front-center,lfe,
supported=yes, direction=1
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping
hdmi-stereo-extra1 (Digital Stereo (HDMI)), priority=52,
channel_map=front-left,front-right, supported=yes, direction=1
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping
hdmi-surround-extra1 (Digital Surround 5.1 (HDMI)), priority=1,
channel_map=front-left,front-right,rear-left,rear-right,front-center,lfe,
supported=yes, direction=1
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping
hdmi-stereo-extra2 (Digital Stereo (HDMI)), priority=52,
channel_map=front-left,front-right, supported=yes, direction=1
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping
hdmi-surround-extra2 (Digital Surround 5.1 (HDMI)), priority=1,
channel_map=front-left,front-right,rear-left,rear-right,front-center,lfe,
supported=yes, direction=1
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping
hdmi-stereo-extra3 (Digital Stereo (HDMI)), priority=52,
channel_map=front-left,front-right, supported=yes, direction=1
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping
hdmi-surround-extra3 (Digital Surround 5.1 (HDMI)), priority=1,
channel_map=front-left,front-right,rear-left,rear-right,front-center,lfe,
supported=yes, direction=1
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:hdmi-stereo (Digital Stereo (HDMI) Output), priority=5400,
supported=yes n_input_mappings=0, n_output_mappings=1
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Output hdmi-stereo
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:hdmi-surround (Digital Surround 5.1 (HDMI) Output),
priority=300, supported=yes n_input_mappings=0, n_output_mappings=1
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Output hdmi-surround
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:hdmi-stereo-extra1 (Digital Stereo (HDMI) Output),
priority=5200, supported=yes n_input_mappings=0, n_output_mappings=1
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Output hdmi-stereo-extra1
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:hdmi-surround-extra1 (Digital Surround 5.1 (HDMI) Output),
priority=100, supported=yes n_input_mappings=0, n_output_mappings=1
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Output hdmi-surround-extra1
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:hdmi-stereo-extra2 (Digital Stereo (HDMI) Output),
priority=5200, supported=yes n_input_mappings=0, n_output_mappings=1
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Output hdmi-stereo-extra2
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:hdmi-surround-extra2 (Digital Surround 5.1 (HDMI) Output),
priority=100, supported=yes n_input_mappings=0, n_output_mappings=1
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Output hdmi-surround-extra2
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:hdmi-stereo-extra3 (Digital Stereo (HDMI) Output),
priority=5200, supported=yes n_input_mappings=0, n_output_mappings=1
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Output hdmi-stereo-extra3
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:hdmi-surround-extra3 (Digital Surround 5.1 (HDMI) Output),
priority=100, supported=yes n_input_mappings=0, n_output_mappings=1
(   0.382|   0.000) D: [pulseaudio] alsa-mixer.c: Output hdmi-surround-extra3
(   0.382|   0.000) I: [pulseaudio] module-card-restore.c: Restoring
profile for card alsa_card.pci-0000_01_00.1.
(   0.382|   0.000) I: [pulseaudio] module-card-restore.c: Restoring
port latency offsets for card alsa_card.pci-0000_01_00.1.
(   0.382|   0.000) I: [pulseaudio] card.c: Created 0
"alsa_card.pci-0000_01_00.1"
(   0.382|   0.000) D: [pulseaudio] reserve-wrap.c: Successfully
create reservation lock monitor for device 'Audio1'
(   0.383|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:1,1 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.383|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hdmi:1,1
(   0.383|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 371 ms
(   0.413|   0.030) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   0.429|   0.015) I: [pulseaudio] alsa-sink.c: Successfully opened
device hdmi:1,1.
(   0.429|   0.000) I: [pulseaudio] alsa-sink.c: Selected mapping
'Digital Stereo (HDMI)' (hdmi-stereo-extra1).
(   0.429|   0.000) I: [pulseaudio] alsa-sink.c: Successfully enabled
mmap() mode.
(   0.429|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL hdmi:1,1
(   0.429|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to
mixer hdmi:1,1: No such file or directory
(   0.430|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached
to mixer 'hw:1'
(   0.430|   0.000) D: [pulseaudio] alsa-mixer.c: Added 1 ports
(   0.430|   0.000) D: [pulseaudio] module-device-restore.c: Database
contains invalid data for key:
sink:alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1:null
(   0.430|   0.000) I: [pulseaudio] sink.c: Created sink 0
"alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1" with sample spec
s16le 2ch 44100Hz and channel map front-left,front-right
(   0.430|   0.000) I: [pulseaudio] sink.c:     alsa.resolution_bits = "16"
(   0.430|   0.000) I: [pulseaudio] sink.c:     device.api = "alsa"
(   0.430|   0.000) I: [pulseaudio] sink.c:     device.class = "sound"
(   0.430|   0.000) I: [pulseaudio] sink.c:     alsa.class = "generic"
(   0.430|   0.000) I: [pulseaudio] sink.c:     alsa.subclass = "generic-mix"
(   0.430|   0.000) I: [pulseaudio] sink.c:     alsa.name = "HDMI 1"
(   0.430|   0.000) I: [pulseaudio] sink.c:     alsa.id = "HDMI 1"
(   0.430|   0.000) I: [pulseaudio] sink.c:     alsa.subdevice = "0"
(   0.430|   0.000) I: [pulseaudio] sink.c:     alsa.subdevice_name =
"subdevice #0"
(   0.430|   0.000) I: [pulseaudio] sink.c:     alsa.device = "7"
(   0.430|   0.000) I: [pulseaudio] sink.c:     alsa.card = "1"
(   0.430|   0.000) I: [pulseaudio] sink.c:     alsa.card_name = "HDA NVidia"
(   0.430|   0.000) I: [pulseaudio] sink.c:     alsa.long_card_name =
"HDA NVidia at 0xf7080000 irq 17"
(   0.430|   0.000) I: [pulseaudio] sink.c:     alsa.driver_name =
"snd_hda_intel"
(   0.430|   0.000) I: [pulseaudio] sink.c:     device.bus_path =
"pci-0000:01:00.1"
(   0.430|   0.000) I: [pulseaudio] sink.c:     sysfs.path =
"/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1"
(   0.430|   0.000) I: [pulseaudio] sink.c:     device.bus = "pci"
(   0.430|   0.000) I: [pulseaudio] sink.c:     device.vendor.id = "10de"
(   0.430|   0.000) I: [pulseaudio] sink.c:     device.vendor.name =
"NVIDIA Corporation"
(   0.430|   0.000) I: [pulseaudio] sink.c:     device.string = "hdmi:1,1"
(   0.430|   0.000) I: [pulseaudio] sink.c:
device.buffering.buffer_size = "8064"
(   0.430|   0.000) I: [pulseaudio] sink.c:
device.buffering.fragment_size = "2688"
(   0.430|   0.000) I: [pulseaudio] sink.c:     device.access_mode = "mmap"
(   0.430|   0.000) I: [pulseaudio] sink.c:     device.profile.name =
"hdmi-stereo-extra1"
(   0.430|   0.000) I: [pulseaudio] sink.c:
device.profile.description = "Digital Stereo (HDMI)"
(   0.430|   0.000) I: [pulseaudio] sink.c:     device.description =
"HDA NVidia Digital Stereo (HDMI)"
(   0.430|   0.000) I: [pulseaudio] sink.c:     alsa.mixer_name =
"Nvidia GPU 41 HDMI/DP"
(   0.430|   0.000) I: [pulseaudio] sink.c:     alsa.components =
"HDA:10de0041,10438422,00100100"
(   0.430|   0.000) I: [pulseaudio] sink.c:
module-udev-detect.discovered = "1"
(   0.430|   0.000) I: [pulseaudio] sink.c:     device.icon_name =
"audio-card-pci"
(   0.430|   0.000) D: [pulseaudio] core-subscribe.c: Dropped
redundant event due to change event.
(   0.430|   0.000) I: [pulseaudio] source.c: Created source 0
"alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1.monitor" with sample
spec s16le 2ch 44100Hz and channel map front-left,front-right
(   0.430|   0.000) I: [pulseaudio] source.c:     device.description =
"Monitor of HDA NVidia Digital Stereo (HDMI)"
(   0.430|   0.000) I: [pulseaudio] source.c:     device.class = "monitor"
(   0.430|   0.000) I: [pulseaudio] source.c:     alsa.card = "1"
(   0.430|   0.000) I: [pulseaudio] source.c:     alsa.card_name = "HDA NVidia"
(   0.430|   0.000) I: [pulseaudio] source.c:     alsa.long_card_name
= "HDA NVidia at 0xf7080000 irq 17"
(   0.430|   0.000) I: [pulseaudio] source.c:     alsa.driver_name =
"snd_hda_intel"
(   0.430|   0.000) I: [pulseaudio] source.c:     device.bus_path =
"pci-0000:01:00.1"
(   0.430|   0.000) I: [pulseaudio] source.c:     sysfs.path =
"/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1"
(   0.430|   0.000) I: [pulseaudio] source.c:     device.bus = "pci"
(   0.430|   0.000) I: [pulseaudio] source.c:     device.vendor.id = "10de"
(   0.430|   0.000) I: [pulseaudio] source.c:     device.vendor.name =
"NVIDIA Corporation"
(   0.430|   0.000) I: [pulseaudio] source.c:     device.string = "1"
(   0.430|   0.000) I: [pulseaudio] source.c:
module-udev-detect.discovered = "1"
(   0.430|   0.000) I: [pulseaudio] source.c:     device.icon_name =
"audio-card-pci"
(   0.430|   0.000) I: [pulseaudio] alsa-sink.c: Using 3.0 fragments
of size 2688 bytes (15.24ms), buffer size is 8064 bytes (45.71ms)
(   0.430|   0.000) D: [pulseaudio] alsa-sink.c: hwbuf_unused=0
(   0.430|   0.000) D: [pulseaudio] alsa-sink.c: setting avail_min=1
(   0.430|   0.000) D: [pulseaudio] alsa-mixer.c: Activating path hdmi-output-1
(   0.430|   0.000) D: [pulseaudio] alsa-mixer.c: Path hdmi-output-1
(HDMI / DisplayPort 2), direction=1, priority=58, probed=yes,
supported=yes, has_mute=no, has_volume=no, has_dB=no, min_volume=0,
max_volume=0, min_dB=inf, max_dB=-inf
(   0.430|   0.000) D: [pulseaudio] alsa-mixer.c: Jack HDMI/DP,pcm=7,
alsa_name='HDMI/DP,pcm=7 Jack', detection possible
(   0.430|   0.000) I: [pulseaudio] alsa-sink.c: Driver does not
support hardware volume control, falling back to software volume
control.
(   0.430|   0.000) I: [pulseaudio] alsa-sink.c: Driver does not
support hardware mute control, falling back to software mute control.
(   0.430|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_dump():
(   0.430|   0.000) D: [pulseaudio] alsa-util.c: Hooks PCM
(   0.430|   0.000) D: [pulseaudio] alsa-util.c: Its setup is:
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   stream       : PLAYBACK
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   access       :
MMAP_INTERLEAVED
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   format       : S16_LE
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   subformat    : STD
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   channels     : 2
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   rate         : 44100
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   exact rate   :
44100 (44100/1)
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   msbits       : 16
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   buffer_size  : 2016
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   period_size  : 672
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   period_time  : 15238
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_mode  : ENABLE
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   period_step  : 1
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   avail_min    : 672
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   period_event : 1
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   start_threshold  : -1
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   stop_threshold   :
9079256848778919936
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   silence_threshold: 0
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   silence_size : 0
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   boundary     :
9079256848778919936
(   0.430|   0.000) D: [pulseaudio] alsa-util.c: Slave: Hardware PCM
card 1 'HDA NVidia' device 7 subdevice 0
(   0.430|   0.000) D: [pulseaudio] alsa-util.c: Its setup is:
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   stream       : PLAYBACK
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   access       :
MMAP_INTERLEAVED
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   format       : S16_LE
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   subformat    : STD
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   channels     : 2
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   rate         : 44100
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   exact rate   :
44100 (44100/1)
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   msbits       : 16
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   buffer_size  : 2016
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   period_size  : 672
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   period_time  : 15238
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_mode  : ENABLE
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   period_step  : 1
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   avail_min    : 672
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   period_event : 1
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   start_threshold  : -1
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   stop_threshold   :
9079256848778919936
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   silence_threshold: 0
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   silence_size : 0
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   boundary     :
9079256848778919936
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   appl_ptr     : 0
(   0.430|   0.000) D: [pulseaudio] alsa-util.c:   hw_ptr       : 0
(   0.431|   0.000) D: [alsa-sink] alsa-sink.c: Thread starting up
(   0.434|   0.003) D: [alsa-sink] core-util.c: RealtimeKit worked.
(   0.434|   0.000) I: [alsa-sink] core-util.c: Successfully enabled
SCHED_RR scheduling for thread, with priority 5.
(   0.434|   0.000) I: [alsa-sink] alsa-sink.c: Starting playback.
(   0.434|   0.000) D: [pulseaudio] module-alsa-card.c: Found 4 jacks.
(   0.434|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached
to mixer 'hw:1'
(   0.434|   0.000) D: [pulseaudio] module-alsa-card.c: Jack
'HDMI/DP,pcm=3 Jack' is now unplugged
(   0.434|   0.000) D: [pulseaudio] device-port.c: Setting port
hdmi-output-0 to status no
(   0.434|   0.000) D: [pulseaudio] core-subscribe.c: Dropped
redundant event due to change event.
(   0.434|   0.000) D: [pulseaudio] module-alsa-card.c: Jack
'HDMI/DP,pcm=7 Jack' is now unplugged
(   0.434|   0.000) D: [pulseaudio] device-port.c: Setting port
hdmi-output-1 to status no
(   0.434|   0.000) D: [pulseaudio] core-subscribe.c: Dropped
redundant event due to change event.
(   0.434|   0.000) D: [pulseaudio] module-alsa-card.c: Jack
'HDMI/DP,pcm=8 Jack' is now unplugged
(   0.434|   0.000) D: [pulseaudio] device-port.c: Setting port
hdmi-output-2 to status no
(   0.434|   0.000) D: [pulseaudio] core-subscribe.c: Dropped
redundant event due to change event.
(   0.434|   0.000) D: [pulseaudio] module-alsa-card.c: Jack
'HDMI/DP,pcm=9 Jack' is now unplugged
(   0.434|   0.000) D: [pulseaudio] device-port.c: Setting port
hdmi-output-3 to status no
(   0.434|   0.000) D: [pulseaudio] core-subscribe.c: Dropped
redundant event due to change event.
(   0.434|   0.000) I: [pulseaudio] module.c: Loaded
"module-alsa-card" (index: #4; argument: "device_id="1"
name="pci-0000_01_00.1" card_name="alsa_card.pci-0000_01_00.1"
namereg_fail=false tsched=no fixed_latency_range=no ignore_dB=no
deferred_volume=yes use_ucm=yes
card_properties="module-udev-detect.discovered=1"").
(   0.435|   0.000) I: [pulseaudio] module-udev-detect.c: Card
/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card1
(alsa_card.pci-0000_01_00.1) module loaded.
(   0.435|   0.000) D: [pulseaudio] module-udev-detect.c:
/dev/snd/controlC0 is accessible: yes
(   0.435|   0.000) D: [pulseaudio] module-udev-detect.c:
/devices/pci0000:00/0000:00:1b.0/sound/card0 is busy: no
(   0.435|   0.000) D: [pulseaudio] module-udev-detect.c: Loading
module-alsa-card with arguments 'device_id="0" name="pci-0000_00_1b.0"
card_name="alsa_card.pci-0000_00_1b.0" namereg_fail=false tsched=no
fixed_latency_range=no ignore_dB=no deferred_volume=yes use_ucm=yes
card_properties="module-udev-detect.discovered=1"'
(   0.435|   0.000) D: [pulseaudio] reserve-wrap.c: Successfully
acquired reservation lock on device 'Audio0'
(   0.435|   0.000) I: [pulseaudio] (alsa-lib)utils.c: could not open
configuration file /usr/share/alsa/ucm/HDA Intel PCH/HDA Intel
PCH.conf
(   0.435|   0.000) I: [pulseaudio] (alsa-lib)parser.c: error: could
not parse configuration for card HDA Intel PCH
(   0.435|   0.000) I: [pulseaudio] (alsa-lib)main.c: error: failed to
import HDA Intel PCH use case configuration -2
(   0.435|   0.000) I: [pulseaudio] alsa-ucm.c: UCM not available for
card HDA Intel PCH
(   0.436|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
input:analog-mono
(   0.436|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
recording on Analog Mono (analog-mono)
(   0.436|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:0 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.436|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:0
(   0.436|   0.000) D: [pulseaudio] alsa-util.c:
snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   0.436|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:0 without
SND_PCM_NO_AUTO_FORMAT ...
(   0.436|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:0
(   0.436|   0.000) D: [pulseaudio] alsa-util.c:
snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   0.436|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:hw:0 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.436|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hw:0
(   0.436|   0.000) D: [pulseaudio] alsa-util.c:
snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   0.436|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:hw:0
without SND_PCM_NO_AUTO_FORMAT ...
(   0.436|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hw:0
(   0.436|   0.000) D: [pulseaudio] alsa-util.c:
snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   0.436|   0.000) I: [pulseaudio] alsa-util.c: Failed to set
hardware parameters on plug:hw:0: Invalid argument
(   0.436|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open input:analog-mono
(   0.436|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
input:analog-stereo
(   0.436|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
recording on Analog Stereo (analog-stereo)
(   0.436|   0.000) D: [pulseaudio] alsa-util.c: Trying front:0 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.437|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:0
(   0.437|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 371 ms
(   0.437|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   0.437|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
input:analog-stereo supported.
(   0.438|   0.001) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL front:0
(   0.438|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to
mixer front:0: No such file or directory
(   0.438|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached
to mixer 'hw:0'
(   0.438|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path
'analog-input-microphone-front'
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front
Mic Jack' succeeded (found!)
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Front Mic Boost' succeeded (volume=1, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Input Source' succeeded (volume=0, switch=0, enumeration=1).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Rear Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Line' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Line Boost' succeeded (volume=2, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Video' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV
Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'FM' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path
'analog-input-microphone-rear'
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Rear
Mic Jack' succeeded (found!)
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Rear Mic Boost' succeeded (volume=1, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Input Source' succeeded (volume=0, switch=0, enumeration=1).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Front Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Line' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Line Boost' succeeded (volume=2, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Video' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV
Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'FM' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path
'analog-input-microphone-internal'
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Mic
Jack' succeeded (not found)
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock
Mic Jack' succeeded (not found)
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front
Mic Jack' succeeded (found!)
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Rear
Mic Jack' succeeded (found!)
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack
'Internal Mic Phantom Jack' succeeded (not found)
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Int Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Int Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Input Source' succeeded (volume=0, switch=0, enumeration=1).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Headphone Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Headphone Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Front Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Rear Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Line' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Line Boost' succeeded (volume=2, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Video' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV
Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'FM' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path
'analog-input-microphone-internal', none of required-any elements
preset.
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path
'analog-input-microphone-dock'
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Dock
Mic Jack' succeeded (not found)
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Input Source' succeeded (volume=0, switch=0, enumeration=1).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Front Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Rear Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Line' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Line Boost' succeeded (volume=2, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Video' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV
Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'FM' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path
'analog-input-microphone-dock', none of required-any elements preset.
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input'
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Front Mic Boost' failed.
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path
'analog-input-microphone'
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Mic
Jack' succeeded (not found)
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.439|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Input Source' succeeded (volume=0, switch=0, enumeration=1).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic Select' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic Boost (+20dB)' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Front Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Rear Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Line' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Line Boost' succeeded (volume=2, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Video' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV
Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'FM' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path
'analog-input-microphone', none of required-any elements preset.
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path
'analog-input-linein'
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Line
Jack' succeeded (found!)
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Line Boost' succeeded (volume=1, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Line' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Input Source' succeeded (volume=0, switch=0, enumeration=1).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Front Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Rear Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Video' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV
Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'FM' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input'
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Line' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'Aux' failed.
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path
'analog-input-video'
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Line' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Video' failed.
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path
'analog-input-video'
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Line' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Video' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV
Tuner' failed.
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path
'analog-input-radio'
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Line' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Video' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV
Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'FM' failed.
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-input'
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Line' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Line Boost' succeeded (volume=2, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Video' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic/Line' failed.
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path
'analog-input-microphone'
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack
'Headphone Mic Jack' succeeded (not found)
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Headphone Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Headphone Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Capture' succeeded (volume=1, switch=1, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Input Source' succeeded (volume=0, switch=0, enumeration=1).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Capture Source' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Auto-Mute Mode' succeeded (volume=0, switch=0, enumeration=1).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Front Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Rear Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Dock Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Dock Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Internal Mic Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Front Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Rear Mic Boost' succeeded (volume=2, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Line' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Line Boost' succeeded (volume=2, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Aux' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Video' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic/Line' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element 'TV
Tuner' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'FM' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Inverted Internal Mic' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Mic Jack Mode' succeeded (volume=0, switch=0, enumeration=0).
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path
'analog-input-microphone', none of required-any elements preset.
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer
paths (after tidying):
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xc76970, direction=2
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Path
analog-input-microphone-front (Front Microphone), direction=2,
priority=85, probed=yes, supported=yes, has_mute=yes, has_volume=yes,
has_dB=yes, min_volume=0, max_volume=3, min_dB=-16, max_dB=60
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front Mic
Boost, direction=2, switch=0, volume=1, volume_limit=-1,
enumeration=0, required=0, required_any=4, required_absent=0,
mask=0x3600000000f66, n_channels=2, override_map=yes
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Element Capture,
direction=2, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x3600000000f66,
n_channels=2, override_map=yes
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Element Input
Source, direction=2, switch=0, volume=0, volume_limit=-1,
enumeration=1, required=0, required_any=0, required_absent=0,
mask=0x0, n_channels=0, override_map=no
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Option Front Mic
(analog-input-microphone-front/analog-input-microphone-front) index=0,
priority=0
(   0.440|   0.000) D: [pulseaudio] alsa-mixer.c: Element Rear Mic
Boost, direction=2, switch=0, volume=2, volume_limit=-1,
enumeration=0, required=0, required_any=0, required_absent=0,
mask=0x6, n_channels=2, override_map=no
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Element Line Boost,
direction=2, switch=0, volume=2, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2,
override_map=no
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Front Mic,
alsa_name='Front Mic Jack', detection possible
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Setting
analog-input-microphone-front (analog-input-microphone-front)
priority=0
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Path
analog-input-microphone-rear (Rear Microphone), direction=2,
priority=82, probed=yes, supported=yes, has_mute=yes, has_volume=yes,
has_dB=yes, min_volume=0, max_volume=3, min_dB=-16, max_dB=60
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Element Rear Mic
Boost, direction=2, switch=0, volume=1, volume_limit=-1,
enumeration=0, required=0, required_any=4, required_absent=0,
mask=0x3600000000f66, n_channels=2, override_map=yes
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Element Capture,
direction=2, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x3600000000f66,
n_channels=2, override_map=yes
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Element Input
Source, direction=2, switch=0, volume=0, volume_limit=-1,
enumeration=1, required=0, required_any=0, required_absent=0,
mask=0x0, n_channels=0, override_map=no
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Option Rear Mic
(analog-input-microphone-rear/analog-input-microphone-rear) index=1,
priority=0
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front Mic
Boost, direction=2, switch=0, volume=2, volume_limit=-1,
enumeration=0, required=0, required_any=0, required_absent=0,
mask=0x6, n_channels=2, override_map=no
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Element Line Boost,
direction=2, switch=0, volume=2, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2,
override_map=no
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Rear Mic,
alsa_name='Rear Mic Jack', detection possible
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Setting
analog-input-microphone-rear (analog-input-microphone-rear) priority=0
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Path
analog-input-linein (Line In), direction=2, priority=81, probed=yes,
supported=yes, has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0,
max_volume=46, min_dB=-16, max_dB=60
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Element Capture,
direction=2, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x3600000000f66,
n_channels=2, override_map=yes
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Element Line Boost,
direction=2, switch=0, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=4, required_absent=0, mask=0x3600000000f66,
n_channels=2, override_map=yes
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Element Input
Source, direction=2, switch=0, volume=0, volume_limit=-1,
enumeration=1, required=0, required_any=0, required_absent=0,
mask=0x0, n_channels=0, override_map=no
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Option Line
(analog-input-linein/analog-input-linein) index=2, priority=0
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front Mic
Boost, direction=2, switch=0, volume=2, volume_limit=-1,
enumeration=0, required=0, required_any=0, required_absent=0,
mask=0x6, n_channels=2, override_map=no
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Element Rear Mic
Boost, direction=2, switch=0, volume=2, volume_limit=-1,
enumeration=0, required=0, required_any=0, required_absent=0,
mask=0x6, n_channels=2, override_map=no
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Line,
alsa_name='Line Jack', detection possible
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Setting
analog-input-linein (analog-input-linein) priority=0
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
input:iec958-stereo
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
recording on Digital Stereo (IEC958) (iec958-stereo)
(   0.441|   0.000) D: [pulseaudio] alsa-util.c: Trying iec958:0 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.441|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open
'/dev/snd/pcmC0D1c' failed (-2)
(   0.441|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device iec958:0: No such file or directory
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open input:iec958-stereo
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:analog-mono
(   0.441|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Analog Mono (analog-mono)
(   0.441|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:0 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.441|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:0
(   0.441|   0.000) D: [pulseaudio] alsa-util.c:
snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   0.441|   0.000) D: [pulseaudio] alsa-util.c: Trying hw:0 without
SND_PCM_NO_AUTO_FORMAT ...
(   0.441|   0.000) D: [pulseaudio] alsa-util.c: Managed to open hw:0
(   0.441|   0.000) D: [pulseaudio] alsa-util.c:
snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   0.441|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:hw:0 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.441|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hw:0
(   0.441|   0.000) D: [pulseaudio] alsa-util.c:
snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   0.441|   0.000) D: [pulseaudio] alsa-util.c: Trying plug:hw:0
without SND_PCM_NO_AUTO_FORMAT ...
(   0.441|   0.000) D: [pulseaudio] alsa-util.c: Managed to open plug:hw:0
(   0.442|   0.000) D: [pulseaudio] alsa-util.c:
snd_pcm_hw_params_set_channels(1) failed: Invalid argument
(   0.442|   0.000) I: [pulseaudio] alsa-util.c: Failed to set
hardware parameters on plug:hw:0: Invalid argument
(   0.442|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:analog-mono
(   0.442|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-mono+input:analog-mono - will not be able to open
output:analog-mono
(   0.442|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-mono+input:analog-stereo - will not be able to open
output:analog-mono
(   0.442|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-mono+input:iec958-stereo - will not be able to open
output:analog-mono
(   0.442|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:analog-stereo
(   0.442|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Analog Stereo (analog-stereo)
(   0.442|   0.000) D: [pulseaudio] alsa-util.c: Trying front:0 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.442|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:0
(   0.442|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 371 ms
(   0.442|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   0.442|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-stereo supported.
(   0.443|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL front:0
(   0.443|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to
mixer front:0: No such file or directory
(   0.443|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached
to mixer 'hw:0'
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path 'analog-output'
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Master' succeeded (volume=1, switch=1, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Master Front' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Line HP Swap' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Headphone' succeeded (volume=3, switch=1, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Headphone2' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Desktop Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Front' succeeded (volume=1, switch=1, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Rear' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Surround' succeeded (volume=1, switch=1, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Side' succeeded (volume=1, switch=1, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Center' succeeded (volume=1, switch=1, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'LFE' succeeded (volume=1, switch=1, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'PCM' succeeded (volume=1, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'External Amplifier' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Bass Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'IEC958' succeeded (volume=0, switch=2, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'IEC958 Optical Raw' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Analog Output' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path
'analog-output-speaker'
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack
'Headphone Jack' succeeded (not found)
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front
Headphone Jack' succeeded (found!)
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack
'Speaker Phantom Jack' succeeded (not found)
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Master' succeeded (volume=1, switch=1, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Master Front' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Headphone' succeeded (volume=3, switch=1, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Headphone2' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Desktop Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Front' succeeded (volume=1, switch=1, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Front Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Rear' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Surround' succeeded (volume=1, switch=1, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Surround Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Side' succeeded (volume=1, switch=1, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Center' succeeded (volume=1, switch=1, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Center Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'LFE' succeeded (volume=1, switch=1, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'LFE Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Bass Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'CLFE' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'PCM' succeeded (volume=1, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'External Amplifier' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Bass Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'IEC958' succeeded (volume=0, switch=2, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'IEC958 Optical Raw' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Analog Output' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping path
'analog-output-speaker', none of required-any elements preset.
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path
'analog-output-speaker'
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Master' succeeded (volume=1, switch=1, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Headphone' succeeded (volume=3, switch=1, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Headphone2' succeeded (volume=0, switch=0, enumeration=0).
(   0.443|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Desktop Speaker' failed.
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path
'analog-output-headphones'
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack 'Front
Headphone Jack' succeeded (found!)
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack
'Headphone Jack' succeeded (not found)
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of jack
'Headphone Mic Jack' succeeded (not found)
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Master' succeeded (volume=1, switch=1, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Master Front' succeeded (volume=0, switch=0, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Headphone' succeeded (volume=1, switch=1, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Line HP Swap' succeeded (volume=0, switch=0, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Headphone2' succeeded (volume=0, switch=0, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Desktop Speaker' succeeded (volume=0, switch=0, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Front' succeeded (volume=3, switch=1, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Rear' succeeded (volume=0, switch=0, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Surround' succeeded (volume=2, switch=2, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Side' succeeded (volume=2, switch=2, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Center' succeeded (volume=2, switch=2, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'LFE' succeeded (volume=2, switch=2, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'PCM' succeeded (volume=1, switch=0, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'External Amplifier' succeeded (volume=0, switch=0, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Bass Boost' succeeded (volume=0, switch=0, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'IEC958' succeeded (volume=0, switch=2, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'IEC958 Optical Raw' succeeded (volume=0, switch=0, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Analog Output' succeeded (volume=0, switch=0, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path
'analog-output-headphones'
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Master' succeeded (volume=1, switch=1, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Master Front' succeeded (volume=0, switch=0, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Master Mono' succeeded (volume=0, switch=0, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Headphone' succeeded (volume=3, switch=1, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Headphone2' failed.
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path
'analog-output-mono'
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Hardware Master' succeeded (volume=0, switch=0, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Master' succeeded (volume=2, switch=2, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Master Front' succeeded (volume=0, switch=0, enumeration=0).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'Master Mono' failed.
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer
paths (after tidying):
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xc72640, direction=1
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-output
(Analog Output), direction=1, priority=99, probed=yes, supported=yes,
has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=64,
min_dB=-177, max_dB=2
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Element Master,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x7ffffffffffff,
n_channels=1, override_map=yes
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Element Headphone,
direction=1, switch=1, volume=3, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2,
override_map=no
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2,
override_map=yes
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Element Surround,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x60,
n_channels=2, override_map=yes
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Element Side,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0xc00,
n_channels=2, override_map=yes
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Element Center,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x4900000000018,
n_channels=1, override_map=yes
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Element LFE,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x80,
n_channels=1, override_map=yes
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Element PCM,
direction=1, switch=0, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x3600000000f66,
n_channels=2, override_map=yes
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Element IEC958,
direction=1, switch=2, volume=0, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0,
override_map=no
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Path
analog-output-headphones (Headphones), direction=1, priority=90,
probed=yes, supported=yes, has_mute=yes, has_volume=yes, has_dB=yes,
min_volume=0, max_volume=64, min_dB=-177, max_dB=2
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Element Master,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x7ffffffffffff,
n_channels=1, override_map=yes
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Element Headphone,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=4, required_absent=0, mask=0x3600000000f66,
n_channels=2, override_map=yes
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front,
direction=1, switch=1, volume=3, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2,
override_map=no
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Element Surround,
direction=1, switch=2, volume=2, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2,
override_map=no
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Element Side,
direction=1, switch=2, volume=2, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2,
override_map=no
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Element Center,
direction=1, switch=2, volume=2, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x7ffffffffffff,
n_channels=1, override_map=no
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Element LFE,
direction=1, switch=2, volume=2, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x7ffffffffffff,
n_channels=1, override_map=no
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Element PCM,
direction=1, switch=0, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x3600000000f66,
n_channels=2, override_map=yes
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Element IEC958,
direction=1, switch=2, volume=0, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0,
override_map=no
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Front
Headphone, alsa_name='Front Headphone Jack', detection possible
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Headphone,
alsa_name='Headphone Jack', detection unavailable
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Headphone Mic,
alsa_name='Headphone Mic Jack', detection unavailable
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-stereo+input:analog-mono - will not be able to open
input:analog-mono
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:analog-stereo+input:analog-stereo
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
recording on Analog Stereo (analog-stereo)
(   0.444|   0.000) D: [pulseaudio] alsa-util.c: Trying front:0 with
SND_PCM_NO_AUTO_FORMAT ...
(   0.444|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:0
(   0.444|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 371 ms
(   0.444|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-stereo+input:analog-stereo supported.
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-stereo+input:iec958-stereo - will not be able to open
input:iec958-stereo
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:analog-surround-40
(   0.444|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Analog Surround 4.0 (analog-surround-40)
(   0.444|   0.000) D: [pulseaudio] alsa-util.c: Trying surround40:0
with SND_PCM_NO_AUTO_FORMAT ...
(   0.445|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround40:0
(   0.445|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 185 ms
(   2.493|   2.048) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   2.493|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-surround-40 supported.
(   2.493|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL
surround40:0
(   2.493|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to
mixer surround40:0: No such file or directory
(   2.494|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached
to mixer 'hw:0'
(   2.494|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer
paths (after tidying):
(   2.494|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xc30dd0, direction=1
(   2.494|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-output
(Analog Output), direction=1, priority=99, probed=yes, supported=yes,
has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=64,
min_dB=-177, max_dB=2
(   2.494|   0.000) D: [pulseaudio] alsa-mixer.c: Element Master,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x7ffffffffffff,
n_channels=1, override_map=yes
(   2.494|   0.000) D: [pulseaudio] alsa-mixer.c: Element Headphone,
direction=1, switch=1, volume=3, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2,
override_map=no
(   2.494|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2,
override_map=yes
(   2.494|   0.000) D: [pulseaudio] alsa-mixer.c: Element Surround,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x60,
n_channels=2, override_map=yes
(   2.494|   0.000) D: [pulseaudio] alsa-mixer.c: Element Side,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0xc00,
n_channels=2, override_map=yes
(   2.494|   0.000) D: [pulseaudio] alsa-mixer.c: Element Center,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x4900000000018,
n_channels=1, override_map=yes
(   2.494|   0.000) D: [pulseaudio] alsa-mixer.c: Element LFE,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x80,
n_channels=1, override_map=yes
(   2.494|   0.000) D: [pulseaudio] alsa-mixer.c: Element PCM,
direction=1, switch=0, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x3600000000f66,
n_channels=2, override_map=yes
(   2.494|   0.000) D: [pulseaudio] alsa-mixer.c: Element IEC958,
direction=1, switch=2, volume=0, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0,
override_map=no
(   2.494|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-40+input:analog-mono - will not be able to open
input:analog-mono
(   2.494|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:analog-surround-40+input:analog-stereo
(   2.494|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
recording on Analog Stereo (analog-stereo)
(   2.494|   0.000) D: [pulseaudio] alsa-util.c: Trying front:0 with
SND_PCM_NO_AUTO_FORMAT ...
(   2.494|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:0
(   2.494|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 371 ms
(   2.494|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   2.494|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-surround-40+input:analog-stereo supported.
(   2.494|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-40+input:iec958-stereo - will not be able to
open input:iec958-stereo
(   2.494|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:analog-surround-41
(   2.494|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Analog Surround 4.1 (analog-surround-41)
(   2.494|   0.000) D: [pulseaudio] alsa-util.c: Trying surround41:0
with SND_PCM_NO_AUTO_FORMAT ...
(   2.494|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround41:0
(   2.495|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 123 ms
(   6.549|   4.054) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   6.549|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-surround-41 supported.
(   6.549|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL
surround41:0
(   6.549|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to
mixer surround41:0: No such file or directory
(   6.550|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached
to mixer 'hw:0'
(   6.550|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer
paths (after tidying):
(   6.550|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xd28070, direction=1
(   6.550|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-output
(Analog Output), direction=1, priority=99, probed=yes, supported=yes,
has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=64,
min_dB=-177, max_dB=2
(   6.550|   0.000) D: [pulseaudio] alsa-mixer.c: Element Master,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x7ffffffffffff,
n_channels=1, override_map=yes
(   6.550|   0.000) D: [pulseaudio] alsa-mixer.c: Element Headphone,
direction=1, switch=1, volume=3, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2,
override_map=no
(   6.550|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2,
override_map=yes
(   6.550|   0.000) D: [pulseaudio] alsa-mixer.c: Element Surround,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x60,
n_channels=2, override_map=yes
(   6.550|   0.000) D: [pulseaudio] alsa-mixer.c: Element Side,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0xc00,
n_channels=2, override_map=yes
(   6.550|   0.000) D: [pulseaudio] alsa-mixer.c: Element Center,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x4900000000018,
n_channels=1, override_map=yes
(   6.550|   0.000) D: [pulseaudio] alsa-mixer.c: Element LFE,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x80,
n_channels=1, override_map=yes
(   6.550|   0.000) D: [pulseaudio] alsa-mixer.c: Element PCM,
direction=1, switch=0, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x3600000000f66,
n_channels=2, override_map=yes
(   6.550|   0.000) D: [pulseaudio] alsa-mixer.c: Element IEC958,
direction=1, switch=2, volume=0, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0,
override_map=no
(   6.550|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-41+input:analog-mono - will not be able to open
input:analog-mono
(   6.550|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:analog-surround-41+input:analog-stereo
(   6.550|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
recording on Analog Stereo (analog-stereo)
(   6.550|   0.000) D: [pulseaudio] alsa-util.c: Trying front:0 with
SND_PCM_NO_AUTO_FORMAT ...
(   6.550|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:0
(   6.550|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 371 ms
(   6.550|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   6.550|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-surround-41+input:analog-stereo supported.
(   6.550|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-41+input:iec958-stereo - will not be able to
open input:iec958-stereo
(   6.550|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:analog-surround-50
(   6.550|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Analog Surround 5.0 (analog-surround-50)
(   6.550|   0.000) D: [pulseaudio] alsa-util.c: Trying surround50:0
with SND_PCM_NO_AUTO_FORMAT ...
(   6.550|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround50:0
(   6.551|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 123 ms
(   6.551|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   6.551|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-surround-50 supported.
(   6.551|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL
surround50:0
(   6.551|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to
mixer surround50:0: No such file or directory
(   6.551|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached
to mixer 'hw:0'
(   6.551|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer
paths (after tidying):
(   6.551|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xcf8270, direction=1
(   6.551|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-output
(Analog Output), direction=1, priority=99, probed=yes, supported=yes,
has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=64,
min_dB=-177, max_dB=2
(   6.551|   0.000) D: [pulseaudio] alsa-mixer.c: Element Master,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x7ffffffffffff,
n_channels=1, override_map=yes
(   6.551|   0.000) D: [pulseaudio] alsa-mixer.c: Element Headphone,
direction=1, switch=1, volume=3, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2,
override_map=no
(   6.551|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2,
override_map=yes
(   6.551|   0.000) D: [pulseaudio] alsa-mixer.c: Element Surround,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x60,
n_channels=2, override_map=yes
(   6.551|   0.000) D: [pulseaudio] alsa-mixer.c: Element Side,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0xc00,
n_channels=2, override_map=yes
(   6.551|   0.000) D: [pulseaudio] alsa-mixer.c: Element Center,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x4900000000018,
n_channels=1, override_map=yes
(   6.551|   0.000) D: [pulseaudio] alsa-mixer.c: Element LFE,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x80,
n_channels=1, override_map=yes
(   6.551|   0.000) D: [pulseaudio] alsa-mixer.c: Element PCM,
direction=1, switch=0, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x3600000000f66,
n_channels=2, override_map=yes
(   6.551|   0.000) D: [pulseaudio] alsa-mixer.c: Element IEC958,
direction=1, switch=2, volume=0, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0,
override_map=no
(   6.551|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-50+input:analog-mono - will not be able to open
input:analog-mono
(   6.551|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:analog-surround-50+input:analog-stereo
(   6.551|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
recording on Analog Stereo (analog-stereo)
(   6.551|   0.000) D: [pulseaudio] alsa-util.c: Trying front:0 with
SND_PCM_NO_AUTO_FORMAT ...
(   6.551|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:0
(   6.551|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 371 ms
(   6.551|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   6.551|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-surround-50+input:analog-stereo supported.
(   6.551|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-50+input:iec958-stereo - will not be able to
open input:iec958-stereo
(   6.551|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:analog-surround-51
(   6.551|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Analog Surround 5.1 (analog-surround-51)
(   6.551|   0.000) D: [pulseaudio] alsa-util.c: Trying surround51:0
with SND_PCM_NO_AUTO_FORMAT ...
(   6.552|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround51:0
(   6.552|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 123 ms
(   6.552|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   6.552|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-surround-51 supported.
(   6.552|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL
surround51:0
(   6.552|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to
mixer surround51:0: No such file or directory
(   6.552|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached
to mixer 'hw:0'
(   6.552|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer
paths (after tidying):
(   6.552|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xd20420, direction=1
(   6.552|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-output
(Analog Output), direction=1, priority=99, probed=yes, supported=yes,
has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=64,
min_dB=-177, max_dB=2
(   6.552|   0.000) D: [pulseaudio] alsa-mixer.c: Element Master,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x7ffffffffffff,
n_channels=1, override_map=yes
(   6.552|   0.000) D: [pulseaudio] alsa-mixer.c: Element Headphone,
direction=1, switch=1, volume=3, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2,
override_map=no
(   6.552|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2,
override_map=yes
(   6.552|   0.000) D: [pulseaudio] alsa-mixer.c: Element Surround,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x60,
n_channels=2, override_map=yes
(   6.552|   0.000) D: [pulseaudio] alsa-mixer.c: Element Side,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0xc00,
n_channels=2, override_map=yes
(   6.552|   0.000) D: [pulseaudio] alsa-mixer.c: Element Center,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x4900000000018,
n_channels=1, override_map=yes
(   6.552|   0.000) D: [pulseaudio] alsa-mixer.c: Element LFE,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x80,
n_channels=1, override_map=yes
(   6.552|   0.000) D: [pulseaudio] alsa-mixer.c: Element PCM,
direction=1, switch=0, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x3600000000f66,
n_channels=2, override_map=yes
(   6.552|   0.000) D: [pulseaudio] alsa-mixer.c: Element IEC958,
direction=1, switch=2, volume=0, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0,
override_map=no
(   6.552|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-51+input:analog-mono - will not be able to open
input:analog-mono
(   6.552|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:analog-surround-51+input:analog-stereo
(   6.552|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
recording on Analog Stereo (analog-stereo)
(   6.552|   0.000) D: [pulseaudio] alsa-util.c: Trying front:0 with
SND_PCM_NO_AUTO_FORMAT ...
(   6.552|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:0
(   6.552|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 371 ms
(   6.552|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   6.552|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-surround-51+input:analog-stereo supported.
(   6.552|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-51+input:iec958-stereo - will not be able to
open input:iec958-stereo
(   6.552|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:analog-surround-71
(   6.552|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Analog Surround 7.1 (analog-surround-71)
(   6.552|   0.000) D: [pulseaudio] alsa-util.c: Trying surround71:0
with SND_PCM_NO_AUTO_FORMAT ...
(   6.553|   0.000) D: [pulseaudio] alsa-util.c: Managed to open surround71:0
(   6.553|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer size is 92 ms
(   8.597|   2.044) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   8.597|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-surround-71 supported.
(   8.597|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL
surround71:0
(   8.597|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to
mixer surround71:0: No such file or directory
(   8.598|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached
to mixer 'hw:0'
(   8.598|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer
paths (after tidying):
(   8.598|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xc619a0, direction=1
(   8.598|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-output
(Analog Output), direction=1, priority=99, probed=yes, supported=yes,
has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=64,
min_dB=-177, max_dB=2
(   8.598|   0.000) D: [pulseaudio] alsa-mixer.c: Element Master,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x7ffffffffffff,
n_channels=1, override_map=yes
(   8.598|   0.000) D: [pulseaudio] alsa-mixer.c: Element Headphone,
direction=1, switch=1, volume=3, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2,
override_map=no
(   8.598|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2,
override_map=yes
(   8.598|   0.000) D: [pulseaudio] alsa-mixer.c: Element Surround,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x60,
n_channels=2, override_map=yes
(   8.598|   0.000) D: [pulseaudio] alsa-mixer.c: Element Side,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0xc00,
n_channels=2, override_map=yes
(   8.598|   0.000) D: [pulseaudio] alsa-mixer.c: Element Center,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x4900000000018,
n_channels=1, override_map=yes
(   8.598|   0.000) D: [pulseaudio] alsa-mixer.c: Element LFE,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x80,
n_channels=1, override_map=yes
(   8.598|   0.000) D: [pulseaudio] alsa-mixer.c: Element PCM,
direction=1, switch=0, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x3600000000f66,
n_channels=2, override_map=yes
(   8.598|   0.000) D: [pulseaudio] alsa-mixer.c: Element IEC958,
direction=1, switch=2, volume=0, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0,
override_map=no
(   8.598|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-71+input:analog-mono - will not be able to open
input:analog-mono
(   8.598|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:analog-surround-71+input:analog-stereo
(   8.598|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
recording on Analog Stereo (analog-stereo)
(   8.598|   0.000) D: [pulseaudio] alsa-util.c: Trying front:0 with
SND_PCM_NO_AUTO_FORMAT ...
(   8.598|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:0
(   8.598|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 371 ms
(   8.598|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   8.598|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-surround-71+input:analog-stereo supported.
(   8.598|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:analog-surround-71+input:iec958-stereo - will not be able to
open input:iec958-stereo
(   8.598|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:iec958-stereo
(   8.598|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Stereo (IEC958) (iec958-stereo)
(   8.598|   0.000) D: [pulseaudio] alsa-util.c: Trying iec958:0 with
SND_PCM_NO_AUTO_FORMAT ...
(   8.598|   0.000) D: [pulseaudio] alsa-util.c: Managed to open iec958:0
(   8.599|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 371 ms
(   9.617|   1.018) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   9.618|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:iec958-stereo supported.
(   9.618|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL iec958:0
(   9.618|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to
mixer iec958:0: No such file or directory
(   9.618|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached
to mixer 'hw:0'
(   9.618|   0.000) D: [pulseaudio] alsa-mixer.c: Probing path
'iec958-stereo-output'
(   9.618|   0.000) D: [pulseaudio] alsa-mixer.c: Probe of element
'IEC958' succeeded (volume=0, switch=1, enumeration=0).
(   9.618|   0.000) D: [pulseaudio] alsa-mixer.c: Available mixer
paths (after tidying):
(   9.618|   0.000) D: [pulseaudio] alsa-mixer.c: Path Set 0xce30e0, direction=1
(   9.618|   0.000) D: [pulseaudio] alsa-mixer.c: Path
iec958-stereo-output (Digital Output (S/PDIF)), direction=1,
priority=0, probed=yes, supported=yes, has_mute=yes, has_volume=no,
has_dB=no, min_volume=0, max_volume=0, min_dB=inf, max_dB=-inf
(   9.618|   0.000) D: [pulseaudio] alsa-mixer.c: Element IEC958,
direction=1, switch=1, volume=0, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0,
override_map=no
(   9.618|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-stereo+input:analog-mono - will not be able to open
input:analog-mono
(   9.618|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:iec958-stereo+input:analog-stereo
(   9.618|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
recording on Analog Stereo (analog-stereo)
(   9.618|   0.000) D: [pulseaudio] alsa-util.c: Trying front:0 with
SND_PCM_NO_AUTO_FORMAT ...
(   9.618|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:0
(   9.618|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 371 ms
(   9.618|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(   9.618|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:iec958-stereo+input:analog-stereo supported.
(   9.618|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-stereo+input:iec958-stereo - will not be able to open
input:iec958-stereo
(   9.618|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:iec958-ac3-surround-40
(   9.618|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Surround 4.0 (IEC958/AC3) (iec958-ac3-surround-40)
(   9.618|   0.000) D: [pulseaudio] alsa-util.c: Trying a52:0 with
SND_PCM_NO_AUTO_FORMAT ...
(   9.618|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM a52:0
(   9.619|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device a52:0: No such file or directory
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:iec958-ac3-surround-40
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-ac3-surround-40+input:analog-mono - will not be able to
open output:iec958-ac3-surround-40
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-ac3-surround-40+input:analog-stereo - will not be able
to open output:iec958-ac3-surround-40
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-ac3-surround-40+input:iec958-stereo - will not be able
to open output:iec958-ac3-surround-40
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:iec958-ac3-surround-51
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Surround 5.1 (IEC958/AC3) (iec958-ac3-surround-51)
(   9.619|   0.000) D: [pulseaudio] alsa-util.c: Trying a52:0 with
SND_PCM_NO_AUTO_FORMAT ...
(   9.619|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM a52:0
(   9.619|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device a52:0: No such file or directory
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:iec958-ac3-surround-51
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-ac3-surround-51+input:analog-mono - will not be able to
open output:iec958-ac3-surround-51
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-ac3-surround-51+input:analog-stereo - will not be able
to open output:iec958-ac3-surround-51
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-ac3-surround-51+input:iec958-stereo - will not be able
to open output:iec958-ac3-surround-51
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:iec958-dts-surround-51
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Surround 5.1 (IEC958/DTS) (iec958-dts-surround-51)
(   9.619|   0.000) D: [pulseaudio] alsa-util.c: Trying dca:0 with
SND_PCM_NO_AUTO_FORMAT ...
(   9.619|   0.000) I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM dca:0
(   9.619|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device dca:0: No such file or directory
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:iec958-dts-surround-51
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-dts-surround-51+input:analog-mono - will not be able to
open output:iec958-dts-surround-51
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-dts-surround-51+input:analog-stereo - will not be able
to open output:iec958-dts-surround-51
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:iec958-dts-surround-51+input:iec958-stereo - will not be able
to open output:iec958-dts-surround-51
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:hdmi-stereo
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Stereo (HDMI) (hdmi-stereo)
(   9.619|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0 with
SND_PCM_NO_AUTO_FORMAT ...
(   9.619|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open
'/dev/snd/pcmC0D3p' failed (-2)
(   9.619|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device hdmi:0: No such file or directory
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:hdmi-stereo
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo+input:analog-mono - will not be able to open
output:hdmi-stereo
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo+input:analog-stereo - will not be able to open
output:hdmi-stereo
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo+input:iec958-stereo - will not be able to open
output:hdmi-stereo
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:hdmi-surround
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Surround 5.1 (HDMI) (hdmi-surround)
(   9.619|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0 with
SND_PCM_NO_AUTO_FORMAT ...
(   9.619|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open
'/dev/snd/pcmC0D3p' failed (-2)
(   9.619|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device hdmi:0: No such file or directory
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:hdmi-surround
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround+input:analog-mono - will not be able to open
output:hdmi-surround
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround+input:analog-stereo - will not be able to open
output:hdmi-surround
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround+input:iec958-stereo - will not be able to open
output:hdmi-surround
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:hdmi-stereo-extra1
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Stereo (HDMI) (hdmi-stereo-extra1)
(   9.619|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,1 with
SND_PCM_NO_AUTO_FORMAT ...
(   9.619|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open
'/dev/snd/pcmC0D7p' failed (-2)
(   9.619|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device hdmi:0,1: No such file or directory
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:hdmi-stereo-extra1
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo-extra1+input:analog-mono - will not be able to open
output:hdmi-stereo-extra1
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo-extra1+input:analog-stereo - will not be able to
open output:hdmi-stereo-extra1
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo-extra1+input:iec958-stereo - will not be able to
open output:hdmi-stereo-extra1
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:hdmi-surround-extra1
(   9.619|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Surround 5.1 (HDMI) (hdmi-surround-extra1)
(   9.619|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,1 with
SND_PCM_NO_AUTO_FORMAT ...
(   9.620|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open
'/dev/snd/pcmC0D7p' failed (-2)
(   9.620|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device hdmi:0,1: No such file or directory
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:hdmi-surround-extra1
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround-extra1+input:analog-mono - will not be able to
open output:hdmi-surround-extra1
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround-extra1+input:analog-stereo - will not be able to
open output:hdmi-surround-extra1
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround-extra1+input:iec958-stereo - will not be able to
open output:hdmi-surround-extra1
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:hdmi-stereo-extra2
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Stereo (HDMI) (hdmi-stereo-extra2)
(   9.620|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,2 with
SND_PCM_NO_AUTO_FORMAT ...
(   9.620|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open
'/dev/snd/pcmC0D8p' failed (-2)
(   9.620|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device hdmi:0,2: No such file or directory
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:hdmi-stereo-extra2
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo-extra2+input:analog-mono - will not be able to open
output:hdmi-stereo-extra2
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo-extra2+input:analog-stereo - will not be able to
open output:hdmi-stereo-extra2
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo-extra2+input:iec958-stereo - will not be able to
open output:hdmi-stereo-extra2
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:hdmi-surround-extra2
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Surround 5.1 (HDMI) (hdmi-surround-extra2)
(   9.620|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,2 with
SND_PCM_NO_AUTO_FORMAT ...
(   9.620|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open
'/dev/snd/pcmC0D8p' failed (-2)
(   9.620|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device hdmi:0,2: No such file or directory
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:hdmi-surround-extra2
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround-extra2+input:analog-mono - will not be able to
open output:hdmi-surround-extra2
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround-extra2+input:analog-stereo - will not be able to
open output:hdmi-surround-extra2
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround-extra2+input:iec958-stereo - will not be able to
open output:hdmi-surround-extra2
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:hdmi-stereo-extra3
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Stereo (HDMI) (hdmi-stereo-extra3)
(   9.620|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,3 with
SND_PCM_NO_AUTO_FORMAT ...
(   9.620|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open
'/dev/snd/pcmC0D9p' failed (-2)
(   9.620|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device hdmi:0,3: No such file or directory
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:hdmi-stereo-extra3
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo-extra3+input:analog-mono - will not be able to open
output:hdmi-stereo-extra3
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo-extra3+input:analog-stereo - will not be able to
open output:hdmi-stereo-extra3
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-stereo-extra3+input:iec958-stereo - will not be able to
open output:hdmi-stereo-extra3
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Looking at profile
output:hdmi-surround-extra3
(   9.620|   0.000) D: [pulseaudio] alsa-mixer.c: Checking for
playback on Digital Surround 5.1 (HDMI) (hdmi-surround-extra3)
(   9.620|   0.000) D: [pulseaudio] alsa-util.c: Trying hdmi:0,3 with
SND_PCM_NO_AUTO_FORMAT ...
(   9.621|   0.000) I: [pulseaudio] (alsa-lib)pcm_hw.c: open
'/dev/snd/pcmC0D9p' failed (-2)
(   9.621|   0.000) I: [pulseaudio] alsa-util.c: Error opening PCM
device hdmi:0,3: No such file or directory
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Caching failure to
open output:hdmi-surround-extra3
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround-extra3+input:analog-mono - will not be able to
open output:hdmi-surround-extra3
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround-extra3+input:analog-stereo - will not be able to
open output:hdmi-surround-extra3
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Skipping profile
output:hdmi-surround-extra3+input:iec958-stereo - will not be able to
open output:hdmi-surround-extra3
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Profile set
0xc5d8d0, auto_profiles=yes, probed=yes, n_mappings=7, n_profiles=15,
n_decibel_fixes=0
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping
analog-stereo (Analog Stereo), priority=60,
channel_map=front-left,front-right, supported=yes, direction=0
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping
analog-surround-40 (Analog Surround 4.0), priority=7,
channel_map=front-left,front-right,rear-left,rear-right,
supported=yes, direction=1
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping
analog-surround-41 (Analog Surround 4.1), priority=8,
channel_map=front-left,front-right,rear-left,rear-right,lfe,
supported=yes, direction=1
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping
analog-surround-50 (Analog Surround 5.0), priority=7,
channel_map=front-left,front-right,rear-left,rear-right,front-center,
supported=yes, direction=1
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping
analog-surround-51 (Analog Surround 5.1), priority=8,
channel_map=front-left,front-right,rear-left,rear-right,front-center,lfe,
supported=yes, direction=1
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping
analog-surround-71 (Analog Surround 7.1), priority=7,
channel_map=front-left,front-right,rear-left,rear-right,front-center,lfe,side-left,side-right,
supported=yes, direction=1
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Mapping
iec958-stereo (Digital Stereo (IEC958)), priority=55,
channel_map=front-left,front-right, supported=yes, direction=0
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
input:analog-stereo (Analog Stereo Input), priority=60, supported=yes
n_input_mappings=1, n_output_mappings=0
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Input analog-stereo
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-stereo (Analog Stereo Output), priority=6000,
supported=yes n_input_mappings=0, n_output_mappings=1
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-stereo
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-stereo+input:analog-stereo (Analog Stereo Duplex),
priority=6060, supported=yes n_input_mappings=1, n_output_mappings=1
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Input analog-stereo
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-stereo
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-surround-40 (Analog Surround 4.0 Output), priority=700,
supported=yes n_input_mappings=0, n_output_mappings=1
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-surround-40
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-surround-40+input:analog-stereo (Analog Surround 4.0
Output + Analog Stereo Input), priority=760, supported=yes
n_input_mappings=1, n_output_mappings=1
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Input analog-stereo
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-surround-40
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-surround-41 (Analog Surround 4.1 Output), priority=800,
supported=yes n_input_mappings=0, n_output_mappings=1
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-surround-41
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-surround-41+input:analog-stereo (Analog Surround 4.1
Output + Analog Stereo Input), priority=860, supported=yes
n_input_mappings=1, n_output_mappings=1
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Input analog-stereo
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-surround-41
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-surround-50 (Analog Surround 5.0 Output), priority=700,
supported=yes n_input_mappings=0, n_output_mappings=1
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-surround-50
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-surround-50+input:analog-stereo (Analog Surround 5.0
Output + Analog Stereo Input), priority=760, supported=yes
n_input_mappings=1, n_output_mappings=1
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Input analog-stereo
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-surround-50
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-surround-51 (Analog Surround 5.1 Output), priority=800,
supported=yes n_input_mappings=0, n_output_mappings=1
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-surround-51
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-surround-51+input:analog-stereo (Analog Surround 5.1
Output + Analog Stereo Input), priority=860, supported=yes
n_input_mappings=1, n_output_mappings=1
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Input analog-stereo
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-surround-51
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-surround-71 (Analog Surround 7.1 Output), priority=700,
supported=yes n_input_mappings=0, n_output_mappings=1
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-surround-71
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:analog-surround-71+input:analog-stereo (Analog Surround 7.1
Output + Analog Stereo Input), priority=760, supported=yes
n_input_mappings=1, n_output_mappings=1
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Input analog-stereo
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Output analog-surround-71
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:iec958-stereo (Digital Stereo (IEC958) Output), priority=5500,
supported=yes n_input_mappings=0, n_output_mappings=1
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Output iec958-stereo
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Profile
output:iec958-stereo+input:analog-stereo (Digital Stereo (IEC958)
Output + Analog Stereo Input), priority=5560, supported=yes
n_input_mappings=1, n_output_mappings=1
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Input analog-stereo
(   9.621|   0.000) D: [pulseaudio] alsa-mixer.c: Output iec958-stereo
(   9.621|   0.000) I: [pulseaudio] module-card-restore.c: Restoring
profile for card alsa_card.pci-0000_00_1b.0.
(   9.621|   0.000) I: [pulseaudio] module-card-restore.c: Restoring
port latency offsets for card alsa_card.pci-0000_00_1b.0.
(   9.621|   0.000) I: [pulseaudio] card.c: Created 1
"alsa_card.pci-0000_00_1b.0"
(   9.622|   0.000) D: [pulseaudio] reserve-wrap.c: Successfully
create reservation lock monitor for device 'Audio0'
(   9.622|   0.000) D: [pulseaudio] alsa-util.c: Trying front:0 with
SND_PCM_NO_AUTO_FORMAT ...
(   9.622|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:0
(   9.622|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 371 ms
(  12.681|   3.059) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(  12.681|   0.000) I: [pulseaudio] alsa-sink.c: Successfully opened
device front:0.
(  12.681|   0.000) I: [pulseaudio] alsa-sink.c: Selected mapping
'Analog Stereo' (analog-stereo).
(  12.681|   0.000) I: [pulseaudio] alsa-sink.c: Successfully enabled
mmap() mode.
(  12.682|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL front:0
(  12.682|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to
mixer front:0: No such file or directory
(  12.682|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached
to mixer 'hw:0'
(  12.682|   0.000) D: [pulseaudio] alsa-mixer.c: Added 2 ports
(  12.682|   0.000) D: [pulseaudio] core-subscribe.c: Dropped
redundant event due to change event.
(  12.682|   0.000) D: [pulseaudio] module-device-restore.c: Database
contains invalid data for key:
sink:alsa_output.pci-0000_00_1b.0.analog-stereo:null
(  12.682|   0.000) I: [pulseaudio] sink.c: Created sink 1
"alsa_output.pci-0000_00_1b.0.analog-stereo" with sample spec s16le
2ch 44100Hz and channel map front-left,front-right
(  12.682|   0.000) I: [pulseaudio] sink.c:     alsa.resolution_bits = "16"
(  12.682|   0.000) I: [pulseaudio] sink.c:     device.api = "alsa"
(  12.682|   0.000) I: [pulseaudio] sink.c:     device.class = "sound"
(  12.682|   0.000) I: [pulseaudio] sink.c:     alsa.class = "generic"
(  12.682|   0.000) I: [pulseaudio] sink.c:     alsa.subclass = "generic-mix"
(  12.682|   0.000) I: [pulseaudio] sink.c:     alsa.name = "ALC889 Analog"
(  12.682|   0.000) I: [pulseaudio] sink.c:     alsa.id = "ALC889 Analog"
(  12.682|   0.000) I: [pulseaudio] sink.c:     alsa.subdevice = "0"
(  12.682|   0.000) I: [pulseaudio] sink.c:     alsa.subdevice_name =
"subdevice #0"
(  12.682|   0.000) I: [pulseaudio] sink.c:     alsa.device = "0"
(  12.682|   0.000) I: [pulseaudio] sink.c:     alsa.card = "0"
(  12.682|   0.000) I: [pulseaudio] sink.c:     alsa.card_name = "HDA Intel PCH"
(  12.682|   0.000) I: [pulseaudio] sink.c:     alsa.long_card_name =
"HDA Intel PCH at 0xf7420000 irq 54"
(  12.682|   0.000) I: [pulseaudio] sink.c:     alsa.driver_name =
"snd_hda_intel"
(  12.682|   0.000) I: [pulseaudio] sink.c:     device.bus_path =
"pci-0000:00:1b.0"
(  12.682|   0.000) I: [pulseaudio] sink.c:     sysfs.path =
"/devices/pci0000:00/0000:00:1b.0/sound/card0"
(  12.682|   0.000) I: [pulseaudio] sink.c:     device.bus = "pci"
(  12.682|   0.000) I: [pulseaudio] sink.c:     device.vendor.id = "8086"
(  12.682|   0.000) I: [pulseaudio] sink.c:     device.vendor.name =
"Intel Corporation"
(  12.682|   0.000) I: [pulseaudio] sink.c:     device.product.name =
"6 Series/C200 Series Chipset Family High Definition Audio Controller"
(  12.682|   0.000) I: [pulseaudio] sink.c:     device.form_factor = "internal"
(  12.682|   0.000) I: [pulseaudio] sink.c:     device.string = "front:0"
(  12.682|   0.000) I: [pulseaudio] sink.c:
device.buffering.buffer_size = "8112"
(  12.682|   0.000) I: [pulseaudio] sink.c:
device.buffering.fragment_size = "4056"
(  12.682|   0.000) I: [pulseaudio] sink.c:     device.access_mode = "mmap"
(  12.682|   0.000) I: [pulseaudio] sink.c:     device.profile.name =
"analog-stereo"
(  12.682|   0.000) I: [pulseaudio] sink.c:
device.profile.description = "Analog Stereo"
(  12.682|   0.000) I: [pulseaudio] sink.c:     device.description =
"Built-in Audio Analog Stereo"
(  12.682|   0.000) I: [pulseaudio] sink.c:     alsa.mixer_name =
"Realtek ALC889"
(  12.682|   0.000) I: [pulseaudio] sink.c:     alsa.components =
"HDA:10ec0889,1043846b,00100004"
(  12.682|   0.000) I: [pulseaudio] sink.c:
module-udev-detect.discovered = "1"
(  12.682|   0.000) I: [pulseaudio] sink.c:     device.icon_name =
"audio-card-pci"
(  12.682|   0.000) D: [pulseaudio] core-subscribe.c: Dropped
redundant event due to change event.
(  12.682|   0.000) I: [pulseaudio] source.c: Created source 1
"alsa_output.pci-0000_00_1b.0.analog-stereo.monitor" with sample spec
s16le 2ch 44100Hz and channel map front-left,front-right
(  12.682|   0.000) I: [pulseaudio] source.c:     device.description =
"Monitor of Built-in Audio Analog Stereo"
(  12.682|   0.000) I: [pulseaudio] source.c:     device.class = "monitor"
(  12.682|   0.000) I: [pulseaudio] source.c:     alsa.card = "0"
(  12.682|   0.000) I: [pulseaudio] source.c:     alsa.card_name =
"HDA Intel PCH"
(  12.682|   0.000) I: [pulseaudio] source.c:     alsa.long_card_name
= "HDA Intel PCH at 0xf7420000 irq 54"
(  12.682|   0.000) I: [pulseaudio] source.c:     alsa.driver_name =
"snd_hda_intel"
(  12.682|   0.000) I: [pulseaudio] source.c:     device.bus_path =
"pci-0000:00:1b.0"
(  12.682|   0.000) I: [pulseaudio] source.c:     sysfs.path =
"/devices/pci0000:00/0000:00:1b.0/sound/card0"
(  12.682|   0.000) I: [pulseaudio] source.c:     device.bus = "pci"
(  12.682|   0.000) I: [pulseaudio] source.c:     device.vendor.id = "8086"
(  12.682|   0.000) I: [pulseaudio] source.c:     device.vendor.name =
"Intel Corporation"
(  12.682|   0.000) I: [pulseaudio] source.c:     device.product.name
= "6 Series/C200 Series Chipset Family High Definition Audio
Controller"
(  12.682|   0.000) I: [pulseaudio] source.c:     device.form_factor =
"internal"
(  12.682|   0.000) I: [pulseaudio] source.c:     device.string = "0"
(  12.682|   0.000) I: [pulseaudio] source.c:
module-udev-detect.discovered = "1"
(  12.682|   0.000) I: [pulseaudio] source.c:     device.icon_name =
"audio-card-pci"
(  12.682|   0.000) I: [pulseaudio] alsa-sink.c: Using 2.0 fragments
of size 4056 bytes (22.99ms), buffer size is 8112 bytes (45.99ms)
(  12.683|   0.000) D: [pulseaudio] alsa-sink.c: hwbuf_unused=0
(  12.683|   0.000) D: [pulseaudio] alsa-sink.c: setting avail_min=1
(  12.683|   0.000) D: [pulseaudio] alsa-mixer.c: Activating path analog-output
(  12.683|   0.000) D: [pulseaudio] alsa-mixer.c: Path analog-output
(Analog Output), direction=1, priority=99, probed=yes, supported=yes,
has_mute=yes, has_volume=yes, has_dB=yes, min_volume=0, max_volume=64,
min_dB=-177, max_dB=2
(  12.683|   0.000) D: [pulseaudio] alsa-mixer.c: Element Master,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x7ffffffffffff,
n_channels=1, override_map=yes
(  12.683|   0.000) D: [pulseaudio] alsa-mixer.c: Element Headphone,
direction=1, switch=1, volume=3, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2,
override_map=no
(  12.683|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2,
override_map=yes
(  12.683|   0.000) D: [pulseaudio] alsa-mixer.c: Element Surround,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x60,
n_channels=2, override_map=yes
(  12.683|   0.000) D: [pulseaudio] alsa-mixer.c: Element Side,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0xc00,
n_channels=2, override_map=yes
(  12.683|   0.000) D: [pulseaudio] alsa-mixer.c: Element Center,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x4900000000018,
n_channels=1, override_map=yes
(  12.683|   0.000) D: [pulseaudio] alsa-mixer.c: Element LFE,
direction=1, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x80,
n_channels=1, override_map=yes
(  12.683|   0.000) D: [pulseaudio] alsa-mixer.c: Element PCM,
direction=1, switch=0, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x3600000000f66,
n_channels=2, override_map=yes
(  12.683|   0.000) D: [pulseaudio] alsa-mixer.c: Element IEC958,
direction=1, switch=2, volume=0, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x0, n_channels=0,
override_map=no
(  12.683|   0.000) I: [pulseaudio] alsa-sink.c: Successfully enabled
deferred volume.
(  12.683|   0.000) I: [pulseaudio] alsa-sink.c: Hardware volume
ranges from -177.00 dB to 2.00 dB.
(  12.683|   0.000) I: [pulseaudio] alsa-sink.c: Fixing base volume to -2.00 dB
(  12.683|   0.000) I: [pulseaudio] alsa-sink.c: Using hardware volume
control. Hardware dB scale supported.
(  12.683|   0.000) I: [pulseaudio] alsa-sink.c: Using hardware mute control.
(  12.683|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_dump():
(  12.683|   0.000) D: [pulseaudio] alsa-util.c: Soft volume PCM
(  12.683|   0.000) D: [pulseaudio] alsa-util.c: Control: PCM Playback Volume
(  12.683|   0.000) D: [pulseaudio] alsa-util.c: min_dB: -51
(  12.683|   0.000) D: [pulseaudio] alsa-util.c: max_dB: 0
(  12.683|   0.000) D: [pulseaudio] alsa-util.c: resolution: 256
(  12.683|   0.000) D: [pulseaudio] alsa-util.c: Its setup is:
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   stream       : PLAYBACK
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   access       :
MMAP_INTERLEAVED
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   format       : S16_LE
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   subformat    : STD
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   channels     : 2
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   rate         : 44100
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   exact rate   :
44100 (44100/1)
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   msbits       : 16
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   buffer_size  : 2028
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   period_size  : 1014
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   period_time  : 22993
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_mode  : ENABLE
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   period_step  : 1
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   avail_min    : 1014
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   period_event : 1
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   start_threshold  : -1
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   stop_threshold   :
9133300044307365888
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   silence_threshold: 0
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   silence_size : 0
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   boundary     :
9133300044307365888
(  12.683|   0.000) D: [pulseaudio] alsa-util.c: Slave: Hardware PCM
card 0 'HDA Intel PCH' device 0 subdevice 0
(  12.683|   0.000) D: [pulseaudio] alsa-util.c: Its setup is:
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   stream       : PLAYBACK
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   access       :
MMAP_INTERLEAVED
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   format       : S16_LE
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   subformat    : STD
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   channels     : 2
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   rate         : 44100
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   exact rate   :
44100 (44100/1)
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   msbits       : 16
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   buffer_size  : 2028
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   period_size  : 1014
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   period_time  : 22993
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_mode  : ENABLE
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   period_step  : 1
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   avail_min    : 1014
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   period_event : 1
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   start_threshold  : -1
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   stop_threshold   :
9133300044307365888
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   silence_threshold: 0
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   silence_size : 0
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   boundary     :
9133300044307365888
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   appl_ptr     : 0
(  12.683|   0.000) D: [pulseaudio] alsa-util.c:   hw_ptr       : 0
(  12.683|   0.000) D: [pulseaudio] alsa-sink.c: Read hardware volume:
0:  76% 1:  76%
(  12.683|   0.000) D: [alsa-sink] alsa-sink.c: Thread starting up
(  12.683|   0.000) D: [pulseaudio] alsa-sink.c:                in dB:
0: -7.20 dB 1: -7.20 dB
(  12.687|   0.003) D: [alsa-sink] core-util.c: RealtimeKit worked.
(  12.687|   0.000) I: [alsa-sink] core-util.c: Successfully enabled
SCHED_RR scheduling for thread, with priority 5.
(  12.687|   0.000) I: [alsa-sink] alsa-sink.c: Starting playback.
(  12.687|   0.000) D: [pulseaudio] module-device-restore.c: Could not
set format on sink alsa_output.pci-0000_00_1b.0.analog-stereo
(  12.687|   0.000) D: [pulseaudio] alsa-util.c: Trying front:0 with
SND_PCM_NO_AUTO_FORMAT ...
(  12.687|   0.000) D: [pulseaudio] alsa-util.c: Managed to open front:0
(  12.687|   0.000) D: [pulseaudio] alsa-util.c: Maximum hw buffer
size is 371 ms
(  12.687|   0.000) D: [pulseaudio] alsa-util.c: Set buffer size first
(to 2028 samples), period size second (to 1014 samples).
(  12.687|   0.000) I: [pulseaudio] alsa-source.c: Successfully opened
device front:0.
(  12.687|   0.000) I: [pulseaudio] alsa-source.c: Selected mapping
'Analog Stereo' (analog-stereo).
(  12.687|   0.000) I: [pulseaudio] alsa-source.c: Successfully
enabled mmap() mode.
(  12.687|   0.000) I: [pulseaudio] (alsa-lib)control.c: Invalid CTL front:0
(  12.687|   0.000) I: [pulseaudio] alsa-util.c: Unable to attach to
mixer front:0: No such file or directory
(  12.687|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached
to mixer 'hw:0'
(  12.688|   0.000) D: [pulseaudio] alsa-mixer.c: Added 3 ports
(  12.688|   0.000) D: [pulseaudio] core-subscribe.c: Dropped
redundant event due to change event.
(  12.688|   0.000) D: [pulseaudio] module-device-restore.c: Database
contains invalid data for key:
source:alsa_input.pci-0000_00_1b.0.analog-stereo:null
(  12.688|   0.000) I: [pulseaudio] source.c: Created source 2
"alsa_input.pci-0000_00_1b.0.analog-stereo" with sample spec s16le 2ch
44100Hz and channel map front-left,front-right
(  12.688|   0.000) I: [pulseaudio] source.c:     alsa.resolution_bits = "16"
(  12.688|   0.000) I: [pulseaudio] source.c:     device.api = "alsa"
(  12.688|   0.000) I: [pulseaudio] source.c:     device.class = "sound"
(  12.688|   0.000) I: [pulseaudio] source.c:     alsa.class = "generic"
(  12.688|   0.000) I: [pulseaudio] source.c:     alsa.subclass = "generic-mix"
(  12.688|   0.000) I: [pulseaudio] source.c:     alsa.name = "ALC889 Analog"
(  12.688|   0.000) I: [pulseaudio] source.c:     alsa.id = "ALC889 Analog"
(  12.688|   0.000) I: [pulseaudio] source.c:     alsa.subdevice = "0"
(  12.688|   0.000) I: [pulseaudio] source.c:     alsa.subdevice_name
= "subdevice #0"
(  12.688|   0.000) I: [pulseaudio] source.c:     alsa.device = "0"
(  12.688|   0.000) I: [pulseaudio] source.c:     alsa.card = "0"
(  12.688|   0.000) I: [pulseaudio] source.c:     alsa.card_name =
"HDA Intel PCH"
(  12.688|   0.000) I: [pulseaudio] source.c:     alsa.long_card_name
= "HDA Intel PCH at 0xf7420000 irq 54"
(  12.688|   0.000) I: [pulseaudio] source.c:     alsa.driver_name =
"snd_hda_intel"
(  12.688|   0.000) I: [pulseaudio] source.c:     device.bus_path =
"pci-0000:00:1b.0"
(  12.688|   0.000) I: [pulseaudio] source.c:     sysfs.path =
"/devices/pci0000:00/0000:00:1b.0/sound/card0"
(  12.688|   0.000) I: [pulseaudio] source.c:     device.bus = "pci"
(  12.688|   0.000) I: [pulseaudio] source.c:     device.vendor.id = "8086"
(  12.688|   0.000) I: [pulseaudio] source.c:     device.vendor.name =
"Intel Corporation"
(  12.688|   0.000) I: [pulseaudio] source.c:     device.product.name
= "6 Series/C200 Series Chipset Family High Definition Audio
Controller"
(  12.688|   0.000) I: [pulseaudio] source.c:     device.form_factor =
"internal"
(  12.688|   0.000) I: [pulseaudio] source.c:     device.string = "front:0"
(  12.688|   0.000) I: [pulseaudio] source.c:
device.buffering.buffer_size = "8112"
(  12.688|   0.000) I: [pulseaudio] source.c:
device.buffering.fragment_size = "4056"
(  12.688|   0.000) I: [pulseaudio] source.c:     device.access_mode = "mmap"
(  12.688|   0.000) I: [pulseaudio] source.c:     device.profile.name
= "analog-stereo"
(  12.688|   0.000) I: [pulseaudio] source.c:
device.profile.description = "Analog Stereo"
(  12.688|   0.000) I: [pulseaudio] source.c:     device.description =
"Built-in Audio Analog Stereo"
(  12.688|   0.000) I: [pulseaudio] source.c:     alsa.mixer_name =
"Realtek ALC889"
(  12.688|   0.000) I: [pulseaudio] source.c:     alsa.components =
"HDA:10ec0889,1043846b,00100004"
(  12.688|   0.000) I: [pulseaudio] source.c:
module-udev-detect.discovered = "1"
(  12.688|   0.000) I: [pulseaudio] source.c:     device.icon_name =
"audio-card-pci"
(  12.688|   0.000) I: [pulseaudio] alsa-source.c: Using 2.0 fragments
of size 4056 bytes (22.99ms), buffer size is 8112 bytes (45.99ms)
(  12.688|   0.000) D: [pulseaudio] alsa-source.c: hwbuf_unused=0
(  12.688|   0.000) D: [pulseaudio] alsa-source.c: setting avail_min=1
(  12.688|   0.000) D: [pulseaudio] alsa-mixer.c: Activating path
analog-input-microphone-front
(  12.688|   0.000) D: [pulseaudio] alsa-mixer.c: Path
analog-input-microphone-front (Front Microphone), direction=2,
priority=85, probed=yes, supported=yes, has_mute=yes, has_volume=yes,
has_dB=yes, min_volume=0, max_volume=3, min_dB=-16, max_dB=60
(  12.688|   0.000) D: [pulseaudio] alsa-mixer.c: Element Front Mic
Boost, direction=2, switch=0, volume=1, volume_limit=-1,
enumeration=0, required=0, required_any=4, required_absent=0,
mask=0x3600000000f66, n_channels=2, override_map=yes
(  12.688|   0.000) D: [pulseaudio] alsa-mixer.c: Element Capture,
direction=2, switch=1, volume=1, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x3600000000f66,
n_channels=2, override_map=yes
(  12.688|   0.000) D: [pulseaudio] alsa-mixer.c: Element Input
Source, direction=2, switch=0, volume=0, volume_limit=-1,
enumeration=1, required=0, required_any=0, required_absent=0,
mask=0x0, n_channels=0, override_map=no
(  12.688|   0.000) D: [pulseaudio] alsa-mixer.c: Option Front Mic
(analog-input-microphone-front/analog-input-microphone-front) index=0,
priority=0
(  12.688|   0.000) D: [pulseaudio] alsa-mixer.c: Element Rear Mic
Boost, direction=2, switch=0, volume=2, volume_limit=-1,
enumeration=0, required=0, required_any=0, required_absent=0,
mask=0x6, n_channels=2, override_map=no
(  12.688|   0.000) D: [pulseaudio] alsa-mixer.c: Element Line Boost,
direction=2, switch=0, volume=2, volume_limit=-1, enumeration=0,
required=0, required_any=0, required_absent=0, mask=0x6, n_channels=2,
override_map=no
(  12.688|   0.000) D: [pulseaudio] alsa-mixer.c: Jack Front Mic,
alsa_name='Front Mic Jack', detection possible
(  12.688|   0.000) D: [pulseaudio] alsa-mixer.c: Setting
analog-input-microphone-front (analog-input-microphone-front)
priority=0
(  12.688|   0.000) I: [pulseaudio] alsa-source.c: Successfully
enabled deferred volume.
(  12.688|   0.000) I: [pulseaudio] alsa-source.c: Hardware volume
ranges from -16.00 dB to 60.00 dB.
(  12.688|   0.000) I: [pulseaudio] alsa-source.c: Fixing base volume
to -60.00 dB
(  12.688|   0.000) I: [pulseaudio] alsa-source.c: Using hardware
volume control. Hardware dB scale supported.
(  12.688|   0.000) I: [pulseaudio] alsa-source.c: Using hardware mute control.
(  12.688|   0.000) D: [pulseaudio] alsa-util.c: snd_pcm_dump():
(  12.688|   0.000) D: [pulseaudio] alsa-util.c: Hardware PCM card 0
'HDA Intel PCH' device 0 subdevice 0
(  12.688|   0.000) D: [pulseaudio] alsa-util.c: Its setup is:
(  12.688|   0.000) D: [pulseaudio] alsa-util.c:   stream       : CAPTURE
(  12.688|   0.000) D: [pulseaudio] alsa-util.c:   access       :
MMAP_INTERLEAVED
(  12.688|   0.000) D: [pulseaudio] alsa-util.c:   format       : S16_LE
(  12.688|   0.000) D: [pulseaudio] alsa-util.c:   subformat    : STD
(  12.688|   0.000) D: [pulseaudio] alsa-util.c:   channels     : 2
(  12.688|   0.000) D: [pulseaudio] alsa-util.c:   rate         : 44100
(  12.688|   0.000) D: [pulseaudio] alsa-util.c:   exact rate   :
44100 (44100/1)
(  12.688|   0.000) D: [pulseaudio] alsa-util.c:   msbits       : 16
(  12.688|   0.000) D: [pulseaudio] alsa-util.c:   buffer_size  : 2028
(  12.688|   0.000) D: [pulseaudio] alsa-util.c:   period_size  : 1014
(  12.688|   0.000) D: [pulseaudio] alsa-util.c:   period_time  : 22993
(  12.688|   0.000) D: [pulseaudio] alsa-util.c:   tstamp_mode  : ENABLE
(  12.688|   0.000) D: [pulseaudio] alsa-util.c:   period_step  : 1
(  12.688|   0.000) D: [pulseaudio] alsa-util.c:   avail_min    : 1014
(  12.688|   0.000) D: [pulseaudio] alsa-util.c:   period_event : 1
(  12.688|   0.000) D: [pulseaudio] alsa-util.c:   start_threshold  : -1
(  12.688|   0.000) D: [pulseaudio] alsa-util.c:   stop_threshold   :
9133300044307365888
(  12.688|   0.000) D: [pulseaudio] alsa-util.c:   silence_threshold: 0
(  12.688|   0.000) D: [pulseaudio] alsa-util.c:   silence_size : 0
(  12.688|   0.000) D: [pulseaudio] alsa-util.c:   boundary     :
9133300044307365888
(  12.688|   0.000) D: [pulseaudio] alsa-util.c:   appl_ptr     : 0
(  12.688|   0.000) D: [pulseaudio] alsa-util.c:   hw_ptr       : 0
(  12.688|   0.000) D: [pulseaudio] alsa-source.c: Read hardware
volume: 0:   5% 1:   5%
(  12.688|   0.000) D: [alsa-source] alsa-source.c: Thread starting up
(  12.688|   0.000) D: [pulseaudio] alsa-source.c:                in
dB: 0: -76.00 dB 1: -76.00 dB
(  12.691|   0.002) D: [alsa-source] core-util.c: RealtimeKit worked.
(  12.691|   0.000) I: [alsa-source] core-util.c: Successfully enabled
SCHED_RR scheduling for thread, with priority 5.
(  12.691|   0.000) I: [alsa-source] alsa-source.c: Starting capture.
(  12.691|   0.000) D: [pulseaudio] module-alsa-card.c: Found 4 jacks.
(  12.691|   0.000) I: [pulseaudio] alsa-util.c: Successfully attached
to mixer 'hw:0'
(  12.691|   0.000) D: [pulseaudio] module-alsa-card.c: Jack 'Front
Headphone Jack' is now unplugged
(  12.691|   0.000) D: [pulseaudio] device-port.c: Setting port
analog-output-headphones to status no
(  12.691|   0.000) D: [pulseaudio] core-subscribe.c: Dropped
redundant event due to change event.
(  12.691|   0.000) D: [pulseaudio] module-alsa-card.c: Jack 'Front
Mic Jack' is now unplugged
(  12.691|   0.000) D: [pulseaudio] device-port.c: Setting port
analog-input-microphone-front to status no
(  12.691|   0.000) D: [pulseaudio] core-subscribe.c: Dropped
redundant event due to change event.
(  12.691|   0.000) D: [pulseaudio] module-alsa-card.c: Jack 'Rear Mic
Jack' is now unplugged
(  12.691|   0.000) D: [pulseaudio] device-port.c: Setting port
analog-input-microphone-rear to status no
(  12.691|   0.000) D: [pulseaudio] core-subscribe.c: Dropped
redundant event due to change event.
(  12.691|   0.000) D: [pulseaudio] module-alsa-card.c: Jack 'Line
Jack' is now unplugged
(  12.691|   0.000) D: [pulseaudio] device-port.c: Setting port
analog-input-linein to status no
(  12.691|   0.000) D: [pulseaudio] core-subscribe.c: Dropped
redundant event due to change event.
(  12.691|   0.000) I: [pulseaudio] module.c: Loaded
"module-alsa-card" (index: #5; argument: "device_id="0"
name="pci-0000_00_1b.0" card_name="alsa_card.pci-0000_00_1b.0"
namereg_fail=false tsched=no fixed_latency_range=no ignore_dB=no
deferred_volume=yes use_ucm=yes
card_properties="module-udev-detect.discovered=1"").
(  12.691|   0.000) I: [pulseaudio] module-udev-detect.c: Card
/devices/pci0000:00/0000:00:1b.0/sound/card0
(alsa_card.pci-0000_00_1b.0) module loaded.
(  12.691|   0.000) I: [pulseaudio] module-udev-detect.c: Found 2 cards.
(  12.691|   0.000) I: [pulseaudio] module.c: Loaded
"module-udev-detect" (index: #6; argument: "tsched=0").
(  12.691|   0.000) D: [pulseaudio] cli-command.c: Checking for
existence of '/usr/lib/pulse-3.0/modules/module-jackdbus-detect.so':
failure
(  12.691|   0.000) D: [pulseaudio] cli-command.c: Checking for
existence of '/usr/lib/pulse-3.0/modules/module-bluetooth-policy.so':
success
(  12.692|   0.000) I: [pulseaudio] module.c: Loaded
"module-bluetooth-policy" (index: #7; argument: "").
(  12.692|   0.000) D: [pulseaudio] cli-command.c: Checking for
existence of '/usr/lib/pulse-3.0/modules/module-bluetooth-discover.so':
success
(  12.692|   0.000) D: [pulseaudio] dbus-util.c: Successfully
connected to D-Bus system bus 200a58f6723ca27a0d9b04b351ed7524 as
:1.89
(  12.693|   0.000) D: [pulseaudio] bluetooth-util.c: dbus:
interface=org.freedesktop.DBus, path=/org/freedesktop/DBus,
member=NameAcquired
(  12.693|   0.000) I: [pulseaudio] module.c: Loaded
"module-bluetooth-discover" (index: #8; argument: "").
(  12.693|   0.000) D: [pulseaudio] cli-command.c: Checking for
existence of '/usr/lib/pulse-3.0/modules/module-esound-protocol-unix.so':
failure
(  12.694|   0.000) I: [pulseaudio] module.c: Loaded
"module-native-protocol-unix" (index: #9; argument: "").
(  12.694|   0.000) D: [pulseaudio] cli-command.c: Checking for
existence of '/usr/lib/pulse-3.0/modules/module-gconf.so': failure
(  12.694|   0.000) D: [pulseaudio] core-subscribe.c: Dropped
redundant event due to change event.
(  12.694|   0.000) I: [pulseaudio] module-default-device-restore.c:
Restored default sink 'alsa_output.pci-0000_00_1b.0.analog-stereo'.
(  12.694|   0.000) D: [pulseaudio] core-subscribe.c: Dropped
redundant event due to change event.
(  12.694|   0.000) I: [pulseaudio] module-default-device-restore.c:
Restored default source 'alsa_input.pci-0000_00_1b.0.analog-stereo'.
(  12.694|   0.000) I: [pulseaudio] module.c: Loaded
"module-default-device-restore" (index: #10; argument: "").
(  12.694|   0.000) I: [pulseaudio] module.c: Loaded
"module-rescue-streams" (index: #11; argument: "").
(  12.694|   0.000) I: [pulseaudio] module.c: Loaded
"module-always-sink" (index: #12; argument: "").
(  12.694|   0.000) I: [pulseaudio] module.c: Loaded
"module-intended-roles" (index: #13; argument: "").
(  12.695|   0.000) D: [pulseaudio] module-suspend-on-idle.c: Sink
alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1 becomes idle, timeout
in 5 seconds.
(  12.695|   0.000) D: [pulseaudio] module-suspend-on-idle.c: Sink
alsa_output.pci-0000_00_1b.0.analog-stereo becomes idle, timeout in 5
seconds.
(  12.695|   0.000) D: [pulseaudio] module-suspend-on-idle.c: Source
alsa_input.pci-0000_00_1b.0.analog-stereo becomes idle, timeout in 5
seconds.
(  12.695|   0.000) I: [pulseaudio] module.c: Loaded
"module-suspend-on-idle" (index: #14; argument: "").
(  12.695|   0.000) D: [pulseaudio] cli-command.c: Checking for
existence of '/usr/lib/pulse-3.0/modules/module-console-kit.so':
success
(  12.695|   0.000) I: [pulseaudio] client.c: Created 0 "ConsoleKit
Session /org/freedesktop/ConsoleKit/Session2"
(  12.695|   0.000) D: [pulseaudio] module-console-kit.c: Added new
session /org/freedesktop/ConsoleKit/Session2
(  12.695|   0.000) I: [pulseaudio] module.c: Loaded
"module-console-kit" (index: #15; argument: "").
(  12.695|   0.000) D: [pulseaudio] cli-command.c: Checking for
existence of '/usr/lib/pulse-3.0/modules/module-systemd-login.so':
failure
(  12.695|   0.000) I: [pulseaudio] module.c: Loaded
"module-position-event-sounds" (index: #16; argument: "").
(  12.696|   0.000) I: [pulseaudio] module.c: Loaded
"module-filter-heuristics" (index: #17; argument: "").
(  12.696|   0.000) I: [pulseaudio] module.c: Loaded
"module-filter-apply" (index: #18; argument: "").
(  12.696|   0.000) D: [pulseaudio] module-switch-on-port-available.c:
finding port hdmi-output-0
(  12.696|   0.000) D: [pulseaudio] module-switch-on-port-available.c:
finding port hdmi-output-1
(  12.696|   0.000) D: [pulseaudio] module-switch-on-port-available.c:
finding port hdmi-output-2
(  12.696|   0.000) D: [pulseaudio] module-switch-on-port-available.c:
finding port hdmi-output-3
(  12.696|   0.000) D: [pulseaudio] module-switch-on-port-available.c:
finding port analog-input-microphone-front
(  12.696|   0.000) D: [pulseaudio] module-switch-on-port-available.c:
finding port analog-input-microphone-rear
(  12.696|   0.000) D: [pulseaudio] module-switch-on-port-available.c:
finding port analog-input-linein
(  12.696|   0.000) D: [pulseaudio] module-switch-on-port-available.c:
finding port analog-output-headphones
(  12.696|   0.000) I: [pulseaudio] module.c: Loaded
"module-switch-on-port-available" (index: #19; argument: "").
(  12.696|   0.000) D: [pulseaudio] main.c: Got org.PulseAudio1!
(  12.697|   0.000) D: [pulseaudio] main.c: Got org.pulseaudio.Server!
(  12.697|   0.000) I: [pulseaudio] main.c: Daemon startup complete.
(  12.697|   0.000) I: [pulseaudio] client.c: Created 1 "Native client
(UNIX socket client)"
(  12.697|   0.000) D: [pulseaudio] module-udev-detect.c:
/dev/snd/controlC1 is accessible: yes
(  12.697|   0.000) D: [pulseaudio] module-udev-detect.c:
/dev/snd/controlC0 is accessible: yes
(  12.697|   0.000) I: [pulseaudio] client.c: Created 2 "Native client
(UNIX socket client)"
(  12.697|   0.000) D: [pulseaudio] protocol-native.c: Protocol
version: remote 27, local 27
(  12.697|   0.000) I: [pulseaudio] protocol-native.c: Got
credentials: uid=1000 gid=1000 success=1
(  12.697|   0.000) D: [pulseaudio] protocol-native.c: SHM possible: yes
(  12.697|   0.000) D: [pulseaudio] protocol-native.c: Negotiated SHM: yes
(  12.697|   0.000) D: [pulseaudio] protocol-native.c: Protocol
version: remote 27, local 27
(  12.697|   0.000) I: [pulseaudio] protocol-native.c: Got
credentials: uid=1000 gid=1000 success=1
(  12.697|   0.000) D: [pulseaudio] protocol-native.c: SHM possible: yes
(  12.697|   0.000) D: [pulseaudio] protocol-native.c: Negotiated SHM: yes
(  12.697|   0.000) D: [pulseaudio] module-augment-properties.c:
Looking for .desktop file for indicator-sound-service
(  12.697|   0.000) D: [pulseaudio] module-augment-properties.c:
Looking for .desktop file for gnome-settings-daemon
(  17.697|   5.000) I: [pulseaudio] module-suspend-on-idle.c: Source
alsa_input.pci-0000_00_1b.0.analog-stereo idle for too long,
suspending ...
(  17.698|   0.000) D: [pulseaudio] source.c: Suspend cause of source
alsa_input.pci-0000_00_1b.0.analog-stereo is 0x0004, suspending
(  17.698|   0.000) I: [alsa-source] alsa-source.c: Device suspended...
(  17.698|   0.000) D: [pulseaudio] core.c: Hmm, no streams around,
trying to vacuum.
(  17.698|   0.000) I: [pulseaudio] module-suspend-on-idle.c: Sink
alsa_output.pci-0000_00_1b.0.analog-stereo idle for too long,
suspending ...
(  17.698|   0.000) D: [pulseaudio] sink.c: Suspend cause of sink
alsa_output.pci-0000_00_1b.0.analog-stereo is 0x0004, suspending
(  17.699|   0.001) I: [alsa-sink] alsa-sink.c: Device suspended...
(  17.699|   0.000) D: [pulseaudio] core.c: Hmm, no streams around,
trying to vacuum.
(  17.699|   0.000) I: [pulseaudio] module-suspend-on-idle.c: Sink
alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1 idle for too long,
suspending ...
(  17.699|   0.000) D: [pulseaudio] sink.c: Suspend cause of sink
alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1 is 0x0004, suspending
(  17.700|   0.000) I: [alsa-sink] alsa-sink.c: Device suspended...
(  17.700|   0.000) D: [pulseaudio] core.c: Hmm, no streams around,
trying to vacuum.
(  17.700|   0.000) D: [pulseaudio] module-udev-detect.c:
/dev/snd/controlC1 is accessible: yes
(  17.700|   0.000) D: [pulseaudio] module-udev-detect.c:
/dev/snd/controlC0 is accessible: yes
(  19.383|   1.683) I: [pulseaudio] client.c: Created 3 "Native client
(UNIX socket client)"
(  19.537|   0.153) D: [pulseaudio] protocol-native.c: Protocol
version: remote 27, local 27
(  19.537|   0.000) I: [pulseaudio] protocol-native.c: Got
credentials: uid=1000 gid=1000 success=1
(  19.537|   0.000) D: [pulseaudio] protocol-native.c: SHM possible: yes
(  19.537|   0.000) D: [pulseaudio] protocol-native.c: Negotiated SHM: yes
(  19.565|   0.028) D: [pulseaudio] module-augment-properties.c:
Looking for .desktop file for gnome-control-center
(  19.565|   0.000) D: [pulseaudio] module-augment-properties.c: Found
/usr/share/applications/gnome-control-center.desktop.
(  30.916|  11.350) I: [pulseaudio] client.c: Freed 3 "GNOME Volume
Control Dialog"
(  30.916|   0.000) I: [pulseaudio] protocol-native.c: Connection died.
(  71.860|  40.944) I: [pulseaudio] main.c: Got signal SIGINT.
(  71.860|   0.000) I: [pulseaudio] main.c: Exiting.
(  71.860|   0.000) I: [pulseaudio] main.c: Daemon shutdown initiated.
(  71.860|   0.000) I: [pulseaudio] module.c: Unloading
"module-device-restore" (index: #0).
(  71.860|   0.000) I: [pulseaudio] module.c: Unloaded
"module-device-restore" (index: #0).
(  71.860|   0.000) I: [pulseaudio] module.c: Unloading
"module-stream-restore" (index: #1).
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1 removed from object
/org/pulseaudio/stream_restore1
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry0
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry1
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry2
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry3
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry4
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry5
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry6
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry7
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry8
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry9
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry10
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry11
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry12
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry13
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry14
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry15
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry16
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry17
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry18
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry19
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry20
(  71.860|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry21
(  71.860|   0.000) D: [pulseaudio] flist.c: pulsecore/hashmap.c:
entries flist is full (don't worry)
(  71.861|   0.000) D: [pulseaudio] flist.c: pulsecore/hashmap.c:
entries flist is full (don't worry)
(  71.861|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry22
(  71.861|   0.000) D: [pulseaudio] flist.c: pulsecore/hashmap.c:
entries flist is full (don't worry)
(  71.861|   0.000) D: [pulseaudio] flist.c: pulsecore/hashmap.c:
entries flist is full (don't worry)
(  71.861|   0.000) D: [pulseaudio] flist.c: pulsecore/hashmap.c:
entries flist is full (don't worry)
(  71.861|   0.000) D: [pulseaudio] flist.c: pulsecore/hashmap.c:
entries flist is full (don't worry)
(  71.861|   0.000) D: [pulseaudio] flist.c: pulsecore/hashmap.c:
entries flist is full (don't worry)
(  71.861|   0.000) D: [pulseaudio] flist.c: pulsecore/hashmap.c:
entries flist is full (don't worry)
(  71.861|   0.000) D: [pulseaudio] flist.c: pulsecore/hashmap.c:
entries flist is full (don't worry)
(  71.861|   0.000) D: [pulseaudio] flist.c: pulsecore/hashmap.c:
entries flist is full (don't worry)
(  71.861|   0.000) D: [pulseaudio] flist.c: pulsecore/hashmap.c:
entries flist is full (don't worry)
(  71.861|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry23
(  71.861|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry24
(  71.861|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry25
(  71.861|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry26
(  71.861|   0.000) D: [pulseaudio] protocol-dbus.c: Interface
org.PulseAudio.Ext.StreamRestore1.RestoreEntry removed from object
/org/pulseaudio/stream_restore1/entry27
(  71.861|   0.000) I: [pulseaudio] module.c: Unloaded
"module-stream-restore" (index: #1).
(  71.861|   0.000) I: [pulseaudio] module.c: Unloading
"module-card-restore" (index: #2).
(  71.861|   0.000) I: [pulseaudio] module.c: Unloaded
"module-card-restore" (index: #2).
(  71.861|   0.000) I: [pulseaudio] module.c: Unloading
"module-augment-properties" (index: #3).
(  71.861|   0.000) I: [pulseaudio] module.c: Unloaded
"module-augment-properties" (index: #3).
(  71.861|   0.000) I: [pulseaudio] module.c: Unloading
"module-alsa-card" (index: #4).
(  71.861|   0.000) D: [pulseaudio] module-rescue-streams.c: No sink
inputs to move away.
(  71.861|   0.000) D: [pulseaudio] module-rescue-streams.c: No source
outputs to move away.
(  71.861|   0.000) D: [alsa-sink] alsa-sink.c: Thread shutting down
(  71.861|   0.000) I: [pulseaudio] sink.c: Freeing sink 0
"alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1"
(  71.861|   0.000) I: [pulseaudio] source.c: Freeing source 0
"alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1.monitor"
(  71.861|   0.000) I: [pulseaudio] card.c: Freed 0 "alsa_card.pci-0000_01_00.1"
(  71.861|   0.000) I: [pulseaudio] module.c: Unloaded
"module-alsa-card" (index: #4).
(  71.861|   0.000) I: [pulseaudio] module.c: Unloading
"module-alsa-card" (index: #5).
(  71.861|   0.000) D: [pulseaudio] module-always-sink.c: Autoloading
null-sink as no other sinks detected.
(  71.861|   0.000) I: [pulseaudio] sink.c: Created sink 2 "auto_null"
with sample spec s16le 2ch 44100Hz and channel map
front-left,front-right
(  71.861|   0.000) I: [pulseaudio] sink.c:     device.description =
"Dummy Output"
(  71.861|   0.000) I: [pulseaudio] sink.c:     device.class = "abstract"
(  71.861|   0.000) I: [pulseaudio] sink.c:     device.icon_name = "audio-card"
(  71.862|   0.000) I: [pulseaudio] source.c: Created source 3
"auto_null.monitor" with sample spec s16le 2ch 44100Hz and channel map
front-left,front-right
(  71.862|   0.000) I: [pulseaudio] source.c:     device.description =
"Monitor of Dummy Output"
(  71.862|   0.000) I: [pulseaudio] source.c:     device.class = "monitor"
(  71.862|   0.000) I: [pulseaudio] source.c:     device.icon_name =
"audio-input-microphone"
(  71.862|   0.000) D: [null-sink] module-null-sink.c: Thread starting up
(  71.862|   0.000) D: [pulseaudio] module-suspend-on-idle.c: Sink
auto_null becomes idle, timeout in 5 seconds.
(  71.862|   0.000) I: [pulseaudio] module.c: Loaded
"module-null-sink" (index: #20; argument: "sink_name=auto_null
sink_properties='device.description="Dummy Output"'").
(  71.862|   0.000) D: [pulseaudio] module-rescue-streams.c: No sink
inputs to move away.
(  71.862|   0.000) D: [pulseaudio] module-rescue-streams.c: No source
outputs to move away.
(  71.862|   0.000) D: [alsa-sink] alsa-sink.c: Thread shutting down
(  71.862|   0.000) I: [pulseaudio] sink.c: Freeing sink 1
"alsa_output.pci-0000_00_1b.0.analog-stereo"
(  71.862|   0.000) I: [pulseaudio] source.c: Freeing source 1
"alsa_output.pci-0000_00_1b.0.analog-stereo.monitor"
(  71.862|   0.000) D: [pulseaudio] module-rescue-streams.c: No source
outputs to move away.
(  71.862|   0.000) D: [pulseaudio] core-subscribe.c: Dropped
redundant event due to change event.
(  71.862|   0.000) D: [alsa-source] alsa-source.c: Thread shutting down
(  71.862|   0.000) I: [pulseaudio] source.c: Freeing source 2
"alsa_input.pci-0000_00_1b.0.analog-stereo"
(  71.862|   0.000) I: [pulseaudio] card.c: Freed 1 "alsa_card.pci-0000_00_1b.0"
(  71.862|   0.000) I: [pulseaudio] module.c: Unloaded
"module-alsa-card" (index: #5).
(  71.862|   0.000) I: [pulseaudio] module.c: Unloading
"module-udev-detect" (index: #6).
(  71.862|   0.000) I: [pulseaudio] module.c: Unloaded
"module-udev-detect" (index: #6).
(  71.862|   0.000) I: [pulseaudio] module.c: Unloading
"module-bluetooth-policy" (index: #7).
(  71.862|   0.000) I: [pulseaudio] module.c: Unloaded
"module-bluetooth-policy" (index: #7).
(  71.862|   0.000) I: [pulseaudio] module.c: Unloading
"module-bluetooth-discover" (index: #8).
(  71.863|   0.000) I: [pulseaudio] module.c: Unloaded
"module-bluetooth-discover" (index: #8).
(  71.863|   0.000) I: [pulseaudio] module.c: Unloading
"module-native-protocol-unix" (index: #9).
(  71.863|   0.000) I: [pulseaudio] client.c: Freed 1 "Indicator Sound"
(  71.863|   0.000) I: [pulseaudio] client.c: Freed 2 "GNOME Volume
Control Media Keys"
(  71.863|   0.000) I: [pulseaudio] module.c: Unloaded
"module-native-protocol-unix" (index: #9).
(  71.863|   0.000) I: [pulseaudio] module.c: Unloading
"module-default-device-restore" (index: #10).
(  71.863|   0.000) I: [pulseaudio] module.c: Unloaded
"module-default-device-restore" (index: #10).
(  71.863|   0.000) I: [pulseaudio] module.c: Unloading
"module-rescue-streams" (index: #11).
(  71.863|   0.000) I: [pulseaudio] module.c: Unloaded
"module-rescue-streams" (index: #11).
(  71.863|   0.000) I: [pulseaudio] module.c: Unloading
"module-always-sink" (index: #12).
(  71.863|   0.000) I: [pulseaudio] module.c: Unloaded
"module-always-sink" (index: #12).
(  71.863|   0.000) I: [pulseaudio] module.c: Unloading
"module-intended-roles" (index: #13).
(  71.863|   0.000) I: [pulseaudio] module.c: Unloaded
"module-intended-roles" (index: #13).
(  71.863|   0.000) I: [pulseaudio] module.c: Unloading
"module-suspend-on-idle" (index: #14).
(  71.863|   0.000) I: [pulseaudio] module.c: Unloaded
"module-suspend-on-idle" (index: #14).
(  71.863|   0.000) I: [pulseaudio] module.c: Unloading
"module-console-kit" (index: #15).
(  71.863|   0.000) D: [pulseaudio] module-console-kit.c: Removing
session /org/freedesktop/ConsoleKit/Session2
(  71.863|   0.000) I: [pulseaudio] client.c: Freed 0 "ConsoleKit
Session /org/freedesktop/ConsoleKit/Session2"
(  71.863|   0.000) I: [pulseaudio] module.c: Unloaded
"module-console-kit" (index: #15).
(  71.863|   0.000) I: [pulseaudio] module.c: Unloading
"module-position-event-sounds" (index: #16).
(  71.863|   0.000) I: [pulseaudio] module.c: Unloaded
"module-position-event-sounds" (index: #16).
(  71.863|   0.000) I: [pulseaudio] module.c: Unloading
"module-filter-heuristics" (index: #17).
(  71.863|   0.000) I: [pulseaudio] module.c: Unloaded
"module-filter-heuristics" (index: #17).
(  71.863|   0.000) I: [pulseaudio] module.c: Unloading
"module-filter-apply" (index: #18).
(  71.863|   0.000) I: [pulseaudio] module.c: Unloaded
"module-filter-apply" (index: #18).
(  71.863|   0.000) I: [pulseaudio] module.c: Unloading
"module-switch-on-port-available" (index: #19).
(  71.863|   0.000) I: [pulseaudio] module.c: Unloaded
"module-switch-on-port-available" (index: #19).
(  71.863|   0.000) I: [pulseaudio] module.c: Unloading
"module-null-sink" (index: #20).
(  71.863|   0.000) D: [pulseaudio] core-subscribe.c: Dropped
redundant event due to remove event.
(  71.863|   0.000) D: [pulseaudio] core-subscribe.c: Dropped
redundant event due to remove event.
(  71.863|   0.000) D: [pulseaudio] core-subscribe.c: Dropped
redundant event due to remove event.
(  71.863|   0.000) D: [pulseaudio] core-subscribe.c: Dropped
redundant event due to remove event.
(  71.864|   0.000) D: [null-sink] module-null-sink.c: Thread shutting down
(  71.864|   0.000) I: [pulseaudio] sink.c: Freeing sink 2 "auto_null"
(  71.864|   0.000) I: [pulseaudio] source.c: Freeing source 3
"auto_null.monitor"
(  71.864|   0.000) I: [pulseaudio] module.c: Unloaded
"module-null-sink" (index: #20).
(  71.864|   0.000) D: [pulseaudio] core-subscribe.c: Dropped
redundant event due to remove event.
(  71.864|   0.000) I: [pulseaudio] main.c: Daemon terminated.
