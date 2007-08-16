From: Sebastian Krause <sebastian@realpath.org>
Subject: Re: no sound with hda-intel,
	conexant venice chip on	hp 2836
Date: Thu, 16 Aug 2007 22:15:42 +0200
Message-ID: <874pizkzgx.fsf@news.realpath.org>
References: <20070815173601.GA3227@bentham.lan>
	<1187227351.5512.280.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A7481038DB
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Aug 2007 22:25:05 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1ILltu-00012c-IC
	for alsa-devel@alsa-project.org; Thu, 16 Aug 2007 22:25:02 +0200
Received: from mue-88-130-70-250.dsl.tropolys.de ([88.130.70.250])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2007 22:25:02 +0200
Received: from sebastian by mue-88-130-70-250.dsl.tropolys.de with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 16 Aug 2007 22:25:02 +0200
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

--=-=-=

Tobin Davis <tdavis@dsl-only.net> wrote:
> For some reason, your system is defaulting the output pin connections to
> the mixer as opposed to the pcm (Node 0x10 & 0x11 should connect to
> 0x19).
>
> Are you dual booting to Windows?  I've had issues getting this driver
> debugged, and this is usually one of the causes.  I'll try to revisit it
> again soon. 

I have a very similar problem as Pieter-Augustijn, at least
regarding the symptoms: Everything seems to be quite fine, I don't
get any error messages and neither see weird things in dmesg. But
using Linux my laptop has never produced any sound until now (trying
different distributions). Neither after a cold start.

I'm using an Acer Aspire 5710Z and also I'm dual-booting with
Windows XP. Since I couldn't find any clues about my problem yet I
didn't know where to start tuning my settings (currently they're
just still Ubuntu default).

I've attached the audio output of "lspci -vv" and the alsa-info.sh
script.

Thanks,
Sebastian


--=-=-=
Content-Disposition: inline; filename=lspci.txt

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 02)
	Subsystem: Acer Incorporated [ALI] Unknown device 012e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin A routed to IRQ 22
	Region 0: Memory at d0440000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express Unknown type IRQ 0
		Device: Supported: MaxPayload 128 bytes, PhantFunc 0, ExtTag-
		Device: Latency L0s <64ns, L1 <1us
		Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
		Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
		Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
		Link: Supported Speed unknown, Width x0, ASPM unknown, Port 0
		Link: Latency L0s <64ns, L1 <1us
		Link: ASPM Disabled CommClk- ExtSynch-
		Link: Speed unknown, Width x0

--=-=-=
Content-Disposition: inline; filename=alsa-info.txt

!!################################
!!ALSA Information Script v 0.4.30
!!################################

!!Script ran on: Thu Aug 16 21:54:44 CEST 2007


!!Linux Distribution
!!------------------

Ubuntu gutsy (development branch) \n \l DISTRIB_ID=Ubuntu DISTRIB_DESCRIPTION="Ubuntu gutsy (development branch)"


!!Kernel Information
!!------------------

Kernel release:    2.6.22-9-generic
Operating System:  GNU/Linux
Architecture:      i686
Processor:         unknown
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     1.0.14
Library version:    
Utilities version:  1.0.14


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xd0440000 irq 22


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 02)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

00:1b.0 0403: 8086:27d8 (rev 02)
	Subsystem: 1025:012e


!!HDA-Intel Codec information
!!---------------------------

Codec: Realtek ID 268
Address: 0
Vendor Id: 0x10ec0268
Subsystem Id: 0x1025012e
Revision Id: 0x100003
Default PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x02 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x40 0x40]
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x30 0x30]
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x04 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x05 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
Node 0x07 [Audio Input] wcaps 0x100111: Stereo
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x24
Node 0x08 [Audio Input] wcaps 0x100111: Stereo
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x23
Node 0x09 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0b [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0d [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0e [Audio Mixer] wcaps 0x20010a: Mono Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00]
  Connection: 1
     0x02
Node 0x0f [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80]
  Connection: 2
     0x02 0x1d
Node 0x10 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x80 0x80] [0x80 0x80]
  Connection: 3
     0x03 0x1d 0x02
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x00:
Node 0x13 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x00:
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x081003c: IN OUT HP EAPD Detect
  Pin Default 0x02211020: [Jack] HP Out at Ext Front
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0f
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x081003c: IN OUT HP EAPD Detect
  Pin Default 0x99130110: [Fixed] Speaker at Int ATAPI
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x10
Node 0x16 [Pin Complex] wcaps 0x40010c: Mono Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80]
  Pincap 0x0810: OUT
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x00:
  Connection: 1
     0x0e
