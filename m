From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000963]: Sounc card is mute
Date: Sat, 19 Mar 2005 18:55:06 +0100
Message-ID: <4ec90d27c9436b7dcc13cf422dd59d99@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4F8C41FD
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 18:55:07 +0100 (MET)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=963> 
======================================================================
Reported By:                jnilles
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   963
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               SuSE
Kernel Version:             
======================================================================
Date Submitted:             03-04-2005 19:07 CET
Last Modified:              03-19-2005 18:55 CET
======================================================================
Summary:                    Sounc card is mute
Description: 
I have a Turtle Beach Santa Cruz. It worked perfectly with SuSE Linux 9.0
and still works perfectly under Windows XP. I "upgraded" to SuSE 9.2 and
the sound card is inoperative, mute, lifeless, sound-free. The only advice
I got from SuSE support was that I shouldn't have skipped from 9.0 to 9.2
without going thgrough 9.1 on the way. That sounds like pretty stupid
advice.
I have spent weeks twiddling with settings  recommended by member sof the
alsa users group, to no avail.
======================================================================

----------------------------------------------------------------------
 tiwai - 03-09-05 18:53 
----------------------------------------------------------------------
Remove /etc/asound.state once, and run alsaconf script.

----------------------------------------------------------------------
 jnilles - 03-10-05 00:21 
----------------------------------------------------------------------
I did remove /etc/asound.state, ran alsaconf. No joy, just silence.

----------------------------------------------------------------------
 jdthood - 03-10-05 15:01 
----------------------------------------------------------------------
More information is needed.  Are the correct modules loaded?  Have you
set the mixer levels appropriately?  Please send:

* the output of lsmod
* the contents of /proc/asound/version and /proc/asound/cards
* the output of lspci -v for the sound device

----------------------------------------------------------------------
 jnilles - 03-10-05 20:29 
----------------------------------------------------------------------
KAMix Master is set at 74, PCM at 90; line playback at 100, CD playback at
90 Mic at 0, Capture at 0.

Here are the requested outputs:
Output of lsmod:
Module                  Size  Used by
snd_seq                53008  1 
nvram                   8328  0 
usbserial              26856  0 
parport_pc             37824  1 
lp                     10536  0 
parport                37960  2 parport_pc,lp
snd_pcm_oss            57896  0 
snd_mixer_oss          19200  1 snd_pcm_oss
snd_cs46xx             87880  4 
ipv6                  237312  13 
snd_rawmidi            24356  1 snd_cs46xx
snd_seq_device          8716  2 snd_seq,snd_rawmidi
snd_ac97_codec         69728  1 snd_cs46xx
snd_pcm                96776  3 snd_pcm_oss,snd_cs46xx,snd_ac97_codec
thermal                17928  0 
processor              25640  1 thermal
fan                     5380  0 
button                  8464  0 
snd_timer              24708  2 snd_seq,snd_pcm
battery                11396  0 
ac                      6404  0 
snd                    60164  18
snd_seq,snd_pcm_oss,snd_mixer_oss,snd_cs46xx,snd_rawmidi,snd_seq_device,snd_ac97_codec,snd_pcm,snd_timer
soundcore               9056  1 snd
snd_page_alloc         10248  2 snd_cs46xx,snd_pcm
gameport                4608  1 snd_cs46xx
edd                    10012  0 
usbhid                 40132  0 
joydev                  9664  0 
sg                     35872  0 
st                     37404  0 
sr_mod                 16292  0 
ide_cd                 38176  1 
cdrom                  36508  2 sr_mod,ide_cd
intel_agp              21024  1 
agpgart                32168  1 intel_agp
tulip                  46496  0 
uhci_hcd               29712  0 
hw_random               5524  0 
evdev                   8960  0 
subfs                   7552  4 
nls_cp437               5888  1 
vfat                   13056  1 
fat                    43168  1 vfat
nls_iso8859_1           4224  2 
ntfs                   91888  1 
dm_mod                 54524  0 
usbcore               106724  5 usbserial,usbhid,uhci_hcd
ext3                  115688  1 
jbd                    61348  1 ext3
sd_mod                 16912  0 
scsi_mod              111052  4 sg,st,sr_mod,sd_mod

Contents of /proc/asound/version:
Advanced Linux Sound Architecture Driver Version 1.0.7rc1.
Compiled on Jan 14 2005 for kernel 2.6.8-24.11-default.

Contents of /proc/asound/cards:
0 [CS46xx         ]: CS46xx - Sound Fusion CS46xx
                     Sound Fusion CS46xx at 0xfeaff000/0xfe900000, irq 3

