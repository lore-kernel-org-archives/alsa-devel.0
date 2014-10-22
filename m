From: "Joshua J. Kugler" <joshua@azariah.com>
Subject: Re: [pulseaudio-discuss] Problem with timing and USB
	scanning...
Date: Wed, 22 Oct 2014 12:36:30 -0800
Message-ID: <6193432.QnYu1kqnSE@hosanna>
References: <5078808.P2JmJn6G2E@hosanna>
 <CAN8ccibJ=HKhXdjTaRbtXjBjJKUXHQ5WpJ_vjW_ZVsKWqV-KUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1801830.RAKFpmdGti"
Content-Transfer-Encoding: 7Bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homiemail-a96.g.dreamhost.com (sub4.mail.dreamhost.com
 [69.163.253.135])
 by alsa0.perex.cz (Postfix) with ESMTP id BE04D265300
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 22:36:36 +0200 (CEST)
In-Reply-To: <CAN8ccibJ=HKhXdjTaRbtXjBjJKUXHQ5WpJ_vjW_ZVsKWqV-KUQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: pulseaudio-discuss@lists.freedesktop.org
Cc: Raymond Yau <superquad.vortex2@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--nextPart1801830.RAKFpmdGti
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, October 22, 2014 12:10:46 Raymond Yau wrote:
> > Howdy! I have a situation where PulseAudio is "grabbing" a usb headset
> 
> before
> 
> > fully initialized, thus not all features are being recognized.
> 
> > More details here:
> https://askubuntu.com/questions/537166/usb%2daudio%2ddevice%2dnot%2dfully%2d
> working%2dafter%2dhotplug
> 
> You have to post output of alsa-info.sh and pactl list before and after the
> hot plug

This does not have my web cam attached.

Files attached. I also did a pulse restart, and captured the pactl list output 
after that too.

> This look like priority issue if you have usb web cam mic and hotplug usb
> headset
> 
> 
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/usb/mixer.c?id=9fcd0ab130579d9742538340edda3225f2b49a3e

This happens even without the USB web cam plugged in.

> Another issue is some usb devices only obtained dB scale at a later time
> after the control is created
> 
> This may need some delay for pulseaudio to get dB scale
> 
> You can add printk statement to find out how much time you need

I've done zero kernel hacking, so can't really help there, sorry!

j

-- 
Joshua J. Kugler - Fairbanks, Alaska
Azariah Enterprises - Programming and Website Design
joshua@azariah.com - Jabber: pedahzur@gmail.com
PGP Key: http://pgp.mit.edu/  ID 0x73B13B6A
--nextPart1801830.RAKFpmdGti
Content-Disposition: attachment; filename="alsa-info-after-plug.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="alsa-info-after-plug.txt"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.64
!!################################

!!Script ran on: Wed Oct 22 20:32:21 UTC 2014


!!Linux Distribution
!!------------------

Ubuntu 14.04.1 LTS \n \l DISTRIB_ID=Ubuntu DISTRIB_DESCRIPTION="Ubuntu 14.04.1 LTS" NAME="Ubuntu" ID=ubuntu ID_LIKE=debian PRETTY_NAME="Ubuntu 14.04.1 LTS" HOME_URL="http://www.ubuntu.com/" SUPPORT_URL="http://help.ubuntu.com/" BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"


!!DMI Information
!!---------------

Manufacturer:      System76, Inc.                          
Product Name:      Bonobo Professional
Product Version:   bonp5                    
Firmware Version:  4.6.4


!!Kernel Information
!!------------------

Kernel release:    3.13.0-37-generic
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         x86_64
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k3.13.0-37-generic
Library version:    1.0.27.2
Utilities version:  1.0.27.2


!!Loaded ALSA modules
!!-------------------

snd_hda_intel
snd_usb_audio
snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - Yes


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xf6500000 irq 52
 1 [USB            ]: USB-Audio - GN 2000 USB
                      GN Netcom GN 2000 USB at usb-0000:00:1d.0-1.1, full speed
 2 [NVidia         ]: HDA-Intel - HDA NVidia
                      HDA NVidia at 0xf6080000 irq 17


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset Family High Definition Audio Controller (rev 05)
01:00.1 Audio device: NVIDIA Corporation GF116 High Definition Audio Controller (rev a1)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:1b.0 0403: 8086:1c20 (rev 05)
	Subsystem: 1558:7100
--
01:00.1 0403: 10de:0bee (rev a1)
	Subsystem: 1558:7100


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

!!Module: snd_usb_audio
	autoclock : Y
	device_setup : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	id : (null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
	ignore_ctl_error : N
	index : -2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	pid : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	vid : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1

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

Codec: Realtek ALC892
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0892
Subsystem Id: 0x15587100
Revision Id: 0x100302
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
GPIO: io=2, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Front Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="ALC892 Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x16 0x16]
  Converter: stream=8, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x03 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Speaker CLFE Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x16 0x16]
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x04 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Speaker Surround Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x16 0x16]
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x05 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Surround Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x16 0x16]
  Converter: stream=8, channel=0
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
  Converter: stream=8, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x5f0]: 32000 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Device: name="ALC892 Analog", type="Audio", device=0
  Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
  Amp-In vals:  [0x27 0x27]
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
  Control: name="Capture Volume", index=1, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=1, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Device: name="ALC892 Alt Analog", type="Audio", device=2
  Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
  Amp-In vals:  [0x80 0x80]
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
  IEC Coding Type: 0x0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Internal Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Internal Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
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
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x05 0x0b
Node 0x10 [Audio Output] wcaps 0x611: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x5f0]: 32000 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x11 [Pin Complex] wcaps 0x400781: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
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
  Control: name="Speaker Front Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Speaker Front Phantom Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001003e: IN OUT HP EAPD Detect Trigger
  EAPD 0x2: EAPD
  Pin Default 0x99130120: [Fixed] Speaker at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0x2, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x0c
Node 0x15 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Speaker CLFE Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Speaker CLFE Phantom Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00000036: IN OUT Detect Trigger
  Pin Default 0x99130130: [Fixed] Speaker at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0x3, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x0d
Node 0x16 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Speaker Surround Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Speaker Surround Phantom Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00000036: IN OUT Detect Trigger
  Pin Default 0x99130140: [Fixed] Speaker at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0x4, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
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
  Control: name="Center Playback Switch", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="LFE Playback Switch", index=0, device=0
    ControlAmp: chs=2, dir=Out, idx=0, ofs=0
  Control: name="Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Mic Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00003736: IN OUT Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x01a11c60: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0x6, Sequence = 0x0
  Pin-ctls: 0x21: IN VREF_50
  Unsolicited: tag=03, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x19 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="Internal Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Internal Mic Phantom Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x03 0x03]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373e: IN OUT HP Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x99a30961: [Fixed] Mic at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0x6, Sequence = 0x1
    Misc = NO_PRESENCE
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1a [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="Surround Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Line Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00003736: IN OUT Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x0181146f: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0x6, Sequence = 0xf
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Headphone Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001373e: IN OUT HP EAPD Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  EAPD 0x2: EAPD
  Pin Default 0x01211010: [Jack] HP Out at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=01, enabled=1
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
  Pin Default 0x598301f0: [N/A] Line In at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x1e [Pin Complex] wcaps 0x400781: Stereo Digital
  Control: name="SPDIF Phantom Jack", index=0, device=0
  Pincap 0x00000010: OUT
  Pin Default 0x01451150: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Black
    DefAssociation = 0x5, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x06
Node 0x1f [Pin Complex] wcaps 0x400681: Stereo Digital
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
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
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 12
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b 0x12
Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x25 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Center Playback Volume", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="LFE Playback Volume", index=0, device=0
    ControlAmp: chs=2, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x16 0x16]
  Converter: stream=8, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x26 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x25 0x0b
Codec: Nvidia GPU 15 HDMI/DP
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10de0015
Subsystem Id: 0x10de0101
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x04 [Audio Output] wcaps 0x72b1: 8-Channels Digital Stripe CP
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Unsolicited: tag=00, enabled=0
Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
  Control: name="HDMI/DP,pcm=3 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="ELD", index=0, device=3
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=01, enabled=1
  Connection: 1
     0x04
Codec: Nvidia GPU 15 HDMI/DP
Address: 1
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10de0015
Subsystem Id: 0x10de0101
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x04 [Audio Output] wcaps 0x72b1: 8-Channels Digital Stripe CP
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Unsolicited: tag=00, enabled=0
Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
  Control: name="HDMI/DP,pcm=7 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=1, device=0
  Control: name="IEC958 Playback Pro Mask", index=1, device=0
  Control: name="IEC958 Playback Default", index=1, device=0
  Control: name="IEC958 Playback Switch", index=1, device=0
  Control: name="ELD", index=0, device=7
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=01, enabled=1
  Connection: 1
     0x04
Codec: Nvidia GPU 15 HDMI/DP
Address: 2
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10de0015
Subsystem Id: 0x10de0101
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x04 [Audio Output] wcaps 0x72b1: 8-Channels Digital Stripe CP
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Unsolicited: tag=00, enabled=0
Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
  Control: name="HDMI/DP,pcm=8 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=2, device=0
  Control: name="IEC958 Playback Pro Mask", index=2, device=0
  Control: name="IEC958 Playback Default", index=2, device=0
  Control: name="IEC958 Playback Switch", index=2, device=0
  Control: name="ELD", index=0, device=8
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=01, enabled=1
  Connection: 1
     0x04
Codec: Nvidia GPU 15 HDMI/DP
Address: 3
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10de0015
Subsystem Id: 0x10de0101
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x04 [Audio Output] wcaps 0x72b1: 8-Channels Digital Stripe CP
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Unsolicited: tag=00, enabled=0
Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
  Control: name="HDMI/DP,pcm=9 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=3, device=0
  Control: name="IEC958 Playback Pro Mask", index=3, device=0
  Control: name="IEC958 Playback Default", index=3, device=0
  Control: name="IEC958 Playback Switch", index=3, device=0
  Control: name="ELD", index=0, device=9
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=01, enabled=1
  Connection: 1
     0x04
--endcollapse--


!!USB Mixer information
!!---------------------
--startcollapse--

USB Mixer: usb_id=0x0b0e2000, ctrlif=0, ctlerr=0
Card: GN Netcom GN 2000 USB at usb-0000:00:1d.0-1.1, full speed
  Unit: 1
    Control: name="Bass Boost", index=0
    Info: id=1, control=9, cmask=0x0, channels=1, type="BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 1
    Control: name="Auto Gain Control", index=0
    Info: id=1, control=7, cmask=0x0, channels=1, type="BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 1
    Control: name="Tone Control - Treble", index=0
    Info: id=1, control=5, cmask=0x0, channels=1, type="S8"
    Volume: min=-48, max=48, dBmin=-18, dBmax=18
  Unit: 1
    Control: name="Tone Control - Bass", index=0
    Info: id=1, control=3, cmask=0x0, channels=1, type="S8"
    Volume: min=-48, max=48, dBmin=-18, dBmax=18
  Unit: 1
    Control: name="Speaker Playback Volume", index=0
    Info: id=1, control=2, cmask=0x3, channels=2, type="S16"
    Volume: min=-10496, max=768, dBmin=-4100, dBmax=300
  Unit: 1
    Control: name="Speaker Playback Switch", index=0
    Info: id=1, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 2
    Control: name="Mic Capture Volume", index=0
    Info: id=2, control=2, cmask=0x0, channels=1, type="S16"
    Volume: min=4096, max=7936, dBmin=1600, dBmax=3100
  Unit: 2
    Control: name="Mic Capture Switch", index=0
    Info: id=2, control=1, cmask=0x0, channels=1, type="INV_BOOLEAN"
    Volume: min=0, max=1, dBmin=0, dBmax=0
  Unit: 6
    Control: name="Mic Playback Volume", index=0
    Info: id=6, control=2, cmask=0x0, channels=1, type="S16"
    Volume: min=-10496, max=0, dBmin=-4100, dBmax=0
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  7 Oct 17 08:05 /dev/snd/controlC0
crw-rw----+ 1 root audio 116, 10 Oct 22 12:31 /dev/snd/controlC1
crw-rw----+ 1 root audio 116, 21 Oct 17 08:05 /dev/snd/controlC2
crw-rw----+ 1 root audio 116,  6 Oct 17 08:05 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116, 20 Oct 17 08:05 /dev/snd/hwC2D0
crw-rw----+ 1 root audio 116, 19 Oct 17 08:05 /dev/snd/hwC2D1
crw-rw----+ 1 root audio 116, 18 Oct 17 08:05 /dev/snd/hwC2D2
crw-rw----+ 1 root audio 116, 17 Oct 17 08:05 /dev/snd/hwC2D3
crw-rw----+ 1 root audio 116,  5 Oct 17 08:06 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116,  4 Oct 22 12:30 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116,  3 Oct 17 08:06 /dev/snd/pcmC0D1p
crw-rw----+ 1 root audio 116,  2 Oct 17 08:05 /dev/snd/pcmC0D2c
crw-rw----+ 1 root audio 116,  9 Oct 22 12:31 /dev/snd/pcmC1D0c
crw-rw----+ 1 root audio 116,  8 Oct 22 12:31 /dev/snd/pcmC1D0p
crw-rw----+ 1 root audio 116, 16 Oct 17 08:06 /dev/snd/pcmC2D3p
crw-rw----+ 1 root audio 116, 15 Oct 21 21:18 /dev/snd/pcmC2D7p
crw-rw----+ 1 root audio 116, 14 Oct 17 08:06 /dev/snd/pcmC2D8p
crw-rw----+ 1 root audio 116, 13 Oct 17 08:06 /dev/snd/pcmC2D9p
crw-rw----+ 1 root audio 116,  1 Oct 17 08:05 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 Oct 17 08:05 /dev/snd/timer