Node 0x17 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x02, stepsize=0x4f, mute=0
  Amp-In vals:  [0x02 0x02]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x083734: IN OUT Detect
  Pin Default 0x02a19840: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x24: IN
  Connection: 1
     0x02
Node 0x19 [Pin Complex] wcaps 0x40008b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x02, stepsize=0x4f, mute=0
  Amp-In vals: 
  Pincap 0x083724: IN Detect
  Pin Default 0x99a30941: [Fixed] Mic at Int ATAPI
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x20: IN
Node 0x1a [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x02, stepsize=0x4f, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x083734: IN OUT Detect
  Pin Default 0x0281304e: [Jack] Line In at Ext Front
    Conn = 1/8, Color = Blue
  Pin-ctls: 0x20: IN
  Connection: 1
     0x02
Node 0x1b [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x4017952d: [N/A] Speaker at Ext N/A
    Conn = Analog, Color = Pink
  Pin-ctls: 0x20: IN
Node 0x1e [Pin Complex] wcaps 0x400380: Mono Digital
  Pincap 0x0810: OUT
  Pin Default 0x02451130: [Jack] SPDIF Out at Ext Front
    Conn = Optical, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x06
Node 0x1f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x23 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x01 0x01]
  Connection: 7
     0x18 0x19 0x1a 0x1c 0x14 0x15* 0x12
Node 0x24 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x14 0x14]
  Connection: 7
     0x18* 0x19 0x1a 0x1c 0x14 0x15 0x13
Codec: Conexant ID 2c06
Address: 1
Vendor Id: 0x14f12c06
Subsystem Id: 0x1025012e
Revision Id: 0x100000


!!ALSA Device nodes
!!-----------------

crw-rw---- 1 root audio 116, 6 2007-08-16 21:22 /dev/snd/controlC0
crw-rw---- 1 root audio 116, 5 2007-08-16 21:22 /dev/snd/pcmC0D0c
crw-rw---- 1 root audio 116, 4 2007-08-16 21:22 /dev/snd/pcmC0D0p
crw-rw---- 1 root audio 116, 3 2007-08-16 21:22 /dev/snd/seq
crw-rw---- 1 root audio 116, 2 2007-08-16 21:22 /dev/snd/timer


!!Aplay output
!!------------

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: HDA Generic [HDA Generic]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Simple mixer control 'Master',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 64
  Mono:
  Front Left: Playback 48 [75%] [-16.00dB]
  Front Right: Playback 48 [75%] [-16.00dB]
Simple mixer control 'PCM',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 218 [85%] [-7.40dB]
  Front Right: Playback 218 [85%] [-7.40dB]
Simple mixer control 'Digital',0
  Capabilities: cvolume
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 120
  Front Left: Capture 60 [50%] [0.00dB]
  Front Right: Capture 60 [50%] [0.00dB]


!!All Loaded Modules
!!------------------

Module
michael_mic
arc4
ecb
blkcipher
ieee80211_crypt_tkip
aes
ieee80211_crypt_ccmp
i915
drm
rfcomm
l2cap
bluetooth
capability
ipv6
ppdev
acpi_cpufreq
cpufreq_ondemand
cpufreq_userspace
cpufreq_stats
freq_table
cpufreq_powersave
cpufreq_conservative
container
button
sbs
ac
video
battery
dock
fuse
parport_pc
lp
parport
snd_hda_intel
snd_pcm_oss
snd_mixer_oss
snd_pcm
snd_seq_dummy
snd_seq_oss
snd_seq_midi
snd_rawmidi
serio_raw
bcm43xx
ieee80211softmac
ieee80211
ieee80211_crypt
snd_seq_midi_event
af_packet
snd_seq
snd_timer
snd_seq_device
sdhci
mmc_core
iTCO_wdt
iTCO_vendor_support
psmouse
snd
soundcore
shpchp
pci_hotplug
snd_page_alloc
intel_agp
agpgart
evdev
ext3
jbd
mbcache
sg
sr_mod
cdrom
sd_mod
usbhid
hid
ata_generic
tg3
ata_piix
ahci
libata
scsi_mod
ehci_hcd
uhci_hcd
usbcore
thermal
processor
fan
apparmor
commoncap
aamatch_pcre



--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-=-=--
