From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000733]: No sound with Hercules Game Theater XP
Date: Sun, 19 Dec 2004 20:05:42 +0100
Message-ID: <0567fd7b26c1a15e991778947c6ccda6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C4AF82B6
	for <alsa-devel@alsa-project.org>; Sun, 19 Dec 2004 20:05:42 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=733> 
======================================================================
Reported By:                sherington
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   733
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.8.1-12mdk
======================================================================
Date Submitted:             12-19-2004 20:05 CET
Last Modified:              12-19-2004 20:05 CET
======================================================================
Summary:                    No sound with Hercules Game Theater XP
Description: 
Hi,

The Hercules Game Theater XP is recognised as a Cirrus Logic CS
4614/22/24. I have had this working very nicely (after some trouble) on
Mandrake 10.0 but I am having major prolems trying to get it working on
Mandrake 10.1. I have had problems with this sound card before on various
earlier versions of Linux.

I am guessing it's a driver problem (and posting here) since I only have
problems when I disable my motherboard's onboard audio (an Intel chip) and
use my PCI Game Theater sound card instead.

A base installation of Linux gives me no sound whatsoever. I have tried to
make sure that it's not just a muting problem because I've checked with
aumix, kmix and alsamixer and everything looks OK to me.

I have also tried with KDE's sound system enabled/disabled and still I
have problems.

After some extensive searching and tweaking, I could get xmms to play mp3
files for a while (although not now) but I then had different problems -
'tinny' output, playback stalling or noise when minimising windows etc,
and application stability problems and video playback grinding to a halt
when using e.g. mplayer to play something. (If I used "mplayer -nosound"
then the video played back flawlessly).

So, I guess it's a sound driver bug and I hope someone here can help me.

Mandrake 10.1 ships with Alsa 1.0.6, I have already built and installed
1.0.7 and it makes no difference.

I have also tried to build the latest ALSA from CVS but I get some
compilation errors that prevent me from being able to do so.

Hardware:
MSI K8N Neo2 Platinum Motherboard
Athlon64 3500+
Hercules Game Theater XP Sound Card

Software:
Mandrake Linux 10.1 Official Edition (32 bit version)
KDE 3.2.3
ALSA 1.0.6 / ALSA 1.0.7

Some diagnostic information that might be useful:

$uname -a
Linux localhost 2.6.8.1-12mdk
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 Fri Oct 1 12:53:41 CEST
2004 i686 AMD
Athlon(tm) 64 Processor 3500+ unknown GNU/Linux

$lspcidrake | fgrep AUDIO
snd-cs46xx      : Cirrus Logic|CS 4614/22/24 [CrystalClear SoundFusion
Audio Accelerator] [MULTIMEDIA_AUDIO] (vendor:1013 device:6003 subv:1681
subd:0050)

$modprobe -l | grep snd-cs46xx

/lib/modules/2.6.8.1-12mdk/kernel/sound/pci/cs46xx/snd-cs46xx.ko.gz
/lib/modules/2.6.8.1-12mdk/kernel/sound/pci/cs46xx/snd-cs46xx.ko

$lsmod | grep snd
snd-seq-oss            33248  0
snd-seq-midi-event      6080  1 snd-seq-oss
snd-seq                47856  4 snd-seq-oss,snd-seq-midi-event
snd-pcm-oss            49832  0
snd-mixer-oss          17536  1 snd-pcm-oss
snd-cs46xx             81896  0
snd-rawmidi            19496  1 snd-cs46xx
snd-seq-device          7020  3 snd-seq-oss,snd-seq,snd-rawmidi
snd-ac97-codec         69392  1 snd-cs46xx
snd-pcm                82632  2 snd-pcm-oss,snd-cs46xx
snd-timer              20452  2 snd-seq,snd-pcm
snd-page-alloc          7464  2 snd-cs46xx,snd-pcm
gameport                3328  1 snd-cs46xx
snd                    46916  10
snd-seq-oss,snd-seq,snd-pcm-oss,snd-mixer-oss,snd-cs46xx,snd-rawmidi,snd-seq-device,snd-ac97-codec,snd-pcm,snd-timer
soundcore               7008  2 snd,audio

$aumix -q
vol 90, 90, P
pcm 77, 77
line 77, 77, P
mic 0, 0, R
cd 77, 77, P
pcm2 77, 77
igain 80, 80
line1 77, 77, P
line2 77, 77
phin 100, 100, P
phout 100, 100, P
video 100, 100, P

