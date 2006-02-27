From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001879]: No sound heard but no error
Date: Mon, 27 Feb 2006 19:26:19 +0100
Message-ID: <cc6ad546ad271c80bb519dc9ca762607@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0761218D
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2006 19:26:19 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1879> 
======================================================================
Reported By:                at2000
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1879
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Ubuntu
Kernel Version:             2.6.15.4 (2.6.15-16-686)
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             02-26-2006 06:18 CET
Last Modified:              02-27-2006 19:26 CET
======================================================================
Summary:                    No sound heard but no error
Description: 
# lspci
0000:00:00.0 Host bridge: Intel Corporation 945G/P Memory Controller Hub
(rev 02)
0000:00:02.0 VGA compatible controller: Intel Corporation 945G Integrated
Graphics Controller (rev 02)
0000:00:1b.0 0403: Intel Corporation 82801G (ICH7 Family) High Definition
Audio Controller (rev 01)
0000:00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #1 (rev 01)
0000:00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #2 (rev 01)
0000:00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #3 (rev 01)
0000:00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB
UHCI #4 (rev 01)
0000:00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2
EHCI Controller (rev 01)
0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1)
0000:00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC
Interface Bridge (rev 01)
0000:00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE
Controller (rev 01)
0000:00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family)
Serial ATA Storage Controllers cc=IDE (rev 01)
0000:00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus
Controller (rev 01)
0000:01:03.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5788
Gigabit Ethernet (rev 03)

# grep . /proc/asound/*
/proc/asound/cards: 0 [Intel ]: HDA-Intel - HDA Intel
/proc/asound/cards: HDA Intel at 0xfdff8000 irq 193
/proc/asound/devices: 0: [ 0] : control
/proc/asound/devices: 16: [ 0- 0]: digital audio playback
/proc/asound/devices: 17: [ 0- 1]: digital audio playback
/proc/asound/devices: 24: [ 0- 0]: digital audio capture
/proc/asound/devices: 33: : timer
/proc/asound/modules: 0 snd_hda_intel
/proc/asound/pcm:00-00: ALC880 Analog : ALC880 Analog : playback 1 :
capture 2
/proc/asound/pcm:00-01: ALC880 Digital : ALC880 Digital : playback 1
/proc/asound/timers:G0: system timer : 1000.000us (10000000 ticks)
/proc/asound/timers:P0-0-0: PCM playback 0-0-0 : SLAVE
/proc/asound/timers:P0-0-1: PCM capture 0-0-1 : SLAVE
/proc/asound/timers:P0-0-3: PCM capture 0-0-3 : SLAVE
/proc/asound/timers:P0-1-0: PCM playback 0-1-0 : SLAVE
/proc/asound/version:Advanced Linux Sound Architecture Driver Version
1.0.11rc2.
/proc/asound/version:Compiled on Feb 26 2006 for kernel 2.6.15-16-686
(SMP).

aplay plays the file but no sound.

