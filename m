From: noreply@alsa-project.org
Subject: [ALSA - driver 0000300]: Lack of sound
Date: Fri, 16 Jul 2004 12:43:42 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716104342.EA25626008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2E33425A
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:43:43 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000300
======================================================================
Reported By:                gandalf
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     300
Category:                   PCI - fm801
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Slackware
Kernel Version:             2.6.6
======================================================================
Date Submitted:             05-24-2004 09:42 CEST
Last Modified:              07-16-2004 12:43 CEST
======================================================================
Summary:                    Lack of sound
Description: 
I moved from 2.4 series to 2.6 kernel. I compiled alsa as a module in
kernel, and then compiled alsa 1.04 from this site.
I still doesn't hear any sound
======================================================================

----------------------------------------------------------------------
 tiwai - 05-25-2004 12:52 CEST 
----------------------------------------------------------------------
the major device 116 is already reserved by something.
it's not a bug of ALSA.  check kernel configuration.

----------------------------------------------------------------------
 gandalf - 05-25-2004 18:26 CEST 
----------------------------------------------------------------------
I don't see anything which could conflict with FM801.

I also found in slackware newsgroups notes that it is a alsa bug. Could
You tell me how to check "kernel config" to find what does conflict with
alsa?

Here goes lspci

root@www:/etc/rc.d/init.d# lspci -v
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 745 Host (rev 01)
        Subsystem: Asustek Computer, Inc.: Unknown device 8083
        Flags: bus master, medium devsel, latency 32
        Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 2.0

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI
bridge (AGP) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: e7000000-e7ffffff
        Prefetchable memory behind bridge: eff00000-febfffff

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC
Bridge)
        Flags: bus master, medium devsel, latency 0

00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
        Flags: medium devsel, IRQ 11
        I/O ports at e600 [size=32]

00:02.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 07) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8083
        Flags: bus master, medium devsel, latency 32, IRQ 5
        Memory at e6800000 (32-bit, non-prefetchable) [size=4K]

00:02.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 07) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8083
        Flags: bus master, medium devsel, latency 32, IRQ 6
        Memory at e6000000 (32-bit, non-prefetchable) [size=4K]

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev
d0) (prog-if 80 [Master])
        Subsystem: Asustek Computer, Inc.: Unknown device 8083
        Flags: bus master, fast devsel, latency 32
        I/O ports at d800 [size=16]

00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 30)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at b000 [size=128]
        Memory at e5800000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1

00:0b.0 Multimedia audio controller: Fortemedia, Inc Xwave QS3000A [FM801]
(rev b2)
        Subsystem: KYE Systems Corporation: Unknown device 7008
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at a800 [size=128]
        Capabilities: [dc] Power Management version 1

00:0b.1 Input device controller: Fortemedia, Inc Xwave QS3000A [FM801 game
port] (rev b2)
        Subsystem: KYE Systems Corporation: Unknown device 7009
        Flags: bus master, medium devsel, latency 32
        I/O ports at a400 [size=16]
        Capabilities: [dc] Power Management version 1

01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX
440 AGP 8x] (rev a2) (prog-if 00 [VGA])
        Subsystem: Micro-Star International Co., Ltd. MS-StarForce
GeForce4 MX 440 with AGP8X
        Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 11
        Memory at e7000000 (32-bit, non-prefetchable) [size=16M]
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at effe0000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 3.0

----------------------------------------------------------------------
 tiwai - 05-25-2004 18:36 CEST 
----------------------------------------------------------------------
as i wrote, something already occupied the device 116 before ALSA
is loaded.  so, first, check /proc/devices.

----------------------------------------------------------------------
 gandalf - 05-25-2004 19:16 CEST 
----------------------------------------------------------------------
I don't understand it :/ Is that possible that two alsa are loaded at the
same time?

cat /proc/deviced

Character devices:
  1 mem
  2 pty
  3 ttyp
  4 /dev/vc/0
  4 tty
  4 ttyS
  5 /dev/tty
  5 /dev/console
  5 /dev/ptmx
  6 lp
  7 vcs
 10 misc
 13 input
 14 sound