$ls -l /dev/sound
total 0
lrwxrwxrwx  1 root root  7 Dec 19 11:31 adsp -> ../adsp
lrwxrwxrwx  1 root root  8 Dec 19 11:31 audio -> ../audio
lrwxrwxrwx  1 root root  9 Dec 19 11:31 dmmidi -> ../dmmidi
lrwxrwxrwx  1 root root  6 Dec 19 11:31 dsp -> ../dsp
lrwxrwxrwx  1 root root  7 Dec 19 11:31 midi -> ../midi
lrwxrwxrwx  1 root root  8 Dec 19 11:31 mixer -> ../mixer
lrwxrwxrwx  1 root root 12 Dec 19 11:31 sequencer -> ../sequencer
lrwxrwxrwx  1 root root 13 Dec 19 11:31 sequencer2 -> ../sequencer2

$ls -l /dev/*dsp* /dev/*audio* /dev/*mixer* /dev/*sequencer* /dev/*midi*
crw-rw----  1 mark audio 14, 12 Dec 19 11:31 /dev/adsp
crw-rw----  1 mark audio 14,  4 Dec 19 11:31 /dev/audio
crw-rw----  1 mark audio 14,  9 Dec 19 11:31 /dev/dmmidi
crw-rw----  1 mark audio 14,  3 Dec 19 11:31 /dev/dsp
crw-rw----  1 mark audio 14,  2 Dec 19 11:31 /dev/midi
crw-rw----  1 mark audio 14,  0 Dec 19 11:31 /dev/mixer
crw-rw----  1 mark audio 14,  1 Dec 19 11:31 /dev/sequencer
crw-rw----  1 mark audio 14,  8 Dec 19 11:31 /dev/sequencer2

$lspcidrake
amd64-agp       : nVidia Corp.| [BRIDGE_HOST]
unknown         : unknown (10de/00e0/1462/0250) [BRIDGE_ISA]
unknown         : unknown (10de/00e4/1462/0250) [SERIAL_SMBUS]
usb-ohci        : unknown (10de/00e7/1462/0250) [SERIAL_USB]
usb-ohci        : unknown (10de/00e7/1462/0250) [SERIAL_USB]
ehci-hcd        : unknown (10de/00e8/1462/0250) [SERIAL_USB]
forcedeth       : nVidia Corp.|Ethernet adapter [BRIDGE_OTHER]
unknown         : unknown (10de/00e5/1462/0250) [STORAGE_IDE]
sata_nv         : nVidia Corp.| [STORAGE_IDE]
unknown         : unknown (10de/00e2/ffff/ffff) [BRIDGE_PCI]
unknown         : unknown (10de/00ed/ffff/ffff) [BRIDGE_PCI]
unknown         : Advanced Micro Devices|K8 [Athlon64/Opteron]
HyperTransport Technology Configuration [BRIDGE_HOST]
unknown         : Advanced Micro Devices|K8 [Athlon64/Opteron] Address Map
[BRIDGE_HOST]
unknown         : Advanced Micro Devices|K8 [Athlon64/Opteron] DRAM
Controller [BRIDGE_HOST]
unknown         : Advanced Micro Devices|K8 [Athlon64/Opteron]
Miscellaneous Control [BRIDGE_HOST]
Card:ATI Radeon (fglrx): ATI|Radeon 9800PRO NH (AGP) [DISPLAY_VGA]
unknown         : ATI|Radeon R300 [Radeon 9800] (Secondary)
[DISPLAY_OTHER]
rt2500          : RaLink|Ralink RT2500 802.11 Cardbus Reference Card
[NETWORK_OTHER]
snd-cs46xx      : Cirrus Logic|CS 4614/22/24 [CrystalClear SoundFusion
Audio Accelerator] [MULTIMEDIA_AUDIO]
ohci1394        : VIA Technologies|OHCI Compliant IEEE 1394 Host
Controller [SERIAL_FIREWIRE]
r8169           : Realtek|RTL-8169 [NETWORK_ETHERNET]
hub             : Linux 2.6.8.1-12mdk ehci_hcd|EHCI Host Controller [Hub]
hub             : Linux 2.6.8.1-12mdk ohci_hcd|OHCI Host Controller [Hub]
hub             : Linux 2.6.8.1-12mdk ohci_hcd|OHCI Host Controller [Hub]

I am very happy to try any suggestions or tests if you have any ideas.

Thanks.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-19-04 20:05 sherington     New Issue                                    
12-19-04 20:05 sherington     Kernel Version            => 2.6.8.1-12mdk   
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