Output of lspci -v:
0000:00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host
Bridge (rev 04)
	Flags: bus master, fast devsel, latency 0
	Memory at f8000000 (32-bit, prefetchable)
	Capabilities: <available only to root>

0000:00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP
Bridge (rev 04) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	Memory behind bridge: fc700000-fe7fffff
	Prefetchable memory behind bridge: e4400000-f44fffff

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 05) (prog-if 00
[Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fe800000-feafffff
	Prefetchable memory behind bridge: f4500000-f45fffff

0000:00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 05)
	Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 05) (prog-if
80 [Master])
	Subsystem: Dell: Unknown device 0115
	Flags: bus master, medium devsel, latency 0
	I/O ports at ffa0 [size=16]

0000:00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1) (rev 05)
(prog-if 00 [UHCI])
	Subsystem: Dell: Unknown device 0115
	Flags: bus master, medium devsel, latency 0, IRQ 5
	I/O ports at ef40 [size=32]

0000:00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 05)
	Subsystem: Dell: Unknown device 0115
	Flags: medium devsel, IRQ 10
	I/O ports at efa0 [size=16]

0000:00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2) (rev 05)
(prog-if 00 [UHCI])
	Subsystem: Dell: Unknown device 0115
	Flags: bus master, medium devsel, latency 0, IRQ 9
	I/O ports at ef80 [size=32]

0000:01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2
MX/MX 400] (rev b2) (prog-if 00 [VGA])
	Subsystem: nVidia Corporation: Unknown device 010f
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 11
	Memory at fd000000 (32-bit, non-prefetchable) [size=fe7f0000]
	Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at 00010000 [disabled]
	Capabilities: <available only to root>

0000:02:09.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
	Subsystem: Voyetra Technologies: Unknown device 3357
	Flags: bus master, slow devsel, latency 32, IRQ 3
	Memory at feaff000 (32-bit, non-prefetchable)
	Memory at fe900000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: <available only to root>

0000:02:0a.0 Communication controller: Conexant HSF 56k
Data/Fax/Voice/Spkp Modem (rev 01)
	Subsystem: GVC Corporation: Unknown device 0219
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at feae0000 (32-bit, non-prefetchable)
	I/O ports at dff0 [size=8]
	Capabilities: <available only to root>

0000:02:0b.0 Ethernet controller: Davicom Semiconductor, Inc. 21x4x
DEC-Tulip compatible 10/100 Ethernet (rev 31)
	Subsystem: Unknown device 4554:434e
	Flags: bus master, medium devsel, latency 32, IRQ 9
	I/O ports at d800 [size=fea80000]
	Memory at feafec00 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at 00040000 [disabled]
	Capabilities: <available only to root>

----------------------------------------------------------------------
 jdthood - 03-10-05 22:04 
----------------------------------------------------------------------
You unmuted and raised the levels of Master Playback, PCM and DAC?

----------------------------------------------------------------------
 jnilles - 03-16-05 01:33 
----------------------------------------------------------------------
In YaST I set Master Playback, PCM and DAC at 100. Sound test produces
zilch.
As far as I can tell, no Mute check boxes in KAMix are checked except Mic.

----------------------------------------------------------------------
 tiwai - 03-16-05 12:31 
----------------------------------------------------------------------
The first thing to suspect for the silent output is the mixer
configuration.  Please attach /etc/asound.state for checking.

Also, make sure that the cable is connected to the correct jack.

----------------------------------------------------------------------
 jnilles - 03-16-05 22:52 
----------------------------------------------------------------------
I have to assume that the cable is OK since the sound card was working
perfectly under Win XP a few minutes ago as it did before under SuSE 9.0.
No connections or settings have been changed.

I note that SuSE 9.2 has a plethora of mixers: KAMix, KMix, QAMix, gamix
and whatever YaST uses. No two of these seem to yhave the same assortment
of controls. Are their settings interconnected and/or do they all control
the same ALSA file?

Here's the output from /etc/asound.state:

