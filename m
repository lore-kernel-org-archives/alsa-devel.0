From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000963]: Sounc card is mute
Date: Thu, 10 Mar 2005 22:04:30 +0100
Message-ID: <ad32bda96deaf969cd8d16c9583f62fc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6649E1C4
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2005 22:04:30 +0100 (MET)
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
Last Modified:              03-10-2005 22:04 CET
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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