108 ppp
116 alsa
128 ptm
136 pts
171 ieee1394
180 usb
195 nvidia

Block devices:
  3 ide0
 22 ide1

----------------------------------------------------------------------
 tiwai - 05-25-2004 19:25 CEST 
----------------------------------------------------------------------
of course not.  this means that ALSA is running already on your system
before you tried to load another ALSA modules.
perhaps you built the ALSA into kernel?

----------------------------------------------------------------------
 gandalf - 05-25-2004 19:29 CEST 
----------------------------------------------------------------------
yes, please read my description for this bug. I mentioned about it. Is it a
problem? If I compiled alsa into kernel as a module i cannot upgrade it?
I should remove it from kernel before upgrading?

----------------------------------------------------------------------
 tiwai - 05-25-2004 19:49 CEST 
----------------------------------------------------------------------
huh?  you can either build the ALSA as modules, or built it into
the kernel.  but not both.  what do you mean "a module in kernel"??

----------------------------------------------------------------------
 gandalf - 05-25-2004 20:01 CEST 
----------------------------------------------------------------------
it means that I downloaded Kernel 2.6.6, configured it with Alsa as a
module, compiled and installed.
Sorry for my terminology, i'm not an expert.

So i had Alsa as a module, and then, i downloaded Alsa 1.0.4 and installed
it from tar.gz.

----------------------------------------------------------------------
 tiwai - 05-25-2004 20:08 CEST 
----------------------------------------------------------------------
ok, then there should be really two ALSA modules?
hmm, it's also questionable...

anyway, you don't have to build the ALSA modules in the kernel tree
if you build ALSA externally from tarball.

for 2.6.6 kernel, you should try the latest ALSA 1.0.5(-rc1).

to be sure, attach your kernel config (/usr/src/linux/.config 
or something like that) for checking.

----------------------------------------------------------------------
 gandalf - 05-26-2004 00:41 CEST 
----------------------------------------------------------------------
uploading config.
I'm trying to launch kernel without alsa and install 1.0.5-rc1

----------------------------------------------------------------------
 gandalf - 05-26-2004 13:53 CEST 
----------------------------------------------------------------------
ok! i recompiled Kernel without Alsa, installed 1.0.5-rc1 and it works
now!

I don't know if this bug should be marked as INVALID for now or not. I
think alsa should deal with anouther alsa installed as a module.

----------------------------------------------------------------------
 tiwai - 05-26-2004 14:29 CEST 
----------------------------------------------------------------------
it should work even if the ALSA was already installed as modules.
(i do this indeed.)
"make install" will remove the old module files.
so i'm still wondering what was wrong.

anyway, i close this bug for now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-24-04 09:42 gandalf        New Bug                                      
05-24-04 09:42 gandalf        Distribution              => Slackware       
05-24-04 09:42 gandalf        Kernel Version            => 2.6.6           
05-25-04 12:52 tiwai          Bugnote Added: 0001205                       
05-25-04 18:26 gandalf        Bugnote Added: 0001223                       
05-25-04 18:36 tiwai          Bugnote Added: 0001224                       
05-25-04 19:16 gandalf        Bugnote Added: 0001230                       
05-25-04 19:25 tiwai          Bugnote Added: 0001231                       
05-25-04 19:29 gandalf        Bugnote Added: 0001232                       
05-25-04 19:49 tiwai          Bugnote Added: 0001235                       
05-25-04 20:01 gandalf        Bugnote Added: 0001237                       
05-25-04 20:08 tiwai          Bugnote Added: 0001238                       
05-26-04 00:41 gandalf        Bugnote Added: 0001243                       
05-26-04 13:53 gandalf        Bugnote Added: 0001253                       
05-26-04 14:29 tiwai          Bugnote Added: 0001254                       
05-26-04 14:29 tiwai          Assigned To               => tiwai           
05-26-04 14:29 tiwai          Resolution               open => unable to duplicate
05-26-04 14:29 tiwai          Status                   new => resolved     
07-16-04 12:43 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
