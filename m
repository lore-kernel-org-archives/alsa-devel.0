From: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Subject: extra interrupt on plug insertion undoes mux selection
Date: Fri, 11 Jun 2010 18:36:16 -0400
Message-ID: <4C12BA60.5080202@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060501020205030009070300"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D6E01039D3
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Jun 2010 00:36:19 +0200 (CEST)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1ONCpm-0005Tv-FC
	for <alsa-devel@alsa-project.org>; Fri, 11 Jun 2010 23:36:18 +0100
Received: from [91.189.91.3] (helo=[10.0.1.106])
	by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <peter.petrakis@canonical.com>) id 1ONCpm-0005on-3p
	for alsa-devel@alsa-project.org; Fri, 11 Jun 2010 23:36:18 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060501020205030009070300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

Trying my hand at snd quirking, I'm working a Dell Latitude E4310. Here's
what I'm seeing. There's a headset jack (HP/MIC combo) on the LHS, when I
insert a headset I see the following in the logs.

Note: port 0xA is the mic jack, 0xB is hp jack, and 0x11 in internal mic.

Jun 11 18:17:45 ubuntu-laptop kernel: [  193.978394] XXX stac92xx_unsol_event: codec subsystem id 10280410
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361330] XXX stac92xx_unsol_event: event - 6 nid - 0a.
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361335] XXX stac92xx_unsol_event: event - 6 MIC
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361337] XXX stac92xx_mic_detect: ENTER
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361340] XXX get_pin_presence:4422 ENTER, NID 0a
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361434] XXX get_pin_presence:4429 EXIT 1, got pin sense
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361439] XXX stac92xx_mic_detect: HERE 4662
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361441] XXX stac92xx_mic_detect: HERE 4676
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361444] XXX stac92xx_mic_detect:4678 mux_nid:0017 index:6
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361449] XXX stac92xx_mic_detect: EXIT
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361451] XXX stac92xx_unsol_event: genevent - 6
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361532] XXX get_pin_presence:4422 ENTER, NID 0a
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361620] XXX get_pin_presence:4429 EXIT 1, got pin sense
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361628] XXX stac92xx_unsol_event: codec subsystem id 10280410
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361631] XXX stac92xx_unsol_event: event - 4 nid - 0b.
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361634] XXX stac92xx_unsol_event: event - 4 HP or LO
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361636] XXX stac92xx_hp_detect: ENTER
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361638] XXX get_pin_presence:4422 ENTER, NID 0b
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361717] XXX get_pin_presence:4429 EXIT 1, got pin sense
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361720] XXX stac92xx_hp_detect:4522  probe_pin:0 hp_pin:000b
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361807] XXX stac92xx_hp_detect: pinctl c0
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361810] XXX stac92xx_hp_detect: HERE 4534
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361812] XXX stac92xx_hp_detect: HERE 4537
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361906] XXX stac92xx_hp_detect: HERE 4569
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361996] XXX stac92xx_hp_detect: EXIT
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.361998] XXX stac92xx_unsol_event: genevent - 4
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.362067] XXX get_pin_presence:4422 ENTER, NID 0b
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.362163] XXX get_pin_presence:4429 EXIT 1, got pin sense
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.362168] XXX stac92xx_unsol_event: codec subsystem id 10280410
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.735203] XXX stac92xx_unsol_event: event - 6 nid - 0a.
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.735206] XXX stac92xx_unsol_event: event - 6 MIC
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.735209] XXX stac92xx_mic_detect: ENTER
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.735212] XXX get_pin_presence:4422 ENTER, NID 0a
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.735311] XXX get_pin_presence:4433 EXIT 0, no pin sense
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.735315] XXX stac92xx_mic_detect: HERE 4666
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.735318] XXX stac92xx_mic_detect: HERE 4676
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.735320] XXX stac92xx_mic_detect:4678 mux_nid:0017 index:4
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.735325] XXX stac92xx_mic_detect: EXIT
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.735327] XXX stac92xx_unsol_event: genevent - 6
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.735410] XXX get_pin_presence:4422 ENTER, NID 0a
Jun 11 18:17:45 ubuntu-laptop kernel: [  201.735497] XXX get_pin_presence:4433 EXIT 0, no pin sense

I've tested against kernels 2.6.32 and 2.6.35rc2 with the same results. The mux is indeed
back where it started after the plug is fully inserted.

Node 0x17 [Audio Selector] wcaps 0x300d0d: Stereo Amp-Out R/L
   Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
   Amp-Out vals:  [0x0f 0x0f]
   Power: setting=D0, actual=D0
   Connection: 7
      0x0c 0x0e 0x0f 0x1b 0x11* 0x12 0x0a

and I can push it around with hda-verb to get the desired result... The question is
why is it doing this? To make things weirder, I can get input from the external mic
even if it isn't selected. This is my first attempt at making codecs "do the right thing"
so I could very well be missing something obvious. What else am I missing here? Thanks.

Peter







--------------060501020205030009070300
Content-Type: text/x-log;
 name="dell-e4310-2nd-int_alsa-info.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dell-e4310-2nd-int_alsa-info.log"

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.59
!!################################

!!Script ran on: Fri Jun 11 22:18:20 UTC 2010


!!Linux Distribution
!!------------------

Ubuntu 10.04 LTS \n \l DISTRIB_ID=Ubuntu DISTRIB_DESCRIPTION="Ubuntu 10.04 LTS"


!!DMI Information
!!---------------

Manufacturer:      Dell Inc.
Product Name:      Latitude E4310


!!Kernel Information
!!------------------

