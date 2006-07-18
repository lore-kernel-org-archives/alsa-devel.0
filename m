From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000698]: Random beeps, ticks and clicks
Date: Tue, 18 Jul 2006 20:21:12 +0200
Message-ID: <1fba7a4b824d8f8020029d37b5d9df3b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D6FD318D
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 20:21:12 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=698> 
======================================================================
Reported By:                moonlite
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   698
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-02-2004 02:56 CET
Last Modified:              07-18-2006 20:21 CEST
======================================================================
Summary:                    Random beeps, ticks and clicks
Description: 
Below is what i posted to the gentoo-forums without getting without getting
help that solved any of my problems.
 
URL:
http://forums.gentoo.org/viewtopic.php?t=255710&start=0&postdays=0&postorder=asc&highlight=
---
I have a problem with alsa and my SBLive-card and kernels newer than
2.4.19.
All in all it works without error-messages and the sound is pretty nice
etc.
But every now and then the music i listen to is interrupted for a small
period of time (around 0.5s most of the time) and during this time i can't
type or move the mouse and an annoying beep comes from my speakers. I am
pretty sure that it is some sort of interruption because the few times the
interrupts are long i am sure that the music continues from where it were
and also, as i said above, i can't type etc during this small period.
This seems to happen more during heavy load than under normal load but it
still happens a lot at any given time. 
---
This problem happened with these kernels:
vanilla-sources-2.4.20
vanilla-sources-2.4.28
gentoo-sources-2.4.20
gentoo-sources-2.4.26-r12
gentoo-dev-sources-2.6.9-r4

(gentoo-sources are gentoo's own patchsets)

Anyway. Since i posted this i've realized that the beeps (and sometimes
also clicks/ticks) also happen more frequent during high network-load and
not only normal load.
Especially the clicking and ticking noise appear more frequent when
downloading large amount of data with high transfer-rates.
======================================================================

----------------------------------------------------------------------
 pzad - 12-02-04 17:32 
----------------------------------------------------------------------
Could you look, if your soundcard shares irq with something ????

----------------------------------------------------------------------
 moonlite - 12-02-04 23:27 
----------------------------------------------------------------------
root@starbase /home/moonlite # hdparm /dev/hda

/dev/hda:
 multcount    =  0 (off)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 65535/16/63, sectors = 117266688, start = 0

root@starbase /home/moonlite # cat /proc/interrupts 
           CPU0       
  0:   33434343          XT-PIC  timer
  1:       9798          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:    5473400          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 11:     664320          XT-PIC  EMU10K1, eth0
 12:     287484          XT-PIC  i8042
 14:      64894          XT-PIC  ide0
 15:         31          XT-PIC  ide1
NMI:          0 
ERR:          1

Ok. so i see that my network-card and EMU10K1 is sharing IRQ.
Maybe that's the problem?

A friend pasted this out of his /proc/interrupts and said it gave him no
problems though:
< TenOfTen>   9:    7387506          XT-PIC  acpi, ehci_hcd, EMU10K1, eth0

----------------------------------------------------------------------
 moonlite - 12-02-04 23:54 
----------------------------------------------------------------------
Ok.
I tested shutting my network down and it solved all problems.
I don't know if this is a bug then?
It is a rather strange behaviour that the problem rises when using kernels
>2.4.19 but not otherwise.
Oh well.

----------------------------------------------------------------------
 moonlite - 12-03-04 00:23 
----------------------------------------------------------------------
I changed the setting in BIOS, setting IRQ 11 to "reserved". I am not sure
what that meant but now eth0 is on IRQ 10 instead of sharing with emu10k1
which is good i guess.
However that did not help me at all since the random beeps are still there
:(

           CPU0       
  0:     220060          XT-PIC  timer
  1:       1245          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          2          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:       2871          XT-PIC  eth0
 11:       1504          XT-PIC  EMU10K1
 12:      14596          XT-PIC  i8042
 14:       9839          XT-PIC  ide0
 15:         31          XT-PIC  ide1
NMI:          0 
ERR:          0

----------------------------------------------------------------------
 rlrevell - 12-03-04 00:35 
----------------------------------------------------------------------
Can you provide a detailed hardware description including the motherboard
chipset?   Is this an AMD64 or VIA KT266 based system?  There is a very
similar, long standing bug report in the kX forums (Windows driver for
emu10k*).  This was never really solved and the consensus seems to be
buggy hardware.

Maybe you have an extreme PCI latency setting or something.

----------------------------------------------------------------------
 moonlite - 12-03-04 00:49 
----------------------------------------------------------------------
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333]
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333 AGP]
0000:00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1
(rev 0a)
0000:00:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game
Port (rev 0a)
0000:00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M
[Tornado] (rev 74)

It was a while ago that i bought the system so i couldn't recall really,
but a fast google told me that it was kt266.
Anyway. The problem goes away as soon as i do a "rmmod 3c59x".
So really. It has something to do with my networks-card and
kernel-versions >2.4.19

----------------------------------------------------------------------
 moonlite - 12-03-04 00:55 
----------------------------------------------------------------------
Below is output from lspci -v (should give all latency-data)
I have NO idea what an extreme latency setting would be.

root@starbase /home/moonlite # lspci -v  
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333]
        Flags: bus master, medium devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo
KT266/A/333 AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: e6000000-e8ffffff
        Prefetchable memory behind bridge: e4000000-e5ffffff
        Capabilities: [80] Power Management version 2

0000:00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1
(rev 0a)
        Subsystem: Creative Labs SBLive! 5.1 Digital Model SB0220
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at d000
        Capabilities: [dc] Power Management version 1

0000:00:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game
Port (rev 0a)
        Subsystem: Creative Labs Gameport Joystick
        Flags: bus master, medium devsel, latency 32
        I/O ports at d400
        Capabilities: [dc] Power Management version 1

0000:00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M
[Tornado] (rev 74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC
Management NIC
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at d800
        Memory at ea000000 (32-bit, non-prefetchable) [size=128]
        Capabilities: [dc] Power Management version 2

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
        Subsystem: VIA Technologies, Inc.: Unknown device 0000
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

0000:00:11.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if
8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc.
VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at dc00 [size=16]
        Capabilities: [c0] Power Management version 2

0000:00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 1b) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32
        I/O ports at e000 [size=32]
        Capabilities: [80] Power Management version 2

0000:00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 1b) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 255
        I/O ports at e400 [size=32]
        Capabilities: [80] Power Management version 2

0000:00:11.4 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
Controller (rev 1b) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 255
        I/O ports at e800 [size=32]
        Capabilities: [80] Power Management version 2

0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
(rev 04) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G400 MAX/Dual Head
32Mb
        Flags: bus master, medium devsel, latency 64, IRQ 255
        Memory at e4000000 (32-bit, prefetchable)
        Memory at e6000000 (32-bit, non-prefetchable) [size=16K]
        Memory at e7000000 (32-bit, non-prefetchable) [size=8M]
        Capabilities: [dc] Power Management version 2
        Capabilities: [f0] AGP version 2.0

----------------------------------------------------------------------
 moonlite - 12-03-04 01:18 
----------------------------------------------------------------------
I did this:

setpci -v -d *:* latency_timer=b0      #all cards
setpci -v -s 01:00.0 latency_timer=ff  #graphics-card
setpci -v -s 00:0d.0 latency_timer=ff  #network-card

It was explained in an article by daniel robbins on ibm.com.
I have no real clue to if these values are good or bad in any way.
He used it to make sound work when an AGP-card that had agp turned of
(thus putting LOTS of data on the pci-bus) would make his soundcard make
distorted sound.
He wanted to keep his graphics-card and network-card being able to put
lots of data on the bus but still making more room for other stuf or
something.

Anyway. It seems to work pretty ok. 
But, if anyone has some other, maybe more sensible, values for my
pci-latency settings, please post them! :)
But for now i'm just glad it all seems to work.

----------------------------------------------------------------------
 rlrevell - 12-03-04 05:30 
----------------------------------------------------------------------
According to Eugene Gavrilov (author of the kX driver) the original OSS
driver from opensource.creative.com driver and the Windows driver from
creative set the PCI latency to 255.  At some point this code was removed.
 Maybe this needs to be put back.

FWIW, other ALSA drivers (RME for example) have code to raise the PCI
latency.

----------------------------------------------------------------------
 moonlite - 12-03-04 12:28 
----------------------------------------------------------------------
That seems, from my point of view and with my limited knowledge, like a
good idea.

edited on: 12-03-04 12:28

----------------------------------------------------------------------
 jdthood - 09-14-05 16:06 
----------------------------------------------------------------------
> I did this:
>
> setpci -v -d *:* latency_timer=b0 #all cards
> setpci -v -s 01:00.0 latency_timer=ff #graphics-card
> setpci -v -s 00:0d.0 latency_timer=ff #network-card
> 
> Anyway. It seems to work pretty ok. 

Any progress on this issue on the ALSA side?

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:17 
----------------------------------------------------------------------
Any improvement with later ALSA versions?  Is the setpci hack still
required?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-02-04 02:56 moonlite       New Issue                                    
12-02-04 02:56 moonlite       Distribution              => Gentoo          
12-02-04 02:56 moonlite       Kernel Version            => 2.6.9           
12-02-04 17:32 pzad           Note Added: 0002687                          
12-02-04 23:27 moonlite       Note Added: 0002699                          
12-02-04 23:54 moonlite       Note Added: 0002700                          
12-03-04 00:23 moonlite       Note Added: 0002701                          
12-03-04 00:23 moonlite       Note Added: 0002702                          
12-03-04 00:23 moonlite       Note Deleted: 0002701                        
12-03-04 00:35 rlrevell       Note Added: 0002703                          
12-03-04 00:49 moonlite       Note Added: 0002704                          
12-03-04 00:55 moonlite       Note Added: 0002705                          
12-03-04 01:18 moonlite       Note Added: 0002706                          
12-03-04 05:30 rlrevell       Note Added: 0002707                          
12-03-04 12:27 moonlite       Note Added: 0002708                          
12-03-04 12:28 moonlite       Note Edited: 0002708                         
09-14-05 16:06 jdthood        Note Added: 0006172                          
03-22-06 03:17 rlrevell       Note Added: 0008807                          
07-18-06 20:21 pzad           Assigned To              pzad =>             
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