/dev/snd/by-id:
total 0
drwxr-xr-x 2 root root  60 Oct 22 12:31 .
drwxr-xr-x 4 root root 480 Oct 22 12:31 ..
lrwxrwxrwx 1 root root  12 Oct 22 12:31 usb-GN_Netcom_GN_2000_USB-00 -> ../controlC1

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root 100 Oct 22 12:31 .
drwxr-xr-x 4 root root 480 Oct 22 12:31 ..
lrwxrwxrwx 1 root root  12 Oct 17 08:05 pci-0000:00:1b.0 -> ../controlC0
lrwxrwxrwx 1 root root  12 Oct 22 12:31 pci-0000:00:1d.0-usb-0:1.1:1.0 -> ../controlC1
lrwxrwxrwx 1 root root  12 Oct 17 08:05 pci-0000:01:00.1 -> ../controlC2


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC892 Analog [ALC892 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 1: ALC892 Digital [ALC892 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: USB [GN 2000 USB], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: NVidia [HDA NVidia], device 7: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: NVidia [HDA NVidia], device 8: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: NVidia [HDA NVidia], device 9: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC892 Analog [ALC892 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 2: ALC892 Alt Analog [ALC892 Alt Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: USB [GN 2000 USB], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [PCH]

Card hw:0 'PCH'/'HDA Intel PCH at 0xf6500000 irq 52'
  Mixer name	: 'Realtek ALC892'
  Components	: 'HDA:10ec0892,15587100,00100302'
  Controls      : 51
  Simple ctrls  : 25
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 22 [34%] [-42.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'Speaker CLFE',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Speaker Front',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'Speaker Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 254 [100%] [-0.20dB]
  Front Right: Playback 254 [100%] [-0.20dB]
Simple mixer control 'Front',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB]
  Front Right: Playback 64 [100%] [0.00dB]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Line Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 46
  Front Left: Capture 39 [85%] [23.00dB] [on]
  Front Right: Capture 39 [85%] [23.00dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 46
  Front Left: Capture 0 [0%] [-16.00dB] [off]
  Front Right: Capture 0 [0%] [-16.00dB] [off]
Simple mixer control 'Auto-Mute Mode',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Enabled'
Simple mixer control 'Channel Mode',0
  Capabilities: enum
  Items: '2ch' '4ch' '6ch'
  Item0: '2ch'
Simple mixer control 'Digital',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 60 [50%] [0.00dB]
  Front Right: Capture 60 [50%] [0.00dB]
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Internal Mic' 'Mic' 'Line'
  Item0: 'Internal Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Internal Mic' 'Mic' 'Line'
  Item0: 'Mic'
Simple mixer control 'Internal Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Internal Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 3 [100%] [30.00dB]
  Front Right: 3 [100%] [30.00dB]

!!-------Mixer controls for card 1 [USB]

Card hw:1 'USB'/'GN Netcom GN 2000 USB at usb-0000:00:1d.0-1.1, full speed'
  Mixer name	: 'USB Mixer'
  Components	: 'USB0b0e:2000'
  Controls      : 11
  Simple ctrls  : 6
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch pswitch-joined
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 704
  Mono:
  Front Left: Playback 524 [74%] [-8.25dB] [on]
  Front Right: Playback 524 [74%] [-8.25dB] [on]
Simple mixer control 'Bass',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 48
  Mono: 24 [50%]
Simple mixer control 'Bass Boost',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Treble',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 48
  Mono: 24 [50%]
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined cvolume cvolume-joined cswitch cswitch-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: Playback 0 - 656 Capture 0 - 15
  Mono: Playback 0 [0%] [-41.00dB] Capture 13 [87%] [29.00dB] [on]
Simple mixer control 'Auto Gain Control',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]

!!-------Mixer controls for card 2 [NVidia]

Card hw:2 'NVidia'/'HDA NVidia at 0xf6080000 irq 17'
  Mixer name	: 'Nvidia GPU 15 HDMI/DP'
  Components	: 'HDA:10de0015,10de0101,00100100'
  Controls      : 28
  Simple ctrls  : 4
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',2
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',3
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]


!!Alsactl output
!!--------------

--startcollapse--
state.PCH {
	control.1 {
		iface MIXER
		name 'Channel Mode'
		value '2ch'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 '2ch'
			item.1 '4ch'
			item.2 '6ch'
		}
	}
	control.2 {
		iface MIXER
		name 'Front Playback Volume'
		value.0 64
		value.1 64
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
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
		name 'Surround Playback Volume'
		value.0 64
		value.1 64
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.5 {
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
	control.6 {
		iface MIXER
		name 'Center Playback Volume'
		value 64
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
		}
	}
	control.7 {
		iface MIXER
		name 'LFE Playback Volume'
		value 64
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
		}
	}
	control.8 {
		iface MIXER
		name 'Center Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.9 {
		iface MIXER
		name 'LFE Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.10 {
		iface MIXER
		name 'Speaker Front Playback Switch'
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
		name 'Speaker Surround Playback Volume'
		value.0 64
		value.1 64
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.12 {
		iface MIXER
		name 'Speaker Surround Playback Switch'
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
		name 'Speaker CLFE Playback Volume'
		value.0 64
		value.1 64
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.14 {
		iface MIXER
		name 'Speaker CLFE Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.15 {
		iface MIXER
		name 'Internal Mic Playback Volume'
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
		name 'Internal Mic Playback Switch'
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
		name 'Mic Playback Volume'
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
		name 'Mic Playback Switch'
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
	control.20 {
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
	control.21 {
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
	control.22 {
		iface MIXER
		name 'Input Source'
		value 'Internal Mic'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Internal Mic'
			item.1 Mic
			item.2 Line
		}
	}
	control.23 {
		iface MIXER
		name 'Input Source'
		index 1
		value Mic
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Internal Mic'
			item.1 Mic
			item.2 Line
		}
	}
	control.24 {
		iface MIXER
		name 'Capture Volume'
		value.0 39
		value.1 39
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 46'
			dbmin -1600
			dbmax 3000
			dbvalue.0 2300
			dbvalue.1 2300
		}
	}
	control.25 {
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
	control.26 {
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
	control.27 {
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
	control.28 {
		iface MIXER
		name 'Internal Mic Boost Volume'
		value.0 3
		value.1 3
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3000
			dbvalue.0 3000
			dbvalue.1 3000
		}
	}
	control.29 {
		iface MIXER
		name 'Mic Boost Volume'
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
	control.31 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.32 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.33 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.34 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.35 {
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.36 {
		iface MIXER
		name 'Master Playback Volume'
		value 22
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 -4200
		}
	}
	control.37 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.38 {
		iface CARD
		name 'Internal Mic Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.39 {
		iface CARD
		name 'Mic Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.40 {
		iface CARD
		name 'Line Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.41 {
		iface CARD
		name 'Headphone Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.42 {
		iface CARD
		name 'Speaker Front Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.43 {
		iface CARD
		name 'Speaker Surround Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.44 {
		iface CARD
		name 'Speaker CLFE Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.45 {
		iface CARD
		name 'SPDIF Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.46 {
		iface PCM
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		comment {
			access read
			type INTEGER
			count 6
			range '0 - 36'
		}
	}
	control.47 {
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
	control.48 {
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
	control.49 {
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
	control.50 {
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
	control.51 {
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
state.USB {
	control.1 {
		iface PCM
		name 'Playback Channel Map'
		value 0
		comment {
			access read
			type INTEGER
			count 1
			range '0 - 36'
		}
	}
	control.2 {
		iface PCM
		name 'Capture Channel Map'
		value 0
		comment {
			access read
			type INTEGER
			count 1
			range '0 - 36'
		}
	}
	control.3 {
		iface MIXER
		name 'Mic Playback Volume'
		value 0
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 656'
			dbmin -4100
			dbmax 0
			dbvalue.0 -4100
		}
	}
	control.4 {
		iface MIXER
		name 'Speaker Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.5 {
		iface MIXER
		name 'Speaker Playback Volume'
		value.0 524
		value.1 524
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 704'
			dbmin -4100
			dbmax 300
			dbvalue.0 -825
			dbvalue.1 -825
		}
	}
	control.6 {
		iface MIXER
		name 'Tone Control - Bass'
		value 24
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 48'
		}
	}
	control.7 {
		iface MIXER
		name 'Tone Control - Treble'
		value 24
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 48'
		}
	}
	control.8 {
		iface MIXER
		name 'Auto Gain Control'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.9 {
		iface MIXER
		name 'Bass Boost'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.10 {
		iface MIXER
		name 'Mic Capture Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.11 {
		iface MIXER
		name 'Mic Capture Volume'
		value 13
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 15'
			dbmin 1600
			dbmax 3100
			dbvalue.0 2900
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
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
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
	control.8 {
		iface CARD
		name 'HDMI/DP,pcm=7 Jack'
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
		index 1
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
		index 1
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
		index 1
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
		index 1
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.13 {
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
	control.14 {
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
	control.15 {
		iface CARD
		name 'HDMI/DP,pcm=8 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.16 {
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
	control.17 {
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
	control.18 {
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
	control.19 {
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
	control.20 {
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
	control.21 {
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
	control.22 {
		iface CARD
		name 'HDMI/DP,pcm=9 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.23 {
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
	control.24 {
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
	control.25 {
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
	control.26 {
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
	control.27 {
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
xfrm_user
xfrm4_tunnel
tunnel4
ipcomp
xfrm_ipcomp
esp4
ah4
af_key
xfrm_algo
ctr
ccm
ipt_MASQUERADE
iptable_nat
nf_nat_ipv4
nf_nat
nf_conntrack_ipv4
nf_defrag_ipv4
xt_conntrack
nf_conntrack
ipt_REJECT
xt_CHECKSUM
iptable_mangle
xt_tcpudp
cuse
bridge
stp
llc
ip6table_filter
ip6_tables
iptable_filter
ip_tables
ebtable_nat
ebtables
x_tables
rfcomm
bnep
bluetooth
binfmt_misc
snd_hda_codec_hdmi
joydev
hid_generic
hid_microsoft
snd_hda_codec_realtek
nvidia
uvcvideo
intel_rapl
snd_hda_intel
videobuf2_vmalloc
x86_pkg_temp_thermal
usbhid
videobuf2_memops
arc4
intel_powerclamp
videobuf2_core
snd_usb_audio
snd_hda_codec
videodev
kvm_intel
hid
snd_usbmidi_lib
kvm
snd_hwdep
iwldvm
mac80211
crct10dif_pclmul
dm_multipath
snd_pcm
scsi_dh
crc32_pclmul
ghash_clmulni_intel
snd_page_alloc
psmouse
snd_seq_midi
ir_lirc_codec
snd_seq_midi_event
lirc_dev
snd_rawmidi
serio_raw
ir_nec_decoder
ir_mce_kbd_decoder
ir_sanyo_decoder
ir_rc5_decoder
ir_jvc_decoder
ir_sony_decoder
ir_rc6_decoder
snd_seq
sdhci_pci
jmb38x_ms
snd_seq_device
iwlwifi
jme
memstick
snd_timer
sdhci
mii
wmi
firewire_ohci
rc_rc6_mce
snd
firewire_core
cfg80211
ite_cir
drm
mac_hid
rc_core
crc_itu_t
soundcore
mei_me
mei
lpc_ich
parport_pc
ppdev
coretemp
lp
parport
dm_crypt
raid10
raid456
async_raid6_recov
async_memcpy
async_pq
async_xor
xor
async_tx
raid6_pq
raid1
raid0
multipath
linear
aesni_intel
aes_x86_64
glue_helper
lrw
gf128mul
ablk_helper
cryptd
ahci
libahci
video


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x11 0x411111f0
0x12 0x411111f0
0x14 0x99130120
0x15 0x99130130
0x16 0x99130140
0x17 0x411111f0
0x18 0x01a11c60
0x19 0x99a30961
0x1a 0x0181146f
0x1b 0x01211010
0x1c 0x411111f0
0x1d 0x598301f0
0x1e 0x01451150
0x1f 0x411111f0

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D0/hints:

/sys/class/sound/hwC2D0/init_pin_configs:
0x05 0x18560010

/sys/class/sound/hwC2D0/driver_pin_configs:

/sys/class/sound/hwC2D0/user_pin_configs:

/sys/class/sound/hwC2D0/init_verbs:

/sys/class/sound/hwC2D0/hints:

/sys/class/sound/hwC2D1/init_pin_configs:
0x05 0x18560010

/sys/class/sound/hwC2D1/driver_pin_configs:

/sys/class/sound/hwC2D1/user_pin_configs:

/sys/class/sound/hwC2D1/init_verbs:

/sys/class/sound/hwC2D1/hints:

/sys/class/sound/hwC2D2/init_pin_configs:
0x05 0x18560010

/sys/class/sound/hwC2D2/driver_pin_configs:

/sys/class/sound/hwC2D2/user_pin_configs:

/sys/class/sound/hwC2D2/init_verbs:

/sys/class/sound/hwC2D2/hints:

/sys/class/sound/hwC2D3/init_pin_configs:
0x05 0x18560010

/sys/class/sound/hwC2D3/driver_pin_configs:

/sys/class/sound/hwC2D3/user_pin_configs:

/sys/class/sound/hwC2D3/init_verbs:

/sys/class/sound/hwC2D3/hints:


!!ALSA/HDA dmesg
!!--------------

[   16.197083] Linux video capture interface: v2.00
[   16.209808] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[   16.213267] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-rs'
--
[   16.223863] nvidia: module verification failed: signature and/or  required key missing - tainting kernel
[   16.227701] hda_codec: ALC892: SKU not ready 0x598301f0
[   16.228304] autoconfig: line_outs=3 (0x14/0x16/0x15/0x0/0x0) type:speaker
--
[   16.232893] usbhid: USB HID core driver
[   16.242564] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input19
[   16.242700] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input18
[   16.242835] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input17
[   16.243449] hda_intel: Disabling MSI
[   16.243457] hda-intel 0000:01:00.1: Handle VGA-switcheroo audio client
[   16.243580] hda-intel 0000:01:00.1: Disabling 64bit DMA
[   16.247696] hda-intel 0000:01:00.1: Enable delay in RIRB handling
[   16.313272] type=1400 audit(1413561932.624:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/sbin/dhclient" pid=838 comm="apparmor_parser"
--
[   16.499835] usb_audio: [6] FU [Mic Playback Volume] ch = 1, val = -10496/0/16usb_audio: Warning! Unlikely big volume range (=704), cval->res is probably wrong.
[   16.506967] usb_audio: [1] FU [Speaker Playback Volume] ch = 2, val = -10496/768/16<6>[   16.529596] usbcore: registered new interface driver snd-usb-audio
[   16.625164] EXT4-fs (dm-6): mounted filesystem with ordered data mode. Opts: (null)
--
[   16.860484] EXT4-fs (dm-4): mounted filesystem with ordered data mode. Opts: (null)
[   17.048322] input: HDA NVidia HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card2/input28
[   17.048404] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card2/input27
[   17.048452] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card2/input26
[   17.048500] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card2/input25
[   17.541125] psmouse serio2: synaptics: Touchpad model: 1, fw: 7.2, id: 0x1c0b1, caps: 0xd04733/0xa40000/0xa0000, board id: 3655, fw id: 582762
--
[54797.272995] iwlwifi 0000:04:00.0: RF_KILL bit toggled to enable radio.
[54797.273213] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[54797.296928] jme 0000:03:00.0 eth0: Link is down
--
[93830.833975] mei_me 0000:00:16.0: irq 50 for MSI/MSI-X
[93830.834093] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[93830.834141] jme 0000:03:00.0: System wakeup disabled by ACPI
--
[132875.700193] iwlwifi 0000:04:00.0: RF_KILL bit toggled to enable radio.
[132875.700215] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[132875.724153] jme 0000:03:00.0 eth0: Link is down
--
[135181.884658] jme 0000:03:00.0: System wakeup disabled by ACPI
[135181.884707] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[135181.884958] iwlwifi 0000:04:00.0: RF_KILL bit toggled to enable radio.
--
[190129.363970] iwlwifi 0000:04:00.0: RF_KILL bit toggled to enable radio.
[190129.364012] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[190129.387868] jme 0000:03:00.0 eth0: Link is down
--
[215539.635317] jme 0000:03:00.0: System wakeup disabled by ACPI
[215539.635509] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[215539.684205] iwlwifi 0000:04:00.0: RF_KILL bit toggled to enable radio.
--
[215674.127612] iwlwifi 0000:04:00.0: RF_KILL bit toggled to enable radio.
[215674.127702] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[215674.339253] usb 2-1.5: reset full-speed USB device number 4 using ehci-pci
--
[217181.497031] jme 0000:03:00.0: System wakeup disabled by ACPI
[217181.497225] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[217181.498289] iwlwifi 0000:04:00.0: RF_KILL bit toggled to enable radio.
--
[217294.942057] jme 0000:03:00.0: System wakeup disabled by ACPI
[217294.942177] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[217294.942596] iwlwifi 0000:04:00.0: RF_KILL bit toggled to enable radio.
--
[217295.497993] firewire_core 0000:05:00.0: rediscovered device fw0
[217296.010484] HDMI: invalid ELD data byte 0
[217296.326800] HDMI: invalid ELD data byte 0
[217296.643112] HDMI: invalid ELD data byte 0
[217296.995484] HDMI: invalid ELD data byte 0
[217297.311738] HDMI: invalid ELD data byte 0
[217297.628064] HDMI: invalid ELD data byte 0
[217297.768224] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
--
[217297.926429] Restarting tasks ... done.
[217297.948453] HDMI: invalid ELD data byte 0
[217298.112845] video LNXVIDEO:00: Restoring backlight state
[217298.264704] HDMI: invalid ELD data byte 0
[217298.581066] HDMI: invalid ELD data byte 0
[217299.226532] firewire_ohci 0000:05:00.0: no hotplug settings from platform
--
[218760.786062] iwlwifi 0000:04:00.0: RF_KILL bit toggled to enable radio.
[218760.786130] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[218760.809806] jme 0000:03:00.0 eth0: Link is down




--nextPart1801830.RAKFpmdGti
Content-Disposition: attachment; filename="pactl-list-after-plug-after-pulse-restart.txt"
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; name="pactl-list-after-plug-after-pulse-restart.txt"

Module #0
=09Name: module-device-restore
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Automatically restore the volume/mute sta=
te of devices"
=09=09module.version =3D "4.0"

Module #1
=09Name: module-stream-restore
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Automatically restore the volume/mute/dev=
ice state of streams"
=09=09module.version =3D "4.0"

Module #2
=09Name: module-card-restore
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Automatically restore profile of cards"
=09=09module.version =3D "4.0"

Module #3
=09Name: module-augment-properties
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Augment the property sets of streams with=
 additional static information"
=09=09module.version =3D "4.0"

Module #4
=09Name: module-switch-on-port-available
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09

Module #5
=09Name: module-alsa-card
=09Argument: device_id=3D"2" name=3D"pci-0000_01_00.1" card_name=3D"als=
a_card.pci-0000_01_00.1" namereg_fail=3Dfalse tsched=3Dyes fixed_latenc=
y_range=3Dno ignore_dB=3Dno deferred_volume=3Dyes use_ucm=3Dyes card_pr=
operties=3D"module-udev-detect.discovered=3D1"
=09Usage counter: 0
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "ALSA Card"
=09=09module.version =3D "4.0"

Module #6
=09Name: module-alsa-card
=09Argument: device_id=3D"0" name=3D"pci-0000_00_1b.0" card_name=3D"als=
a_card.pci-0000_00_1b.0" namereg_fail=3Dfalse tsched=3Dyes fixed_latenc=
y_range=3Dno ignore_dB=3Dno deferred_volume=3Dyes use_ucm=3Dyes card_pr=
operties=3D"module-udev-detect.discovered=3D1"
=09Usage counter: 0
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "ALSA Card"
=09=09module.version =3D "4.0"

Module #7
=09Name: module-alsa-card
=09Argument: device_id=3D"1" name=3D"usb-GN_Netcom_GN_2000_USB-00-USB" =
card_name=3D"alsa_card.usb-GN_Netcom_GN_2000_USB-00-USB" namereg_fail=3D=
false tsched=3Dyes fixed_latency_range=3Dno ignore_dB=3Dno deferred_vol=
ume=3Dyes use_ucm=3Dyes card_properties=3D"module-udev-detect.discovere=
d=3D1"
=09Usage counter: 0
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "ALSA Card"
=09=09module.version =3D "4.0"

Module #8
=09Name: module-udev-detect
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Detect available audio hardware and load =
matching drivers"
=09=09module.version =3D "4.0"

Module #9
=09Name: module-bluetooth-policy
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Fr=C3=A9d=C3=A9ric Dalleau"
=09=09module.description =3D "When a bluetooth sink or source is added,=
 load module-loopback"
=09=09module.version =3D "4.0"

Module #10
=09Name: module-bluetooth-discover
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Joao Paulo Rechi Vita"
=09=09module.description =3D "Detect available bluetooth audio devices =
and load bluetooth audio drivers"
=09=09module.version =3D "4.0"

Module #11
=09Name: module-native-protocol-unix
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Native protocol (UNIX sockets)"
=09=09module.version =3D "4.0"

Module #12
=09Name: module-default-device-restore
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Automatically restore the default sink an=
d source"
=09=09module.version =3D "4.0"

Module #13
=09Name: module-rescue-streams
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "When a sink/source is removed, try to mov=
e their streams to the default sink/source"
=09=09module.version =3D "4.0"

Module #14
=09Name: module-always-sink
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Colin Guthrie"
=09=09module.description =3D "Always keeps at least one sink loaded eve=
n if it's a null one"
=09=09module.version =3D "4.0"

Module #15
=09Name: module-intended-roles
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Automatically set device of streams based=
 of intended roles of devices"
=09=09module.version =3D "4.0"

Module #16
=09Name: module-suspend-on-idle
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "When a sink/source is idle for too long, =
suspend it"
=09=09module.version =3D "4.0"

Module #17
=09Name: module-systemd-login
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Create a client for each login session of=
 this user"
=09=09module.version =3D "4.0"

Module #18
=09Name: module-position-event-sounds
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Position event sounds between L and R dep=
ending on the position on screen of the widget triggering them."
=09=09module.version =3D "4.0"

Module #19
=09Name: module-filter-heuristics
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Colin Guthrie"
=09=09module.description =3D "Detect when various filters are desirable=
"
=09=09module.version =3D "4.0"

Module #20
=09Name: module-filter-apply
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Colin Guthrie"
=09=09module.description =3D "Load filter sinks automatically when need=
ed"
=09=09module.version =3D "4.0"

Sink #0
=09State: SUSPENDED
=09Name: alsa_output.pci-0000_01_00.1.hdmi-stereo
=09Description: GF116 High Definition Audio Controller Digital Stereo (=
HDMI)
=09Driver: module-alsa-card.c
=09Sample Specification: s16le 2ch 44100Hz
=09Channel Map: front-left,front-right
=09Owner Module: 5
=09Mute: no
=09Volume: 0:  90% 1:  90%
=09        0: -2.74 dB 1: -2.74 dB
=09        balance 0.00
=09Base Volume: 100%
=09             0.00 dB
=09Monitor Source: alsa_output.pci-0000_01_00.1.hdmi-stereo.monitor
=09Latency: 0 usec, configured 0 usec
=09Flags: HARDWARE DECIBEL_VOLUME LATENCY SET_FORMATS=20
=09Properties:
=09=09alsa.resolution_bits =3D "16"
=09=09device.api =3D "alsa"
=09=09device.class =3D "sound"
=09=09alsa.class =3D "generic"
=09=09alsa.subclass =3D "generic-mix"
=09=09alsa.name =3D "HDMI 0"
=09=09alsa.id =3D "HDMI 0"
=09=09alsa.subdevice =3D "0"
=09=09alsa.subdevice_name =3D "subdevice #0"
=09=09alsa.device =3D "3"
=09=09alsa.card =3D "2"
=09=09alsa.card_name =3D "HDA NVidia"
=09=09alsa.long_card_name =3D "HDA NVidia at 0xf6080000 irq 17"
=09=09alsa.driver_name =3D "snd_hda_intel"
=09=09device.bus_path =3D "pci-0000:01:00.1"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sou=
nd/card2"
=09=09device.bus =3D "pci"
=09=09device.vendor.id =3D "10de"
=09=09device.vendor.name =3D "NVIDIA Corporation"
=09=09device.product.id =3D "0bee"
=09=09device.product.name =3D "GF116 High Definition Audio Controller"
=09=09device.string =3D "hdmi:2"
=09=09device.buffering.buffer_size =3D "65536"
=09=09device.buffering.fragment_size =3D "32768"
=09=09device.access_mode =3D "mmap+timer"
=09=09device.profile.name =3D "hdmi-stereo"
=09=09device.profile.description =3D "Digital Stereo (HDMI)"
=09=09device.description =3D "GF116 High Definition Audio Controller Di=
gital Stereo (HDMI)"
=09=09alsa.mixer_name =3D "Nvidia GPU 15 HDMI/DP"
=09=09alsa.components =3D "HDA:10de0015,10de0101,00100100"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-pci"
=09Ports:
=09=09hdmi-output-0: HDMI / DisplayPort (priority: 5900, not available)=

=09Active Port: hdmi-output-0
=09Formats:
=09=09pcm

Sink #1
=09State: SUSPENDED
=09Name: alsa_output.pci-0000_00_1b.0.analog-stereo
=09Description: Built-in Audio Analog Stereo
=09Driver: module-alsa-card.c
=09Sample Specification: s16le 2ch 44100Hz
=09Channel Map: front-left,front-right
=09Owner Module: 6
=09Mute: no
=09Volume: 0:  20% 1:  20%
=09        0: -42.18 dB 1: -42.18 dB
=09        balance 0.00
=09Base Volume: 100%
=09             0.00 dB
=09Monitor Source: alsa_output.pci-0000_00_1b.0.analog-stereo.monitor
=09Latency: 0 usec, configured 0 usec
=09Flags: HARDWARE HW_MUTE_CTRL HW_VOLUME_CTRL DECIBEL_VOLUME LATENCY=20=

=09Properties:
=09=09alsa.resolution_bits =3D "16"
=09=09device.api =3D "alsa"
=09=09device.class =3D "sound"
=09=09alsa.class =3D "generic"
=09=09alsa.subclass =3D "generic-mix"
=09=09alsa.name =3D "ALC892 Analog"
=09=09alsa.id =3D "ALC892 Analog"
=09=09alsa.subdevice =3D "0"
=09=09alsa.subdevice_name =3D "subdevice #0"
=09=09alsa.device =3D "0"
=09=09alsa.card =3D "0"
=09=09alsa.card_name =3D "HDA Intel PCH"
=09=09alsa.long_card_name =3D "HDA Intel PCH at 0xf6500000 irq 52"
=09=09alsa.driver_name =3D "snd_hda_intel"
=09=09device.bus_path =3D "pci-0000:00:1b.0"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:1b.0/sound/card0"
=09=09device.bus =3D "pci"
=09=09device.vendor.id =3D "8086"
=09=09device.vendor.name =3D "Intel Corporation"
=09=09device.product.id =3D "1c20"
=09=09device.product.name =3D "6 Series/C200 Series Chipset Family High=
 Definition Audio Controller"
=09=09device.form_factor =3D "internal"
=09=09device.string =3D "front:0"
=09=09device.buffering.buffer_size =3D "65536"
=09=09device.buffering.fragment_size =3D "32768"
=09=09device.access_mode =3D "mmap+timer"
=09=09device.profile.name =3D "analog-stereo"
=09=09device.profile.description =3D "Analog Stereo"
=09=09device.description =3D "Built-in Audio Analog Stereo"
=09=09alsa.mixer_name =3D "Realtek ALC892"
=09=09alsa.components =3D "HDA:10ec0892,15587100,00100302"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-pci"
=09Ports:
=09=09analog-output: Analog Output (priority: 9900)
=09=09analog-output-headphones: Headphones (priority: 9000, not availab=
le)
=09Active Port: analog-output
=09Formats:
=09=09pcm

Sink #2
=09State: SUSPENDED
=09Name: alsa_output.usb-GN_Netcom_GN_2000_USB-00-USB.analog-stereo
=09Description: GN 2000 USB Analog Stereo
=09Driver: module-alsa-card.c
=09Sample Specification: s16le 2ch 44100Hz
=09Channel Map: front-left,front-right
=09Owner Module: 7
=09Mute: no
=09Volume: 0:  65% 1:  65%
=09        0: -11.19 dB 1: -11.19 dB
=09        balance 0.00
=09Base Volume:  89%
=09             -3.00 dB
=09Monitor Source: alsa_output.usb-GN_Netcom_GN_2000_USB-00-USB.analog-=
stereo.monitor
=09Latency: 0 usec, configured 0 usec
=09Flags: HARDWARE HW_MUTE_CTRL HW_VOLUME_CTRL DECIBEL_VOLUME LATENCY=20=

=09Properties:
=09=09alsa.resolution_bits =3D "16"
=09=09device.api =3D "alsa"
=09=09device.class =3D "sound"
=09=09alsa.class =3D "generic"
=09=09alsa.subclass =3D "generic-mix"
=09=09alsa.name =3D "USB Audio"
=09=09alsa.id =3D "USB Audio"
=09=09alsa.subdevice =3D "0"
=09=09alsa.subdevice_name =3D "subdevice #0"
=09=09alsa.device =3D "0"
=09=09alsa.card =3D "1"
=09=09alsa.card_name =3D "GN 2000 USB"
=09=09alsa.long_card_name =3D "GN Netcom GN 2000 USB at usb-0000:00:1d.=
0-1.1, full speed"
=09=09alsa.driver_name =3D "snd_usb_audio"
=09=09device.bus_path =3D "pci-0000:00:1d.0-usb-0:1.1:1.0"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.1/2=
-1.1:1.0/sound/card1"
=09=09udev.id =3D "usb-GN_Netcom_GN_2000_USB-00-USB"
=09=09device.bus =3D "usb"
=09=09device.vendor.id =3D "0b0e"
=09=09device.vendor.name =3D "GN Netcom"
=09=09device.product.id =3D "2000"
=09=09device.product.name =3D "GN 2000 USB"
=09=09device.serial =3D "GN_Netcom_GN_2000_USB"
=09=09device.string =3D "front:1"
=09=09device.buffering.buffer_size =3D "352800"
=09=09device.buffering.fragment_size =3D "176400"
=09=09device.access_mode =3D "mmap+timer"
=09=09device.profile.name =3D "analog-stereo"
=09=09device.profile.description =3D "Analog Stereo"
=09=09device.description =3D "GN 2000 USB Analog Stereo"
=09=09alsa.mixer_name =3D "USB Mixer"
=09=09alsa.components =3D "USB0b0e:2000"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-usb"
=09Ports:
=09=09analog-output-speaker;output-bass-boost-on: Speakers / Bass Boost=
 (priority: 10000)
=09=09analog-output-speaker;output-bass-boost-off: Speakers / No Bass B=
oost (priority: 10010)
=09Active Port: analog-output-speaker;output-bass-boost-off
=09Formats:
=09=09pcm

Source #0
=09State: SUSPENDED
=09Name: alsa_output.pci-0000_01_00.1.hdmi-stereo.monitor
=09Description: Monitor of GF116 High Definition Audio Controller Digit=
al Stereo (HDMI)
=09Driver: module-alsa-card.c
=09Sample Specification: s16le 2ch 44100Hz
=09Channel Map: front-left,front-right
=09Owner Module: 5
=09Mute: yes
=09Volume: 0: 100% 1: 100%
=09        0: 0.00 dB 1: 0.00 dB
=09        balance 0.00
=09Base Volume: 100%
=09             0.00 dB
=09Monitor of Sink: alsa_output.pci-0000_01_00.1.hdmi-stereo
=09Latency: 0 usec, configured 0 usec
=09Flags: DECIBEL_VOLUME LATENCY=20
=09Properties:
=09=09device.description =3D "Monitor of GF116 High Definition Audio Co=
ntroller Digital Stereo (HDMI)"
=09=09device.class =3D "monitor"
=09=09alsa.card =3D "2"
=09=09alsa.card_name =3D "HDA NVidia"
=09=09alsa.long_card_name =3D "HDA NVidia at 0xf6080000 irq 17"
=09=09alsa.driver_name =3D "snd_hda_intel"
=09=09device.bus_path =3D "pci-0000:01:00.1"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sou=
nd/card2"
=09=09device.bus =3D "pci"
=09=09device.vendor.id =3D "10de"
=09=09device.vendor.name =3D "NVIDIA Corporation"
=09=09device.product.id =3D "0bee"
=09=09device.product.name =3D "GF116 High Definition Audio Controller"
=09=09device.string =3D "2"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-pci"
=09Formats:
=09=09pcm

Source #1
=09State: SUSPENDED
=09Name: alsa_output.pci-0000_00_1b.0.analog-stereo.monitor
=09Description: Monitor of Built-in Audio Analog Stereo
=09Driver: module-alsa-card.c
=09Sample Specification: s16le 2ch 44100Hz
=09Channel Map: front-left,front-right
=09Owner Module: 6
=09Mute: yes
=09Volume: 0: 100% 1: 100%
=09        0: 0.00 dB 1: 0.00 dB
=09        balance 0.00
=09Base Volume: 100%
=09             0.00 dB
=09Monitor of Sink: alsa_output.pci-0000_00_1b.0.analog-stereo
=09Latency: 0 usec, configured 0 usec
=09Flags: DECIBEL_VOLUME LATENCY=20
=09Properties:
=09=09device.description =3D "Monitor of Built-in Audio Analog Stereo"
=09=09device.class =3D "monitor"
=09=09alsa.card =3D "0"
=09=09alsa.card_name =3D "HDA Intel PCH"
=09=09alsa.long_card_name =3D "HDA Intel PCH at 0xf6500000 irq 52"
=09=09alsa.driver_name =3D "snd_hda_intel"
=09=09device.bus_path =3D "pci-0000:00:1b.0"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:1b.0/sound/card0"
=09=09device.bus =3D "pci"
=09=09device.vendor.id =3D "8086"
=09=09device.vendor.name =3D "Intel Corporation"
=09=09device.product.id =3D "1c20"
=09=09device.product.name =3D "6 Series/C200 Series Chipset Family High=
 Definition Audio Controller"
=09=09device.form_factor =3D "internal"
=09=09device.string =3D "0"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-pci"
=09Formats:
=09=09pcm

Source #2
=09State: SUSPENDED
=09Name: alsa_input.pci-0000_00_1b.0.analog-stereo
=09Description: Built-in Audio Analog Stereo
=09Driver: module-alsa-card.c
=09Sample Specification: s16le 2ch 44100Hz
=09Channel Map: front-left,front-right
=09Owner Module: 6
=09Mute: no
=09Volume: 0:  76% 1:  76%
=09        0: -7.00 dB 1: -7.00 dB
=09        balance 0.00
=09Base Volume:  10%
=09             -60.00 dB
=09Monitor of Sink: n/a
=09Latency: 0 usec, configured 0 usec
=09Flags: HARDWARE HW_MUTE_CTRL HW_VOLUME_CTRL DECIBEL_VOLUME LATENCY=20=

=09Properties:
=09=09alsa.resolution_bits =3D "16"
=09=09device.api =3D "alsa"
=09=09device.class =3D "sound"
=09=09alsa.class =3D "generic"
=09=09alsa.subclass =3D "generic-mix"
=09=09alsa.name =3D "ALC892 Analog"
=09=09alsa.id =3D "ALC892 Analog"
=09=09alsa.subdevice =3D "0"
=09=09alsa.subdevice_name =3D "subdevice #0"
=09=09alsa.device =3D "0"
=09=09alsa.card =3D "0"
=09=09alsa.card_name =3D "HDA Intel PCH"
=09=09alsa.long_card_name =3D "HDA Intel PCH at 0xf6500000 irq 52"
=09=09alsa.driver_name =3D "snd_hda_intel"
=09=09device.bus_path =3D "pci-0000:00:1b.0"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:1b.0/sound/card0"
=09=09device.bus =3D "pci"
=09=09device.vendor.id =3D "8086"
=09=09device.vendor.name =3D "Intel Corporation"
=09=09device.product.id =3D "1c20"
=09=09device.product.name =3D "6 Series/C200 Series Chipset Family High=
 Definition Audio Controller"
=09=09device.form_factor =3D "internal"
=09=09device.string =3D "front:0"
=09=09device.buffering.buffer_size =3D "65536"
=09=09device.buffering.fragment_size =3D "32768"
=09=09device.access_mode =3D "mmap+timer"
=09=09device.profile.name =3D "analog-stereo"
=09=09device.profile.description =3D "Analog Stereo"
=09=09device.description =3D "Built-in Audio Analog Stereo"
=09=09alsa.mixer_name =3D "Realtek ALC892"
=09=09alsa.components =3D "HDA:10ec0892,15587100,00100302"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-pci"
=09Ports:
=09=09analog-input-microphone-internal: Internal Microphone (priority: =
8900)
=09=09analog-input-microphone: Microphone (priority: 8700, not availabl=
e)
=09=09analog-input-linein: Line In (priority: 8100, not available)
=09Active Port: analog-input-microphone-internal
=09Formats:
=09=09pcm

Source #3
=09State: SUSPENDED
=09Name: alsa_output.usb-GN_Netcom_GN_2000_USB-00-USB.analog-stereo.mon=
itor
=09Description: Monitor of GN 2000 USB Analog Stereo
=09Driver: module-alsa-card.c
=09Sample Specification: s16le 2ch 44100Hz
=09Channel Map: front-left,front-right
=09Owner Module: 7
=09Mute: no
=09Volume: 0: 100% 1: 100%
=09        0: -0.01 dB 1: -0.01 dB
=09        balance 0.00
=09Base Volume: 100%
=09             0.00 dB
=09Monitor of Sink: alsa_output.usb-GN_Netcom_GN_2000_USB-00-USB.analog=
-stereo
=09Latency: 0 usec, configured 0 usec
=09Flags: DECIBEL_VOLUME LATENCY=20
=09Properties:
=09=09device.description =3D "Monitor of GN 2000 USB Analog Stereo"
=09=09device.class =3D "monitor"
=09=09alsa.card =3D "1"
=09=09alsa.card_name =3D "GN 2000 USB"
=09=09alsa.long_card_name =3D "GN Netcom GN 2000 USB at usb-0000:00:1d.=
0-1.1, full speed"
=09=09alsa.driver_name =3D "snd_usb_audio"
=09=09device.bus_path =3D "pci-0000:00:1d.0-usb-0:1.1:1.0"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.1/2=
-1.1:1.0/sound/card1"
=09=09udev.id =3D "usb-GN_Netcom_GN_2000_USB-00-USB"
=09=09device.bus =3D "usb"
=09=09device.vendor.id =3D "0b0e"
=09=09device.vendor.name =3D "GN Netcom"
=09=09device.product.id =3D "2000"
=09=09device.product.name =3D "GN 2000 USB"
=09=09device.serial =3D "GN_Netcom_GN_2000_USB"
=09=09device.string =3D "1"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-usb"
=09Formats:
=09=09pcm

Source #4
=09State: SUSPENDED
=09Name: alsa_input.usb-GN_Netcom_GN_2000_USB-00-USB.analog-stereo
=09Description: GN 2000 USB Analog Stereo
=09Driver: module-alsa-card.c
=09Sample Specification: s16le 2ch 44100Hz
=09Channel Map: front-left,front-right
=09Owner Module: 7
=09Mute: no
=09Volume: 0:  93% 1:  93%
=09        0: -1.91 dB 1: -1.91 dB
=09        balance 0.00
=09Base Volume:  30%
=09             -31.00 dB
=09Monitor of Sink: n/a
=09Latency: 0 usec, configured 0 usec
=09Flags: HARDWARE HW_MUTE_CTRL HW_VOLUME_CTRL DECIBEL_VOLUME LATENCY=20=

=09Properties:
=09=09alsa.resolution_bits =3D "16"
=09=09device.api =3D "alsa"
=09=09device.class =3D "sound"
=09=09alsa.class =3D "generic"
=09=09alsa.subclass =3D "generic-mix"
=09=09alsa.name =3D "USB Audio"
=09=09alsa.id =3D "USB Audio"
=09=09alsa.subdevice =3D "0"
=09=09alsa.subdevice_name =3D "subdevice #0"
=09=09alsa.device =3D "0"
=09=09alsa.card =3D "1"
=09=09alsa.card_name =3D "GN 2000 USB"
=09=09alsa.long_card_name =3D "GN Netcom GN 2000 USB at usb-0000:00:1d.=
0-1.1, full speed"
=09=09alsa.driver_name =3D "snd_usb_audio"
=09=09device.bus_path =3D "pci-0000:00:1d.0-usb-0:1.1:1.0"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.1/2=
-1.1:1.0/sound/card1"
=09=09udev.id =3D "usb-GN_Netcom_GN_2000_USB-00-USB"
=09=09device.bus =3D "usb"
=09=09device.vendor.id =3D "0b0e"
=09=09device.vendor.name =3D "GN Netcom"
=09=09device.product.id =3D "2000"
=09=09device.product.name =3D "GN 2000 USB"
=09=09device.serial =3D "GN_Netcom_GN_2000_USB"
=09=09device.string =3D "front:1"
=09=09device.buffering.buffer_size =3D "352800"
=09=09device.buffering.fragment_size =3D "176400"
=09=09device.access_mode =3D "mmap+timer"
=09=09device.profile.name =3D "analog-stereo"
=09=09device.profile.description =3D "Analog Stereo"
=09=09device.description =3D "GN 2000 USB Analog Stereo"
=09=09alsa.mixer_name =3D "USB Mixer"
=09=09alsa.components =3D "USB0b0e:2000"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-usb"
=09Ports:
=09=09analog-input-microphone: Microphone (priority: 8700)
=09Active Port: analog-input-microphone
=09Formats:
=09=09pcm

Client #0
=09Driver: module-systemd-login.c
=09Owner Module: 17
=09Properties:
=09=09application.name =3D "Login Session c4"
=09=09systemd-login.session =3D "c4"

Client #1
=09Driver: protocol-native.c
=09Owner Module: 11
=09Properties:
=09=09application.name =3D "KMix"
=09=09native-protocol.peer =3D "UNIX socket client"
=09=09native-protocol.version =3D "28"
=09=09application.process.id =3D "3983"
=09=09application.process.user =3D "jkugler"
=09=09application.process.host =3D "hosanna"
=09=09application.process.binary =3D "kmix"
=09=09application.language =3D "en_US.UTF-8"
=09=09window.x11.display =3D ":0"
=09=09application.process.machine_id =3D "f5f9985a3e8c192858318dd900000=
46a"
=09=09application.process.session_id =3D "c4"
=09=09application.icon_name =3D "kmix"

Client #2
=09Driver: protocol-native.c
=09Owner Module: 11
=09Properties:
=09=09application.name =3D "KNotify"
=09=09native-protocol.peer =3D "UNIX socket client"
=09=09native-protocol.version =3D "28"
=09=09application.icon_name =3D "knotify"
=09=09application.process.id =3D "4008"
=09=09application.process.user =3D "jkugler"
=09=09application.process.host =3D "hosanna"
=09=09application.process.binary =3D "knotify4"
=09=09application.language =3D "en_US.UTF-8"
=09=09window.x11.display =3D ":0"
=09=09application.process.machine_id =3D "f5f9985a3e8c192858318dd900000=
46a"
=09=09application.process.session_id =3D "c4"

Client #3
=09Driver: protocol-native.c
=09Owner Module: 11
=09Properties:
=09=09application.name =3D "KMix"
=09=09native-protocol.peer =3D "UNIX socket client"
=09=09native-protocol.version =3D "28"
=09=09application.process.id =3D "3741"
=09=09application.process.user =3D "jkugler"
=09=09application.process.host =3D "hosanna"
=09=09application.process.binary =3D "kdeinit4"
=09=09application.language =3D "en_US.UTF-8"
=09=09window.x11.display =3D ":0"
=09=09application.process.machine_id =3D "f5f9985a3e8c192858318dd900000=
46a"
=09=09application.process.session_id =3D "c4"

Client #4
=09Driver: protocol-native.c
=09Owner Module: 11
=09Properties:
=09=09application.name =3D "pactl"
=09=09native-protocol.peer =3D "UNIX socket client"
=09=09native-protocol.version =3D "28"
=09=09application.process.id =3D "20902"
=09=09application.process.user =3D "jkugler"
=09=09application.process.host =3D "hosanna"
=09=09application.process.binary =3D "pactl"
=09=09application.language =3D "en_US.UTF-8"
=09=09window.x11.display =3D ":0"
=09=09application.process.machine_id =3D "f5f9985a3e8c192858318dd900000=
46a"
=09=09application.process.session_id =3D "c4"

Card #0
=09Name: alsa_card.pci-0000_01_00.1
=09Driver: module-alsa-card.c
=09Owner Module: 5
=09Properties:
=09=09alsa.card =3D "2"
=09=09alsa.card_name =3D "HDA NVidia"
=09=09alsa.long_card_name =3D "HDA NVidia at 0xf6080000 irq 17"
=09=09alsa.driver_name =3D "snd_hda_intel"
=09=09device.bus_path =3D "pci-0000:01:00.1"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sou=
nd/card2"
=09=09device.bus =3D "pci"
=09=09device.vendor.id =3D "10de"
=09=09device.vendor.name =3D "NVIDIA Corporation"
=09=09device.product.id =3D "0bee"
=09=09device.product.name =3D "GF116 High Definition Audio Controller"
=09=09device.string =3D "2"
=09=09device.description =3D "GF116 High Definition Audio Controller"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-pci"
=09Profiles:
=09=09output:hdmi-stereo: Digital Stereo (HDMI) Output (sinks: 1, sourc=
es: 0, priority. 5400)
=09=09output:hdmi-surround: Digital Surround 5.1 (HDMI) Output (sinks: =
1, sources: 0, priority. 300)
=09=09output:hdmi-stereo-extra1: Digital Stereo (HDMI) Output (sinks: 1=
, sources: 0, priority. 5200)
=09=09output:hdmi-surround-extra1: Digital Surround 5.1 (HDMI) Output (=
sinks: 1, sources: 0, priority. 100)
=09=09output:hdmi-stereo-extra2: Digital Stereo (HDMI) Output (sinks: 1=
, sources: 0, priority. 5200)
=09=09output:hdmi-surround-extra2: Digital Surround 5.1 (HDMI) Output (=
sinks: 1, sources: 0, priority. 100)
=09=09output:hdmi-stereo-extra3: Digital Stereo (HDMI) Output (sinks: 1=
, sources: 0, priority. 5200)
=09=09output:hdmi-surround-extra3: Digital Surround 5.1 (HDMI) Output (=
sinks: 1, sources: 0, priority. 100)
=09=09off: Off (sinks: 0, sources: 0, priority. 0)
=09Active Profile: output:hdmi-stereo
=09Ports:
=09=09hdmi-output-0: HDMI / DisplayPort (priority: 5900, latency offset=
: 0 usec, not available)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "video-display"
=09=09=09Part of profile(s): output:hdmi-stereo, output:hdmi-surround
=09=09hdmi-output-1: HDMI / DisplayPort 2 (priority: 5800, latency offs=
et: 0 usec, not available)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "video-display"
=09=09=09Part of profile(s): output:hdmi-stereo-extra1, output:hdmi-sur=
round-extra1
=09=09hdmi-output-2: HDMI / DisplayPort 3 (priority: 5700, latency offs=
et: 0 usec, not available)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "video-display"
=09=09=09Part of profile(s): output:hdmi-stereo-extra2, output:hdmi-sur=
round-extra2
=09=09hdmi-output-3: HDMI / DisplayPort 4 (priority: 5600, latency offs=
et: 0 usec, not available)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "video-display"
=09=09=09Part of profile(s): output:hdmi-stereo-extra3, output:hdmi-sur=
round-extra3

Card #1
=09Name: alsa_card.pci-0000_00_1b.0
=09Driver: module-alsa-card.c
=09Owner Module: 6
=09Properties:
=09=09alsa.card =3D "0"
=09=09alsa.card_name =3D "HDA Intel PCH"
=09=09alsa.long_card_name =3D "HDA Intel PCH at 0xf6500000 irq 52"
=09=09alsa.driver_name =3D "snd_hda_intel"
=09=09device.bus_path =3D "pci-0000:00:1b.0"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:1b.0/sound/card0"
=09=09device.bus =3D "pci"
=09=09device.vendor.id =3D "8086"
=09=09device.vendor.name =3D "Intel Corporation"
=09=09device.product.id =3D "1c20"
=09=09device.product.name =3D "6 Series/C200 Series Chipset Family High=
 Definition Audio Controller"
=09=09device.form_factor =3D "internal"
=09=09device.string =3D "0"
=09=09device.description =3D "Built-in Audio"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-pci"
=09Profiles:
=09=09input:analog-stereo: Analog Stereo Input (sinks: 0, sources: 1, p=
riority. 60)
=09=09output:analog-stereo: Analog Stereo Output (sinks: 1, sources: 0,=
 priority. 6000)
=09=09output:analog-stereo+input:analog-stereo: Analog Stereo Duplex (s=
inks: 1, sources: 1, priority. 6060)
=09=09output:analog-surround-40: Analog Surround 4.0 Output (sinks: 1, =
sources: 0, priority. 700)
=09=09output:analog-surround-40+input:analog-stereo: Analog Surround 4.=
0 Output + Analog Stereo Input (sinks: 1, sources: 1, priority. 760)
=09=09output:analog-surround-41: Analog Surround 4.1 Output (sinks: 1, =
sources: 0, priority. 800)
=09=09output:analog-surround-41+input:analog-stereo: Analog Surround 4.=
1 Output + Analog Stereo Input (sinks: 1, sources: 1, priority. 860)
=09=09output:analog-surround-50: Analog Surround 5.0 Output (sinks: 1, =
sources: 0, priority. 700)
=09=09output:analog-surround-50+input:analog-stereo: Analog Surround 5.=
0 Output + Analog Stereo Input (sinks: 1, sources: 1, priority. 760)
=09=09output:analog-surround-51: Analog Surround 5.1 Output (sinks: 1, =
sources: 0, priority. 800)
=09=09output:analog-surround-51+input:analog-stereo: Analog Surround 5.=
1 Output + Analog Stereo Input (sinks: 1, sources: 1, priority. 860)
=09=09output:iec958-stereo: Digital Stereo (IEC958) Output (sinks: 1, s=
ources: 0, priority. 5500)
=09=09output:iec958-stereo+input:analog-stereo: Digital Stereo (IEC958)=
 Output + Analog Stereo Input (sinks: 1, sources: 1, priority. 5560)
=09=09off: Off (sinks: 0, sources: 0, priority. 0)
=09Active Profile: output:analog-stereo+input:analog-stereo
=09Ports:
=09=09analog-input-microphone-internal: Internal Microphone (priority: =
8900, latency offset: 0 usec)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "audio-input-microphone"
=09=09=09Part of profile(s): input:analog-stereo, output:analog-stereo+=
input:analog-stereo, output:analog-surround-40+input:analog-stereo, out=
put:analog-surround-41+input:analog-stereo, output:analog-surround-50+i=
nput:analog-stereo, output:analog-surround-51+input:analog-stereo, outp=
ut:iec958-stereo+input:analog-stereo
=09=09analog-input-microphone: Microphone (priority: 8700, latency offs=
et: 0 usec, not available)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "audio-input-microphone"
=09=09=09Part of profile(s): input:analog-stereo, output:analog-stereo+=
input:analog-stereo, output:analog-surround-40+input:analog-stereo, out=
put:analog-surround-41+input:analog-stereo, output:analog-surround-50+i=
nput:analog-stereo, output:analog-surround-51+input:analog-stereo, outp=
ut:iec958-stereo+input:analog-stereo
=09=09analog-input-linein: Line In (priority: 8100, latency offset: 0 u=
sec, not available)
=09=09=09Part of profile(s): input:analog-stereo, output:analog-stereo+=
input:analog-stereo, output:analog-surround-40+input:analog-stereo, out=
put:analog-surround-41+input:analog-stereo, output:analog-surround-50+i=
nput:analog-stereo, output:analog-surround-51+input:analog-stereo, outp=
ut:iec958-stereo+input:analog-stereo
=09=09analog-output: Analog Output (priority: 9900, latency offset: 0 u=
sec)
=09=09=09Part of profile(s): output:analog-stereo, output:analog-stereo=
+input:analog-stereo, output:analog-surround-40, output:analog-surround=
-40+input:analog-stereo, output:analog-surround-41, output:analog-surro=
und-41+input:analog-stereo, output:analog-surround-50, output:analog-su=
rround-50+input:analog-stereo, output:analog-surround-51, output:analog=
-surround-51+input:analog-stereo
=09=09analog-output-headphones: Headphones (priority: 9000, latency off=
set: 0 usec, not available)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "audio-headphones"
=09=09=09Part of profile(s): output:analog-stereo, output:analog-stereo=
+input:analog-stereo
=09=09iec958-stereo-output: Digital Output (S/PDIF) (priority: 0, laten=
cy offset: 0 usec)
=09=09=09Part of profile(s): output:iec958-stereo, output:iec958-stereo=
+input:analog-stereo

Card #2
=09Name: alsa_card.usb-GN_Netcom_GN_2000_USB-00-USB
=09Driver: module-alsa-card.c
=09Owner Module: 7
=09Properties:
=09=09alsa.card =3D "1"
=09=09alsa.card_name =3D "GN 2000 USB"
=09=09alsa.long_card_name =3D "GN Netcom GN 2000 USB at usb-0000:00:1d.=
0-1.1, full speed"
=09=09alsa.driver_name =3D "snd_usb_audio"
=09=09device.bus_path =3D "pci-0000:00:1d.0-usb-0:1.1:1.0"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.1/2=
-1.1:1.0/sound/card1"
=09=09udev.id =3D "usb-GN_Netcom_GN_2000_USB-00-USB"
=09=09device.bus =3D "usb"
=09=09device.vendor.id =3D "0b0e"
=09=09device.vendor.name =3D "GN Netcom"
=09=09device.product.id =3D "2000"
=09=09device.product.name =3D "GN 2000 USB"
=09=09device.serial =3D "GN_Netcom_GN_2000_USB"
=09=09device.string =3D "1"
=09=09device.description =3D "GN 2000 USB"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-usb"
=09Profiles:
=09=09input:analog-mono: Analog Mono Input (sinks: 0, sources: 1, prior=
ity. 1)
=09=09input:analog-stereo: Analog Stereo Input (sinks: 0, sources: 1, p=
riority. 60)
=09=09input:iec958-stereo: Digital Stereo (IEC958) Input (sinks: 0, sou=
rces: 1, priority. 55)
=09=09output:analog-mono: Analog Mono Output (sinks: 1, sources: 0, pri=
ority. 100)
=09=09output:analog-mono+input:analog-mono: Analog Mono Duplex (sinks: =
1, sources: 1, priority. 101)
=09=09output:analog-mono+input:analog-stereo: Analog Mono Output + Anal=
og Stereo Input (sinks: 1, sources: 1, priority. 160)
=09=09output:analog-mono+input:iec958-stereo: Analog Mono Output + Digi=
tal Stereo (IEC958) Input (sinks: 1, sources: 1, priority. 155)
=09=09output:analog-stereo: Analog Stereo Output (sinks: 1, sources: 0,=
 priority. 6000)
=09=09output:analog-stereo+input:analog-mono: Analog Stereo Output + An=
alog Mono Input (sinks: 1, sources: 1, priority. 6001)
=09=09output:analog-stereo+input:analog-stereo: Analog Stereo Duplex (s=
inks: 1, sources: 1, priority. 6060)
=09=09output:analog-stereo+input:iec958-stereo: Analog Stereo Output + =
Digital Stereo (IEC958) Input (sinks: 1, sources: 1, priority. 6055)
=09=09output:iec958-stereo: Digital Stereo (IEC958) Output (sinks: 1, s=
ources: 0, priority. 5500)
=09=09output:iec958-stereo+input:analog-mono: Digital Stereo (IEC958) O=
utput + Analog Mono Input (sinks: 1, sources: 1, priority. 5501)
=09=09output:iec958-stereo+input:analog-stereo: Digital Stereo (IEC958)=
 Output + Analog Stereo Input (sinks: 1, sources: 1, priority. 5560)
=09=09output:iec958-stereo+input:iec958-stereo: Digital Stereo Duplex (=
IEC958) (sinks: 1, sources: 1, priority. 5555)
=09=09off: Off (sinks: 0, sources: 0, priority. 0)
=09Active Profile: output:analog-stereo+input:analog-stereo
=09Ports:
=09=09analog-input-microphone: Microphone (priority: 8700, latency offs=
et: 0 usec)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "audio-input-microphone"
=09=09=09Part of profile(s): input:analog-mono, input:analog-stereo, ou=
tput:analog-mono+input:analog-mono, output:analog-mono+input:analog-ste=
reo, output:analog-stereo+input:analog-mono, output:analog-stereo+input=
:analog-stereo, output:iec958-stereo+input:analog-mono, output:iec958-s=
tereo+input:analog-stereo
=09=09iec958-stereo-input: Digital Input (S/PDIF) (priority: 0, latency=
 offset: 0 usec)
=09=09=09Part of profile(s): input:iec958-stereo, output:analog-mono+in=
put:iec958-stereo, output:analog-stereo+input:iec958-stereo, output:iec=
958-stereo+input:iec958-stereo
=09=09analog-output-speaker;output-bass-boost-on: Speakers / Bass Boost=
 (priority: 10000, latency offset: 0 usec)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "audio-speakers"
=09=09=09Part of profile(s): output:analog-mono, output:analog-mono+inp=
ut:analog-mono, output:analog-mono+input:analog-stereo, output:analog-m=
ono+input:iec958-stereo, output:analog-stereo, output:analog-stereo+inp=
ut:analog-mono, output:analog-stereo+input:analog-stereo, output:analog=
-stereo+input:iec958-stereo
=09=09analog-output-speaker;output-bass-boost-off: Speakers / No Bass B=
oost (priority: 10010, latency offset: 0 usec)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "audio-speakers"
=09=09=09Part of profile(s): output:analog-mono, output:analog-mono+inp=
ut:analog-mono, output:analog-mono+input:analog-stereo, output:analog-m=
ono+input:iec958-stereo, output:analog-stereo, output:analog-stereo+inp=
ut:analog-mono, output:analog-stereo+input:analog-stereo, output:analog=
-stereo+input:iec958-stereo
=09=09iec958-stereo-output: Digital Output (S/PDIF) (priority: 0, laten=
cy offset: 0 usec)
=09=09=09Part of profile(s): output:iec958-stereo, output:iec958-stereo=
+input:analog-mono, output:iec958-stereo+input:analog-stereo, output:ie=
c958-stereo+input:iec958-stereo

--nextPart1801830.RAKFpmdGti
Content-Disposition: attachment; filename="pactl-list-after-plug.txt"
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; name="pactl-list-after-plug.txt"

Module #0
=09Name: module-device-restore
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Automatically restore the volume/mute sta=
te of devices"
=09=09module.version =3D "4.0"

Module #1
=09Name: module-stream-restore
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Automatically restore the volume/mute/dev=
ice state of streams"
=09=09module.version =3D "4.0"

Module #2
=09Name: module-card-restore
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Automatically restore profile of cards"
=09=09module.version =3D "4.0"

Module #3
=09Name: module-augment-properties
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Augment the property sets of streams with=
 additional static information"
=09=09module.version =3D "4.0"

Module #4
=09Name: module-switch-on-port-available
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09

Module #5
=09Name: module-alsa-card
=09Argument: device_id=3D"2" name=3D"pci-0000_01_00.1" card_name=3D"als=
a_card.pci-0000_01_00.1" namereg_fail=3Dfalse tsched=3Dyes fixed_latenc=
y_range=3Dno ignore_dB=3Dno deferred_volume=3Dyes use_ucm=3Dyes card_pr=
operties=3D"module-udev-detect.discovered=3D1"
=09Usage counter: 0
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "ALSA Card"
=09=09module.version =3D "4.0"

Module #6
=09Name: module-alsa-card
=09Argument: device_id=3D"0" name=3D"pci-0000_00_1b.0" card_name=3D"als=
a_card.pci-0000_00_1b.0" namereg_fail=3Dfalse tsched=3Dyes fixed_latenc=
y_range=3Dno ignore_dB=3Dno deferred_volume=3Dyes use_ucm=3Dyes card_pr=
operties=3D"module-udev-detect.discovered=3D1"
=09Usage counter: 0
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "ALSA Card"
=09=09module.version =3D "4.0"

Module #9
=09Name: module-udev-detect
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Detect available audio hardware and load =
matching drivers"
=09=09module.version =3D "4.0"

Module #10
=09Name: module-bluetooth-policy
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Fr=C3=A9d=C3=A9ric Dalleau"
=09=09module.description =3D "When a bluetooth sink or source is added,=
 load module-loopback"
=09=09module.version =3D "4.0"

Module #11
=09Name: module-bluetooth-discover
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Joao Paulo Rechi Vita"
=09=09module.description =3D "Detect available bluetooth audio devices =
and load bluetooth audio drivers"
=09=09module.version =3D "4.0"

Module #12
=09Name: module-native-protocol-unix
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Native protocol (UNIX sockets)"
=09=09module.version =3D "4.0"

Module #13
=09Name: module-default-device-restore
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Automatically restore the default sink an=
d source"
=09=09module.version =3D "4.0"

Module #14
=09Name: module-rescue-streams
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "When a sink/source is removed, try to mov=
e their streams to the default sink/source"
=09=09module.version =3D "4.0"

Module #15
=09Name: module-always-sink
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Colin Guthrie"
=09=09module.description =3D "Always keeps at least one sink loaded eve=
n if it's a null one"
=09=09module.version =3D "4.0"

Module #16
=09Name: module-intended-roles
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Automatically set device of streams based=
 of intended roles of devices"
=09=09module.version =3D "4.0"

Module #17
=09Name: module-suspend-on-idle
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "When a sink/source is idle for too long, =
suspend it"
=09=09module.version =3D "4.0"

Module #18
=09Name: module-systemd-login
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Create a client for each login session of=
 this user"
=09=09module.version =3D "4.0"

Module #19
=09Name: module-position-event-sounds
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Position event sounds between L and R dep=
ending on the position on screen of the widget triggering them."
=09=09module.version =3D "4.0"

Module #20
=09Name: module-filter-heuristics
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Colin Guthrie"
=09=09module.description =3D "Detect when various filters are desirable=
"
=09=09module.version =3D "4.0"

Module #21
=09Name: module-filter-apply
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Colin Guthrie"
=09=09module.description =3D "Load filter sinks automatically when need=
ed"
=09=09module.version =3D "4.0"

Module #22
=09Name: module-device-manager
=09Argument: do_routing=3D1
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Colin Guthrie"
=09=09module.description =3D "Keep track of devices (and their descript=
ions) both past and present and prioritise by role"
=09=09module.version =3D "4.0"

Module #23
=09Name: module-x11-publish
=09Argument: display=3D:0
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "X11 credential publisher"
=09=09module.version =3D "4.0"

Module #24
=09Name: module-x11-bell
=09Argument: display=3D:0 sample=3Dbell.ogg
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "X11 bell interceptor"
=09=09module.version =3D "4.0"

Module #25
=09Name: module-x11-bell
=09Argument: display=3D:0 sample=3Dbell.ogg
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "X11 bell interceptor"
=09=09module.version =3D "4.0"

Module #26
=09Name: module-x11-cork-request
=09Argument: display=3D:0
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Synthesize X11 media key events when cork=
/uncork is requested"
=09=09module.version =3D "4.0"

Module #27
=09Name: module-x11-xsmp
=09Argument: display=3D:0 session_manager=3Dlocal/hosanna:@/tmp/.ICE-un=
ix/3777,unix/hosanna:/tmp/.ICE-unix/3777
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "X11 session management"
=09=09module.version =3D "4.0"

Module #36
=09Name: module-alsa-card
=09Argument: device_id=3D"1" name=3D"usb-GN_Netcom_GN_2000_USB-00-USB" =
card_name=3D"alsa_card.usb-GN_Netcom_GN_2000_USB-00-USB" namereg_fail=3D=
false tsched=3Dyes fixed_latency_range=3Dno ignore_dB=3Dno deferred_vol=
ume=3Dyes use_ucm=3Dyes card_properties=3D"module-udev-detect.discovere=
d=3D1"
=09Usage counter: 0
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "ALSA Card"
=09=09module.version =3D "4.0"

Sink #1
=09State: SUSPENDED
=09Name: alsa_output.pci-0000_00_1b.0.analog-stereo
=09Description: Built-in Audio Analog Stereo
=09Driver: module-alsa-card.c
=09Sample Specification: s16le 2ch 48000Hz
=09Channel Map: front-left,front-right
=09Owner Module: 6
=09Mute: no
=09Volume: 0:  20% 1:  20%
=09        0: -42.18 dB 1: -42.18 dB
=09        balance 0.00
=09Base Volume: 100%
=09             0.00 dB
=09Monitor Source: alsa_output.pci-0000_00_1b.0.analog-stereo.monitor
=09Latency: 0 usec, configured 0 usec
=09Flags: HARDWARE HW_MUTE_CTRL HW_VOLUME_CTRL DECIBEL_VOLUME LATENCY=20=

=09Properties:
=09=09alsa.resolution_bits =3D "16"
=09=09device.api =3D "alsa"
=09=09device.class =3D "sound"
=09=09alsa.class =3D "generic"
=09=09alsa.subclass =3D "generic-mix"
=09=09alsa.name =3D "ALC892 Analog"
=09=09alsa.id =3D "ALC892 Analog"
=09=09alsa.subdevice =3D "0"
=09=09alsa.subdevice_name =3D "subdevice #0"
=09=09alsa.device =3D "0"
=09=09alsa.card =3D "0"
=09=09alsa.card_name =3D "HDA Intel PCH"
=09=09alsa.long_card_name =3D "HDA Intel PCH at 0xf6500000 irq 52"
=09=09alsa.driver_name =3D "snd_hda_intel"
=09=09device.bus_path =3D "pci-0000:00:1b.0"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:1b.0/sound/card0"
=09=09device.bus =3D "pci"
=09=09device.vendor.id =3D "8086"
=09=09device.vendor.name =3D "Intel Corporation"
=09=09device.product.id =3D "1c20"
=09=09device.product.name =3D "6 Series/C200 Series Chipset Family High=
 Definition Audio Controller"
=09=09device.form_factor =3D "internal"
=09=09device.string =3D "front:0"
=09=09device.buffering.buffer_size =3D "65536"
=09=09device.buffering.fragment_size =3D "32768"
=09=09device.access_mode =3D "mmap+timer"
=09=09device.profile.name =3D "analog-stereo"
=09=09device.profile.description =3D "Analog Stereo"
=09=09device.description =3D "Built-in Audio Analog Stereo"
=09=09alsa.mixer_name =3D "Realtek ALC892"
=09=09alsa.components =3D "HDA:10ec0892,15587100,00100302"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-pci"
=09Ports:
=09=09analog-output: Analog Output (priority: 9900)
=09=09analog-output-headphones: Headphones (priority: 9000, not availab=
le)
=09Active Port: analog-output
=09Formats:
=09=09pcm

Sink #5
=09State: SUSPENDED
=09Name: alsa_output.usb-GN_Netcom_GN_2000_USB-00-USB.analog-stereo
=09Description: GN 2000 USB Analog Stereo
=09Driver: module-alsa-card.c
=09Sample Specification: s16le 2ch 44100Hz
=09Channel Map: front-left,front-right
=09Owner Module: 36
=09Mute: no
=09Volume: 0:  65% 1:  65%
=09        0: -11.19 dB 1: -11.19 dB
=09        balance 0.00
=09Base Volume:  89%
=09             -3.00 dB
=09Monitor Source: alsa_output.usb-GN_Netcom_GN_2000_USB-00-USB.analog-=
stereo.monitor
=09Latency: 0 usec, configured 0 usec
=09Flags: HARDWARE HW_MUTE_CTRL HW_VOLUME_CTRL DECIBEL_VOLUME LATENCY=20=

=09Properties:
=09=09alsa.resolution_bits =3D "16"
=09=09device.api =3D "alsa"
=09=09device.class =3D "sound"
=09=09alsa.class =3D "generic"
=09=09alsa.subclass =3D "generic-mix"
=09=09alsa.name =3D "USB Audio"
=09=09alsa.id =3D "USB Audio"
=09=09alsa.subdevice =3D "0"
=09=09alsa.subdevice_name =3D "subdevice #0"
=09=09alsa.device =3D "0"
=09=09alsa.card =3D "1"
=09=09alsa.card_name =3D "GN 2000 USB"
=09=09alsa.long_card_name =3D "GN Netcom GN 2000 USB at usb-0000:00:1d.=
0-1.1, full speed"
=09=09alsa.driver_name =3D "snd_usb_audio"
=09=09device.bus_path =3D "pci-0000:00:1d.0-usb-0:1.1:1.0"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.1/2=
-1.1:1.0/sound/card1"
=09=09udev.id =3D "usb-GN_Netcom_GN_2000_USB-00-USB"
=09=09device.bus =3D "usb"
=09=09device.vendor.id =3D "0b0e"
=09=09device.vendor.name =3D "GN Netcom"
=09=09device.product.id =3D "2000"
=09=09device.product.name =3D "GN 2000 USB"
=09=09device.serial =3D "GN_Netcom_GN_2000_USB"
=09=09device.string =3D "front:1"
=09=09device.buffering.buffer_size =3D "352800"
=09=09device.buffering.fragment_size =3D "176400"
=09=09device.access_mode =3D "mmap+timer"
=09=09device.profile.name =3D "analog-stereo"
=09=09device.profile.description =3D "Analog Stereo"
=09=09device.description =3D "GN 2000 USB Analog Stereo"
=09=09alsa.mixer_name =3D "USB Mixer"
=09=09alsa.components =3D "USB0b0e:2000"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-usb"
=09Ports:
=09=09analog-output-speaker;output-bass-boost-on: Speakers / Bass Boost=
 (priority: 10000)
=09=09analog-output-speaker;output-bass-boost-off: Speakers / No Bass B=
oost (priority: 10010)
=09Active Port: analog-output-speaker;output-bass-boost-off
=09Formats:
=09=09pcm

Source #1
=09State: SUSPENDED
=09Name: alsa_output.pci-0000_00_1b.0.analog-stereo.monitor
=09Description: Monitor of Built-in Audio Analog Stereo
=09Driver: module-alsa-card.c
=09Sample Specification: s16le 2ch 44100Hz
=09Channel Map: front-left,front-right
=09Owner Module: 6
=09Mute: yes
=09Volume: 0: 100% 1: 100%
=09        0: 0.00 dB 1: 0.00 dB
=09        balance 0.00
=09Base Volume: 100%
=09             0.00 dB
=09Monitor of Sink: alsa_output.pci-0000_00_1b.0.analog-stereo
=09Latency: 0 usec, configured 0 usec
=09Flags: DECIBEL_VOLUME LATENCY=20
=09Properties:
=09=09device.description =3D "Monitor of Built-in Audio Analog Stereo"
=09=09device.class =3D "monitor"
=09=09alsa.card =3D "0"
=09=09alsa.card_name =3D "HDA Intel PCH"
=09=09alsa.long_card_name =3D "HDA Intel PCH at 0xf6500000 irq 52"
=09=09alsa.driver_name =3D "snd_hda_intel"
=09=09device.bus_path =3D "pci-0000:00:1b.0"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:1b.0/sound/card0"
=09=09device.bus =3D "pci"
=09=09device.vendor.id =3D "8086"
=09=09device.vendor.name =3D "Intel Corporation"
=09=09device.product.id =3D "1c20"
=09=09device.product.name =3D "6 Series/C200 Series Chipset Family High=
 Definition Audio Controller"
=09=09device.form_factor =3D "internal"
=09=09device.string =3D "0"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-pci"
=09Formats:
=09=09pcm

Source #2
=09State: SUSPENDED
=09Name: alsa_input.pci-0000_00_1b.0.analog-stereo
=09Description: Built-in Audio Analog Stereo
=09Driver: module-alsa-card.c
=09Sample Specification: s16le 2ch 44100Hz
=09Channel Map: front-left,front-right
=09Owner Module: 6
=09Mute: no
=09Volume: 0:  76% 1:  76%
=09        0: -7.00 dB 1: -7.00 dB
=09        balance 0.00
=09Base Volume:  10%
=09             -60.00 dB
=09Monitor of Sink: n/a
=09Latency: 0 usec, configured 0 usec
=09Flags: HARDWARE HW_MUTE_CTRL HW_VOLUME_CTRL DECIBEL_VOLUME LATENCY=20=

=09Properties:
=09=09alsa.resolution_bits =3D "16"
=09=09device.api =3D "alsa"
=09=09device.class =3D "sound"
=09=09alsa.class =3D "generic"
=09=09alsa.subclass =3D "generic-mix"
=09=09alsa.name =3D "ALC892 Analog"
=09=09alsa.id =3D "ALC892 Analog"
=09=09alsa.subdevice =3D "0"
=09=09alsa.subdevice_name =3D "subdevice #0"
=09=09alsa.device =3D "0"
=09=09alsa.card =3D "0"
=09=09alsa.card_name =3D "HDA Intel PCH"
=09=09alsa.long_card_name =3D "HDA Intel PCH at 0xf6500000 irq 52"
=09=09alsa.driver_name =3D "snd_hda_intel"
=09=09device.bus_path =3D "pci-0000:00:1b.0"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:1b.0/sound/card0"
=09=09device.bus =3D "pci"
=09=09device.vendor.id =3D "8086"
=09=09device.vendor.name =3D "Intel Corporation"
=09=09device.product.id =3D "1c20"
=09=09device.product.name =3D "6 Series/C200 Series Chipset Family High=
 Definition Audio Controller"
=09=09device.form_factor =3D "internal"
=09=09device.string =3D "front:0"
=09=09device.buffering.buffer_size =3D "65536"
=09=09device.buffering.fragment_size =3D "32768"
=09=09device.access_mode =3D "mmap+timer"
=09=09device.profile.name =3D "analog-stereo"
=09=09device.profile.description =3D "Analog Stereo"
=09=09device.description =3D "Built-in Audio Analog Stereo"
=09=09alsa.mixer_name =3D "Realtek ALC892"
=09=09alsa.components =3D "HDA:10ec0892,15587100,00100302"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-pci"
=09Ports:
=09=09analog-input-microphone-internal: Internal Microphone (priority: =
8900)
=09=09analog-input-microphone: Microphone (priority: 8700, not availabl=
e)
=09=09analog-input-linein: Line In (priority: 8100, not available)
=09Active Port: analog-input-microphone-internal
=09Formats:
=09=09pcm

Source #11
=09State: SUSPENDED
=09Name: alsa_output.usb-GN_Netcom_GN_2000_USB-00-USB.analog-stereo.mon=
itor
=09Description: Monitor of GN 2000 USB Analog Stereo
=09Driver: module-alsa-card.c
=09Sample Specification: s16le 2ch 44100Hz
=09Channel Map: front-left,front-right
=09Owner Module: 36
=09Mute: no
=09Volume: 0: 100% 1: 100%
=09        0: -0.01 dB 1: -0.01 dB
=09        balance 0.00
=09Base Volume: 100%
=09             0.00 dB
=09Monitor of Sink: alsa_output.usb-GN_Netcom_GN_2000_USB-00-USB.analog=
-stereo
=09Latency: 0 usec, configured 0 usec
=09Flags: DECIBEL_VOLUME LATENCY=20
=09Properties:
=09=09device.description =3D "Monitor of GN 2000 USB Analog Stereo"
=09=09device.class =3D "monitor"
=09=09alsa.card =3D "1"
=09=09alsa.card_name =3D "GN 2000 USB"
=09=09alsa.long_card_name =3D "GN Netcom GN 2000 USB at usb-0000:00:1d.=
0-1.1, full speed"
=09=09alsa.driver_name =3D "snd_usb_audio"
=09=09device.bus_path =3D "pci-0000:00:1d.0-usb-0:1.1:1.0"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.1/2=
-1.1:1.0/sound/card1"
=09=09udev.id =3D "usb-GN_Netcom_GN_2000_USB-00-USB"
=09=09device.bus =3D "usb"
=09=09device.vendor.id =3D "0b0e"
=09=09device.vendor.name =3D "GN Netcom"
=09=09device.product.id =3D "2000"
=09=09device.product.name =3D "GN 2000 USB"
=09=09device.serial =3D "GN_Netcom_GN_2000_USB"
=09=09device.string =3D "1"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-usb"
=09Formats:
=09=09pcm

Client #0
=09Driver: module-systemd-login.c
=09Owner Module: 18
=09Properties:
=09=09application.name =3D "Login Session c4"
=09=09systemd-login.session =3D "c4"

Client #4
=09Driver: protocol-native.c
=09Owner Module: 12
=09Properties:
=09=09application.name =3D "KMix"
=09=09native-protocol.peer =3D "UNIX socket client"
=09=09native-protocol.version =3D "28"
=09=09application.process.id =3D "3983"
=09=09application.process.user =3D "jkugler"
=09=09application.process.host =3D "hosanna"
=09=09application.process.binary =3D "kmix"
=09=09application.language =3D "en_US.UTF-8"
=09=09window.x11.display =3D ":0"
=09=09application.process.machine_id =3D "f5f9985a3e8c192858318dd900000=
46a"
=09=09application.process.session_id =3D "c4"
=09=09application.icon_name =3D "kmix"

Client #6
=09Driver: protocol-native.c
=09Owner Module: 12
=09Properties:
=09=09application.name =3D "KNotify"
=09=09native-protocol.peer =3D "UNIX socket client"
=09=09native-protocol.version =3D "28"
=09=09application.icon_name =3D "knotify"
=09=09application.process.id =3D "4008"
=09=09application.process.user =3D "jkugler"
=09=09application.process.host =3D "hosanna"
=09=09application.process.binary =3D "knotify4"
=09=09application.language =3D "en_US.UTF-8"
=09=09window.x11.display =3D ":0"
=09=09application.process.machine_id =3D "f5f9985a3e8c192858318dd900000=
46a"
=09=09application.process.session_id =3D "c4"

Client #11
=09Driver: protocol-native.c
=09Owner Module: 12
=09Properties:
=09=09application.name =3D "KMix"
=09=09native-protocol.peer =3D "UNIX socket client"
=09=09native-protocol.version =3D "28"
=09=09application.process.id =3D "3741"
=09=09application.process.user =3D "jkugler"
=09=09application.process.host =3D "hosanna"
=09=09application.process.binary =3D "kdeinit4"
=09=09application.language =3D "en_US.UTF-8"
=09=09window.x11.display =3D ":0"
=09=09application.process.machine_id =3D "f5f9985a3e8c192858318dd900000=
46a"
=09=09application.process.session_id =3D "c4"

Client #18
=09Driver: module-x11-xsmp.c
=09Owner Module: 27
=09Properties:
=09=09application.name =3D "XSMP Session on KDE as 10d6ddd4610001413561=
97700000037770030"
=09=09xsmp.vendor =3D "KDE"
=09=09xsmp.client.id =3D "10d6ddd461000141356197700000037770030"

Client #19
=09Driver: protocol-native.c
=09Owner Module: 12
=09Properties:
=09=09application.name =3D "Skype"
=09=09native-protocol.peer =3D "UNIX socket client"
=09=09native-protocol.version =3D "28"
=09=09application.process.id =3D "4064"
=09=09application.process.user =3D "jkugler"
=09=09application.process.host =3D "hosanna"
=09=09application.process.binary =3D "skype"
=09=09application.language =3D "en_US.UTF-8"
=09=09window.x11.display =3D ":0"
=09=09application.process.machine_id =3D "f5f9985a3e8c192858318dd900000=
46a"
=09=09application.process.session_id =3D "c4"
=09=09application.icon_name =3D "skype.png"

Client #24
=09Driver: protocol-native.c
=09Owner Module: 12
=09Properties:
=09=09application.name =3D "Chrome input"
=09=09native-protocol.peer =3D "UNIX socket client"
=09=09native-protocol.version =3D "28"
=09=09application.process.id =3D "4508"
=09=09application.process.user =3D "jkugler"
=09=09application.process.host =3D "hosanna"
=09=09application.process.binary =3D "chrome"
=09=09application.language =3D "en_US.UTF-8"
=09=09window.x11.display =3D ":0"
=09=09application.process.machine_id =3D "f5f9985a3e8c192858318dd900000=
46a"
=09=09application.process.session_id =3D "c4"

Client #408
=09Driver: protocol-native.c
=09Owner Module: 12
=09Properties:
=09=09application.name =3D "AudioStream"
=09=09native-protocol.peer =3D "UNIX socket client"
=09=09native-protocol.version =3D "28"
=09=09application.process.id =3D "6142"
=09=09application.process.user =3D "jkugler"
=09=09application.process.host =3D "hosanna"
=09=09application.process.binary =3D "firefox"
=09=09application.language =3D "en_US.UTF-8"
=09=09window.x11.display =3D ":0"
=09=09application.process.machine_id =3D "f5f9985a3e8c192858318dd900000=
46a"
=09=09application.process.session_id =3D "c4"
=09=09application.icon_name =3D "firefox"

Client #580
=09Driver: protocol-native.c
=09Owner Module: 12
=09Properties:
=09=09application.name =3D "pactl"
=09=09native-protocol.peer =3D "UNIX socket client"
=09=09native-protocol.version =3D "28"
=09=09application.process.id =3D "20791"
=09=09application.process.user =3D "jkugler"
=09=09application.process.host =3D "hosanna"
=09=09application.process.binary =3D "pactl"
=09=09application.language =3D "en_US.UTF-8"
=09=09window.x11.display =3D ":0"
=09=09application.process.machine_id =3D "f5f9985a3e8c192858318dd900000=
46a"
=09=09application.process.session_id =3D "c4"

Card #0
=09Name: alsa_card.pci-0000_01_00.1
=09Driver: module-alsa-card.c
=09Owner Module: 5
=09Properties:
=09=09alsa.card =3D "2"
=09=09alsa.card_name =3D "HDA NVidia"
=09=09alsa.long_card_name =3D "HDA NVidia at 0xf6080000 irq 17"
=09=09alsa.driver_name =3D "snd_hda_intel"
=09=09device.bus_path =3D "pci-0000:01:00.1"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sou=
nd/card2"
=09=09device.bus =3D "pci"
=09=09device.vendor.id =3D "10de"
=09=09device.vendor.name =3D "NVIDIA Corporation"
=09=09device.product.id =3D "0bee"
=09=09device.product.name =3D "GF116 High Definition Audio Controller"
=09=09device.string =3D "2"
=09=09device.description =3D "GF116 High Definition Audio Controller"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-pci"
=09Profiles:
=09=09output:hdmi-stereo: Digital Stereo (HDMI) Output (sinks: 1, sourc=
es: 0, priority. 5400)
=09=09output:hdmi-surround: Digital Surround 5.1 (HDMI) Output (sinks: =
1, sources: 0, priority. 300)
=09=09output:hdmi-stereo-extra1: Digital Stereo (HDMI) Output (sinks: 1=
, sources: 0, priority. 5200)
=09=09output:hdmi-surround-extra1: Digital Surround 5.1 (HDMI) Output (=
sinks: 1, sources: 0, priority. 100)
=09=09output:hdmi-stereo-extra2: Digital Stereo (HDMI) Output (sinks: 1=
, sources: 0, priority. 5200)
=09=09output:hdmi-surround-extra2: Digital Surround 5.1 (HDMI) Output (=
sinks: 1, sources: 0, priority. 100)
=09=09output:hdmi-stereo-extra3: Digital Stereo (HDMI) Output (sinks: 1=
, sources: 0, priority. 5200)
=09=09output:hdmi-surround-extra3: Digital Surround 5.1 (HDMI) Output (=
sinks: 1, sources: 0, priority. 100)
=09=09off: Off (sinks: 0, sources: 0, priority. 0)
=09Active Profile: output:hdmi-stereo-extra1
=09Ports:
=09=09hdmi-output-0: HDMI / DisplayPort (priority: 5900, latency offset=
: 0 usec, not available)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "video-display"
=09=09=09Part of profile(s): output:hdmi-stereo, output:hdmi-surround
=09=09hdmi-output-1: HDMI / DisplayPort 2 (priority: 5800, latency offs=
et: 0 usec, not available)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "video-display"
=09=09=09Part of profile(s): output:hdmi-stereo-extra1, output:hdmi-sur=
round-extra1
=09=09hdmi-output-2: HDMI / DisplayPort 3 (priority: 5700, latency offs=
et: 0 usec, not available)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "video-display"
=09=09=09Part of profile(s): output:hdmi-stereo-extra2, output:hdmi-sur=
round-extra2
=09=09hdmi-output-3: HDMI / DisplayPort 4 (priority: 5600, latency offs=
et: 0 usec, not available)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "video-display"
=09=09=09Part of profile(s): output:hdmi-stereo-extra3, output:hdmi-sur=
round-extra3

Card #1
=09Name: alsa_card.pci-0000_00_1b.0
=09Driver: module-alsa-card.c
=09Owner Module: 6
=09Properties:
=09=09alsa.card =3D "0"
=09=09alsa.card_name =3D "HDA Intel PCH"
=09=09alsa.long_card_name =3D "HDA Intel PCH at 0xf6500000 irq 52"
=09=09alsa.driver_name =3D "snd_hda_intel"
=09=09device.bus_path =3D "pci-0000:00:1b.0"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:1b.0/sound/card0"
=09=09device.bus =3D "pci"
=09=09device.vendor.id =3D "8086"
=09=09device.vendor.name =3D "Intel Corporation"
=09=09device.product.id =3D "1c20"
=09=09device.product.name =3D "6 Series/C200 Series Chipset Family High=
 Definition Audio Controller"
=09=09device.form_factor =3D "internal"
=09=09device.string =3D "0"
=09=09device.description =3D "Built-in Audio"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-pci"
=09Profiles:
=09=09input:analog-stereo: Analog Stereo Input (sinks: 0, sources: 1, p=
riority. 60)
=09=09output:analog-stereo: Analog Stereo Output (sinks: 1, sources: 0,=
 priority. 6000)
=09=09output:analog-stereo+input:analog-stereo: Analog Stereo Duplex (s=
inks: 1, sources: 1, priority. 6060)
=09=09output:analog-surround-40: Analog Surround 4.0 Output (sinks: 1, =
sources: 0, priority. 700)
=09=09output:analog-surround-40+input:analog-stereo: Analog Surround 4.=
0 Output + Analog Stereo Input (sinks: 1, sources: 1, priority. 760)
=09=09output:analog-surround-41: Analog Surround 4.1 Output (sinks: 1, =
sources: 0, priority. 800)
=09=09output:analog-surround-41+input:analog-stereo: Analog Surround 4.=
1 Output + Analog Stereo Input (sinks: 1, sources: 1, priority. 860)
=09=09output:analog-surround-50: Analog Surround 5.0 Output (sinks: 1, =
sources: 0, priority. 700)
=09=09output:analog-surround-50+input:analog-stereo: Analog Surround 5.=
0 Output + Analog Stereo Input (sinks: 1, sources: 1, priority. 760)
=09=09output:analog-surround-51: Analog Surround 5.1 Output (sinks: 1, =
sources: 0, priority. 800)
=09=09output:analog-surround-51+input:analog-stereo: Analog Surround 5.=
1 Output + Analog Stereo Input (sinks: 1, sources: 1, priority. 860)
=09=09output:iec958-stereo: Digital Stereo (IEC958) Output (sinks: 1, s=
ources: 0, priority. 5500)
=09=09output:iec958-stereo+input:analog-stereo: Digital Stereo (IEC958)=
 Output + Analog Stereo Input (sinks: 1, sources: 1, priority. 5560)
=09=09off: Off (sinks: 0, sources: 0, priority. 0)
=09Active Profile: output:analog-stereo+input:analog-stereo
=09Ports:
=09=09analog-input-microphone-internal: Internal Microphone (priority: =
8900, latency offset: 0 usec)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "audio-input-microphone"
=09=09=09Part of profile(s): input:analog-stereo, output:analog-stereo+=
input:analog-stereo, output:analog-surround-40+input:analog-stereo, out=
put:analog-surround-41+input:analog-stereo, output:analog-surround-50+i=
nput:analog-stereo, output:analog-surround-51+input:analog-stereo, outp=
ut:iec958-stereo+input:analog-stereo
=09=09analog-input-microphone: Microphone (priority: 8700, latency offs=
et: 0 usec, not available)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "audio-input-microphone"
=09=09=09Part of profile(s): input:analog-stereo, output:analog-stereo+=
input:analog-stereo, output:analog-surround-40+input:analog-stereo, out=
put:analog-surround-41+input:analog-stereo, output:analog-surround-50+i=
nput:analog-stereo, output:analog-surround-51+input:analog-stereo, outp=
ut:iec958-stereo+input:analog-stereo
=09=09analog-input-linein: Line In (priority: 8100, latency offset: 0 u=
sec, not available)
=09=09=09Part of profile(s): input:analog-stereo, output:analog-stereo+=
input:analog-stereo, output:analog-surround-40+input:analog-stereo, out=
put:analog-surround-41+input:analog-stereo, output:analog-surround-50+i=
nput:analog-stereo, output:analog-surround-51+input:analog-stereo, outp=
ut:iec958-stereo+input:analog-stereo
=09=09analog-output: Analog Output (priority: 9900, latency offset: 0 u=
sec)
=09=09=09Part of profile(s): output:analog-stereo, output:analog-stereo=
+input:analog-stereo, output:analog-surround-40, output:analog-surround=
-40+input:analog-stereo, output:analog-surround-41, output:analog-surro=
und-41+input:analog-stereo, output:analog-surround-50, output:analog-su=
rround-50+input:analog-stereo, output:analog-surround-51, output:analog=
-surround-51+input:analog-stereo
=09=09analog-output-headphones: Headphones (priority: 9000, latency off=
set: 0 usec, not available)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "audio-headphones"
=09=09=09Part of profile(s): output:analog-stereo, output:analog-stereo=
+input:analog-stereo
=09=09iec958-stereo-output: Digital Output (S/PDIF) (priority: 0, laten=
cy offset: 0 usec)
=09=09=09Part of profile(s): output:iec958-stereo, output:iec958-stereo=
+input:analog-stereo

Card #12
=09Name: alsa_card.usb-GN_Netcom_GN_2000_USB-00-USB
=09Driver: module-alsa-card.c
=09Owner Module: 36
=09Properties:
=09=09alsa.card =3D "1"
=09=09alsa.card_name =3D "GN 2000 USB"
=09=09alsa.long_card_name =3D "GN Netcom GN 2000 USB at usb-0000:00:1d.=
0-1.1, full speed"
=09=09alsa.driver_name =3D "snd_usb_audio"
=09=09device.bus_path =3D "pci-0000:00:1d.0-usb-0:1.1:1.0"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.1/2=
-1.1:1.0/sound/card1"
=09=09udev.id =3D "usb-GN_Netcom_GN_2000_USB-00-USB"
=09=09device.bus =3D "usb"
=09=09device.vendor.id =3D "0b0e"
=09=09device.vendor.name =3D "GN Netcom"
=09=09device.product.id =3D "2000"
=09=09device.product.name =3D "GN 2000 USB"
=09=09device.serial =3D "GN_Netcom_GN_2000_USB"
=09=09device.string =3D "1"
=09=09device.description =3D "GN 2000 USB"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-usb"
=09Profiles:
=09=09output:analog-mono: Analog Mono Output (sinks: 1, sources: 0, pri=
ority. 100)
=09=09output:analog-stereo: Analog Stereo Output (sinks: 1, sources: 0,=
 priority. 6000)
=09=09output:iec958-stereo: Digital Stereo (IEC958) Output (sinks: 1, s=
ources: 0, priority. 5500)
=09=09off: Off (sinks: 0, sources: 0, priority. 0)
=09Active Profile: output:analog-stereo
=09Ports:
=09=09analog-output-speaker;output-bass-boost-on: Speakers / Bass Boost=
 (priority: 10000, latency offset: 0 usec)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "audio-speakers"
=09=09=09Part of profile(s): output:analog-mono, output:analog-stereo
=09=09analog-output-speaker;output-bass-boost-off: Speakers / No Bass B=
oost (priority: 10010, latency offset: 0 usec)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "audio-speakers"
=09=09=09Part of profile(s): output:analog-mono, output:analog-stereo
=09=09iec958-stereo-output: Digital Output (S/PDIF) (priority: 0, laten=
cy offset: 0 usec)
=09=09=09Part of profile(s): output:iec958-stereo

--nextPart1801830.RAKFpmdGti
Content-Disposition: attachment; filename="alsa-info-before-plug.txt"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="alsa-info-before-plug.txt"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.64
!!################################

!!Script ran on: Wed Oct 22 20:31:13 UTC 2014


!!Linux Distribution
!!------------------

Ubuntu 14.04.1 LTS \n \l DISTRIB_ID=Ubuntu DISTRIB_DESCRIPTION="Ubuntu 14.04.1 LTS" NAME="Ubuntu" ID=ubuntu ID_LIKE=debian PRETTY_NAME="Ubuntu 14.04.1 LTS" HOME_URL="http://www.ubuntu.com/" SUPPORT_URL="http://help.ubuntu.com/" BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"


!!DMI Information
!!---------------

Manufacturer:      System76, Inc.                          
Product Name:      Bonobo Professional
Product Version:   bonp5                    
Firmware Version:  4.6.4


!!Kernel Information
!!------------------

Kernel release:    3.13.0-37-generic
Operating System:  GNU/Linux
Architecture:      x86_64
Processor:         x86_64
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k3.13.0-37-generic
Library version:    1.0.27.2
Utilities version:  1.0.27.2


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
                      HDA Intel PCH at 0xf6500000 irq 52
 2 [NVidia         ]: HDA-Intel - HDA NVidia
                      HDA NVidia at 0xf6080000 irq 17


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 6 Series/C200 Series Chipset Family High Definition Audio Controller (rev 05)
01:00.1 Audio device: NVIDIA Corporation GF116 High Definition Audio Controller (rev a1)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:1b.0 0403: 8086:1c20 (rev 05)
	Subsystem: 1558:7100
--
01:00.1 0403: 10de:0bee (rev a1)
	Subsystem: 1558:7100


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

Codec: Realtek ALC892
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x10ec0892
Subsystem Id: 0x15587100
Revision Id: 0x100302
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
GPIO: io=2, o=0, i=0, unsolicited=1, wake=0
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Front Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="ALC892 Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x16 0x16]
  Converter: stream=8, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x03 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Speaker CLFE Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x16 0x16]
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x04 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Speaker Surround Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x16 0x16]
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x05 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Surround Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x16 0x16]
  Converter: stream=8, channel=0
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
  Converter: stream=8, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x5f0]: 32000 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Device: name="ALC892 Analog", type="Audio", device=0
  Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
  Amp-In vals:  [0x27 0x27]
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
  Control: name="Capture Volume", index=1, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=1, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Device: name="ALC892 Alt Analog", type="Audio", device=2
  Amp-In caps: ofs=0x10, nsteps=0x2e, stepsize=0x03, mute=1
  Amp-In vals:  [0x80 0x80]
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
  IEC Coding Type: 0x0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Internal Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Internal Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
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
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x05 0x0b
Node 0x10 [Audio Output] wcaps 0x611: Stereo Digital
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x5f0]: 32000 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x11 [Pin Complex] wcaps 0x400781: Stereo Digital
  Pincap 0x00000010: OUT
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
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
  Control: name="Speaker Front Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Speaker Front Phantom Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001003e: IN OUT HP EAPD Detect Trigger
  EAPD 0x2: EAPD
  Pin Default 0x99130120: [Fixed] Speaker at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0x2, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x0c
Node 0x15 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Speaker CLFE Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Speaker CLFE Phantom Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00000036: IN OUT Detect Trigger
  Pin Default 0x99130130: [Fixed] Speaker at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0x3, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x0d
Node 0x16 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Speaker Surround Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Speaker Surround Phantom Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00000036: IN OUT Detect Trigger
  Pin Default 0x99130140: [Fixed] Speaker at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0x4, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
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
  Control: name="Center Playback Switch", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="LFE Playback Switch", index=0, device=0
    ControlAmp: chs=2, dir=Out, idx=0, ofs=0
  Control: name="Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Mic Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00003736: IN OUT Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x01a11c60: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0x6, Sequence = 0x0
  Pin-ctls: 0x21: IN VREF_50
  Unsolicited: tag=03, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x19 [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="Internal Mic Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Internal Mic Phantom Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x03 0x03]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0000373e: IN OUT HP Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x99a30961: [Fixed] Mic at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0x6, Sequence = 0x1
    Misc = NO_PRESENCE
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1a [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="Surround Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line Boost Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Line Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x00003736: IN OUT Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x0181146f: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0x6, Sequence = 0xf
  Pin-ctls: 0x20: IN VREF_HIZ
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Headphone Jack", index=0, device=0
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0001373e: IN OUT HP EAPD Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  EAPD 0x2: EAPD
  Pin Default 0x01211010: [Jack] HP Out at Ext Rear
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=01, enabled=1
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
  Pin Default 0x598301f0: [N/A] Line In at Int ATAPI
    Conn = ATAPI, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x1e [Pin Complex] wcaps 0x400781: Stereo Digital
  Control: name="SPDIF Phantom Jack", index=0, device=0
  Pincap 0x00000010: OUT
  Pin Default 0x01451150: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Black
    DefAssociation = 0x5, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 1
     0x06
Node 0x1f [Pin Complex] wcaps 0x400681: Stereo Digital
  Pincap 0x00000020: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
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
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 12
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b 0x12
Node 0x23 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x00 0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x25 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Center Playback Volume", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="LFE Playback Volume", index=0, device=0
    ControlAmp: chs=2, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x16 0x16]
  Converter: stream=8, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x26 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x25 0x0b
Codec: Nvidia GPU 15 HDMI/DP
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10de0015
Subsystem Id: 0x10de0101
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x04 [Audio Output] wcaps 0x72b1: 8-Channels Digital Stripe CP
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Unsolicited: tag=00, enabled=0
Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
  Control: name="HDMI/DP,pcm=3 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Control: name="ELD", index=0, device=3
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=01, enabled=1
  Connection: 1
     0x04
Codec: Nvidia GPU 15 HDMI/DP
Address: 1
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10de0015
Subsystem Id: 0x10de0101
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x04 [Audio Output] wcaps 0x72b1: 8-Channels Digital Stripe CP
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Unsolicited: tag=00, enabled=0
Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
  Control: name="HDMI/DP,pcm=7 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=1, device=0
  Control: name="IEC958 Playback Pro Mask", index=1, device=0
  Control: name="IEC958 Playback Default", index=1, device=0
  Control: name="IEC958 Playback Switch", index=1, device=0
  Control: name="ELD", index=0, device=7
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=01, enabled=1
  Connection: 1
     0x04
Codec: Nvidia GPU 15 HDMI/DP
Address: 2
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10de0015
Subsystem Id: 0x10de0101
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x04 [Audio Output] wcaps 0x72b1: 8-Channels Digital Stripe CP
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Unsolicited: tag=00, enabled=0
Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
  Control: name="HDMI/DP,pcm=8 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=2, device=0
  Control: name="IEC958 Playback Pro Mask", index=2, device=0
  Control: name="IEC958 Playback Default", index=2, device=0
  Control: name="IEC958 Playback Switch", index=2, device=0
  Control: name="ELD", index=0, device=8
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=01, enabled=1
  Connection: 1
     0x04
Codec: Nvidia GPU 15 HDMI/DP
Address: 3
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10de0015
Subsystem Id: 0x10de0101
Revision Id: 0x100100
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x04 [Audio Output] wcaps 0x72b1: 8-Channels Digital Stripe CP
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  IEC Coding Type: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Unsolicited: tag=00, enabled=0
Node 0x05 [Pin Complex] wcaps 0x407381: 8-Channels Digital CP
  Control: name="HDMI/DP,pcm=9 Jack", index=0, device=0
  Control: name="IEC958 Playback Con Mask", index=3, device=0
  Control: name="IEC958 Playback Pro Mask", index=3, device=0
  Control: name="IEC958 Playback Default", index=3, device=0
  Control: name="IEC958 Playback Switch", index=3, device=0
  Control: name="ELD", index=0, device=9
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=01, enabled=1
  Connection: 1
     0x04
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116,  7 Oct 17 08:05 /dev/snd/controlC0
crw-rw----+ 1 root audio 116, 21 Oct 17 08:05 /dev/snd/controlC2
crw-rw----+ 1 root audio 116,  6 Oct 17 08:05 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116, 20 Oct 17 08:05 /dev/snd/hwC2D0
crw-rw----+ 1 root audio 116, 19 Oct 17 08:05 /dev/snd/hwC2D1
crw-rw----+ 1 root audio 116, 18 Oct 17 08:05 /dev/snd/hwC2D2
crw-rw----+ 1 root audio 116, 17 Oct 17 08:05 /dev/snd/hwC2D3
crw-rw----+ 1 root audio 116,  5 Oct 17 08:06 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116,  4 Oct 22 12:30 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116,  3 Oct 17 08:06 /dev/snd/pcmC0D1p
crw-rw----+ 1 root audio 116,  2 Oct 17 08:05 /dev/snd/pcmC0D2c
crw-rw----+ 1 root audio 116, 16 Oct 17 08:06 /dev/snd/pcmC2D3p
crw-rw----+ 1 root audio 116, 15 Oct 21 21:18 /dev/snd/pcmC2D7p
crw-rw----+ 1 root audio 116, 14 Oct 17 08:06 /dev/snd/pcmC2D8p
crw-rw----+ 1 root audio 116, 13 Oct 17 08:06 /dev/snd/pcmC2D9p
crw-rw----+ 1 root audio 116,  1 Oct 17 08:05 /dev/snd/seq
crw-rw----+ 1 root audio 116, 33 Oct 17 08:05 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  80 Oct 22 12:28 .
drwxr-xr-x 3 root root 400 Oct 22 12:28 ..
lrwxrwxrwx 1 root root  12 Oct 17 08:05 pci-0000:00:1b.0 -> ../controlC0
lrwxrwxrwx 1 root root  12 Oct 17 08:05 pci-0000:01:00.1 -> ../controlC2


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC892 Analog [ALC892 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 1: ALC892 Digital [ALC892 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: NVidia [HDA NVidia], device 7: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: NVidia [HDA NVidia], device 8: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 2: NVidia [HDA NVidia], device 9: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC892 Analog [ALC892 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 2: ALC892 Alt Analog [ALC892 Alt Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [PCH]

Card hw:0 'PCH'/'HDA Intel PCH at 0xf6500000 irq 52'
  Mixer name	: 'Realtek ALC892'
  Components	: 'HDA:10ec0892,15587100,00100302'
  Controls      : 51
  Simple ctrls  : 25
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 22 [34%] [-42.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'Speaker CLFE',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Speaker Front',0
  Capabilities: pswitch
  Playback channels: Front Left - Front Right
  Mono:
  Front Left: Playback [on]
  Front Right: Playback [on]
Simple mixer control 'Speaker Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 254 [100%] [-0.20dB]
  Front Right: Playback 254 [100%] [-0.20dB]
Simple mixer control 'Front',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB]
  Front Right: Playback 64 [100%] [0.00dB]
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Line Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]
Simple mixer control 'Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 0 [0%] [0.00dB]
  Front Right: 0 [0%] [0.00dB]
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958 Default PCM',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 46
  Front Left: Capture 39 [85%] [23.00dB] [on]
  Front Right: Capture 39 [85%] [23.00dB] [on]
Simple mixer control 'Capture',1
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 46
  Front Left: Capture 0 [0%] [-16.00dB] [off]
  Front Right: Capture 0 [0%] [-16.00dB] [off]
Simple mixer control 'Auto-Mute Mode',0
  Capabilities: enum
  Items: 'Disabled' 'Enabled'
  Item0: 'Enabled'
Simple mixer control 'Channel Mode',0
  Capabilities: enum
  Items: '2ch' '4ch' '6ch'
  Item0: '2ch'
Simple mixer control 'Digital',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 60 [50%] [0.00dB]
  Front Right: Capture 60 [50%] [0.00dB]
Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Internal Mic' 'Mic' 'Line'
  Item0: 'Internal Mic'
Simple mixer control 'Input Source',1
  Capabilities: cenum
  Items: 'Internal Mic' 'Mic' 'Line'
  Item0: 'Mic'
Simple mixer control 'Internal Mic',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-34.50dB] [off]
  Front Right: Playback 0 [0%] [-34.50dB] [off]
Simple mixer control 'Internal Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 3
  Front Left: 3 [100%] [30.00dB]
  Front Right: 3 [100%] [30.00dB]

!!-------Mixer controls for card 2 [NVidia]

Card hw:2 'NVidia'/'HDA NVidia at 0xf6080000 irq 17'
  Mixer name	: 'Nvidia GPU 15 HDMI/DP'
  Components	: 'HDA:10de0015,10de0101,00100100'
  Controls      : 28
  Simple ctrls  : 4
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',1
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',2
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',3
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]


!!Alsactl output
!!--------------

--startcollapse--
state.PCH {
	control.1 {
		iface MIXER
		name 'Channel Mode'
		value '2ch'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 '2ch'
			item.1 '4ch'
			item.2 '6ch'
		}
	}
	control.2 {
		iface MIXER
		name 'Front Playback Volume'
		value.0 64
		value.1 64
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
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
		name 'Surround Playback Volume'
		value.0 64
		value.1 64
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.5 {
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
	control.6 {
		iface MIXER
		name 'Center Playback Volume'
		value 64
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
		}
	}
	control.7 {
		iface MIXER
		name 'LFE Playback Volume'
		value 64
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
		}
	}
	control.8 {
		iface MIXER
		name 'Center Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.9 {
		iface MIXER
		name 'LFE Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.10 {
		iface MIXER
		name 'Speaker Front Playback Switch'
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
		name 'Speaker Surround Playback Volume'
		value.0 64
		value.1 64
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.12 {
		iface MIXER
		name 'Speaker Surround Playback Switch'
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
		name 'Speaker CLFE Playback Volume'
		value.0 64
		value.1 64
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}
	control.14 {
		iface MIXER
		name 'Speaker CLFE Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}
	control.15 {
		iface MIXER
		name 'Internal Mic Playback Volume'
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
		name 'Internal Mic Playback Switch'
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
		name 'Mic Playback Volume'
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
		name 'Mic Playback Switch'
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
	control.20 {
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
	control.21 {
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
	control.22 {
		iface MIXER
		name 'Input Source'
		value 'Internal Mic'
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Internal Mic'
			item.1 Mic
			item.2 Line
		}
	}
	control.23 {
		iface MIXER
		name 'Input Source'
		index 1
		value Mic
		comment {
			access 'read write'
			type ENUMERATED
			count 1
			item.0 'Internal Mic'
			item.1 Mic
			item.2 Line
		}
	}
	control.24 {
		iface MIXER
		name 'Capture Volume'
		value.0 39
		value.1 39
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 46'
			dbmin -1600
			dbmax 3000
			dbvalue.0 2300
			dbvalue.1 2300
		}
	}
	control.25 {
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
	control.26 {
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
	control.27 {
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
	control.28 {
		iface MIXER
		name 'Internal Mic Boost Volume'
		value.0 3
		value.1 3
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 3'
			dbmin 0
			dbmax 3000
			dbvalue.0 3000
			dbvalue.1 3000
		}
	}
	control.29 {
		iface MIXER
		name 'Mic Boost Volume'
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
	control.31 {
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.32 {
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access read
			type IEC958
			count 1
		}
	}
	control.33 {
		iface MIXER
		name 'IEC958 Playback Default'
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
		comment {
			access 'read write'
			type IEC958
			count 1
		}
	}
	control.34 {
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.35 {
		iface MIXER
		name 'IEC958 Default PCM Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.36 {
		iface MIXER
		name 'Master Playback Volume'
		value 22
		comment {
			access 'read write'
			type INTEGER
			count 1
			range '0 - 64'
			dbmin -6400
			dbmax 0
			dbvalue.0 -4200
		}
	}
	control.37 {
		iface MIXER
		name 'Master Playback Switch'
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.38 {
		iface CARD
		name 'Internal Mic Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.39 {
		iface CARD
		name 'Mic Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.40 {
		iface CARD
		name 'Line Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.41 {
		iface CARD
		name 'Headphone Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.42 {
		iface CARD
		name 'Speaker Front Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.43 {
		iface CARD
		name 'Speaker Surround Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.44 {
		iface CARD
		name 'Speaker CLFE Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.45 {
		iface CARD
		name 'SPDIF Phantom Jack'
		value true
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.46 {
		iface PCM
		name 'Playback Channel Map'
		value.0 0
		value.1 0
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		comment {
			access read
			type INTEGER
			count 6
			range '0 - 36'
		}
	}
	control.47 {
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
	control.48 {
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
	control.49 {
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
	control.50 {
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
	control.51 {
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
		value '0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
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
	control.8 {
		iface CARD
		name 'HDMI/DP,pcm=7 Jack'
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
		index 1
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
		index 1
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
		index 1
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
		index 1
		value true
		comment {
			access 'read write'
			type BOOLEAN
			count 1
		}
	}
	control.13 {
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
	control.14 {
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
	control.15 {
		iface CARD
		name 'HDMI/DP,pcm=8 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.16 {
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
	control.17 {
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
	control.18 {
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
	control.19 {
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
	control.20 {
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
	control.21 {
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
	control.22 {
		iface CARD
		name 'HDMI/DP,pcm=9 Jack'
		value false
		comment {
			access read
			type BOOLEAN
			count 1
		}
	}
	control.23 {
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
	control.24 {
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
	control.25 {
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
	control.26 {
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
	control.27 {
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
xfrm_user
xfrm4_tunnel
tunnel4
ipcomp
xfrm_ipcomp
esp4
ah4
af_key
xfrm_algo
ctr
ccm
ipt_MASQUERADE
iptable_nat
nf_nat_ipv4
nf_nat
nf_conntrack_ipv4
nf_defrag_ipv4
xt_conntrack
nf_conntrack
ipt_REJECT
xt_CHECKSUM
iptable_mangle
xt_tcpudp
cuse
bridge
stp
llc
ip6table_filter
ip6_tables
iptable_filter
ip_tables
ebtable_nat
ebtables
x_tables
rfcomm
bnep
bluetooth
binfmt_misc
snd_hda_codec_hdmi
joydev
hid_generic
hid_microsoft
snd_hda_codec_realtek
nvidia
uvcvideo
intel_rapl
snd_hda_intel
videobuf2_vmalloc
x86_pkg_temp_thermal
usbhid
videobuf2_memops
arc4
intel_powerclamp
videobuf2_core
snd_usb_audio
snd_hda_codec
videodev
kvm_intel
hid
snd_usbmidi_lib
kvm
snd_hwdep
iwldvm
mac80211
crct10dif_pclmul
dm_multipath
snd_pcm
scsi_dh
crc32_pclmul
ghash_clmulni_intel
snd_page_alloc
psmouse
snd_seq_midi
ir_lirc_codec
snd_seq_midi_event
lirc_dev
snd_rawmidi
serio_raw
ir_nec_decoder
ir_mce_kbd_decoder
ir_sanyo_decoder
ir_rc5_decoder
ir_jvc_decoder
ir_sony_decoder
ir_rc6_decoder
snd_seq
sdhci_pci
jmb38x_ms
snd_seq_device
iwlwifi
jme
memstick
snd_timer
sdhci
mii
wmi
firewire_ohci
rc_rc6_mce
snd
firewire_core
cfg80211
ite_cir
drm
mac_hid
rc_core
crc_itu_t
soundcore
mei_me
mei
lpc_ich
parport_pc
ppdev
coretemp
lp
parport
dm_crypt
raid10
raid456
async_raid6_recov
async_memcpy
async_pq
async_xor
xor
async_tx
raid6_pq
raid1
raid0
multipath
linear
aesni_intel
aes_x86_64
glue_helper
lrw
gf128mul
ablk_helper
cryptd
ahci
libahci
video


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x11 0x411111f0
0x12 0x411111f0
0x14 0x99130120
0x15 0x99130130
0x16 0x99130140
0x17 0x411111f0
0x18 0x01a11c60
0x19 0x99a30961
0x1a 0x0181146f
0x1b 0x01211010
0x1c 0x411111f0
0x1d 0x598301f0
0x1e 0x01451150
0x1f 0x411111f0

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D0/hints:

/sys/class/sound/hwC2D0/init_pin_configs:
0x05 0x18560010

/sys/class/sound/hwC2D0/driver_pin_configs:

/sys/class/sound/hwC2D0/user_pin_configs:

/sys/class/sound/hwC2D0/init_verbs:

/sys/class/sound/hwC2D0/hints:

/sys/class/sound/hwC2D1/init_pin_configs:
0x05 0x18560010

/sys/class/sound/hwC2D1/driver_pin_configs:

/sys/class/sound/hwC2D1/user_pin_configs:

/sys/class/sound/hwC2D1/init_verbs:

/sys/class/sound/hwC2D1/hints:

/sys/class/sound/hwC2D2/init_pin_configs:
0x05 0x18560010

/sys/class/sound/hwC2D2/driver_pin_configs:

/sys/class/sound/hwC2D2/user_pin_configs:

/sys/class/sound/hwC2D2/init_verbs:

/sys/class/sound/hwC2D2/hints:

/sys/class/sound/hwC2D3/init_pin_configs:
0x05 0x18560010

/sys/class/sound/hwC2D3/driver_pin_configs:

/sys/class/sound/hwC2D3/user_pin_configs:

/sys/class/sound/hwC2D3/init_verbs:

/sys/class/sound/hwC2D3/hints:


!!ALSA/HDA dmesg
!!--------------

[   16.197083] Linux video capture interface: v2.00
[   16.209808] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[   16.213267] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-rs'
--
[   16.223863] nvidia: module verification failed: signature and/or  required key missing - tainting kernel
[   16.227701] hda_codec: ALC892: SKU not ready 0x598301f0
[   16.228304] autoconfig: line_outs=3 (0x14/0x16/0x15/0x0/0x0) type:speaker
--
[   16.232893] usbhid: USB HID core driver
[   16.242564] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1b.0/sound/card0/input19
[   16.242700] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1b.0/sound/card0/input18
[   16.242835] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1b.0/sound/card0/input17
[   16.243449] hda_intel: Disabling MSI
[   16.243457] hda-intel 0000:01:00.1: Handle VGA-switcheroo audio client
[   16.243580] hda-intel 0000:01:00.1: Disabling 64bit DMA
[   16.247696] hda-intel 0000:01:00.1: Enable delay in RIRB handling
[   16.313272] type=1400 audit(1413561932.624:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/sbin/dhclient" pid=838 comm="apparmor_parser"
--
[   16.499835] usb_audio: [6] FU [Mic Playback Volume] ch = 1, val = -10496/0/16usb_audio: Warning! Unlikely big volume range (=704), cval->res is probably wrong.
[   16.506967] usb_audio: [1] FU [Speaker Playback Volume] ch = 2, val = -10496/768/16<6>[   16.529596] usbcore: registered new interface driver snd-usb-audio
[   16.625164] EXT4-fs (dm-6): mounted filesystem with ordered data mode. Opts: (null)
--
[   16.860484] EXT4-fs (dm-4): mounted filesystem with ordered data mode. Opts: (null)
[   17.048322] input: HDA NVidia HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card2/input28
[   17.048404] input: HDA NVidia HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card2/input27
[   17.048452] input: HDA NVidia HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card2/input26
[   17.048500] input: HDA NVidia HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:01.0/0000:01:00.1/sound/card2/input25
[   17.541125] psmouse serio2: synaptics: Touchpad model: 1, fw: 7.2, id: 0x1c0b1, caps: 0xd04733/0xa40000/0xa0000, board id: 3655, fw id: 582762
--
[54797.272995] iwlwifi 0000:04:00.0: RF_KILL bit toggled to enable radio.
[54797.273213] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[54797.296928] jme 0000:03:00.0 eth0: Link is down
--
[93830.833975] mei_me 0000:00:16.0: irq 50 for MSI/MSI-X
[93830.834093] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[93830.834141] jme 0000:03:00.0: System wakeup disabled by ACPI
--
[132875.700193] iwlwifi 0000:04:00.0: RF_KILL bit toggled to enable radio.
[132875.700215] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[132875.724153] jme 0000:03:00.0 eth0: Link is down
--
[135181.884658] jme 0000:03:00.0: System wakeup disabled by ACPI
[135181.884707] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[135181.884958] iwlwifi 0000:04:00.0: RF_KILL bit toggled to enable radio.
--
[190129.363970] iwlwifi 0000:04:00.0: RF_KILL bit toggled to enable radio.
[190129.364012] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[190129.387868] jme 0000:03:00.0 eth0: Link is down
--
[215539.635317] jme 0000:03:00.0: System wakeup disabled by ACPI
[215539.635509] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[215539.684205] iwlwifi 0000:04:00.0: RF_KILL bit toggled to enable radio.
--
[215674.127612] iwlwifi 0000:04:00.0: RF_KILL bit toggled to enable radio.
[215674.127702] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[215674.339253] usb 2-1.5: reset full-speed USB device number 4 using ehci-pci
--
[217181.497031] jme 0000:03:00.0: System wakeup disabled by ACPI
[217181.497225] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[217181.498289] iwlwifi 0000:04:00.0: RF_KILL bit toggled to enable radio.
--
[217294.942057] jme 0000:03:00.0: System wakeup disabled by ACPI
[217294.942177] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[217294.942596] iwlwifi 0000:04:00.0: RF_KILL bit toggled to enable radio.
--
[217295.497993] firewire_core 0000:05:00.0: rediscovered device fw0
[217296.010484] HDMI: invalid ELD data byte 0
[217296.326800] HDMI: invalid ELD data byte 0
[217296.643112] HDMI: invalid ELD data byte 0
[217296.995484] HDMI: invalid ELD data byte 0
[217297.311738] HDMI: invalid ELD data byte 0
[217297.628064] HDMI: invalid ELD data byte 0
[217297.768224] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
--
[217297.926429] Restarting tasks ... done.
[217297.948453] HDMI: invalid ELD data byte 0
[217298.112845] video LNXVIDEO:00: Restoring backlight state
[217298.264704] HDMI: invalid ELD data byte 0
[217298.581066] HDMI: invalid ELD data byte 0
[217299.226532] firewire_ohci 0000:05:00.0: no hotplug settings from platform
--
[218760.786062] iwlwifi 0000:04:00.0: RF_KILL bit toggled to enable radio.
[218760.786130] snd_hda_intel 0000:00:1b.0: irq 52 for MSI/MSI-X
[218760.809806] jme 0000:03:00.0 eth0: Link is down




--nextPart1801830.RAKFpmdGti
Content-Disposition: attachment; filename="pactl-list-before-plug.txt"
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; name="pactl-list-before-plug.txt"

Module #0
=09Name: module-device-restore
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Automatically restore the volume/mute sta=
te of devices"
=09=09module.version =3D "4.0"

Module #1
=09Name: module-stream-restore
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Automatically restore the volume/mute/dev=
ice state of streams"
=09=09module.version =3D "4.0"

Module #2
=09Name: module-card-restore
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Automatically restore profile of cards"
=09=09module.version =3D "4.0"

Module #3
=09Name: module-augment-properties
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Augment the property sets of streams with=
 additional static information"
=09=09module.version =3D "4.0"

Module #4
=09Name: module-switch-on-port-available
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09

Module #5
=09Name: module-alsa-card
=09Argument: device_id=3D"2" name=3D"pci-0000_01_00.1" card_name=3D"als=
a_card.pci-0000_01_00.1" namereg_fail=3Dfalse tsched=3Dyes fixed_latenc=
y_range=3Dno ignore_dB=3Dno deferred_volume=3Dyes use_ucm=3Dyes card_pr=
operties=3D"module-udev-detect.discovered=3D1"
=09Usage counter: 0
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "ALSA Card"
=09=09module.version =3D "4.0"

Module #6
=09Name: module-alsa-card
=09Argument: device_id=3D"0" name=3D"pci-0000_00_1b.0" card_name=3D"als=
a_card.pci-0000_00_1b.0" namereg_fail=3Dfalse tsched=3Dyes fixed_latenc=
y_range=3Dno ignore_dB=3Dno deferred_volume=3Dyes use_ucm=3Dyes card_pr=
operties=3D"module-udev-detect.discovered=3D1"
=09Usage counter: 0
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "ALSA Card"
=09=09module.version =3D "4.0"

Module #9
=09Name: module-udev-detect
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Detect available audio hardware and load =
matching drivers"
=09=09module.version =3D "4.0"

Module #10
=09Name: module-bluetooth-policy
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Fr=C3=A9d=C3=A9ric Dalleau"
=09=09module.description =3D "When a bluetooth sink or source is added,=
 load module-loopback"
=09=09module.version =3D "4.0"

Module #11
=09Name: module-bluetooth-discover
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Joao Paulo Rechi Vita"
=09=09module.description =3D "Detect available bluetooth audio devices =
and load bluetooth audio drivers"
=09=09module.version =3D "4.0"

Module #12
=09Name: module-native-protocol-unix
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Native protocol (UNIX sockets)"
=09=09module.version =3D "4.0"

Module #13
=09Name: module-default-device-restore
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Automatically restore the default sink an=
d source"
=09=09module.version =3D "4.0"

Module #14
=09Name: module-rescue-streams
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "When a sink/source is removed, try to mov=
e their streams to the default sink/source"
=09=09module.version =3D "4.0"

Module #15
=09Name: module-always-sink
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Colin Guthrie"
=09=09module.description =3D "Always keeps at least one sink loaded eve=
n if it's a null one"
=09=09module.version =3D "4.0"

Module #16
=09Name: module-intended-roles
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Automatically set device of streams based=
 of intended roles of devices"
=09=09module.version =3D "4.0"

Module #17
=09Name: module-suspend-on-idle
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "When a sink/source is idle for too long, =
suspend it"
=09=09module.version =3D "4.0"

Module #18
=09Name: module-systemd-login
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Create a client for each login session of=
 this user"
=09=09module.version =3D "4.0"

Module #19
=09Name: module-position-event-sounds
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Position event sounds between L and R dep=
ending on the position on screen of the widget triggering them."
=09=09module.version =3D "4.0"

Module #20
=09Name: module-filter-heuristics
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Colin Guthrie"
=09=09module.description =3D "Detect when various filters are desirable=
"
=09=09module.version =3D "4.0"

Module #21
=09Name: module-filter-apply
=09Argument:=20
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Colin Guthrie"
=09=09module.description =3D "Load filter sinks automatically when need=
ed"
=09=09module.version =3D "4.0"

Module #22
=09Name: module-device-manager
=09Argument: do_routing=3D1
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Colin Guthrie"
=09=09module.description =3D "Keep track of devices (and their descript=
ions) both past and present and prioritise by role"
=09=09module.version =3D "4.0"

Module #23
=09Name: module-x11-publish
=09Argument: display=3D:0
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "X11 credential publisher"
=09=09module.version =3D "4.0"

Module #24
=09Name: module-x11-bell
=09Argument: display=3D:0 sample=3Dbell.ogg
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "X11 bell interceptor"
=09=09module.version =3D "4.0"

Module #25
=09Name: module-x11-bell
=09Argument: display=3D:0 sample=3Dbell.ogg
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "X11 bell interceptor"
=09=09module.version =3D "4.0"

Module #26
=09Name: module-x11-cork-request
=09Argument: display=3D:0
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "Synthesize X11 media key events when cork=
/uncork is requested"
=09=09module.version =3D "4.0"

Module #27
=09Name: module-x11-xsmp
=09Argument: display=3D:0 session_manager=3Dlocal/hosanna:@/tmp/.ICE-un=
ix/3777,unix/hosanna:/tmp/.ICE-unix/3777
=09Usage counter: n/a
=09Properties:
=09=09module.author =3D "Lennart Poettering"
=09=09module.description =3D "X11 session management"
=09=09module.version =3D "4.0"

Sink #1
=09State: SUSPENDED
=09Name: alsa_output.pci-0000_00_1b.0.analog-stereo
=09Description: Built-in Audio Analog Stereo
=09Driver: module-alsa-card.c
=09Sample Specification: s16le 2ch 48000Hz
=09Channel Map: front-left,front-right
=09Owner Module: 6
=09Mute: no
=09Volume: 0:  20% 1:  20%
=09        0: -42.18 dB 1: -42.18 dB
=09        balance 0.00
=09Base Volume: 100%
=09             0.00 dB
=09Monitor Source: alsa_output.pci-0000_00_1b.0.analog-stereo.monitor
=09Latency: 0 usec, configured 0 usec
=09Flags: HARDWARE HW_MUTE_CTRL HW_VOLUME_CTRL DECIBEL_VOLUME LATENCY=20=

=09Properties:
=09=09alsa.resolution_bits =3D "16"
=09=09device.api =3D "alsa"
=09=09device.class =3D "sound"
=09=09alsa.class =3D "generic"
=09=09alsa.subclass =3D "generic-mix"
=09=09alsa.name =3D "ALC892 Analog"
=09=09alsa.id =3D "ALC892 Analog"
=09=09alsa.subdevice =3D "0"
=09=09alsa.subdevice_name =3D "subdevice #0"
=09=09alsa.device =3D "0"
=09=09alsa.card =3D "0"
=09=09alsa.card_name =3D "HDA Intel PCH"
=09=09alsa.long_card_name =3D "HDA Intel PCH at 0xf6500000 irq 52"
=09=09alsa.driver_name =3D "snd_hda_intel"
=09=09device.bus_path =3D "pci-0000:00:1b.0"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:1b.0/sound/card0"
=09=09device.bus =3D "pci"
=09=09device.vendor.id =3D "8086"
=09=09device.vendor.name =3D "Intel Corporation"
=09=09device.product.id =3D "1c20"
=09=09device.product.name =3D "6 Series/C200 Series Chipset Family High=
 Definition Audio Controller"
=09=09device.form_factor =3D "internal"
=09=09device.string =3D "front:0"
=09=09device.buffering.buffer_size =3D "65536"
=09=09device.buffering.fragment_size =3D "32768"
=09=09device.access_mode =3D "mmap+timer"
=09=09device.profile.name =3D "analog-stereo"
=09=09device.profile.description =3D "Analog Stereo"
=09=09device.description =3D "Built-in Audio Analog Stereo"
=09=09alsa.mixer_name =3D "Realtek ALC892"
=09=09alsa.components =3D "HDA:10ec0892,15587100,00100302"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-pci"
=09Ports:
=09=09analog-output: Analog Output (priority: 9900)
=09=09analog-output-headphones: Headphones (priority: 9000, not availab=
le)
=09Active Port: analog-output
=09Formats:
=09=09pcm

Source #1
=09State: SUSPENDED
=09Name: alsa_output.pci-0000_00_1b.0.analog-stereo.monitor
=09Description: Monitor of Built-in Audio Analog Stereo
=09Driver: module-alsa-card.c
=09Sample Specification: s16le 2ch 44100Hz
=09Channel Map: front-left,front-right
=09Owner Module: 6
=09Mute: yes
=09Volume: 0: 100% 1: 100%
=09        0: 0.00 dB 1: 0.00 dB
=09        balance 0.00
=09Base Volume: 100%
=09             0.00 dB
=09Monitor of Sink: alsa_output.pci-0000_00_1b.0.analog-stereo
=09Latency: 0 usec, configured 0 usec
=09Flags: DECIBEL_VOLUME LATENCY=20
=09Properties:
=09=09device.description =3D "Monitor of Built-in Audio Analog Stereo"
=09=09device.class =3D "monitor"
=09=09alsa.card =3D "0"
=09=09alsa.card_name =3D "HDA Intel PCH"
=09=09alsa.long_card_name =3D "HDA Intel PCH at 0xf6500000 irq 52"
=09=09alsa.driver_name =3D "snd_hda_intel"
=09=09device.bus_path =3D "pci-0000:00:1b.0"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:1b.0/sound/card0"
=09=09device.bus =3D "pci"
=09=09device.vendor.id =3D "8086"
=09=09device.vendor.name =3D "Intel Corporation"
=09=09device.product.id =3D "1c20"
=09=09device.product.name =3D "6 Series/C200 Series Chipset Family High=
 Definition Audio Controller"
=09=09device.form_factor =3D "internal"
=09=09device.string =3D "0"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-pci"
=09Formats:
=09=09pcm

Source #2
=09State: SUSPENDED
=09Name: alsa_input.pci-0000_00_1b.0.analog-stereo
=09Description: Built-in Audio Analog Stereo
=09Driver: module-alsa-card.c
=09Sample Specification: s16le 2ch 44100Hz
=09Channel Map: front-left,front-right
=09Owner Module: 6
=09Mute: no
=09Volume: 0:  76% 1:  76%
=09        0: -7.00 dB 1: -7.00 dB
=09        balance 0.00
=09Base Volume:  10%
=09             -60.00 dB
=09Monitor of Sink: n/a
=09Latency: 0 usec, configured 0 usec
=09Flags: HARDWARE HW_MUTE_CTRL HW_VOLUME_CTRL DECIBEL_VOLUME LATENCY=20=

=09Properties:
=09=09alsa.resolution_bits =3D "16"
=09=09device.api =3D "alsa"
=09=09device.class =3D "sound"
=09=09alsa.class =3D "generic"
=09=09alsa.subclass =3D "generic-mix"
=09=09alsa.name =3D "ALC892 Analog"
=09=09alsa.id =3D "ALC892 Analog"
=09=09alsa.subdevice =3D "0"
=09=09alsa.subdevice_name =3D "subdevice #0"
=09=09alsa.device =3D "0"
=09=09alsa.card =3D "0"
=09=09alsa.card_name =3D "HDA Intel PCH"
=09=09alsa.long_card_name =3D "HDA Intel PCH at 0xf6500000 irq 52"
=09=09alsa.driver_name =3D "snd_hda_intel"
=09=09device.bus_path =3D "pci-0000:00:1b.0"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:1b.0/sound/card0"
=09=09device.bus =3D "pci"
=09=09device.vendor.id =3D "8086"
=09=09device.vendor.name =3D "Intel Corporation"
=09=09device.product.id =3D "1c20"
=09=09device.product.name =3D "6 Series/C200 Series Chipset Family High=
 Definition Audio Controller"
=09=09device.form_factor =3D "internal"
=09=09device.string =3D "front:0"
=09=09device.buffering.buffer_size =3D "65536"
=09=09device.buffering.fragment_size =3D "32768"
=09=09device.access_mode =3D "mmap+timer"
=09=09device.profile.name =3D "analog-stereo"
=09=09device.profile.description =3D "Analog Stereo"
=09=09device.description =3D "Built-in Audio Analog Stereo"
=09=09alsa.mixer_name =3D "Realtek ALC892"
=09=09alsa.components =3D "HDA:10ec0892,15587100,00100302"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-pci"
=09Ports:
=09=09analog-input-microphone-internal: Internal Microphone (priority: =
8900)
=09=09analog-input-microphone: Microphone (priority: 8700, not availabl=
e)
=09=09analog-input-linein: Line In (priority: 8100, not available)
=09Active Port: analog-input-microphone-internal
=09Formats:
=09=09pcm

Client #0
=09Driver: module-systemd-login.c
=09Owner Module: 18
=09Properties:
=09=09application.name =3D "Login Session c4"
=09=09systemd-login.session =3D "c4"

Client #4
=09Driver: protocol-native.c
=09Owner Module: 12
=09Properties:
=09=09application.name =3D "KMix"
=09=09native-protocol.peer =3D "UNIX socket client"
=09=09native-protocol.version =3D "28"
=09=09application.process.id =3D "3983"
=09=09application.process.user =3D "jkugler"
=09=09application.process.host =3D "hosanna"
=09=09application.process.binary =3D "kmix"
=09=09application.language =3D "en_US.UTF-8"
=09=09window.x11.display =3D ":0"
=09=09application.process.machine_id =3D "f5f9985a3e8c192858318dd900000=
46a"
=09=09application.process.session_id =3D "c4"
=09=09application.icon_name =3D "kmix"

Client #6
=09Driver: protocol-native.c
=09Owner Module: 12
=09Properties:
=09=09application.name =3D "KNotify"
=09=09native-protocol.peer =3D "UNIX socket client"
=09=09native-protocol.version =3D "28"
=09=09application.icon_name =3D "knotify"
=09=09application.process.id =3D "4008"
=09=09application.process.user =3D "jkugler"
=09=09application.process.host =3D "hosanna"
=09=09application.process.binary =3D "knotify4"
=09=09application.language =3D "en_US.UTF-8"
=09=09window.x11.display =3D ":0"
=09=09application.process.machine_id =3D "f5f9985a3e8c192858318dd900000=
46a"
=09=09application.process.session_id =3D "c4"

Client #11
=09Driver: protocol-native.c
=09Owner Module: 12
=09Properties:
=09=09application.name =3D "KMix"
=09=09native-protocol.peer =3D "UNIX socket client"
=09=09native-protocol.version =3D "28"
=09=09application.process.id =3D "3741"
=09=09application.process.user =3D "jkugler"
=09=09application.process.host =3D "hosanna"
=09=09application.process.binary =3D "kdeinit4"
=09=09application.language =3D "en_US.UTF-8"
=09=09window.x11.display =3D ":0"
=09=09application.process.machine_id =3D "f5f9985a3e8c192858318dd900000=
46a"
=09=09application.process.session_id =3D "c4"

Client #18
=09Driver: module-x11-xsmp.c
=09Owner Module: 27
=09Properties:
=09=09application.name =3D "XSMP Session on KDE as 10d6ddd4610001413561=
97700000037770030"
=09=09xsmp.vendor =3D "KDE"
=09=09xsmp.client.id =3D "10d6ddd461000141356197700000037770030"

Client #19
=09Driver: protocol-native.c
=09Owner Module: 12
=09Properties:
=09=09application.name =3D "Skype"
=09=09native-protocol.peer =3D "UNIX socket client"
=09=09native-protocol.version =3D "28"
=09=09application.process.id =3D "4064"
=09=09application.process.user =3D "jkugler"
=09=09application.process.host =3D "hosanna"
=09=09application.process.binary =3D "skype"
=09=09application.language =3D "en_US.UTF-8"
=09=09window.x11.display =3D ":0"
=09=09application.process.machine_id =3D "f5f9985a3e8c192858318dd900000=
46a"
=09=09application.process.session_id =3D "c4"
=09=09application.icon_name =3D "skype.png"

Client #24
=09Driver: protocol-native.c
=09Owner Module: 12
=09Properties:
=09=09application.name =3D "Chrome input"
=09=09native-protocol.peer =3D "UNIX socket client"
=09=09native-protocol.version =3D "28"
=09=09application.process.id =3D "4508"
=09=09application.process.user =3D "jkugler"
=09=09application.process.host =3D "hosanna"
=09=09application.process.binary =3D "chrome"
=09=09application.language =3D "en_US.UTF-8"
=09=09window.x11.display =3D ":0"
=09=09application.process.machine_id =3D "f5f9985a3e8c192858318dd900000=
46a"
=09=09application.process.session_id =3D "c4"

Client #408
=09Driver: protocol-native.c
=09Owner Module: 12
=09Properties:
=09=09application.name =3D "AudioStream"
=09=09native-protocol.peer =3D "UNIX socket client"
=09=09native-protocol.version =3D "28"
=09=09application.process.id =3D "6142"
=09=09application.process.user =3D "jkugler"
=09=09application.process.host =3D "hosanna"
=09=09application.process.binary =3D "firefox"
=09=09application.language =3D "en_US.UTF-8"
=09=09window.x11.display =3D ":0"
=09=09application.process.machine_id =3D "f5f9985a3e8c192858318dd900000=
46a"
=09=09application.process.session_id =3D "c4"
=09=09application.icon_name =3D "firefox"

Client #577
=09Driver: protocol-native.c
=09Owner Module: 12
=09Properties:
=09=09application.name =3D "pactl"
=09=09native-protocol.peer =3D "UNIX socket client"
=09=09native-protocol.version =3D "28"
=09=09application.process.id =3D "20474"
=09=09application.process.user =3D "jkugler"
=09=09application.process.host =3D "hosanna"
=09=09application.process.binary =3D "pactl"
=09=09application.language =3D "en_US.UTF-8"
=09=09window.x11.display =3D ":0"
=09=09application.process.machine_id =3D "f5f9985a3e8c192858318dd900000=
46a"
=09=09application.process.session_id =3D "c4"

Card #0
=09Name: alsa_card.pci-0000_01_00.1
=09Driver: module-alsa-card.c
=09Owner Module: 5
=09Properties:
=09=09alsa.card =3D "2"
=09=09alsa.card_name =3D "HDA NVidia"
=09=09alsa.long_card_name =3D "HDA NVidia at 0xf6080000 irq 17"
=09=09alsa.driver_name =3D "snd_hda_intel"
=09=09device.bus_path =3D "pci-0000:01:00.1"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:01.0/0000:01:00.1/sou=
nd/card2"
=09=09device.bus =3D "pci"
=09=09device.vendor.id =3D "10de"
=09=09device.vendor.name =3D "NVIDIA Corporation"
=09=09device.product.id =3D "0bee"
=09=09device.product.name =3D "GF116 High Definition Audio Controller"
=09=09device.string =3D "2"
=09=09device.description =3D "GF116 High Definition Audio Controller"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-pci"
=09Profiles:
=09=09output:hdmi-stereo: Digital Stereo (HDMI) Output (sinks: 1, sourc=
es: 0, priority. 5400)
=09=09output:hdmi-surround: Digital Surround 5.1 (HDMI) Output (sinks: =
1, sources: 0, priority. 300)
=09=09output:hdmi-stereo-extra1: Digital Stereo (HDMI) Output (sinks: 1=
, sources: 0, priority. 5200)
=09=09output:hdmi-surround-extra1: Digital Surround 5.1 (HDMI) Output (=
sinks: 1, sources: 0, priority. 100)
=09=09output:hdmi-stereo-extra2: Digital Stereo (HDMI) Output (sinks: 1=
, sources: 0, priority. 5200)
=09=09output:hdmi-surround-extra2: Digital Surround 5.1 (HDMI) Output (=
sinks: 1, sources: 0, priority. 100)
=09=09output:hdmi-stereo-extra3: Digital Stereo (HDMI) Output (sinks: 1=
, sources: 0, priority. 5200)
=09=09output:hdmi-surround-extra3: Digital Surround 5.1 (HDMI) Output (=
sinks: 1, sources: 0, priority. 100)
=09=09off: Off (sinks: 0, sources: 0, priority. 0)
=09Active Profile: output:hdmi-stereo-extra1
=09Ports:
=09=09hdmi-output-0: HDMI / DisplayPort (priority: 5900, latency offset=
: 0 usec, not available)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "video-display"
=09=09=09Part of profile(s): output:hdmi-stereo, output:hdmi-surround
=09=09hdmi-output-1: HDMI / DisplayPort 2 (priority: 5800, latency offs=
et: 0 usec, not available)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "video-display"
=09=09=09Part of profile(s): output:hdmi-stereo-extra1, output:hdmi-sur=
round-extra1
=09=09hdmi-output-2: HDMI / DisplayPort 3 (priority: 5700, latency offs=
et: 0 usec, not available)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "video-display"
=09=09=09Part of profile(s): output:hdmi-stereo-extra2, output:hdmi-sur=
round-extra2
=09=09hdmi-output-3: HDMI / DisplayPort 4 (priority: 5600, latency offs=
et: 0 usec, not available)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "video-display"
=09=09=09Part of profile(s): output:hdmi-stereo-extra3, output:hdmi-sur=
round-extra3

Card #1
=09Name: alsa_card.pci-0000_00_1b.0
=09Driver: module-alsa-card.c
=09Owner Module: 6
=09Properties:
=09=09alsa.card =3D "0"
=09=09alsa.card_name =3D "HDA Intel PCH"
=09=09alsa.long_card_name =3D "HDA Intel PCH at 0xf6500000 irq 52"
=09=09alsa.driver_name =3D "snd_hda_intel"
=09=09device.bus_path =3D "pci-0000:00:1b.0"
=09=09sysfs.path =3D "/devices/pci0000:00/0000:00:1b.0/sound/card0"
=09=09device.bus =3D "pci"
=09=09device.vendor.id =3D "8086"
=09=09device.vendor.name =3D "Intel Corporation"
=09=09device.product.id =3D "1c20"
=09=09device.product.name =3D "6 Series/C200 Series Chipset Family High=
 Definition Audio Controller"
=09=09device.form_factor =3D "internal"
=09=09device.string =3D "0"
=09=09device.description =3D "Built-in Audio"
=09=09module-udev-detect.discovered =3D "1"
=09=09device.icon_name =3D "audio-card-pci"
=09Profiles:
=09=09input:analog-stereo: Analog Stereo Input (sinks: 0, sources: 1, p=
riority. 60)
=09=09output:analog-stereo: Analog Stereo Output (sinks: 1, sources: 0,=
 priority. 6000)
=09=09output:analog-stereo+input:analog-stereo: Analog Stereo Duplex (s=
inks: 1, sources: 1, priority. 6060)
=09=09output:analog-surround-40: Analog Surround 4.0 Output (sinks: 1, =
sources: 0, priority. 700)
=09=09output:analog-surround-40+input:analog-stereo: Analog Surround 4.=
0 Output + Analog Stereo Input (sinks: 1, sources: 1, priority. 760)
=09=09output:analog-surround-41: Analog Surround 4.1 Output (sinks: 1, =
sources: 0, priority. 800)
=09=09output:analog-surround-41+input:analog-stereo: Analog Surround 4.=
1 Output + Analog Stereo Input (sinks: 1, sources: 1, priority. 860)
=09=09output:analog-surround-50: Analog Surround 5.0 Output (sinks: 1, =
sources: 0, priority. 700)
=09=09output:analog-surround-50+input:analog-stereo: Analog Surround 5.=
0 Output + Analog Stereo Input (sinks: 1, sources: 1, priority. 760)
=09=09output:analog-surround-51: Analog Surround 5.1 Output (sinks: 1, =
sources: 0, priority. 800)
=09=09output:analog-surround-51+input:analog-stereo: Analog Surround 5.=
1 Output + Analog Stereo Input (sinks: 1, sources: 1, priority. 860)
=09=09output:iec958-stereo: Digital Stereo (IEC958) Output (sinks: 1, s=
ources: 0, priority. 5500)
=09=09output:iec958-stereo+input:analog-stereo: Digital Stereo (IEC958)=
 Output + Analog Stereo Input (sinks: 1, sources: 1, priority. 5560)
=09=09off: Off (sinks: 0, sources: 0, priority. 0)
=09Active Profile: output:analog-stereo+input:analog-stereo
=09Ports:
=09=09analog-input-microphone-internal: Internal Microphone (priority: =
8900, latency offset: 0 usec)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "audio-input-microphone"
=09=09=09Part of profile(s): input:analog-stereo, output:analog-stereo+=
input:analog-stereo, output:analog-surround-40+input:analog-stereo, out=
put:analog-surround-41+input:analog-stereo, output:analog-surround-50+i=
nput:analog-stereo, output:analog-surround-51+input:analog-stereo, outp=
ut:iec958-stereo+input:analog-stereo
=09=09analog-input-microphone: Microphone (priority: 8700, latency offs=
et: 0 usec, not available)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "audio-input-microphone"
=09=09=09Part of profile(s): input:analog-stereo, output:analog-stereo+=
input:analog-stereo, output:analog-surround-40+input:analog-stereo, out=
put:analog-surround-41+input:analog-stereo, output:analog-surround-50+i=
nput:analog-stereo, output:analog-surround-51+input:analog-stereo, outp=
ut:iec958-stereo+input:analog-stereo
=09=09analog-input-linein: Line In (priority: 8100, latency offset: 0 u=
sec, not available)
=09=09=09Part of profile(s): input:analog-stereo, output:analog-stereo+=
input:analog-stereo, output:analog-surround-40+input:analog-stereo, out=
put:analog-surround-41+input:analog-stereo, output:analog-surround-50+i=
nput:analog-stereo, output:analog-surround-51+input:analog-stereo, outp=
ut:iec958-stereo+input:analog-stereo
=09=09analog-output: Analog Output (priority: 9900, latency offset: 0 u=
sec)
=09=09=09Part of profile(s): output:analog-stereo, output:analog-stereo=
+input:analog-stereo, output:analog-surround-40, output:analog-surround=
-40+input:analog-stereo, output:analog-surround-41, output:analog-surro=
und-41+input:analog-stereo, output:analog-surround-50, output:analog-su=
rround-50+input:analog-stereo, output:analog-surround-51, output:analog=
-surround-51+input:analog-stereo
=09=09analog-output-headphones: Headphones (priority: 9000, latency off=
set: 0 usec, not available)
=09=09=09Properties:
=09=09=09=09device.icon_name =3D "audio-headphones"
=09=09=09Part of profile(s): output:analog-stereo, output:analog-stereo=
+input:analog-stereo
=09=09iec958-stereo-output: Digital Output (S/PDIF) (priority: 0, laten=
cy offset: 0 usec)
=09=09=09Part of profile(s): output:iec958-stereo, output:iec958-stereo=
+input:analog-stereo

--nextPart1801830.RAKFpmdGti
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--nextPart1801830.RAKFpmdGti--