Kernel release:    2.6.32-22-generic
Operating System:  GNU/Linux
Architecture:      i686
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.21
Library version:    1.0.22
Utilities version:  1.0.22


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
      Installed - Yes (/usr/bin/pulseaudio)
      Running - Yes

ESound Daemon:
      Installed - Yes (/usr/bin/esd)
      Running - No


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0x55460000 irq 22


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation Device 3b57 (rev 05)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:3b57 (rev 05)
	Subsystem: 1028:0410


!!Modprobe options (Sound related)
!!--------------------------------

snd-atiixp-modem: index=-2
snd-intel8x0m: index=-2
snd-via82xx-modem: index=-2
snd-usb-audio: index=-2
snd-usb-us122l: index=-2
snd-usb-usx2y: index=-2
snd-usb-caiaq: index=-2
snd-cmipci: mpu_port=0x330 fm_port=0x388
snd-pcsp: index=-2
snd-hda-intel: patch=audio-test.fw


!!Loaded sound module options
!!--------------------------

!!Module: snd_hda_intel
	bdl_pos_adj : 1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	enable : Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
	enable_msi : 0
	id : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
	index : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	model : <NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
	patch : audio-test.fw,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>,<NULL>
	position_fix : 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	power_save : 0
	power_save_controller : Y
	probe_mask : -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
	probe_only : N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N
	single_cmd : N


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: IDT 92HD81B1X5
Address: 0
Function Id: 0x1
Vendor Id: 0x111d7605
Subsystem Id: 0x10280410
Revision Id: 0x100104
No Modem Function Group found
Default PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
Default Amp-Out caps: ofs=0x7f, nsteps=0x7f, stepsize=0x02, mute=1
GPIO: io=3, o=0, i=0, unsolicited=1, wake=1
  IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
  IO[2]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Power-Map: 0x00
Node 0x0a [Pin Complex] wcaps 0x400583: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x02 0x02]
  Pincap 0x0001173c: IN OUT HP EAPD Detect
    Vref caps: HIZ 50 GRD 80
  EAPD 0x2: EAPD
  Pin Default 0x03a11020: [Jack] Mic at Ext Left
    Conn = 1/8, Color = Black
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x24: IN VREF_80
  Unsolicited: tag=02, enabled=1
  Power: setting=D0, actual=D0
  Connection: 3
     0x13* 0x14 0x1c
Node 0x0b [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x0001001c: OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x0321101f: [Jack] HP Out at Ext Left
    Conn = 1/8, Color = Black
    DefAssociation = 0x1, Sequence = 0xf
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=01, enabled=1
  Power: setting=D0, actual=D0
  Connection: 3
     0x13 0x14* 0x1c
Node 0x0c [Pin Complex] wcaps 0x400583: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00011734: IN OUT EAPD Detect
    Vref caps: HIZ 50 GRD 80
  EAPD 0x2: EAPD
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00: VREF_HIZ
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Connection: 3
     0x13* 0x14 0x1c
Node 0x0d [Pin Complex] wcaps 0x400501: Stereo
  Pincap 0x00010050: OUT EAPD Balanced
  EAPD 0x2: EAPD
  Pin Default 0x90170110: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x00:
  Power: setting=D0, actual=D0
  Connection: 3
     0x13* 0x14 0x1c
Node 0x0e [Pin Complex] wcaps 0x400583: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00010034: IN OUT EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x40f000f0: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Connection: 3
     0x13 0x14 0x1c*
Node 0x0f [Pin Complex] wcaps 0x400583: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00010034: IN OUT EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x40f000f0: [N/A] Other at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Connection: 3
     0x13* 0x14 0x1c
Node 0x10 [Pin Complex] wcaps 0x400500: Mono
  Pincap 0x00000010: OUT
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Power: setting=D0, actual=D0
  Connection: 1
     0x1a
Node 0x11 [Pin Complex] wcaps 0x400483: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Pincap 0x00000024: IN Detect
  Pin Default 0x90a601a0: [Fixed] Mic at Int N/A
    Conn = Digital, Color = Unknown
    DefAssociation = 0xa, Sequence = 0x0
    Misc = NO_PRESENCE
  Pin-ctls: 0x20: IN
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
Node 0x12 [Vendor Defined Widget] wcaps 0xf00503: Stereo Amp-In
  Amp-In caps: N/A
  Amp-In vals:  [0x00 0x00]
  Power: setting=D0, actual=D0
  Connection: 1
     0x20
Node 0x13 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x56 0x56]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x14 [Audio Output] wcaps 0xd0c05: Stereo Amp-Out R/L
  Amp-Out caps: N/A
  Amp-Out vals:  [0x56 0x56]
  Converter: stream=0, channel=0
  Power: setting=D0, actual=D0
  Delay: 13 samples
Node 0x15 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Delay: 13 samples
  Connection: 1
     0x17
  Processing caps: benign=0, ncoeff=0
Node 0x16 [Audio Input] wcaps 0x1d0541: Stereo
  Converter: stream=0, channel=0
  SDI-Select: 0
  Power: setting=D0, actual=D0
  Delay: 13 samples
  Connection: 1
     0x18
  Processing caps: benign=0, ncoeff=0
Node 0x17 [Audio Selector] wcaps 0x300d0d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x0f 0x0f]
  Power: setting=D0, actual=D0
  Connection: 7
     0x0c 0x0e 0x0f 0x1b 0x11* 0x12 0x0a
Node 0x18 [Audio Selector] wcaps 0x300d0d: Stereo Amp-Out R/L
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x80 0x80]
  Power: setting=D0, actual=D0
  Connection: 7
     0x0c* 0x0e 0x0f 0x1b 0x11 0x12 0x0a