state.CS46xx {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'Master Playback Volume'
		value.0 62
		value.1 62
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Headphone Playback Switch'
		value true
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 23
		value.1 23
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Mono Playback Switch'
		value true
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Master Mono Playback Volume'
		value 23
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PC Speaker Playback Switch'
		value true
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'PC Speaker Playback Volume'
		value 15
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Phone Playback Switch'
		value true
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Phone Playback Volume'
		value 0
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Playback Switch'
		value false
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value 0
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Boost (+20dB)'
		value false
	}
	control.14 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line Playback Switch'
		value true
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 31
		value.1 31
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'CD Playback Switch'
		value true
	}
	control.17 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		value.0 28
		value.1 28
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Video Playback Switch'
		value true
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Video Playback Volume'
		value.0 0
		value.1 0
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Aux Playback Switch'
		value true
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		value.0 31
		value.1 31
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PCM Playback Switch'
		value true
	}
	control.23 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 30
		value.1 30
	}
	control.24 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mic
		comment.item.1 CD
		comment.item.2 Video
		comment.item.3 Aux
		comment.item.4 Line
		comment.item.5 Mix
		comment.item.6 'Mix Mono'
		comment.item.7 Phone
		iface MIXER
		name 'Capture Source'
		value.0 Mic
		value.1 Mic
	}
	control.25 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Capture Switch'
		value true
	}
	control.26 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
	}
	control.27 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name '3D Control - Switch'
		value false
	}
	control.28 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mix
		comment.item.1 Mic
		iface MIXER
		name 'Mono Output Select'
		value Mix
	}
	control.29 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mic1
		comment.item.1 Mic2
		iface MIXER
		name 'Mic Select'
		value Mic1
	}
	control.30 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Center'
		value 6
	}
	control.31 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Depth'
		value 0
	}
	control.32 {
		comment.access read
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value
'0fff000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.33 {
		comment.access read
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value
cf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.34 {
		comment.access 'read write'
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Default'
		value
'0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.35 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
	}
	control.36 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'External Amplifier'
		value false
	}
	control.37 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Playback Switch'
		index 1
		value false
	}
	control.38 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'Master Playback Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.39 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Center Playback Switch'
		index 1
		value true
	}
	control.40 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'Center Playback Volume'
		index 1
		value 63
	}
	control.41 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'LFE Playback Switch'
		index 1
		value true
	}
	control.42 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'LFE Playback Volume'
		index 1
		value 0
	}
	control.43 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Surround Playback Switch'
		index 1
		value.0 true
		value.1 true
	}
	control.44 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'Surround Playback Volume'
		index 1
		value.0 22
		value.1 22
	}
	control.45 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Playback Switch'
		index 1
		value false
	}
	control.46 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		index 1
		value 0
	}
	control.47 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Boost (+20dB)'
		index 1
		value false
	}
	control.48 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line Playback Switch'
		index 1
		value false
	}
	control.49 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.50 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'CD Playback Switch'
		index 1
		value false
	}
	control.51 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.52 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Aux Playback Switch'
		index 1
		value false
	}
	control.53 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.54 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PCM Playback Switch'
		index 1
		value true
	}
	control.55 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		index 1
		value.0 28
		value.1 28
	}
	control.56 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mic
		comment.item.1 CD
		comment.item.2 Video
		comment.item.3 Aux
		comment.item.4 Line
		comment.item.5 Mix
		comment.item.6 'Mix Mono'
		comment.item.7 Phone
		iface MIXER
		name 'Capture Source'
		index 1
		value.0 Mic
		value.1 Mic
	}
	control.57 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Capture Switch'
		index 1
		value true
	}
	control.58 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.59 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 'pre 3D'
		comment.item.1 'post 3D'
		iface MIXER
		name 'PCM Out Path & Mute'
		index 1
		value 'pre 3D'
	}
	control.60 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name '3D Control - Switch'
		index 1
		value false
	}
	control.61 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Center'
		index 1
		value 0
	}
	control.62 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Depth'
		index 1
		value 0
	}
	control.63 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 32767'
		iface MIXER
		name 'DAC Volume'
		value.0 32439
		value.1 32439
	}
	control.64 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 32767'
		iface MIXER
		name 'ADC Volume'
		value.0 32767
		value.1 32767
	}
	control.65 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'ADC Capture Switch'
		value false
	}
	control.66 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'DAC Capture Switch'
		value false
	}
	control.67 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Output Switch'
		value false
	}
	control.68 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Input Switch'
		value false
	}
	control.69 {
		comment.access 'read write'
		comment.type IEC958
		iface PCM
		name 'IEC958 Playback Default'
		value
'0000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.70 {
		comment.access read
		comment.type IEC958
		iface PCM
		name 'IEC958 Playback Mask'
		value
ffff00ff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.71 {
		comment.access 'read write'
		comment.type IEC958
		iface PCM
		name 'IEC958 Playback PCM Stream'
		value
'0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
}

----------------------------------------------------------------------
 jdthood - 03-17-05 10:11 
----------------------------------------------------------------------
This doesn't look good:

    control.37 {
        comment.access 'read write'
        comment.type BOOLEAN
        iface MIXER
        name 'Master Playback Switch'
        index 1
        value false
    }
    control.38 {
        comment.access 'read write'
        comment.type INTEGER
        comment.range '0 - 63'
        iface MIXER
        name 'Master Playback Volume'
        index 1
        value.0 0
        value.1 0
    }


As an experiment you can edit asound.state and run 'alsactl restore'
to load the values into the hardware.  If you don't want to do that
then I suggest you kill all mixer applications (except gamix) and
try to raise the Master Playback levels using gamix.

----------------------------------------------------------------------
 jnilles - 03-17-05 23:07 
----------------------------------------------------------------------
OK, gamix solved it, at least for playing CDs and setting microphone
volumes. The key was to enable the External Amplifier switch, which KAMix
apparently ignored. So much for KAMix.
The gamix controls to the right of the External Amplifier switch don't
seem to affect anything; are they for a nonexistent second sound card or
what?

Thanks for the help; this was a major barrier to my switching a lot of my
activities from Win XP to Linux.

----------------------------------------------------------------------
 jdthood - 03-18-05 14:38 
----------------------------------------------------------------------
It would be helpful if you would send asound.state containing "working"
mixer values for your card.

----------------------------------------------------------------------
 tiwai - 03-18-05 17:59 
----------------------------------------------------------------------
The XXX,1 (i.e. index=1) is the secondary codec, which is used likely for
the surround output.  Thus most of XXX,1 controls are suprefluous.
But we don't know which controls are exactly needed...

----------------------------------------------------------------------
 jnilles - 03-18-05 22:42 
----------------------------------------------------------------------
Here's the working version. The only problem detected so far is that the
microphone input isn't doing too well; that is, skype isn't picking up the
microphone. If I set the mic playback volume up I get a serious feedback
squeal, as one would expect; ergo the mic hardware is working, just not
the skype conection.

state.CS46xx {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'Master Playback Volume'
		value.0 63
		value.1 63
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Headphone Playback Switch'
		value true
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 23
		value.1 23
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Mono Playback Switch'
		value true
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Master Mono Playback Volume'
		value 25
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PC Speaker Playback Switch'
		value false
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'PC Speaker Playback Volume'
		value 0
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Phone Playback Switch'
		value false
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Phone Playback Volume'
		value 0
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Playback Switch'
		value false
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value 0
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Boost (+20dB)'
		value false
	}
	control.14 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line Playback Switch'
		value true
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 31
		value.1 31
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'CD Playback Switch'
		value true
	}
	control.17 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		value.0 31
		value.1 31
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Video Playback Switch'
		value true
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Video Playback Volume'
		value.0 0
		value.1 0
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Aux Playback Switch'
		value true
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		value.0 0
		value.1 0
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PCM Playback Switch'
		value true
	}
	control.23 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 31
		value.1 31
	}
	control.24 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mic
		comment.item.1 CD
		comment.item.2 Video
		comment.item.3 Aux
		comment.item.4 Line
		comment.item.5 Mix
		comment.item.6 'Mix Mono'
		comment.item.7 Phone
		iface MIXER
		name 'Capture Source'
		value.0 Mic
		value.1 Mic
	}
	control.25 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Capture Switch'
		value true
	}
	control.26 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
	}
	control.27 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name '3D Control - Switch'
		value true
	}
	control.28 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mix
		comment.item.1 Mic
		iface MIXER
		name 'Mono Output Select'
		value Mix
	}
	control.29 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mic1
		comment.item.1 Mic2
		iface MIXER
		name 'Mic Select'
		value Mic1
	}
	control.30 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Center'
		value 7
	}
	control.31 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Depth'
		value 14
	}
	control.32 {
		comment.access read
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value
'0fff000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.33 {
		comment.access read
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value
cf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.34 {
		comment.access 'read write'
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Default'
		value
'0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.35 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Playback Switch'
		value false
	}
	control.36 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'External Amplifier'
		value true
	}
	control.37 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Playback Switch'
		index 1
		value true
	}
	control.38 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'Master Playback Volume'
		index 1
		value.0 63
		value.1 63
	}
	control.39 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Center Playback Switch'
		index 1
		value true
	}
	control.40 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'Center Playback Volume'
		index 1
		value 63
	}
	control.41 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'LFE Playback Switch'
		index 1
		value true
	}
	control.42 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'LFE Playback Volume'
		index 1
		value 0
	}
	control.43 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Surround Playback Switch'
		index 1
		value.0 true
		value.1 true
	}
	control.44 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'Surround Playback Volume'
		index 1
		value.0 63
		value.1 63
	}
	control.45 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Playback Switch'
		index 1
		value false
	}
	control.46 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		index 1
		value 0
	}
	control.47 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Boost (+20dB)'
		index 1
		value false
	}
	control.48 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line Playback Switch'
		index 1
		value false
	}
	control.49 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.50 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'CD Playback Switch'
		index 1
		value false
	}
	control.51 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		index 1
		value.0 31
		value.1 31
	}
	control.52 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Aux Playback Switch'
		index 1
		value false
	}
	control.53 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.54 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PCM Playback Switch'
		index 1
		value true
	}
	control.55 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		index 1
		value.0 31
		value.1 31
	}
	control.56 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mic
		comment.item.1 CD
		comment.item.2 Video
		comment.item.3 Aux
		comment.item.4 Line
		comment.item.5 Mix
		comment.item.6 'Mix Mono'
		comment.item.7 Phone
		iface MIXER
		name 'Capture Source'
		index 1
		value.0 Mic
		value.1 Mic
	}
	control.57 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Capture Switch'
		index 1
		value true
	}
	control.58 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'Capture Volume'
		index 1
		value.0 0
		value.1 0
	}
	control.59 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 'pre 3D'
		comment.item.1 'post 3D'
		iface MIXER
		name 'PCM Out Path & Mute'
		index 1
		value 'pre 3D'
	}
	control.60 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name '3D Control - Switch'
		index 1
		value false
	}
	control.61 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Center'
		index 1
		value 0
	}
	control.62 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Depth'
		index 1
		value 0
	}
	control.63 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 32767'
		iface MIXER
		name 'DAC Volume'
		value.0 32439
		value.1 32439
	}
	control.64 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 32767'
		iface MIXER
		name 'ADC Volume'
		value.0 32767
		value.1 32767
	}
	control.65 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'ADC Capture Switch'
		value false
	}
	control.66 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'DAC Capture Switch'
		value false
	}
	control.67 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Output Switch'
		value false
	}
	control.68 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Input Switch'
		value false
	}
	control.69 {
		comment.access 'read write'
		comment.type IEC958
		iface PCM
		name 'IEC958 Playback Default'
		value
'0000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.70 {
		comment.access read
		comment.type IEC958
		iface PCM
		name 'IEC958 Playback Mask'
		value
ffff00ff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.71 {
		comment.access 'read write'
		comment.type IEC958
		iface PCM
		name 'IEC958 Playback PCM Stream'
		value
'0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
}

----------------------------------------------------------------------
 jdthood - 03-19-05 09:44 
----------------------------------------------------------------------
You switched on both the "External Amplifier" and the "Master Playback"
controls.  Which of these two was necessary for the solution of the
problem, or were both necessary?

    control.36 {
        comment.access 'read write'
        comment.type BOOLEAN
        iface MIXER
        name 'External Amplifier'
        value true
    }
    control.37 {
        comment.access 'read write'
        comment.type BOOLEAN
        iface MIXER
        name 'Master Playback Switch'
        index 1
        value true
    }
    control.38 {
        comment.access 'read write'
        comment.type INTEGER
        comment.range '0 - 63'
        iface MIXER
        name 'Master Playback Volume'
        index 1
        value.0 63
        value.1 63
    }

----------------------------------------------------------------------
 jnilles - 03-19-05 18:55 
----------------------------------------------------------------------
Only the 'External Amplifier' switch was necessary to produce the sound
output.
What might be the problem with the microphone? The mic controls on gamix
are quite ambiguous.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-04-05 19:07 jnilles        New Issue                                    
03-04-05 19:07 jnilles        Distribution              => SuSE            
03-09-05 18:53 tiwai          Note Added: 0003840                          
03-10-05 00:21 jnilles        Note Added: 0003846                          
03-10-05 15:01 jdthood        Note Added: 0003856                          
03-10-05 20:29 jnilles        Note Added: 0003872                          
03-10-05 22:04 jdthood        Note Added: 0003874                          
03-16-05 01:33 jnilles        Note Added: 0003926                          
03-16-05 12:31 tiwai          Note Added: 0003941                          
03-16-05 22:52 jnilles        Note Added: 0003972                          
03-17-05 10:11 jdthood        Note Added: 0003980                          
03-17-05 23:07 jnilles        Note Added: 0003986                          
03-18-05 14:38 jdthood        Note Added: 0003993                          
03-18-05 17:59 tiwai          Note Added: 0003997                          
03-18-05 22:42 jnilles        Note Added: 0004006                          
03-19-05 09:44 jdthood        Note Added: 0004025                          
03-19-05 18:55 jnilles        Note Added: 0004066                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