# grep . /proc/asound/card0/*
/proc/asound/card0/codec#2:Codec: Realtek ALC880
/proc/asound/card0/codec#2:Address: 2
/proc/asound/card0/codec#2:Vendor Id: 0x10ec0880
/proc/asound/card0/codec#2:Subsystem Id: 0x105bb603
/proc/asound/card0/codec#2:Revision Id: 0x100800
/proc/asound/card0/codec#2:Default PCM: rates 0x560, bits 0x0e, types 0x1
/proc/asound/card0/codec#2:Default Amp-In caps: N/A
/proc/asound/card0/codec#2:Default Amp-Out caps: N/A
/proc/asound/card0/codec#2:Node 0x02 [Audio Output] wcaps 0x411: Stereo
/proc/asound/card0/codec#2:  PCM: rates 0x560, bits 0x0e, types 0x1
/proc/asound/card0/codec#2:  Power: 0x0
/proc/asound/card0/codec#2:Node 0x03 [Audio Output] wcaps 0x411: Stereo
/proc/asound/card0/codec#2:  PCM: rates 0x560, bits 0x0e, types 0x1
/proc/asound/card0/codec#2:  Power: 0x0
/proc/asound/card0/codec#2:Node 0x04 [Audio Output] wcaps 0x411: Stereo
/proc/asound/card0/codec#2:  PCM: rates 0x160, bits 0x0e, types 0x1
/proc/asound/card0/codec#2:  Power: 0x0
/proc/asound/card0/codec#2:Node 0x05 [Audio Output] wcaps 0x411: Stereo
/proc/asound/card0/codec#2:  PCM: rates 0x160, bits 0x0e, types 0x1
/proc/asound/card0/codec#2:  Power: 0x0
/proc/asound/card0/codec#2:Node 0x06 [Audio Output] wcaps 0x211: Stereo
Digital
/proc/asound/card0/codec#2:  PCM: rates 0x160, bits 0x1e, types 0x1
/proc/asound/card0/codec#2:Node 0x07 [Audio Input] wcaps 0x10051b: Stereo
Amp-In
/proc/asound/card0/codec#2:  Amp-In caps: ofs=0x00, nsteps=0x23,
stepsize=0x03, mute=1
/proc/asound/card0/codec#2:  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00
0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
/proc/asound/card0/codec#2:  PCM: rates 0x160, bits 0x06, types 0x1
/proc/asound/card0/codec#2:  Power: 0x0
/proc/asound/card0/codec#2:  Connection: 7
/proc/asound/card0/codec#2:     0x18* 0x19 0x1a 0x1b 0x1c 0x14 0x15
/proc/asound/card0/codec#2:Node 0x08 [Audio Input] wcaps 0x10051b: Stereo
Amp-In
/proc/asound/card0/codec#2:  Amp-In caps: ofs=0x00, nsteps=0x23,
stepsize=0x03, mute=1
/proc/asound/card0/codec#2:  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00
0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00]
/proc/asound/card0/codec#2:  PCM: rates 0x160, bits 0x06, types 0x1
/proc/asound/card0/codec#2:  Power: 0x0
/proc/asound/card0/codec#2:  Connection: 7
/proc/asound/card0/codec#2:     0x18* 0x19 0x1a 0x1b 0x1c 0x14 0x15
/proc/asound/card0/codec#2:Node 0x09 [Audio Input] wcaps 0x10051b: Stereo
Amp-In
/proc/asound/card0/codec#2:  Amp-In caps: ofs=0x00, nsteps=0x23,
stepsize=0x03, mute=1
/proc/asound/card0/codec#2:  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00
0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x00
0x00] [0x00 0x00]
/proc/asound/card0/codec#2:  PCM: rates 0x160, bits 0x06, types 0x1
/proc/asound/card0/codec#2:  Power: 0x0
/proc/asound/card0/codec#2:  Connection: 10
/proc/asound/card0/codec#2:     0x18* 0x19 0x1a 0x1b 0x1c 0x0b 0x14 0x15
0x16 0x17
/proc/asound/card0/codec#2:Node 0x0a [Audio Input] wcaps 0x100391: Stereo
Digital
/proc/asound/card0/codec#2:  PCM: rates 0x160, bits 0x1e, types 0x1
/proc/asound/card0/codec#2:  Connection: 1
/proc/asound/card0/codec#2:     0x1f
/proc/asound/card0/codec#2:Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo
Amp-In
/proc/asound/card0/codec#2:  Amp-In caps: ofs=0x23, nsteps=0x41,
stepsize=0x03, mute=1
/proc/asound/card0/codec#2:  Amp-In vals:  [0x1d 0x1d] [0x41 0x41] [0x41
0x41] [0x00 0x00] [0x41 0x41] [0xa3 0xa3] [0xa3 0xa3] [0xa3 0xa3]
/proc/asound/card0/codec#2:  Connection: 8
/proc/asound/card0/codec#2:     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15
/proc/asound/card0/codec#2:Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo
Amp-In Amp-Out
/proc/asound/card0/codec#2:  Amp-In caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
/proc/asound/card0/codec#2:  Amp-In vals:  [0x00 0x00] [0x00 0x00]
/proc/asound/card0/codec#2:  Amp-Out caps: ofs=0x40, nsteps=0x40,
stepsize=0x03, mute=0
/proc/asound/card0/codec#2:  Amp-Out vals:  [0x40 0x40]
/proc/asound/card0/codec#2:  Connection: 2
/proc/asound/card0/codec#2:     0x02 0x0b
/proc/asound/card0/codec#2:Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo
Amp-In Amp-Out
/proc/asound/card0/codec#2:  Amp-In caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
/proc/asound/card0/codec#2:  Amp-In vals:  [0x00 0x00] [0x00 0x00]
/proc/asound/card0/codec#2:  Amp-Out caps: ofs=0x40, nsteps=0x40,
stepsize=0x03, mute=0
/proc/asound/card0/codec#2:  Amp-Out vals:  [0x40 0x40]
/proc/asound/card0/codec#2:  Connection: 2
/proc/asound/card0/codec#2:     0x03 0x0b
/proc/asound/card0/codec#2:Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo
Amp-In Amp-Out
/proc/asound/card0/codec#2:  Amp-In caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
/proc/asound/card0/codec#2:  Amp-In vals:  [0x00 0x00] [0x00 0x00]
/proc/asound/card0/codec#2:  Amp-Out caps: ofs=0x40, nsteps=0x40,
stepsize=0x03, mute=0
/proc/asound/card0/codec#2:  Amp-Out vals:  [0x40 0x40]
/proc/asound/card0/codec#2:  Connection: 2
/proc/asound/card0/codec#2:     0x04 0x0b
/proc/asound/card0/codec#2:Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo
Amp-In Amp-Out
/proc/asound/card0/codec#2:  Amp-In caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
/proc/asound/card0/codec#2:  Amp-In vals:  [0x00 0x00] [0x00 0x00]
/proc/asound/card0/codec#2:  Amp-Out caps: ofs=0x40, nsteps=0x40,
stepsize=0x03, mute=0
/proc/asound/card0/codec#2:  Amp-Out vals:  [0x40 0x40]
/proc/asound/card0/codec#2:  Connection: 2
/proc/asound/card0/codec#2:     0x05 0x0b
/proc/asound/card0/codec#2:Node 0x10 [Audio Selector] wcaps 0x300101:
Stereo
/proc/asound/card0/codec#2:  Connection: 4
/proc/asound/card0/codec#2:     0x0c* 0x0d 0x0e 0x0f
/proc/asound/card0/codec#2:Node 0x11 [Audio Selector] wcaps 0x300101:
Stereo
/proc/asound/card0/codec#2:  Connection: 4
/proc/asound/card0/codec#2:     0x0c* 0x0d 0x0e 0x0f
/proc/asound/card0/codec#2:Node 0x12 [Audio Selector] wcaps 0x300101:
Stereo
/proc/asound/card0/codec#2:  Connection: 4
/proc/asound/card0/codec#2:     0x0c* 0x0d 0x0e 0x0f
/proc/asound/card0/codec#2:Node 0x13 [Audio Selector] wcaps 0x300101:
Stereo
/proc/asound/card0/codec#2:  Connection: 4
/proc/asound/card0/codec#2:     0x0c* 0x0d 0x0e 0x0f
/proc/asound/card0/codec#2:Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo
Amp-Out
/proc/asound/card0/codec#2:  Amp-Out caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
/proc/asound/card0/codec#2:  Amp-Out vals:  [0x00 0x00]
/proc/asound/card0/codec#2:  Pincap 0x083f: IN OUT HP
/proc/asound/card0/codec#2:  Pin Default 0x01014410: [Jack] Line Out at
Ext Rear
/proc/asound/card0/codec#2:    Conn = 1/8, Color = Green
/proc/asound/card0/codec#2:  Pin-ctls: 0x40: OUT
/proc/asound/card0/codec#2:  Connection: 1
/proc/asound/card0/codec#2:     0x0c
/proc/asound/card0/codec#2:Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo
Amp-Out
/proc/asound/card0/codec#2:  Amp-Out caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
/proc/asound/card0/codec#2:  Amp-Out vals:  [0x00 0x00]
/proc/asound/card0/codec#2:  Pincap 0x083f: IN OUT HP
/proc/asound/card0/codec#2:  Pin Default 0x01011412: [Jack] Line Out at
Ext Rear
/proc/asound/card0/codec#2:    Conn = 1/8, Color = Black
/proc/asound/card0/codec#2:  Pin-ctls: 0x40: OUT
/proc/asound/card0/codec#2:  Connection: 1
/proc/asound/card0/codec#2:     0x0d
/proc/asound/card0/codec#2:Node 0x16 [Pin Complex] wcaps 0x40018d: Stereo
Amp-Out
/proc/asound/card0/codec#2:  Amp-Out caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
/proc/asound/card0/codec#2:  Amp-Out vals:  [0x00 0x00]
/proc/asound/card0/codec#2:  Pincap 0x083f: IN OUT HP
/proc/asound/card0/codec#2:  Pin Default 0x01016411: [Jack] Line Out at
Ext Rear
/proc/asound/card0/codec#2:    Conn = 1/8, Color = Orange
/proc/asound/card0/codec#2:  Pin-ctls: 0x40: OUT
/proc/asound/card0/codec#2:  Connection: 1
/proc/asound/card0/codec#2:     0x0e
/proc/asound/card0/codec#2:Node 0x17 [Pin Complex] wcaps 0x40018d: Stereo
Amp-Out
/proc/asound/card0/codec#2:  Amp-Out caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
/proc/asound/card0/codec#2:  Amp-Out vals:  [0x00 0x00]
/proc/asound/card0/codec#2:  Pincap 0x083f: IN OUT HP
/proc/asound/card0/codec#2:  Pin Default 0x01012414: [Jack] Line Out at
Ext Rear
/proc/asound/card0/codec#2:    Conn = 1/8, Color = Grey
/proc/asound/card0/codec#2:  Pin-ctls: 0x40: OUT
/proc/asound/card0/codec#2:  Connection: 1
/proc/asound/card0/codec#2:     0x0f
/proc/asound/card0/codec#2:Node 0x18 [Pin Complex] wcaps 0x40018d: Stereo
Amp-Out
/proc/asound/card0/codec#2:  Amp-Out caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
/proc/asound/card0/codec#2:  Amp-Out vals:  [0x80 0x80]
/proc/asound/card0/codec#2:  Pincap 0x08133f: IN OUT HP
/proc/asound/card0/codec#2:  Pin Default 0x01a19c30: [Jack] Mic at Ext
Rear
/proc/asound/card0/codec#2:    Conn = 1/8, Color = Pink
/proc/asound/card0/codec#2:  Pin-ctls: 0x24: IN
/proc/asound/card0/codec#2:  Connection: 1
/proc/asound/card0/codec#2:     0x10
/proc/asound/card0/codec#2:Node 0x19 [Pin Complex] wcaps 0x40018d: Stereo
Amp-Out
/proc/asound/card0/codec#2:  Amp-Out caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
/proc/asound/card0/codec#2:  Amp-Out vals:  [0x80 0x80]
/proc/asound/card0/codec#2:  Pincap 0x08133f: IN OUT HP
/proc/asound/card0/codec#2:  Pin Default 0x02a19c40: [Jack] Mic at Ext
Front
/proc/asound/card0/codec#2:    Conn = 1/8, Color = Pink
/proc/asound/card0/codec#2:  Pin-ctls: 0x24: IN
/proc/asound/card0/codec#2:  Connection: 1
/proc/asound/card0/codec#2:     0x11
/proc/asound/card0/codec#2:Node 0x1a [Pin Complex] wcaps 0x40018d: Stereo
Amp-Out
/proc/asound/card0/codec#2:  Amp-Out caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
/proc/asound/card0/codec#2:  Amp-Out vals:  [0x80 0x80]
/proc/asound/card0/codec#2:  Pincap 0x08133f: IN OUT HP
/proc/asound/card0/codec#2:  Pin Default 0x01813431: [Jack] Line In at Ext
Rear
/proc/asound/card0/codec#2:    Conn = 1/8, Color = Blue
/proc/asound/card0/codec#2:  Pin-ctls: 0x20: IN
/proc/asound/card0/codec#2:  Connection: 1
/proc/asound/card0/codec#2:     0x12
/proc/asound/card0/codec#2:Node 0x1b [Pin Complex] wcaps 0x40018d: Stereo
Amp-Out
/proc/asound/card0/codec#2:  Amp-Out caps: ofs=0x00, nsteps=0x00,
stepsize=0x00, mute=1
/proc/asound/card0/codec#2:  Amp-Out vals:  [0x00 0x00]
/proc/asound/card0/codec#2:  Pincap 0x08133f: IN OUT HP
/proc/asound/card0/codec#2:  Pin Default 0x02214c20: [Jack] HP Out at Ext
Front
/proc/asound/card0/codec#2:    Conn = 1/8, Color = Green
/proc/asound/card0/codec#2:  Pin-ctls: 0xc0: OUT HP
/proc/asound/card0/codec#2:  Connection: 1
/proc/asound/card0/codec#2:     0x13
/proc/asound/card0/codec#2:Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
/proc/asound/card0/codec#2:  Pincap 0x0820: IN
/proc/asound/card0/codec#2:  Pin Default 0x99331133: [Fixed] CD at Int
ATAPI
/proc/asound/card0/codec#2:    Conn = ATAPI, Color = Black
/proc/asound/card0/codec#2:  Pin-ctls: 0x00:
/proc/asound/card0/codec#2:Node 0x1d [Pin Complex] wcaps 0x400000: Mono
/proc/asound/card0/codec#2:  Pincap 0x0820: IN
/proc/asound/card0/codec#2:  Pin Default 0x99931132: [Fixed] Aux at Int
ATAPI
/proc/asound/card0/codec#2:    Conn = ATAPI, Color = Black
/proc/asound/card0/codec#2:  Pin-ctls: 0x00:
/proc/asound/card0/codec#2:Node 0x1e [Pin Complex] wcaps 0x400300: Mono
Digital
/proc/asound/card0/codec#2:  Pincap 0x0810: OUT
/proc/asound/card0/codec#2:  Pin Default 0x9943111e: [Fixed] SPDIF Out at
Int ATAPI
/proc/asound/card0/codec#2:    Conn = ATAPI, Color = Black
/proc/asound/card0/codec#2:  Pin-ctls: 0x00:
/proc/asound/card0/codec#2:  Connection: 1
/proc/asound/card0/codec#2:     0x06
/proc/asound/card0/codec#2:Node 0x1f [Pin Complex] wcaps 0x400200: Mono
Digital
/proc/asound/card0/codec#2:  Pincap 0x0820: IN
/proc/asound/card0/codec#2:  Pin Default 0x411111f0: [N/A] Speaker at Ext
Rear
/proc/asound/card0/codec#2:    Conn = 1/8, Color = Black
/proc/asound/card0/codec#2:  Pin-ctls: 0x00:
/proc/asound/card0/codec#2:Node 0x20 [Vendor Defined Widget] wcaps
0xf00040: Mono
/proc/asound/card0/codec#2:Node 0x21 [Volume Knob Widget] wcaps 0x600080:
Mono
/proc/asound/card0/id:Intel
/proc/asound/card0/oss_mixer:VOLUME "Front" 0
/proc/asound/card0/oss_mixer:BASS "" 0
/proc/asound/card0/oss_mixer:TREBLE "" 0
/proc/asound/card0/oss_mixer:SYNTH "" 0
/proc/asound/card0/oss_mixer:PCM "" 0
/proc/asound/card0/oss_mixer:SPEAKER "" 0
/proc/asound/card0/oss_mixer:LINE "Line" 0
/proc/asound/card0/oss_mixer:MIC "Mic" 0
/proc/asound/card0/oss_mixer:CD "CD" 0
/proc/asound/card0/oss_mixer:IMIX "" 0
/proc/asound/card0/oss_mixer:ALTPCM "" 0
/proc/asound/card0/oss_mixer:RECLEV "" 0
/proc/asound/card0/oss_mixer:IGAIN "Capture" 0
/proc/asound/card0/oss_mixer:OGAIN "" 0
/proc/asound/card0/oss_mixer:LINE1 "" 0
/proc/asound/card0/oss_mixer:LINE2 "" 0
/proc/asound/card0/oss_mixer:LINE3 "" 0
/proc/asound/card0/oss_mixer:DIGITAL1 "IEC958" 0
/proc/asound/card0/oss_mixer:DIGITAL2 "" 0
/proc/asound/card0/oss_mixer:DIGITAL3 "" 0
/proc/asound/card0/oss_mixer:PHONEIN "" 0
/proc/asound/card0/oss_mixer:PHONEOUT "" 0
/proc/asound/card0/oss_mixer:VIDEO "" 0
/proc/asound/card0/oss_mixer:RADIO "" 0
/proc/asound/card0/oss_mixer:MONITOR "" 0
======================================================================

----------------------------------------------------------------------
 at2000 - 02-27-06 08:43 
----------------------------------------------------------------------
Sorry, it is wiring problem. I just read the motherboard manual, and it
says that if I don't plug in front-side speaker, I must short 2 pairs of
pins; otherwise, the back-side will be muted. I did it, and it works.
Please close the issue. Thanks!

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-26-06 06:18 at2000         New Issue                                    
02-26-06 06:18 at2000         Distribution              => Ubuntu          
02-26-06 06:18 at2000         Kernel Version            => 2.6.15.4
(2.6.15-16-686)
02-26-06 18:53 at2000         Issue Monitored: at2000                      
02-27-06 08:41 at2000         Issue End Monitor: at2000                    
02-27-06 08:43 at2000         Note Added: 0008219                          
02-27-06 19:26 rlrevell       Status                   assigned => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