Node 0x19 [Audio Selector] wcaps 0x300501: Stereo
  Power: setting=D0, actual=D0
  Connection: 3
     0x13* 0x14 0x1c
Node 0x1a [Audio Mixer] wcaps 0x200500: Mono
  Power: setting=D0, actual=D0
  Connection: 1
     0x19
Node 0x1b [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97] [0x97 0x97]
  Power: setting=D0, actual=D0
  Connection: 6
     0x0c 0x0e 0x0f 0x13 0x14 0x0a
Node 0x1c [Audio Selector] wcaps 0x30050d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x9f 0x9f]
  Power: setting=D0, actual=D0
  Connection: 1
     0x1b
Node 0x1d [Audio Output] wcaps 0x4061d: Stereo Digital Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Power: setting=D0, actual=D0
  Delay: 4 samples
Node 0x1e [Audio Output] wcaps 0x4061d: Stereo Digital Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Converter: stream=0, channel=0
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Power: setting=D0, actual=D0
  Delay: 4 samples
Node 0x1f [Pin Complex] wcaps 0x400781: Stereo Digital
  Pincap 0x00000014: OUT Detect
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Connection: 1
     0x1d
Node 0x20 [Pin Complex] wcaps 0x400781: Stereo Digital
  Pincap 0x00000034: IN OUT Detect
  Pin Default 0x400000f0: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
    DefAssociation = 0xf, Sequence = 0x0
  Pin-ctls: 0x00:
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Connection: 1
     0x1e
Node 0x21 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=1
  Amp-Out vals:  [0x00]
Node 0x22 [Vendor Defined Widget] wcaps 0xf00000: Mono
Codec: Intel G45 DEVIBX
Address: 3
Function Id: 0x1
Vendor Id: 0x80862804
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
  Digital:
  Digital category: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power: setting=D0, actual=D0
Node 0x03 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power: setting=D0, actual=D0
Node 0x04 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x09000094: OUT Detect HDMI
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=08, enabled=1
  Power: setting=D0, actual=D0
  Connection: 2
     0x02* 0x03
Node 0x05 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x80]
  Pincap 0x09000094: OUT Detect HDMI
  Pin Default 0x18560020: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x2, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Connection: 2
     0x02* 0x03
Node 0x06 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x80]
  Pincap 0x09000094: OUT Detect HDMI
  Pin Default 0x58560030: [N/A] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x3, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=00, enabled=0
  Power: setting=D0, actual=D0
  Connection: 2
     0x02* 0x03
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw----+ 1 root audio 116, 9 Jun 11 18:14 /dev/snd/controlC0
crw-rw----+ 1 root audio 116, 8 Jun 11 18:14 /dev/snd/hwC0D0
crw-rw----+ 1 root audio 116, 7 Jun 11 18:14 /dev/snd/hwC0D3
crw-rw----+ 1 root audio 116, 6 Jun 11 18:14 /dev/snd/pcmC0D0c
crw-rw----+ 1 root audio 116, 5 Jun 11 18:14 /dev/snd/pcmC0D0p
crw-rw----+ 1 root audio 116, 4 Jun 11 18:14 /dev/snd/pcmC0D3p
crw-rw----+ 1 root audio 116, 3 Jun 11 18:14 /dev/snd/seq
crw-rw----+ 1 root audio 116, 2 Jun 11 18:14 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Jun 11 18:14 .
drwxr-xr-x 3 root root 220 Jun 11 18:14 ..
lrwxrwxrwx 1 root root  12 Jun 11 18:14 pci-0000:00:1b.0 -> ../controlC0


!!Aplay/Arecord output
!!------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 3: INTEL HDMI [INTEL HDMI]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: STAC92xx Analog [STAC92xx Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0x55460000 irq 22'
  Mixer name	: 'Intel G45 DEVIBX'
  Components	: 'HDA:111d7605,10280410,00100104 HDA:80862804,80860101,00100000'
  Controls      : 18
  Simple ctrls  : 10
Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 64
  Mono: Playback 23 [36%] [-30.75dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 64 [100%] [0.00dB] [on]
  Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume penum
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 253 [99%] [0.40dB]
  Front Right: Playback 253 [99%] [0.40dB]
Simple mixer control 'Front Mic',0
  Capabilities: cvolume penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 3
  Front Left: Capture 0 [0%] [0.00dB]
  Front Right: Capture 0 [0%] [0.00dB]
Simple mixer control 'Mic',0
  Capabilities: cvolume penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 3
  Front Left: Capture 2 [67%] [20.00dB]
  Front Right: Capture 2 [67%] [20.00dB]
Simple mixer control 'Mic Jack Mode',0
  Capabilities: enum
  Items: 'Mic In' 'Line In'
  Item0: 'Mic In'
Simple mixer control 'IEC958',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch penum
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 15
  Front Left: Capture 15 [100%] [22.50dB] [on]
  Front Right: Capture 15 [100%] [22.50dB] [on]
Simple mixer control 'PC Beep',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
  Playback channels: Mono
  Limits: Playback 0 - 3
  Mono: Playback 0 [0%] [-18.00dB] [off]


!!Alsactl output
!!-------------

--startcollapse--
state.Intel {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Speaker Playback Volume'
		value.0 64
		value.1 64
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Speaker Playback Switch'
		value.0 true
		value.1 true
	}
	control.3 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'Mic In'
		comment.item.1 'Line In'
		iface MIXER
		name 'Mic Jack Mode'
		value 'Mic In'
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PC Beep Playback Switch'
		value false
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 3'
		comment.dbmin -1800
		comment.dbmax 0
		iface MIXER
		name 'PC Beep Playback Volume'
		value 0
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 64
		value.1 64
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Headphone Playback Switch'
		value.0 true
		value.1 true
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
		value.0 15
		value.1 15
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3000
		iface MIXER
		name 'Mic Capture Volume'
		value.0 2
		value.1 2
	}
	control.11 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 3'
		comment.dbmin 0
		comment.dbmax 3000
		iface MIXER
		name 'Front Mic Capture Volume'
		value.0 0
		value.1 0
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 64'
		comment.dbmin -4800
		comment.dbmax 0
		iface MIXER
		name 'Master Playback Volume'
		value 23
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
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
		comment.access 'read write user'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 255'
		comment.tlv '0000000100000008ffffec1400000014'
		comment.dbmin -5100
		comment.dbmax 0
		iface MIXER
		name 'PCM Playback Volume'
		value.0 253
		value.1 253
	}
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
binfmt_misc
dm_crypt
snd_hda_codec_intelhdmi
snd_hda_codec_idt
snd_hda_intel
snd_hda_codec
snd_hwdep
snd_pcm_oss
snd_mixer_oss
snd_pcm
snd_seq_dummy
snd_seq_oss
snd_seq_midi
snd_rawmidi
snd_seq_midi_event
arc4
snd_seq
snd_timer
iwlagn
snd_seq_device
joydev
iwlcore
sdhci_pci
snd
sdhci
mac80211
soundcore
psmouse
ppdev
led_class
dell_wmi
cfg80211
serio_raw
snd_page_alloc
parport_pc
lp
dcdbas
parport
dm_raid45
xor
fbcon
tileblit
font
bitblit
softcursor
vga16fb
vgastate
usbhid
hid
i915
drm_kms_helper
drm
intel_agp
i2c_algo_bit
video
output
ahci
e1000e
agpgart


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x0a 0x03a11020
0x0b 0x0321101f
0x0c 0x400000f0
0x0d 0x90170110
0x0e 0x23011050
0x0f 0x23a1102e
0x10 0x400000f0
0x11 0x90a601a0
0x1f 0x400000f0
0x20 0x400000f0

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:
0x0e 0x40f000f0
0x0f 0x40f000f0

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D3/init_pin_configs:
0x04 0x18560010
0x05 0x18560020
0x06 0x58560030

/sys/class/sound/hwC0D3/driver_pin_configs:

/sys/class/sound/hwC0D3/user_pin_configs:

/sys/class/sound/hwC0D3/init_verbs:


!!ALSA/HDA dmesg
!!------------------

[   14.429318]   alloc kstat_irqs on node -1
[   14.429325] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) -> IRQ 22
[   14.429375] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   14.429380] hda-intel: chipset global capabilities = 0x4401
[   14.460407] hda-intel: codec_mask = 0x9
[   14.460504] hda-intel: codec #0 probed OK
[   14.460547] hda-intel: codec #3 probed OK
[   14.532339] hda-intel: Applying patch firmware 'audio-test.fw'
[   14.532351] HDA Intel 0000:00:1b.0: firmware: requesting audio-test.fw
[   14.648917] hda_codec: 92HD81B1X5: BIOS auto-probing.
[   14.648923] autoconfig: line_outs=1 (0xd/0x0/0x0/0x0/0x0)
--
[   14.649137] stac92xx: dac_nids=1 (0x13/0x0/0x0/0x0/0x0)
[   14.649321] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.0/input/input11
[   14.649369] XXX stac_check_auto_mic:3545 ENTER
--
[   14.796272] Cannot find slave IEC958 Playback Switch, skipped
[   14.796554] input: HDA Intel Mic at Ext Left Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input12
[   14.796690] input: HDA Intel HP Out at Ext Left Jack as /devices/pci0000:00/0000:00:1b.0/sound/card0/input13
[   14.859861] e1000e 0000:00:19.0: irq 33 for MSI/MSI-X
--
[   16.456984] cfg80211: Found new beacon on frequency: 5220 MHz (Ch 44) on phy0
[   18.284752] hda_codec_cleanup_stream: NID=0x13
[   18.284757] hda_codec_cleanup_stream: NID=0x14
[   18.284927] hda_codec_cleanup_stream: NID=0x13
[   18.284930] hda_codec_cleanup_stream: NID=0x14
[   18.285128] hda_codec_cleanup_stream: NID=0x13
[   18.285132] hda_codec_cleanup_stream: NID=0x14
[   18.285459] hda_codec_cleanup_stream: NID=0x13
[   18.285464] hda_codec_cleanup_stream: NID=0x14
[   18.285640] hda_codec_cleanup_stream: NID=0x13
[   18.285644] hda_codec_cleanup_stream: NID=0x14
[   18.285858] hda_codec_cleanup_stream: NID=0x13
[   18.285861] hda_codec_cleanup_stream: NID=0x14
[   18.286031] hda_codec_cleanup_stream: NID=0x13
[   18.286038] hda_codec_cleanup_stream: NID=0x14
[   18.286379] hda_codec_cleanup_stream: NID=0x13
[   18.286382] hda_codec_cleanup_stream: NID=0x14
[   18.286507] hda_codec_cleanup_stream: NID=0x13
[   18.286510] hda_codec_cleanup_stream: NID=0x14
[   18.286671] hda_codec_cleanup_stream: NID=0x13
[   18.286674] hda_codec_cleanup_stream: NID=0x14
[   18.286842] hda_codec_cleanup_stream: NID=0x13
[   18.286845] hda_codec_cleanup_stream: NID=0x14
[   18.287188] hda_codec_cleanup_stream: NID=0x13
[   18.287191] hda_codec_cleanup_stream: NID=0x14
[   18.287315] hda_codec_cleanup_stream: NID=0x13
[   18.287319] hda_codec_cleanup_stream: NID=0x14
[   18.287446] hda_codec_cleanup_stream: NID=0x13
[   18.287449] hda_codec_cleanup_stream: NID=0x14
[   18.287621] hda_codec_cleanup_stream: NID=0x13
[   18.287624] hda_codec_cleanup_stream: NID=0x14
[   18.287900] hda_codec_cleanup_stream: NID=0x13
[   18.287903] hda_codec_cleanup_stream: NID=0x14
[   18.288033] hda_codec_cleanup_stream: NID=0x13
[   18.288036] hda_codec_cleanup_stream: NID=0x14
[   18.288163] hda_codec_cleanup_stream: NID=0x13
[   18.288167] hda_codec_cleanup_stream: NID=0x14
[   18.288339] hda_codec_cleanup_stream: NID=0x13
[   18.288343] hda_codec_cleanup_stream: NID=0x14
[   18.288615] hda_codec_cleanup_stream: NID=0x13
[   18.288618] hda_codec_cleanup_stream: NID=0x14
[   18.290976] hda-intel: azx_pcm_prepare: bufsize=0x3700, format=0x4011
[   18.290990] hda_codec_setup_stream: NID=0x13, stream=0x5, channel=0, format=0x4011
[   18.301277] hda_codec_setup_stream: NID=0x14, stream=0x5, channel=0, format=0x4011
[   18.309372] hda-intel: azx_pcm_prepare: bufsize=0x3700, format=0x4011
[   18.309393] hda_codec_setup_stream: NID=0x13, stream=0x5, channel=0, format=0x4011
[   18.317267] hda_codec_setup_stream: NID=0x14, stream=0x5, channel=0, format=0x4011
[   18.325774] hda_codec_cleanup_stream: NID=0x15
[   18.325991] hda_codec_cleanup_stream: NID=0x15
[   18.326170] hda_codec_cleanup_stream: NID=0x15
[   18.326519] hda_codec_cleanup_stream: NID=0x15
[   18.326883] hda-intel: azx_pcm_prepare: bufsize=0x3700, format=0x4011
[   18.326891] hda_codec_setup_stream: NID=0x15, stream=0x1, channel=0, format=0x4011
[   18.337475] hda-intel: azx_pcm_prepare: bufsize=0x3700, format=0x4011
[   18.337485] hda_codec_setup_stream: NID=0x15, stream=0x1, channel=0, format=0x4011
[   18.345468] hda_codec_cleanup_stream: NID=0x15
[   18.345484] hda_codec_cleanup_stream: NID=0x15
[   18.346065] hda_codec_cleanup_stream: NID=0x13
[   18.346069] hda_codec_cleanup_stream: NID=0x14
[   18.346086] hda_codec_cleanup_stream: NID=0x13
[   18.346088] hda_codec_cleanup_stream: NID=0x14
[   18.346388] hda_codec_cleanup_stream: NID=0x13
[   18.346391] hda_codec_cleanup_stream: NID=0x14
[   18.346656] hda_codec_cleanup_stream: NID=0x13
[   18.346660] hda_codec_cleanup_stream: NID=0x14
[   18.347010] hda_codec_cleanup_stream: NID=0x13
[   18.347014] hda_codec_cleanup_stream: NID=0x14
[   18.347475] hda_codec_cleanup_stream: NID=0x13
[   18.347478] hda_codec_cleanup_stream: NID=0x14
[   18.347745] hda_codec_cleanup_stream: NID=0x13
[   18.347749] hda_codec_cleanup_stream: NID=0x14
[   18.348011] hda_codec_cleanup_stream: NID=0x13
[   18.348015] hda_codec_cleanup_stream: NID=0x14
[   18.348360] hda_codec_cleanup_stream: NID=0x13
[   18.348364] hda_codec_cleanup_stream: NID=0x14
[   18.348823] hda_codec_cleanup_stream: NID=0x13
[   18.348827] hda_codec_cleanup_stream: NID=0x14
[   18.349093] hda_codec_cleanup_stream: NID=0x13
[   18.349097] hda_codec_cleanup_stream: NID=0x14
[   18.349359] hda_codec_cleanup_stream: NID=0x13
[   18.349362] hda_codec_cleanup_stream: NID=0x14
[   18.349867] hda_codec_cleanup_stream: NID=0x13
[   18.349871] hda_codec_cleanup_stream: NID=0x14
[   18.350311] hda_codec_cleanup_stream: NID=0x13
[   18.350315] hda_codec_cleanup_stream: NID=0x14
[   18.350647] hda_codec_cleanup_stream: NID=0x13
[   18.350650] hda_codec_cleanup_stream: NID=0x14
[   18.350903] hda_codec_cleanup_stream: NID=0x13
[   18.350906] hda_codec_cleanup_stream: NID=0x14
[   18.351313] hda_codec_cleanup_stream: NID=0x13
[   18.351316] hda_codec_cleanup_stream: NID=0x14
[   18.351766] hda_codec_cleanup_stream: NID=0x13
[   18.351769] hda_codec_cleanup_stream: NID=0x14
[   18.352034] hda_codec_cleanup_stream: NID=0x13
[   18.352038] hda_codec_cleanup_stream: NID=0x14
[   18.352298] hda_codec_cleanup_stream: NID=0x13
[   18.352301] hda_codec_cleanup_stream: NID=0x14
[   18.352661] hda_codec_cleanup_stream: NID=0x13
[   18.352665] hda_codec_cleanup_stream: NID=0x14
[   18.353123] hda_codec_cleanup_stream: NID=0x13
[   18.353126] hda_codec_cleanup_stream: NID=0x14
[   18.353383] hda_codec_cleanup_stream: NID=0x13
[   18.353387] hda_codec_cleanup_stream: NID=0x14
[   18.353688] hda_codec_cleanup_stream: NID=0x13
[   18.353692] hda_codec_cleanup_stream: NID=0x14
[   18.353940] hda_codec_cleanup_stream: NID=0x13
[   18.353943] hda_codec_cleanup_stream: NID=0x14
[   18.354181] hda_codec_cleanup_stream: NID=0x13
[   18.354184] hda_codec_cleanup_stream: NID=0x14
[   18.354406] hda_codec_cleanup_stream: NID=0x13
[   18.354409] hda_codec_cleanup_stream: NID=0x14
[   18.354667] hda_codec_cleanup_stream: NID=0x13
[   18.354670] hda_codec_cleanup_stream: NID=0x14
[   18.354897] hda_codec_cleanup_stream: NID=0x13
[   18.354901] hda_codec_cleanup_stream: NID=0x14
[   18.355177] hda_codec_cleanup_stream: NID=0x13
[   18.355180] hda_codec_cleanup_stream: NID=0x14
[   18.355401] hda_codec_cleanup_stream: NID=0x13
[   18.355405] hda_codec_cleanup_stream: NID=0x14
[   18.355664] hda_codec_cleanup_stream: NID=0x13
[   18.355667] hda_codec_cleanup_stream: NID=0x14
[   18.355903] hda_codec_cleanup_stream: NID=0x13
[   18.355906] hda_codec_cleanup_stream: NID=0x14
[   18.356150] hda_codec_cleanup_stream: NID=0x13
[   18.356153] hda_codec_cleanup_stream: NID=0x14
[   18.356384] hda_codec_cleanup_stream: NID=0x13
[   18.356388] hda_codec_cleanup_stream: NID=0x14
[   18.356615] hda_codec_cleanup_stream: NID=0x13
[   18.356619] hda_codec_cleanup_stream: NID=0x14
[   18.356858] hda_codec_cleanup_stream: NID=0x13
[   18.356862] hda_codec_cleanup_stream: NID=0x14
[   18.357104] hda_codec_cleanup_stream: NID=0x13
[   18.357108] hda_codec_cleanup_stream: NID=0x14
[   18.357340] hda_codec_cleanup_stream: NID=0x13
[   18.357343] hda_codec_cleanup_stream: NID=0x14
[   18.357583] hda_codec_cleanup_stream: NID=0x13
[   18.357587] hda_codec_cleanup_stream: NID=0x14
[   18.357825] hda_codec_cleanup_stream: NID=0x13
[   18.357829] hda_codec_cleanup_stream: NID=0x14
[   18.358077] hda_codec_cleanup_stream: NID=0x13
[   18.358081] hda_codec_cleanup_stream: NID=0x14
[   18.358313] hda_codec_cleanup_stream: NID=0x13
[   18.358316] hda_codec_cleanup_stream: NID=0x14
[   18.358580] hda_codec_cleanup_stream: NID=0x13
[   18.358583] hda_codec_cleanup_stream: NID=0x14
[   18.358810] hda_codec_cleanup_stream: NID=0x13
[   18.358813] hda_codec_cleanup_stream: NID=0x14
[   18.359087] hda_codec_cleanup_stream: NID=0x13
[   18.359090] hda_codec_cleanup_stream: NID=0x14
[   18.359312] hda_codec_cleanup_stream: NID=0x13
[   18.359316] hda_codec_cleanup_stream: NID=0x14
[   18.359575] hda_codec_cleanup_stream: NID=0x13
[   18.359578] hda_codec_cleanup_stream: NID=0x14
[   18.359812] hda_codec_cleanup_stream: NID=0x13
[   18.359816] hda_codec_cleanup_stream: NID=0x14
[   18.360058] hda_codec_cleanup_stream: NID=0x13
[   18.360061] hda_codec_cleanup_stream: NID=0x14
[   18.360295] hda_codec_cleanup_stream: NID=0x13
[   18.360298] hda_codec_cleanup_stream: NID=0x14
[   18.360525] hda_codec_cleanup_stream: NID=0x13
[   18.360528] hda_codec_cleanup_stream: NID=0x14
[   18.360766] hda_codec_cleanup_stream: NID=0x13
[   18.360770] hda_codec_cleanup_stream: NID=0x14
[   18.361015] hda_codec_cleanup_stream: NID=0x13
[   18.361019] hda_codec_cleanup_stream: NID=0x14
[   18.361253] hda_codec_cleanup_stream: NID=0x13
[   18.361256] hda_codec_cleanup_stream: NID=0x14
[   18.361505] hda_codec_cleanup_stream: NID=0x13
[   18.361509] hda_codec_cleanup_stream: NID=0x14
[   18.361751] hda_codec_cleanup_stream: NID=0x13
[   18.361754] hda_codec_cleanup_stream: NID=0x14
[   18.362002] hda_codec_cleanup_stream: NID=0x13
[   18.362006] hda_codec_cleanup_stream: NID=0x14
[   18.362240] hda_codec_cleanup_stream: NID=0x13
[   18.362244] hda_codec_cleanup_stream: NID=0x14
[   18.362504] hda_codec_cleanup_stream: NID=0x13
[   18.362507] hda_codec_cleanup_stream: NID=0x14
[   18.362734] hda_codec_cleanup_stream: NID=0x13
[   18.362737] hda_codec_cleanup_stream: NID=0x14
[   18.363010] hda_codec_cleanup_stream: NID=0x13
[   18.363013] hda_codec_cleanup_stream: NID=0x14
[   18.363264] hda_codec_cleanup_stream: NID=0x13
[   18.363267] hda_codec_cleanup_stream: NID=0x14
[   18.363556] hda_codec_cleanup_stream: NID=0x13
[   18.363559] hda_codec_cleanup_stream: NID=0x14
[   18.363883] hda_codec_cleanup_stream: NID=0x13
[   18.363886] hda_codec_cleanup_stream: NID=0x14
[   18.364468] hda_codec_cleanup_stream: NID=0x13
[   18.364473] hda_codec_cleanup_stream: NID=0x14
[   18.364866] hda_codec_cleanup_stream: NID=0x13
[   18.364871] hda_codec_cleanup_stream: NID=0x14
[   18.365273] hda_codec_cleanup_stream: NID=0x13
[   18.365277] hda_codec_cleanup_stream: NID=0x14
[   18.365808] hda_codec_cleanup_stream: NID=0x13
[   18.365813] hda_codec_cleanup_stream: NID=0x14
[   18.366465] hda_codec_cleanup_stream: NID=0x13
[   18.366469] hda_codec_cleanup_stream: NID=0x14
[   18.366873] hda_codec_cleanup_stream: NID=0x13
[   18.366878] hda_codec_cleanup_stream: NID=0x14
[   18.367269] hda_codec_cleanup_stream: NID=0x13
[   18.367273] hda_codec_cleanup_stream: NID=0x14
[   18.367788] hda_codec_cleanup_stream: NID=0x13
[   18.367792] hda_codec_cleanup_stream: NID=0x14
[   18.368479] hda_codec_cleanup_stream: NID=0x13
[   18.368483] hda_codec_cleanup_stream: NID=0x14
[   18.368890] hda_codec_cleanup_stream: NID=0x13
[   18.368894] hda_codec_cleanup_stream: NID=0x14
[   18.369285] hda_codec_cleanup_stream: NID=0x13
[   18.369289] hda_codec_cleanup_stream: NID=0x14
[   18.369849] hda_codec_cleanup_stream: NID=0x13
[   18.369853] hda_codec_cleanup_stream: NID=0x14
[   18.370546] hda_codec_cleanup_stream: NID=0x13
[   18.370551] hda_codec_cleanup_stream: NID=0x14
[   18.370959] hda_codec_cleanup_stream: NID=0x13
[   18.370963] hda_codec_cleanup_stream: NID=0x14
[   18.371356] hda_codec_cleanup_stream: NID=0x13
[   18.371360] hda_codec_cleanup_stream: NID=0x14
[   18.371898] hda_codec_cleanup_stream: NID=0x13
[   18.371903] hda_codec_cleanup_stream: NID=0x14
[   18.372610] hda_codec_cleanup_stream: NID=0x13
[   18.372615] hda_codec_cleanup_stream: NID=0x14
[   18.373025] hda_codec_cleanup_stream: NID=0x13
[   18.373030] hda_codec_cleanup_stream: NID=0x14
[   18.373443] hda_codec_cleanup_stream: NID=0x13
[   18.373448] hda_codec_cleanup_stream: NID=0x14
[   18.373836] hda_codec_cleanup_stream: NID=0x13
[   18.373840] hda_codec_cleanup_stream: NID=0x14
[   18.374396] hda_codec_cleanup_stream: NID=0x13
[   18.374401] hda_codec_cleanup_stream: NID=0x14
[   18.374706] hda_codec_cleanup_stream: NID=0x13
[   18.374710] hda_codec_cleanup_stream: NID=0x14
[   18.375092] hda_codec_cleanup_stream: NID=0x13
[   18.375097] hda_codec_cleanup_stream: NID=0x14
[   18.375551] hda_codec_cleanup_stream: NID=0x13
[   18.375555] hda_codec_cleanup_stream: NID=0x14
[   18.376180] hda_codec_cleanup_stream: NID=0x13
[   18.376185] hda_codec_cleanup_stream: NID=0x14
[   18.376515] hda_codec_cleanup_stream: NID=0x13
[   18.376519] hda_codec_cleanup_stream: NID=0x14
[   18.376826] hda_codec_cleanup_stream: NID=0x13
[   18.376829] hda_codec_cleanup_stream: NID=0x14
[   18.377265] hda_codec_cleanup_stream: NID=0x13
[   18.377268] hda_codec_cleanup_stream: NID=0x14
[   18.377745] hda_codec_cleanup_stream: NID=0x13
[   18.377748] hda_codec_cleanup_stream: NID=0x14
[   18.378048] hda_codec_cleanup_stream: NID=0x13
[   18.378052] hda_codec_cleanup_stream: NID=0x14
[   18.378315] hda_codec_cleanup_stream: NID=0x13
[   18.378318] hda_codec_cleanup_stream: NID=0x14
[   18.378817] hda_codec_cleanup_stream: NID=0x13
[   18.378821] hda_codec_cleanup_stream: NID=0x14
[   18.379514] hda_codec_cleanup_stream: NID=0x13
[   18.379519] hda_codec_cleanup_stream: NID=0x14
[   18.379911] hda_codec_cleanup_stream: NID=0x13
[   18.379916] hda_codec_cleanup_stream: NID=0x14
[   18.380307] hda_codec_cleanup_stream: NID=0x13
[   18.380311] hda_codec_cleanup_stream: NID=0x14
[   18.380830] hda_codec_cleanup_stream: NID=0x13
[   18.380834] hda_codec_cleanup_stream: NID=0x14
[   18.381534] hda_codec_cleanup_stream: NID=0x13
[   18.381538] hda_codec_cleanup_stream: NID=0x14
[   18.386048] hda-intel: azx_pcm_prepare: bufsize=0x3700, format=0x4011
[   18.386060] hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
[   18.394000] HDMI: ELD buf size is 84
[   18.394065] HDMI: DIP GP[0] buf size is 30
[   18.394119] HDMI: DIP GP[1] buf size is 30
[   18.394162] HDMI: DIP GP[2] buf size is 30
[   18.394206] HDMI: DIP GP[3] buf size is 30
[   18.394249] HDMI: DIP GP[4] buf size is 0
[   18.394293] HDMI: DIP GP[5] buf size is 0
[   18.394347] HDMI: DIP GP[6] buf size is 0
[   18.394390] HDMI: DIP GP[7] buf size is 0
[   18.394426] hda-intel: azx_pcm_prepare: bufsize=0x3700, format=0x4011
[   18.394436] hda_codec_setup_stream: NID=0x2, stream=0x5, channel=0, format=0x4011
[   18.401994] HDMI: ELD buf size is 84
[   18.402048] HDMI: DIP GP[0] buf size is 30
[   18.402082] HDMI: DIP GP[1] buf size is 30
[   18.402135] HDMI: DIP GP[2] buf size is 30
[   18.402198] HDMI: DIP GP[3] buf size is 30
[   18.402260] HDMI: DIP GP[4] buf size is 0
[   18.402313] HDMI: DIP GP[5] buf size is 0
[   18.402355] HDMI: DIP GP[6] buf size is 0
[   18.402398] HDMI: DIP GP[7] buf size is 0
[   18.402683] hda_codec_cleanup_stream: NID=0x15
[   18.402813] hda_codec_cleanup_stream: NID=0x15
[   18.402992] hda_codec_cleanup_stream: NID=0x15
[   18.403269] hda_codec_cleanup_stream: NID=0x15
[   18.403644] hda-intel: azx_pcm_prepare: bufsize=0x3700, format=0x4011
[   18.403653] hda_codec_setup_stream: NID=0x15, stream=0x1, channel=0, format=0x4011
[   18.409890] hda-intel: azx_pcm_prepare: bufsize=0x3700, format=0x4011
[   18.409902] hda_codec_setup_stream: NID=0x15, stream=0x1, channel=0, format=0x4011
[   18.417943] hda_codec_cleanup_stream: NID=0x15
[   18.417967] hda_codec_cleanup_stream: NID=0x15
[   18.418558] hda_codec_cleanup_stream: NID=0x2
[   18.418594] hda_codec_cleanup_stream: NID=0x2
[   18.418757] hda_codec_cleanup_stream: NID=0x15
[   18.418886] hda_codec_cleanup_stream: NID=0x15
[   18.419066] hda_codec_cleanup_stream: NID=0x15
[   18.419398] hda_codec_cleanup_stream: NID=0x15
[   18.419918] hda-intel: azx_pcm_prepare: bufsize=0x3700, format=0x4011
[   18.419928] hda_codec_setup_stream: NID=0x15, stream=0x1, channel=0, format=0x4011
[   18.425844] hda-intel: azx_pcm_prepare: bufsize=0x3700, format=0x4011
[   18.425854] hda_codec_setup_stream: NID=0x15, stream=0x1, channel=0, format=0x4011
[   18.433857] hda_codec_cleanup_stream: NID=0x15
[   18.433880] hda_codec_cleanup_stream: NID=0x15
[   18.436229] hda-intel: azx_pcm_prepare: bufsize=0x56200, format=0x4011
[   18.436242] hda_codec_setup_stream: NID=0x13, stream=0x5, channel=0, format=0x4011
[   18.441797] hda_codec_setup_stream: NID=0x14, stream=0x5, channel=0, format=0x4011
[   18.449807] hda-intel: azx_pcm_prepare: bufsize=0x56200, format=0x4011
[   18.449923] hda_codec_setup_stream: NID=0x13, stream=0x5, channel=0, format=0x4011
[   18.457761] hda_codec_setup_stream: NID=0x14, stream=0x5, channel=0, format=0x4011
[   18.674055] hda-intel: azx_pcm_prepare: bufsize=0x56200, format=0x4011
[   18.674065] hda_codec_setup_stream: NID=0x15, stream=0x1, channel=0, format=0x4011
[   18.681430] hda-intel: azx_pcm_prepare: bufsize=0x56200, format=0x4011
[   18.681441] hda_codec_setup_stream: NID=0x15, stream=0x1, channel=0, format=0x4011
[   18.703220] CPU0 attaching NULL sched-domain.
--
[   18.753441]    groups: 1,3 (cpu_power = 1178) 0,2 (cpu_power = 1178)
[   23.717959] hda_codec_cleanup_stream: NID=0x15
[   23.717976] hda_codec_cleanup_stream: NID=0x15
[   26.622100] cfg80211: Found new beacon on frequency: 5785 MHz (Ch 157) on phy0
--
[   26.859924] ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready
[   33.471128] hda_codec_cleanup_stream: NID=0x13
[   33.471133] hda_codec_cleanup_stream: NID=0x14
[   33.471238] hda_codec_cleanup_stream: NID=0x13
[   33.471240] hda_codec_cleanup_stream: NID=0x14
[   37.280513] wlan0: no IPv6 routers present



--------------060501020205030009070300
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060501020205030009070300--
